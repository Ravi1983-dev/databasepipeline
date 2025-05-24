--Create the Login and then map to the Clidot_Prod database

USE master
-- Step 1: Create server login
IF NOT EXISTS (SELECT * FROM sys.sql_logins WHERE name = 'Clidot_Prod_isource')
BEGIN
    CREATE LOGIN Clidot_Prod_isource WITH PASSWORD = 'StrongPasswordHere';
END

-- Step 2: Create user in specific database (change context)
USE Clidot_Prod
GO

-- Step 3: Create DB user and map to login
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = 'Clidot_Prod_isource')
BEGIN
    CREATE USER Clidot_Prod_isource FOR LOGIN Clidot_Prod_isource;
    EXEC sp_addrolemember 'db_datareader', 'Clidot_Prod_isource';
    EXEC sp_addrolemember 'db_datawriter', 'Clidot_Prod_isource';
END


