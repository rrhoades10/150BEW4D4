-- DDL Data Definition Language
-- Anything that has to do with defining the shape of our database - creating the db, creating tables, creating columns, modifying column types, constraints 
-- creating a shape for our data to take 
-- all mySQL statements/commands end with a semicolon
CREATE DATABASE e_commerce_db; 

-- selecting the database for use
USE e_commerce_db; 
-- tells the current query tool which database we're working with

-- creating tables 
-- CREATE TABLE table_name (column_name column_type column_constraints) 
CREATE TABLE Customers (
	customer_id INT AUTO_INCREMENT PRIMARY KEY, -- by default primary key is not null and unique
    name VARCHAR(150) NOT NULL,
    email VARCHAR(150),
    phone VARCHAR(15)
	
);

-- create orders which has a FOREIGN KEY - creating a relationship between customers and orders 
CREATE TABLE Orders (
	order_id INT AUTO_INCREMENT PRIMARY KEY,
    date DATE NOT NULL,
    customer_id INT,
    -- Adding the FOREIGN KEY constraint to a column and tying it to the primary key of the customer table
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id) 
); 

-- altering existing tables - add a column 
ALTER TABLE Customers 
ADD phone VARCHAR(15); -- adds a column called phone to the Customers table

-- modify columns within a table - change their types/constraints/ rename
 ALTER TABLE Customers
 MODIFY email VARCHAR(200);


-- deleting tables, columns, and entire databases 

-- a database
-- DROP DATABASE ObsoleteDatabase;
-- drop a table
-- DROP TABLE Reviews; -- if we found we werent collecting enough reviews we could remove the unnecessary table
-- dropping a column 
-- ALTER TABLE customers
-- DROP COLUMN address

-- DML - Data Manipulation Languate
-- anythign that has to do with tangibly working with the data
-- INSERT, UPDATE, DELETE -> data  

-- adding data to the customer table 
INSERT INTO Customers (name, email, phone)
VALUES ('Obi Wan Kenobi', 'oleben@gmail.com', '6307894561');

-- brief preview of DQL - SELECT statement
SELECT * FROM Customers;

-- Insert a NULL Value into email
INSERT INTO Customers (name, email, phone)
VALUES ('Mace Windu', "thepurp@gmail.com", '3127539512');

-- ommitting a column entirely 
INSERT INTO Customers (name, email, phone)
VALUES ('Ki Adi Mundi', "big.forehead@gmail.com", '6307894561');

-- INSERT several values with one insert statement
INSERT INTO Customers (name, email, phone)
VALUES ("Luke Skywalker", "skywalker@yahoo.com", "7894561230"),
("Plo Koon", "lillgreenman@gmail.com", "78946543258");

-- UPDATE A ROW's Email 
 -- its always best to specidy by the Primary Key - its going to give you a unique row of data 
UPDATE Customers
SET email = "thepurp@gmail.com"
 --  sets a condition to update the specified data
WHERE customer_id = 2;
 
SELECT * FROM Customers;
 
UPDATE Customers
SET email = "big.forehead@gmail.com"
 --  sets a condition to update the specified data
WHERE customer_id = 3; -- how we find a row

-- ALTER TABLE Customers
-- ADD COLUMN occupation VARCHAR(150);

-- -- we cannot make mass updates without turning off SQL_SAFE_UPDATES 
-- -- turn off SQL_SAFE_UPDATES
-- SET SQL_SAFE_UPDATES = 0; -- value for false  
-- UPDATE Customers
-- SET occupation = "Jedi";
-- SET SQL_SAFE_UPDATES = 1;

-- ALTER TABLE Customers
-- DROP COLUMN occupation;


-- deleting a row of data
DELETE FROM Customers
WHERE customer_id = 5;

SELECT * FROM Customers;

-- if we try to delete by anything other than primary key - we need to turn off SQL_SAFE_UPDATES 
DELETE FROM Customers
WHERE name = "Ahsoka Tano"; -- gives an error becuase of the SQL_SAFE_UPDATES

SET SQL_SAFE_UPDATES = 0; -- turns it off by setting it to a false value of 0
DELETE FROM Customers
WHERE name = "Ahsoka Tano";
SET SQL_SAFE_UPDATES = 1; -- turn it back on when we're done so we dont make any oopsies


-- DQL - Data Query Language

-- SELECT specify the columns we're querying
-- FROM specify the table we're querying
-- selecting all columns from the customer table 
SELECT * FROM CUSTOMERS;

-- naming the columns we want to retrieve 
SELECT name, email
FROM Customers;

-- specify row or rows of data to retrieve
-- can specify by any column 
SELECT *
FROM Customers
WHERE customer_id = 1;

SELECT *
FROM Customers
WHERE name = "Kit Fisto";

-- combine clauses with AND
SELECT *
FROM Customers 
WHERE name = "Obi Wan Kenobi" AND email = "oleben@gmail.com"; -- both clauses in the WHERE must be True to find the corresponding data

-- OR - only one thing in the WHERE clause needs to be True 
SELECT * 
FROM Customers
WHERE name = "Obi Wan Kenobi" OR name = "Mace Windu";

SELECT * 
FROM Customers
WHERE name = "Obi Wan Kenobi" OR email = "oldben@gmail.com";

-- excluding rows of data
SELECT *
FROM Customers
WHERE NOT name = "Yoda"; 

-- ORDER BY - orders the results
--  by default it orders (sorts) in Ascending order
-- ASC or DESC
SELECT * 
FROM Customers
ORDER BY name ASC; -- default to ascending order ASC

SELECT *
FROM Customers
ORDER BY customer_id DESC; -- orders in descending order

-- DISTINCT eliminate redudancies in our results 
SELECT DISTINCT name
FROM Customers;

-- Finding partial matches in data with the WHERE clause
-- WHERE and LIKE % - wildcard
SELECT * 
FROM Customers
-- finds names that start with K and end with i
WHERE name LIKE "K%i";

-- searchign for specific email domains
SELECT *
FROM Customers
WHERE email LIKE "%gmail.com"; -- returns results for everybody with the gmail.com email domain


-- using WHERE and IN to find several rows of Data
SELECT * 
FROM Customers
WHERE customer_id IN (10, 11, 12); 

-- WHERE and BETWEEN  
SELECT *
FROM Customers
WHERE customer_id BETWEEN 1 and 10;

-- MIN() and MAX() - return the large value from specified column
SELECT MIN(customer_id)
FROM Customers; 

SELECT MAX(customer_id)
FROM Customers; 

SELECT MAX(name)
FROM Customers; -- Yoda cause Y

-- COUNT - return the total number of rows
SELECT COUNT(*)
FROM Customers; 

-- count unique instances of a row with a column
SELECT COUNT(DISTINCT name)
FROM Customers; 

SELECT * FROM Customers;
-- INSERTING INTO our Orders Table
INSERT INTO Orders(date, customer_id)
VALUES ('2024-06-27', 1),
('2024-05-16', 1),
('2024-04-16', 1),
('2024-03-16', 8),
('2024-02-16', 10),
('2024-01-16', 10);

SELECT * 
FROM Orders;

-- GRABBING INFORMATION FROM MORE THAN ONE TABLE WHERE THE PRIMARY KEY MATCHES THE FOREIGN KEY 
SELECT order_id, date, Customers.customer_id, name, email -- if we have columns that exist within both tables, we need to specify which table we want to pull that column from
FROM Customers, Orders
WHERE customerS.customer_id = orders.customer_id;

-- Using a join to grab information from both tables - connect on the primary and foreign keys
SELECT Orders.customer_id, name, email, order_id, date
FROM Customers
JOIN Orders
ON Orders.customer_id = Customers.customer_id;

 
















