# 1. CREATE TABLES: AUTHORS, BOOKS, BORROWERS and LENDING

mysql> CREATE TABLE Authors (
    -> AuthorID INT PRIMARY KEY NOT NULL,
    -> AuthorName VARCHAR(25) NOT NULL,
    -> Nationality VARCHAR(20)
    -> );


mysql> CREATE TABLE Books (
    -> BookID INT PRIMARY KEY NOT NULL,
    -> Title VARCHAR(30) NOT NULL,
    -> AuthorID INT,
    -> PublicationYear INT,
    -> ISBN VARCHAR(20) UNIQUE,
    -> FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID)
    -> );

mysql> CREATE TABLE Borrowers (
    -> BorrowerID INT PRIMARY KEY NOT NULL,
    -> BorrowerName VARCHAR(25) NOT NULL,
    -> Email VARCHAR(30) UNIQUE,
    -> PhoneNumber VARCHAR(20)
    -> );

mysql> CREATE TABLE Lending (
    -> LendingID INT PRIMARY KEY NOT NULL,
    -> BookID INT,
    -> BorrowerID INT,
    -> BorrowDate DATE,
    -> ReturnDate DATE,
    -> FOREIGN KEY (BookID) REFERENCES Books(BookID),
    -> FOREIGN KEY (BorrowerID) REFERENCES Borrowers(BorrowerID)
    -> );

# 2. INSERT THE RECORDS INTO AUTHORS 
mysql> INSERT INTO Authors (AuthorID, AuthorName, Nationality) VALUES
    -> (1,'R.K.Narayan', 'Indian'),
    -> (2,'Arundhati Roy', 'Indian'),
    -> (3,'Salman Rushdie','Indian'),
    -> (4,'J.K.Rowling','British'),
    -> (5,'Chetan Bhagat','Indian');

# INSERT THE RECORDS INTO BOOKS
mysql> INSERT INTO Books (BookID, Title, AuthorID, PublicationYear, ISBN) VALUES
    -> (1111,'Swamy and Friends',1,'1935', '978-0141439518'),
    -> (2222,'God of Small Things',2,'1997', '978-0141439517'),
    -> (3333,'Satanic Verses',3,'1988','978-0141423456'),
    -> (4444,'Harry Potter',4,'1998','987-1402345678'),
    -> (5555,'Fivepoint Someone',5,'2004','986-1401234567');

# INSERT THE RECORDS INTO BORROWERS
mysql> INSERT INTO Borrowers (
    -> BorrowerID,BorrowerName,Email,PhoneNumber) VALUES
    -> (99,'Herbert','herbert@company.in','9876543210'),
    -> (88,'Dhamodhar','dhamo@company.in','9876543211'),
    -> (77,'Bharani','bharani@company.in','9876543212');

# INSERT THE RECORDS INTO LENDING
mysql> INSERT INTO Lending (LendingID,BookID, BorrowerID, BorrowDate, ReturnDate) VALUES
    -> (10,1111, 99, '2025-12-01', '2025-12-15'),
    -> (11,2222, 88, '2025-12-10', '2025-12-25'),
    -> (12,3333, 99, '2025-12-01', '2025-12-15'),
    -> (13,4444, 77, '2025-12-15', '2025-12-30'),
    -> (14,5555, 99, '2026-01-01', NULL);

# 3. Retrieve book details borrowed by a specific borrower using nested queries

mysql> SELECT
    -> B.Title,
    -> A.AuthorName
    -> FROM
    -> Books AS B
    -> JOIN Authors AS A ON B.AuthorID = A.AuthorID
    -> WHERE
    -> B.BookID IN (SELECT L.BookID FROM Lending AS L JOIN Borrowers AS BR ON L.BorrowerID = BR.BorrowerID 
    -> WHERE BR.BorrowerName='Herbert');

 
# 4. Count how many books each borrower has taken using aggregate functions

mysql> SELECT
    -> BR.BorrowerName,
    -> COUNT(L.BookID) AS TotalBooksBorrowed
    -> FROM
    -> Borrowers AS BR
    -> LEFT JOIN
    -> Lending AS L ON BR.BorrowerID = L.BorrowerID
    -> GROUP BY
    -> BR.BorrowerID, BR.BorrowerName
    -> ORDER BY
    -> TotalBooksBorrowed DESC;


# 5. Create a view showing borrower name and books borrowed

mysql> CREATE VIEW BorrowerBooks AS
    -> SELECT
    -> BR.BorrowerName,
    -> B.Title
    -> FROM
    -> Borrowers AS BR
    -> JOIN
    -> Lending AS L ON BR.BorrowerID = L.BorrowerID
    -> JOIN
    -> Books AS B ON L.BookID = B.BookID;
Query OK, 0 rows affected (0.05 sec)

mysql> SELECT * FROM BorrowerBooks;


                                     +--------------+---------------------+
