SHOW DATABASES;
SHOW TABLES;

-- a) How many orders were shipped by Speedy Express in total?

SELECT COUNT(*) AS NumberOfOrders
FROM [Orders]
JOIN [Shippers]
    ON [Shippers].ShipperID = [Orders].ShipperID
WHERE [Shippers].ShipperName = 'Speedy Express'

ANSWER: 54

-- b) What is the last name of the employee with the most orders? 

SELECT [Employees].LastName, COUNT(*) AS NumberOfOrders
FROM [Orders]
JOIN [Employees]
ON [Orders].EmployeeID = [Employees].EmployeeID
GROUP BY [Employees].LastName
ORDER BY NumberOfOrders DESC
LIMIT 1

ANSWER: Peacock, 40 

-- c) What product was ordered the most by customers in Germany?

CREATE VIEW Products_Ordered AS
SELECT Orders.OrderID, Customers.Country, OrderDetails.Quantity, Products.ProductName
FROM Orders, OrderDetails
JOIN Customers ON Orders.CustomerID=Customers.CustomerID
JOIN Products ON OrderDetails.ProductID=Products.ProductID
WHERE Country='Germany';

CREATE VIEW Product_Orders AS
SELECT ProductName, Quantity, COUNT(*) as 'Orders'
FROM Products_Ordered
GROUP BY ProductName;

SELECT ProductName, Quantity, Orders, (Quantity * Orders) AS TotalOrdered
FROM Product_Orders
ORDER BY TotalOrdered desc
LIMIT 1;

Answer:  

ProductName - Camembert Pierrot
Quantity - 40 
Orders - 300
TotalOrdered - 12000
