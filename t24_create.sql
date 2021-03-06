/****** Script for SelectTopNRows command from SSMS  ******/
CREATE TABLE T24 (
BookingDate varchar(10),TransactionReference varchar(15),ValueDate varchar(10),[Description] varchar(20),TransactionRRN varchar(12),TransactingTerminalID varchar(15),TerminalLocation varchar(100),DebitAmount varchar(10),CreditAmount varchar(10)	
);


drop table T24

CREATE TABLE T24_CR (
BookingDate DATE FORMAT 'yyyymmdd',	TransactionReference varchar(15),	ValueDate DATE FORMAT 'yyyymmdd',	Description varchar(20),	TransactionRRN varchar(12),
	TransactingTerminalID varchar(15),	TerminalLocation varchar(100), CreditAmount varchar(10)	
);


CREATE TABLE T24_DR (
BookingDate DATE FORMAT 'yyyymmdd',	TransactionReference varchar(15),	ValueDate DATE FORMAT 'yyyymmdd',	Description varchar(20),	TransactionRRN varchar(12),
	TransactingTerminalID varchar(15),	TerminalLocation varchar(100),	DebitAmount varchar(10)	
);



  ALTER TABLE T24 
  ADD REF AS (DebitAmount + CreditAmount)
  ;


  
CREATE TABLE [dbo].[mobiquity](
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
	[Reference1] as substring(Reference, 1,15) + Amount
) 
