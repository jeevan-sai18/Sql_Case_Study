create database School;

Use School;

CREATE TABLE CourseMaster (
    CID INTEGER PRIMARY KEY,
    CourseName VARCHAR(40) NOT NULL,
    Category CHAR(1) NULL CHECK (Category IN ('B', 'M', 'A')),
    Fee SMALLMONEY NOT NULL CHECK (Fee >= 0)
);

CREATE TABLE StudentMaster (
    SID TINYINT PRIMARY KEY,
    StudentName VARCHAR(40) NOT NULL,
    Origin CHAR(1) NOT NULL CHECK (Origin IN ('L', 'F')), 
    Type CHAR(1) NOT NULL CHECK (Type IN ('U', 'G')) 
);

CREATE TABLE EnrollmentMaster (
    CID INTEGER NOT NULL,
    SID TINYINT NOT NULL,
    DOE DATETIME NOT NULL,
    FWF BIT NOT NULL,
    Grade CHAR(1) CHECK (Grade IN ('O', 'A', 'B', 'C')),
    PRIMARY KEY (CID, SID),
    FOREIGN KEY (CID) REFERENCES CourseMaster(CID),
    FOREIGN KEY (SID) REFERENCES StudentMaster(SID)
);


INSERT INTO CourseMaster (CID, CourseName, Category, Fee)
VALUES
    (1, 'Introduction to SQL', 'B', 500),
    (2, 'Intermediate SQL', 'M', 750),
    (3, 'Advanced SQL Techniques', 'A', 1000),
    (4, 'Database Design Fundamentals', 'B', 6000),
    (5, 'Normalization and Optimization', 'M', 8000),
    (6, 'Query Performance Tuning', 'A', 1200),
    (7, 'Data Modeling with ER Diagrams', 'B', 550),
    (8, 'Transactions and Concurrency', 'M', 900),
    (9, 'Stored Procedures and Functions', 'A', 1100),
    (10, 'Advanced Database Security', 'A', 950);

	

INSERT INTO StudentMaster (SID, StudentName, Origin, Type)
VALUES
    (101, 'John', 'L', 'U'),
    (102, 'Jane', 'F', 'G'), 
    (103, 'Bob', 'L', 'U'), 
    (104, 'Alice', 'F', 'G'), 
    (105, 'Charlie', 'L', 'U'), 
    (106, 'Eva', 'F', 'G'),
    (107, 'David', 'L', 'U'),
    (108, 'Sophia', 'F', 'G'),
    (109, 'Michael', 'L', 'U'),
    (110, 'Olivia', 'F', 'G');


INSERT INTO EnrollmentMaster (CID, SID, DOE, FWF, Grade)
VALUES
    (1, 101, '2023-01-21', 0, 'A'),
    (2, 102, '2023-01-22', 1, 'B'),
    (3, 103, '2023-01-23', 0, 'C'),
    (4, 104, '2023-01-24', 1, 'A'),
    (5, 105, '2023-01-25', 0, 'B'),
    (6, 106, '2023-01-26', 1, 'C'),
    (7, 107, '2023-01-27', 0, 'A'),
    (8, 108, '2023-01-28', 1, 'B'),
    (9, 109, '2023-01-29', 0, 'C'),
    (10, 110, '2023-01-30', 1, 'A');


--QNUM 1

SELECT CourseMaster.COURSENAME, COUNT(EnrollmentMaster.SID) AS Total_Students_Enrolled
FROM CourseMaster 
JOIN EnrollmentMaster  ON CourseMaster.CID = EnrollmentMaster.CID
JOIN StudentMaster  ON EnrollmentMaster.SID = StudentMaster.SID
WHERE StudentMaster.origin = 'F'
GROUP BY CourseMaster.COURSENAME
HAVING COUNT(EnrollmentMaster.SID) > 10;

-- QNUM 2

SELECT StudentName FROM StudentMaster
WHERE SID NOT IN (
        SELECT e.SID FROM CourseMaster d
        JOIN EnrollmentMaster e ON d.CID = e.CID
        WHERE d.CourseName = 'Java'
    );

-- QNUM 3

SELECT d.CourseName AS AdvancedCourse,
 COUNT(e.SID) AS ForeignEnrollmentCount
FROM CourseMaster d
LEFT JOIN
    EnrollmentMaster e ON d.CID = e.CID
LEFT JOIN
    StudentMaster s ON e.SID = s.SID AND s.Origin = 'F'
WHERE d.Category = 'A' 
GROUP BY d.CourseName
ORDER BY ForeignEnrollmentCount DESC
OFFSET 0 ROWS FETCH NEXT 1 ROWS ONLY;


-- QNUM 4

SELECT DISTINCT s.StudentName
FROM StudentMaster s
JOIN
    EnrollmentMaster e ON s.SID = e.SID
JOIN
    CourseMaster d ON e.CID = d.CID
WHERE
    d.Category = 'B'
    AND MONTH(e.DOE) = MONTH(GETDATE())
    AND YEAR(e.DOE) = YEAR(GETDATE());

--QNUM 5

SELECT DISTINCT s.StudentName
FROM StudentMaster s
JOIN
    EnrollmentMaster e ON s.SID = e.SID
JOIN
    CourseMaster d ON e.CID = d.CID
WHERE
    s.Type = 'U' 
    AND s.Origin = 'L' 
    AND d.Category = 'B'
    AND e.Grade = 'C';
	
--QNUM 6

SELECT CourseMaster.CourseName FROM CourseMaster 
WHERE NOT EXISTS 
(
SELECT 1
FROM EnrollmentMaster 
WHERE CourseMaster.CID = EnrollmentMaster.CID
AND MONTH(EnrollmentMaster.DOE) = 5
AND YEAR(EnrollmentMaster.DOE) = 2020
);

--QNUM 7

SELECT CourseMaster.COURSENAME AS 'Course Name',
COUNT(EnrollmentMaster.CID) AS 'Number of Enrollments',
 CASE 
    WHEN COUNT(EnrollmentMaster.CID) > 50 THEN 'High'
    WHEN COUNT(EnrollmentMaster.CID) >= 20 AND COUNT(EnrollmentMaster.CID) <= 50 THEN 'Medium'
       ELSE 'Low'
    END AS 'Popularity'
FROM CourseMaster 
LEFT JOIN EnrollmentMaster  ON CourseMaster.CID = EnrollmentMaster.CID
GROUP BY CourseMaster.COURSENAME;


-- QNUM 8

SELECT
    StudentMaster.StudentName,
    CourseMaster.CourseName,
    DATEDIFF(DAY, EnrollmentMaster.DOE, GETDATE()) AS EnrollmentAgeInDays
FROM StudentMaster 
JOIN EnrollmentMaster  ON StudentMaster.SID = EnrollmentMaster.SID
JOIN  CourseMaster  ON EnrollmentMaster.CID = CourseMaster.CID
WHERE EnrollmentMaster.DOE = (SELECT MAX(DOE) FROM EnrollmentMaster WHERE SID = StudentMaster.SID);


-- QNUM 9

SELECT StudentMaster.studentName
FROM StudentMaster 
JOIN EnrollmentMaster ON StudentMaster.SID = EnrollmentMaster.SID
JOIN CourseMaster ON EnrollmentMaster.CID = CourseMaster.CID
WHERE StudentMaster.origin = 'L' AND CourseMaster.Category = 'B'
GROUP BY StudentMaster.SID, StudentMaster.studentName
HAVING COUNT (*)= 3;


--QNUM 10


SELECT CourseMaster.CourseName
FROM CourseMaster 
WHERE 
NOT EXISTS
(
  SELECT 1
  FROM StudentMaster 
  WHERE NOT EXISTS
  (SELECT 1
  FROM EnrollmentMaster 
  WHERE EnrollmentMaster.CID = CourseMaster.CID AND EnrollmentMaster.SID = StudentMaster.SID)
);

--QNUM 11

SELECT StudentMaster.studentName
FROM EnrollmentMaster
INNER JOIN StudentMaster ON EnrollmentMaster.SID = StudentMaster.SID
WHERE EnrollmentMaster.grade = 'O' AND EnrollmentMaster.FWF = 1;


--QNUM 12

SELECT DISTINCT StudentMaster.StudentName
FROM StudentMaster 
JOIN EnrollmentMaster ON StudentMaster.SID = EnrollmentMaster.SID
JOIN CourseMaster ON EnrollmentMaster.CID = CourseMaster.CID
WHERE StudentMaster.Origin = 'F' 
AND StudentMaster.Type = 'U' 
AND CourseMaster.Category = 'B'
AND EnrollmentMaster.Grade = 'C';


--QNUM 13

SELECT CourseMaster.COURSENAME, COUNT(EnrollmentMaster.CID) AS TotalEnrollments
FROM CourseMaster 
INNER JOIN EnrollmentMaster ON CourseMaster.CID = EnrollmentMaster.CID
WHERE MONTH(EnrollmentMaster.DOE) = MONTH(GETDATE()) AND YEAR(EnrollmentMaster.DOE) = YEAR(GETDATE())
GROUP BY CourseMaster.COURSENAME;

-- THE END   