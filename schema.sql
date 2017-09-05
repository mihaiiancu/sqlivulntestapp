CREATE DATABASE ItemListDb;

CREATE TABLE ItemListDb.tblUser (
userId INT NOT NULL AUTO_INCREMENT,
userName VARCHAR(45) NOT NULL,
password VARCHAR(45) NOT NULL,
PRIMARY KEY (userId));

CREATE TABLE ItemListDb.tblItem (
itemId INT NOT NULL AUTO_INCREMENT,
userId INT NOT NULL,
itemName VARCHAR(45) NULL,
PRIMARY KEY (itemId));

ALTER TABLE ItemListDb.tblUser ADD CONSTRAINT unique_username UNIQUE (userName);

ALTER TABLE ItemListDb.tblItem
ADD CONSTRAINT FK_USER_ITEM FOREIGN KEY (userId)
REFERENCES ItemListDb.tblUser(userId);

CREATE USER 'mihai'@'%' IDENTIFIED BY 's3k5E7-D40w5s@p+';
GRANT ALL PRIVILEGES ON ItemListDb.* TO 'mihai'@'%';

#ALTER TABLE 'ItemListDb'.'tblUser' DROP INDEX unique_username;
#ALTER TABLE tbl_name DROP FOREIGN KEY fk_userid;
