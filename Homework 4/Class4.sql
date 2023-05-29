-- Calculate “(price + cost) / weight” for all products.
DO $$
DECLARE
   p_price NUMERIC;
   p_cost NUMERIC;
   p_weight NUMERIC;
   result NUMERIC;
   
BEGIN   
   SELECT 
      price,cost,weight
	  into p_price,p_cost,p_weight
      FROM product;

   result := (p_price + p_cost) / p_weight;
   
   RAISE NOTICE 'Result: %',result;
   
END$$




-- Get a round number that is higher or equal for the costs and a round
-- number that is lower or equal for the prices for all products.
DO $$
DECLARE
   p_price NUMERIC;
   p_cost NUMERIC;
   result1 NUMERIC;
   result2 NUMERIC;
   
BEGIN   
   SELECT 
      price,cost
	  into p_price,p_cost
      FROM product;

   result1 := CEIL(p_cost);
   result2 := FLOOR(p_price);
   
   RAISE NOTICE 'Result1: %',result1;
   RAISE NOTICE 'Result2: %',result2;
END$$




-- Get all orders and generate a random number between 0 and 100 for
-- every order.
CREATE OR REPLACE FUNCTION get_orders_with_random_number()
RETURNS TABLE (id INT,random_number INT)
AS $$
BEGIN
  RETURN QUERY
  SELECT
    o.id,
    FLOOR(RANDOM() * 101)::INT AS random_number
  FROM
    "Order" o;
END
$$ LANGUAGE plpgsql;

SELECT * FROM get_orders_with_random_number();



-- Concatenate the name, region and zipcode from every business entity
-- and add the delimiter ‘; ‘ between them
CREATE OR REPLACE FUNCTION concat_info()
  RETURNS TABLE (result TEXT)
 AS $$
   BEGIN
     RETURN QUERY
       SELECT CONCAT(name,';',region, ';', zipcode)
       FROM businessentity;
END
$$ LANGUAGE plpgsql;

SELECT * FROM concat_info();




-- Declare temp table that will contain LastName and HireDate columns.
-- The HireDate column must not allow dates after 01.01.2010. Insert 5
-- rows of dummy data and display every row inserted.
CREATE TEMPORARY TABLE temp_table
(
  LastName VARCHAR(50),
  HireDate DATE CHECK (HireDate <= '2010-01-01')
);

INSERT INTO temp_table (LastName, HireDate)
VALUES
  ('Ingjikj', '2008-05-10'),
  ('Doe', '2009-03-15'),
  ('Smith', '2010-01-01'),
  ('LeBron', '2007-11-20'),
  ('Jordan', '2009-06-30')



-- Create a function (get_employees_hired_later_than) that will return
-- all employees that were hired after a provided date. Return the
-- following columns:
-- • The first and last name concatenated into one column with a space between
-- them. The column should be named “Full name”.
-- • The age that the employee was at the time he was employed. Column should
-- be named “Age of employee on hiring”.
-- • The national ID number concatenated with the gender, with a ‘; ‘ delimiter
-- between them.
CREATE OR REPLACE FUNCTION get_employees_hired_later_than(hire_date_input DATE)
RETURNS TABLE (full_name TEXT, age_on_hiring NUMERIC, national_id_and_gender TEXT)
AS $$
BEGIN
  RETURN QUERY
  SELECT
    CONCAT(firstName, ' ', lastName) AS full_name,
    EXTRACT(YEAR FROM AGE(hireDate, dateofbirth)) AS age_on_hiring,
    CONCAT(nationalIdNumber, '; ', gender) AS national_id_and_gender
  FROM
    employee
  WHERE
    hireDate > hire_date_input;
END
$$ LANGUAGE plpgsql;

SELECT * FROM get_employees_hired_later_than('2000-01-01')


-- Create a function (get_employee_orders) that will return all orders
-- done by a specific employee. Return the following columns:
-- • The first 3 letters of the name, the last 3 characters of the code and the full
-- description concatenated delimited with the character ‘; ‘ of the product for
-- which the order was made.
-- • The quantity of the order.
-- • The business entity name for which the order was made.



-- CREATE OR REPLACE FUNCTION get_employee_orders(employee_id_input INT)
-- RETURNS TABLE (product_info TEXT, quantity INT, business_entity_name TEXT)
-- AS $$
-- BEGIN
--   RETURN QUERY
--   SELECT
--     LEFT(p.name, 3) || '; ' || RIGHT(b.zipcode, 3) || '; ' || p.description AS product_info,
--     od.quantity:: INT,
--     b.name AS business_entity_name
--   FROM
--     "Order" o
-- 	INNER JOIN orderdetails od ON od.orderid = o.id
--     INNER JOIN product p ON od.productid = p.id
--     INNER JOIN businessentity b ON o.businessentityid = b.id
--   WHERE
--     o.employeeid = employee_id_input;
-- END
-- $$ LANGUAGE plpgsql;


-- SELECT * FROM get_employee_orders(1)


