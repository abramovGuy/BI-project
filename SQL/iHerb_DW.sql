 --drop table [iHerb_DW].[dbo].[Products_DIM]
 --TRUNCATE TABLE [iHerb_DW].[dbo].[Products_DIM]

 CREATE TABLE [iHerb_DW].[dbo].[Products_DIM](
 --ADD IDINTITY
	[ProductID] [int] PRIMARY KEY NOT NULL,
	[ProductName] [varchar](100) NOT NULL,
	[brandName] [varchar](50) NOT NULL,
	[ProductCategory] [varchar](50) NOT NULL,
	[Rating] [int] NOT NULL,
	[Review] [varchar](50) NOT NULL,
	[ProductPrice_USD] [money] NOT NULL,
 )

--drop table [iHerb_DW].[dbo].[Customer_DIM]
 --TRUNCATE TABLE [iHerb_DW].[dbo].[Customer_DIM]
CREATE	TABLE [iHerb_DW].[dbo].[Customer_DIM] (
	DwCustomer int identity(1,1) not null  ,
	customerID		Int  NOT NULL,
	firstName	Varchar (30) NOT NULL,
	lastName	Varchar (30) NOT NULL,
	birthdate		Date NOT NULL,
	email varchar(40) NOT NULL,
	age		Int NOT NULL,
	ageGroup		Varchar(10) NOT NULL,
	gender		Varchar(30) NOT NULL,
	country		Varchar (30) NOT NULL,	
	city		Varchar (30) NOT NULL,
	validFrom date ,
	validUntil date 
 )

 --drop table [iHerb_DW].[dbo].[Warehouse_DIM]
 --TRUNCATE TABLE [iHerb_DW].[dbo].[Warehouse_DIM]
CREATE	TABLE [iHerb_DW].[dbo].[Warehouse_DIM] (
	DWWarehouse int  NOT NULL,
	warehouseID int PRIMARY KEY NOT NULL,
	year_Month date NOT NULL, 
	Country varchar(30) NOT NULL,
	City varchar(30) NOT NULL,
	Size int NOT NULL,
	NumberOfTracks int NOT NULL,
	NumberOfStockkeepers int NOT NULL,
	NumberOfForklifts int NOT NULL,
 )



 drop table [iHerb_DW].[dbo].[country_DIM]
 --TRUNCATE TABLE [iHerb_DW].[dbo].[country_DIM]
 CREATE TABLE [iHerb_DW].[dbo].[country_DIM](
	[country] [varchar](30) NOT NULL,
	[city] [varchar](30) NOT NULL,
	CONSTRAINT [PK_country_DIM] PRIMARY KEY (country,city) 

)

--drop table [iHerb_DW].[dbo].[city_DIM]
 --TRUNCATE TABLE [iHerb_DW].[dbo].[city_DIM]
CREATE TABLE [iHerb_DW].[dbo].[city_DIM](
	[city] [varchar](30)  PRIMARY KEY NOT NULL,

)

--drop table iHerb_DW.dbo.DIM_DATE
--dim date
create table iHerb_DW.dbo.DIM_DATE
(
	TheDate date,
	TheDay int,
	TheDayName varchar(20),
	TheDayOfWeek int,
	IsWeekend int,
	TheWeek int,
	TheWeekOfMonth int,
	TheMonth int,
	TheMonthName varchar(20),
	TheQuarter int,
	TheFirstOfQuarter date,
	TheLastOfQuarter date,
	TheYear int,
	IsLeapYear int
	)


DECLARE @StartDate  date = '20200501';
DECLARE @CutoffDate date = DATEADD(DAY, -1, DATEADD(YEAR, 5, @StartDate));
;WITH seq(n) AS
(
  SELECT 0 UNION ALL SELECT n + 1 FROM seq
  WHERE n < DATEDIFF(DAY, @StartDate, @CutoffDate)
),
d(d) AS
(
  SELECT DATEADD(DAY, n, @StartDate) FROM seq
),
src AS
(
  SELECT
    TheDate         = CONVERT(date, d),
    TheDay          = DATEPART(DAY,       d),
    TheDayName      = DATENAME(WEEKDAY,   d),
    TheWeek         = DATEPART(WEEK,      d),
    TheISOWeek      = DATEPART(ISO_WEEK,  d),
    TheDayOfWeek    = DATEPART(WEEKDAY,   d),
    TheMonth        = DATEPART(MONTH,     d),
    TheMonthName    = DATENAME(MONTH,     d),
    TheQuarter      = DATEPART(Quarter,   d),
    TheYear         = DATEPART(YEAR,      d),
    TheFirstOfMonth = DATEFROMPARTS(YEAR(d), MONTH(d), 1),
    TheLastOfYear   = DATEFROMPARTS(YEAR(d), 12, 31),
    TheDayOfYear    = DATEPART(DAYOFYEAR, d)
  FROM d
),

dim AS
(
  SELECT
    TheDate,
    TheDay,
    TheDayName,
    TheDayOfWeek,
    IsWeekend           = CASE WHEN TheDayOfWeek IN (CASE @@DATEFIRST WHEN 1 THEN 6 WHEN 7 THEN 1 END,7)
                            THEN 1 ELSE 0 END,
    TheWeek,
    TheWeekOfMonth      = CONVERT(tinyint, DENSE_RANK() OVER
                            (PARTITION BY TheYear, TheMonth ORDER BY TheWeek)),
    TheMonth,
    TheMonthName,
    TheQuarter,
    TheFirstOfQuarter   = MIN(TheDate) OVER (PARTITION BY TheYear, TheQuarter),
    TheLastOfQuarter    = MAX(TheDate) OVER (PARTITION BY TheYear, TheQuarter),
    TheYear,
    IsLeapYear          = CONVERT(bit, CASE WHEN (TheYear % 400 = 0)
                            OR (TheYear % 4 = 0 AND TheYear % 100 <> 0)
                            THEN 1 ELSE 0 END)
  FROM src
)
insert into iHerb_DW.dbo.DIM_DATE
SELECT * FROM dim
  ORDER BY TheDate

OPTION (MAXRECURSION 0);



--drop table [iHerb_DW].[dbo].[DW_OrderDetails_Summary]
CREATE	TABLE [iHerb_DW].[dbo].[DW_OrderDetails_Summary] (
ProductID int NOT NULL ,
TheYear int  NOT NULL , 
TheMonth int NOT NULL,
total_Quantity int NOT NULL,
total_income float NOT NULL ,
total_discountAmount float NOT NULL , 
totalLostFromReturns float NOT NULL ,

CONSTRAINT [PK_Summary_DW_OrderDetails_Summary] PRIMARY KEY (ProductID,TheYear,TheMonth)  

)



--drop table [iHerb_DW].[dbo].[DW_Warehouse_Summary]
CREATE	TABLE [iHerb_DW].[dbo].[DW_Warehouse_Summary] (
warehouseID int NOT NULL ,
TheYear int  NOT NULL , 
TheMonth int NOT NULL,
totalPrice float NOT NULL,
returnQuantity int NOT NULL ,
saleQuantity int NOT NULL , 
avgShipTime float NOT NULL ,
CONSTRAINT [PK_DW_Warehouse_Summary] PRIMARY KEY (warehouseID,TheYear,TheMonth)  

)

--drop table [iHerb_DW].[dbo].[old_Version_Customer]
 --TRUNCATE TABLE [iHerb_DW].[dbo].[old_Version_Customer]
CREATE	TABLE [iHerb_DW].[dbo].[old_Version_Customer] (
	DwCustomer int not null primary key ,
	customerID		Int  NOT NULL,
	firstName	Varchar (30) NOT NULL,
	lastName	Varchar (30) NOT NULL,
	birthdate		Date NOT NULL,
	email varchar(40) NOT NULL,
	age		Int NOT NULL,
	ageGroup		Varchar(10) NOT NULL,
	gender		Varchar(30) NOT NULL,
	country		Varchar (30) NOT NULL,	
	city		Varchar (30) NOT NULL,
	validFrom date ,
	validUntil date 
 )


Create procedure [dbo].[updateOldVersions] as BEGIN
update [iHerb_DW].[dbo].[Customer_DIM] set ValidUntil = GETDATE() where DwCustomer in (Select DwCustomer from [iHerb_DW].[dbo].[old_Version_Customer]) 
truncate table [iHerb_DW].[dbo].[old_Version_Customer]
END

--drop table [iHerb_DW].[dbo].[OrderDetails_FactDW]
 --TRUNCATE TABLE [iHerb_DW].[dbo].[OrderDetails_FactDW]
CREATE	TABLE [iHerb_DW].[dbo].[OrderDetails_FactDW] (
	--DWOrder		Int identity (1,1) NOT NULL primary key ,
	orderNumber Int NOT NULL   ,
	orderDate	Date NOT NULL, 
	arrivalDate Date NOT NULL, 
	orderStatus VARCHAR(40) NOT NULL,
	shipType VARCHAR(20) NOT NULL,
	shipPrice float NOT NULL,
	totalPrice float NOT NULL, 
	isLate	bit   NOT NULL, 
	warehouseID int NOT NULL, 
	--DWCustomer int NOT NULL,
	customerID int NOT NULL,
	--DWProduct int NOT NULL,
	ProductID int NOT NULL,
	returnQuantity int NOT NULL, 
	returnReason varchar(20) , 
	Compensation_Method  varchar(20) , 
	Quantity int NOT NULL, 
	Discount float NOT NULL, 
	DiscountAmount float NOT NULL ,
	ProductPrice_USD money not null
 )


 --drop table [iHerb_DW].[dbo].[rejected]
 --TRUNCATE TABLE [iHerb_STG].[dbo].[rejected]
CREATE	TABLE [iHerb_DW].[dbo].[rejected] (
	--DWOrder		Int identity (1,1) NOT NULL ,
	orderNumber Int NOT NULL    ,
	orderDate	Date NOT NULL, 
	arrivalDate Date NOT NULL, 
	orderStatus VARCHAR(40) NOT NULL,
	shipType VARCHAR(20) NOT NULL,
	shipPrice float NOT NULL,
	totalPrice float NOT NULL, 
	isLate	bit   NOT NULL, 
	warehouseID int NOT NULL, 
	--DWCustomer int NOT NULL,
	customerID int NOT NULL,
	--DWProduct int NOT NULL,
	ProductID int ,
	returnQuantity int NOT NULL, 
	returnReason varchar(20) , 
	Compensation_Method  varchar(20) , 
	Quantity int NOT NULL, 
	Discount float NOT NULL, 
	DiscountAmount float NOT NULL ,
	ProductPrice_USD money not null
 )