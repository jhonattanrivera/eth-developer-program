// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;
// A Solidity contract for a Pokemon factory
contract PokemonFactory {
    // Enumeration of Pokemon types
    enum PokemonType {
        Grass,
        Poison,
        Fire,
        Flying,
        Ice,
        Psychic
    }

    // Struct defining a Pokemon
    struct Pokemon {
        uint id;
        string name;
        PokemonType[] types; // Challenge #4
        PokemonType[] weaknesses; // Challenge #4
        uint[] skills; // Challenge #3
    }

    // Struct defining a skill for a Pokemon
    struct Skill {
        string name;
        string description;
    }

    // Array containing all Pokemons
    Pokemon[] pokemons;

    // Mapping of skill ID to Skill object
    mapping(uint => Skill) public skillList;
    // Mapping of Pokemon ID to owner's address
    mapping(uint => address) pokemonOwners;
    // Mapping of owner's address to number of owned Pokemons
    mapping(address => uint) ownerCounter;

    // Challenge #1: an event that creates information about what just happened
    event NewPokemonCreated(address owner, uint id, string name);

    // Function to create a new Pokemon
    function createPokemon(
        uint _id,
        string memory _name,
        PokemonType[] memory _types,
        PokemonType[] memory _weaknesses,
        uint[] memory _skills
    ) public {
        // Challenge #2: validate that id must be higher than 0 and the name length must be longer than 2 characters
        require(_id > 0, "The id must be higher than 0");
        require(
            bytes(_name).length >= 2,
            "The Pokemon's name must be longer than 2 characters"
        );
        pokemons.push(Pokemon(_id, _name, _types, _weaknesses, _skills));
        pokemonOwners[_id] = msg.sender;
        ownerCounter[msg.sender]++;
        // Challenge #1
        emit NewPokemonCreated(msg.sender, _id, _name);
    }

    // Challenge #3: Function to create a new skill
    function createSkill(
        uint _id,
        string memory _name,
        string memory _description
    ) public {
        skillList[_id] = Skill(_name, _description);
    }

    // Function to add a skill to a Pokemon
    function addSkillToPokemon(uint _skillId, uint _pokemonId) public {
        pokemons[_pokemonId].skills.push(_skillId);
    }

    // Function to get all Pokemons
    function getAllPokemons() public view returns (Pokemon[] memory) {
        return pokemons;
    }

    // Function to get the owner of a specific Pokemon
    function getOwnerOf(uint _id) public view returns (address) {
        return pokemonOwners[_id];
    }

    // Function to get the number of owned Pokemons by an owner
    function getOwnedCounter(address _owner) public view returns (uint) {
        return ownerCounter[_owner];
    }
}