# Solidity Functions and Error

This project demonstrates the use of functions and error handling functions such as require(), revert(), and assert(). This is a simple program which can help beginners in Solidity to have a grasp of how it works.

## Description

The project allows the user to buy item, check item count, and allows owners to add item price and item count, and withdraw the accumulated sales. There will be actions that can only be accessed and done by the owner, and an error will occur if an unauthorized action is done. 

## Getting Started

### Executing program

To run this program, you can use Remix, an online Solidity IDE. To get started, go to the Remix website at https://remix.ethereum.org/.

Once you are on the Remix website, create a new file by clicking on the "+" icon in the left-hand sidebar. Save the file with a .sol extension (e.g., balanceContract.sol). Copy and paste the following code into the file:
```
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


```
To compile the code, click on the "Solidity Compiler" tab in the left-hand sidebar. Make sure the "Compiler" option is set to "0.8.0" (or another compatible version), and then click on the "Compile itemSales.sol" button.

Once the code is compiled, you can deploy the contract by clicking on the "Deploy & Run Transactions" tab in the left-hand sidebar. Select the "balanceContract" contract from the dropdown menu, and then click on the "Deploy" button.

Once the contract is deployed, you can interact with it by calling the functions "buyItem", "restock", "withdraw", "checkOwner", "customRevert", "itemCount", "itemPrice", and "owner". 

## Authors

Kristine Garcia

## License

This project is licensed under the MIT License - see the LICENSE.md file for details
