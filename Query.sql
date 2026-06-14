-- =========================================================================
-- SYSTEM: Football Ticket Booking System Database Setup Template

-- =========================================================================

-- DROP TABLES IF THEY ALREADY EXIST TO PREVENT CONFLICTS
DROP TABLE IF EXISTS Bookings;
DROP TABLE IF EXISTS Matches;
DROP TABLE IF EXISTS Users;

-- =========================================================================
-- 1. CREATE USERS TABLE
-- =========================================================================
CREATE TABLE Users (
    user_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    role VARCHAR(20) NOT NULL 
    CHECK (role in('Football Fan', 'Ticket Manager')),
    phone_number VARCHAR(15)
    
);

-- =========================================================================
-- 2. CREATE MATCHES TABLE
-- =========================================================================
CREATE TABLE Matches (
    match_id INT PRIMARY KEY,
    fixture VARCHAR(100) NOT NULL,
    tournament_category VARCHAR(50) NOT NULL,
    base_ticket_price DECIMAL(10,5) NOT NULL 
    CHECK (base_ticket_price > 0),
    match_status VARCHAR(20) NOT NULL 
    CHECK (match_status in ('Available', 'Selling Fast', 'Sold Out', 'Postponed'))
    
);

-- =========================================================================
-- 3. CREATE BOOKINGS TABLE
-- =========================================================================
CREATE TABLE Bookings (
    booking_id INT PRIMARY KEY, -- Unique tracking transaction number
    user_id INT NOT NULL,
    match_id INT NOT NULL,

    CONSTRAINT Fk_BookingTable_User_Id
    FOREIGN KEY (user_id) REFERENCES users(user_id),

    CONSTRAINT Fk_BookingTable_Match_Id
    FOREIGN KEY (match_id) REFERENCES matches(match_id),

    seat_number VARCHAR(10),
    payment_status VARCHAR(15) 
    CHECK( payment_status in ('Pending', 'Confirmed', 'Cancelled', 'Refunded') OR payment_status IS NULL),
    total_cost DECIMAL(10,5),
    UNIQUE(match_id, seat_number)
    
);


-- =========================================================================
-- DATA SEEDING: INSERT SAMPLE DATA INTO USERS
-- =========================================================================
-- INSERT INTO Users (user_id, full_name, email, role, phone_number) VALUES
-- (1, 'Tanvir Rahman', 'tanvir@mail.com', 'Football Fan', '+8801711111111'),
-- (2, 'Asif Haque', 'asif@mail.com', 'Football Fan', '+8801722222222'),
-- (3, 'Sajjad Rahman', 'sajjad@mail.com', 'Ticket Manager', '+8801733333333'),
-- (4, 'Jannat Ara', 'jannat@mail.com', 'Football Fan', NULL);

-- =========================================================================
-- DATA SEEDING: INSERT SAMPLE DATA INTO MATCHES
-- =========================================================================
-- INSERT INTO Matches (match_id, fixture, tournament_category, base_ticket_price, match_status) VALUES
-- (101, 'Real Madrid vs Barcelona', 'Champions League', 150.00, 'Available'),
-- (102, 'Man City vs Liverpool', 'Premier League', 120.00, 'Selling Fast'),
-- (103, 'Bayern Munich vs PSG', 'Champions League', 130.00, 'Available'),
-- (104, 'AC Milan vs Inter Milan', 'Serie A', 90.00, 'Sold Out'),
-- (105, 'Juventus vs Roma', 'Serie A', 80.00, 'Available');

-- =========================================================================
-- DATA SEEDING: INSERT SAMPLE DATA INTO BOOKINGS
-- =========================================================================
-- INSERT INTO Bookings (booking_id, user_id, match_id, seat_number, payment_status, total_cost) VALUES
-- (501, 1, 101, 'A-12', 'Confirmed', 150.00),
-- (502, 1, 102, 'B-04', 'Confirmed', 120.00),
-- (503, 2, 101, 'A-13', 'Confirmed', 150.00),
-- (504, 2, 101, NULL, NULL, 150.00),
-- (505, 3, 102, 'C-20', 'Pending', 120.00);