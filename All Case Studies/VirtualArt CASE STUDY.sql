CREATE DATABASE VirtualArtGallery;
use [VirtualArtGallery];

CREATE TABLE ArtWork
(
	ArtWorkId INT PRIMARY KEY,
	Title VARCHAR(30),
	Description VARCHAR(150),
	CreationDate DATE,
	Medium VARCHAR(100),
	ImageUrl VARCHAR(30)
);

CREATE TABLE Artist
(
	ArtistId INT PRIMARY KEY,
	Name VARCHAR(30),
	Biography VARCHAR(150),
	BirthDate DATE,
	Nationality VARCHAR(20),
	Website VARCHAR(100),
	Address VARCHAR(30),
	PhoneNumber VARCHAR(20)
);
CREATE TABLE Users
(
	UserId INT PRIMARY KEY,
	UserName VARCHAR(30),
	Email VARCHAR(50),
	Password VARCHAR(30),
	FirstName VARCHAR(30),
	LastName VARCHAR(30),
	DOB DATE,
	ProfilePic VARBINARY(MAX) ,
	FavouriteArtWorks INT FOREIGN KEY (FavouriteArtWorks) REFERENCES ArtWork(ArtWorkId)
);

ALTER TABLE Users
ALTER COLUMN ProfilePic VARCHAR(30);

CREATE TABLE Gallery
(
	GalleryId INT PRIMARY KEY,
	Name VARCHAR(30),
	Description VARCHAR(100),
	Location VARCHAR(50),
	Curator INT FOREIGN KEY (Curator) REFERENCES Artist(ArtistID),
	OpeningHours VARCHAR(100)
);
INSERT INTO ArtWork 
VALUES
(1, 'Paint', 'lord shiva', '2022-10-11', 'oil paint', 'image1.png'),
(2, 'photo', 'lord vishnu', '2022-10-12', 'paper work', 'image2.png'),
(3, 'paper', 'lord hanuman', '2022-10-13', 'Digital', 'image3.png'),
(4, 'Drawing', 'lord rama', '2022-10-14', 'Pencil ', 'image4.png'),
(5, 'computer', 'lord vinayaka', '2022-10-15', 'digital', 'image5.png');

INSERT INTO Artist 
VALUES(1, 'jeevan', 'Biography jeevan', '2023-10-11', 'Indian', 'www.india.com', 'vizag', '0000000001'),
(2, 'virat', 'Biography virat', '2023-10-12', 'chinese', 'www.china.com', 'srikakulam', '0000000002'),
(3, 'kohli', 'Biography kohli', '2023-10-13', 'American', 'www.america.com', 'east godavari', '0000000003'),
(4, 'sachin', 'Biography sachin', '2023-10-14', 'Japanese', 'www.japan.com', 'guntur', '0000000004'),
(5, 'chaithu', 'Biography chaithu', '2023-10-15', 'Italian', 'www.italy.com', 'kadapa', '0000000005');
INSERT INTO Users
VALUES(10, 'user1', 'user1@email.com', 'password1', 'jeevan', 'sai', '2001-10-24', 'profile1.jpg', 1),
(20, 'user2', 'user2@email.com', 'password2', 'kohli', 'virat', '2001-10-25', 'profile2.jpg', 2),
(3, 'user3', 'user3@email.com', 'password3', 'sachin', 'Tendulkar', '2001-10-26', 'profile3.jpg',3),
(4, 'user4', 'user4@email.com', 'password4', 'mahi', 'dhoni', '2001-10-27', 'profile4.jpg',4),
(5, 'user5', 'user5@email.com', 'password5', 'rahul', 'dravid', '2001-10-28', 'profile5.jpg',5);

INSERT INTO Gallery 
VALUES(101, 'Gallery 1', 'Contemporary Art', 'vizag', 1, '10:00 AM - 6:00 PM'),
(102, 'Gallery 2', 'Modern Art', 'kakinada', 2, '11:30 AM - 7:00 PM'),
(103, 'Gallery 3', 'Abstract Art', 'godavari', 3, '10:00 AM - 5:00 PM'),
(104, 'Gallery 4', 'Impressionist Art', 'kurnoole', 4, '11:00 PM - 8:00 PM'),
(105, 'Gallery 5', 'Sculpture Exhibition', 'hyderabad', 5, '1:00 PM - 9:00 PM');