DROP DATABASE IF EXISTS deep;
CREATE DATABASE deep;
USE deep;

CREATE TABLE Moves(
movename varchar(50) PRIMARY KEY,
powerr int,
typee varchar(50),
category varchar(50)
);

INSERT INTO Moves (movename, powerr, typee,category) VALUES
('body slam',85,'normal','physical'),
('tri attack',80,'normal','special'),
('fire punch',75,'fire','physical'),
('lava plume',80,'fire','special'),
('waterfall',80,'water','physical'),
('surf',90,'water','special'),
('thunder punch',75,'electric','physical'),
('thunderbolt',90,'electric','special'),
('seed bomb',80,'grass','physical'),
('energy ball',90,'grass','special'),
('ice punch',75,'ice','physical'),
('ice beam',90,'ice','special'),
('brick break',75,'fighting','physical'),
('aura sphere',80,'fighting','special'),
('dire claw',80,'poison','physical'),
('sludge bomb',90,'poison','special'),
('stomping tantrum',75,'ground','physical'),
('earth power',90,'ground','special'),
('dual wingbeat',80,'flying','physical'),
('air slash',75,'flying','special'),
('zen headbutt',85,'psychic','physical'),
('extrasensory',80,'psychic','special'),
('lunge',80,'bug','physical'),
('bug buzz',90,'bug','special'),
('rock slide',75,'rock','physical'),
('ancient power',60,'rock','special'),
('shadow claw',70,'ghost','physical'),
('shadow ball',80,'ghost','special'),
('dragon claw',80,'dragon','physical'),
('draco meteor',130,'dragon','special'),
('crunch',80,'dark','physical'),
('dark pulse',80,'dark','special'),
('iron head',80,'steel','physical'),
('flash cannon',80,'steel','special'),
('play rough',90,'fairy','physical'),
('moonblast',95,'fairy','special')
;

CREATE TABLE Pokemonlist(
namee varchar(50) PRIMARY KEY,
firsttype varchar(50),
secondtype varchar(50),
HP int,         -- HP will be real HP multiplied by 2
atk int,
def int,
spatk int,
spdef int,
speed int
);

INSERT INTO Pokemonlist(namee,firsttype,secondtype,HP,atk,def,spatk,spdef,speed) VALUES
('pikachu','electric','nonee',70,55,40,50,50,100),
('charizard','fire','flying',156,84,78,109,85,99),
('venusaur','grass','poison',160,82,83,100,100,98),
('blastoise','water','nonee',158,83,100,85,105,97),
('greninja','water','dark',144,95,67,103,71,96),
('togekiss','fairy','flying',170,50,95,120,115,95),
('eevee','normal','nonee',110,55,50,45,65,94),
('lugia','psychic','flying',212,90,130,90,154,93),
('regidrago','dragon','nonee',400,100,50,100,50,92),
('rayquaza','dragon','flying',210,150,90,150,90,91),
('arceus','psychic','nonee',120,120,120,120,120,90),
('excadrill','ground','steel',340,90,45,90,45,89),
('butterfree','bug','flying',120,45,50,90,80,88),
('dodrio','normal','flying',120,110,70,60,60,87),
('jynx','ice','psychic',130,50,35,115,95,86),
('arcanine','fire','nonee',180,110,80,100,80,85),
('electabuzz','electric','nonee',130,83,57,95,85,84)
;


/*
firstmove varchar(50) DEFAULT 'nonee',
FOREIGN KEY (firstmove) REFERENCES Moves(movename),
secondmove varchar(50) DEFAULT 'nonee,
FOREIGN KEY (secondmove) REFERENCES Moves(movename),
thirdmove varchar(50) DEFAULT 'nonee',
FOREIGN KEY (secondmove) REFERENCES Moves(movename),
fourthmove varchar(50) DEFAULT 'nonee',
FOREIGN KEY (secondmove) REFERENCES Moves(movename)
);*/

 SELECT COUNT(*) FROM Pokemonlist;

CREATE TABLE typemultiplier(
attackingtype varchar(50) PRIMARY KEY,
normal float,
fire float,
water float,
electric float,
grass float,
ice float,
fighting float,
poison float,
ground float,
flying float,
psychic float,
bug float,
rock float,
ghost float,
dragon float,
dark float,
steel float,
fairy float,
nonee float
);

INSERT INTO typemultiplier (attackingtype, normal, fire, water, electric, grass, ice, fighting, poison, ground, flying, psychic, bug, rock, ghost, dragon, dark, steel, fairy, nonee) VALUES
('normal',1,1,1,1,1,1,1,1,1,1,1,1,1,0,1,1,0.5,1,1),
('fire',1,0.5,0.5,1,2,2,1,1,1,1,1,2,0.5,1,0.5,1,2,1,1),
('water',1,2,0.5,1,0.5,0.5,1,1,1,1,1,1,2,1,0.5,1,1,1,1),
('electric',1,1,2,0.5,0.5,1,1,1,0,2,1,1,1,1,0.5,1,1,1,1),
('grass',1,0.5,2,1,0.5,1,1,0.5,2,0.5,1,0.5,2,1,0.5,1,0.5,1,1),
('ice',1,0.5,0.5,1,2,0.5,1,1,2,2,1,1,1,1,2,1,0.5,1,1),
('fighting',2,1,1,1,1,2,1,0.5,1,0.5,0.5,0.5,1,0,1,2,2,0.5,1),
('poison',1,1,1,1,2,1,1,0.5,0.5,1,1,1,0.5,0.5,1,1,0,2,1),
('ground',1,2,1,2,0.5,1,1,2,1,0,1,0.5,2,1,1,1,2,1,1),
('flying',1,1,1,0.5,2,1,2,1,1,1,1,2,0.5,1,1,1,0.5,1,1),
('psychic',1,1,1,1,1,1,2,2,1,1,0.5,1,1,1,1,0,0.5,1,1),
('bug',1,0.5,1,1,2,1,0.5,0.5,1,0.5,2,1,1,0.5,1,2,0.5,1,1),
('rock',1,2,1,1,1,2,0.5,1,0.5,2,1,2,1,1,1,1,0.5,1,1),
('ghost',0,1,1,1,1,1,1,1,1,1,2,1,1,2,1,0.5,1,1,1),
('dragon',1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,1,0.5,0,1),
('dark',1,1,1,1,1,1,0.5,1,1,1,2,1,1,2,1,0.5,1,0.5,1),
('steel',1,0.5,0.5,0.5,1,2,1,1,1,1,1,1,2,1,1,1,0.5,2,1),
('fairy',1,0.5,1,1,1,1,2,0.5,1,1,1,1,1,1,2,2,0.5,1,1)
;

-- select * from typemultiplier;

CREATE TABLE teammembers(
teamname varchar(50),
teammate varchar(50),     -- when accessing the teammember, check that teamname and teammate are both the parameters you search for

move1 varchar(50),
move2 varchar(50),
move3 varchar(50),
move4 varchar(50),

FOREIGN KEY (teammate) REFERENCES Pokemonlist(namee),

FOREIGN KEY (move1) REFERENCES Moves(movename),
FOREIGN KEY (move2) REFERENCES Moves(movename),
FOREIGN KEY (move3) REFERENCES Moves(movename),
FOREIGN KEY (move4) REFERENCES Moves(movename)
);
-- SELECT * from teammembers;

SELECT * from teammembers
LEFT JOIN Pokemonlist
ON teammembers.teammate=Pokemonlist.namee;


DELIMITER $$

CREATE TRIGGER before_insert_check_existence
BEFORE INSERT ON teams
FOR EACH ROW
BEGIN
    -- Check if name is right
    IF NEW.teammate NOT IN (Pokemonlist.namee) THEN
        -- Set quantity to the limit of 1000
        SELECT 'invalid name';
    END IF;
END $$

DELIMITER ;


INSERT INTO teammembers(teamname,teammate,move1,move2,move3,move4) VALUES 
('trying','pikachu','thunderbolt','surf','body slam','flash cannon'),
('trying','blastoise','surf','ice beam','flash cannon','aura sphere'),
('trying','rayquaza','rock slide','dual wingbeat','air slash','ancient power'),
('trying','lugia','lunge','shadow ball','ice beam','seed bomb'),
('trying','eevee','body slam','ice beam','thunderbolt','draco meteor'),
('trying','togekiss','moonblast','air slash','body slam','crunch');

INSERT INTO teammembers(teamname,teammate,move1,move2,move3,move4) VALUES
('testing','charizard','fire punch','thunder punch','air slash','ancient power'),
('testing','regidrago','earth power','energy ball','bug buzz','shadow claw'),
('testing','excadrill','iron head','sludge bomb','brick break','lava plume'),
('testing','arceus','fire punch','thunder punch','ice punch','stomping tantrum'),
('testing','greninja','dire claw','rock slide','waterfall','dragon claw'),
('testing','venusaur','energy ball','sludge bomb','thunder punch','ice beam');

INSERT INTO teammembers(teamname,teammate,move1,move2,move3,move4) VALUES
('three','charizard','air slash','lava plume','ancient power','thunderbolt'),
('three','pikachu','thunderbolt','thunder punch','rock slide','energy ball'),
('three','venusaur','energy ball','sludge bomb','air slash','draco meteor'),
('self','butterfree','ancient power','lunge','dual wingbeat','brick break'),
('self','blastoise','lunge','thunder punch','crunch','flash cannon'),
('self','eevee','body slam','iron head','thunder punch','moonblast');



CREATE TABLE teams(
teamname varchar(50) PRIMARY KEY,
teammate1 varchar(50),
teammate2 varchar(50),
teammate3 varchar(50),
teammate4 varchar(50),
teammate5 varchar(50),
teammate6 varchar(50),

FOREIGN KEY (teammate1) REFERENCES teammembers(teammate),
FOREIGN KEY (teammate2) REFERENCES teammembers(teammate),
FOREIGN KEY (teammate3) REFERENCES teammembers(teammate),
FOREIGN KEY (teammate4) REFERENCES teammembers(teammate),
FOREIGN KEY (teammate5) REFERENCES teammembers(teammate),
FOREIGN KEY (teammate6) REFERENCES teammembers(teammate)
);

INSERT INTO teams(teamname,teammate1,teammate2,teammate3,teammate4,teammate5,teammate6) VALUES
('trying','pikachu','blastoise','rayquaza','lugia','eevee','togekiss');

INSERT INTO teams(teamname,teammate1,teammate2,teammate3,teammate4,teammate5,teammate6) VALUES
('testing','charizard','regidrago','excadrill','arceus','greninja','venusaur');

INSERT INTO teams(teamname,teammate1,teammate2,teammate3) VALUES
('three','charizard','pikachu','venusaur');

INSERT INTO teams(teamname,teammate1,teammate2,teammate3) VALUES
('self','butterfree','blastoise','eevee');

-- select * from teams;
-- test data, some preloaded teams


CREATE TABLE currentteam1(
pokemon varchar(50),
move1 varchar(50),
move2 varchar(50),
move3 varchar(50),
move4 varchar(50),
health int,

FOREIGN KEY (move1) REFERENCES Moves(movename),
FOREIGN KEY (move2) REFERENCES Moves(movename),
FOREIGN KEY (move3) REFERENCES Moves(movename), 
FOREIGN KEY (move4) REFERENCES Moves(movename),

FOREIGN KEY (pokemon) REFERENCES Pokemonlist(namee)
);



CREATE TABLE currentteam2(
pokemon varchar(50),
move1 varchar(50),
move2 varchar(50),
move3 varchar(50),
move4 varchar(50),
health int,

FOREIGN KEY (move1) REFERENCES Moves(movename),
FOREIGN KEY (move2) REFERENCES Moves(movename),
FOREIGN KEY (move3) REFERENCES Moves(movename), 
FOREIGN KEY (move4) REFERENCES Moves(movename),

FOREIGN KEY (pokemon) REFERENCES Pokemonlist(namee)
);


INSERT INTO currentteam1(pokemon,move1,move2,move3,move4)
SELECT teammate,move1,move2,move3,move4 from teammembers WHERE teamname = 'trying';

INSERT INTO currentteam2(pokemon,move1,move2,move3,move4)
SELECT teammate,move1,move2,move3,move4 from teammembers WHERE teamname = 'testing';

SET SQL_SAFE_UPDATES = 0;

UPDATE currentteam1
SET health=(SELECT HP from Pokemonlist WHERE currentteam1.pokemon=Pokemonlist.namee);

UPDATE currentteam2
SET health=(SELECT HP from Pokemonlist WHERE currentteam2.pokemon=Pokemonlist.namee);

SELECT * FROM currentteam1;