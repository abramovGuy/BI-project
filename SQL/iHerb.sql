--drop table [iHerb].[dbo].[Product]

 CREATE TABLE [iHerb].[dbo].[Product](
	[ProductID] [int] PRIMARY KEY NOT NULL,
	[ProductName] [varchar](100) NOT NULL,
	[brandName] [varchar](50) NOT NULL,
	[ProductCategory] [varchar](50) NOT NULL,
	[Rating] [int] NOT NULL,
	[Review] [varchar](50) NOT NULL,
	[ProductPrice_USD] [money] NOT NULL,
 )

---------------------------------------------------------------------------
 --drop table [iHerb].[dbo].[customer]
CREATE TABLE [iHerb].[dbo].[customer](
	[customerID] [int] PRIMARY KEY NOT NULL,
	[firstName] [varchar](20) NOT NULL,
	[lastName] [varchar](20) NOT NULL,
	[birthday] [date] NOT NULL,
	[gender] [varchar](10) NOT NULL,
	[email] [varchar](40) NOT NULL,
	[phoneNumber] [varchar](15) NOT NULL,
	[city] [varchar](40) NOT NULL,
	[country] [varchar](30) NOT NULL
 )
--------------------------------------------------------------------------------------
 --drop table [iHerb].[dbo].[warehouse]

CREATE TABLE [iHerb].[dbo].[warehouse](
	[warehouseID] [int] PRIMARY KEY  NOT NULL,
	[Country] [varchar](20) NOT NULL,
	[City] [varchar](20) NOT NULL,
	[Size_m_3] [int] NOT NULL
)
-------------------------------------------------------------
--drop table [iHerb].[dbo].[warehouseStatus]
CREATE TABLE [iHerb].[dbo].[warehouseStatus](
	[yearMonth] [date] NOT NULL,
	[warehouseID] [int]  NOT NULL,
	[NumberOfTracks] [int] NOT NULL,
	[NumberOfStockkeepers] [int] NOT NULL,
	[NumberOfForklifts] [int] NOT NULL
	CONSTRAINT [PK_warehouseStatus] PRIMARY KEY (yearMonth,warehouseID) 
)
--------------------------------------------------------------------
ALTER TABLE [iHerb].[dbo].[warehouseStatus]
ADD CONSTRAINT FK_warehouseStatus
FOREIGN KEY ([warehouseID]) REFERENCES [iHerb].[dbo].[warehouse]([warehouseID]);


-------------------------------------------------------
 --drop table [iHerb].[dbo].[order]
CREATE TABLE [iHerb].[dbo].[order](
	[orderNumber] [int] PRIMARY KEY NOT NULL,
	[orderDate] [date] NOT NULL,
	[arrivalDate] [date] NOT NULL,
	[email] [varchar](50) NOT NULL,
	[orderStatus] [varchar](50) NOT NULL,
	[shipType] [varchar](50) NOT NULL,
	[shipPrice] [money] NOT NULL,
	[orderPrice] [money] NOT NULL,
	[isLate] [bit] NOT NULL,
	[warehouseID] [int]  NOT NULL
)
---------------------------------------------------------
ALTER TABLE [iHerb].[dbo].[order]
ADD CONSTRAINT FK_Order
FOREIGN KEY ([warehouseID]) REFERENCES [iHerb].[dbo].[warehouse]([warehouseID]);
-----------------------------------------------------
 --drop table [iHerb].[dbo].[orderDetails]

CREATE TABLE [iHerb].[dbo].[orderDetails](
	[order_Number] [int] NOT NULL,
	[ProductID] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[Discount] [float] NOT NULL,
	[returnQuantity] [int] NOT NULL,
	[returnReason] [varchar](50) NOT NULL,
	[compensationMethod] [varchar](30) NOT NULL
	 CONSTRAINT [PK_orderDetails] PRIMARY KEY (order_Number,ProductID) 
)
---------------------------------[warehouseID] [int]  NOT NULL,

ALTER TABLE [iHerb].[dbo].[orderDetails]
ADD CONSTRAINT FK_OrderNumber
FOREIGN KEY ([order_Number]) REFERENCES [iHerb].[dbo].[order]([orderNumber]);


ALTER TABLE [iHerb].[dbo].[orderDetails]
ADD CONSTRAINT FK_orderDetails
FOREIGN KEY ([ProductID]) REFERENCES [iHerb].[dbo].[Product]([ProductID]);
-----------------------------------------------
