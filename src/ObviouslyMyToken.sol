//SPDX-License-Identifier:MIT

pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract ObviouslyMyToken is ERC20{
    constructor(uint256 initialSupply) ERC20("ObviouslyMyToken", "OMT"){
        _mint(msg.sender, initialSupply);
    }
}