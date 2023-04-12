
use Final_Project
go

Select City from Address where AddressID = '10100';

SELECT FirstName FROM Customer where AddressID = '10002'

SELECT RestaurantName from Restaurant where RestaurantID = '30499'

SELECT MenuName FROM Menu where RestaurantID = '30010'

SELECT DishPrice FROM MenuItem where DishType = 'Appetizer'

SELECT ProductName, CostPrice FROM Product where ProductId = '60411'

SELECT SupplierFirstName FROM Supplier where SupplierState = 'MA'

SELECT SupplyDate FROM Supply where RestaurantID = '30001'

Select OrderDate, RestaurantID from [Order] where CustomerID = '20009'

SELECT OrderItemID, OrderQuantity FROM OrderItem where OrderID = '90004'

SELECT PaymentAmount, IsSuccessful FROM Payment where PaymentID = '57001'

SELECT FirstName FROM DeliveryPerson where DeliveryPersonID = '11111'

Select IsDelivered, OrderID from Delivery where DeliveryID = '10111'


---View 1
GO
SELECT OrderID, IsSuccessful FROM Paymenttt;

---View 2
go
SELECT DishName FROM Menuu;


---view 3
go
SELECT OrderID, RestaurantName FROM odr where IsDelivered = 'True';

---view 4
go
SELECT SupplierID, SupplierFirstName FROM sps;

---view 5
go
Select FirstName, email_encrypt from cdetails

---Stored Procedure 1
---Selecting all restaurants in the city Ashleytown
EXEC SelectAllRestaurants @city = 'Ashleytown';

---Stored Prodcedure 2
---Updating the payment status with PaymentID
EXEC UpdatePayment '56701', 'Success';


---Stored Procedure 3
---Displaying the dish with Maximum Price

EXEC Maxpricedish;


---UDF 1
---calculate sales

go
SELECT dbo.GetSales() as totalorders


---Trigger
---once the delivery status changes to true, the restaurant can be sent a notification that the order is delivered
go
UPDATE Delivery
SET IsDelivered = 'True'
WHERE DeliveryID = '10113';

---Column data encryption
---encrypt delivery person's emailid

OPEN SYMMETRIC KEY SymKey_test
	DECRYPTION BY CERTIFICATE CustPass;

Select email_encrypt, CONVERT(varchar, DECRYPTBYKEY(email_encrypt)) AS decrypted from Customer

CLOSE SYMMETRIC KEY SymKey_test;


---Non-clustered index - 1
---to find orders using customerID
Select name, type_desc
from sys.indexes
Where object_id = OBJECT_ID('[Order]')
and type_desc = 'NONCLUSTERED';

---Non-clustered index - 2
---to find orders of a restaurant using restaurantid
Select name, type_desc
from sys.indexes
Where object_id = OBJECT_ID('[Order]')
and type_desc = 'NONCLUSTERED';

---Non-clustered index - 3
---Orderid and payment
Select name, type_desc
from sys.indexes
Where object_id = OBJECT_ID('Payment')
and type_desc = 'NONCLUSTERED';
	
