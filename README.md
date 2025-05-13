# library-management-system
real world library management system
# Library Management System

## Description
A comprehensive database system for managing library operations including book inventory, member registrations, and loan tracking.

## Setup Instructions
1. Clone this repository
2. Execute the SQL script in your MySQL environment:
   ```bash
   mysql -u username -p < library_db_setup.sql

   Features
Book inventory management

Member registration

Loan tracking

Multi-category book classification


## Key Features Implemented

1. **Database Structure**:
   - Proper table relationships (1-to-many for loans, many-to-many for categories)
   - Constraints to maintain data integrity (CHECK for non-negative copies)

2. **Sample Data**:
   - Comprehensive set of books across multiple genres
   - Realistic member information
   - Proper category mappings

3. **Operational Logic**:
   - Automatic due date calculation (14 days from loan)
   - Available copies adjustment when books are loaned

4. **Project Organization**:
   - Single, well-commented SQL file
   - Complete README with setup instructions

This implementation provides a solid foundation for a library management system that can be extended with additional features like:
- Late fee calculations
- Book reservations
- Advanced search functionality
- Reporting tools

- ER DIAGRAM- KEY RELATIONSHIPS VISUALIZED

- +-------------+       +--------------+       +-------------+
|   BOOKS     |       |    LOANS     |       |  MEMBERS    |
+-------------+       +--------------+       +-------------+
| PK: book_id |←------| FK: book_id  |      | PK:member_id|
|    title    |  1    | FK:member_id |→ M   | first_name  |
|    author   |   ↓   |  loan_date   |      |  last_name  |
|     ...     |   M   |   due_date   |      |     ...     |
+-------------+       +--------------+       +-------------+
       ↑
       | M
+--------------+
| BOOK_CATEG   |
+--------------+       +-------------+
| FK:book_id   |→------| CATEGORIES  |
| FK:category_id|   M   +-------------+
+--------------+       | PK:cat_id   |
                       |    name     |
                       +-------------+
