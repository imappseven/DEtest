USE Staging;
SELECT * FROM customer;

CREATE DATABASE DWH_Project;
USE DWH_Project;

CREATE TABLE dbo.DimCustomer(
    CustomerID INT NOT NULL,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Age INT NOT NULL,
    Gender VARCHAR(50) NOT NULL,
    City VARCHAR(50) NOT NULL,
    NoHP VARCHAR(50) NOT NULL,
    PRIMARY KEY (CustomerID)
);

SELECT * FROM DimCustomer;

CREATE TABLE dbo.DimProduct(
    ProductID INT NOT NULL,
    ProductName VARCHAR(255) NOT NULL,
    ProductCategory VARCHAR(255) NOT NULL,
    ProductUnitPrice INT NULL,
    PRIMARY KEY (ProductID)
);

SELECT * FROM DimProduct;

CREATE TABLE dbo.DimStatusOrder(
    StatusID INT NOT NULL,
    StatusOrder VARCHAR(50) NOT NULL,
    StatusOrderDesc VARCHAR(50) NOT NULL,
    PRIMARY KEY (StatusID)
);

SELECT * FROM DimStatusOrder;

CREATE TABLE dbo.FactSalesOrder(
    OrderID INT NOT NULL,
    CustomerID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    Amount INT NOT NULL,
    StatusID INT NOT NULL,
    OrderDate DATE NOT NULL,
    PRIMARY KEY (OrderID),
    FOREIGN KEY (CustomerID) REFERENCES DimCustomer(CustomerID),
    FOREIGN KEY (ProductID) REFERENCES DimProduct(ProductID),
    FOREIGN KEY (StatusID) REFERENCES DimStatusOrder(StatusID)
);

SELECT * FROM FactSalesOrder;

SELECT * FROM sys.foreign_keys;

ALTER TABLE dbo.FactSalesOrder
DROP CONSTRAINT FK__FactSales__Custo__3D5E1FD2;

SELECT * FROM DimCustomer;
SELECT * FROM DimProduct;
SELECT * FROM DimStatusOrder;
SELECT * FROM FactSalesOrder;

ALTER TABLE dbo.FactSalesOrder
ADD FOREIGN KEY (CustomerID) REFERENCES dbo.DimCustomer(CustomerID);

SELECT Fasalor.OrderID,
       Dimcust.CustomerName,
       Dimprod.ProductName,
       Fasalor.Quantity,
       Dimstat.StatusOrder
FROM dbo.FactSalesOrder AS Fasalor
JOIN dbo.DimCustomer AS Dimcust
ON Fasalor.CustomerID = Dimcust.CustomerID
JOIN dbo.DimProduct AS Dimprod
ON Fasalor.ProductID = Dimprod.ProductID
JOIN dbo.DimStatusOrder AS Dimstat
ON Fasalor.StatusID = Dimstat.StatusID;