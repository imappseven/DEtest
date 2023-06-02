CREATE PROCEDURE dbo.summary_order_status(
    @StatusID INT
)
AS
BEGIN
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
    ON Fasalor.StatusID = Dimstat.StatusID
    WHERE Dimstat.StatusID = @StatusID
END;

EXEC dbo.summary_order_status @StatusID = 5;