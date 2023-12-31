-- Active: 1698681509571@@127.0.0.1@5432@postgres@public
drop table if exists Laptop;
drop table if exists PC;
drop table if exists Printer;
drop table if exists Product;

CREATE TABLE Laptop (
	code int NOT NULL ,
	model varchar (50) NOT NULL ,
	speed smallint NOT NULL ,
	ram smallint NOT NULL ,
	hd real NOT NULL ,
	price decimal(12,2) NULL ,
	screen smallint NOT NULL 
) 
;

CREATE TABLE PC (
	code int NOT NULL ,
	model varchar (50) NOT NULL ,
	speed smallint NOT NULL ,
	ram smallint NOT NULL ,
	hd real NOT NULL ,
	cd varchar (10) NOT NULL ,
	price decimal(12,2) NULL 
) 
;

CREATE TABLE Product (
	maker varchar (10) NOT NULL ,
	model varchar (50) NOT NULL ,
	type varchar (50) NOT NULL 
) 
;

CREATE TABLE Printer (
	code int NOT NULL ,
	model varchar (50) NOT NULL ,
	color char (1) NOT NULL ,
	type varchar (10) NOT NULL ,
	price decimal(12,2) NULL 
) 
;

ALTER TABLE Laptop  ADD 
	CONSTRAINT PK_Laptop PRIMARY KEY
	(
		code
	)   
;

ALTER TABLE PC  ADD 
	CONSTRAINT PK_pc PRIMARY KEY 
	(
		code
	)   
;

ALTER TABLE Product  ADD 
	CONSTRAINT PK_product PRIMARY KEY 
	(
		model
	)   
;

ALTER TABLE Printer  ADD 
	CONSTRAINT PK_printer PRIMARY KEY 
	(
		code
	)   
;

ALTER TABLE Laptop ADD 
	CONSTRAINT FK_Laptop_product FOREIGN KEY 
	(
		model
	) REFERENCES Product (
		model
	)
;

ALTER TABLE PC ADD 
	CONSTRAINT FK_pc_product FOREIGN KEY 
	(
		model
	) REFERENCES Product (
		model
	)
;

ALTER TABLE Printer ADD 
	CONSTRAINT FK_printer_product FOREIGN KEY 
	(
		model
	) REFERENCES Product (
		model
	)
;


CREATE SEQUENCE pc_sequence
  start 1
  increment 1;


CREATE SEQUENCE laptop_sequence
  start 1
  increment 1;


CREATE SEQUENCE printer_sequence
  start 1
  increment 1;