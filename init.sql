-- Create database (run this first if database doesn't exist)
CREATE DATABASE forumhub;

-- Connect to forumhub database, then run the following:

-- Insert test users (passwords are BCrypt hashed - all passwords are "123456")
INSERT INTO usuarios (login, senha, nome, email) VALUES
('admin', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8w1BYQCqoAJ/RgEjlW', 'Administrador', 'admin@forumhub.com'),
('maria', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8w1BYQCqoAJ/RgEjlW', 'Maria Silva', 'maria@email.com'),
('joao', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8w1BYQCqoAJ/RgEjlW', 'João Santos', 'joao@email.com');

-- Insert test courses
INSERT INTO cursos (nome, categoria) VALUES
('Java', 'Programação'),
('Spring Boot', 'Programação'),
('Python', 'Programação'),
('JavaScript', 'Programação');

-- Note: Topics will be created via API
-- This script just sets up initial users and courses for testing
