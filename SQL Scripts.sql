
-- Project Name: Coffee Makers

DROP TABLE bcb_companys;
DROP TABLE bcb_brands;
DROP TABLE bcb_models;
DROP TABLE bcb_types;
DROP TABLE bcb_products;
DROP TABLE bcb_accessorys;
DROP TABLE bcb_product_colors;
DROP TABLE bcb_pieces;
DROP TABLE bcb_orders;
DROP TABLE bcb_order_lines;
DROP TABLE bcb_customers;
DROP TABLE bcb_employees;
DROP TABLE bcb_location2s;
DROP TABLE bcb_salesoffices;
DROP TABLE bcb_warehouses; 
DROP TABLE bcb_inventorys;
DROP TABLE bcb_locations;
DROP TABLE bcb_regions;


/* 1. DDL CREATE Statements. */
-- ===================================================================================================

CREATE TABLE bcb_companys (
  company_id      INTEGER      NOT NULL
  GENERATED ALWAYS AS IDENTITY
  (START WITH 30000 INCREMENT BY 1),
  company_name    VARCHAR(200) NOT NULL,
  contact_person  VARCHAR(100),
  contact_no      VARCHAR(15)  NOT NULL);
  
CREATE TABLE bcb_brands (
  brand_id     INTEGER     NOT NULL
  GENERATED ALWAYS AS IDENTITY
  (START WITH 31000 INCREMENT BY 1),
  brand_name   VARCHAR(70) NOT NULL,
  company_id   INTEGER     NOT NULL,
  brand_level  VARCHAR(30) NOT NULL);
  
CREATE TABLE bcb_types (
  type_id     INTEGER      NOT NULL,
  type_name   VARCHAR(70)  NOT NULL,
  type_desc   VARCHAR(200) NOT NULL,
  technology  VARCHAR(100));

CREATE TABLE bcb_models (
  model_id        INTEGER      NOT NULL,
  model           VARCHAR(100) NOT NULL,
  model_name      VARCHAR(200) NOT NULL,
  description     VARCHAR(300) NOT NULL,
  brand_id        INTEGER      NOT NULL,
  type_id         INTEGER      NOT NULL,
  warranty_years  INTEGER      NOT NULL   DEFAULT 1,
  voltage         INTEGER      NOT NULL);
  
------------------------------------------------------------------------------

CREATE TABLE bcb_products (
  product_id     INTEGER       NOT NULL,
  mod_variant    VARCHAR(70)   NOT NULL,
  model_id       INTEGER       NOT NULL,
  active_status  VARCHAR(1)    NOT NULL   DEFAULT 'Y', 
  price          DECIMAL(6,2)  NOT NULL,
  cup_capacity   INTEGER       NOT NULL,
  weight_pounds  DECIMAL(4,2)  NOT NULL,
  dimensions     VARCHAR(40)   NOT NULL,
  wattage        DECIMAL(5,1)  NOT NULL,
  ratings        DECIMAL(2,1));

CREATE TABLE bcb_accessorys (
  product_id      INTEGER         NOT NULL,
  accessory_id    INTEGER         NOT NULL,
  accessory_name  VARCHAR(100)    NOT NULL,
  accessory_desc  VARCHAR(200));

CREATE TABLE bcb_product_colors (
  product_id    INTEGER       NOT NULL,
  color_id      INTEGER       NOT NULL,
  color_name    VARCHAR(50)   NOT NULL,
  color_desc    VARCHAR(100));

CREATE TABLE bcb_pieces (
  piece_id        INTEGER       NOT NULL,
  serial_number   VARCHAR(50)   NOT NULL,
  order_id        INTEGER,       
  product_id      INTEGER       NOT NULL);

----------------------------------------------------------------------------------

CREATE TABLE bcb_orders (
  order_id      INTEGER       NOT NULL,
  order_date    DATE          NOT NULL    DEFAULT CURRENT_DATE,
  order_time    VARCHAR(8)    NOT NULL,
  total_price   DECIMAL(8,2)  NOT NULL,
  customer_id   INTEGER       NOT NULL,
  employee_id   INTEGER       NOT NULL);

CREATE OR REPLACE SEQUENCE order_id_seq
  START WITH 90000000
  INCREMENT BY 1
  NO MAXVALUE
  NO CACHE
  NO CYCLE;

CREATE TABLE bcb_order_lines (
  order_id      INTEGER   NOT NULL,
  product_id    INTEGER   NOT NULL, 
  sr_no         INTEGER   NOT NULL,
  quantity      INTEGER   NOT NULL);

----------------------------------------------------------------------------------
CREATE TABLE bcb_customers (
  customer_id     INTEGER       NOT NULL
  GENERATED ALWAYS AS IDENTITY
  (START WITH 10000000 INCREMENT BY 1),
  first_name      VARCHAR(70)   NOT NULL,
  last_name       VARCHAR(70)   NOT NULL,
  email_id        VARCHAR(100),
  phone_no        VARCHAR(15),
  street_address  VARCHAR(100),
  location_id     INTEGER);

CREATE TABLE bcb_employees (
  employee_id       INTEGER       NOT NULL
  GENERATED ALWAYS AS IDENTITY
  (START WITH 20000000 INCREMENT BY 1),
  emp_first_name    VARCHAR(70)   NOT NULL,
  emp_last_name     VARCHAR(70)   NOT NULL,
  soc_insurance_no  DECIMAL(9,0)  NOT NULL,
  hire_date         DATE          NOT NULL,
  job_code          VARCHAR(1)    NOT NULL    DEFAULT 'T',
  salary            DECIMAL(8,2),
  sales_office_id   INTEGER,
  emp_email_id      VARCHAR(100)  NOT NULL,
  emp_phone_no      VARCHAR(15)   NOT NULL,
  street_address    VARCHAR(100),
  location_id       INTEGER);

CREATE TABLE bcb_location2s (
  location_id   INTEGER       NOT NULL
  GENERATED ALWAYS AS IDENTITY
  (START WITH 7000000 INCREMENT BY 1),
  postal_code   VARCHAR(6)    NOT NULL,
  city          VARCHAR(40)   NOT NULL,
  province      VARCHAR(40)   NOT NULL);

-------------------------------------------------------------------------------------

CREATE TABLE bcb_salesoffices (
  sales_office_id   INTEGER       NOT NULL,
  sales_office      VARCHAR(70)   NOT NULL,
  location_id       INTEGER       NOT NULL,
  so_phone_no       VARCHAR(15)   NOT NULL,  
  so_email_id       VARCHAR(100)  NOT NULL,  
  so_street_address VARCHAR(100)  NOT NULL,
  manager_id        INTEGER);

CREATE TABLE bcb_warehouses (
  warehouse_id        INTEGER       NOT NULL,
  wh_street_address   VARCHAR(100)  NOT NULL,
  wh_phone_no         VARCHAR(15)   NOT NULL,
  contact_person      VARCHAR(70)   NOT NULL,
  location_id         INTEGER       NOT NULL);    

CREATE TABLE bcb_inventorys (
  product_id    INTEGER   NOT NULL,
  warehouse_id  INTEGER   NOT NULL,
  avail_quantity INTEGER   NOT NULL);

-------------------------------------------------------------------------------------

CREATE TABLE bcb_locations (
  location_id   INTEGER       NOT NULL
  GENERATED ALWAYS AS IDENTITY
  (START WITH 8000000 INCREMENT BY 1),
  postal_code   VARCHAR(6)    NOT NULL,
  city          VARCHAR(40)   NOT NULL,
  region_id     INTEGER       NOT NULL,
  province      VARCHAR(40)   NOT NULL);

CREATE TABLE bcb_regions (
  region_id    INTEGER        NOT NULL,
  region_name  VARCHAR(100)   NOT NULL);

------------------------------------------------------------------------------------
--======================================================================================================


/* Database Constraint Statements */
-- ======================================================================================================

-- PK, UK CONSTRAINTS ------------------------------------------------------------------------
-- ===========================================================================================

ALTER TABLE bcb_companys
  ADD CONSTRAINT bcb_companys_pk
    PRIMARY KEY (company_id)
  ADD CONSTRAINT bcb_companys_company_name_uk
    UNIQUE (COMPANY_NAME)
  ADD CONSTRAINT bcb_companys_contact_no_uk
    UNIQUE (contact_no);

ALTER TABLE bcb_brands 
  ADD CONSTRAINT bcb_brands_pk
    PRIMARY KEY (brand_id)
  ADD CONSTRAINT bcb_brands_brand_name_uk
    UNIQUE (brand_name);
  
ALTER TABLE bcb_models 
  ADD CONSTRAINT bcb_models_pk
    PRIMARY KEY (model_id)
  ADD CONSTRAINT bcb_models_model_uk
    UNIQUE (model);

ALTER TABLE bcb_types 
  ADD CONSTRAINT bcb_types_pk
    PRIMARY KEY (type_id)
  ADD CONSTRAINT bcb_types_type_desc_uk
    UNIQUE (type_desc);
    
ALTER TABLE bcb_products 
  ADD CONSTRAINT bcb_products_pk
    PRIMARY KEY (product_id);

ALTER TABLE bcb_accessorys
  ADD CONSTRAINT bcb_accessorys_pk
    PRIMARY KEY (product_id, accessory_id);

ALTER TABLE bcb_product_colors 
  ADD CONSTRAINT bcb_product_colors_pk
    PRIMARY KEY (product_id, color_id);
  
ALTER TABLE bcb_pieces 
  ADD CONSTRAINT bcb_pieces_pk
    PRIMARY KEY (piece_id)
  ADD CONSTRAINT bcb_pieces_serial_number_uk
    UNIQUE (serial_number);

ALTER TABLE bcb_orders 
  ADD CONSTRAINT bcb_orders_pk
    PRIMARY KEY (order_id);

ALTER TABLE bcb_order_lines 
  ADD CONSTRAINT bcb_order_lines_pk
    PRIMARY KEY (order_id, product_id);

ALTER TABLE bcb_customers 
  ADD CONSTRAINT bcb_customers_pk
    PRIMARY KEY (customer_id)
  ADD CONSTRAINT bcb_customers_email_id_uk
    UNIQUE (email_id);
  
ALTER TABLE bcb_employees 
  ADD CONSTRAINT bcb_employees_pk
    PRIMARY KEY (employee_id)
  ADD CONSTRAINT bcb_employees_soc_insurance_no_uk
    UNIQUE (soc_insurance_no)
  ADD CONSTRAINT bcb_employees_emp_email_id_uk
    UNIQUE (emp_email_id)
  ADD CONSTRAINT bcb_employees_emp_phone_no_uk
    UNIQUE (emp_phone_no);
  
ALTER TABLE bcb_location2s 
  ADD CONSTRAINT bcb_location2s_pk
    PRIMARY KEY (location_id)
  ADD CONSTRAINT bcb_location2s_postal_code_uk
    UNIQUE (postal_code);

ALTER TABLE bcb_salesoffices 
  ADD CONSTRAINT bcb_salesoffices_pk
    PRIMARY KEY (sales_office_id)
  ADD CONSTRAINT bcb_salesoffices_so_phone_no_uk
    UNIQUE (so_phone_no)
  ADD CONSTRAINT bcb_salesoffices_so_email_id_uk
    UNIQUE (so_email_id)
  ADD CONSTRAINT bcb_salesoffices_so_street_address_uk
    UNIQUE (so_street_address);

ALTER TABLE bcb_warehouses 
  ADD CONSTRAINT bcb_warehouses_pk
    PRIMARY KEY (warehouse_id)
  ADD CONSTRAINT bcb_warehouses_wh_street_address_uk
    UNIQUE (wh_street_address)
  ADD CONSTRAINT bcb_warehouses_wh_phone_no_uk
    UNIQUE (wh_phone_no);
  
ALTER TABLE bcb_inventorys 
  ADD CONSTRAINT bcb_inventorys_pk
    PRIMARY KEY (product_id, warehouse_id);

ALTER TABLE bcb_locations 
  ADD CONSTRAINT bcb_locations_pk
    PRIMARY KEY (location_id)
  ADD CONSTRAINT bcb_locations_postal_code_uk
    UNIQUE (postal_code);

ALTER TABLE bcb_regions
  ADD CONSTRAINT bcb_regions_pk
    PRIMARY KEY (region_id)
  ADD CONSTRAINT bcb_regions_region_name_uk
    UNIQUE (region_name);


-- FK CONSTRAINTS ------------------------------------------------------------------------
-- ===========================================================================================

ALTER TABLE bcb_brands 
  ADD CONSTRAINT bcb_brands_company_id_fk
    FOREIGN KEY (company_id)
    REFERENCES bcb_companys (company_id);

ALTER TABLE bcb_models
  ADD CONSTRAINT bcb_models_brand_id_fk
    FOREIGN KEY (brand_id)
    REFERENCES bcb_brands (brand_id)
  ADD CONSTRAINT bcb_models_type_id_fk
    FOREIGN KEY (type_id)
    REFERENCES bcb_types (type_id);

ALTER TABLE bcb_products 
  ADD CONSTRAINT bcb_products_model_id_fk
    FOREIGN KEY (model_id)
    REFERENCES bcb_models (model_id);

ALTER TABLE bcb_accessorys 
  ADD CONSTRAINT bcb_accessorys_product_id_fk
    FOREIGN KEY (product_id)
    REFERENCES bcb_products (product_id);

ALTER TABLE bcb_product_colors
  ADD CONSTRAINT bcb_product_colors_product_id_fk
    FOREIGN KEY (product_id)
    REFERENCES bcb_products (product_id);

ALTER TABLE bcb_pieces
  ADD CONSTRAINT bcb_pieces_order_id_fk
    FOREIGN KEY (order_id)
    REFERENCES bcb_orders (order_id)
  ADD CONSTRAINT bcb_pieces_product_id_fk
    FOREIGN KEY (product_id)
    REFERENCES bcb_products (product_id);

ALTER TABLE bcb_orders
  ADD CONSTRAINT bcb_orders_customer_id_fk
    FOREIGN KEY (customer_id)
    REFERENCES bcb_customers (customer_id)
  ADD CONSTRAINT bcb_orders_employee_id_fk
    FOREIGN KEY (employee_id)
    REFERENCES bcb_employees (employee_id);
  
ALTER TABLE bcb_order_lines
  ADD CONSTRAINT bcb_order_lines_order_id_fk
    FOREIGN KEY (order_id)
    REFERENCES bcb_orders (order_id)
  ADD CONSTRAINT bcb_order_lines_product_id_fk
    FOREIGN KEY (product_id)
    REFERENCES bcb_products (product_id);

ALTER TABLE bcb_customers
  ADD CONSTRAINT bcb_customers_location_id_fk
    FOREIGN KEY (location_id)
    REFERENCES bcb_location2s (location_id);

ALTER TABLE bcb_employees
  ADD CONSTRAINT bcb_employees_sales_office_id_fk
    FOREIGN KEY (sales_office_id)
    REFERENCES bcb_salesoffices (sales_office_id)
  ADD CONSTRAINT bcb_employees_location_id_fk
    FOREIGN KEY (location_id)
    REFERENCES bcb_location2s (location_id);

ALTER TABLE bcb_salesoffices
  ADD CONSTRAINT bcb_salesoffices_location_id_fk
    FOREIGN KEY (location_id)
    REFERENCES bcb_locations (location_id);

ALTER TABLE bcb_salesoffices
  ADD CONSTRAINT bcb_salesoffice_manager_id_fk
    FOREIGN KEY (manager_id)
    REFERENCES bcb_employees (employee_id);
  
ALTER TABLE bcb_warehouses
  ADD CONSTRAINT bcb_warehouses_location_id_fk
    FOREIGN KEY (location_id)
    REFERENCES bcb_locations (location_id);

ALTER TABLE bcb_inventorys
  ADD CONSTRAINT bcb_inventorys_product_id_fk
    FOREIGN KEY (product_id)
    REFERENCES bcb_products (product_id)
  ADD CONSTRAINT bcb_inventorys_warehouse_id_fk
    FOREIGN KEY (warehouse_id)
    REFERENCES bcb_warehouses (warehouse_id);

ALTER TABLE bcb_locations
  ADD CONSTRAINT bcb_locations_region_id_fk
    FOREIGN KEY (region_id)
    REFERENCES bcb_regions (region_id);
  

-- CHECK CONSTRAINTS --------------------------------------------------------------------
--=======================================================================================

ALTER TABLE bcb_models
  ADD CONSTRAINT bcb_models_warranty_years_ck
    CHECK (warranty_years BETWEEN 1 AND 5);

ALTER TABLE bcb_products
  ADD CONSTRAINT bcb_products_active_status_ck
    CHECK (active_status IN ('Y', 'N'));

ALTER TABLE bcb_orders 
  ADD CONSTRAINT bcb_orders_order_date_ck
    CHECK (order_date >= '2018-01-01');

ALTER TABLE bcb_order_lines 
  ADD CONSTRAINT bcb_order_lines_quantity_ck
    CHECK (quantity >= 1);

ALTER TABLE bcb_employees
  ADD CONSTRAINT bcb_employees_hire_date_ck
    CHECK (hire_date >= '2017-09-01');
  
ALTER TABLE bcb_employees
  ADD CONSTRAINT bcb_employees_job_code_ck
    CHECK (job_code IN ('T', 'J', 'M'));
  
ALTER TABLE bcb_employees 
  ADD CONSTRAINT bcb_employees_salary_ck
    CHECK (salary IS NULL OR (salary BETWEEN 60000.00 AND 170000));

ALTER TABLE bcb_inventorys
  ADD CONSTRAINT bcb_inventorys_avail_quantity_ck
    CHECK (avail_quantity <= 500);

-- ======================================================================================================================


/* 2. DDL INSERT Statements */
-- ======================================================================================================================

  
-- Companys, Brands & Types --------------------------------------------------------------------
-- =============================================================================================
  
INSERT INTO bcb_companys
  (company_id, company_name, contact_person, contact_no) VALUES
  (DEFAULT, 'Hamilton Beach Brands, Inc', 'John Martin', '14182445911');

INSERT INTO bcb_brands 
  (brand_id, brand_name, company_id, brand_level) VALUES
  (DEFAULT, 'Hamilton Beach', IDENTITY_VAL_LOCAL(), 'International High');
  
INSERT INTO bcb_companys
  (company_id, company_name, contact_person, contact_no) VALUES
  (DEFAULT, 'BLACK+DECKER', 'Bob Specter', '14508785825');

INSERT INTO bcb_brands 
  (brand_id, brand_name, company_id, brand_level) VALUES
  (DEFAULT, 'BLACK+DECKER', IDENTITY_VAL_LOCAL(), 'International Medium');

INSERT INTO bcb_companys
  (company_id, company_name, contact_person, contact_no) VALUES
  (DEFAULT, 'Keurig Dr Pepper', 'Nick Thomas', '14167583758');

INSERT INTO bcb_brands 
  (brand_id, brand_name, company_id, brand_level) VALUES
  (DEFAULT, 'Keurig', IDENTITY_VAL_LOCAL(), 'International');

INSERT INTO bcb_companys
  (company_id, company_name, contact_person, contact_no) VALUES
  (DEFAULT, 'SharkNinja Operating LLC', 'Francis John', '13298946786');

INSERT INTO bcb_brands
  (brand_id, brand_name, company_id, brand_level) VALUES
  (DEFAULT, 'Ninja', IDENTITY_VAL_LOCAL(), 'International');

INSERT INTO bcb_companys
  (company_id, company_name, contact_person, contact_no) VALUES
  (DEFAULT, 'Braun GmbH', 'Tim Godershmidt', '15137896741');

INSERT INTO bcb_brands
  (brand_id, brand_name, company_id, brand_level) VALUES
  (DEFAULT, 'Braun', IDENTITY_VAL_LOCAL(), 'International Medium');

INSERT INTO bcb_companys
  (company_id, company_name, contact_person, contact_no) VALUES
  (DEFAULT, 'Conair Corporation', 'Puneet Singh', '15198967786');

INSERT INTO bcb_brands
  (brand_id, brand_name, company_id, brand_level) VALUES
  (DEFAULT, 'Cuisinart', IDENTITY_VAL_LOCAL(), 'International High');

INSERT INTO bcb_companys
  (company_id, company_name, contact_person, contact_no) VALUES
  (DEFAULT, 'Newell Brands', 'Ham Spacey', '17128953789');

INSERT INTO bcb_brands
  (brand_id, brand_name, company_id, brand_level) VALUES
  (DEFAULT, 'Mr. Coffee', IDENTITY_VAL_LOCAL(), 'International');

INSERT INTO bcb_companys
  (company_id, company_name, contact_person, contact_no) VALUES
  (DEFAULT, 'Breville Group Limited', 'Sushmita Singhania', '61772348965');

INSERT INTO bcb_brands
  (brand_id, brand_name, company_id, brand_level) VALUES
  (DEFAULT, 'Breville', IDENTITY_VAL_LOCAL(), 'International High');

INSERT INTO bcb_companys
  (company_id, company_name, contact_person, contact_no) VALUES
  (DEFAULT, 'Thermoplan AG', 'Aaron Crayman', '17723489651');

INSERT INTO bcb_brands
  (brand_id, brand_name, company_id, brand_level) VALUES
  (DEFAULT, 'BUNN', IDENTITY_VAL_LOCAL(), 'Medium');

INSERT INTO bcb_companys
  (company_id, company_name, contact_person, contact_no) VALUES
  (DEFAULT, 'Whirlpool Corp.', 'Hussain Khan', '17453499231');

INSERT INTO bcb_brands
  (brand_id, brand_name, company_id, brand_level) VALUES
  (DEFAULT, 'KitchenAid', IDENTITY_VAL_LOCAL(), 'International');



INSERT INTO bcb_types
  (type_id, type_name, type_desc, technology) VALUES
  (101, 'Drip', 'Hot Water Poured on Coffee GrindsBrewed. Can be preset in advance to brew at a specific time later on', NULL),
  (102, 'Espresso', 'thick, concentrated coffee maker', NULL);

-------------------------------------------------------------------------------------------------------------------
-- ================================================================================================================


-- Models, Products, Accessorys & Product Colours ------------------------------------------------
-- ===============================================================================================

INSERT INTO bcb_models
  (model_id, model, model_name, description, brand_id, type_id, warranty_years, voltage) VALUES
  (400000, '43874', 'Brewer Maxx', '12 Cup Digital Coffee Maker', 31000, 101, 5, 240),
  (400001, '48465', 'Brewstation Summit', '12 cup Brewstation Summit Dispensing Coffeemaker', 31000, 101, 5, 240),
  (400002, 'CM1231SC', '12 Pro-Drip', '12 Cup, Programmable', 31001, 101, 3, 240),
  (400003, '4335461236', 'Star 5 Cup', 'Coffee Maker, 5 Cup', 31001, 101, 3, 240),
  (400004, 'CM2035B-1', 'Thermal Espresso', '12-Cup Thermal Coffeemaker', 31001, 102, 3, 240),
  (400005, 'SSK0200558', 'SS K-Cup Latte + Capuccino', 'Single Serve K-Cup Pod Coffee, Latte, Capuccino maker', 31002, 102, 2, 240),
  (400006, '611247376966', 'SS K-cup Special', 'Single Serve K-Cup Pod Coffee, Latte and Cappuccino Maker, with Milk Frother for Speciality Beverages', 31002, 102, 2, 240),
  (400007, 'RW1020-12', 'SS K-Cup Brew', 'Single Serve K-Cup Pod Coffee Maker, with 6 to 12oz Brew Size', 31002, 102, 3, 120),
  (400008, '611247371923', 'SS K-Cup Iced', 'Single Serve K-Cup Pod Coffee Maker, With Iced Brew Functionality And Quiet Brew Technology', 31002, 102, 3, 120),
  (400009, 'CE200C', '12-Cup Brewer', '12-Cup Programmable Coffee Brewer', 31003, 101, 2, 120),
  (400010, 'CFP301', '12-Cup Drip', '12-Cup Drip Maker with Glass Carafe, Single-Serve', 31003, 101, 3, 120),
  (400011, '472WR567', 'Westmaxx Drip', '12 Cup Drip Coffee Maker', 31004, 101, 2, 120),
  (400012, 'KF7370SI', 'BrewSense Touch Screen', 'BrewSense Touch Screen Coffee Maker KF7370SI, 12 cup', 31004, 101, 3, 120),
  (400013, 'KF6050WH', 'BrewSense Reg+', 'BrewSense Drip Coffee Maker', 31004, 101, 3, 110),
  (400014, 'EM-100C', 'My Espresso', 'Espresso Maker', 31005, 102, 2, 120),
  (400015, 'SS-GB1C', '12-cup Carafe', '12-cup Carafe and Single serve, Espresso Maker', 31005, 102, 3, 120),
  (400016, 'BVMC-EM6701SS', 'One-Touch CoffeeHouse', 'One-Touch CoffeeHouse Espresso and Cappuccino Machine', 31006, 102, 5, 110),
  (400017, 'ECM160', 'Star Espresso', '4-Cup Steam Espresso System with Milk Frother', 31006, 102, 5, 110),
  (400018, 'BDC650BSS', 'GrindMaxx Drip', 'The Grind Control Drip Coffee Maker', 31007, 101, 1, 120),
  (400019, 'CSB2B', 'Speed Brew Elite', 'Speed Brew Elite 10-Cup Coffee Maker', 31008, 101, 1, 120),
  (400020, 'KCM1209OB', 'Wonder Drip 12', 'Drip Coffee Maker, 12 Cup', 31009, 101, 1, 110);
  
  
  
INSERT INTO bcb_products
  (product_id, mod_variant, model_id, active_status, price, cup_capacity, weight_pounds, dimensions, wattage, ratings) VALUES
  (410000, 'Latte+', 400000, 'Y', 99.99, 4, 5.6, '23.4 x 29.1 x 35.1 cm', 1030, 4.1),
  (410001, 'small', 400000, 'Y', 36.93, 6, 4.2, '27.94 x 20.02 x 36.2 cm', 950, 4.5),
  (410002, 'medium', 400000, 'Y',56.21, 8, 5.3, '31.94 x 20.02 x 37 cm', 1230, 4.5),
  (410003, 'large', 400000, 'N', 72.93, 12, 5.9, '35.94 x 20.02 x 41 cm', 1560, 4.5),
  (410004, 'Regular', 400001, 'Y', 75.90, 12, 5.6, '27.94 x 20.02 x 36.2 cm', 950, 4.7),
  (410005, 'Versatile', 400001, DEFAULT, 107.41, 12, 5.8, '27.94 x 20.02 x 36.2 cm', 1080, 4.8),
  (410006, 'Primary', 400002, DEFAULT, 107.41, 12, 5.8, '35 x 21.01 x 35.99 cm', 1290, 4.1),
  (410007, 'Primary', 400003, 'N', 67.90, 5, 4.9, '35 x 21.01 x 35.99 cm', 1290, 4.1),
  (410008, 'Primary', 400004, 'N', 167.29, 12, 4, '20.3 x 27.9 x 29.2 cm', 980, 4.9),
  (410009, 'Regular', 400005, 'N', 187.29, 5, 12.8, '29.7 x 38.9 x 31.8 cm', 1840, 4.1),
  (410010, 'Programmable', 400005, 'Y', 187.29, 5, 12.8, '29.7 x 38.9 x 31.8 cm', 1840, 4.1),
  (410011, 'Regular', 400006, 'Y', 231.88, 5, 4.8, '45.2 x 37.3 x 37.8 cm', 2150, 4.4),
  (410012, 'Programmable', 400006, DEFAULT, 287.29, 5, 4.8, '45.2 x 37.3 x 37.8 cm', 2357, 4.8),
  (410013, 'Manual', 400007, DEFAULT, 99.99, 2, 2.3, '28.7 x 11.4 x 30.7 cm', 420, 4.8),
  (410014, 'Automatic', 400007, 'Y', 189.23, 2, 2.8, '28.7 x 11.4 x 30.7 cm', 650, 4.8),
  (410015, 'Single Brew', 400008, 'N', 147.98, 8, 12.2, '40.13 x 29.97 x 37.08 cm', 1540, 4.8),
  (410016, 'Ice + Quiet', 400008, 'Y', 185.45, 8, 12.6, '40.13 x 29.97 x 37.08 cm', 1870, 4.8),
  (410017, 'Canadian Version', 400009, 'Y', 94.98, 12, 6.42, '22.2 x 25.2 x 37.1 cm', 1100, 4.7),
  (410018, 'American Version', 400009, 'Y', 113.78, 12, 7.67, '24.2 x 27.2 x 35.1 cm', 1100, 4.9),
  (410019, 'DualBrew', 400010, 'Y', 460.29, 12, 9.69, '28.9 x 23.2 x 39.5 cm', 1550, 4.5),
  (410020, '12 Cup', 400011, 'Y', 105.39, 12, 8.45, '21.3 x 26.7 x 34.5 cm', 1230, 4.6),
  (410021, 'Stainless Steel', 400012, 'Y', 129.99, 12, 8.95, '20.07 x 20.07 x 36.07 cm', 1200, 4.3),
  (410022, 'Prorammable', 400013, 'Y', 105.54, 8, 6.2, '20.1 x 20.1 x 36.1 cm', 940, 4.2),
  (410023, '12 Cup', 400014, 'Y', 197.60, 12, 14.60, '25.4 x 32.39 x 37.47 cm', 1670, 3.9),
  (410024, '8 Cup', 400014, 'Y', 167.50, 8, 10.90, '21.4 x 27.19 x 32.47 cm', 1200, 4.1),
  (410025, 'Regular', 400015, 'Y', 279.99, 12, 12.20, '32.08 x 35.56 x 45.09 cm', 1200, 4.5),
  (410026, 'GRIND & BREW PLUS', 400015, 'Y', 349.99, 12, 16.20, '32.08 x 35.56 x 45.09 cm', 1340, 4.8),
  (410027, 'Programmable', 400016, 'Y', 430.79, 8, 13.40, '‎33.02 x 26.92 x 36.32 cm', 1400, 4.2),
  (410028, 'Steam Espresso', 400017, 'Y', 83.95, 4, 2.65, '20.3 x 16.5 x 26.7 cm', 820, 3.1),
  (410029, 'Grind Control', 400018, 'Y', 320.50, 12, 16, '31.75 x 21.59 x 41.4 cm', 1100, 4.8),
  (410030, 'Free Carafe', 400019, 'Y', 270.10, 10, 5.5, '19.56 x 32.26 x 35.05 cm', 1200, 4.5),
  (410031, 'Programmable', 400020, 'Y', 140.00, 12, 12.3, '34.04 x 18.21 x 36.42 cm', 1100, 4.2);



INSERT INTO bcb_accessorys
  (product_id, accessory_id, accessory_name, accessory_desc) VALUES
  (410000, 500000, 'Cleaner', 'Cleans the stains'),
  (410001, 500000, 'Cleaner', 'Cleans the stains'),
  (410002, 500001, 'Filter', 'Different Sizes Filter'),
  (410007, 500002, 'Sipper', NULL),
  (410012, 500003, 'Rotating Filter', NULL),
  (410014, 500000, 'Cleaner', 'Cleans the stains'),
  (410015, 500001, 'Filter', 'Different Sizes Filter'),
  (410016, 500004, 'Crusher blade', 'Crushes the coffee beans'),
  (410017, 500005, 'Thermos Glass', NULL),
  (410026, 500006, 'Family Cups', '6 Cups for family'),
  (410031, 500007, 'Soft Wipes', NULL);



INSERT INTO bcb_product_colors 
  (product_id, color_id, color_name, color_desc) VALUES
  (410000, 610000, 'Black', NULL),
  (410000, 610001, 'Silver', NULL),
  (410001, 610002, 'Coffee Brown', 'Colored Body face and Silver Back'),
  (410002, 610003, 'Cream White', 'Colored Body with black buttons'),
  (410007, 610004, 'Black & Brown', 'Spotted Brown on Black'),
  (410009, 610005, 'White', NULL),
  (410011, 610006, 'Gray', NULL),
  (410017, 610007, 'Coffee Gold', 'Body Colored and Silver back'),
  (410017, 610008, 'Tinted Black', NULL),
  (410019, 610009, 'Cream Brown', NULL),
  (410019, 610010, 'Light Brown', 'Full Body Colored'),
  (410020, 610011, 'Sea Gray', 'Full Body Colored'),
  (410021, 610001, 'Silver', NULL),
  (410021, 610011, 'Sea Gray', 'Full Body Colored'),
  (410021, 610004, 'Black & Brown', 'Spotted Brown on Black'),
  (410022, 610007, 'Coffee Gold', 'Body Colored and Silver back'),
  (410024, 610012, 'Coffee Light', 'Full Body Colored, Buttons White'),
  (410026, 610013, 'Dark Brown', 'Front Colored, Silver Back'),
  (410028, 610012, 'Coffee Light', 'Full Body Colored, Buttons White'),
  (410029, 610000, 'Black', NULL),
  (410031, 610008, 'Tinted Black', NULL);

---------------------------------------------------------------------------------------------------------------
-- ============================================================================================================


-- Regions, Locations, Salesoffices, Warehouses & Inventorys --------------------------------------------------
-- ============================================================================================================

INSERT INTO bcb_regions VALUES
  (1100, 'Sourthern ontario'),
  (1101, 'Manitoba & Sasketchwan'),
  (1102, 'Western Canada');


INSERT INTO bcb_locations
  (location_id, postal_code, city, region_id, province) VALUES
  (DEFAULT, 'M3K4J1', 'Toronto', 1100, 'Ontario'),
  (DEFAULT, 'M6T4J9', 'Toronto', 1100, 'Ontario'),
  (DEFAULT, 'L3K4J1', 'Hamilton', 1100, 'Ontario'),
  (DEFAULT, 'L3P1T7', 'Hamilton', 1100, 'Ontario'),
  (DEFAULT, 'R2P1L9', 'Winnipeg', 1101, 'Manitoba'),
  (DEFAULT, 'R3H4V8', 'Winnipeg', 1101, 'Manitoba'),
  (DEFAULT, 'S4T8W4', 'Regia', 1101, 'Sasketchewan'),
  (DEFAULT, 'S6B7D1', 'Regina', 1101, 'Sasketchewan'),
  (DEFAULT, 'T3D3V1', 'Calgary', 1102, 'Alberta'),
  (DEFAULT, 'T2J1C5', 'Calgary', 1102, 'Alberta'),
  (DEFAULT, 'V5N8W3', 'Vancouver', 1102, 'British Columbia'),
  (DEFAULT, 'V7G1T2', 'vancouver', 1102, 'British Columbia'); 



INSERT INTO bcb_salesoffices
  (sales_office_id, sales_office, location_id, so_phone_no, so_email_id, so_street_address) VALUES
  (12000, 'Toronto', 8000000, '12294459987', 'sotoronto@beatcrimbrown.com', '123 Quarters Square, Ralph Lane'),
  (12001, 'Hamilton', 8000002, '15394489767', 'sohamilton@beatcrimbrown.com', '21 Dwarf Park, Weber Street'),
  (12002, 'Winnipeg', 8000004, '12246678123', 'sowinnipeg@beatcrimbrown.com', '41 Fresher Square'),
  (12003, 'Regina', 8000006, '12176638912', 'soregina@beatcrimbrown.com', '671 Andit Business Park'),
  (12004, 'Calgary', 8000008, '12984679327', 'socalgary@beatcrimbrown.com', '89 Yoler Park'),
  (12005, 'Vancouver', 8000010, '12434859347', 'sovancouver@beatcrimbrown.com', '190 Sober Square');



INSERT INTO bcb_warehouses VALUES
  (18000, '131 Godown Street', '12389459922', 'Udai Shenoy', 8000001),
  (18001, '121 Drums Street', '13289857722', 'Steve Shepherd', 8000003),
  (18002, '11 Newblue Street', '12459115522', 'Razi Khan', 8000005),
  (18003, '156 Doland Street', '14594599922', 'Jazer Ron', 8000007),
  (18004, '12 Gowin Bay', '16386758222', 'Bob Shezy', 8000009),
  (18005, '11 Qtown Street', '13889459652', 'Harinder Singh', 8000011);



INSERT INTO bcb_inventorys VALUES
  (410001, 18000, 100), (410001, 18001, 200), (410001, 18002, 300), (410001, 18003, 400), (410001, 18004, 120), (410001, 18005, 310),
  (410002, 18001, 200), (410002, 18002, 100), (410002, 18003, 120), (410003, 18001, 160), (410003, 18002, 130), (410003, 18005, 230),
  (410004, 18002, 170), (410004, 18003, 90), (410004, 18005, 20), (410005, 18001, 0), (410005, 18002, 23), (410005, 18004, 50),
  (410006, 18001, 20), (410006, 18002, 30), (410006, 18003, 40), (410006, 18005, 1), (410007, 18003, 37), (410008, 18000, 100),
  (410008, 18001, 200), (410008, 18002, 300), (410008, 18003, 400), (410008, 18004, 120), (410008, 18005, 310), (410009, 18000, 200),
  (410009, 18001, 100), (410009, 18002, 120), (410009, 18003, 160), (410009, 18004, 130), (410009, 18005, 230), (410010, 18002, 170),
  (410010, 18003, 90), (410010, 18005, 20), (410013, 18001, 0), (410013, 18002, 23), (410013, 18004, 50), (410015, 18001, 20),
  (410015, 18002, 30),  (410015, 18003, 40), (410015, 18005, 1), (410016, 18003, 0), (410016, 18004, 303), (410017, 18001, 124),
  (410017, 18002, 250), (410018, 18003, 70), (410018, 18004, 13), (410018, 18005, 12), (410019, 18001, 11), (410019, 18002, 120),
  (410019, 18003, 300), (410019, 18004, 300), (410019, 18005, 300), (410020, 18001, 300), (410020, 18002, 300), (410020, 18003, 300),
  (410020, 18004, 300), (410020, 18005, 300), (410021, 18000, 303), (410021, 18001, 124), (410022, 18002, 250), (410022, 18003, 70),
  (410023, 18004, 13), (410024, 18005, 12), (410025, 18001, 11), (410026, 18002, 120), (410026, 18003, 300), (410027, 18004, 300),
  (410027, 18005, 300), (410028, 18001, 300), (410029, 18002, 300), (410030, 18003, 300), (410031, 18004, 300), (410031, 18005, 300);

---------------------------------------------------------------------------------------------------------------------------------
-- ==============================================================================================================================


-- Location2s for Customers and Employees ----------------------------------------------------------------------
-- =============================================================================================================

INSERT INTO bcb_location2s
  (location_id, postal_code, city, province) VALUES
  (DEFAULT, 'L8P1C5', 'Hamilton', 'Ontario'),
  (DEFAULT, 'N2V2V9', 'Waterloo', 'Ontario'),
  (DEFAULT, 'M3K4J1', 'Toronto', 'Ontario'),
  (DEFAULT, 'M6N5A3', 'Toronto', 'Ontario'), 
  (DEFAULT, 'N5V3V4', 'London', 'Ontario'),
  (DEFAULT, 'N1H3L1', 'Guelph', 'Ontario'),
  (DEFAULT, 'R3P1T7', 'Winnipeg', 'Manitoba'),
  (DEFAULT, 'R2J1T6', 'Winnipeg', 'Manitoba'),
  (DEFAULT, 'R7C1T6', 'Brandon', 'Manitoba'),
  (DEFAULT, 'R7C1H5', 'Brandon', 'Manitoba'),
  (DEFAULT, 'S4S2Y3', 'Regina', 'Sasketchewan'),
  (DEFAULT, 'T3G9R3', 'Calgary', 'Alberta'),
  (DEFAULT, 'V5N1V8', 'Vancouver', 'British Columbia'),
  (DEFAULT, 'V7G1H3', 'Vancouver', 'British Columbia');
  


-- Customers & Employees --------------------------------------------------------------------------------
-- ======================================================================================================

INSERT INTO bcb_customers 
  (customer_id, first_name, last_name, email_id, phone_no, street_address, location_id) VALUES
  (DEFAULT, 'Sumeet', 'Singh', 'sumeetsingh@gmail.com', 15192237788, '129 Quanvy Ave', 7000000),
  (DEFAULT, 'Alwin', 'Kane', 'alwinkane@gmail.com', 15123468912, '234 Roders Bay', 7000001),
  (DEFAULT, 'Ravi', 'Shah', 'ravishah@gmail.com', 12247784167, '14 Mister Street', 7000002),
  (DEFAULT, 'Brian', 'Ralph', 'brianralphh@gmail.com', NULL, '127 Quanvy Ave', 7000003),
  (DEFAULT, 'Mary', 'Cooper', 'marycooper@gmail.com', NULL, '123 Tombay', 7000004),
  (DEFAULT, 'Tom', 'Karron', NULL, 17784239965, NULL, NULL),
  (DEFAULT, 'Louis', 'Viter', NULL, 18893214490, NULL, NULL),
  (DEFAULT, 'Supria', 'Thukral', NULL, 12389453188, '23 Brit Street', 7000005),
  (DEFAULT, 'Adnan', 'Ali', 'adnanali@hotmail.com', 14569873125, '12 Quinter Bay', 7000006),
  (DEFAULT, 'Ameer', 'Jahan', NULL, NULL, '34 Ramsbay', 7000007),
  (DEFAULT, 'Harry', 'Gill', NULL, NULL, NULL, NULL),
  (DEFAULT, 'James', 'Fredrick', 'jamesf@outlook.com', 18938714378, '13 Tim Ave', 7000007),
  (DEFAULT, 'Samantha', 'John', 'sjohn@yahoo.com', NULL, NULL, NULL),
  (DEFAULT, 'Disha', 'Patel', 'dishap@gmail.com', 17894534412, '452 Brander Drive', 7000008),
  (DEFAULT, 'Nancy', 'Williams', 'nancywil@yahoo.com', 15195628821, NULL, NULL),
  (DEFAULT, 'Harvey', 'Knocker', 'harveyknocker@gmail.com', 15123465517, '34 Bowler Street', 7000009);



INSERT INTO bcb_employees  
  (employee_id, emp_first_name, emp_last_name, soc_insurance_no, hire_date, job_code, salary, sales_office_id, emp_email_id, emp_phone_no, street_address, location_id) VALUES
  (DEFAULT, 'Jasneet', 'Kaur', 231789456, '2019-03-01', 'J', 67000, 12000, 'jskaur@outlook.com', '15195207785', '12 Amqueen Ave', 7000002),
  (DEFAULT, 'Thomas', 'Underwood', 231789424, '2019-02-01', 'T', NULL, 12000, 'thunderwood@outlook.com', '15195207456', '19 Amqueen Ave', 7000002),
  (DEFAULT, 'Gurpreet', 'Singh', 236881244, '2019-01-01', 'M', 105000, 12000, 'gurpreets@yahoo.com', '15195617713', '21 Varset Bay', 7000003),
  (DEFAULT, 'Rahul', 'Jha', 236782345, '2019-04-01', 'J', 71000, 12001, 'rjkp@outlook.com', '12247766645', '504 Astroid Street', 7000000),
  (DEFAULT, 'Ripon', 'Simon', 453998216, '2019-03-01', 'M', 90000, 12001, 'ripontp@gmail.com', '17138862214', 'Ramsbay Ave', 7000000),
  (DEFAULT, 'Sania', 'Ibrahim', 383245990, '2019-05-01', 'J', 65000, 12002, 'saniahm@gmail.com', '17789953123', '14 Goliber Street', 7000006),
  (DEFAULT, 'Faizal', 'Hussein', 427287910, '2019-04-01', 'M', 109000, 12002, 'faizhus@gmail.com', '12297128892', '34 Rinder Ave', 7000007),
  (DEFAULT, 'Tom', 'Pearson', 289261610, '2019-07-01', 'J', 78000, 12003, 'tompson@yahoo.com', '15607812391', '238 Tiger Street', 7000010),
  (DEFAULT, 'Alicia', 'Pearson', 586715990, '2019-05-01', 'J', 165000, 12003, 'alciap@outlook.com', '18846349910', '149 Hasby Drive', 7000010),
  (DEFAULT, 'Gopal', 'Shinde', 883245990, '2019-09-01', 'J', 78000, 12004, 'gopalshinde@gmail.com', '17606653312', '563 Front Street', 7000011),
  (DEFAULT, 'Jason', 'Cromson', 737267390, '2019-01-01', 'M', 160000, 12004, 'jasonc@yahoo.com', '17789953653', '190 Crofter Street', 7000011),
  (DEFAULT, 'Nexer', 'Frazer', 497823456, '2019-05-01', 'J', 63000, 12005, 'nexfrp@gmail.com', '16789989123', '457 Vitert Street', 7000012),
  (DEFAULT, 'Veronica', 'Zester', 647901236, '2019-03-01', 'M', 120000, 12005, 'veronzset@gmail.com', '15168946623', '721 Under Bay', 7000013);
 
----------------------------------------------------------------------------------------------------------------------------------------
-- =====================================================================================================================================



---======== ORDERS AND ORDER LINES ================================================================================

-- Orders with 1 product on each order -----------------------------------
-- ======================================================================= 

INSERT INTO bcb_orders 
  (order_id, order_date, order_time, total_price, customer_id, employee_id) VALUES
  (NEXTVAL FOR order_id_seq, '2020-01-01', '12:44 PM', 220.50, 10000000, 20000000);

INSERT INTO bcb_order_lines 
  (order_id, product_id, sr_no, quantity) VALUES
  (PREVIOUS VALUE FOR order_id_seq, 410000, 1, 2);

INSERT INTO bcb_orders 
  (order_id, order_date, order_time, total_price, customer_id, employee_id) VALUES
  (NEXTVAL FOR order_id_seq, '2020-01-03', '01:29 PM', 120.90, 10000001, 20000000);

INSERT INTO bcb_order_lines 
  (order_id, product_id, sr_no, quantity) VALUES
  (PREVIOUS VALUE FOR order_id_seq, 410002, 1, 1);

INSERT INTO bcb_orders 
  (order_id, order_date, order_time, total_price, customer_id, employee_id) VALUES
  (NEXTVAL FOR order_id_seq, '2020-01-03', '11:24 AM', 220.50, 10000002, 20000000);

INSERT INTO bcb_order_lines 
  (order_id, product_id, sr_no, quantity) VALUES
  (PREVIOUS VALUE FOR order_id_seq, 410000, 1, 2);

INSERT INTO bcb_orders 
  (order_id, order_date, order_time, total_price, customer_id, employee_id) VALUES
  (NEXTVAL FOR order_id_seq, '2020-01-05', '10:32 AM', 89.78, 10000003, 20000003);

INSERT INTO bcb_order_lines 
  (order_id, product_id, sr_no, quantity) VALUES
  (PREVIOUS VALUE FOR order_id_seq, 410003, 1, 1);

INSERT INTO bcb_orders 
  (order_id, order_date, order_time, total_price, customer_id, employee_id) VALUES
  (NEXTVAL FOR order_id_seq, '2020-01-08', '10:44 AM', 350.70, 10000004, 20000003);

INSERT INTO bcb_order_lines 
  (order_id, product_id, sr_no, quantity) VALUES
  (PREVIOUS VALUE FOR order_id_seq, 410008, 1, 2);

INSERT INTO bcb_orders 
  (order_id, order_date, order_time, total_price, customer_id, employee_id) VALUES
  (NEXTVAL FOR order_id_seq, '2020-01-09', '12:39 PM', 350.65, 10000005, 20000000);

INSERT INTO bcb_order_lines 
  (order_id, product_id, sr_no, quantity) VALUES
  (PREVIOUS VALUE FOR order_id_seq, 410005, 1, 3);

INSERT INTO bcb_orders 
  (order_id, order_date, order_time, total_price, customer_id, employee_id) VALUES
  (NEXTVAL FOR order_id_seq, '2020-01-11', '01:39 PM', 88.90, 10000006, 20000000);

INSERT INTO bcb_order_lines 
  (order_id, product_id, sr_no, quantity) VALUES
  (PREVIOUS VALUE FOR order_id_seq, 410004, 1, 1);

INSERT INTO bcb_orders 
  (order_id, order_date, order_time, total_price, customer_id, employee_id) VALUES
  (NEXTVAL FOR order_id_seq, '2020-01-12', '01:31 PM', 350.65, 10000007, 20000003);

INSERT INTO bcb_order_lines 
  (order_id, product_id, sr_no, quantity) VALUES
  (PREVIOUS VALUE FOR order_id_seq, 410005, 1, 3);

INSERT INTO bcb_orders 
  (order_id, order_date, order_time, total_price, customer_id, employee_id) VALUES
  (NEXTVAL FOR order_id_seq, '2020-01-13', '03:29 PM', 81.70, 10000008, 20000005);

INSERT INTO bcb_order_lines 
  (order_id, product_id, sr_no, quantity) VALUES
  (PREVIOUS VALUE FOR order_id_seq, 410003, 1, 1);

INSERT INTO bcb_orders 
  (order_id, order_date, order_time, total_price, customer_id, employee_id) VALUES
  (NEXTVAL FOR order_id_seq, '2020-01-18', '04:33 PM', 1480.70, 10000009, 20000005);

INSERT INTO bcb_order_lines 
  (order_id, product_id, sr_no, quantity) VALUES
  (PREVIOUS VALUE FOR order_id_seq, 410019, 1, 3);



-- Orders with 2 products on each order -----------------------------------
-- ========================================================================   

INSERT INTO bcb_orders 
  (order_id, order_date, order_time, total_price, customer_id, employee_id) VALUES
  (NEXTVAL FOR order_id_seq, '2020-02-01', '11:44 PM', 439.60, 10000000, 20000000);

INSERT INTO bcb_order_lines 
  (order_id, product_id, sr_no, quantity) VALUES
  (PREVIOUS VALUE FOR order_id_seq, 410008, 1, 2),
  (PREVIOUS VALUE FOR order_id_seq, 410001, 2, 2);

INSERT INTO bcb_orders 
  (order_id, order_date, order_time, total_price, customer_id, employee_id) VALUES
  (NEXTVAL FOR order_id_seq, '2020-02-03', '04:29 PM', 126.80, 10000001, 20000000);

INSERT INTO bcb_order_lines 
  (order_id, product_id, sr_no, quantity) VALUES
  (PREVIOUS VALUE FOR order_id_seq, 410001, 1, 1),
  (PREVIOUS VALUE FOR order_id_seq, 410003, 2, 1);

INSERT INTO bcb_orders 
  (order_id, order_date, order_time, total_price, customer_id, employee_id) VALUES
  (NEXTVAL FOR order_id_seq, '2020-02-03', '10:24 AM', 494.40, 10000002, 20000000);

INSERT INTO bcb_order_lines 
  (order_id, product_id, sr_no, quantity) VALUES
  (PREVIOUS VALUE FOR order_id_seq, 410009, 1, 2),
  (PREVIOUS VALUE FOR order_id_seq, 410004, 2, 1);

INSERT INTO bcb_orders 
  (order_id, order_date, order_time, total_price, customer_id, employee_id) VALUES
  (NEXTVAL FOR order_id_seq, '2020-02-05', '11:32 AM', 623.79, 10000003, 20000003);

INSERT INTO bcb_order_lines 
  (order_id, product_id, sr_no, quantity) VALUES
  (PREVIOUS VALUE FOR order_id_seq, 410003, 1, 1),
  (PREVIOUS VALUE FOR order_id_seq, 410008, 2, 3);

INSERT INTO bcb_orders 
  (order_id, order_date, order_time, total_price, customer_id, employee_id) VALUES
  (NEXTVAL FOR order_id_seq, '2020-02-08', '03:44 PM', 238.76, 10000004, 20000003);

INSERT INTO bcb_order_lines 
  (order_id, product_id, sr_no, quantity) VALUES
  (PREVIOUS VALUE FOR order_id_seq, 410008, 1, 1),
  (PREVIOUS VALUE FOR order_id_seq, 410007, 2, 1);

INSERT INTO bcb_orders 
  (order_id, order_date, order_time, total_price, customer_id, employee_id) VALUES
  (NEXTVAL FOR order_id_seq, '2020-03-09', '01:39 PM', 587.53, 10000005, 20000000);

INSERT INTO bcb_order_lines 
  (order_id, product_id, sr_no, quantity) VALUES
  (PREVIOUS VALUE FOR order_id_seq, 410005, 1, 1),
  (PREVIOUS VALUE FOR order_id_seq, 410019, 2, 1);

INSERT INTO bcb_orders 
  (order_id, order_date, order_time, total_price, customer_id, employee_id) VALUES
  (NEXTVAL FOR order_id_seq, '2020-08-11', '04:39 PM', 298.67, 10000006, 20000000);

INSERT INTO bcb_order_lines 
  (order_id, product_id, sr_no, quantity) VALUES
  (PREVIOUS VALUE FOR order_id_seq, 410004, 1, 1),
  (PREVIOUS VALUE FOR order_id_seq, 410023, 2, 1);

INSERT INTO bcb_orders 
  (order_id, order_date, order_time, total_price, customer_id, employee_id) VALUES
  (NEXTVAL FOR order_id_seq, '2020-09-12', '02:31 PM', 532.48, 10000007, 20000003);

INSERT INTO bcb_order_lines 
  (order_id, product_id, sr_no, quantity) VALUES
  (PREVIOUS VALUE FOR order_id_seq, 410015, 1, 2),
  (PREVIOUS VALUE FOR order_id_seq, 410013, 2, 1);

INSERT INTO bcb_orders 
  (order_id, order_date, order_time, total_price, customer_id, employee_id) VALUES
  (NEXTVAL FOR order_id_seq, '2020-09-13', '01:29 PM', 403.67, 10000008, 20000005);

INSERT INTO bcb_order_lines 
  (order_id, product_id, sr_no, quantity) VALUES
  (PREVIOUS VALUE FOR order_id_seq, 410012, 1, 1),
  (PREVIOUS VALUE FOR order_id_seq, 410013, 2, 1);

INSERT INTO bcb_orders 
  (order_id, order_date, order_time, total_price, customer_id, employee_id) VALUES
  (NEXTVAL FOR order_id_seq, '2020-09-18', '05:33 PM', 718.65, 10000009, 20000005);

INSERT INTO bcb_order_lines 
  (order_id, product_id, sr_no, quantity) VALUES
  (PREVIOUS VALUE FOR order_id_seq, 410019, 1, 1),
  (PREVIOUS VALUE FOR order_id_seq, 410003, 2, 3);



-- Orders with minimum 3 products on each order -----------------------------------
-- ================================================================================   

INSERT INTO bcb_orders 
  (order_id, order_date, order_time, total_price, customer_id, employee_id) VALUES
  (NEXTVAL FOR order_id_seq, '2021-02-01', '11:44 PM', 737.89, 10000000, 20000000);

INSERT INTO bcb_order_lines 
  (order_id, product_id, sr_no, quantity) VALUES
  (PREVIOUS VALUE FOR order_id_seq, 410003, 1, 2),
  (PREVIOUS VALUE FOR order_id_seq, 410004, 2, 2),
  (PREVIOUS VALUE FOR order_id_seq, 410009, 3, 2);

INSERT INTO bcb_orders 
  (order_id, order_date, order_time, total_price, customer_id, employee_id) VALUES
  (NEXTVAL FOR order_id_seq, '2021-02-03', '04:29 PM', 339.54, 10000001, 20000000);

INSERT INTO bcb_order_lines 
  (order_id, product_id, sr_no, quantity) VALUES
  (PREVIOUS VALUE FOR order_id_seq, 410004, 1, 1),
  (PREVIOUS VALUE FOR order_id_seq, 410008, 2, 1),
  (PREVIOUS VALUE FOR order_id_seq, 410002, 3, 1);

INSERT INTO bcb_orders 
  (order_id, order_date, order_time, total_price, customer_id, employee_id) VALUES
  (NEXTVAL FOR order_id_seq, '2021-02-03', '10:24 AM', 267.31, 10000002, 20000000);

INSERT INTO bcb_order_lines 
  (order_id, product_id, sr_no, quantity) VALUES
  (PREVIOUS VALUE FOR order_id_seq, 410001, 1, 1),
  (PREVIOUS VALUE FOR order_id_seq, 410002, 2, 1),
  (PREVIOUS VALUE FOR order_id_seq, 410003, 3, 1),
  (PREVIOUS VALUE FOR order_id_seq, 410007, 4, 1);

INSERT INTO bcb_orders 
  (order_id, order_date, order_time, total_price, customer_id, employee_id) VALUES
  (NEXTVAL FOR order_id_seq, '2021-02-05', '11:32 AM', 285.43, 10000003, 20000003);

INSERT INTO bcb_order_lines 
  (order_id, product_id, sr_no, quantity) VALUES
  (PREVIOUS VALUE FOR order_id_seq, 410002, 1, 1),
  (PREVIOUS VALUE FOR order_id_seq, 410001, 2, 1),
  (PREVIOUS VALUE FOR order_id_seq, 410008, 3, 1);

INSERT INTO bcb_orders 
  (order_id, order_date, order_time, total_price, customer_id, employee_id) VALUES
  (NEXTVAL FOR order_id_seq, '2021-02-08', '03:44 PM', 321.98, 10000004, 20000003);

INSERT INTO bcb_order_lines 
  (order_id, product_id, sr_no, quantity) VALUES
  (PREVIOUS VALUE FOR order_id_seq, 410008, 1, 1),
  (PREVIOUS VALUE FOR order_id_seq, 410007, 2, 1),
  (PREVIOUS VALUE FOR order_id_seq, 410001, 3, 1);

INSERT INTO bcb_orders 
  (order_id, order_date, order_time, total_price, customer_id, employee_id) VALUES
  (NEXTVAL FOR order_id_seq, '2021-03-09', '01:39 PM', 623.87, 10000005, 20000000);

INSERT INTO bcb_order_lines 
  (order_id, product_id, sr_no, quantity) VALUES
  (PREVIOUS VALUE FOR order_id_seq, 410003, 1, 1),
  (PREVIOUS VALUE FOR order_id_seq, 410024, 2, 1),
  (PREVIOUS VALUE FOR order_id_seq, 410011, 3, 1);

INSERT INTO bcb_orders 
  (order_id, order_date, order_time, total_price, customer_id, employee_id) VALUES
  (NEXTVAL FOR order_id_seq, '2021-08-11', '04:39 PM', 845.65, 10000006, 20000000);

INSERT INTO bcb_order_lines 
  (order_id, product_id, sr_no, quantity) VALUES
  (PREVIOUS VALUE FOR order_id_seq, 410002, 1, 1),
  (PREVIOUS VALUE FOR order_id_seq, 410025, 2, 1),
  (PREVIOUS VALUE FOR order_id_seq, 410019, 3, 1);

INSERT INTO bcb_orders 
  (order_id, order_date, order_time, total_price, customer_id, employee_id) VALUES
  (NEXTVAL FOR order_id_seq, '2021-09-12', '02:31 PM', 767.64, 10000007, 20000003);

INSERT INTO bcb_order_lines 
  (order_id, product_id, sr_no, quantity) VALUES
  (PREVIOUS VALUE FOR order_id_seq, 410019, 1, 1),
  (PREVIOUS VALUE FOR order_id_seq, 410018, 2, 1),
  (PREVIOUS VALUE FOR order_id_seq, 410021, 3, 1);

INSERT INTO bcb_orders 
  (order_id, order_date, order_time, total_price, customer_id, employee_id) VALUES
  (NEXTVAL FOR order_id_seq, '2021-09-13', '01:29 PM', 585.76, 10000008, 20000005);

INSERT INTO bcb_order_lines 
  (order_id, product_id, sr_no, quantity) VALUES
  (PREVIOUS VALUE FOR order_id_seq, 410000, 1, 1),
  (PREVIOUS VALUE FOR order_id_seq, 410003, 2, 1),
  (PREVIOUS VALUE FOR order_id_seq, 410005, 3, 1),
  (PREVIOUS VALUE FOR order_id_seq, 410007, 4, 1),
  (PREVIOUS VALUE FOR order_id_seq, 410009, 5, 1);

INSERT INTO bcb_orders 
  (order_id, order_date, order_time, total_price, customer_id, employee_id) VALUES
  (NEXTVAL FOR order_id_seq, '2021-09-18', '05:33 PM', 987.63, 10000009, 20000005);

INSERT INTO bcb_order_lines 
  (order_id, product_id, sr_no, quantity) VALUES
  (PREVIOUS VALUE FOR order_id_seq, 410021, 1, 1),
  (PREVIOUS VALUE FOR order_id_seq, 410026, 2, 1),
  (PREVIOUS VALUE FOR order_id_seq, 410012, 3, 1),
  (PREVIOUS VALUE FOR order_id_seq, 410018, 4, 1);

-- ==========================================================================================================

-- INSERT INTO PIECES ---------------------------------------
-- ==========================================================
INSERT INTO bcb_pieces
  (piece_id, serial_number, order_id, product_id) VALUES
  (300000001, 'SRT45-UI76', 90000000, 410000),
  (300000002, 'DFRT-6734', 90000001, 410002),
  (300000003, 'GHTRES342', 90000002, 410000),
  (300000004, 'HJTR57SD', 90000003, 410003),
  (300000005, 'JHGFSVXC09', 90000004, 410008),
  (300000006, 'GHSTKSV875', 90000005, 410005),
  (300000007, 'YUGF567', 90000006, 410004),
  (300000008, 'FGSCTYF4327', 90000007, 410005),
  (300000009, 'KJF-0982FRT', 90000008, 410003),
  (300000010, 'HGFD56TY-987', 90000009, 410019),
  (300000011, 'JH08-UUY', 90000010, 410008),
  (300000012, 'GHF4523-LK', 90000010, 410001),
  (300000013, 'JHFVG-9065', 90000011, 410001),
  (300000014, 'OTY09875-89', 90000011, 410003),
  (300000015, 'JHFOY-543', 90000012, 410009),
  (300000016, 'HJGFDS346', 90000012, 410004),
  (300000017, 'KJGCVTRE23', 90000013, 410003),
  (300000018, 'JKHFS45GF', 90000013, 410008),
  (300000019, 'JKH56-YRTS', 90000014, 410008),
  (300000020, 'HJSUYT-6723', 90000014, 410007),
  (300000021, 'GHFSUY-876', 90000015, 410005),
  (300000022, 'HGSFCXN-996', 90000015, 410019),
  (300000023, 'HGSCXTYS-892', 90000016, 410004),
  (300000024, 'HJSVXC7809', 90000016, 410023),
  (300000025, 'HSGDVXI9056', 90000017, 410015),
  (300000026, 'GHSCZO89423', 90000017, 410013),
  (300000027, 'LKACZ6543-8956', 90000018, 410012),
  (300000028, 'ZXC89TR', 90000018, 410013),
  (300000029, 'BNVXTF96', 90000019, 410019),
  (300000030, 'HJSVC-987', 90000019, 410003),
  (300000031, 'GHSXCTYCV89', 90000020, 410003),
  (300000032, 'GHSCXYUDT3', 90000020, 410004),
  (300000033, 'JH99876', 90000020, 410009),
  (300000034, 'JTYUDS5634', NULL, 410003);


-- =================================================================================================
-- Select Statements to select data
----------------------------------------------------------------------------------------------------  
  
SELECT * FROM bcb_companys;
SELECT * FROM bcb_brands;
SELECT * FROM bcb_models;
SELECT * FROM bcb_types;
SELECT * FROM bcb_products;
SELECT * FROM bcb_accessorys;
SELECT * FROM bcb_product_colors;
SELECT * FROM bcb_pieces;
SELECT * FROM bcb_orders;
SELECT * FROM bcb_order_lines;
SELECT * FROM bcb_customers;
SELECT * FROM bcb_employees;
SELECT * FROM bcb_location2s;
SELECT * FROM bcb_salesoffices;
SELECT * FROM bcb_locations;
SELECT * FROM bcb_regions;
SELECT * FROM bcb_warehouses;
SELECT * FROM bcb_inventorys;

-- =================================================================================================================================


-- ================================================================================================================
--                                  3. /* CONSTRAINTS TESTING */
-- ================================================================================================================

-- NOTE: Since the valid data is already input in the tables and it has been accepted,
--       the CONSTRAINT Testing would only be done on the invalid data, and the expected results are invalid data being rejected.


-- 1. NOT NULL CONSTRAINTS ----------------------------------
-- ==========================================================

-- NOT NULL - CONSTRAINT TEST - 1
-- Purpose - Confirm the NOT NULL CONSTRAINT on the Column company_name in Table bcb_companys
-- INVALID TEST 
--    EXPECTED RESULTS: Insert Fails as not allowed by the constraint.
--    ACTION:-
INSERT INTO bcb_companys
  (company_id, company_name, contact_person, contact_no) VALUES
  (DEFAULT, NULL, 'Jay Martin', '14187843212');

--- TEST RESULTS:-
--- SQL Error [23502]: [SQL0407] Null values not allowed in column or variable COMPANY_NAME.



-- NOT NULL - CONSTRAINT TEST - 2
-- Purpose - Confirm the NOT NULL CONSTRAINT on the Column type_name in Table bcb_types
-- INVALID TEST 
--    EXPECTED RESULTS: Insert Fails as not allowed by the constraint.
--    ACTION:-
INSERT INTO bcb_types
  (type_id, type_name, type_desc, technology) VALUES
  (103, NULL, 'Latte Maker', NULL);

--- TEST RESULTS:-
--- SQL Error [23502]: [SQL0407] Null values not allowed in column or variable TYPE_NAME.



-- 2. DEFAULT CONSTRAINTS -------------------------------------------
-- ==================================================================

-- DEFAULT - CONSTRAINT TEST - 1
-- Purpose - Confirm the DEFAULT CONSTRAINT on the Column warranty_years in Table bcb_models
-- VALID TEST 
--    EXPECTED RESULTS: Insert adds row in the Table bcb_models with default warranty_years as 1 .
--    ACTION:-
INSERT INTO bcb_models
  (model_id, model, description, brand_id, type_id, warranty_years, voltage) VALUES
  (400040, 'HJ4R76', '12 Cup Digital Coffee Maker', 31000, 101, DEFAULT, 240);

SELECT * FROM bcb_models WHERE model_id = 400040;
--- TEST RESULTS:- Row Addition Successful
/*
 MODEL_ID|MODEL |DESCRIPTION                |BRAND_ID|TYPE_ID|WARRANTY_YEARS|VOLTAGE|
--------+------+---------------------------+--------+-------+--------------+-------+
  400040|HJ4R76|12 Cup Digital Coffee Maker|   31000|    101|             1|    240|
 */



-- 3. PRIMARY KEY CONSTRAINTS -------------------------------------------------
-- ============================================================================

-- PRIMARY KEY - CONSTRAINT TEST - 1
-- Purpose - Confirm the PRIMARY KEY CONSTRAINT on the Table bcb_regions
-- VALID TEST 
--    EXPECTED RESULTS: Insert Successful.
--    ACTION:-
INSERT INTO bcb_regions VALUES
  (1103, 'Sourthern Alberta');

SELECT * FROM bcb_regions WHERE region_id = 1103;
--- TEST RESULTS:-
/*
 REGION_ID|REGION_NAME      |
---------+-----------------+
     1103|Sourthern Alberta|
 */

-- INVALID TEST 
--    EXPECTED RESULTS: Insert Fails as not allowed by constraint.
--    ACTION:-
INSERT INTO bcb_regions VALUES
  (1103, 'Sourthern California');

--- TEST RESULTS:-
--- SQL Error [23505]: [SQL0803] Duplicate key value specified.



-- PRIMARY KEY - CONSTRAINT TEST - 2
-- Purpose - Confirm the PRIMARY KEY CONSTRAINT on the Table bcb_warehouses
-- VALID TEST 
--    EXPECTED RESULTS: Insert Successful.
--    ACTION:-
INSERT INTO bcb_warehouses VALUES
  (18007, '121 Goman Street', '12389455562', 'Udai Shetty', 8000001);

  SELECT * FROM bcb_warehouses WHERE warehouse_id = 18007;
--- TEST RESULTS:-
/*
WAREHOUSE_ID|WH_STREET_ADDRESS|WH_PHONE_NO|CONTACT_PERSON|LOCATION_ID|
------------+-----------------+-----------+--------------+-----------+
       18007|121 Goman Street |12389455562|Udai Shetty   |    8000001|
 */

-- INVALID TEST 
--    EXPECTED RESULTS: Insert Fails as not allowed by constraint.
--    ACTION:-
INSERT INTO bcb_warehouses VALUES
  (18007, '121 Dorway Street', '12386621562', 'Usmaan Sheikh', 8000001);

--- TEST RESULTS:-
--- SQL Error [23505]: [SQL0803] Duplicate key value specified.



-- 4. UNIQUE KEY CONSTRAINT ------------------------------------
-- =============================================================

-- UNIQUE KEY - CONSTRAINT TEST - 1
-- Purpose - Confirm the UNIQUE KEY CONSTRAINT on the Column company_name in Table bcb_companys
-- VALID TEST 
--    EXPECTED RESULTS: Insert Successful.
--    ACTION:-
INSERT INTO bcb_companys
  (company_id, company_name, contact_person, contact_no) VALUES
  (DEFAULT, 'Best Coffee Makers', 'Louis Decker', '14183218911');

SELECT * FROM bcb_companys WHERE company_id = 30010;
--- TEST RESULTS:-
/*
COMPANY_ID|COMPANY_NAME      |CONTACT_PERSON|CONTACT_NO |
----------+------------------+--------------+-----------+
     30010|Best Coffee Makers|Louis Decker  |14183218911|
 */

-- INVALID TEST 
--    EXPECTED RESULTS: Insert Fails as not allowed by constraint.
--    ACTION:-
INSERT INTO bcb_companys
  (company_id, company_name, contact_person, contact_no) VALUES
  (DEFAULT, 'Best Coffee Makers', 'Louis Salson', '14155218911');

--- TEST RESULTS:-
--- SQL Error [23505]: [SQL0803] Duplicate key value specified.



-- 5. FOREIGN KEY CONSTRAINTS ---------------------------------------------------
-- ==============================================================================

-- FOREIGN KEY - CONSTRAINT TEST - 1
-- Purpose - Confirm the FOREIGN KEY CONSTRAINT on the foreign key model_id in Table bcb_products
-- INVALID TEST 
--    EXPECTED RESULTS: Insert Fails as not allowed by the constraint.
--    ACTION:-
INSERT INTO bcb_products
  (product_id, mod_variant, model_id, active_status, price, cup_capacity, weight_pounds, dimensions, wattage, ratings) VALUES
  (410036, 'MAXX', 400024, 'Y', 99.99, 4, 5.6, '23.4 x 29.1 x 35.1 cm', 1030, 4.1);
--- TEST RESULTS:-
--- SQL Error [23503]: [SQL0530] Operation not allowed by referential constraint BCB_PRODUCTS_MODEL_ID_FK in IBM7453.


-- FOREIGN KEY - CONSTRAINT TEST - 2
-- Purpose - Confirm the FOREIGN KEY CONSTRAINT on the foreign key location_id in Table bcb_customers
-- INVALID TEST 
--    EXPECTED RESULTS: Insert Fails as not allowed by the constraint.
--    ACTION:-
INSERT INTO bcb_customers 
  (customer_id, first_name, last_name, email_id, phone_no, street_address, location_id) VALUES
  (DEFAULT, 'Sumeet', 'Singhania', 'sumeetsh@gmail.com', 15176537898, '129 Roster Ave', 7000023);
--- TEST RESULTS:-
--- SQL Error [23503]: [SQL0530] Operation not allowed by referential constraint BCB_CUSTOMERS_LOCATION_ID_FK in IBM7453.
  

-- FOREIGN KEY - CONSTRAINT TEST - 3
-- Purpose - Confirm the FOREIGN KEY CONSTRAINT on the foreign key region_id in Table bcb_locations
-- INVALID TEST 
--    EXPECTED RESULTS: Insert Fails as not allowed by the constraint.
--    ACTION:-
INSERT INTO bcb_locations
  (location_id, postal_code, city, region_id, province) VALUES
  (DEFAULT, 'W8H4R6', 'Yellowknife', 1105, 'NWT');
--- TEST RESULTS:-
--- SQL Error [23503]: [SQL0530] Operation not allowed by referential constraint BCB_LOCATIONS_REGION_ID_FK in IBM7453.


-- FOREIGN KEY - CONSTRAINT TEST - 4
-- Purpose - Confirm the FOREIGN KEY CONSTRAINT on the foreign key company_id in Table bcb_brands
-- INVALID TEST 
--    EXPECTED RESULTS: Insert Fails as not allowed by the constraint.
--    ACTION:-
INSERT INTO bcb_brands 
  (brand_id, brand_name, company_id, brand_level) VALUES
  (DEFAULT, 'COFFEE MAXX', 30018, 'International High');
--- TEST RESULTS:-
--- SQL Error [23503]: [SQL0530] Operation not allowed by referential constraint BCB_BRANDS_COMPANY_ID_FK in IBM7453.



-- 6. CHECK CONSTRAINTS -----------------------------------------------------
-- ==========================================================================

-- CHECK - CONSTRAINT TEST - 1
-- Purpose - Confirm CHECK CONSTRAINT on the Column warranty_years in table bcb_models, warranty_years should be between 1 and 5.
-- INVALID TEST 
--    EXPECTED RESULTS: Insert Fails as not allowed by the CHECK Constraint.

--    ACTION:-
INSERT INTO bcb_models
  (model_id, model, description, brand_id, type_id, warranty_years, voltage) VALUES
  (400078, '4HUR4874', '12 Cup Digital Coffee Maker', 31000, 101, 8, 240);
--- TEST RESULTS:-
--- SQL Error [23513]: [SQL0545] INSERT, UPDATE, or MERGE not allowed by CHECK constraint.

--    ACTION:-
INSERT INTO bcb_models
  (model_id, model, description, brand_id, type_id, warranty_years, voltage) VALUES
  (400068, '4HASP4YU4', '12 Cup Digital Coffee Maker', 31000, 101, 0, 240);
--- TEST RESULTS:-
--- SQL Error [23513]: [SQL0545] INSERT, UPDATE, or MERGE not allowed by CHECK constraint.
  

  
-- CHECK - CONSTRAINT TEST - 2
-- Purpose - Confirm CHECK CONSTRAINT on the Column active_status in table bcb_products, active_status should be 'Y' or 'N'.
-- INVALID TEST 
--    EXPECTED RESULTS: Insert Fails as not allowed by the CHECK Constraint.
--    ACTION:-
INSERT INTO bcb_products
  (product_id, mod_variant, model_id, active_status, price, cup_capacity, weight_pounds, dimensions, wattage, ratings) VALUES
  (410036, 'MAXX', 400014, 'R', 99.99, 4, 5.6, '23.4 x 29.1 x 35.1 cm', 1030, 4.1);
--- TEST RESULTS:-
--- SQL Error [23513]: [SQL0545] INSERT, UPDATE, or MERGE not allowed by CHECK constraint.



-- CHECK - CONSTRAINT TEST - 3
-- Purpose - Confirm CHECK CONSTRAINT on the Column hire_date in table bcb_employees, hire_date must be >= '2017-09-01'.
-- INVALID TEST 
--    EXPECTED RESULTS: Insert Fails as not allowed by the CHECK Constraint.
--    ACTION:-
INSERT INTO bcb_employees  
  (employee_id, emp_first_name, emp_last_name, soc_insurance_no, hire_date, job_code, salary, sales_office_id, emp_email_id, emp_phone_no, street_address, location_id) VALUES
  (DEFAULT, 'Hari', 'Om', 231623456, '2010-03-01', 'J', 67000, 12000, 'hop@outlook.com', '1554327785', '67 Amqueen Ave', 7000002);
--- TEST RESULTS:-
--- SQL Error [23513]: [SQL0545] INSERT, UPDATE, or MERGE not allowed by CHECK constraint.



-- CHECK - CONSTRAINT TEST - 4
-- Purpose - Confirm CHECK CONSTRAINT on the Column job_code in table bcb_employees, job_code must be 'T', 'J', 'M'.
-- INVALID TEST 
--    EXPECTED RESULTS: Insert Fails as not allowed by the CHECK Constraint.
--    ACTION:-
INSERT INTO bcb_employees  
  (employee_id, emp_first_name, emp_last_name, soc_insurance_no, hire_date, job_code, salary, sales_office_id, emp_email_id, emp_phone_no, street_address, location_id) VALUES
  (DEFAULT, 'Hari', 'Om', 231623456, '2010-03-01', 'B', 67000, 12000, 'hop@outlook.com', '1554327785', '67 Amqueen Ave', 7000002);
--- TEST RESULTS:-
--- SQL Error [23513]: [SQL0545] INSERT, UPDATE, or MERGE not allowed by CHECK constraint.



-- CHECK - CONSTRAINT TEST - 5
-- Purpose - Confirm CHECK CONSTRAINT on the Column salary in table bcb_employees, salary must be between 60000 and 170000.
-- INVALID TEST 
--    EXPECTED RESULTS: Insert Fails as not allowed by the CHECK Constraint.

--    ACTION:-
INSERT INTO bcb_employees  
  (employee_id, emp_first_name, emp_last_name, soc_insurance_no, hire_date, job_code, salary, sales_office_id, emp_email_id, emp_phone_no, street_address, location_id) VALUES
  (DEFAULT, 'Hari', 'Om', 231623456, '2010-03-01', 'J', 40000, 12000, 'hop@outlook.com', '1554327785', '67 Amqueen Ave', 7000002);
--- TEST RESULTS:-
--- SQL Error [23513]: [SQL0545] INSERT, UPDATE, or MERGE not allowed by CHECK constraint.

--    ACTION:-
INSERT INTO bcb_employees  
  (employee_id, emp_first_name, emp_last_name, soc_insurance_no, hire_date, job_code, salary, sales_office_id, emp_email_id, emp_phone_no, street_address, location_id) VALUES
  (DEFAULT, 'Hari', 'Om', 231623456, '2010-03-01', 'M', 200000, 12000, 'hop@outlook.com', '1554327785', '67 Amqueen Ave', 7000002);
--- TEST RESULTS:-
--- SQL Error [23513]: [SQL0545] INSERT, UPDATE, or MERGE not allowed by CHECK constraint.



-- CHECK - CONSTRAINT TEST - 6
-- Purpose - Confirm CHECK CONSTRAINT on the Column avail_quantity in table bcb_inventorys, avail_quantity must be <= 500.
-- INVALID TEST 
--    EXPECTED RESULTS: Insert Fails as not allowed by the CHECK Constraint.
--    ACTION:-
INSERT INTO bcb_inventorys
  (product_id, warehouse_id, avail_quantity) VALUES
  (410030, 18005, 700);
--- TEST RESULTS:-
--- SQL Error [23513]: [SQL0545] INSERT, UPDATE, or MERGE not allowed by CHECK constraint.




