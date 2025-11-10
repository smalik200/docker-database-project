# Project Database in Docker (PostgreSQL)

## Overview
Student–advisor–degree planning database running in Docker (PostgreSQL 15).  
Tables are created and seeded automatically from `init-db/` at first startup.

## How to run
```bash
docker compose upgit remote -v
# Docker Database Project

This project creates and runs a PostgreSQL database inside a Docker container for managing student, advisor, and degree planning data. It automatically creates and populates tables from the SQL scripts in the init-db folder when the container starts. To start the database, use the command `docker compose up`. To connect to the running database, use `docker exec -it my_project_db psql -U student -d projectdb`, then run `\dt` to list all tables and `SELECT * FROM student;` to view sample data. To stop the container, use `docker compose down`, and to reset the database completely (reloading all tables and data), use `docker compose down -v` followed by `docker compose up`. This setup verifies a working PostgreSQL environment with automatically initialized schema and sample data for IS 436 Deliverable 3.
