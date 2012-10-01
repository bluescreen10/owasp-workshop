CREATE TABLE users(
       id       INTEGER PRIMARY KEY ASC,
       nick     VARCHAR(25) UNIQUE NOT NULL,
       password VARCHAR(27) NOT NULL
);

CREATE TABLE posts(
       id        INTEGER PRIMARY KEY ASC,
       text      TEXT NOT NULL,
       user      VARCHAR(25) NOT NULL,
       timestamp timestamp,           
       FOREIGN KEY(user) REFERENCES users(id)
);

CREATE TABLE session (
    sid          VARCHAR(40) PRIMARY KEY,
    data         TEXT,
    expires      INTEGER UNSIGNED NOT NULL,
    UNIQUE(sid)
);
 
