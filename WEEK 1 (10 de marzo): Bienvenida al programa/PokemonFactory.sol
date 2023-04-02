// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {
    enum PokemonType {
        Grass,
        Poison,
        Fire,
        Flying,
        Ice,
        Psychic
    }

    struct Pokemon {
        uint id;
        string name;
        PokemonType[] types; // Challenge #4
        PokemonType[] weaknesses; // Challenge #4
        uint[] skills; // Challenge #3
    }

    struct Skill {
        string name;
        string description;
    }

    Pokemon[] pokemons;

    mapping(uint => Skill) public skillList;
    mapping(uint => address) pokemonOwners;
    mapping(address => uint) ownerCounter;

    // Challenge #1: an event that create information about what is just happened
    event NewPokemonCreated(address owner, uint id, string name);

    function createPokemon(
        uint _id,
        string memory _name,
        PokemonType[] memory _types,
        PokemonType[] memory _weaknesses,
        uint[] memory _skills
    ) public {
        // Challenge #2: validate that id must be higher than 0 and the name length must be longer than 2 characteres
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

    // Challenge #3
    function createSkill(
        uint _id,
        string memory _name,
        string memory _description
    ) public {
        skillList[_id] = Skill(_name, _description);
    }

    function addSkillToPokemon(uint _skillId, uint _pokemonId) public {
        pokemons[_pokemonId].skills.push(_skillId);
    }

    function getAllPokemons() public view returns (Pokemon[] memory) {
        return pokemons;
    }

    function getOwnerOf(uint _id) public view returns (address) {
        return pokemonOwners[_id];
    }

    function getOwnedCounter(address _owner) public view returns (uint) {
        return ownerCounter[_owner];
    }
}
