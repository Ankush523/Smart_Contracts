//SPDX-License-Identifier:MIT

pragma solidity ^0.8.0;

contract todo{
    uint todoid;
    struct Todo{
        uint todoid;
        string work;
        bool done;
    }

    mapping(address => mapping(uint => Todo))todos;

    function add(string memory _todo) external {
        ++todoid;
        todos[msg.sender][todoid]=Todo(todoid,_todo,false);
    }

    function change(uint _todoid)external{
        require(todos[msg.sender][_todoid].done == false);
        todos[msg.sender][_todoid].done = true;
    }

     function receivemsg(uint _todoid) public view returns (Todo memory){
         return todos[msg.sender][_todoid];
     } 

    function receiveid() external view returns (uint){
        return todoid;
    }

}