INSERT INTO student (name, email, major, minor, gpa, total_credits) VALUES
('Alice Nguyen',  'anguyen1@umbc.edu', 'Computer Science',        'Mathematics', 3.85, 90),
('Brandon Lee',   'blee2@umbc.edu',    'Information Systems',      NULL,          3.40, 75),
('Chloe Smith',   'csmith3@umbc.edu',  'Mechanical Engineering',   'Physics',     3.67, 105);

INSERT INTO advisor (name, email, department) VALUES
('Dr. Karen Holt',    'kholt@umbc.edu', 'Computer Science & Electrical Engineering'),
('Prof. Michael Tran','mtran@umbc.edu', 'Information Systems'),
('Dr. Ana Rivera',    'arivera@umbc.edu','Mechanical Engineering');

INSERT INTO degree_plan (student_id, advisor_id, major, expected_grad_year, status)
VALUES
(1, 1, 'Computer Science',        2026, 'Approved'),
(2, 2, 'Information Systems',     2025, 'Submitted'),
(3, 3, 'Mechanical Engineering',  2027, 'Draft');

INSERT INTO semester_plan (plan_id, semester_name, total_credits) VALUES
(1, 'Fall 2025', 15),
(2, 'Spring 2025', 12),
(3, 'Fall 2026', 16);

INSERT INTO course (course_code, course_name, credits, prerequisites, department) VALUES
('CMSC202', 'Computer Science II', 4,  'CMSC201', 'Computer Science'),
('IS310',   'Database Design',     3,  'IS210',   'Information Systems'),
('ENME301', 'Dynamics',            3,  'ENME101', 'Mechanical Engineering');

INSERT INTO enrollment (semester_id, course_id, grade) VALUES
(1, 1, 'A'),
(2, 2, 'B'),
(3, 3, NULL);

INSERT INTO review (student_id, course_id, professor_name, rating, comment, approved)
VALUES
(1, 1, 'Dr. Jessica Park', 5, 'Great lectures and clear assignments.', TRUE),
(2, 2, 'Prof. Li Chen',    4, 'Challenging but rewarding.',           TRUE),
(3, 3, 'Dr. Raj Patel',    3, 'Interesting material but fast-paced.', FALSE);

INSERT INTO recommendation (student_id, course_id, reason, semester_suggested, status)
VALUES
(1, 2, 'Good complement for database systems knowledge.', 'Spring 2026', 'Pending'),
(2, 1, 'To strengthen programming fundamentals.',          'Fall 2025',   'Accepted'),
(3, 3, 'Core requirement for major completion.',           'Fall 2026',   'Pending');

INSERT INTO notification (student_id, message, type, read_status)
VALUES
(1, 'Your degree plan was approved.', 'Approval',     TRUE),
(2, 'Missing prerequisite for IS310.','Prerequisite', FALSE),
(3, 'Course ENME301 added to plan.',  'Update',       TRUE);
