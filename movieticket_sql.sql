create database movieshowticket;
use movieshowticket;
-- Movies Table
CREATE TABLE Movies (
    MovieID INT PRIMARY KEY IDENTITY,
    Title VARCHAR(100) NOT NULL,
    Genre VARCHAR(50),
    ReleaseDate DATE
);

-- Showtimes Table
CREATE TABLE Showtimes (
    ShowtimeID INT PRIMARY KEY IDENTITY,
    MovieID INT FOREIGN KEY REFERENCES Movies(MovieID),
    ShowDateTime DATETIME
);

-- Bookings Table
CREATE TABLE Bookings (
    BookingID INT PRIMARY KEY IDENTITY,
    ShowtimeID INT FOREIGN KEY REFERENCES Showtimes(ShowtimeID),
    CustomerName VARCHAR(100),
    BookingDate DATE DEFAULT GETDATE()
);


-- Insert Movies
INSERT INTO Movies (Title, Genre, ReleaseDate) VALUES
('Inception', 'Sci-Fi', '2010-07-16'),
('Avengers: Endgame', 'Action', '2019-04-26'),
('The Lion King', 'Animation', '1994-06-15');

-- Insert Showtimes
INSERT INTO Showtimes (MovieID, ShowDateTime) VALUES
(1, '2025-05-21 14:00:00'),
(2, '2025-05-22 18:30:00'),
(3, '2025-05-23 12:00:00');

-- Insert Bookings
INSERT INTO Bookings (ShowtimeID, CustomerName) VALUES
(1, 'Alice'),
(2, 'Bob'),
(2, 'Charlie'),
(3, 'David');


--join used--
-- Show all bookings with movie title and showtime
SELECT 
    b.BookingID,
    b.CustomerName,
    m.Title AS MovieTitle,
    s.ShowDateTime
FROM Bookings b
JOIN Showtimes s ON b.ShowtimeID = s.ShowtimeID
JOIN Movies m ON s.MovieID = m.MovieID;

-- Update movie release date
UPDATE Movies
SET ReleaseDate = '2010-07-20'
WHERE Title = 'Inception';

-- Update customer name in booking
UPDATE Bookings
SET CustomerName = 'Alice Cooper'
WHERE CustomerName = 'Alice';

-- Delete a booking
DELETE FROM Bookings
WHERE CustomerName = 'David';

-- Delete a showtime (only if no bookings exist for it)
DELETE FROM Showtimes
WHERE ShowtimeID = 3 AND NOT EXISTS (
    SELECT 1 FROM Bookings WHERE ShowtimeID = 3
);

-- Drop in reverse order due to FK constraints
DROP TABLE Bookings;
DROP TABLE Showtimes;
DROP TABLE Movies;

