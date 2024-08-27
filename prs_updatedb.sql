
USE master;
GO

--alter database [prs-db] set single_user with rollback immediate;

DROP Database if exists prsdb;
GO
CREATE Database prsdb;
Go
USE prsdb;
Go

-- User Table

  CREATE TABLE [User]
(   
	Id          INT              PRIMARY KEY  IDENTITY(1,1) ,
    Username    VARCHAR(20)                 not null,
    Password    VARCHAR(10)                 not null,
    FirstName   VARCHAR(20)                 not null,
	LastName    VARCHAR(20)                 not null,
	PhoneNumber VARCHAR(12)                 not null,
    Email       VARCHAR(75)                  not null,
	Reviewer     BIT                       default 0 not null,
    Admin        BIT                              default 0 not null,
    constraint uq_user_unique Unique(Username),
	constraint uq_user_person Unique(FirstName, LastName,PhoneNumber),
	constraint uq_user_email Unique(email)
	);
    



-- Vendor Table
CREATE TABLE Vendor
(
    Id        INT                       PRIMARY KEY identity (1,1),
	code      varchar(10)                    not null,
    Name      varchar(255)                   not null,
    Address    varchar(255)                  not null,
    City       varchar(255)                  not null,
    State      varchar(2)                    not null,
    Zip        varchar(5)                    not null,
    PhoneNumber VARCHAR(12)                  not null,
    email       VARCHAR(100)                       not null,
	Constraint uq_vendor_code Unique(code),
	Constraint uq_Vendor_Business Unique(Name,Address, City,State)
);

-- Product Table
CREATE TABLE Product 
(
    Id               INT            PRIMARY KEY identity (1,1),
    VendorId         INT                     not null,
    PartNumber       varchar(50)             not null,
    Name             varchar(150)            not null,
    Price            decimal(10,2)           not null,
	Unit             varchar(255)                        null,
	Photopath VARCHAR(255)  null,
    FOREIGN KEY (vendorId) REFERENCES Vendor(id),
	Constraint UQ_product_Vid_Pnum Unique(vendorId,PartNumber)
	);

-- Request Table



CREATE TABLE Request (
Id 					int 			PRIMARY KEY IDENTITY(1,1),
UserId 				int		 		not null,
Description 		varchar(100) 	not null,
Justification 		varchar(255) 	not null,
DateNeeded 			date 			null,
DeliveryMode 		varchar(25) 	not null,
Status 				varchar(20) 	not null DEFAULT 'New',
Total 				decimal(10,2) 	not null,
SubmittedDate 		datetime 		DEFAULT current_timestamp not null,
ReasonForRejection 	varchar(100) 	null,
FOREIGN KEY (UserID) REFERENCES [User](Id)
);

--Create PurchaseRequestLineItem table
CREATE TABLE LineItem(
    Id INT PRIMARY KEY Identity (1,1),
    RequestId INT  not null,
    ProductId INT not null,
    Quantity INT not null,
    FOREIGN KEY (ProductId) REFERENCES Product(ID),
    FOREIGN KEY (RequestID) REFERENCES Request(ID),
	Constraint UQ_Lineitem_Req_Prod unique (RequestID,ProductID)
);




--Insert data into table user
INSERT INTO [user] (Username,Password,FirstName,Lastname,PhoneNumber,Email,Reviewer,Admin)
VALUES
('susan123', 'friend', 'Susan','Loechle','859-782-5336', 'sue@test.com', 'True','True'),
('Fred923', 'rainbow','Fred','Hockney','423-474-7822', 'Fred@work.com)','True','True'),
('Lekha222','unicorn','Lekha','Nair','782-334-6000','Lekha@tip.com','True','True');


--insert  data into vendor table
INSERT INTO Vendor(code,Name,Address,City,state,Zip,PhoneNumber,Email)
VALUES
('46532', 'Best Buy', '100, Reach Drive','Florence','KY','32067','859-432-6078','Vendor@bestbuy.com'),
('33247', 'Walmart','230 Hanes Avenue','Union','KY','41042','783-333-6666','Vendor@walmart.com'),
( '23576', 'Amazon', '200 Hill Drive','Chicago','IL','23410', '234-226-4568','Vendor@amazon.com');



--insert data for product table
INSERT INTO Product (VendorId, PartNumber, Name, Price, Unit, Photopath)
VALUES 
(1, 'BB-P001', 'Best Buy TV 42-inch', 299.99, 'Each', 'images/bb_tv42.jpg'),
(1, 'BB-P002', 'Best Buy Laptop 15-inch', 499.99, 'Each', 'images/bb_laptop15.jpg'),
(1, 'BB-P003', 'Best Buy Headphones', 79.99, 'Each', 'images/bb_headphones.jpg'),
(1, 'BB-P004', 'Best Buy Refrigerator', 699.99, 'Each', 'images/bb_refrigerator.jpg'),
(1, 'BB-P005', 'Best Buy Microwave Oven', 99.99, 'Each', 'images/bb_microwave.jpg'),

(2, 'WM-P001', 'Walmart Smart TV 50-inch', 399.99, 'Each', 'images/wm_tv50.jpg'),
(2, 'WM-P002', 'Walmart Gaming Console', 299.99, 'Each', 'images/wm_console.jpg'),
(2, 'WM-P003', 'Walmart Blender', 49.99, 'Each', 'images/wm_blender.jpg'),
(2, 'WM-P004', 'Walmart Vacuum Cleaner', 149.99, 'Each', 'images/wm_vacuum.jpg'),
(2, 'WM-P005', 'Walmart Coffee Maker', 89.99, 'Each', 'images/wm_coffeemaker.jpg'),

(3, 'AMZ-P001', 'Amazon Echo Dot', 29.99, 'Each', 'images/amz_echo.jpg'),
(3, 'AMZ-P002', 'Amazon Kindle Paperwhite', 129.99, 'Each', 'images/amz_kindle.jpg'),
(3, 'AMZ-P003', 'Amazon Fire Stick', 39.99, 'Each', 'images/amz_firestick.jpg'),
(3, 'AMZ-P004', 'Amazon Security Camera', 89.99, 'Each', 'images/amz_camera.jpg'),
(3, 'AMZ-P005', 'Amazon Ring Doorbell', 99.99, 'Each', 'images/amz_ring.jpg'),

(1, 'BB-P006', 'Best Buy Washing Machine', 499.99, 'Each', 'images/bb_washingmachine.jpg'),
(2, 'WM-P006', 'Walmart Portable AC', 199.99, 'Each', 'images/wm_portableac.jpg'),
(3, 'AMZ-P006', 'Amazon Smart Plug', 24.99, 'Each', 'images/amz_smartplug.jpg'),
(1, 'BB-P007', 'Best Buy Dishwasher', 399.99, 'Each', 'images/bb_dishwasher.jpg'),
(2, 'WM-P007', 'Walmart Air Fryer', 89.99, 'Each', 'images/wm_airfryer.jpg');


--Insert data in request table
INSERT INTO Request (UserId, Description, Justification, DateNeeded, DeliveryMode, Status, Total, SubmittedDate, ReasonForRejection)
VALUES 
(1, 'Laptop Purchase', 'Need a new laptop for work from home', '2024-09-10', 'Delivery', 'New', 499.99, '2024-08-26 10:15:00', NULL),
(2, 'Webcam Purchase', 'Required for video conferencing', '2024-09-12', 'Pickup', 'New', 79.99, '2024-08-26 11:00:00', NULL),
(3, 'Printer Purchase', 'Replacing old printer for office use', '2024-09-15', 'Delivery', 'New', 129.99, '2024-08-26 12:30:00', NULL);


---insert data in Lineitem Table
INSERT INTO LineItem (RequestId, ProductId, Quantity)
VALUES 
(1, 2, 1),  -- Best Buy Laptop 15-inch (Laptop Purchase by Susan)
(2, 3, 1),  -- Best Buy Headphones (Substituting as a webcam purchase by Fred)
(3, 12, 1);  -- Amazon Kindle Paperwhite (Substituting as a printer purchase by Lekha)



