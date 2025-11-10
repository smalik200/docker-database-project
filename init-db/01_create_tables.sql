DROP TABLE IF EXISTS notification      CASCADE;
DROP TABLE IF EXISTS recommendation    CASCADE;
DROP TABLE IF EXISTS review            CASCADE;
DROP TABLE IF EXISTS enrollment        CASCADE;
DROP TABLE IF EXISTS course            CASCADE;
DROP TABLE IF EXISTS semester_plan     CASCADE;
DROP TABLE IF EXISTS degree_plan       CASCADE;
DROP TABLE IF EXISTS advisor           CASCADE;
DROP TABLE IF EXISTS student           CASCADE;

CREATE TABLE student (
  student_id SERIAL PRIMARY KEY,
  name            VARCHAR(100),
  email           VARCHAR(100) UNIQUE,
  major           VARCHAR(100),
  minor           VARCHAR(100),
  gpa             NUMERIC(3,2) CHECK (gpa >= 0 AND gpa <= 4.00),
  total_credits   INT DEFAULT 0 CHECK (total_credits >= 0)
);

CREATE TABLE advisor (
  advisor_id SERIAL PRIMARY KEY,
  name        VARCHAR(100),
  email       VARCHAR(100) UNIQUE,
  department  VARCHAR(100)
);

CREATE TABLE degree_plan (
  plan_id            SERIAL PRIMARY KEY,
  student_id         INT REFERENCES student(student_id) ON DELETE CASCADE,
  advisor_id         INT REFERENCES advisor(advisor_id) ON DELETE SET NULL,
  major              VARCHAR(100),
  expected_grad_year INT CHECK (expected_grad_year BETWEEN 1900 AND 2100),
  status             VARCHAR(20) CHECK (status IN ('Draft','Submitted','Approved')),
  last_updated       TIMESTAMP DEFAULT NOW()
);

CREATE TABLE semester_plan (
  semester_id   SERIAL PRIMARY KEY,
  plan_id       INT REFERENCES degree_plan(plan_id) ON DELETE CASCADE,
  semester_name VARCHAR(20),
  total_credits INT DEFAULT 0 CHECK (total_credits >= 0)
);

CREATE TABLE course (
  course_id     SERIAL PRIMARY KEY,
  course_code   VARCHAR(10) UNIQUE,
  course_name   VARCHAR(100),
  credits       INT CHECK (credits >= 0),
  prerequisites VARCHAR(255),
  department    VARCHAR(50)
);

CREATE TABLE enrollment (
  enrollment_id SERIAL PRIMARY KEY,
  semester_id   INT REFERENCES semester_plan(semester_id) ON DELETE CASCADE,
  course_id     INT REFERENCES course(course_id),
  grade         VARCHAR(2)
);

CREATE TABLE review (
  review_id      SERIAL PRIMARY KEY,
  student_id     INT REFERENCES student(student_id) ON DELETE CASCADE,
  course_id      INT REFERENCES course(course_id) ON DELETE CASCADE,
  professor_name VARCHAR(100),
  rating         INT CHECK (rating BETWEEN 1 AND 5),
  comment        TEXT,
  date_posted    TIMESTAMP DEFAULT NOW(),
  approved       BOOLEAN DEFAULT FALSE
);

CREATE TABLE recommendation (
  recommendation_id  SERIAL PRIMARY KEY,
  student_id         INT REFERENCES student(student_id) ON DELETE CASCADE,
  course_id          INT REFERENCES course(course_id) ON DELETE CASCADE,
  reason             TEXT,
  semester_suggested VARCHAR(20),
  status             VARCHAR(20) CHECK (status IN ('Accepted','Rejected','Pending')) DEFAULT 'Pending'
);

CREATE TABLE notification (
  notification_id SERIAL PRIMARY KEY,
  student_id      INT REFERENCES student(student_id) ON DELETE CASCADE,
  message         TEXT,
  type            VARCHAR(50) CHECK (type IN ('Conflict','Prerequisite','Approval','Update')),
  date_sent       TIMESTAMP DEFAULT NOW(),
  read_status     BOOLEAN DEFAULT FALSE
);

CREATE INDEX idx_degree_plan_student  ON degree_plan(student_id);
CREATE INDEX idx_degree_plan_advisor  ON degree_plan(advisor_id);
CREATE INDEX idx_semester_plan_plan   ON semester_plan(plan_id);
CREATE INDEX idx_enroll_semester      ON enrollment(semester_id);
CREATE INDEX idx_enroll_course        ON enrollment(course_id);
CREATE INDEX idx_review_course        ON review(course_id);
CREATE INDEX idx_review_student       ON review(student_id);
CREATE INDEX idx_reco_student         ON recommendation(student_id);
CREATE INDEX idx_reco_course          ON recommendation(course_id);
CREATE INDEX idx_notif_student        ON notification(student_id);
