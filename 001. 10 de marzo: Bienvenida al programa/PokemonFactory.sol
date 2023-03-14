// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {

    struct Pokemon {
        uint id;
        string name;
    }
    Pokemon[] private pokemons;
    
    // Challenge #3
    struct PokemonSkill {
        string skillName;
        string skillDescription;
    }
    PokemonSkill[] private pokemonskills;

    mapping (uint => address) public pokemonToOwner;
    mapping (address => uint) ownerPokemonCount;
    mapping(uint => PokemonSkill) public pokemonSkillById;

    // Challenge #1: an event that create information about what is just happened
    event eventNewPokemon(
        address _createdBy,
        uint _id,
        string _name
    );

    function createPokemon(string memory _name, uint _id) public {
        // Challenge #2: validate that id must be higher than 0 and the name length must be longer than 2 characteres
        bytes memory nameReq = bytes(_name);
        require(
            _id > 0, "The id must be higher than 0"
        );
        require(
            nameReq.length > 2, "The Pokemon's name must be longer than 2 characters"
        );
        pokemons.push(Pokemon(_id, _name));
        pokemonToOwner[_id] = msg.sender;
        ownerPokemonCount[msg.sender]++;
        // Challenge #1
        emit eventNewPokemon(msg.sender,_id,_name);
    }

    // Challenge #3
    function createPokemonSkill(string memory _skillName, string memory _skillDescription, uint _id) public {
        PokemonSkill memory newPokemonSkill = PokemonSkill(_skillName, _skillDescription);
        pokemonskills.push(newPokemonSkill);
        pokemonSkillById[_id] = newPokemonSkill;
    }

    function getAllPokemons() public view returns (Pokemon[] memory) {
        return pokemons;
    }

    function getResult() public pure returns(uint product, uint sum){
        uint a = 1; 
        uint b = 2;
        product = a * b;
        sum = a + b; 
   }
}