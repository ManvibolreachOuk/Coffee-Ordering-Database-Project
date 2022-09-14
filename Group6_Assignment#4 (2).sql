-- Table Creation

CREATE TABLE comm_Customers (
    customerID NUMBER(6) PRIMARY KEY,
	firstName VARCHAR2(75) NOT NULL,
	lastName VARCHAR2(75) NOT NULL, 
    email VARCHAR2(255) NOT NULL,
    phone NUMBER(12),
    address VARCHAR2(255),
    city VARCHAR2(50),
	province VARCHAR2(25),
	postalCode VARCHAR2(6)
);
INSERT INTO comm_Customers 
VALUES (103458, 'John', 'Doe', 'johndoe@gmail.com', 6472175632, '123 Royal Lane', 'Toronto', 'Ontario', 'P6A4G5');
INSERT INTO comm_Customers 
VALUES (110928, 'Kate', 'Bishop', 'katebishop@gmail.com', 4163450873, '45 Blaze Street', 'Toronto', 'Ontario', 'K4A1J2');
INSERT INTO comm_Customers 
VALUES (125326, 'Samuel', 'Harris', 'samharris@hotmail.com', 4168983344, '227 Anago Crescent', 'Brampton', 'Ontario', 'H3R5T7');
INSERT INTO comm_Customers 
VALUES (134972, 'Lionel', 'Richie', 'lionelrichie@gmail.com', 9056728419, '641 Mavs Crescent', 'Milton', 'Ontario', 'J9E2K3');
INSERT INTO comm_Customers 
VALUES (144519, 'Kristen', 'Bell', 'kristenbell@hotmail.com', 4168983344, '391 Historic Trail', 'Mississauga', 'Ontario', 'L5P1S4');
INSERT INTO comm_Customers 
VALUES (153229, 'Jack', 'Reacher', 'jackreacher@gmail.com', 9056761254, '873 Mantle Way', 'Oakville', 'Ontario', 'O4J1S6');

CREATE TABLE comm_Vendors (
	siteID NUMBER(3) PRIMARY KEY,
	siteName VARCHAR(255) NOT NULL
);
INSERT INTO comm_Vendors
VALUES (001, 'beansemporium.com');
INSERT INTO comm_Vendors
VALUES (002, 'coffeekulture.com');
INSERT INTO comm_Vendors
VALUES (003, 'kellyscoffee.com');
INSERT INTO comm_Vendors
VALUES (004, 'clevercoffee.com');
INSERT INTO comm_Vendors
VALUES (005, 'southbeanco.com');

CREATE TABLE comm_BeansCat (
	beanID NUMBER(3) PRIMARY KEY,
	beanType VARCHAR2(75) NOT NULL,
    CONSTRAINT comm_BeansCat_beanType_ck CHECK (beanType IN ('Robusta', 'Excelsa', 'Liberica', 'Arabica', 'Unknown'))
);
INSERT INTO comm_BeansCat
VALUES (001, 'Robusta');
INSERT INTO comm_BeansCat
VALUES (002, 'Excelsa');
INSERT INTO comm_BeansCat
VALUES (003, 'Liberica');
INSERT INTO comm_BeansCat
VALUES (004, 'Arabica');
INSERT INTO comm_BeansCat
VALUES (005, 'Unknown');

CREATE TABLE comm_ProdCntry (
	cntryID NUMBER(3) PRIMARY KEY,
	cntryName VARCHAR2(100) NOT NULL,
	CONSTRAINT comm_ProdCntry_cntryName_ck CHECK (cntryName IN ('BRAZIL', 'VIETNAM', 'COLOMBIA', 'INDONESIA', 'HONDURAS', 'ETHIOPIA', 'PERU', 'INDIA', 'GUATEMALA', 'UGANDA'))
);
INSERT INTO comm_ProdCntry
VALUES (001, 'BRAZIL');
INSERT INTO comm_ProdCntry
VALUES (002, 'COLOMBIA');
INSERT INTO comm_ProdCntry
VALUES (003, 'ETHIOPIA');
INSERT INTO comm_ProdCntry
VALUES (004, 'GUATEMALA');
INSERT INTO comm_ProdCntry
VALUES (005, 'HONDURAS');
INSERT INTO comm_ProdCntry
VALUES (006, 'INDIA');
INSERT INTO comm_ProdCntry
VALUES (007, 'INDONESIA');
INSERT INTO comm_ProdCntry
VALUES (008, 'PERU');
INSERT INTO comm_ProdCntry
VALUES (009, 'UGANDA');
INSERT INTO comm_ProdCntry
VALUES (010, 'VIETNAM');

CREATE TABLE comm_Products (
	prodID NUMBER(10),
	prodName VARCHAR2(75) NOT NULL,
	prodPrice NUMBER(10, 2) NOT NULL,
	cntryID NUMBER(3) NOT NULL,
	beanID NUMBER(3) NOT NULL,
	roastLevel VARCHAR2(16) NOT NULL,
    PRIMARY KEY (prodID),
    CONSTRAINT comm_BeansCat_beanID_fk FOREIGN KEY (beanID) REFERENCES comm_BeansCat (beanID),
	CONSTRAINT comm_ProdCntry_cntryID_fk FOREIGN KEY (cntryID) REFERENCES comm_ProdCntry (cntryID),
    CONSTRAINT comm_Products_prodName_ck CHECK (prodName IN ('Odacio', 'Melozio', 'Stormio', 'Intenso', 'Elvazio', 'Giorno', 'Altesso', 'Monaro')),
    CONSTRAINT comm_Products_roastLevel_ck CHECK (roastLevel IN ('light', 'medium', 'dark', 'black'))
);
INSERT INTO comm_Products 
VALUES (001, 'Odacio', 12.50, 002, 003, 'medium');
INSERT INTO comm_Products 
VALUES (002, 'Melozio', 15.00, 005, 004, 'light');
INSERT INTO comm_Products 
VALUES (003, 'Stormio', 17.50, 008, 002, 'dark');
INSERT INTO comm_Products 
VALUES (004, 'Intenso', 20.00, 010, 005, 'black');
INSERT INTO comm_Products 
VALUES (005, 'Elvazio', 14.00, 003, 001, 'light');
INSERT INTO comm_Products 
VALUES (006, 'Giorno', 16.00, 006, 003, 'medium');
INSERT INTO comm_Products 
VALUES (007, 'Altesso', 18.50, 004, 002, 'dark');
INSERT INTO comm_Products 
VALUES (008, 'Monaro', 22.25, 007, 001, 'black');

CREATE TABLE comm_ShopCart (
    customerID NUMBER(6) NOT NULL,
	prodID NUMBER(10),
	prodName VARCHAR2(75) NOT NULL,
    prodPrice NUMBER(10, 2) NOT NULL,
	quantity NUMBER(3) NOT NULL,
	status VARCHAR2(20) NOT NULL,
    PRIMARY KEY (prodID),
    CONSTRAINT comm_ShopCart_customerID_fk FOREIGN KEY (customerID) REFERENCES comm_Customers (customerID),
    CONSTRAINT comm_ShopCart_prodID_fk FOREIGN KEY (prodID) REFERENCES comm_Products (prodID),
    CONSTRAINT comm_ShopCart_status_ck CHECK (status IN ('Y', 'N'))
);
INSERT INTO comm_ShopCart
VALUES (103458, 001, 'Odacio', 12.50, 4, 'Y');
INSERT INTO comm_ShopCart
VALUES (110928, 003, 'Stormio', 17.50, 3, 'N');
INSERT INTO comm_ShopCart
VALUES (125326, 004, 'Intenso', 20.00, 5, 'Y');
INSERT INTO comm_ShopCart
VALUES (134972, 006, 'Giorno', 16.00, 2, 'Y');
INSERT INTO comm_ShopCart
VALUES (144519, 008, 'Monaro', 22.25, 3, 'Y');

CREATE TABLE comm_SalesOrders (
	orderID NUMBER(9) PRIMARY KEY,
	customerID NUMBER(6) NOT NULL,
	shipStatus VARCHAR2(20) NOT NULL,
	orderDate DATE NOT NULL,
	shipDate DATE,
	CONSTRAINT comm_SalesOrders_customerID_fk FOREIGN KEY (customerID) REFERENCES comm_Customers (customerID),
    CONSTRAINT comm_salesorders_shipStatus_ck CHECK (shipStatus IN ('pending', 'processing', 'sent', 'delivered'))
);
INSERT INTO comm_SalesOrders
VALUES (000000001, 103458, 'processing' , TO_DATE('11-AUG-22','DD-MON-YY'), TO_DATE('13-AUG-22','DD-MON-YY'));
INSERT INTO comm_SalesOrders
VALUES (000000002, 110928, 'sent' , TO_DATE('08-AUG-22','DD-MON-YY'), TO_DATE('10-AUG-22','DD-MON-YY'));
INSERT INTO comm_SalesOrders
VALUES (000000003, 125326, 'pending' , TO_DATE('10-AUG-22','DD-MON-YY'), TO_DATE('12-AUG-22','DD-MON-YY'));
INSERT INTO comm_SalesOrders
VALUES (000000004, 134972, 'pending' , TO_DATE('12-AUG-22','DD-MON-YY'), TO_DATE('14-AUG-22','DD-MON-YY'));
INSERT INTO comm_SalesOrders
VALUES (000000005, 144519, 'delivered' , TO_DATE('06-AUG-22','DD-MON-YY'), TO_DATE('08-AUG-22','DD-MON-YY'));
INSERT INTO comm_SalesOrders
VALUES (000000006, 134972, 'delivered' , TO_DATE('05-AUG-22','DD-MON-YY'), TO_DATE('07-AUG-22','DD-MON-YY'));
INSERT INTO comm_SalesOrders
VALUES (000000007, 125326, 'delivered' , TO_DATE('02-AUG-22','DD-MON-YY'), TO_DATE('04-AUG-22','DD-MON-YY'));
INSERT INTO comm_SalesOrders
VALUES (000000008, 110928, 'delivered' , TO_DATE('01-AUG-22','DD-MON-YY'), TO_DATE('03-AUG-22','DD-MON-YY'));
INSERT INTO comm_SalesOrders
VALUES (000000009, 103458, 'delivered' , TO_DATE('30-JUL-22','DD-MON-YY'), TO_DATE('01-AUG-22','DD-MON-YY'));
INSERT INTO comm_SalesOrders
VALUES (000000010, 144519, 'delivered' , TO_DATE('29-JUL-22','DD-MON-YY'), TO_DATE('31-JUL-22','DD-MON-YY'));

CREATE TABLE comm_FinOrders (
	orderID NUMBER(9),
	prodId NUMBER(10) NOT NULL,
	quantity NUMBER(3) NOT NULL,
	discount NUMBER(10, 2) DEFAULT 0,
    PRIMARY KEY (orderID),
	CONSTRAINT comm_FinOrders_orderID_fk FOREIGN KEY (orderID) REFERENCES comm_SalesOrders (orderID),
	CONSTRAINT comm_FinOrders_prodID_fk FOREIGN KEY (prodID) REFERENCES comm_Products (prodID)
);
INSERT INTO comm_FinOrders
VALUES (000000005, 003, 3, 5.00);
INSERT INTO comm_FinOrders
VALUES (000000006, 007, 2, 8.00);
INSERT INTO comm_FinOrders
VALUES (000000007, 008, 6, 12.50);
INSERT INTO comm_FinOrders
VALUES (000000008, 004, 2, 2.50);
INSERT INTO comm_FinOrders
VALUES (000000009, 006, 4, 7.50);
INSERT INTO comm_FinOrders
VALUES (000000010, 002, 5, 10.00);

CREATE TABLE comm_PmntInfo (
	paymentID NUMBER(9) PRIMARY KEY,
	orderID NUMBER(9),
	curType CHAR(3), 
	exchangeRate NUMBER DEFAULT 0 NOT NULL,
	paymentDate DATE NOT NULL,
	totalPayment NUMBER NOT NULL,	
    CONSTRAINT comm_PmntInfo_orderID_fk FOREIGN KEY (orderID) REFERENCES comm_SalesOrders (orderID),
    CONSTRAINT comm_PmntInfo_curType_ck CHECK (curType IN ('USD', 'CAD', 'CNY', 'EUR', 'MXN', 'YEN', 'WON', 'AUD'))
);
INSERT INTO comm_PmntInfo
VALUES (000000005, 000000005, 'CAD', 0, TO_DATE('05-AUG-22','DD-MON-YY'), 47.50);
INSERT INTO comm_PmntInfo
VALUES (000000006, 000000006, 'CAD', 0, TO_DATE('04-AUG-22','DD-MON-YY'), 29.00);
INSERT INTO comm_PmntInfo
VALUES (000000007, 000000007, 'USD', 1.29, TO_DATE('01-AUG-22','DD-MON-YY'), 216.01);
INSERT INTO comm_PmntInfo
VALUES (000000008, 000000008, 'EUR', 1.31, TO_DATE('30-JUL-22','DD-MON-YY'), 49.12);
INSERT INTO comm_PmntInfo
VALUES (000000009, 000000009, 'CAD', 0, TO_DATE('29-JUL-22','DD-MON-YY'), 56.50);

CREATE TABLE comm_Inventory (
	siteID NUMBER(3),
	prodID NUMBER (10),
	quantity NUMBER,
	PRIMARY KEY (siteID, prodID),
	CONSTRAINT comm_Inventory_siteID_fk FOREIGN KEY (siteID) REFERENCES comm_Vendors (siteID),
	CONSTRAINT comm_Inventory_prodID_fk FOREIGN KEY (prodID) REFERENCES comm_Products (prodID) 
);
INSERT INTO comm_Inventory
VALUES (001, 002, 250);
INSERT INTO comm_Inventory
VALUES (001, 005, 250);
INSERT INTO comm_Inventory
VALUES (002, 001, 300);
INSERT INTO comm_Inventory
VALUES (002, 006, 300);
INSERT INTO comm_Inventory
VALUES (003, 003, 350);
INSERT INTO comm_Inventory
VALUES (003, 007, 350);
INSERT INTO comm_Inventory
VALUES (004, 004, 275);
INSERT INTO comm_Inventory
VALUES (005, 008, 375);


-- Query

-- Customers table queries
SELECT * FROM comm_Customers;
SELECT FIRSTNAME, LASTNAME, PHONE, CITY FROM comm_Customers WHERE CITY = 'Toronto' OR CITY = 'Brampton' order by firstname;
SELECT FIRSTNAME, LASTNAME FROM comm_Customers WHERE LASTNAME LIKE '_i%';
select postalcode, substr(postalcode, 1, 3) from comm_customers;
select firstname, instr(firstname, 't') "First t" from comm_customers;
select lower(firstname), lastname from comm_customers where lower(lastname) = 'doe';
select firstname, lastname, concat(firstname, lastname) from comm_customers;

-- Vendors table queries
SELECT * FROM comm_Vendors;
SELECT * FROM comm_Vendors WHERE SITEID <= 3;
select sitename, LPAD(sitename, 30, '*') from comm_vendors;
select sitename, ltrim(sitename, 'c') from comm_vendors where sitename like 'c%';
SELECT comm_Inventory.quantity,comm_vendors.siteName FROM comm_vendors INNER JOIN comm_Inventory ON comm_Vendors.siteID = comm_Inventory.siteID;


--Beans Categories table queries 
SELECT * FROM comm_BeansCat;
SELECT * FROM comm_BeansCat WHERE BEANTYPE != 'Unknown';
select beantype, translate(beantype, 'a', 'ara') from comm_beanscat;

--Production countries table queries 
SELECT * FROM comm_ProdCntry;
SELECT * FROM comm_ProdCntry WHERE CNTRYNAME LIKE '%U%';
select cntryname, length(cntryname) from comm_prodcntry;
select c.cntryID, p.prodname from comm_prodcntry c, comm_products p where prodname = 'Odacio';

--Products table queries 
SELECT * FROM comm_Products;
SELECT * FROM comm_Products WHERE PRODPRICE BETWEEN 15 AND 20 AND ROASTLEVEL LIKE 'dark';
SELECT * FROM comm_Products WHERE PRODNAME LIKE '%io';
select prodprice, round(prodprice, 1), trunc(prodprice) from comm_products where prodprice > 20;

--Shop cart table queries
SELECT * FROM comm_Shopcart;
SELECT CUSTOMERID FROM comm_Shopcart WHERE QUANTITY = 5;
select customerid, avg(prodprice) from comm_shopcart group by customerid having avg(prodprice) > 15;
select avg(sum(quantity)) from comm_shopcart group by customerid;
select prodprice, customerid, beantype from comm_beanscat natural join comm_shopcart;

--Sales orders table queries
SELECT * FROM comm_SalesOrders;
SELECT * FROM comm_SalesOrders WHERE SHIPDATE < '01-AUG-22';
SELECT * FROM comm_SalesOrders WHERE ORDERDATE BETWEEN '01-AUG-22' AND '15-AUG-22';
SELECT * FROM comm_SalesOrders WHERE SHIPSTATUS LIKE 'pending';
select orderdate, sysdate, abs(round(orderdate-sysdate)) from comm_salesorders where orderdate > '10-AUG-22';
select months_between(orderdate, shipdate), add_months(orderdate, 4), next_day(shipdate, 'tuesday') from comm_salesorders;

--Fin orders table queries
SELECT * FROM comm_FinOrders;
SELECT ORDERID, PRODID, DISCOUNT FROM comm_FinOrders WHERE DISCOUNT >= 10;
select count(discount) from comm_finorders;
select prodname, discount from comm_products p, comm_finorders f where p.prodid(+) = f.prodid order by prodname;
SELECT comm_FinOrders.quantity, comm_SalesOrders.orderdate, comm_Products.cntryid FROM ((comm_FinOrders INNER JOIN comm_SalesOrders ON comm_FinOrders.orderID = comm_SalesOrders.orderID) INNER JOIN comm_Products ON comm_FinOrders.prodID = comm_Products.prodID);
 
--Payment Info table queries
SELECT * FROM comm_PmntInfo;
SELECT * FROM comm_PmntInfo WHERE CURTYPE = 'CAD'; 
SELECT * FROM comm_PmntInfo WHERE TOTALPAYMENT < 200;
select distinct curtype from comm_pmntInfo p join comm_salesorders using (orderid); 
select exchangerate, orderid from comm_pmntinfo p left outer join comm_finorders using (orderid) order by discount;

--Inventory Info table queries
SELECT * FROM comm_Inventory;
SELECT * FROM comm_Inventory WHERE SITEID = 1 AND QUANTITY < 300;
SELECT * FROM comm_Inventory WHERE PRODID = 2 OR PRODID = 4;
select sum(quantity), avg(quantity) from comm_inventory;


