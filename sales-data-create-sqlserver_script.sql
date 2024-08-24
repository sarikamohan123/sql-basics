USE MASTER;
GO

DROP DATABASE IF EXISTS SALESDB;
GO


CREATE DATABASE SALESDB;
GO

USE SALESDB;
GO

--select * from Sales_Denormalized

---delete from customer
---delete from SalesPerson;

CREATE TABLE Sales_Denormalized (
	Id int PRIMARY KEY IDENTITY(1,1),
	SalesPersonId int NOT NULL,
	SalesPersonFirstName varchar(25) NOT NULL,
	SalesPersonLastName varchar(25) NOT NULL,
	Region varchar(20) NOT NULL,
	SalesDate date NOT NULL,
	SalesAmount decimal(10,2),
	Customer varchar(50)
)

create table region (
id int Primary key identity (1,1),
Name  varchar(15) not null
);

--insert data in region
Insert into region (Name)
Select distinct region
From Sales_Denormalized;

Create table customer(
id int Primary key identity (1,1),
Name varchar (20) not null
);

--insert data in customer
Insert into customer(Name)
select distinct customer
from Sales_Denormalized;

create table SalesPerson(
id  int Primary key identity (1,1),
Firstname varchar(20) not null,
Lastname varchar (20) not null,
Regionid int not null,
foreign key (regionid) references region(id)
);

---insert into salesperson
insert into SalesPerson (Firstname , Lastname, Regionid)
select distinct sd.SalesPersonFirstName,sd.SalesPersonLastName, R.id
from Sales_Denormalized SD
join region R on SD.Region = R.Name;




CREATE TABLE Sales (
	Id int PRIMARY KEY IDENTITY(1,1),
	SalesPersonId int NOT NULL,
	SalesDate date NOT NULL,
	SalesAmount decimal(10,2),
	Customerid int,
	FOREIGN KEY (SalesPersonId) REFERENCES SalesPerson(Id),
	FOREIGN KEY (CustomerId) REFERENCES Customer(Id)
);
--insert into sales



