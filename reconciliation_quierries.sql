SELECT * INTO mob_Date FROM mobiquity
ALTER TABLE mob_Date DROP COLUMN Date_
SELECT * FROM mob_Date
DROP TABLE mob_Date


--Transaction that are in mobiquity and t24
select * from mobiquity m, t24 t where m.Reference  = t.Reference
and CD_DR = 'DR' AND t.CreditAmount > 0

select * from mobiquity m, t24 t where 
CD_DR = 'DR' AND t.CreditAmount  is like '% '

select


select count(*) from mobiquity m, t24 t where m.Reference  = t.Reference 
---306

select * from mobiquity
select * from T24
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


--- 

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


--- t24 debit

--- t24 credit

---mobiquity debit 

---mobiquity debit transactional correction

---mobiquity credit reversed through transactional charges

---mobiquity debit merchant payment transactional charge

select *from mobiquity
select  Tran_ID, Phone, Date_ , MR_CP, CD_DR , merchant_Payment,  TS_ , Amount, Opening_Balance, Closing_Balance, Reference, TC_MP from  mobiquity
--- extracting date in the required format
select left(Date_, 10) from mobiquity;



 /* CREATE TABLE [dbo].[mobiquity](
	[Tran_ID] [varchar](50) NULL,
	[Phone] [varchar](50) NULL,
	[Date_] [varchar](50) NULL,
	[MR_CP] [varchar](50) NULL,
	[CD_DR] [varchar](50) NULL,
	[merchant_Payment] [varchar](50) NULL,
	[TS_] [varchar](50) NULL,
	[Amount] [varchar](50) NULL,
	[Opening_Balance] [varchar](50) NULL,
	[Closing_Balance] [varchar](50) NULL,
	[Reference] [varchar](50) NULL,
	[TC_MP] [varchar](50) NULL,
	[Phone1] [varchar](50) NULL,
	[ref]  AS ([Reference]+[Amount]

	*/

	  /* New Architrecture */

	  /* Final Production Ecosale */

	CREATE TABLE [dbo].[t24](
	[Booking Date] [varchar](8) NULL,
	[Transaction Reference] [varchar](12) NULL,
	[Value Date] [varchar](8) NULL,
	[Description] [varchar](19) NULL,
	[Transaction RRN] [varchar](20) NULL,
	[Transacting Terminal ID] [varchar](8) NULL,
	[Terminal Location] [varchar](50) NULL,
	[Debit Amount] [varchar](30) NULL,
	[Credit Amount] [varchar](30) NULL,
	[Running Balance] [varchar](30) NULL,
	[Opening Balance] [varchar](30) NULL,
	[Closing Balance] [varchar](30) NULL
	)
DROP TABLE t24

/* 2021/08/01 2021 August 1 */

DROP TABLE t24


 /* CREATE TABLE  t24(
	   [Post_Date] varchar(50) 
      ,[FTRef] varchar (50)
      ,[Narrative] varchar(50)
      ,[Value_Date] varchar(50)
      ,[Reference] varchar(50)
      ,[Debit] varchar(50)
      ,[Credit] varchar(50)
      ,[BankVal] varchar(50)
	  , [ref] as ([Reference]+ [Debit])
	  );
*/


drop table t24

CREATE TABLE [dbo].[t24_TEST](
	[Booking Date] [varchar](8) NULL,
	[Transaction Reference] [varchar](12) NULL,
	[Value Date] [varchar](8) NULL,
	[Description] [varchar](19) NULL,
	[Transaction RRN] [varchar](20) NULL,
	[Transacting Terminal ID] [varchar](8) NULL,
	[Terminal Location] [varchar](50) NULL,
	[Debit Amount] [varchar](30) NULL,
	[Credit Amount] [varchar](30) NULL,
	[Running Balance] [varchar](30) NULL,
    [ref] as ([Reference] + [Debit])
) ;

 /* CREATE TABLE [dbo].[mobiquity](
	[Tran_ID] [varchar](50) NULL,
	[Phone] [varchar](50) NULL,
	[Date_] [varchar](50) NULL,
	[MR_CP] [varchar](50) NULL,
	[CD_DR] [varchar](50) NULL,
	[merchant_Payment] [varchar](50) NULL,
	[TS_] [varchar](50) NULL,
	[Amount] [varchar](50) NULL,
	[Opening_Balance] [varchar](50) NULL,
	[Closing_Balance] [varchar](50) NULL,
	[Reference] [varchar](50) NULL,
	[TC_MP] [varchar](50) NULL,
	[Phone1] [varchar](50) NULL,
	[ref]  AS ([Reference]+[Amount]

	*/
  ALTER TABLE T24 
  ADD REF AS (DebitAmount + CreditAmount)
  ;


  /* eXCPTIONS */
/ *select Reference1 from mobiquity

  select * from T24




  T24DR VS T24CR matched 

  Select * 
From ( Select * ,count(*) over (Partition By reference3) as t24matched from T24) t
Where t24matched >1 ;


Select * 
From ( Select * ,count(*) over (Partition By reference3) as t24unmatched from T24) t
Where t24unmatched = 1 ;



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

select * from T24 order by (CAST(CreditAmount AS float)) DESC;

select * from T24 order by (CAST(CreditAmount AS float)) DESC where  CAST(CreditAmount AS float <> 0  ;

/* t24 debit 
select t24 , mobiquity inner join on t24.reference = mobiquity reference3 */

SELECT 
	first_name,
	last_name,
	email 
FROM voters
WHERE CHARINDEX('dan', first_name) > 0;


SELECT 
	first_name,
	last_name,
	email 
FROM voters
WHERE CHARINDEX('dan', first_name) > 0 
	AND CHARINDEX('z', last_name) > 0;


SELECT 
	first_name,
	last_name,
	email 
FROM voters
WHERE CHARINDEX('dan', first_name) > 0 
	AND CHARINDEX('z', last_name) = 0;

SELECT 
	first_name,
	last_name,
	email 
FROM voters
WHERE PATINDEX('%rr%', first_name) > 0;


SELECT TerritoryName, OrderDate, 
       ROW_NUMBER() 
       OVER(PARTITION BY TerritoryName ORDER BY OrderDate) AS OrderCount
FROM Orders;

SELECT OrderID, TerritoryName, 
       COUNT(OrderID) 
       OVER (PARTITION BY TerritoryName) AS TotalOrders
FROM Orders;