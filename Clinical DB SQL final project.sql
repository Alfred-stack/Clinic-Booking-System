-- Clinic Management System Database Schema (clinic_db) created for final submission 

-- Drop database if it exists
DROP DATABASE IF EXISTS clinic_db; -- this would drop any database that has the same name.

-- Create database
CREATE DATABASE clinic_db;
USE clinic_db;

-- Creating patients table
-- the table is created using the key word create 
CREATE TABLE Patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY, -- create a patient id column that is the primary key and automatically increments itself
    first_name VARCHAR(100) NOT NULL, -- Creates a first name column that doesnt allow null values, which means i set a restriction for that column
    last_name VARCHAR(100) NOT NULL, -- Accepts only 100 characters 
    date_of_birth DATE,
    gender ENUM('Male', 'Female', 'Other'), -- Here the gender column is created with 3 restriants allowing only female, male or other to be filled in
    phone VARCHAR(15) UNIQUE,
    email VARCHAR(100),
    address TEXT
);

-- Doctors Table
-- this table is the doctors table and has its columns with restrictions like not having null values, using the current date of hire for each doctor, and setting limits for values entered.
CREATE TABLE Doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(150) NOT NULL,
    specialty VARCHAR(100) NOT NULL,
    phone VARCHAR(15) UNIQUE,
    email VARCHAR(100),
    hire_date DATE DEFAULT (CURRENT_DATE)
);

-- Appointments Table
-- In this table we have the same restrictions as before but now we have foriegn keys where we now use constraints to declear and show the reference of the foreign keys to the primary keys in other tables which indicates that this is a relational database design.
CREATE TABLE Appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    appointment_date DATETIME NOT NULL,
    reason TEXT,
    status ENUM('Scheduled', 'Completed', 'Cancelled') DEFAULT 'Scheduled',
    
    CONSTRAINT fk_appointment_patient FOREIGN KEY (patient_id) REFERENCES Patients(patient_id) ON DELETE CASCADE,
    CONSTRAINT fk_appointment_doctor FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id) ON DELETE SET NULL
);

-- Medical Records Table
-- this is a medical records table that keeps records of all operations performed on patients which also links to the doctors who performed either operations or diagnosis for each reference
CREATE TABLE Medical_Records (
    record_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    diagnosis TEXT NOT NULL,
    prescription TEXT,
    record_date DATE DEFAULT (CURRENT_DATE),

    CONSTRAINT fk_record_patient FOREIGN KEY (patient_id) REFERENCES Patients(patient_id) ON DELETE CASCADE,
    CONSTRAINT fk_record_doctor FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id) ON DELETE SET NULL
);

-- Bills table
-- This table is a bill table that keeps records of patients bills and has the same constraints as the previous tables.
CREATE TABLE Bills (
    bill_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    appointment_id INT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    payment_status ENUM('Paid', 'Unpaid', 'Pending') DEFAULT 'Unpaid',
    billing_date DATE DEFAULT (CURRENT_DATE),

    CONSTRAINT fk_bill_patient FOREIGN KEY (patient_id) REFERENCES Patients(patient_id) ON DELETE CASCADE,
    CONSTRAINT fk_bill_appointment FOREIGN KEY (appointment_id) REFERENCES Appointments(appointment_id) ON DELETE SET NULL
);
