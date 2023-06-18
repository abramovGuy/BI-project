 --drop table [iHerb_MRR].[dbo].[Products_MRR]

 CREATE TABLE [iHerb_MRR].[dbo].[Product_MRR](
	[ProductID] [int] PRIMARY KEY NOT NULL,
	[ProductName] [varchar](100) NOT NULL,
	[brandName] [varchar](50) NOT NULL,
	[ProductCategory] [varchar](50) NOT NULL,
	[Rating] [int] NOT NULL,
	[Review] [varchar](50) NOT NULL,
	[ProductPrice_USD] [money] NOT NULL,
 )

---------------------------------------------------------------------------
 --drop table [iHerb_MRR].[dbo].[customer_MRR]
CREATE TABLE [iHerb_MRR].[dbo].[customer_MRR](
	[customerID] [int] PRIMARY KEY NOT NULL,
	[firstName] [varchar](20) NOT NULL,
	[lastName] [varchar](20) NOT NULL,
	[birthdate] [date] NOT NULL,
	[gender] [varchar](10) NOT NULL,
	[email] [varchar](40) NOT NULL,
	[phoneNumber] [varchar](15) NOT NULL,
	[city] [varchar](40) NOT NULL,
	[country] [varchar](30) NOT NULL
 )
--------------------------------------------------------------------------------------
 --drop table [iHerb_MRR].[dbo].[warehouse_MRR]

CREATE TABLE [iHerb_MRR].[dbo].[warehouse_MRR](
	[warehouseID] [int] PRIMARY KEY  NOT NULL,
	[Country] [varchar](10) NOT NULL,
	[City] [varchar](40) NOT NULL,
	[Size] [int] NOT NULL
)
-------------------------------------------------------------
--drop table [iHerb_MRR].[dbo].[warehouseStatus_MRR]
CREATE TABLE [iHerb_MRR].[dbo].[warehouseStatus_MRR](
	[warehouseID] [int]  NOT NULL,
	[year_Month] [date] NOT NULL,
	[NumberOfTracks] [int] NOT NULL,
	[NumberOfStockkeepers] [int] NOT NULL,
	[NumberOfForklifts] [int] NOT NULL
	CONSTRAINT [PK_warehouseStatus] PRIMARY KEY (yearMonth,warehouseID) 
)

-------------------------------------------------------
 --drop table [iHerb_MRR].[dbo].[order_MRR]
CREATE TABLE [iHerb_MRR].[dbo].[order_MRR](
	[orderNumber] [int] PRIMARY KEY NOT NULL,
	[orderDate] [date] NOT NULL,
	[arrivalDate] [date] NOT NULL,
	[email] [varchar](50) NOT NULL,
	[orderStatus] [varchar](50) NOT NULL,
	[shipType] [varchar](50) NOT NULL,
	[shipPrice] [money] NOT NULL,
	[total_order_Price] [money] NOT NULL,
	[isLate] [bit] NOT NULL,
	[warehouseID] [int]  NOT NULL
)

-----------------------------------------------------
 --drop table [iHerb_MRR].[dbo].[orderDetails_MRR]

CREATE TABLE [iHerb_MRR].[dbo].[orderDetails_MRR](
	[order_Number] [int] NOT NULL,
	[ProductID] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[Discount] [float] NOT NULL,
	[returnQuantity] [int] NOT NULL,
	[returnReason] [varchar](50) ,
	[Compensation_Method] [varchar](30) 
	 CONSTRAINT [PK_orderDetails] PRIMARY KEY (order_Number,ProductID) 
)
---------------------------------


