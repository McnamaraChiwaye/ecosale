--Transaction that are in mobiquity and t24
select * from mobiquity m, t24 t where m.Reference  = t.Reference
and CD_DR = 'DR' AND t.CreditAmount > 0

select * from mobiquity m, t24 t where 
CD_DR = 'DR' AND t.CreditAmount  is like '% '

select count(*) from mobiquity m, t24 t where m.Reference  = t.Reference 
---306

--How many records are they ?
select count(*) from mobiquity
--- 4240
select count(*) from t24
--732

--- Picking mobiquiity credits
select * from mobiquity m, t24 t where m.Reference  = t.Reference and m.CD_DR = 'CR'
select count(*)  from mobiquity m, t24 t where m.Reference  = t.Reference and m.CD_DR = 'CR'
---153

---Picking mobiquity debits

select * from mobiquity m, t24 t where m.Reference  = t.Reference and m.CD_DR = 'DR'
select count(*)  from mobiquity m, t24 t where m.Reference  = t.Reference and m.CD_DR = 'DR'
--153

select t.Reference from t24 t
left outer join mobiquity m
ON t.Reference = m.reference
where m.reference is null

 union all
 select m.reference from mobiquity m
left outer join t24 t
ON t.reference = m.Reference
where t.Reference is null ;
---4717 rows


---
select t.Reference from t24 t
left outer join mobiquity m
ON t.Reference = m.reference
where m.reference is null
--579 rows
--Records in t24 and not in mobiquity

 select m.reference from mobiquity m
left outer join t24 t
ON t.reference = m.Reference
where t.Reference is null ;
---4138 rows


----Records that are in mobiquity and not in t24
select * from mobiquity ----4240
select * from t24  ---- 720


--- Advanced mobiquity queeries
--- Extracting debits transctions from  credits
select * from mobiquity where CD_DR ='DR';
--- Extracting debits transctions from  credits
select * from mobiquity where CD_DR ='cR';


select Tran_ID from mobiquity ORDER BY Tran_ID DESC;
---filtering Transactional corrections
select Tran_ID from mobiquity where Tran_ID like 'TC%' 


select *from mobiquity
select  Tran_ID, Phone, Date_ , MR_CP, CD_DR , merchant_Payment,  TS_ , Amount, Opening_Balance, Closing_Balance, Reference, TC_MP from  mobiquity
--- extracting date in the required format
select left(Date_, 10) from mobiquity;



 #---------------- T24DR VS T24CR matched -------------------------# 

  Select * 
From ( Select * ,count(*) over (Partition By reference3) as t24matched from T24) t
Where t24matched >1 ;

 # --------------- T24DR VS T24CR matched  ------------------------------# 
Select * 
From ( Select * ,count(*) over (Partition By reference3) as t24unmatched from T24) t
Where t24unmatched < 1 ;

---------------------T24DR vs Mob_cr---------------Exceptions 
 
select *from t24_dr  tdr 
left  outer join mob_cr mcr on tdr.reference = mcr.reference1;


---------------------Mobcr  vs T24DR    .--------------EXCEPTIONS

select *from mob_cr mcr  
left  outer join t24_dr  tdr on tdr.reference = mcr.reference1  ;


-------------- MobDr VS T24CR --------------------Exceptions 

select *from mob_dr mdr  
left  outer join t24_cr  tcr on tcr.reference = mdr.reference1  ;


----------- T24 DR vs MObCr with TC'S and CD_DR = 'CR'-------------

select * from mob_cr mcr where   mcr.TC_MP like 'TC%'
and CD_DR = 'CR'
;

select * from t24_dr tdr where  tdr.DebitAmount is not null

;

select * from mob_dr mdr where   mdr.tran_id like 'TC%'
and CD_DR = 'DR'

select * from mob_dr mdr ,  mob_cr mcr 
where  mdr.tran_id  =  mcr.TC_MP ;

-----------------         MobiquityDR VS MobiquityCR unmatched 
select * from mobiquity  where reference2 like 'TC%';

  Select * 
From ( Select * ,count(*) over (Partition By reference2) as mobiquitymatched from mobiquity) m
Where mobiquitymatched >1 
and reference2 like 'TC%';

 # --------------- MobiquityDR VS MobiquityCR unmatched  ------------------------------# 
Select * 
From ( Select * ,count(*) over (Partition By reference2) as mobiquityunmatched from mobiquity) t
Where mobiquityunmatched < 1 
and reference2 like 'TC%';







#----- left out join with exclusion----------- or anti semi join  or right outer join with exclusion-------# 
select * from mob_dr mdr ,
right  outer join  mob_cr mcr  on mdr.tran_id  =  mcr.TC_MP 
where mcr.TC_MP like 'TC%' ;


select * from mob_dr mdr ,  mob_cr mcr 
where  mdr.tran_id  =  mcr.TC_MP ;


wheremcr.TC_MP like 'TC%' ;


-------------------------------------

select * from mob_cr mcr 
left outer join  mob_dr mdr  on mcr.TC_MP  = mdr.tran_id 
where mcr.TC_MP like 'TC%' 
and mdr.tran_id is null;
;


left  outer join t24_cr  tcr on tcr.reference = mdr.reference1  ;


select * from t24_dr

/****** Script for SelectTopNRows command from SSMS  ******/


-------------------------------------------------------part 1---------------------
Select * 
From ( Select * ,count(*) over (Partition By reference3) as t24matched from T24) t
Where t24matched >1 ;


Select * 
From ( Select * ,count(*) over (Partition By reference3) as t24matched from T24) t
Where t24matched = 1 ;

-------------------------------------------------------------------------

-------------------------------------------------part2------------------

SELECT *
FROM   T24 t
WHERE  EXISTS (SELECT 1
               FROM   mobiquity m
               WHERE  t.Reference = m.Reference1
               HAVING Count(Reference) > 1) 
Order by Reference ;

-------------------------------------------------part2------------------

select * from T24 WHERE(CAST(CreditAmount AS float)) <> 0;

select * from T24 WHERE(CAST(DebitAmount AS float)) <> 0;

------------------
--------------T24DR VS MOBCR  Exceptions

select * from T24 t 
 left outer join mobiquity  m on t.reference = m.reference1  
 WHERE 
(CAST(t.DebitAmount AS float)) <> 0 
;
-----------------------------

select * from mobiquity m
 left outer join T24  t on t.reference = m.reference1  
 WHERE 
(CAST(t.Amount AS float)) <> 0 


# ------ creating new tables in db ---------#

select * into t24_dr from T24 WHERE(CAST(DebitAmount AS float)) <> 0;
select * into t24_cr from T24 WHERE(CAST(CreditAmount AS float)) <> 0;
select * into mob_cr from mobiquity where CD_DR ='CR';
select * into mob_dr from mobiquity where CD_DR ='DR';
select * into mob_cr_rvsd_ttc from mob_cr mcr where   mcr.TC_MP like 'TC%'
and CD_DR = 'CR'
;
select * into mob_dr_trans_corr from mob_dr md where   md.Tran_id like 'TC%'
and md.CD_DR = 'DR' ;


DELETE T24
DELETE MOBIQUITY
DROP TABLE t24_dr
DROP TABLE t24_cr
drop table mob_cr
drop table mob_dr
drop table mob_dr_trans_corr 
drop table mob_cr_rvsd_ttc


select * from mobiquity where CD_DR ='DR';
--- Extracting debits transctions from  credits
select * from mobiquity where CD_DR ='cR';


ALTER TABLE mob_Date DROP COLUMN last_name
SELECT * FROM mob_Date
DROP TABLE mob_Date
;

drop table t24_cr

select t.Reference ,m.reference1 from T24 t ,mobiquity m 
where t.Reference = m.Reference1 

select * from T24 t where Reference = '18091200880598.93';

select * from mobiquity  where Reference1 = '18091200880598.93';
where t.Reference = m.Reference1 


and m.CD_DR = 'CR';


18091200880598.93       98.93   180912008805

select * from mobiquity ;


select * from T24 order by (CAST(CreditAmount AS float)) DESC;

select * from T24 order by (CAST(CreditAmount AS float)) DESC where  CAST(CreditAmount AS float <> 0  ;

/* t24 debit 
select t24 , mobiquity inner join on t24.reference = mobiquity reference3 */
