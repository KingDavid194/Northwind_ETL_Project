-- Create database
IF DB_ID('Northwind_DW') IS NULL
BEGIN
    CREATE DATABASE Northwind_DW;
END;
GO

USE Northwind_DW;
GO

DROP TABLE IF EXISTS FactSales;
DROP TABLE IF EXISTS DimCustomer;
DROP TABLE IF EXISTS DimProduct;
DROP TABLE IF EXISTS DimDate;
GO

-- Create DimCustomer table
CREATE TABLE DimCustomer (
    CustomerKey INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID NVARCHAR(10) NOT NULL,
    CompanyName NVARCHAR(100),
    ContactName NVARCHAR(100),
    City NVARCHAR(50),
    Country NVARCHAR(50),
    CustomerSegment NVARCHAR(50)
);
GO

-- Create DimProduct table
CREATE TABLE DimProduct (
    ProductKey INT IDENTITY(1,1) PRIMARY KEY,
    ProductID INT NOT NULL,
    ProductName NVARCHAR(100),
    CategoryName NVARCHAR(100),
    UnitPrice DECIMAL(10,2),
    Discontinued BIT,
    CostPrice DECIMAL(10,2),
    CountryOfOrigin NVARCHAR(50),
    SupplierProductCode NVARCHAR(50)
);
GO

-- Create DimDate table
CREATE TABLE DimDate (
    DateKey INT PRIMARY KEY,
    FullDate DATE NOT NULL,
    Year INT,
    Quarter INT,
    Month INT,
    MonthName NVARCHAR(20),
    Week INT,
    DayOfMonth INT,
    DayName NVARCHAR(20)
);
GO

-- Create FactSales table
CREATE TABLE FactSales (
    SalesKey INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT NOT NULL,
    CustomerKey INT NOT NULL,
    ProductKey INT NOT NULL,
    DateKey INT NOT NULL,
    Quantity INT,
    UnitPrice DECIMAL(10,2),
    Discount DECIMAL(5,2),
    TotalAmount DECIMAL(10,2),

    CONSTRAINT FK_FactSales_DimCustomer
        FOREIGN KEY (CustomerKey) REFERENCES DimCustomer(CustomerKey),

    CONSTRAINT FK_FactSales_DimProduct
        FOREIGN KEY (ProductKey) REFERENCES DimProduct(ProductKey),

    CONSTRAINT FK_FactSales_DimDate
        FOREIGN KEY (DateKey) REFERENCES DimDate(DateKey)
);
GO