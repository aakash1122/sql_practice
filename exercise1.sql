--@drop all TABLES
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS manufacturers;

--@block create table
create table Manufacturers (
  m_code INT GENERATED ALWAYS AS IDENTITY ,
  name VARCHAR(40) NOT NULL,
  PRIMARY KEY(m_code)
);

--@block show manufacturer TABLE
SELECT * FROM manufacturers;

--@block create table
create table Products (
  p_code  INT GENERATED ALWAYS AS IDENTITY ,
  name VARCHAR(40) NOT NULL,
  price REAL NOT NULL,
  m_code INT,
  PRIMARY KEY(p_code),
  FOREIGN KEY(m_code) 
	  REFERENCES Manufacturers(m_code)
);

--@block insert DATA
INSERT INTO Manufacturers(name) VALUES('Sony');
INSERT INTO Manufacturers(name) VALUES('Creative Labs');
INSERT INTO Manufacturers(name) VALUES('Hewlett-Packard');
INSERT INTO Manufacturers(name) VALUES('Iomega');
INSERT INTO Manufacturers(name) VALUES('Fujitsu');
INSERT INTO Manufacturers(name) VALUES('Winchester');

INSERT INTO Products(name,price,m_code) VALUES('Hard drive',240,5);
INSERT INTO Products(name,price,m_code) VALUES('Memory',120,6);
INSERT INTO Products(name,price,m_code) VALUES('ZIP drive',150,4);
INSERT INTO Products(name,price,m_code) VALUES('Floppy disk',5,6);
INSERT INTO Products(name,price,m_code) VALUES('Monitor',240,1);
INSERT INTO Products(name,price,m_code) VALUES('DVD drive',180,2);
INSERT INTO Products(name,price,m_code) VALUES('CD drive',90,2);
INSERT INTO Products(name,price,m_code) VALUES('Printer',270,3);
INSERT INTO Products(name,price,m_code) VALUES('Toner cartridge',66,3);
INSERT INTO Products(name,price,m_code) VALUES('DVD burner',180,2);

--@block Select the names of all the products in the store.
SELECT name from products;

--@block Select the names and the prices of all the products in the store.
SELECT name,price FROM products;

--@block . Select the name of the products with a price less than or equal to $200.
SELECT name,price FROM products WHERE price <= 200;

--@block Select all the products with a price between $60 and $120.
SELECT * FROM products WHERE price BETWEEN 60 AND 120;

--@BLOCK Select the name and price in cents (i.e., the price must be multiplied by 100).
SELECT name,price*100 AS price_in_cent FROM products;

--@block Compute the average price of all the products. 

SELECT AVG(price) from products;

--@block Compute the average price of all products with manufacturer code equal to 2.
-- SELECT AVG(price) from manufacturers LEFT JOIN products ON
-- manufacturers.m_code = products.m_code 
-- WHERE manufacturers.m_code = 2;
SELECT AVG(price) from products where m_code = 2;

--@block Compute the number of products with a price larger than or equal to $180.
SELECT COUNT(*) from products 
where price >= 180
;

--@block Select the name and price of all products with a price larger than or equal to $180, and sort first by price (in descending order), and then by name (in ascending order).
SELECT name,price from products 
where price >= 180
ORDER BY price desc, name ASC;

--@block Select all the data from the products, including all the data for each product's manufacturer. 
SELECT * from manufacturers 
INNER JOIN products 
on manufacturers.m_code = products.m_code;
/* Without INNER JOIN */
 SELECT * FROM Products, Manufacturers
   WHERE Products.m_code = manufacturers.m_code;

--@block  Select the product name, price, and manufacturer name of all the products.
SELECT products.name,price,manufacturers.name AS manufacturer from products INNER join manufacturers on products.m_code = manufacturers.m_code;

--@block Select the average price of each manufacturer's products, showing only the manufacturer's code.
SELECT AVG(price),m_code from products GROUP BY m_code;

--@block Select the average price of each manufacturer's products, showing the manufacturer's name.
SELECT AVG(products.price), manufacturers.name from manufacturers 
LEFT JOIN products 
ON manufacturers.m_code = products.m_code
GROUP BY manufacturers.m_code;

--@block Select the names of manufacturer whose products have an average price larger than or equal to $150.
SELECT Manufacturers.name,AVG(price) from Manufacturers 
LEFT JOIN Products 
on products.m_code = Manufacturers.m_code
where price>= 150
GROUP BY Manufacturers.name;

--@block Select the name and price of the cheapest product.
 SELECT name, price FROM products 
  ORDER BY PRICE LIMIT 1;

--@BLOCK Select the name of each manufacturer along with the name and price of its most expensive product.
SELECT Manufacturers.name, products.name, products.price from manufacturers left join products 
on manufacturers.m_code = products.m_code
ORDER BY price desc limit 1


--@block Select the name of each manufacturer which have an average price above $145 and contain at least 2 different products.

select manufacturers.name, price from manufacturers
left join products
on manufacturers.m_code = products.m_code
GROUP BY Manufacturers.name
-- HAVING AVG(price) >= 180
