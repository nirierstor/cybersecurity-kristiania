drop database if exists wow_forever;
create database wow_forever;
use wow_forever;

-- Tabell for factions (Alliance og Horde).
-- Hver race tilhører en faction, så race peker hit med faction_id

create table faction (
faction_id int primary key,
faction_name varchar(20) not null
); 

create table race (
race_id int primary key,
race_name varchar(30) not null,
faction_id int not null,
foreign key (faction_id) references faction(faction_id)
);


create table class (
class_id int primary key,
class_name varchar(20) not null
);

create table server (
server_id int primary key,
ruleset varchar(10) not null
);

create table player (
player_id int primary key,
username varchar(20) not null
);

create table game_character (
character_id int primary key,
character_name varchar(20),
character_level int,
created_date date not null,
player_id int,
race_id int,
class_id int,
server_id int,
foreign key (player_id) references player(player_id),
foreign key (race_id) references race(race_id),
foreign key (class_id) references class(class_id),
foreign key (server_id) references server(server_id)
);

-- Values (Ki brukt til å skrive randome v på de lengste!!)

insert into faction (faction_id, faction_name) values
(1, 'Alliance'),
(2, 'Horde');

insert into race (race_id, race_name, faction_id) values
(1, 'Human', 1),
(2, 'Dwarf', 1),
(3, 'Night Elf', 1),
(4, 'Gnome', 1),
(5, 'High Order Skyborne', 1),
(6, 'Orc', 2),
(7, 'Undead', 2),
(8, 'Tauren', 2),
(9, 'Troll', 2),
(10, 'Windshaper Skyborne', 2);

insert into class (class_id, class_name) values
(1, 'Warrior'),
(2, 'Hunter'),
(3, 'Mage'),
(4, 'Rogue'),
(5, 'Preist'),
(6, 'Warlock'),
(7, 'Paladin'),
(8, 'Druid'),
(9, 'Shaman');

insert into server (server_id, ruleset) values
(1, 'PvE'),
(2, 'PvP'),
(3, 'RP'),
(4, 'Hardcore');

-- Ki lagde randome navn for å spare tid
insert into player (player_id, username) values
(1,  'nordlys_gamer'),
(2,  'fjellgeit'),
(3,  'svensk_tank'),
(4,  'drachenblut'),
(5,  'vikinghealer'),
(6,  'pixelpanda'),
(7,  'lootgoblin'),
(8,  'raidleader_kim'),
(9,  'grindmaster'),
(10, 'frostbitt'),
(11, 'quietarcher'),
(12, 'chaosbolt');


-- Ki lagde randome navn, lvl og dato og id for å spare tid
-- Hvordan IDene i game_character kobles til andre tabeller:
--   player_id  > player(player_id)   hvilken spillerkonto karakteren tilhører
--   race_id    > race(race_id)       hvilken race karakteren er
--   class_id   > class(class_id)     hvilken class karakteren spiller
--   server_id  > server(server_id)   hvilken server karakteren er på
insert into game_character (
character_id, character_name, 
character_level, created_date, 
player_id, race_id, class_id, server_id) values
-- PvE (server 1)
(1,  'Thandrel',      60, '2026-11-04', 1,  1, 7, 1),
(2,  'Brimli',        52, '2026-11-04', 2,  2, 2, 1),
(3,  'Lunaria',       60, '2026-11-05', 3,  3, 8, 1),
(4,  'Fizzlebolt',    41, '2026-11-08', 4,  4, 3, 1),
(5,  'Grokmar',       60, '2026-11-04', 5,  6, 1, 1),
(6,  'Morthis',       38, '2026-11-12', 6,  7, 5, 1),
(7,  'Hoofrun',       55, '2026-11-06', 7,  8, 9, 1),
(8,  'Zuljaro',       29, '2026-11-20', 8,  9, 3, 1),
(9,  'Elaria',        47, '2026-11-15', 1,  1, 5, 1),
(10, 'Stonebeard',    60, '2026-11-04', 9,  2, 1, 1),
(11, 'Skywing',       33, '2026-11-25', 10, 5, 2, 1),
(12, 'Grimtusk',      44, '2026-11-10', 11, 6, 2, 1),
(13, 'Galeborn',      50, '2026-11-09', 12, 10, 8, 1),
-- PvP (server 2)
(14, 'Gorrash',       60, '2026-11-04', 2,  6, 4, 2),
(15, 'Vexira',        60, '2026-11-04', 3,  7, 6, 2),
(16, 'Kragg',         58, '2026-11-05', 4,  6, 1, 2),
(17, 'Shadowmend',    51, '2026-11-07', 5,  7, 5, 2),
(18, 'Tarjin',        60, '2026-11-04', 6,  9, 9, 2),
(19, 'Stormhorn',     46, '2026-11-11', 7,  8, 1, 2),
(20, 'Jintaro',       39, '2026-11-18', 8,  9, 2, 2),
(21, 'Nethra',        60, '2026-11-04', 12, 7, 3, 2),
(22, 'Brakka',        22, '2026-12-01', 9,  6, 6, 2),
(23, 'Thunderhoof',   57, '2026-11-06', 10, 8, 8, 2),
(24, 'Windcutter',    60, '2026-11-04', 11, 10, 4, 2),
(25, 'Aldric',        60, '2026-11-04', 11, 1, 1, 2),
(26, 'Pipwick',       35, '2026-11-22', 12, 4, 4, 2),
(27, 'Kaelen',        60, '2026-11-05', 1,  3, 4, 2),
(28, 'Ironfist',      44, '2026-11-14', 2,  2, 7, 2),
(29, 'Zanjira',       53, '2026-11-09', 3,  9, 4, 2),
(30, 'Grimfang',      60, '2026-11-04', 4,  6, 9, 2),
-- RP (server 3)
(31, 'Lady Elowen',   40, '2026-11-10', 5,  1, 3, 3),
(32, 'Moonwhisper',   36, '2026-11-13', 6,  3, 5, 3),
(33, 'Oakenshield',   28, '2026-11-19', 7,  2, 5, 3),
(34, 'Tinkerspark',   31, '2026-11-21', 8,  4, 6, 3),
(35, 'Earthmother',   45, '2026-11-08', 9,  8, 2, 3),
(36, 'Garashka',      50, '2026-11-06', 10, 6, 1, 3),
(37, 'Bonechill',     24, '2026-12-03', 11, 7, 4, 3),
(38, 'Mojara',        38, '2026-11-17', 12, 9, 5, 3),
(39, 'Featherlight',  42, '2026-11-16', 1,  5, 3, 3),
-- Hardcore (server 4)
(40, 'Riskit',        23, '2026-12-05', 1,  1, 1, 4),
(41, 'Nopetwice',     17, '2026-12-06', 3,  4, 3, 4),
(42, 'Slowandsteady', 42, '2026-12-05', 5,  2, 2, 4),
(43, 'Lastbreath',    31, '2026-12-07', 7,  7, 6, 4),
(44, 'Steelhide',     60, '2026-12-05', 9,  8, 1, 4),
(45, 'Wildroot',      38, '2026-12-08', 11, 3, 8, 4),
(46, 'Hexbane',       12, '2026-12-10', 12, 9, 9, 4),
(47, 'Carefulcat',    27, '2026-12-09', 6,  6, 2, 4);
