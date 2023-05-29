-- Find all Employees with FirstName = Antonio
SELECT * FROM employee
WHERE firstname = 'Antonio'


-- Find all Employees with DateOfBirth greater than ‘01.01.1979’
SELECT * FROM employee
WHERE dateofbirth > '01.01.1979'


-- Find all Male Employees
SELECT * FROM employee
WHERE gender = 'M'


-- Find all Employees with LastName starting With ‘T’
SELECT * FROM employee
WHERE lastname LIKE 'T%' 


-- Find all Employees hired in January/1988
SELECT * FROM employee
WHERE hiredate BETWEEN '1988-01-01' AND '1988-01-30'


-- Find all Employees with LastName starting With ‘J’ hired in January/1988

SELECT * FROM employee
WHERE lastname LIKE 'J%' AND
hiredate BETWEEN '1988-01-01' AND '1988-01-30'


-- Find all Employees with FirstName = Antonio ordered by Last Name
SELECT * FROM employee
WHERE firstname = 'Antonio'
ORDER BY lastname 



-- List all Employees ordered by FirstName
SELECT * FROM employee
WHERE gender = 'M'
ORDER BY firstname



-- Find all Male employees ordered by HireDate, starting from the last hired
SELECT * FROM employee
WHERE gender = 'M'
ORDER BY hiredate DESC



--  List all Business Entity region and Customer region names in single result set WITH duplicates
SELECT region
FROM businessentity
UNION ALL
SELECT regionname
FROM customer



-- List all Business Entity region and Customer region names in single result set WITHOUT duplicates
SELECT region
FROM businessentity
UNION
SELECT regionname
FROM customer



-- List all common region names between Business Entities and Customers
SELECT region
FROM businessentity
INTERSECT
SELECT regionname
FROM customer




-- Provide create table script for the Order table where it won’t allow an orderDate before 01.01.2010
CREATE TABLE IF NOT EXISTS task1 (
	orderDate date CHECK (orderDate > '01.01.2010')
)



-- Provide create table script for the Product table where the price will 
-- always be AT LEAST 20% higher than the cost
CREATE TABLE IF NOT EXISTS TEST (
	cost INT,
	price INT CHECK (price > cost * 1.2)
)


-- Provide create table script for the Product table where all description
-- values will be UNIQUE
CREATE TABLE IF NOT EXISTS Product (
	description varchar(500) UNIQUE
)




-- Create Foreign key constraints for the Order table with script
CREATE TABLE IF NOT EXISTS Order (
	customer_id INT,
	FOREIGN KEY (customer_id) REFERENCES customer(id)
)



-- List all possible combinations of Customer names and Product names
-- that can be ordered from a specific customer
SELECT c.name, p.name
FROM customer c
JOIN product p ON c.id = p.id
WHERE c.id = 1;




-- List all Business Entities that has any order
SELECT b.name
FROM "Order" o
INNER JOIN businessentity b ON o.businessentityid = b.id



-- List all Business Entities without orders
SELECT b.name
FROM businessentity b
LEFT JOIN "Order" o ON b.id = o.businessentityId
WHERE o.businessentityId IS NULL;



-- List all Customers without orders (using Right Join and using Left join)
SELECT c.name
FROM customer c
RIGHT JOIN "Order" o ON o.customerId = c.id
WHERE o.customerId IS NULL;
