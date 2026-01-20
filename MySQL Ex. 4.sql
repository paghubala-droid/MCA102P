Exercise 4

CREATE DATABASE Hospital;

USE Hospital;

# 1. CREATE TABLES: PATIENT, DOCTOR, & APPOINTMENT

CREATE TABLE Patient (
    -> PatientID INT PRIMARY KEY NOT NULL,
    -> PatientName VARCHAR(25) NOT NULL,
    -> DateofBirth DATE,
    -> Gender VARCHAR(10),
    -> ContactNumber VARCHAR(15),
    -> Email VARCHAR(30)
    -> );


CREATE TABLE Doctor (
    -> DoctorID INT PRIMARY KEY NOT NULL,
    -> DoctorName VARCHAR(25) NOT NULL,
    -> Speciality VARCHAR(20),
    -> ContactNumber VARCHAR(20),
    -> Email VARCHAR(30)
    -> );

CREATE TABLE Appointment (
    -> AppointmentID INT PRIMARY KEY NOT NULL,
    -> PatientID INT,
    -> DoctorID INT,
    -> AppointmentDateTime DATETIME,
    -> ReasonForVisit TEXT,
    -> FOREIGN KEY (PatientID) REFERENCES Patient (PatientID),
    -> FOREIGN KEY (DoctorID) REFERENCES Doctor (DoctorID)
    -> );

# 2. INSERT SAMPLE DATA FOR ATLEAST 5 PATIENTS AND 3 DOCTORS 

INSERT INTO Patient (PatientID, PatientName, DateofBirth, Gender, ContactNumber, Email) VALUES
    -> (1, 'Manoj Gowda','2015-10-10','Male','9876543210','manojgowda@company.in'),
    -> (2, 'Mohammed Anas','2016-08-15','Male','9876543211','anas@company.in'),
    -> (3, 'Arulkumar', '2014-09-20','Male','9876543212','arulkumar@company.in'),
    -> (4, 'Arvind','2015-07-18','Male','9876543213','arvind@company.in'),
    -> (5, 'Thanushree','2016-05-16','Female','9876543214','thanushree@company.in');

INSERT INTO Doctor (DoctorID, DoctorName, Speciality, ContactNumber, Email) VALUES
    -> (999,'Pooja','Cardiology','555-123-4567','pooja@hospital.com'),
    -> (888,'Senthilkumar','Paediatrics','555-456-7890','senthil@hospital.com'),
    -> (777,'Balaji','Orthopedics','9876543218','balaji@hospital.com');

INSERT INTO Appointment (AppointmentID, PatientID, DoctorID, AppointmentDateTime, ReasonForVisit) VALUES
    -> (100, 1, 999, '2026-01-20 10:00:00', 'Chest pain'),
    -> (101, 2, 999, '2026-01-20 11:00:00', 'Follow-up after surgery'),
    -> (102, 3, 888, '2026-01-21 14:00:00', 'Vaccination'),
    -> (103, 4, 777, '2026-01-22 09:30:00', 'Knee injury'),
    -> (104, 5, 888, '2026-01-22 11:00:00', 'Checkup'),
    -> (105, 1, 888, '2026-01-23 13:00:00', 'Sore throat'),
    -> (106, 2, 777, '2026-01-23 15:30:00', 'Back pain');

# 3. RETRIEVE PATIENT NAMES WHO HAVE APPOINTMENTS WITH A SPECIFIC DOCTOR

 SELECT P.PatientName
    -> FROM Patient P
    -> JOIN Appointment A ON P.PatientID = A.PatientID
    -> WHERE A.DoctorID = (SELECT DoctorID FROM Doctor WHERE DoctorName = 'Senthilkumar');

# 4. DISPLAY TOTAL NUMBERS OF APPOINTMENTS PER DOCTOR

SELECT D.DoctorName COUNT(A.AppointmentID) AS TotalAppointments
    -> FROM Doctor D
    -> LEFT JOIN Appointment A ON D.DoctorID = A.DoctorID
    -> GROUP BY D.DoctorID
    -> ORDER BY TotalAppointments DESC;

# 5. CREATE AN INDEX ON DOCTORID

CREATE INDEX idx_DoctorID ON Appointment (DoctorID);





