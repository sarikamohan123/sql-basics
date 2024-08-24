Use master
Go
drop database if exists BMDB;

Go

--Create Database BMDB

create database BMDB;
Go

Use BMDB
Go

---create table Movie

Create table Movie (
	Id       int               PRIMARY KEY IDENTITY(1,1),
	title    varchar (100)      not null,
	year     int                 not null,
	rating   varchar(5)          not null,
	director varchar(255)        not null,
	constraint UQ_Movie_title_year unique(Title, Year)
);

---create table Actor
Create table Actor (
	Id int PRIMARY KEY IDENTITY(1,1),
	Firstname varchar (50) not null,
	Lastname varchar (50) not null,
	Gender varchar (1) not null,
	Birthdate date not null
	Constraint UQ_Actor_fn_ln_bd unique(Firstname, Lastname,Birthdate)
);


--create table credit
Create table Credit (
	Id          int                        PRIMARY KEY IDENTITY(1,1),
	movieID     int                           not null,
	ActorID     int                          not null,
	Role        varchar(255)                   not null,
    FOREIGN KEY (movieId) REFERENCES movie(Id),
	FOREIGN KEY (ActorId) REFERENCES Actor(Id),
	constraint UQ_Credit_Movie_Actor Unique(movieid, actorid)
);

--BMDB crud stuff

--Insert into table Movie
 Insert into Movie(title,year,rating,director)
 Values
 ('The Pursuit Of Happyness',2006,'PG-13','Gabriele Muccino');


 ---Insert Actor information inthe table Actor

 Insert into Actor( Firstname,Lastname,Gender,Birthdate)
 values
 ('Will','Smith','M','1968-09-25');

 --Insert values into table Credit
 Insert into Credit( movieID,ActorID,Role)
 values(1,1,'Chris Gardner');




	