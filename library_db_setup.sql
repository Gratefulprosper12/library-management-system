-- LIBRARY MANAGEMENT SYSTEM DATABASE
-- Author: GRATEFUL PROSPER
-- Description: Manages books, members, loans, and returns
-- =============================================
DROP DATABASE IF EXISTS library_db;
CREATE DATABASE library_db;
USE library_db;
-- table books that stores information
CREATE TABLE books(
book_id INT AUTO_INCREMENT PRIMARY KEY,
title VARCHAR(100) NOT NULL,
author VARCHAR(70) NOT NULL,
isbn VARCHAR(30) UNIQUE NOT NULL,
published_date DATE,
genre VARCHAR(40),
available_copies INT DEFAULT 1,
CHECK (available_copies >=0) -- ensures no negative copies
);

-- TABLE, members i.e library members

CREATE TABLE members(
member_id INT AUTO_INCREMENT PRIMARY KEY,
first_name VARCHAR(100) NOT NULL,
last_name VARCHAR(100) NOT NULL,
email VARCHAR(100) UNIQUE NOT NULL,
phone VARCHAR(20),
join_date DATE DEFAULT (CURRENT_DATE)
);

-- 🏷️ Table: 'categories' - Book genres (M-M relationship via junction table)

CREATE TABLE categories(
category_id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(50) UNIQUE NOT NULL
);

-- TABLE  loans i.e book_borrowings(tracks the members who borrowed a book) (ONE TO MANY RLSHP)	
CREATE TABLE loans(
loan_id INT AUTO_INCREMENT PRIMARY KEY,
book_id INT NOT NULL,
member_id INT NOT NULL,
loan_date DATE DEFAULT (CURRENT_DATE),
due_date DATE DEFAULT (DATE_ADD(CURRENT_DATE, INTERVAL 14 DAY)), -- 14 DAY LOAN
return_date DATE,
FOREIGN KEY (book_id) REFERENCES books(book_id),
FOREIGN KEY (member_id) REFERENCES members(member_id)
);

-- Junction Table: 'book_categories' (M-M relationship between books & categories)
CREATE TABLE book_categories(
book_id INT,
category_id INT,
PRIMARY KEY(book_id, category_id),
FOREIGN KEY (book_id) REFERENCES books(book_id),
FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

-- 📥 Insert sample data
INSERT INTO books (title, author, isbn, published_date, genre, available_copies) VALUES
('The Great Gatsby', 'F. Scott Fitzgerald', '9780743273565', '1925-04-10', 'Classic', 3),
('To Kill a Mockingbird', 'Harper Lee', '9780061120084', '1960-07-11', 'Classic', 5),
('1984', 'George Orwell', '9780451524935', '1949-06-08', 'Dystopian', 4),
('Pride and Prejudice', 'Jane Austen', '9780141439518', '1813-01-28', 'Romance', 6),
('The Hobbit', 'J.R.R. Tolkien', '9780547928227', '1937-09-21', 'Fantasy', 7),
('The Catcher in the Rye', 'J.D. Salinger', '9780316769488', '1951-07-16', 'Literary Fiction', 2),
('The Da Vinci Code', 'Dan Brown', '9780307474278', '2003-03-18', 'Thriller', 8),
('Harry Potter and the Sorcerer''s Stone', 'J.K. Rowling', '9780590353427', '1997-06-26', 'Fantasy', 10),
('The Alchemist', 'Paulo Coelho', '9780062315007', '1988-01-01', 'Philosophical Fiction', 9),
('The Shining', 'Stephen King', '9780307743657', '1977-01-28', 'Horror', 3),
('Brave New World', 'Aldous Huxley', '9780060850524', '1932-01-01', 'Science Fiction', 4),
('The Hunger Games', 'Suzanne Collins', '9780439023481', '2008-09-14', 'Dystopian', 6),
('Gone Girl', 'Gillian Flynn', '9780307588364', '2012-06-05', 'Psychological Thriller', 5),
('The Silent Patient', 'Alex Michaelides', '9781250301697', '2019-02-05', 'Mystery', 7),
('Dune', 'Frank Herbert', '9780441172719', '1965-08-01', 'Science Fiction', 3),
('The Girl on the Train', 'Paula Hawkins', '9781594634024', '2015-01-13', 'Thriller', 4),
('The Road', 'Cormac McCarthy', '9780307387899', '2006-09-26', 'Post-Apocalyptic', 2),
('The Book Thief', 'Markus Zusak', '9780375831003', '2005-03-14', 'Historical Fiction', 5),
('The Fault in Our Stars', 'John Green', '9780525478812', '2012-01-10', 'Young Adult', 8),
('Educated', 'Tara Westover', '9780399590504', '2018-02-20', 'Memoir', 6),
('Sapiens', 'Yuval Noah Harari', '9780062316097', '2011-02-10', 'Non-Fiction', 4);

INSERT INTO members (first_name, last_name, email, phone) VALUES
('Michael', 'Johnson', 'michael.johnson@email.com', '5551234567'),
('Emily', 'Williams', 'emily.williams@email.com', '5559876543'),
('Robert', 'Brown', 'robert.brown@email.com', '5554567890'),
('Sarah', 'Davis', 'sarah.davis@email.com', '5557890123'),
('David', 'Miller', 'david.miller@email.com', '5552345678'),
('Jennifer', 'Wilson', 'jennifer.wilson@email.com', '5558765432'),
('James', 'Taylor', 'james.taylor@email.com', '5553456789'),
('Jessica', 'Anderson', 'jessica.anderson@email.com', '5557654321'),
('Daniel', 'Thomas', 'daniel.thomas@email.com', '5556789012'),
('Lisa', 'Jackson', 'lisa.jackson@email.com', '5553210987'),
('Matthew', 'White', 'matthew.white@email.com', '5558901234'),
('Amanda', 'Harris', 'amanda.harris@email.com', '5554321098'),
('Christopher', 'Martin', 'christopher.martin@email.com', '5559012345'),
('Nicole', 'Thompson', 'nicole.thompson@email.com', '5552109876'),
('Andrew', 'Garcia', 'andrew.garcia@email.com', '5557891234'),
('Megan', 'Martinez', 'megan.martinez@email.com', '5550123456'),
('Kevin', 'Robinson', 'kevin.robinson@email.com', '5556782345'),
('Stephanie', 'Clark', 'stephanie.clark@email.com', '5551237890'),
('Ryan', 'Rodriguez', 'ryan.rodriguez@email.com', '5554560123'),
('Olivia', 'Lewis', 'olivia.lewis@email.com', '5557893456');

INSERT INTO categories (name) VALUES
('Fiction'),
('Classic'),
('Dystopian'),
('Science Fiction'),
('Historical Fiction'),
('Romance'),
('Fantasy'),
('Thriller'),
('Horror'),
('Mystery'),
('Young Adult'),
('Non-Fiction'),
('Memoir'),
('Philosophical Fiction'),
('Post-Apocalyptic');

INSERT INTO loans (book_id, member_id) VALUES
(1, 1),  -- Michael Johnson borrowed The Great Gatsby
(3, 2);  -- Emily Williams borrowed 1984

INSERT INTO book_categories VALUES
(1, 2),   -- The Great Gatsby (Classic)
(2, 2),   -- To Kill a Mockingbird (Classic)
(4, 2),   -- Pride and Prejudice (Classic)
(5, 2),   -- The Catcher in the Rye (Classic)
-- Dystopian
(3, 3),   -- 1984 (Dystopian)
(11, 3),  -- The Hunger Games (Dystopian)
-- Science Fiction
(10, 4),  -- Brave New World (Science Fiction)
(14, 4),  -- Dune (Science Fiction)
-- Fiction (general)
(6, 1),   -- The Da Vinci Code (Fiction/Thriller)
(7, 1),   -- Harry Potter and the Sorcerer's Stone (Fiction/Fantasy)
(8, 1),   -- The Alchemist (Fiction/Philosophical)
(9, 1),   -- The Shining (Fiction/Horror)
(12, 1),  -- Gone Girl (Fiction/Thriller)
(13, 1),  -- The Silent Patient (Fiction/Mystery)
(15, 1),  -- The Girl on the Train (Fiction/Thriller)
(16, 1),  -- The Road (Fiction/Post-Apocalyptic)
(17, 1),  -- The Book Thief (Fiction/Historical)
(18, 1);  -- The Fault in Our Stars (Fiction/YA)
-- table statements
UPDATE books SET available_copies = available_copies - 1 WHERE book_id = 1;
UPDATE books SET available_copies = available_copies- 1 where book_id =3;