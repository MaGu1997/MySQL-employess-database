-- SELECT DATABASE sales
USE sales;

-- DROP TABLES
DROP TABLE IF EXISTS sales;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS items;
DROP TABLE IF EXISTS companies;

-- CREATE TABLE QUERY
CREATE TABLE customers (
    customer_id INT NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email_address VARCHAR(255),
    number_of_complaints INT DEFAULT 0,
    PRIMARY KEY (customer_id)
);
ALTER TABLE customers
ADD UNIQUE KEY (email_address);

ALTER TABLE customers
DROP INDEX email_address;

TRUNCATE TABLE customers;

INSERT INTO customers (first_name, last_name)
VALUES ('Sagar','Gurbani')
;

ALTER TABLE customers
ALTER COLUMN number_of_complaints DROP DEFAULT;

SELECT 
    *
FROM
    customers;

CREATE TABLE sales (
    purchase_number INT NOT NULL AUTO_INCREMENT,
    date_of_purchase DATE,
    customer_id INT,
    item_code VARCHAR(10),
    PRIMARY KEY (purchase_number)
);
ALTER TABLE sales
ADD FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE;

CREATE TABLE companies (
    company_id INT NOT NULL,
    company_name VARCHAR(255) NOT NULL,
    headquarters_phone_number VARCHAR(255) NOT NULL,
    PRIMARY KEY (company_id)
);
ALTER TABLE companies
MODIFY company_name VARCHAR(255) NULL
;

INSERT INTO companies (company_id, company_name,headquarters_phone_number)
VALUES (1,'Company A','+33756873434')
;

CREATE TABLE items (
    item_code INT NOT NULL,
    item VARCHAR(20) NOT NULL,
    unit_price INT NOT NULL,
    company_id INT NOT NULL,
    PRIMARY KEY (item_code)
);
ALTER TABLE items
ADD FOREIGN KEY (company_id) REFERENCES companies(company_id) ON DELETE CASCADE;

/*
comment 1
comment 2
*/

