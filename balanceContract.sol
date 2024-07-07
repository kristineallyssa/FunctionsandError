// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract itemSales {
    address public owner;
    uint public itemPrice;
    uint public itemCount;

    constructor(uint _itemPrice, uint _itemCount) {
        owner = msg.sender;
        itemPrice = _itemPrice;
        itemCount = _itemCount;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can perform this action.");
        _;
    }

    function buyItem() external payable {
        require(msg.value >= itemPrice, "Not enough Ether sent.");
        require(itemCount > 0, "No items available.");

        // Decrease item count
        itemCount--;

        // If more Ether is sent than required, send back the excess
        if (msg.value > itemPrice) {
            uint refund = msg.value - itemPrice;
            (bool sent, ) = msg.sender.call{value: refund}("");
            require(sent, "Failed to send refund.");
        }
    }

    function restock(uint _count) external onlyOwner {
        require(_count > 0, "Restock count must be greater than zero.");
        itemCount += _count;
    }

    function withdraw() external onlyOwner {
        uint balance = address(this).balance;
        require(balance > 0, "No Ether to withdraw.");

        (bool sent, ) = owner.call{value: balance}("");
        require(sent, "Failed to withdraw Ether.");
    }

    // Example of using assert 
    function checkOwner() external view {
        assert(msg.sender == owner);
    }

    // Example of using revert
    function customRevert() external view {
        if (msg.sender != owner) {
            revert("You are not the owner!");
        }
    }
}
