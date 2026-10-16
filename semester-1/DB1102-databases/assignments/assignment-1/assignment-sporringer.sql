use wow_forever;

-- SPØRRING 1 viser hvor mange karakterer det er på de forskjellige serverene

select s.ruleset,
count(*) as antall_karakterer
from game_character c
join server s on c.server_id = s.server_id 
group by s.ruleset
order by antall_karakterer desc;

-- SPØRRING 2 kobler brukernavn og antall karakterer men viser bare de som har 4 eller flere karakterer

select p.username,
count(*) as antall_karakterer
from player p
join game_character c on p.player_id = c.player_id
group by p.username
having count(*) >= 4
order by antall_karakterer desc;

-- SPØRRING 3 viser når første og siste karakter ble laget på hver server

select s.ruleset,
min(c.created_date) as første_karakter,
max(c.created_date) as siste_karakter
from game_character c
join server s on c.server_id = s.server_id
group by s.ruleset
order by første_karakter;   

-- SPØRRING 4 ??

select cl.class_name,
round(avg(c.character_level), 1) as snitt_level
from game_character c
join class cl on c.class_id = cl.class_id
group by cl.class_name
order by snitt_level desc;
