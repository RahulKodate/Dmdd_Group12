CREATE DATABASE Restaurant_food
GO
use Restaurant_food
go


CREATE TABLE Address
(
    AddressID varchar(6) NOT NULL,
    Street VARCHAR(50),
    City VARCHAR(30),
    State CHAR(2),
    ZipCode int NOT NULL CHECK(ZipCode >= 10000 AND ZipCode <= 99999),
    CONSTRAINT Address_PK PRIMARY KEY (AddressID)
);

insert into Address (AddressID, Street, City, State, ZipCode) values ('100001', '1 Hagan Parkway', 'Sacramento', 'CA', '94263');
insert into Address (AddressID, Street, City, State, ZipCode) values ('100002', '6 Red Cloud Alley', 'Wilmington', 'NC', '28405');
insert into Address (AddressID, Street, City, State, ZipCode) values ('100003', '62951 Fisk Avenue', 'Abilene', 'TX', '79605');
insert into Address (AddressID, Street, City, State, ZipCode) values ('100004', '0 Warner Alley', 'Sacramento', 'CA', '95894');
insert into Address (AddressID, Street, City, State, ZipCode) values ('100005', '40039 Sycamore Plaza', 'Detroit', 'MI', '48295');

Select * from Address;

CREATE TABLE Customer
(
    CustomerID varchar(5) NOT NULL,
    AddressID varchar(6) NOT NULL,
    FirstName VARCHAR(20),
    LastName VARCHAR(20),
    EmailID VARCHAR(200),
    ContactNumber char(10) NOT NULL,
	CONSTRAINT Customer_PK PRIMARY KEY (CustomerID),
	CONSTRAINT Customer_FK FOREIGN KEY (AddressID) REFERENCES Address(AddressID)
);

insert into Customer(CustomerID, AddressID, FirstName, LastName, EmailID, ContactNumber) Values ('20001' , '100001', 'Pavithra', 'Kareddy', 'pavithra@gmail.com', '8003001000');
insert into Customer(CustomerID, AddressID, FirstName, LastName, EmailID, ContactNumber) Values ('20002' , '100002', 'Jahnavi', 'Gangarapu', 'jahnavi@gmail.com', '8003001100');
insert into Customer(CustomerID, AddressID, FirstName, LastName, EmailID, ContactNumber) Values ('20003' , '100003', 'Rahul', 'Kodate', 'rahul@gmail.com', '8003001011');
insert into Customer(CustomerID, AddressID, FirstName, LastName, EmailID, ContactNumber) Values ('20004' , '100004', 'Yash', 'Jaigude', 'yash@gmail.com', '8003001555');
insert into Customer(CustomerID, AddressID, FirstName, LastName, EmailID, ContactNumber) Values ('20005' , '100005', 'Shuolin', 'Hu', 'shuolin@gmail.com', '8003001999');

SELECT * FROM Customer;

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

insert into Restaurant(RestaurantID, RestaurantName, RestaurantStreet, RestaurantCity, RestaurantState, RestaurantZipCode, RestaurantEmailId, RestaurantContactNumber) values ('30001', 'Vaanga', '360 Huntington Ave', 'Boston', 'MA', '02115', 'vaanga@gmail.com', '9000010000');
insert into Restaurant(RestaurantID, RestaurantName, RestaurantStreet, RestaurantCity, RestaurantState, RestaurantZipCode, RestaurantEmailId, RestaurantContactNumber) values ('30002', 'Mumbai Spice', '100 West Ave', 'New York City', 'NY', '02211', 'mumbai@gmail.com', '9000010222');
insert into Restaurant(RestaurantID, RestaurantName, RestaurantStreet, RestaurantCity, RestaurantState, RestaurantZipCode, RestaurantEmailId, RestaurantContactNumber) values ('30003', 'Bawarchi', '720 Boylston Ave', 'Framingham', 'MA', '31033', 'bawarchi@gmail.com', '8800010000');
insert into Restaurant(RestaurantID, RestaurantName, RestaurantStreet, RestaurantCity, RestaurantState, RestaurantZipCode, RestaurantEmailId, RestaurantContactNumber) values ('30004', 'Godavari', '20 Mass Ave', 'Miami', 'FL', '47839', 'godavari@gmail.com', '9000010440');
insert into Restaurant(RestaurantID, RestaurantName, RestaurantStreet, RestaurantCity, RestaurantState, RestaurantZipCode, RestaurantEmailId, RestaurantContactNumber) values ('30005', 'Wow Tikka', '001 Riverway Ave', 'Los Angeles', 'CA', '27469', 'tikka@gmail.com', '2000010000');

SELECT * FROM Restaurant;

CREATE TABLE Menu
(
	MenuID char(5) not null,
	RestaurantID  varchar(5) not null,
	MenuName nvarchar(20),
	CONSTRAINT Menu_PK PRIMARY KEY (MenuID),
	CONSTRAINT Menu_FK FOREIGN KEY (RestaurantID) references Restaurant(RestaurantID)
);

insert into Menu(MenuID, RestaurantID, MenuName) values ('40001', '30001', 'Breakfast');
insert into Menu(MenuID, RestaurantID, MenuName) values ('40002', '30002', 'Lunch');
insert into Menu(MenuID, RestaurantID, MenuName) values ('40003', '30003', 'Dinner');
insert into Menu(MenuID, RestaurantID, MenuName) values ('40004', '30004', 'Snacks');
insert into Menu(MenuID, RestaurantID, MenuName) values ('40005', '30005', 'Brunch');

SELECT * FROM Menu;

CREATE TABLE MenuItem
(
	MenuItemID char(5) not null,
	MenuID char(5) not null,
	DishName nvarchar(20),
	DishDescription varchar(30),
	DishPrice decimal,
	DishType varchar(20),
	CONSTRAINT MenuItem_PK PRIMARY KEY (MenuItemID),
	CONSTRAINT MenuItem_FK FOREIGN KEY (MenuID) references Menu(MenuID)
);

insert into MenuItem(MenuItemID, MenuID, DishName, DishDescription, DishPrice, DishType) values ('50001', '40001', 'Chicken Biryani', 'Very Tasty', '10', 'Indian');
insert into MenuItem(MenuItemID, MenuID, DishName, DishDescription, DishPrice, DishType) values ('50002', '40002', 'Hotpot', 'Yummyyy', '20', 'Chinese');
insert into MenuItem(MenuItemID, MenuID, DishName, DishDescription, DishPrice, DishType) values ('50003', '40003', 'Dosa', 'Delicious', '15', 'Indian');
insert into MenuItem(MenuItemID, MenuID, DishName, DishDescription, DishPrice, DishType) values ('50004', '40004', 'Chicken Tikka Masala', 'Spicy', '12', 'Indian');
insert into MenuItem(MenuItemID, MenuID, DishName, DishDescription, DishPrice, DishType) values ('50005', '40005', 'Pasta', 'Saucy', '14', 'Italian');

SELECT * FROM MenuItem;

CREATE TABLE Product 
(
	ProductId char(5) not null,
	ProductName nvarchar(50),
	ProductDescription varchar(100),
	ProductQuantity varchar(10),
	CostPrice decimal,
	CONSTRAINT Product_PK PRIMARY KEY (ProductId)
);


insert into Product(ProductId, ProductName, ProductDescription, ProductQuantity, CostPrice) values('60001', 'Meat', 'Nonveg', '100kg', '100');
insert into Product(ProductId, ProductName, ProductDescription, ProductQuantity, CostPrice) values('60002', 'Paneer', 'Veg', '10kg', '50');
insert into Product(ProductId, ProductName, ProductDescription, ProductQuantity, CostPrice) values('60003', 'Spinach', 'GreenLeaf', '50kg', '120');
insert into Product(ProductId, ProductName, ProductDescription, ProductQuantity, CostPrice) values('60004', 'Apple', 'Fruit', '30kg', '80');
insert into Product(ProductId, ProductName, ProductDescription, ProductQuantity, CostPrice) values('60005', 'Green Peppers', 'Vegetable', '45kg', '90');

SELECT * FROM Product;

CREATE TABLE Supplier
(
    SupplierID char(5) not null,
    SupplierFirstName nvarchar(25),
    SupplierLastName nvarchar(25),
    SupplierContactNumber char(10),
    SupplierEmailID varchar(100),
    SupplierStreet varchar(20),
    SupplierCity varchar(20),
    SupplierState char(2),
    SupplierZipCode char(5)
    CONSTRAINT Supplier_PK PRIMARY KEY (SupplierID)
);

insert into Supplier(SupplierID, SupplierFirstName, SupplierLastName, SupplierContactNumber, SupplierEmailID, SupplierStreet, SupplierCity, SupplierState, SupplierZipCode) values ('70001', 'Kabir' , 'Singh', '1234567890', 'kabir@gmail.com', '347 Eagan Point', 'Nora', 'MA', '02119');
insert into Supplier(SupplierID, SupplierFirstName, SupplierLastName, SupplierContactNumber, SupplierEmailID, SupplierStreet, SupplierCity, SupplierState, SupplierZipCode) values ('70002', 'Shah' , 'Rukh', '3334567890', 'shah@gmail.com', '1030 Hooker Terrace', 'Talzemt', 'NY', '33680');
insert into Supplier(SupplierID, SupplierFirstName, SupplierLastName, SupplierContactNumber, SupplierEmailID, SupplierStreet, SupplierCity, SupplierState, SupplierZipCode) values ('70003', 'Salman' , 'Khan', '2234567890', 'salman@gmail.com', '6 Anderson Road', 'Asembagus', 'CA', '94622');
insert into Supplier(SupplierID, SupplierFirstName, SupplierLastName, SupplierContactNumber, SupplierEmailID, SupplierStreet, SupplierCity, SupplierState, SupplierZipCode) values ('70004', 'Rocky' , 'Bhai', '4444567890', 'rocky@gmail.com', '1210 Roth Circle', 'Tubungan', 'FL', '96684');
insert into Supplier(SupplierID, SupplierFirstName, SupplierLastName, SupplierContactNumber, SupplierEmailID, SupplierStreet, SupplierCity, SupplierState, SupplierZipCode) values ('70005', 'Ram' , 'Charan', '1234867890', 'ram@gmail.com', '15 Bartelt Way', 'Powassan', 'TX', '23161');

SELECT * FROM Supplier;

CREATE TABLE Supply
(
    SupplyID char(5) not null,
    ProductID char(5) not null,
    SupplierID char(5) not null,
    RestaurantID varchar(5) not null,
    SupplyDate Datetime default (getdate()),
    CONSTRAINT Supply_PK PRIMARY KEY (SupplyID),
    CONSTRAINT Supply_FK1 FOREIGN KEY (ProductID) REFERENCES Product(ProductID),
    CONSTRAINT Supply_FK2 FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID),
    CONSTRAINT Supply_FK3 FOREIGN KEY (RestaurantID) REFERENCES Restaurant(RestaurantID)
);

insert into Supply(SupplyID, ProductID, SupplierID, RestaurantID) values ('80001', '60001', '70001', '30001');
insert into Supply(SupplyID, ProductID, SupplierID, RestaurantID) values ('80002', '60002', '70002', '30002');
insert into Supply(SupplyID, ProductID, SupplierID, RestaurantID) values ('80003', '60003', '70003', '30003');
insert into Supply(SupplyID, ProductID, SupplierID, RestaurantID) values ('80004', '60004', '70004', '30004');
insert into Supply(SupplyID, ProductID, SupplierID, RestaurantID) values ('80005', '60005', '70005', '30005');

SELECT * FROM Supply;

CREATE TABLE [Order]
(
	OrderID char(5) not null,	
	OrderDate Datetime default ( getdate()),
	CustomerID varchar(5) not null,
	RestaurantID varchar(5) not null,
	DeliveryDate DATETIME DEFAULT (getdate()),
	TotalPrice decimal not null,
	CONSTRAINT Order_PK PRIMARY KEY (OrderID),
	CONSTRAINT Order_FK1 FOREIGN KEY (CustomerID) references Customer(CustomerID),
	CONSTRAINT Order_FK2 FOREIGN KEY (RestaurantID) references Restaurant(RestaurantID),
);

insert into [Order](OrderID, CustomerID, RestaurantID, TotalPrice) values ('90001', '20001', '30001', '200');
insert into [Order](OrderID, CustomerID, RestaurantID, TotalPrice) values ('90002', '20002', '30002', '350');
insert into [Order](OrderID, CustomerID, RestaurantID, TotalPrice) values ('90003', '20003', '30003', '400');
insert into [Order](OrderID, CustomerID, RestaurantID, TotalPrice) values ('90004', '20004', '30004', '440');
insert into [Order](OrderID, CustomerID, RestaurantID, TotalPrice) values ('90005', '20005', '30005', '500');

SELECT * FROM [Order];

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

insert into OrderItem(OrderItemID, OrderID, MenuItemID, OrderQuantity) values ('23001', '90001', '50001' , '5');
insert into OrderItem(OrderItemID, OrderID, MenuItemID, OrderQuantity) values ('23002', '90002', '50002' , '2');
insert into OrderItem(OrderItemID, OrderID, MenuItemID, OrderQuantity) values ('23003', '90003', '50003' , '3');
insert into OrderItem(OrderItemID, OrderID, MenuItemID, OrderQuantity) values ('23004', '90004', '50004' , '6');
insert into OrderItem(OrderItemID, OrderID, MenuItemID, OrderQuantity) values ('23005', '90005', '50005' , '1');

SELECT * FROM OrderItem;

CREATE TABLE Payment
(
	PaymentID char(5) not null,
	OrderID char(5) not null,
	PaymentDate Datetime default ( getdate()),
	PaymentAmount decimal not null,
	IsSuccessful varchar(10), CONSTRAINT IsSuccessful_chk CHECK(IsSuccessful IN ('Success', 'Failure')),
	CONSTRAINT Payment_PK PRIMARY KEY (PaymentID),
	CONSTRAINT Payment_FK FOREIGN KEY (OrderID) references [Order](OrderID),
);

insert into Payment(PaymentID, OrderID, PaymentAmount, IsSuccessful) values ('56701', '90001', '100', 'Success');
insert into Payment(PaymentID, OrderID, PaymentAmount, IsSuccessful) values ('56702', '90002', '110', 'Failure');
insert into Payment(PaymentID, OrderID, PaymentAmount, IsSuccessful) values ('56703', '90003', '200', 'Success');
insert into Payment(PaymentID, OrderID, PaymentAmount, IsSuccessful) values ('56704', '90004', '230', 'Success');
insert into Payment(PaymentID, OrderID, PaymentAmount, IsSuccessful) values ('56705', '90005', '560', 'Failure');

SELECT * FROM Payment;

CREATE TABLE DeliveryPerson
(
    DeliveryPersonID char(5) not null,
    FirstName NVARCHAR(25),
    LastName NVARCHAR(25),
    Email_ID VARCHAR(100),
    ContactNumber char(10),
    CONSTRAINT DeliveryPerson_PK primary key (DeliveryPersonID),
);

insert into DeliveryPerson(DeliveryPersonID, FirstName, LastName, Email_ID, ContactNumber) values ('11101', 'Wilbert', 'Jimpson', 'wjimpson0@technorati.com', '7062827511');
insert into DeliveryPerson(DeliveryPersonID, FirstName, LastName, Email_ID, ContactNumber) values ('11102', 'Windy', 'Wayman', 'wwayman1@globo.com', '8654761069');
insert into DeliveryPerson(DeliveryPersonID, FirstName, LastName, Email_ID, ContactNumber) values ('11103', 'Brooks', 'Grahlman', 'bgrahlman2@fema.gov', '4756831027');
insert into DeliveryPerson(DeliveryPersonID, FirstName, LastName, Email_ID, ContactNumber) values ('11104', 'Muire', 'Girtin', 'mgirtin3@mayoclinic.com', '7324607382');
insert into DeliveryPerson(DeliveryPersonID, FirstName, LastName, Email_ID, ContactNumber) values ('11105', 'Pebrook', 'Vanderson', 'pvanderson4@vk.com', '5196572939');

SELECT * FROM DeliveryPerson;

CREATE TABLE Delivery
(
    DeliveryID char(5) not null,
    OrderID char(5) not null,
    DeliveryPersonID char(5) not null,
    DeliveryDate Datetime default ( getdate()),
    IsDelivered varchar(10), CONSTRAINT IsDelivered_chk CHECK(IsDelivered IN ('True', 'False')),
    CONSTRAINT Delivery_PK primary key (DeliveryID),
    CONSTRAINT Delivery_FK1 FOREIGN KEY (OrderID) REFERENCES [Order](OrderID),
    CONSTRAINT Delivery_FK2 FOREIGN KEY (DeliveryPersonID) REFERENCES DeliveryPerson(DeliveryPersonID),
);

insert into Delivery(DeliveryID, OrderID, DeliveryPersonID, IsDelivered) values ('00111', '90001', '11101','True');
insert into Delivery(DeliveryID, OrderID, DeliveryPersonID, IsDelivered) values ('00112', '90002', '11102','False');
insert into Delivery(DeliveryID, OrderID, DeliveryPersonID, IsDelivered) values ('00113', '90003', '11103','True');
insert into Delivery(DeliveryID, OrderID, DeliveryPersonID, IsDelivered) values ('00114', '90004', '11104','False');
insert into Delivery(DeliveryID, OrderID, DeliveryPersonID, IsDelivered) values ('00115', '90005', '11105','True');

SELECT * FROM Delivery;


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
CREATE VIEW Menuu AS
SELECT m.MenuID, mi.MenuItemID, m.MenuName, mi.DishName, mi.DishDescription
FROM Menu m JOIN MenuItem mi on m.MenuID = mi.MenuID
WHERE m.MenuName IN (SELECT MenuName FROM Menu where MenuName in ('Lunch'));

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
WHERE ProductName = 'Paneer';

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

EXEC SelectAllRestaurants @city = 'Boston';

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

EXEC UpdatePayment '56702', 'Success';

---Stored Procedure 3
---Displaying the dish with Maximum Price
go
ALTER PROCEDURE Maxpricedish as
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
ALTER FUNCTION dbo.GetSales()
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
	