create database OrgStructdb;

use OrgStructdb;

-- Vytvorenie tabuľky zamestnancov
CREATE TABLE Emp (
    emp_id INT IDENTITY(1,1) PRIMARY KEY,
    title VARCHAR(50),
    first_name NVARCHAR(100) NOT NULL,
    last_name NVARCHAR(100) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    email NVARCHAR(100) NOT NULL
);

-- Vytvorenie tabuľky organizačných jednotiek
CREATE TABLE OrgUnit (
    unit_id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(100) NOT NULL,
    code VARCHAR(20) NOT NULL,
    parent_unit_id INT,
    director_id INT NOT NULL,
    level INT NOT NULL,
	--CHECK (level IN (1, 2, 3, 4)),												--úroveň jednotky v hierarchii
    FOREIGN KEY (parent_unit_id) REFERENCES OrgUnit(unit_id) ON DELETE NO ACTION,
	FOREIGN KEY (director_id) REFERENCES Emp(emp_id)
);

-- Vytvorenie tabuľky pozícií zamestnancov v organizáciách
CREATE TABLE EmpPos (
	emp_pos_id INT IDENTITY(1,1) PRIMARY KEY,
    emp_id INT NOT NULL,
    unit_id INT NOT NULL,
    pos_name VARCHAR(100) NOT NULL,
	--CHECK (pos_name IN ('director', 'manager', 'employee')),					--pozície, na ktorých môže zamestnanec pracovať
    FOREIGN KEY (emp_id) REFERENCES Emp(emp_id) ON DELETE CASCADE,
    FOREIGN KEY (unit_id) REFERENCES OrgUnit(unit_id) ON DELETE CASCADE
);