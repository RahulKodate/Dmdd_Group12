CREATE DATABASE Restaurant_food
GO
use Restaurant_food
go


CREATE TABLE Address
(
    AddressID varchar(5) NOT NULL,
    Street VARCHAR(50),
    City VARCHAR(30),
    State CHAR(2),
    ZipCode int NOT NULL CHECK(ZipCode >= 10000 AND ZipCode <= 99999),
    CONSTRAINT Address_PK PRIMARY KEY (AddressID)
);

Select City from Address where AddressID = '10100';

SELECT * FROM Address

CREATE TABLE Customer
(
    CustomerID varchar(5) NOT NULL,
    AddressID varchar(5) NOT NULL,
    FirstName VARCHAR(20),
    LastName VARCHAR(20),
    EmailID VARCHAR(200),
    ContactNumber char(10) NOT NULL,
	CONSTRAINT Customer_PK PRIMARY KEY (CustomerID),
	CONSTRAINT Customer_FK FOREIGN KEY (AddressID) REFERENCES Address(AddressID)
);
SELECT FirstName FROM Customer where AddressID = '10002'

CREATE TABLE Restaurant
(
	RestaurantID varchar(5) not null,
	RestaurantName nvarchar(25),
	RestaurantStreet varchar(20),
	RestaurantCity varchar(20),
	RestaurantState char(2),
	RestaurantZipCode char(5),
	RestaurantEmailId varchar(200),
	RestaurantContactNumber char(10)
	CONSTRAINT Restaurant_PK PRIMARY KEY (RestaurantID)
);

SELECT RestaurantName from Restaurant where RestaurantID = '30499'

CREATE TABLE Menu
(
	MenuID char(5) not null,
	RestaurantID  varchar(5) not null,
	MenuName nvarchar(20),
	CONSTRAINT Menu_PK PRIMARY KEY (MenuID),
	CONSTRAINT Menu_FK FOREIGN KEY (RestaurantID) references Restaurant(RestaurantID)
);

SELECT MenuName FROM Menu where RestaurantID = '30010'

CREATE TABLE MenuItem
(
	MenuItemID char(5) not null,
	MenuID char(5) not null,
	DishName varchar(255),
	DishPrice decimal,
	DishType varchar(255),
	CONSTRAINT MenuItem_PK PRIMARY KEY (MenuItemID),
	CONSTRAINT MenuItem_FK FOREIGN KEY (MenuID) references Menu(MenuID)
);

SELECT DishPrice FROM MenuItem where DishType = 'Appetizer'

CREATE TABLE Product 
(
	ProductId char(5) not null,
	ProductName varchar(50),
	ProductQuantity varchar(50),
	CostPrice decimal,
	CONSTRAINT Product_PK PRIMARY KEY (ProductId)
);

SELECT ProductName, CostPrice FROM Product where ProductId = '60411'

CREATE TABLE Supplier
(
    SupplierID char(5) not null,
    SupplierFirstName varchar(25),
    SupplierLastName varchar(25),
    SupplierContactNumber char(10),
    SupplierEmailID varchar(100),
    SupplierStreet varchar(20),
    SupplierCity varchar(20),
    SupplierState char(2),
    SupplierZipCode char(5)
    CONSTRAINT Supplier_PK PRIMARY KEY (SupplierID)
);

SELECT SupplierFirstName FROM Supplier where SupplierState = 'MA'

CREATE TABLE Supply
(
    SupplyID char(5) not null,
    ProductID char(5) not null,
    SupplierID char(5) not null,
    RestaurantID varchar(5) not null,
    SupplyDate Datetime,
    CONSTRAINT Supply_PK PRIMARY KEY (SupplyID),
    CONSTRAINT Supply_FK1 FOREIGN KEY (ProductID) REFERENCES Product(ProductID),
    CONSTRAINT Supply_FK2 FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID),
    CONSTRAINT Supply_FK3 FOREIGN KEY (RestaurantID) REFERENCES Restaurant(RestaurantID)
);

SELECT SupplyDate FROM Supply where RestaurantID = '30001'

CREATE TABLE [Order]
(
	OrderID char(5) not null,	
	OrderDate Datetime,
	CustomerID varchar(5) not null,
	RestaurantID varchar(5) not null,
	DeliveryDate DATETIME,
	TotalPrice decimal not null,
	CONSTRAINT Order_PK PRIMARY KEY (OrderID),
	CONSTRAINT Order_FK1 FOREIGN KEY (CustomerID) references Customer(CustomerID),
	CONSTRAINT Order_FK2 FOREIGN KEY (RestaurantID) references Restaurant(RestaurantID),
);

Select OrderDate, DeliveryDate from [Order] where CustomerID = '20009'

CREATE TABLE OrderItem
(
	OrderItemID char(5) not null,
	OrderID char(5) not null,
	MenuItemID char(5) not null,
	OrderQuantity int not null,
	CONSTRAINT OrderItem_PK PRIMARY KEY (OrderItemID),
	CONSTRAINT OrderItem_FK1 FOREIGN KEY (OrderID) references [Order](OrderID),
	CONSTRAINT OrderItem_FK2 FOREIGN KEY (MenuItemID) references MenuItem(MenuItemID),
);

SELECT OrderItemID, OrderQuantity FROM OrderItem where OrderID = '90004'

CREATE TABLE Payment
(
	PaymentID char(5) not null,
	OrderID char(5) not null,
	PaymentDate Datetime,
	PaymentAmount decimal not null,
	IsSuccessful varchar(10), CONSTRAINT IsSuccessful_chk CHECK(IsSuccessful IN ('Success', 'Failure')),
	CONSTRAINT Payment_PK PRIMARY KEY (PaymentID),
	CONSTRAINT Payment_FK FOREIGN KEY (OrderID) references [Order](OrderID),
);

SELECT PaymentAmount, IsSuccessful FROM Payment where PaymentID = '57001'

CREATE TABLE DeliveryPerson
(
    DeliveryPersonID char(5) not null,
    FirstName VARCHAR(25),
    LastName VARCHAR(25),
    Email_ID VARCHAR(100),
    ContactNumber char(10),
    CONSTRAINT DeliveryPerson_PK primary key (DeliveryPersonID),
);

SELECT FirstName FROM DeliveryPerson where DeliveryPersonID = '11111'

CREATE TABLE Delivery
(
    DeliveryID char(5) not null,
    OrderID char(5) not null,
    DeliveryPersonID char(5) not null,
    DeliveryDate Datetime,
    IsDelivered varchar(10), CONSTRAINT IsDelivered_chk CHECK(IsDelivered IN ('True', 'False')),
    CONSTRAINT Delivery_PK primary key (DeliveryID),
    CONSTRAINT Delivery_FK1 FOREIGN KEY (OrderID) REFERENCES [Order](OrderID),
    CONSTRAINT Delivery_FK2 FOREIGN KEY (DeliveryPersonID) REFERENCES DeliveryPerson(DeliveryPersonID),
);

Select IsDelivered, OrderID from Delivery where DeliveryID = '10111'

---View 1
go
CREATE VIEW Paymenttt AS
SELECT p.PaymentID, o.OrderID, o.TotalPrice, o.CustomerID, p.IsSuccessful
FROM Payment p JOIN [Order] o on o.OrderID = p.OrderID
WHERE p.IsSuccessful IN (SELECT IsSuccessful FROM Payment where IsSuccessful in ('Success'));

GO
SELECT * FROM Paymenttt;

---View 2
go
ALTER VIEW Menuu AS
SELECT m.MenuID, mi.MenuItemID, m.MenuName, mi.DishName
FROM Menu m JOIN MenuItem mi on m.MenuID = mi.MenuID
WHERE m.MenuName IN (SELECT MenuName FROM Menu where MenuName in ('Breakfast Menu'));

go
SELECT * FROM Menuu;


---view 3
go
CREATE VIEW odr AS
SELECT o.OrderID, r.RestaurantID, d.IsDelivered, r.RestaurantName, o.OrderDate
FROM [Order] as o INNER JOIN Delivery d on o.OrderID = d.OrderID INNER JOIN Restaurant as r on o.RestaurantID = r.RestaurantID

---DROP VIEW odr;
go
SELECT * FROM odr;


---view 4
go
CREATE VIEW sps AS
SELECT s.SupplierID, s.SupplierFirstName, su.SupplyID, su.SupplyDate, p.ProductId, p.ProductName 
FROM Supplier s JOIN Supply su on s.SupplierID = su.SupplierID JOIN Product p on p.ProductId = su.ProductID
WHERE ProductName = 'Happy Snack';

go
SELECT * FROM sps;

---DROP VIEW sps;


---Stored Procedure 1
---Selecting all restaurants in the city Boston
go
CREATE PROCEDURE SelectAllRestaurants  @city varchar(20)
AS 
SELECT * FROM Restaurant where RestaurantCity = @city
Go

EXEC SelectAllRestaurants @city = 'Ashleytown';


---Stored Prodcedure 2
---Updating the payment status with PaymentID
go
CREATE PROCEDURE UpdatePayment @PaymenttID int, @PaymentStatus varchar(10)
AS
BEGIN 
	UPDATE Payment
	SET IsSuccessful = @PaymentStatus
	WHERE PaymentID = @PaymenttID
END

EXEC UpdatePayment '56701', 'Success';


---Stored Procedure 3
---Displaying the dish with Maximum Price
go
Create PROCEDURE Maxpricedish as
DECLARE @maxprice decimal
Begin
SELECT @maxprice = max(DishPrice) from MenuItem;
SELECT DishName, DishPrice
FROM MenuItem
WHERE DishPrice = @maxprice
END

EXEC Maxpricedish;


---UDF 1
---calculate sales
go
Create FUNCTION dbo.GetSales()
RETURNS int
AS
BEGIN

	DECLARE @TotalCompletedOrders int

	select @TotalCompletedOrders = count(PaymentID) from Payment
	where IsSuccessful = 'Success'

	RETURN @TotalCompletedOrders
END

go
SELECT dbo.GetSales() as totalorders

---Trigger
---once the delivery status changes to true, the restaurant can be sent a notification that the order is delivered
GO
CREATE TRIGGER Is_Delivered_Message 
ON Delivery
AFTER UPDATE 
AS 
BEGIN
    IF UPDATE(IsDelivered) AND EXISTS (
        SELECT * FROM inserted WHERE IsDelivered = 'True'
    )
    BEGIN
        DECLARE @OrderID char(5), @RestaurantName nvarchar(25);

        SELECT @OrderID = i.OrderID, @RestaurantName = r.RestaurantName
		FROM inserted i
		INNER JOIN [Order] o ON i.OrderID = o.OrderID
		INNER JOIN Restaurant r ON o.RestaurantID = r.RestaurantID;

        PRINT 'Order ' + @OrderID + ' is delivered from ' + @RestaurantName;
    END
END

Select * from Delivery;

UPDATE Delivery
SET IsDelivered = 'True'
WHERE DeliveryID = '10112';


---Column data encryption
---encrypt customer's emailid
create Master key
ENCRYPTION BY PASSWORD='restaurant6210';

SELECT name KeyName,
	symmetric_key_id KeyID,
	key_length KeyLength,
	algorithm_desc KeyAlgorithm
FROM sys.symmetric_keys;

go
CREATE CERTIFICATE CustPass
	WITH SUBJECT = 'Restaurant Password'

GO
SELECT name CertName,
	certificate_id CertID,
	pvt_key_encryption_type_desc EncryptType,
	issuer_name Issuer
FROM sys.certificates;

CREATE SYMMETRIC KEY SymKey_test WITH ALGORITHM = AES_256 ENCRYPTION BY CERTIFICATE CustPass;

SELECT name KeyName,
	symmetric_key_id KeyID,
	key_length KeyLength,
	algorithm_desc KeyAlgorithm
FROM sys.symmetric_keys;

ALTER TABLE Customer 
ADD email_encrypt varbinary(MAX)

OPEN SYMMETRIC KEY SymKey_test
	DECRYPTION BY CERTIFICATE CustPass;

UPDATE Customer 
	SET email_encrypt = ENCRYPTBYKEY(KEY_GUID('SymKey_test'), EmailID)
	FROM Customer;
	go

CLOSE SYMMETRIC KEY SymKey_test;

Select * from Customer;


---Non-clustered index - 1
---to find orders using customerID
CREATE NONCLUSTERED INDEX index_customer_id 
ON [Order](CustomerID)

Select name, type_desc
from sys.indexes
Where object_id = OBJECT_ID('[Order]')
and type_desc = 'NONCLUSTERED';

---Non-clustered index - 2
---to find orders of a restaurant using restaurantid
CREATE NONCLUSTERED INDEX index_restaurantid
ON [Order](RestaurantID)

Select name, type_desc
from sys.indexes
Where object_id = OBJECT_ID('[Order]')
and type_desc = 'NONCLUSTERED';

---Non-clustered index - 3
---Orderid and payment
CREATE NONCLUSTERED INDEX index_orderid
ON Payment(OrderID)

Select name, type_desc
from sys.indexes
Where object_id = OBJECT_ID('Payment')
and type_desc = 'NONCLUSTERED';
	