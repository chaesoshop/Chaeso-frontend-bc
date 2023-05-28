// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC20 {
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
    function balanceOf(address account) external view returns (uint256);
}

contract CHAESOMARKET {
    IERC20 public token;
    mapping(uint256 => address) public itemOwners;
    uint256 public ItemId;
    event ItemPurchased(address buyer, uint256 itemId, uint256 amount);
    event ItemSold(address seller, uint256 itemId, uint256 amount);
    
    constructor(address tokenAddress) {
        token = IERC20(tokenAddress);
        ItemId = 1;
    }
    
    function buyItem(uint256 amount) public {
        require(token.balanceOf(msg.sender) >= amount, "Insufficient balance");
        token.transferFrom(msg.sender, address(this), amount * 10 ** 18);
        itemOwners[ItemId] = msg.sender;
        emit ItemPurchased(msg.sender, ItemId, amount);
        ItemId++;
    }
    
    function sellItem(uint256 itemId, uint256 amount) public {
        require(token.balanceOf(msg.sender) >= amount, "Insufficient balance");
        token.transferFrom(address(this), msg.sender, amount * 10 ** 18);
        emit ItemSold(msg.sender, itemId, amount);
    }
    
    function getBalance(address account) public view returns (uint256) {
        return token.balanceOf(account);
    }
}