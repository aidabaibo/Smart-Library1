USE smart_library;

CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    role VARCHAR(30) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

SELECT * FROM users;



USE smart_library;

INSERT INTO users (full_name, email, phone, role)
VALUES
('Аида Байбосын', 'aida@gmail.com', '87011234567', 'reader'),
('Іңкәр Әділхан', 'inkar@gmail.com', '87021234567', 'reader'),
('Аружан Серік', 'aruzhan@gmail.com', '87031234567', 'librarian'),
('Медет Нұрғазы', 'medet@gmail.com', '87041234567', 'booking_employee'),
('Жұлдыз Амангелді', 'zhuldyz@gmail.com', '87051234567', 'admin');

SELECT * FROM users;



USE smart_library;

CREATE TABLE books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(150) NOT NULL,
    author VARCHAR(100) NOT NULL,
    isbn VARCHAR(20) UNIQUE,
    publication_year INT,
    total_copies INT NOT NULL DEFAULT 1,
    available_copies INT NOT NULL DEFAULT 1,
    hall VARCHAR(30),
    shelf VARCHAR(30)
);

SELECT * FROM books;


USE smart_library;

INSERT INTO books
(title, author, isbn, publication_year,
 total_copies, available_copies, hall, shelf)
VALUES
('Абай жолы', 'Мұхтар Әуезов', '9786010000001', 1942, 5, 5, 'A', '1'),
('Менің атым Қожа', 'Бердібек Соқпақбаев', '9786010000002', 1957, 4, 4, 'A', '2'),
('Көшпенділер', 'Ілияс Есенберлин', '9786010000003', 1969, 3, 3, 'B', '1'),
('Қара сөздер', 'Абай Құнанбайұлы', '9786010000004', 1890, 6, 6, 'B', '2'),
('Ақбілек', 'Жүсіпбек Аймауытов', '9786010000005', 1927, 2, 2, 'C', '1');

SELECT * FROM books;





USE smart_library;

CREATE TABLE library_cards (
    card_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL UNIQUE,
    card_number VARCHAR(30) NOT NULL UNIQUE,
    status VARCHAR(20) NOT NULL DEFAULT 'active',
    issue_date DATE NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    CHECK (status IN ('active', 'blocked'))
);

INSERT INTO library_cards
(user_id, card_number, status, issue_date)
VALUES
(1, 'LIB001', 'active', '2026-09-01'),
(2, 'LIB002', 'active', '2026-09-02');

SELECT * FROM library_cards;




USE smart_library;

CREATE TABLE reservations (
    reservation_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    book_id INT NOT NULL,
    reservation_date DATE NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'pending',
    prepared_by INT NULL,

    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id),
    FOREIGN KEY (prepared_by) REFERENCES users(user_id),

    CHECK (status IN
    ('pending', 'confirmed', 'ready', 'cancelled'))
);

INSERT INTO reservations
(user_id, book_id, reservation_date, status, prepared_by)
VALUES
(1, 1, '2026-10-12', 'pending', NULL),
(2, 2, '2026-10-12', 'confirmed', 4);

SELECT * FROM reservations;




USE smart_library;

UPDATE reservations
SET status = 'ready',
    prepared_by = 4
WHERE reservation_id = 2
  AND status = 'confirmed';

SELECT * FROM reservations;




USE smart_library;

INSERT INTO reservations
(user_id, book_id, reservation_date, status)
VALUES
(1, 3, '2026-10-12', 'cancelled');

SELECT * FROM reservations;

DELETE FROM reservations
WHERE user_id = 1
AND book_id = 3
AND status = 'cancelled';

SELECT * FROM reservations;

