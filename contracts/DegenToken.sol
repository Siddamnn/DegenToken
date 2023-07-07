// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DegenToken is ERC20, Ownable {
    address payable private Owner;
    mapping(string => uint256) public store;
    mapping(address => string[]) public items;

    constructor() ERC20("Degen", "DGN") {
        Owner = payable(msg.sender);
    }

    //Function so that owner can add items in the store
    function addItems(string memory name, uint256 Price) public onlyOwner {
        store[name] = Price;
    }

    //Function to mint token
    //Added modifier so only owner can mint function
    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    //Function to burn token
    function burn(uint256 amount) external {
        _burn(msg.sender, amount);
    }

    //Function to transfer token
    function transfer(
        address toAddress,
        uint256 amount
    ) public override returns (bool) {
        _transfer(msg.sender, toAddress, amount);
    }

    //Function to redeem
    function redeem(string memory itemName) external {
        require(balanceOf(msg.sender) >= store[itemName], "Insufficient funds");
        _burn(msg.sender, store[itemName]);
        items[msg.sender].push(itemName);
    }
}
