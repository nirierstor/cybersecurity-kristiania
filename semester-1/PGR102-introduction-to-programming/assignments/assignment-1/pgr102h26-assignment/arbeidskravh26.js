//Denne JS-koden er laget klar for deg. Den trenger du ikke endre på. :-)
//Stats for heroes: Du må ikke bruke alle stats videre i programmet ditt hvis du ikke ser det nødvendig.
//Husk at for å hente ut noe fra et objekt som er i et array kan vi skrive for eksempel slik: heroesArray[1].name (Ariana Archer)


let heroesArray = [
    {
        id: 0,
        name: "Henriette Healer",
        maxHP: 400,
        currentHP: 400,
        damage: 100,
        alive: true,
    },
    {
        id: 1,
        name: "Ariana archer",
        maxHP: 600,
        currentHP: 600,
        damage: 400,
        alive: true,
    },
    {
        id: 2,
        name: "Wyona Warrior",
        maxHP: 800,
        currentHP: 800,
        damage: 400,
        alive: true,
    },
];

let dragonStats = {
    name: "Daar Dragon",
    maxHP: 2000,
    currentHP: 2000,
    damage: 200,
    alive: true,
};

//Bildene som skal kunne trykkes på
const healer = document.getElementById("healer");
const archer = document.getElementById("archer");
const warrior = document.getElementById("warrior");

const dragon = document.getElementById("dragon");

//Navnene til heltene og dragen som kan oppdateres med riktig navn (tilleggsfunksjonalitet)
const healerName = document.getElementById("healer-name-txt");
const archerName = document.getElementById("archer-name-txt");
const warriorName = document.getElementById("warrior-name-txt");

const dragonName = document.getElementById("dragon-name-txt");

//HP-tekstene til heltene som skal kunne oppdatere seg (tilleggsfunksjonalitet)
const healerHealthTxt = document.getElementById("healer-health-txt");
const archerHealthTxt = document.getElementById("archer-health-txt");
const warriorHealthTxt = document.getElementById("warrior-health-txt");

//HP-teksten til dragen som kan oppdatere seg (tilleggsfunksjonalitet)
const dragonHealthTxt = document.getElementById("dragon-health-txt");

//Healthbars som må oppdateres for at grønnfargen skal bli mindre når HP blir mindre (tilleggsfunksjonalitet)
const healerHealthBar = document.getElementById("healer-health");
const archerHealthBar = document.getElementById("archer-health");
const warriorHealthBar = document.getElementById("warrior-health");

const dragonHealthBar = document.getElementById("dragon-health");

//Her kommer din kode! :o
//-----------------------------

// Oppgave 1

// Heltene angriper dragen
function attackDragon(heroIndex) {

    // Hent helten som angriper fra arrayet
    const hero = heroesArray[heroIndex];

    // Angrepet skjer bare hvis både helten og dragen lever
    if (hero.currentHP > 0 && dragonStats.currentHP > 0) {

        // Trekk heltens damage fra dragens liv
        //Math.max(0, .....) gjør at HP aldri blir lavere enn 0
        dragonStats.currentHP = Math.max(0, dragonStats.currentHP - hero.damage);

        // Oppdater dragens lifebar og HP tekst
        updateUI();
        updateHealthBar(dragonStats, dragonHealthBar);
        

        // Alert med navn og damage
        alert(`${hero.name} har gjort ${hero.damage} skade på ${dragonStats.name}!`);

        // Seier sjekkes før motangrepet, slik at en død drage ikke slår tilbake
        if (dragonStats.currentHP <= 0) {
          checkIfGameWon();
        } else { 
            dragonCounterAttack();
            checkIfGameLost();
        }

    }
}


// Pilfunksjonen gjør at attackDragon først kjører når det klikkes
// Tallet er heltens plass i heroesArray
healer.addEventListener("click", () => {
    attackDragon(0);
});

archer.addEventListener("click", () => {
    attackDragon(1);
});

warrior.addEventListener("click", () => {
    attackDragon(2);
});

//Oppgave 2

// Rekkefølgen må matche heroesArray (0, 1, 2), slik at id kan brukes som indeks
const heroElements = [healer, archer, warrior]

// Rekkefølgen må matche heroesArray her også
const heroHealthBars = [healerHealthBar, archerHealthBar, warriorHealthBar];

function dragonCounterAttack () {

    // filter() lager et nytt array med bare heltene som lever,
    // slik at dragen ikke kan angripe en som allerede er død
    const aliveHeroes = heroesArray.filter((hero) => {
        return hero.currentHP > 0;
    });

    //Her velger den en tilfeldig helt (0, 1 eller 2. Det blir da en 1/3 sjanse)
    const randomIndex = Math.floor(Math.random() * aliveHeroes.length)
    const targetHero = aliveHeroes[randomIndex]

    // Her gjør dragen damage mot heltene (HP blir ikke mindre enn 0)
    targetHero.currentHP = Math.max(0, targetHero.currentHP - dragonStats.damage);

    // Oppdater lifebar og HP tekst til helten som ble truffet
    // targetHero.id er heltens plass i heroesArray, ikke plassen i aliveHeroes
    updateUI();
    updateHealthBar(targetHero, heroHealthBars[targetHero.id]);
    

    // Her vises alerten til hvem dragen angrep
    alert(`${dragonStats.name} har angrepet ${targetHero.name} for ${dragonStats.damage}!`);

    // Hvis helten er død så oppdaterer alive til false og fjerner bildet fra siden
    if (targetHero.currentHP <= 0) {
        targetHero.alive = false;
        heroElements[targetHero.id].remove()
    }
}

//Oppgave 3

function checkIfGameLost() {

    //every() gir true bare hvis alle heltene har 0 HP
    const allHeroesDead = heroesArray.every((hero) => {
        return hero.currentHP <= 0;
    });

    // Alle heltene er døde og dragen lever fortsatt
    // Vent 100ms slik at nettleseren rekker å vise at heltene er borte før alerten vises
    // Uten ventetiden ville alerten kommet før den siste helten forsvant
    if (allHeroesDead && dragonStats.currentHP > 0) {
        setTimeout(() => {
        alert(`Spillet er tapt!  ${dragonStats.name}  har vunnet!`);
        }, 100);
    }
}

//Oppgave 4

function checkIfGameWon() {

    // some() gir true hvis minst en helt har mer enn 0 HP
    const someHeroAlive = heroesArray.some(hero => hero.currentHP > 0);

    // Dragen er død og minst en helt lever
    if (dragonStats.currentHP <= 0 && someHeroAlive) {
        dragonStats.alive = false;

        // Fjerne dragon fra siden
        const dragonElement = document.getElementById("dragon");
        dragonElement.remove()

        // Vent 100ms slik at nettleseren rekker å vise at dragen er borte før alerten vises
        setTimeout(() => {
            alert("Gratulerer, du har vunnet spillet!");
        }, 100);

    }
}

// Tilleggsfunksjonalitet 3

// Rekkefølgen må matche heroesArray (0, 1, 2)
const heroNameElements = [healerName, archerName, warriorName];
const heroHealthtTxtElements = [healerHealthTxt, archerHealthTxt, warriorHealthTxt];

function updateUI() {

    // forEach går gjennom alle heltene. index brukes til å finne riktig tekstelement
    heroesArray.forEach((hero, index) => {
        // textContent erstatter teksten inne i p taggen i html "arbeidskravh26.html"
        heroNameElements[index].textContent = hero.name;
        heroHealthtTxtElements[index].textContent = `${hero.currentHP} / ${hero.maxHP} HP`;
    });

    // Samme men for dragen
    dragonName.textContent = dragonStats.name;
    dragonHealthTxt.textContent = `${dragonStats.currentHP} / ${dragonStats.maxHP} HP`;
}

//Oppgave tillegg 4

function updateHealthBar(character, HealthBarElement) {

    // Regn ut hvor stor del av livet som er igjen
    const healthPercentage = character.currentHP / character.maxHP;

    // Full bar er 300px bred i CSS, så vi ganger andelen med 300
    let newWidth = healthPercentage * 300;

    // Ikke la bredden bli negativ når Hp går under 0
    if (newWidth < 0) {
        newWidth = 0;
    }

    // style.width overstyrer bredden fra CSS filen
    HealthBarElement.style.width = newWidth + "px";
}

// Vis riktige navn og HP med en gang siden lastes
updateUI();
