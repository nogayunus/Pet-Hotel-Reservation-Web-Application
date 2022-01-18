create table customer (
username varchar(25) primary key,
namesurname varchar(25),
phonenumber varchar(11),
namesurname varchar(25),
email varchar(25),
password varchar(25)
);
create table roomtype (
roomtype varchar(25) primary key
);
create table pettype (
pettype varchar(25) primary key,
roomtype varchar(25),
foreign key (roomtype) references roomtype(roomtype)
);
create table pet (
petid int primary key,
petname varchar(25),
pettype varchar(25),
age int,
gender varchar(6),
owner varchar(25),
foreign key (pettype) references pettype(pettype),
foreign key (owner) references customer(username)
);
create table bdate (
bday int primary key,
dmonth varchar(20),
byear int,
status boolean
);
create table reservation (
resid int primary key,
username varchar(25),
petid int,
bday int
foreign key (username) references customer(username),
foreign key (petid) references pet(petid),
foreign key (bday) references bdate(bday)
);
insert into bdate values (1,'May',2022,true);
insert into bdate values (2,'May',2022,true);
insert into bdate values (3,'May',2022,true);
insert into bdate values (4,'May',2022,true);
insert into bdate values (5,'May',2022,true);
insert into bdate values (6,'May',2022,true);
insert into bdate values (7,'May',2022,true);
insert into bdate values (8,'May',2022,true);
insert into bdate values (9,'May',2022,true);
insert into bdate values (10,'May',2022,true);
insert into bdate values (12,'May',2022,true);
insert into bdate values (13,'May',2022,true);
insert into bdate values (14,'May',2022,true);
insert into bdate values (15,'May',2022,true);
insert into bdate values (16,'May',2022,true);
insert into bdate values (17,'May',2022,true);
insert into bdate values (18,'May',2022,true);
insert into bdate values (19,'May',2022,true);
insert into bdate values (20,'May',2022,true);
insert into bdate values (21,'May',2022,true);
insert into bdate values (22,'May',2022,true);
insert into bdate values (23,'May',2022,true);
insert into bdate values (24,'May',2022,true);
insert into bdate values (25,'May',2022,true);
insert into bdate values (26,'May',2022,true);
insert into bdate values (27,'May',2022,true);
insert into bdate values (28,'May',2022,true);
insert into bdate values (29,'May',2022,true);
insert into bdate values (30,'May',2022,true);

