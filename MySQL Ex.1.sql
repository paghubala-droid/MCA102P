#Create the University database
CREATE DATABASE University;

#Use the University database
USE University;

1.Create the Student table
CREATE TABLE Student (
    StudentID INT PRIMARY KEY NOT NULL,
    Name VARCHAR(30) NOT NULL,
    DateOfBirth DATE,
    Email VARCHAR(35) UNIQUE,
    PhoneNumber VARCHAR(20)
);

#Create the Course table
CREATE TABLE Course (
    CourseID INT PRIMARY KEY NOT NULL,
    CourseName VARCHAR(35) NOT NULL,
    Credits INT NOT NULL,
    Department VARCHAR(25)
);

#Create the Enrolment table
CREATE TABLE Enrolment (
    EnrolmentID INT PRIMARY KEY NOT NULL,
    StudentID INT,
    CourseID INT,
    EnrolmentDate DATE,
    Grade VARCHAR(2),
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID) ON DELETE CASCADE,
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID) ON DELETE CASCADE
);

2. Insert records into the Student table

INSERT INTO Student (StudentID, Name, DateOfBirth, Email, PhoneNumber) VALUES
(10001,'Herbert' '2000-03-15', 'herbert@example.com', '9876543210'),
(10002,'Dhamodhar',1999-08-22', 'dhamo@example.com', '9876543211'),
(10003,'Bharani', '2001-01-10', 'bharani@example.com', '9876543212'),
(10004,'David', '2000-06-04', 'david@example.com', '555-135-7924'),
(10005,'Mozhi', '1999-11-28', 'mozhi@example.com', '555-369-1258');

#Insert records into the Course table

INSERT INTO Course (CourseID, CourseName, Credits, Department) VALUES
(123,'DBMS', 3, 'Computer Science'),
(124,'Calculus I', 4, 'Mathematics'),
(125,'Linear Algebra', 3, 'Mathematics'),
(126,'Principles of Economics', 3, 'Economics'),
(127,'Organic Chemistry', 4, 'Chemistry');

#Insert records into the Enrolment table

INSERT INTO Enrolment (EnrolmentID, StudentID, CourseID, EnrolmentDate, Grade) VALUES
(100,10001, 123, '2025-09-01', 'A+'),
(101,10002, 124, '2025-09-01', 'B'),
(102,10003, 125, '2025-09-01', 'B+'),
(103,10004, 126, '2025-09-01', 'A'),
(104,10005, 127, '2025-09-01', 'B'),


3.Display all student details enrolled in a specific course 

SELECT S.*
FROM Student S
JOIN Enrolment E ON S.StudentID = E.StudentID
WHERE E.CourseID = 123;

4.Update a student's name 

UPDATE Student
SET Name = 'Herbi'
WHERE StudentID = 10001;

5.Delete a course 

DELETE FROM Course
WHERE CourseID = 126;

#Verify the update and delete
SELECT * FROM Course;

