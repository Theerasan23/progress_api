CREATE TABLE t_users (
  id INT NOT NULL IDENTITY(1,1),  -- Equivalent to MySQL AUTO_INCREMENT
  uid NVARCHAR(36) NULL,
  title NVARCHAR(3) NULL,
  title_name NVARCHAR(20) NULL,
  fname NVARCHAR(50) NULL,
  lname NVARCHAR(50) NULL,
  fname_en NVARCHAR(50) NULL,
  lname_en NVARCHAR(50) NULL,
  pos NVARCHAR(100) NULL,
  pos_lv NVARCHAR(50) NULL,
  workgroup_id VARBINARY(10) NULL,
  workgroup_name NVARCHAR(100) NULL,
  email NVARCHAR(100) NULL,
  division_id NVARCHAR(10) NULL,
  division_name NVARCHAR(100) NULL,
  fullname NVARCHAR(101) NULL,
  user_sso NVARCHAR(50) NULL,
  username NVARCHAR(20) NULL,
  password NVARCHAR(35) NULL,
  role INT NULL,
  status INT NULL,
  d_create DATETIME DEFAULT GETDATE(),  -- Equivalent to CURRENT_TIMESTAMP in MySQL
  d_update DATETIME DEFAULT GETDATE(),  -- Equivalent to CURRENT_TIMESTAMP in MySQL
  PRIMARY KEY (id)
);

CREATE TABLE document_group (
  id INT NOT NULL IDENTITY(1,1),  -- Equivalent to AUTO_INCREMENT in MySQL
  name NVARCHAR(100) NULL,        -- Using NVARCHAR for Unicode support
  code INT NULL,
  status INT DEFAULT 0,           -- Integer default without quotes
  PRIMARY KEY (id)                -- PRIMARY KEY does not require USING BTREE in SQL Server
);

CREATE TABLE division (
  id INT NOT NULL IDENTITY(1,1),  -- Equivalent to AUTO_INCREMENT in MySQL
  name NVARCHAR(100) NOT NULL,
  code NVARCHAR(10) NOT NULL,
  status INT DEFAULT 0,  -- Integer literals don't need quotes in SQL Server
  PRIMARY KEY (id, code)  -- Composite primary key on id and code
);

CREATE TABLE document_status (
  id INT NOT NULL IDENTITY(1,1),  -- Equivalent to AUTO_INCREMENT in MySQL
  code NVARCHAR(10) NULL,         -- Using NVARCHAR for Unicode support
  name NVARCHAR(100) NULL,        -- Using NVARCHAR for Unicode support
  status INT NULL,                -- Status field, allowing NULL
  PRIMARY KEY (id)                -- No need for USING BTREE in SQL Server
);

CREATE TABLE document_user_status (
  id INT NOT NULL IDENTITY(1,1),  -- Equivalent to AUTO_INCREMENT in MySQL
  name NVARCHAR(50) NULL,         -- Using NVARCHAR for Unicode support
  code NVARCHAR(2) NULL,          -- Using NVARCHAR for Unicode support
  status INT DEFAULT 1,           -- Integer default without quotes
  PRIMARY KEY (id)                -- No need for USING BTREE in SQL Server
);

CREATE TABLE documents (
  id INT NOT NULL IDENTITY(1,1),  -- Equivalent to AUTO_INCREMENT in MySQL
  title NVARCHAR(100) NOT NULL,   -- Using NVARCHAR for Unicode support
  [group] INT NULL,                -- Using square brackets to escape reserved keyword
  d_create DATETIME DEFAULT GETDATE(),  -- Equivalent to CURRENT_TIMESTAMP in SQL Server
  d_update DATETIME DEFAULT GETDATE(),  -- Equivalent to CURRENT_TIMESTAMP in SQL Server
  update_by INT NULL,
  create_by INT NULL,
  by_name NVARCHAR(100) NULL,
  position NVARCHAR(50) NULL,
  workgroup_id NVARCHAR(10) NULL,
  workgroup_name NVARCHAR(100) NULL,
  status INT DEFAULT 1,            -- Integer default without quotes
  comment NVARCHAR(MAX) NULL,      -- Longtext in MySQL is equivalent to NVARCHAR(MAX) in SQL Server
  form_id NVARCHAR(50) NULL,
  documents NVARCHAR(MAX) NULL,    -- Longtext in MySQL is equivalent to NVARCHAR(MAX) in SQL Server
  year INT NOT NULL,
  PRIMARY KEY (id)                 -- No need for USING BTREE in SQL Server
);

CREATE TABLE logs_load (
  id INT NOT NULL IDENTITY(1,1),          -- Equivalent to AUTO_INCREMENT in MySQL
  ip NVARCHAR(255) NULL,                  -- Using NVARCHAR for Unicode support
  form_id NVARCHAR(50) NOT NULL,          -- Using NVARCHAR for Unicode support
  fname NVARCHAR(255) NULL,               -- Using NVARCHAR for Unicode support
  lname NVARCHAR(255) NULL,               -- Using NVARCHAR for Unicode support
  d_create DATETIME DEFAULT GETDATE(),    -- Equivalent to CURRENT_TIMESTAMP in SQL Server
  PRIMARY KEY (id)                        -- No need for USING BTREE in SQL Server
);

CREATE TABLE logs_view (
  id INT NOT NULL IDENTITY(1,1),          -- Equivalent to AUTO_INCREMENT in MySQL
  ip NVARCHAR(255) NULL,                  -- Using NVARCHAR for Unicode support
  form_id NVARCHAR(50) NOT NULL,          -- Using NVARCHAR for Unicode support
  user_id INT NOT NULL,                   -- User ID field as an integer
  fname NVARCHAR(255) NULL,               -- Using NVARCHAR for Unicode support
  lname NVARCHAR(255) NULL,               -- Using NVARCHAR for Unicode support
  d_create DATETIME DEFAULT GETDATE(),    -- Equivalent to CURRENT_TIMESTAMP in SQL Server
  PRIMARY KEY (id)                        -- No need for USING BTREE in SQL Server
);

CREATE TABLE prename (
  id INT NOT NULL IDENTITY(1,1),           -- Equivalent to AUTO_INCREMENT in MySQL
  name NVARCHAR(50) NULL,                  -- Using NVARCHAR for Unicode support
  code NVARCHAR(3) NULL,                   -- Using NVARCHAR for Unicode support
  PRIMARY KEY (id)                         -- No need for USING BTREE in SQL Server
);

CREATE TABLE role (
  id INT NOT NULL IDENTITY(1,1),           -- Equivalent to AUTO_INCREMENT in MySQL
  name NVARCHAR(50) NULL,                  -- Using NVARCHAR for Unicode support
  code INT NOT NULL,                       -- Code field as an integer
  status INT DEFAULT 0,                    -- Integer default without quotes
  PRIMARY KEY (id, code)                   -- No need for USING BTREE in SQL Server
);

CREATE TABLE status (
  id INT NOT NULL IDENTITY(1,1),           -- Equivalent to AUTO_INCREMENT in MySQL
  name NVARCHAR(50) NULL,                  -- Using NVARCHAR for Unicode support
  code NVARCHAR(1) NOT NULL,               -- Using NVARCHAR for Unicode support
  status INT DEFAULT 0,                    -- Integer default without quotes
  PRIMARY KEY (id, code)                   -- No need for USING BTREE in SQL Server
);

CREATE TABLE sub_documents (
  id INT NOT NULL IDENTITY(1,1),                            -- Equivalent to AUTO_INCREMENT in MySQL
  default_filename NVARCHAR(100) NULL,                      -- Using NVARCHAR for Unicode support
  file_hash NVARCHAR(50) NOT NULL,                          -- Using NVARCHAR for Unicode support
  file_size FLOAT DEFAULT NULL,                              -- Using FLOAT for double precision
  file_type NVARCHAR(20) NULL,                              -- Using NVARCHAR for Unicode support
  form_id NVARCHAR(50) NULL,                                -- Using NVARCHAR for Unicode support
  d_create DATETIME DEFAULT GETDATE(),                      -- Default to current timestamp
  d_update DATETIME NULL,                                   -- Nullable datetime for updates
  by_name NVARCHAR(20) NULL,                                -- Using NVARCHAR for Unicode support
  by_pos NVARCHAR(50) NULL,                                 -- Using NVARCHAR for Unicode support
  workgroup NVARCHAR(100) NULL,                             -- Using NVARCHAR for Unicode support
  by_id INT DEFAULT NULL,                                   -- ID field
  comment NVARCHAR(100) NULL,                               -- Using NVARCHAR for Unicode support
  status INT DEFAULT NULL,                                   -- Status field
  PRIMARY KEY (id, file_hash)                               -- No need for USING BTREE in SQL Server
);

CREATE TABLE t_document_usershare (
  id INT NOT NULL IDENTITY(1,1),                            -- Equivalent to AUTO_INCREMENT in MySQL
  form_id NVARCHAR(50) NOT NULL,                           -- Using NVARCHAR for Unicode support
  user_id INT DEFAULT NULL,                                 -- User ID, nullable
  name NVARCHAR(100) NULL,                                 -- Using NVARCHAR for Unicode support
  pos NVARCHAR(50) NULL,                                   -- Using NVARCHAR for Unicode support
  pos_lv NVARCHAR(20) NULL,                                -- Using NVARCHAR for Unicode support
  workgroup_id NVARCHAR(10) NULL,                          -- Using NVARCHAR for Unicode support
  workgroup_name NVARCHAR(100) NULL,                       -- Using NVARCHAR for Unicode support
  status INT NOT NULL DEFAULT 0,                           -- Default value of 0 without quotes
  PRIMARY KEY (id)                                         -- No need for USING BTREE in SQL Server
);


CREATE TABLE t_documents (
  id INT NOT NULL IDENTITY(1,1),                           -- Equivalent to AUTO_INCREMENT in MySQL
  form_id NVARCHAR(36) DEFAULT NULL,                       -- Using NVARCHAR for Unicode support
  file_name NVARCHAR(100) DEFAULT NULL,                    -- Using NVARCHAR for Unicode support
  file_hash NVARCHAR(50) DEFAULT NULL,                     -- Using NVARCHAR for Unicode support
  file_type NVARCHAR(20) DEFAULT NULL,                     -- Using NVARCHAR for Unicode support
  file_size INT DEFAULT NULL,                               -- Size of the file
  user_id INT DEFAULT NULL,                                 -- User ID, nullable
  form_status INT DEFAULT NULL,                             -- File status
  d_update DATETIME DEFAULT NULL,                           -- Update date
  d_create DATETIME DEFAULT CURRENT_TIMESTAMP,             -- Creation date
  create_by INT DEFAULT NULL,                               -- ID of the creator
  update_by INT DEFAULT NULL,                               -- ID of the updater
  PRIMARY KEY (id)                                         -- No need for USING BTREE in SQL Server
);

CREATE TABLE test_table (
  id INT NOT NULL IDENTITY(1,1),                          -- Equivalent to AUTO_INCREMENT in MySQL
  code NVARCHAR(1) DEFAULT NULL,                          -- Using NVARCHAR for Unicode support
  name NVARCHAR(50) DEFAULT NULL,                         -- Using NVARCHAR for Unicode support
  PRIMARY KEY (id)                                       -- No need for USING BTREE in SQL Server
);

CREATE TABLE user_group (
  id INT NOT NULL IDENTITY(1,1),                          -- Equivalent to AUTO_INCREMENT in MySQL
  code NVARCHAR(255) DEFAULT NULL,                        -- Using NVARCHAR for Unicode support
  name NVARCHAR(255) DEFAULT NULL,                        -- Using NVARCHAR for Unicode support
  status INT DEFAULT 0,                                   -- Default value as an integer
  PRIMARY KEY (id)                                       -- No need for USING BTREE in SQL Server
);

CREATE TABLE user_status (
  id INT NOT NULL IDENTITY(1,1),                          -- Equivalent to AUTO_INCREMENT in MySQL
  name NVARCHAR(30) DEFAULT NULL,                        -- Using NVARCHAR for Unicode support
  code INT DEFAULT 0,                                    -- Default value as an integer
  PRIMARY KEY (id)                                       -- No need for USING BTREE in SQL Server
);

CREATE TABLE usershare_status (
  id INT NOT NULL IDENTITY(1,1),                          -- Equivalent to AUTO_INCREMENT in MySQL
  code INT NOT NULL,                                      -- Keeping code as NOT NULL
  name NVARCHAR(50) DEFAULT NULL,                        -- Using NVARCHAR for Unicode support
  status INT DEFAULT 1,                                   -- Default value as an integer
  PRIMARY KEY (id, code)                                  -- Composite primary key
);

CREATE TABLE web_logs (
  id SMALLINT NOT NULL,                                 -- Small integer type
  code SMALLINT DEFAULT NULL,                          -- Small integer with default NULL
  type NVARCHAR(10) DEFAULT NULL,                     -- Using NVARCHAR for Unicode support
  name NVARCHAR(100) DEFAULT NULL,                    -- Using NVARCHAR for Unicode support
  ip NVARCHAR(20) DEFAULT NULL,                       -- Using NVARCHAR for Unicode support
  PRIMARY KEY (id)                                     -- Primary key on id
);

CREATE TABLE workgroup (
  id INT NOT NULL IDENTITY(1,1),                         -- Use IDENTITY for auto-increment
  code NVARCHAR(10) NOT NULL,                            -- Using NVARCHAR for Unicode support
  name NVARCHAR(100) DEFAULT NULL,                       -- Using NVARCHAR for Unicode support
  status INT DEFAULT 0,                                  -- Default value set to 0
  PRIMARY KEY (id, code)                                 -- Primary key on id and code
);

CREATE TABLE years (
  id INT NOT NULL IDENTITY(1,1),              -- Use IDENTITY for auto-increment
  year_th INT DEFAULT NULL,                    -- Thai year
  year_us INT DEFAULT NULL,                    -- US year
  status INT DEFAULT 1,                        -- Default value set to 1
  PRIMARY KEY (id)                             -- Primary key on id
);
