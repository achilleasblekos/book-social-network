CREATE TABLE book
(
    id                 INT AUTO_INCREMENT NOT NULL,
    created_date       datetime NOT NULL,
    last_modified_date datetime NULL,
    created_by         INT      NOT NULL,
    last_modified_by   INT NULL,
    title              VARCHAR(255) NULL,
    author_name        VARCHAR(255) NULL,
    isbn               VARCHAR(255) NULL,
    synopsis           VARCHAR(255) NULL,
    book_cover         VARCHAR(255) NULL,
    archived           BIT(1)   NOT NULL,
    shareable          BIT(1)   NOT NULL,
    owner_id           INT NULL,
    CONSTRAINT pk_book PRIMARY KEY (id)
);

CREATE TABLE book_transaction_history
(
    id                 INT AUTO_INCREMENT NOT NULL,
    created_date       datetime NOT NULL,
    last_modified_date datetime NULL,
    created_by         INT      NOT NULL,
    last_modified_by   INT NULL,
    user_id            INT NULL,
    book_id            INT NULL,
    returned           BIT(1)   NOT NULL,
    return_approved    BIT(1)   NOT NULL,
    CONSTRAINT pk_booktransactionhistory PRIMARY KEY (id)
);

CREATE TABLE feedback
(
    id                 INT AUTO_INCREMENT NOT NULL,
    created_date       datetime NOT NULL,
    last_modified_date datetime NULL,
    created_by         INT      NOT NULL,
    last_modified_by   INT NULL,
    note DOUBLE NULL,
    comment            VARCHAR(255) NULL,
    book_id            INT NULL,
    CONSTRAINT pk_feedback PRIMARY KEY (id)
);

CREATE TABLE `role`
(
    id                 INT AUTO_INCREMENT NOT NULL,
    name               VARCHAR(255) NULL,
    created_date       datetime NOT NULL,
    last_modified_date datetime NULL,
    CONSTRAINT pk_role PRIMARY KEY (id)
);

CREATE TABLE token
(
    id           INT AUTO_INCREMENT NOT NULL,
    token        VARCHAR(255) NULL,
    created_at   datetime NULL,
    expires_at   datetime NULL,
    validated_at datetime NULL,
    user_id      INT NOT NULL,
    CONSTRAINT pk_token PRIMARY KEY (id)
);

CREATE TABLE user
(
    id                 INT AUTO_INCREMENT NOT NULL,
    firstname          VARCHAR(255) NULL,
    lastname           VARCHAR(255) NULL,
    date_of_birth      date NULL,
    email              VARCHAR(255) NULL,
    password           VARCHAR(255) NULL,
    account_locked     BIT(1)   NOT NULL,
    enabled            BIT(1)   NOT NULL,
    created_date       datetime NOT NULL,
    last_modified_date datetime NULL,
    CONSTRAINT pk_user PRIMARY KEY (id)
);

CREATE TABLE user_roles
(
    roles_id INT NOT NULL,
    users_id INT NOT NULL
);

ALTER TABLE user
    ADD CONSTRAINT uc_user_email UNIQUE (email);

ALTER TABLE book_transaction_history
    ADD CONSTRAINT FK_BOOKTRANSACTIONHISTORY_ON_BOOK FOREIGN KEY (book_id) REFERENCES book (id);

ALTER TABLE book_transaction_history
    ADD CONSTRAINT FK_BOOKTRANSACTIONHISTORY_ON_USER FOREIGN KEY (user_id) REFERENCES user (id);

ALTER TABLE book
    ADD CONSTRAINT FK_BOOK_ON_OWNER FOREIGN KEY (owner_id) REFERENCES user (id);

ALTER TABLE feedback
    ADD CONSTRAINT FK_FEEDBACK_ON_BOOK FOREIGN KEY (book_id) REFERENCES book (id);

ALTER TABLE token
    ADD CONSTRAINT FK_TOKEN_ON_USERID FOREIGN KEY (user_id) REFERENCES user (id);

ALTER TABLE user_roles
    ADD CONSTRAINT fk_userol_on_role FOREIGN KEY (roles_id) REFERENCES `role` (id);

ALTER TABLE user_roles
    ADD CONSTRAINT fk_userol_on_user FOREIGN KEY (users_id) REFERENCES user (id);