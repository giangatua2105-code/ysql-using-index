-- =====================================================
-- [Thực hành] Chỉ mục trong MySQL
-- CSDL: classicmodels (tải tại mysqltutorial.org)
-- =====================================================
USE classicmodels;

-- -----------------------------------------------------
-- BƯỚC 1: Truy vấn TRƯỚC khi tạo Index
-- -----------------------------------------------------
SELECT * FROM customers
WHERE customerName = 'Land of Toys Inc.';

EXPLAIN
SELECT * FROM customers
WHERE customerName = 'Land of Toys Inc.';

-- Kết quả mong đợi:
-- type = ALL, possible_keys = NULL, key = NULL
-- rows ~ 17123 (Full Table Scan)

-- -----------------------------------------------------
-- BƯỚC 2: Tạo Index đơn trên cột customerName
-- -----------------------------------------------------
ALTER TABLE customers
ADD INDEX idx_customerName(customerName);

-- -----------------------------------------------------
-- BƯỚC 3: Truy vấn SAU khi tạo Index
-- -----------------------------------------------------
EXPLAIN
SELECT * FROM customers
WHERE customerName = 'Land of Toys Inc.';

-- Kết quả mong đợi:
-- type = ref, possible_keys = idx_customerName
-- key = idx_customerName, key_len = 52, rows = 1

-- -----------------------------------------------------
-- BƯỚC 4: Tạo Composite Index cho 2 cột
-- -----------------------------------------------------
ALTER TABLE customers
ADD INDEX idx_full_name(contactFirstName, contactLastName);

-- -----------------------------------------------------
-- BƯỚC 5: Truy vấn dùng Composite Index
-- -----------------------------------------------------
EXPLAIN
SELECT * FROM customers
WHERE contactFirstName = 'Jean'
   OR contactFirstName = 'King';

-- -----------------------------------------------------
-- BƯỚC 6: Xóa Index khi không cần nữa
-- -----------------------------------------------------
ALTER TABLE customers DROP INDEX idx_full_name;
