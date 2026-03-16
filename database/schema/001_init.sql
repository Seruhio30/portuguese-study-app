CREATE DATABASE IF NOT EXISTS portugues_app
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE portugues_app;

CREATE TABLE levels (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    code VARCHAR(10) NOT NULL UNIQUE,
    name VARCHAR(50) NOT NULL,
    description TEXT,
    order_index INT NOT NULL
);

CREATE TABLE users (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(120) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    native_language VARCHAR(50) DEFAULT 'es',
    target_language VARCHAR(50) DEFAULT 'pt',
    current_level_id BIGINT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (current_level_id) REFERENCES levels(id)
);

CREATE TABLE tenses (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    code VARCHAR(60) NOT NULL UNIQUE,
    mood VARCHAR(50) NOT NULL,
    level_id BIGINT,
    description TEXT,
    FOREIGN KEY (level_id) REFERENCES levels(id)
);

CREATE TABLE pronouns (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    code VARCHAR(50) NOT NULL UNIQUE,
    display_name VARCHAR(50) NOT NULL,
    person_number VARCHAR(10) NOT NULL,
    sort_order INT NOT NULL
);

CREATE TABLE verbs (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    infinitive VARCHAR(100) NOT NULL UNIQUE,
    translation_es VARCHAR(150) NOT NULL,
    regular_type VARCHAR(20) NOT NULL,
    is_irregular BOOLEAN DEFAULT FALSE,
    difficulty_level_id BIGINT,
    FOREIGN KEY (difficulty_level_id) REFERENCES levels(id)
);

CREATE TABLE verb_conjugations (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    verb_id BIGINT NOT NULL,
    tense_id BIGINT NOT NULL,
    pronoun_id BIGINT NOT NULL,
    conjugated_form VARCHAR(100) NOT NULL,
    FOREIGN KEY (verb_id) REFERENCES verbs(id),
    FOREIGN KEY (tense_id) REFERENCES tenses(id),
    FOREIGN KEY (pronoun_id) REFERENCES pronouns(id),
    UNIQUE (verb_id, tense_id, pronoun_id)
);

CREATE TABLE user_verb_progress (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id BIGINT NOT NULL,
    verb_id BIGINT NOT NULL,
    times_seen INT DEFAULT 0,
    times_correct INT DEFAULT 0,
    times_incorrect INT DEFAULT 0,
    mastery_score DECIMAL(5,2) DEFAULT 0,
    status VARCHAR(20) DEFAULT 'new',
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (verb_id) REFERENCES verbs(id)
);

CREATE TABLE vocabulary_words (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    word_pt VARCHAR(120) NOT NULL,
    translation_es VARCHAR(120) NOT NULL,
    example_pt TEXT,
    example_es TEXT,
    category VARCHAR(50),
    level_id BIGINT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (level_id) REFERENCES levels(id)
);