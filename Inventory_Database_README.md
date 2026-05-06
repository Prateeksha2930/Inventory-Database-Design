# 🗄️ Relational Database Design – Inventory & Sales Management

> **Designing and implementing a normalized MySQL database to modernize inventory management for an online clothing retailer**

---

## 📌 Project Overview

**Padmavati Vastra Bhandar**, a traditional Indian clothing retailer specializing in ethnic garments, was managing all inventory operations using physical notebooks — a system that severely limited scalability, caused data inconsistencies, and made it impossible to get real-time visibility into stock levels and sales performance.

This project replaces that manual system with a **centralized, normalized relational database** designed in LucidChart and implemented in MySQL Workbench. The database automatically updates inventory upon each recorded sale, eliminates data redundancy, enforces referential integrity, and provides the foundation for Tableau-powered business intelligence reporting that enables data-driven inventory and sales decisions.

---

## 🎯 Objectives

- Design a fully normalized relational database that eliminates redundancy and ensures referential integrity
- Model all real-world business entities (Products, Orders, Customers, Suppliers, Inventory) and their relationships using an Enhanced Entity-Relationship (EER) diagram
- Implement the physical database in MySQL Workbench with proper constraints — Primary Keys, Foreign Keys, NOT NULL, and Indexes
- Populate the database with realistic mock data using SQL INSERT statements to validate functionality
- Build Tableau visualizations on top of the database to deliver inventory and sales insights to business stakeholders

---

## 🛠️ Tech Stack

| Category | Tools |
|----------|-------|
| **Database Design** | LucidChart (EER Diagram) |
| **Database Implementation** | MySQL, MySQL Workbench |
| **Query Language** | SQL (DDL, DML — CREATE, INSERT, SELECT, JOIN) |
| **Visualization** | Tableau |

---

## 🗃️ Database Schema

### Entities & Relationships

| Entity | Description | Primary Key | Foreign Keys |
|--------|-------------|-------------|--------------|
| **PRODUCT** | Descriptive information about each garment — name, category, price | ProductID | — |
| **INVENTORY** | Current stock levels and reorder thresholds for each product | InventoryID | ProductID |
| **CUSTOMER** | Customer name, contact information, and shipping address | CustomerID | — |
| **ORDER** | Order total price and the date the order was placed | OrderID | CustomerID |
| **ORDER_ITEM** | Line items linking each order to its specific products and quantities | OrderItemID | OrderID, ProductID |
| **SUPPLIER** | Supplier name, contact information, and address | SupplierID | — |
| **PRODUCT_SUPPLIER** | Junction table mapping which suppliers provide which products | ProductSupplierID | ProductID, SupplierID |

### Relationships Summary

| Relationship | Cardinality | Description |
|-------------|-------------|-------------|
| CUSTOMER → ORDER | One-to-Many | One customer can place many orders |
| ORDER → ORDER_ITEM | One-to-Many | One order contains many line items |
| PRODUCT → ORDER_ITEM | One-to-Many | One product can appear in many order items |
| PRODUCT → INVENTORY | One-to-One | Each product has one inventory record |
| PRODUCT ↔ SUPPLIER | Many-to-Many | Resolved via PRODUCT_SUPPLIER junction table |

### Key Design Decisions

- **Third Normal Form (3NF)**: All transitive dependencies eliminated — each table contains only data about its primary entity, with no repeating groups or partial dependencies
- **Junction Table** (`PRODUCT_SUPPLIER`): Properly resolves the many-to-many relationship between Products and Suppliers, enabling tracking of multiple suppliers per product and vice versa
- **Indexes on all Foreign Keys**: Ensures fast JOIN query performance for reporting and dashboard queries
- **NOT NULL constraints** on all business-critical fields to enforce data completeness at the database level
- **AUTO_INCREMENT Primary Keys**: Automatically assigned sequential IDs for all entities, eliminating manual key management

---

## 🔬 Implementation Steps

### Phase 1 – EER Diagram Design (LucidChart)
- Identified all business entities from the retailer's real-world operations
- Defined primary keys, foreign keys, cardinality (1:1, 1:N, M:N), and participation constraints for every relationship
- Reviewed the EER diagram to verify normalization, eliminate redundancy, and confirm referential integrity before moving to physical implementation
- Exported the finalized EER diagram as the authoritative blueprint for database construction

### Phase 2 – Physical Database Implementation (MySQL Workbench)
- Translated the EER diagram into MySQL DDL statements (`CREATE TABLE`) with all constraints applied
- Implemented: `PRIMARY KEY`, `FOREIGN KEY`, `NOT NULL`, `AUTO_INCREMENT`, and index creation for all FK columns
- Used MySQL Workbench's built-in EER reverse-engineering tool to visually verify that the physical schema matched the logical design exactly
- Tested all foreign key relationships by attempting to insert orphaned records — confirmed that referential integrity constraints correctly rejected invalid data

### Phase 3 – Data Population (SQL INSERT Statements)
- Wrote SQL `INSERT` statements to populate all 7 tables with realistic mock data representing actual garment inventory and customer transactions
- Inserted: **12 Products**, **12 Inventory records**, **15 Customers**, **20 Orders**, **12 Order Items**, **12 Suppliers**, **12 Product-Supplier mappings**
- Validated data integrity post-insertion by running SELECT queries and JOIN-based reports to confirm all relationships resolved correctly

### Phase 4 – Tableau Visualization
- Connected Tableau directly to the MySQL database using a live connection
- Built business-facing dashboards delivering actionable insights including:
  - **Inventory Level Monitor** — current stock quantities vs. reorder thresholds by product and category
  - **Sales Performance Dashboard** — total order value by time period, top-selling products, and revenue by customer segment
  - **Supplier Contribution View** — which suppliers provide which products and their contribution to overall inventory
  - **Low Stock Alert View** — products currently below reorder threshold requiring immediate restocking action

---

## 📋 Sample SQL Queries

```sql
-- Create the PRODUCT table
CREATE TABLE PRODUCT (
    ProductID   INT AUTO_INCREMENT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    Category    VARCHAR(50)  NOT NULL,
    Price       DECIMAL(10,2) NOT NULL,
    Description TEXT
);

-- Create the INVENTORY table with FK to PRODUCT
CREATE TABLE INVENTORY (
    InventoryID   INT AUTO_INCREMENT PRIMARY KEY,
    ProductID     INT NOT NULL,
    StockQuantity INT NOT NULL,
    ReorderLevel  INT NOT NULL,
    LastUpdated   DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ProductID) REFERENCES PRODUCT(ProductID)
);

-- Create ORDER_ITEM junction table
CREATE TABLE ORDER_ITEM (
    OrderItemID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID     INT NOT NULL,
    ProductID   INT NOT NULL,
    Quantity    INT NOT NULL,
    TotalPrice  DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (OrderID)   REFERENCES `ORDER`(OrderID),
    FOREIGN KEY (ProductID) REFERENCES PRODUCT(ProductID)
);

-- Business query: products currently below reorder level
SELECT p.ProductName, i.StockQuantity, i.ReorderLevel,
       (i.ReorderLevel - i.StockQuantity) AS UnitsNeeded
FROM PRODUCT p
JOIN INVENTORY i ON p.ProductID = i.ProductID
WHERE i.StockQuantity < i.ReorderLevel
ORDER BY UnitsNeeded DESC;

-- Business query: top customers by total order value
SELECT c.CustomerID,
       CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
       COUNT(o.OrderID)    AS TotalOrders,
       SUM(o.TotalPrice)   AS TotalSpent
FROM CUSTOMER c
JOIN `ORDER` o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID
ORDER BY TotalSpent DESC;
```

---

## 📈 Business Impact

- **Eliminated manual tracking entirely** — replaced error-prone physical notebook system with a centralized, automated relational database
- **Real-time inventory visibility** — stock levels update automatically with each recorded sale via ORDER_ITEM inserts, eliminating the need for manual stock counts
- **Zero data redundancy** — 3NF normalization and proper FK constraints ensure every piece of information is stored exactly once, eliminating the inconsistencies that plagued the manual system
- **Scalable architecture** — the schema is designed to accommodate expansion into multiple product lines, store locations, and supplier networks without structural redesign
- **Data integrity enforced at the database level** — FK constraints, NOT NULL rules, and AUTO_INCREMENT PKs prevent bad data from entering the system regardless of user error
- **Decision-support ready** — Tableau dashboards give management instant, accurate visibility into top-selling products, low-stock alerts, supplier performance, and customer purchasing patterns

---

## 👥 Team

**Team D – ISDS 555, Spring 2025, California State University Fullerton**

Prateeksha Mehta, Anthony Nava Camacho, Mika Ozaki-Gonzales, Dhrithi Reddy, Shradha Suresh Mungase, Yeldah Zia

**Instructor**: Dr. Bill Jung

---

## 📬 Contact

**Prateeksha Mehta** | pratu2930@gmail.com | [LinkedIn](https://linkedin.com/in/prateeksha29) | [GitHub](https://github.com/Prateeksha2930)
