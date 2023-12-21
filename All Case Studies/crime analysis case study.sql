create database Crime_Analysis;

use Crime_Analysis;

CREATE TABLE Victims (
    VictimID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DateOfBirth DATE,
    Gender CHAR,
    PhoneNumber CHAR(10)
);

CREATE TABLE Suspects (
    SuspectID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DateOfBirth DATE,
    Gender VARCHAR(10),
    PhoneNumber VARCHAR(20)
);

CREATE TABLE LawEnforcementAgencies (
    AgencyID INT PRIMARY KEY,
    AgencyName VARCHAR(100),
    Jurisdiction VARCHAR(100),
    ContactInformation VARCHAR(200)
);

CREATE TABLE Officers (
    OfficerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    BadgeNumber VARCHAR(20),
    Rank VARCHAR(50),
    Phonenumber CHAR(10),
    AgencyID INT,
    FOREIGN KEY (AgencyID) REFERENCES LawEnforcementAgencies(AgencyID)
);

CREATE TABLE Incidents (
    IncidentID INT PRIMARY KEY,
    IncidentType VARCHAR(50),
    IncidentDate DATE,
    Location VARCHAR(100), 
    Description TEXT,
    Status VARCHAR(20),
    VictimID INT,
    SuspectID INT,
    AgencyID INT,
    FOREIGN KEY (VictimID) REFERENCES Victims(VictimID),
    FOREIGN KEY (SuspectID) REFERENCES Suspects(SuspectID),
    FOREIGN KEY (AgencyID) REFERENCES LawEnforcementAgencies(AgencyID)
);


CREATE TABLE Evidence (
    EvidenceID INT PRIMARY KEY,
    Description TEXT,
    LocationFound VARCHAR(255),
    IncidentID INT,
    FOREIGN KEY (IncidentID) REFERENCES Incidents(IncidentID)
);


CREATE TABLE Reports (
    ReportID INT PRIMARY KEY,
    IncidentID INT,
    ReportingOfficerID INT,
    ReportDate DATE,
    ReportDetails TEXT,
    Status VARCHAR(20),
    FOREIGN KEY (IncidentID) REFERENCES Incidents(IncidentID),
    FOREIGN KEY (ReportingOfficerID) REFERENCES Officers(OfficerID)
);

-- Insert values into Victims table
INSERT INTO Victims (VictimID, FirstName, LastName, DateOfBirth, Gender,  PhoneNumber)
VALUES
(1, 'bharath', 'kumar', '1997-08-22', 'M',  '0000000001'),
(2, 'queen', 'one', '2000-08-22', 'F', '0000000002'),
(3, 'venky', 'singh', '1995-02-10', 'M', '0000000003'),
(4, 'queenn', 'two', '2001-11-30', 'F',  '0000000004'),
(5, 'robo', 'one', '1998-07-18', 'M', '0000000005');

select * from  Suspects

-- Insert values into Suspects table
INSERT INTO Suspects (SuspectID, FirstName, LastName, DateOfBirth, Gender, PhoneNumber)
VALUES
(6, 'Sunil', 'babu', '1998-04-29', 'M', '0000000006'),
(7, 'Sujan', 'Kumari', '1993-08-12', 'F',  '0000000007'),
(8, 'anandh', 'patel', '1999-12-05', 'M',  '0000000008'),
(9, 'queeen', 'three', '1999-07-20', 'F',  '0000000009'),
(10, 'jai', 'dev', '1998-06-08', 'M', '0000000010');

-- Insert values into LawEnforcementAgencies table
INSERT INTO LawEnforcementAgencies (AgencyID, AgencyName, Jurisdiction, ContactInformation)
VALUES
(11, 'City Police Department', 'City A', '10101'),
(12, 'County Sheriff Office', 'County B', '10102'),
(13, 'State Highway Patrol', 'State C', '10103'),
(14, 'Federal Bureau of Investigation', 'Federal', '10104'),
(15, 'Drug Enforcement Administration', 'DEA', '10105');

-- Insert values into Officers table
INSERT INTO Officers (OfficerID, FirstName, LastName, BadgeNumber, Rank, Phonenumber, AgencyID)
VALUES
(16, 'axe', 'gon', '12345', 'Detective', '0000000011', 11),
(17, 'hexa', 'non', '67890', 'Sergeant', '0000000012', 12),
(18, 'octa', 'gon', '54321', 'Special Agent', '0000000013', 13),
(19, 'penta', 'Davis', '98765', 'Special Agent in Charge', '0000000014', 14),
(20, 'Troop', 'John', '24680', 'Trooper', '0000000015', 15);

-- Insert values into Incidents table
INSERT INTO Incidents (IncidentID, IncidentType, IncidentDate, Location, Description, Status, VictimID, SuspectID, AgencyID)
VALUES
(21, 'Robbery', '2023-01-05', 'Vizag', 'Armed robbery at a convenience store', 'Open', 1, 6, 11),
(22, 'Homicide', '2023-02-15', 'kadapa', 'Fatal shooting in a residential area', 'Closed', 2, 7, 12),
(23, 'Theft', '2023-03-20','nellore', 'Shoplifting at a mall', 'Under Investigation', 3, 8, 13),
(24, 'Robbery', '2023-04-10', 'ananthapur', 'Bank robbery with hostages', 'Open', 4, 9, 14),
(25, 'Homicide', '2023-05-25', 'hyderabad', 'Gang-related shooting in the city', 'Closed', 5, 10, 15);

-- Insert values into Evidence table
INSERT INTO Evidence (EvidenceID, Description, LocationFound, IncidentID)
VALUES
(26, 'Security camera footage', 'Store premises', 21),
(27, 'Weapon found at crime scene', 'near to crime scene', 22),
(28, 'Stolen items recovered', 'Mall premises', 23),
(29, 'Hostage statements', 'Bank premises', 24),
(30, 'Forensic evidence', 'Crime scene', 25);

-- Insert values into Reports table
INSERT INTO Reports (ReportID, IncidentID, ReportingOfficerID, ReportDate, ReportDetails, Status)
VALUES
(31, 21, 16, '2023-01-10', 'Initial report', 'close'),
(32, 22, 17, '2023-02-11', 'Finalized homicide report', 'Finalized'),
(33, 23, 18, '2023-03-12', 'Ongoing investigation report', 'close'),
(34, 24, 19, '2023-04-14', 'Bank robbery report', 'Finalized'),
(35, 25, 20, '2023-06-09', 'Gang homicide report', 'open');