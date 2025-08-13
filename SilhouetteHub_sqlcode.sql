-- Show all the available database.
SHOW DATABASES;

-- Drop the data base if it already exists 
DROP DATABASE SilhouetteHub;

-- create the database
CREATE DATABASE SilhouetteHub;
USE SilhouetteHub;

--  SUPPLIERS Table
CREATE TABLE SUPPLIERS (
    SupplierID INT PRIMARY KEY,
    SupplierName VARCHAR(50),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    StreetAddress VARCHAR(100),
    City VARCHAR(50),
    State VARCHAR(50),
    Zip INT
);

--  PRODUCTS Table
CREATE TABLE PRODUCTS (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(100),
    Price DECIMAL(10,2)
);

-- PRODUCT_SUPPLIERS (junction table)
CREATE TABLE PRODUCT_SUPPLIERS (
    ProductSupplierID INT PRIMARY KEY,
    ProductID INT,
    SupplierID INT,
    FOREIGN KEY (ProductID) REFERENCES PRODUCTS(ProductID)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (SupplierID) REFERENCES SUPPLIERS(SupplierID)
        ON DELETE CASCADE ON UPDATE CASCADE
);

--  CUSTOMERS Table
CREATE TABLE CUSTOMERS (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    StreetAddress VARCHAR(100),
    City VARCHAR(50),
    State VARCHAR(50),
    Zip INT
);

-- ORDERS Table
CREATE TABLE ORDERS (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    TotalPrice DECIMAL(10,2),
    FOREIGN KEY (CustomerID) REFERENCES CUSTOMERS(CustomerID)
        ON DELETE SET NULL ON UPDATE CASCADE
);

-- 6. ORDER_ITEMS Table
CREATE TABLE ORDER_ITEMS (
    OrderItemID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    TotalPrice DECIMAL(10,2),
    FOREIGN KEY (OrderID) REFERENCES ORDERS(OrderID)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (ProductID) REFERENCES PRODUCTS(ProductID)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

-- 7. INVENTORY Table
CREATE TABLE INVENTORIES (
    InventoryID INT PRIMARY KEY,
    ProductID INT,
    StockQuantity INT,
    ReorderLevel INT,
    FOREIGN KEY (ProductID) REFERENCES PRODUCTS(ProductID)
        ON DELETE SET NULL ON UPDATE CASCADE
);

-- Insert data into SUPPLIERS --
INSERT INTO SUPPLIERS VALUES
(1, 'Mohan Cloth Store', 'mohancstore@gmail.com', '6574893674', '14 Shree Nagar Society', 'Godhra', 'Gujarat', 389001),
(2, 'Jyoti Enterprise', 'jyotienterprise@gmail.com', '1446794567', '72 Diamond Textile Road', 'Surat', 'Gujarat', 302001),
(3, 'Gayatri Garments', 'gayatrig@yahoo.com', '9834581065', '36 Amer Fort Avenue', 'Jaipur', 'Rajasthan', 482001),
(4, 'Hari Om Fashion', 'hariomfashion@gmail.com', '5076298730', '88 Sabarmati Riverfront Rd', 'Ahmedabad', 'Gujarat', 370001),
(5, 'Shri Hari Textile', 'shriharitextile@hotmail.com', '5902658923', '29 Sinhagad Hills View', 'Pune', 'Maharashtra', 413229),
(6, 'Jignesh Hosieri', 'jignesgh@gmail.com', '7608904567', '12 Kalawad Main Street', 'Rajkot', 'Gujarat', 171001),
(7, 'Hemant Garment', 'hgarmet@outlook.com', '8080657463', '53 Marina Promenade Rd', 'Chennai', 'Tamilnadu', 600001),
(8, 'Shakti Saree Center', 'shaktisareecenter@gmail.com', '7485200349', '67 Ganga Ghat Lane', 'Varanasi', 'Uttar Pradesh', 500001),
(9, 'Shakti Enterprise', 'shaktienterprise@gmail.com', '7107456293', '22 Mehrangarh Fort Road', 'Jodhpur', 'Rajasthan', 800001),
(10, 'Hari Krushna Saree Center', 'harikrushnasaree@outlook.com', '9086473819', '11 Connaught Place Avenue', 'Delhi', 'Delhi', 781001),
(11, 'Anjali Saree Center', 'anjalisareec@yahoo.com', '9237845012', '45 Rose Garden Sector 17', 'Chandigarh', 'Punjab', 335009),
(12, 'Soham Sarees', 'sohamsarees@hotmail.com', '8950763109', '91 Lakshmi Vilas Palace Rd', 'Vadodara', 'Gujarat', 212011);

-- Insert data into PRODUCTS --
INSERT INTO PRODUCTS (ProductID, ProductName, Category, Price) VALUES
(101, 'Saree', 'Women', 2000.00),
(102, 'Kurti', 'Women', 1000.00),
(103, 'Shirt', 'Men', 600.00),
(104, 'Jeans', 'Men', 700.00),
(105, 'Pyjama', 'Women', 550.00),
(106, 'Tshirt', 'Men', 500.00),
(107, 'Night Dress', 'Women', 1200.00),
(108, 'Frocks', 'Women', 1000.00),
(109, 'Dupattas', 'Women', 500.00),
(110, 'Sherwanis', 'Men', 5000.00),
(111, 'Shawls', 'Men', 400.00),
(112, 'Kurta', 'Men', 6000.00);

-- Insert data into PRODUCT_SUPPLIERS --
INSERT INTO PRODUCT_SUPPLIERS (ProductSupplierID, ProductID, SupplierID) VALUES
(1011, 101, 1),
(1022, 102, 2),
(1033, 103, 3),
(1044, 104, 4),
(1055, 105, 5),
(1066, 106, 6),
(1077, 107, 7),
(1088, 108, 8),
(1099, 109, 9),
(11010, 110, 10),
(11111, 111, 11),
(11212, 112, 12);

-- Insert data into CUSTOMERS --
INSERT INTO CUSTOMERS (CustomerID, FirstName, LastName, Email, Phone, StreetAddress, City, State, Zip) VALUES
(101, 'Adit', 'Gandhi', 'aditgandhi@gmail.com', '9586829783', '21 Shree Nagar Lane', 'Godhra', 'Gujarat', 389001),
(102, 'Meera', 'Mehta', 'meeram@yahoo.com', '7016182519', '45 Pink City Avenue', 'Jaipur', 'Rajasthan', 302001),
(103, 'Kruti', 'Shah', 'krutishah@gmail.com', '9879393800', '18 Mahatma Gandhi Road', 'Indore', 'Madhya Pradesh', 482001),
(104, 'Akshat', 'Mehta', 'a.mehta@yahoo.com', '9586387611', '32 Riverfront Residency', 'Ahmedabad', 'Gujarat', 370001),
(105, 'Hetal', 'Gandhi', 'hetalgandhi@hotmail.com', '7016182518', '87 Shivaji Park Road', 'Pune', 'Maharastra', 413229),
(106, 'Bhavin', 'Modi', 'b.modi@gmail.com', '7145105976', '12 Snow View Apartments', 'Shimla', 'Himachal Pradesh', 171001),
(107, 'Nilesh', 'Gandhi', 'nsgandhi@gmail.com', '9494229169', '56 Marina Beach Street', 'Chennai', 'Tamilnadu', 600001),
(108, 'Jamuna', 'Harvu', 'jamuna.h@outlook.com', '7147143175', '89 Charminar Heights', 'Hyderabad', 'Andhra Pradesh', 500001),
(109, 'Arham', 'Mehta', 'ar.mehta@gmail.com', '8780311976', '25 Bodhgaya Main Street', 'Gaya', 'Bihar', 800001),
(110, 'Sridhar', 'Sudharshan', 'ss309@yahoo.com', '7069612345', '77 Brahmaputra Residency', 'Assam', 'Assam', 781001),
(111, 'Naresh', 'Sure', 'naresh.sure@gmail.com', '7145101947', '14 Textile Hub Road', 'Surat', 'Gujarat', 335009),
(112, 'Hardik', 'Modi', 'hmodi@hotmail.com', '9825283832', '63 Kashi Vishwanath Lane', 'Varanasi', 'Uttar Pradesh', 212011),
(113, 'Minaxi', 'Modi', 'minaxi.m@gmail.com', '7149467177', '19 Port View Complex', 'Manglore', 'Karnataka', 574142),
(114, 'Prateeksha', 'Mehta', 'p.mehta29@yahoo.com', '7011775364', '48 Valley Heights', 'Dalhousie', 'Uttrakhand', 176304),
(115, 'Vaishali', 'Mehta', 'v.mehta@outlook.com', '8821156343', '92 Banjara Hills Boulevard', 'Hyderabad', 'Andhra Pradesh', 500004);


-- Insert data into INVENTORIES --
INSERT INTO INVENTORIES (InventoryID, ProductID, StockQuantity, ReorderLevel) VALUES
(1, 101, 100, 20),
(2, 102, 200, 10),
(3, 103, 100, 5),
(4, 104, 150, 20),
(5, 105, 120, 10),
(6, 106, 80, 30),
(7, 107, 300, 40),
(8, 108, 90, 0),
(9, 109, 400, 10),
(10, 110, 50, 60),
(11, 111, 40, 100),
(12, 112, 12, 328);

-- Insert data into ORDERS --
INSERT INTO ORDERS (OrderID, CustomerID, OrderDate, TotalPrice) VALUES
(1001, 109, '2024-04-20', 2500),
(1002, 107, '2024-03-22', 3546),
(1003, 105, '2024-05-06', 3700),
(1004, 101, '2024-04-12', 2100),
(1005, 103, '2024-12-12', 4500),
(1006, 102, '2024-02-17', 6000),
(1007, 106, '2024-07-07', 5400),
(1008, 108, '2024-05-05', 3500),
(1009, 110, '2024-05-25', 4140),
(1010, 112, '2024-01-23', 2750),
(1011, 104, '2024-01-02', 5159),
(1012, 115, '2024-09-10', 3300),
(1015, 113, '2024-10-12', 1999),
(1016, 112, '2024-11-19', 2900),
(1017, 111, '2024-04-13', 3999),
(1018, 114, '2024-03-03', 4800),
(1019, 108, '2024-02-11', 5350),
(1020, 115, '2024-04-10', 6434);

-- Insert data into ORDER_ITEMS --
INSERT INTO ORDER_ITEMS (OrderItemID, OrderID, ProductID, Quantity, TotalPrice) VALUES
(1001101, 1001, 101, 20, 6000),
(1002102, 1002, 102, 10, 1000),
(1003103, 1003, 103, 5, 2500),
(1004104, 1004, 104, 8, 1600),
(1005105, 1005, 105, 6, 3000),
(1006106, 1006, 106, 2, 3000),
(1007107, 1007, 107, 15, 150000),
(1008108, 1008, 108, 11, 1100),
(1009109, 1009, 109, 30, 3000),
(1010110, 1010, 110, 20, 50000),
(1011111, 1011, 111, 100, 15000),
(1012112, 1012, 112, 10, 5000);


SELECT * FROM CUSTOMERS;
SELECT * FROM PRODUCTS;
SELECT * FROM PRODUCT_SUPPLIERS;
SELECT * FROM ORDERS;
SELECT * FROM INVENTORIES;
SELECT * FROM ORDER_ITEMS;
SELECT * FROM SUPPLIERS;

COMMIT;