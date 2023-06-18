 --drop table [iHerb_STG].[dbo].[Products_STG]
 --TRUNCATE TABLE [iHerb_STG].[dbo].[Products_STG]

 CREATE TABLE [iHerb_STG].[dbo].[Products_STG](
	[ProductID] [int] PRIMARY KEY NOT NULL,
	[ProductName] [varchar](100) NOT NULL,
	[brandName] [varchar](50) NOT NULL,
	[ProductCategory] [varchar](50) NOT NULL,
	[Rating] [int] NOT NULL,
	[Review] [varchar](50) NOT NULL,
	[ProductPrice_USD] [money] NOT NULL,
 )

--drop table [iHerb_STG].[dbo].[Customer_STG]
 --TRUNCATE TABLE [iHerb_STG].[dbo].[Customer_STG]
CREATE	TABLE [iHerb_STG].[dbo].[Customer_STG] (
	DwCustomer int ,
	customerID		Int NOT NULL,
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

 --drop table [iHerb_STG].[dbo].[Warehouse_STG]
 --TRUNCATE TABLE [iHerb_STG].[dbo].[Warehouse_STG]
CREATE	TABLE [iHerb_STG].[dbo].[Warehouse_STG] (
	DWWarehouse int identity (1,1) PRIMARY KEY NOT NULL,
	warehouseID int NOT NULL,
	year_Month date NOT NULL, 
	Country varchar(30) NOT NULL,
	City varchar(30) NOT NULL,
	Size int NOT NULL,
	NumberOfTracks int NOT NULL,
	NumberOfStockkeepers int NOT NULL,
	NumberOfForklifts int NOT NULL,
 )

--drop table [iHerb_STG].[dbo].[OrderDetails_Fact]
 --TRUNCATE TABLE [iHerb_STG].[dbo].[OrderDetails_Fact]
CREATE	TABLE [iHerb_STG].[dbo].[OrderDetails_Fact] (
	--DWOrder		Int identity (1,1) NOT NULL ,
	orderNumber Int NOT NULL primary key   ,
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

 
 CREATE TABLE [iHerb_STG].[dbo].[country_STG](
	[country] [varchar](30) PRIMARY KEY NOT NULL,
	[city] [varchar](30) NOT NULL,
)

CREATE TABLE [iHerb_STG].[dbo].[city_STG](
	[city] [varchar](30)  PRIMARY KEY NOT NULL,
)

--drop table [iHerb_STG].[dbo].[Summary_OrderDetails_Fact]
CREATE	TABLE [iHerb_STG].[dbo].[Summary_OrderDetails_Fact] (
ProductID int NOT NULL ,
TheYear int  NOT NULL , 
TheMonth int NOT NULL,
total_Quantity int NOT NULL,
total_income float NOT NULL ,
total_discountAmount float NOT NULL , 
totalLostFromReturns float NOT NULL ,

CONSTRAINT [PK_Summary_OrderDetails_Fact] PRIMARY KEY (ProductID,TheYear,TheMonth)  

)



--drop table [iHerb_STG].[dbo].[Summary_Warehouse_Fact]
CREATE	TABLE [iHerb_STG].[dbo].[Summary_Warehouse_Fact] (
warehouseID int NOT NULL ,
TheYear int  NOT NULL , 
TheMonth int NOT NULL,
totalPrice float NOT NULL,
returnQuantity int NOT NULL ,
saleQuantity int NOT NULL , 
avgShipTime float NOT NULL ,
CONSTRAINT [PK_Summary_Warehouse_Fact] PRIMARY KEY (warehouseID,TheYear,TheMonth)  

)

--drop table [iHerb_STG].[dbo].[rejected]
 --TRUNCATE TABLE [iHerb_STG].[dbo].[rejected]
CREATE	TABLE [iHerb_STG].[dbo].[rejected] (
	--DWOrder		Int identity (1,1) NOT NULL ,
	orderNumber Int NOT NULL primary key   ,
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





 --drop table [iHerb_STG].[dbo].[Order_DW]
 --TRUNCATE TABLE [iHerb_STG].[dbo].[Order_DW]
CREATE	TABLE [iHerb_STG].[dbo].[Order_DW] (
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