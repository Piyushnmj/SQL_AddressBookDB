--UC1
Create Database AddressBookDB
use AddressBookDB

--UC2
Create Table Address_Book_Table
(
	FirstName varchar(50) not null,
	LastName varchar(100) not null,
	Address varchar(300) not null,
	City varchar(80) not null,
	State varchar(100) not null,
	ZipCode int not null,
	PhoneNumber bigint not null unique,
	Email varchar(200) not null unique
)
Select * From Address_Book_Table
Exec sp_help 'Address_Book_Table'

--UC3
Insert into Address_Book_Table (FirstName,LastName,Address,City,State,ZipCode,PhoneNumber,Email) 
values('Bill','Gates','Somewhere','New York','USA',402034,9009001234,'billG01@gmail.com')
Insert into Address_Book_Table (FirstName,LastName,Address,City,State,ZipCode,PhoneNumber,Email) 
values('Donald','Trumph','White House','Washington DC','USA',413508,9009005678,'donald.T@gmail.com')
Insert into Address_Book_Table (FirstName,LastName,Address,City,State,ZipCode,PhoneNumber,Email) 
values('Barack','Obama','Somewhere in America','Manhatten','USA',413508,9009005678,'barack.ObamaB@gmail.com')
Insert into Address_Book_Table (FirstName,LastName,Address,City,State,ZipCode,PhoneNumber,Email)
values('Virat', 'Kohli', 'Somewhere in Mumbai', 'Mumbai', 'Maharashtra', 400002, 9099990999,'vKohli@gmail.com')


--UC4
Update Address_Book_Table Set FirstName = 'Joe', LastName = 'Biden' Where FirstName = 'Donald'
Update Address_Book_Table Set PhoneNumber = 9009016789, Email = 'joe.Biden02@gmail.com' Where FirstName = 'Joe'

--UC5
Delete Address_Book_Table Where FirstName = 'Virat'

--UC6
Select * from Address_Book_Table Where City = 'New York' or  State = 'USA'
Select * from Address_Book_Table Where City = 'New York' and  State = 'USA'

--UC7
Select Count(*) As Size from Address_Book_Table Where City = 'New York' or  State = 'USA'
Select Count(*) As Size from Address_Book_Table Where City = 'New York' and  State = 'USA'

--UC8
Select * from Address_Book_Table Where City = 'New York' Order By FirstName asc

--UC9
ALTER TABLE Address_Book_Table ADD AdressBookName varchar(50), Type varchar(20)
UPDATE  Address_Book_Table SET AdressBookName = 'FamilyAddressBook', Type = 'Family' 
WHERE FirstName ='Joe' or FirstName='JoeII'
UPDATE  Address_Book_Table SET AdressBookName = 'FriendAddressBook', Type = 'Friend' 
WHERE FirstName ='Barack' or FirstName='Donald'
Update Address_Book_Table SET AdressBookName = 'ProfessionAddressBook', Type = 'Profession'
WHERE FirstName = 'Bill' or FirstName = 'Elon'

--UC10
Select COUNT(*) as Size, Type from Address_Book_Table group by Type;
Select count(*)as CountAbNames, AdressBookName  from Address_Book_Table group by AdressBookName;

--UC11
Insert into Address_Book_Table(FirstName, LastName, Address, City, State, ZipCode, PhoneNumber, Email, AdressBookName, Type) 
Values('Elon','Musk','TeslaInc','California','USA',413508,88562365122,'musk_elon@gmail.com','ProfessionAddressBook','Profession')
select * from Address_Book_Table

--UC12
--Create AddressBook Table
CREATE TABLE AddressBook
(
AddressBookId INT IDENTITY(1,1) PRIMARY KEY,
AddressBookName VARCHAR(30)
)

--Create PersonsTypes Table
CREATE TABLE PersonTypes
(
PersonTypeId INT IDENTITY(1,1) PRIMARY KEY,
PersonType varchar(50),
)

--Create Persons Table
CREATE TABLE Person
(
PersonId INT IDENTITY(1,1) PRIMARY KEY,
AddressBookId INT FOREIGN KEY REFERENCES AddressBook(AddressBookId),
FirstName varchar(30),
LastName varchar(30),
Address varchar(30),
City varchar(30),
StateName varchar(30),
ZipCode int,
PhoneNumber bigint,
EmailId varchar(30)
)

CREATE TABLE PersonTypesMap
(
PersonId INT FOREIGN KEY REFERENCES Person(PersonId),
PersonTypeId INT FOREIGN KEY REFERENCES PersonTypes(PersonTypeId)
)

--Insert Values into address books
INSERT INTO AddressBook VALUES ('Bill'),('Donald');
SELECT * FROM AddressBook

--Insert values in persons type
INSERT INTO PersonTypes VALUES ('Family'),('Friend'),('Profession');
SELECT * FROM PersonTypes

---Insert Values into Persons
INSERT INTO Person 
VALUES (1,'Donald','Trumph','White House','Washington DC','USA',413508,9009005678,'donald.T@gmail.com')
INSERT INTO Person 
VALUES (1,'Bill','Gates','Somewhere','New York','USA',402034,9009001234,'billG01@gmail.com'),
(2,'Barack','Obama','Somewhere in America','Manhatten','USA',413508,9009005678,'barack.ObamaB@gmail.com')
INSERT INTO Person 
VALUES (1,'Virat', 'Kohli', 'Somewhere in Mumbai', 'Mumbai', 'Maharashtra', 400002, 9099990999,'vKohli@gmail.com')
SELECT * FROM Person

--Insert into persons type map tables
INSERT INTO PersonTypesMap VALUES (1,1),(2,2),(3,3),(4,1)
SELECT * FROM PersonTypesMap

--Retrive All Data
SELECT ab.AddressBookId,ab.AddressBookName,p.PersonId,p.FirstName,p.LastName,p.Address,p.City,p.StateName,p.ZipCode,
p.PhoneNumber,p.EmailId,pt.PersonType,pt.PersonTypeId 
FROM AddressBook AS ab 
INNER JOIN Person AS p ON ab.AddressBookId = p.AddressBookId
INNER JOIN PersonTypesMap as ptm On ptm.PersonId = p.PersonId
INNER JOIN PersonTypes AS pt ON pt.PersonTypeId = ptm.PersonTypeId

--UC13
--Retrieve based on city and state--
SELECT ab.AddressBookId,ab.AddressBookName,p.PersonId,p.FirstName,p.LastName,p.Address,p.City,p.StateName,p.ZipCode,
p.PhoneNumber,p.EmailId,pt.PersonType,pt.PersonTypeId 
FROM AddressBook AS ab 
INNER JOIN Person AS p ON ab.AddressBookId = p.AddressBookId AND (p.City='Washingtone DC' OR p.StateName='USA')
INNER JOIN PersonTypesMap as ptm On ptm.PersonId = p.PersonId
INNER JOIN PersonTypes AS pt ON pt.PersonTypeId = ptm.PersonTypeId

--Count based on city---
Select Count(*) As Count,StateName,City from Person group by StateName,City

--Sort based on first name
SELECT ab.AddressBookId,ab.AddressBookName,p.PersonId,p.FirstName,p.LastName,p.Address,p.City,p.StateName,p.ZipCode,
p.PhoneNumber,p.EmailId,pt.PersonType,pt.PersonTypeId 
FROM AddressBook AS ab 
INNER JOIN Person AS p ON ab.AddressBookId = p.AddressBookId
INNER JOIN PersonTypesMap as ptm On ptm.PersonId = p.PersonId
INNER JOIN PersonTypes AS pt ON pt.PersonTypeId = ptm.PersonTypeId ORDER BY p.FirstName asc

--Retreive based on person types---
SELECT COUNT(ptm.PersonTypeId) as Relations,pt.PersonType FROM
PersonTypesMap AS ptm 
INNER JOIN PersonTypes as pt On pt.PersonTypeId = ptm.PersonTypeId
INNER JOIN Person as p ON p.PersonId = ptm.PersonId GROUP BY Ptm.PersonTypeId,pt.PersonType