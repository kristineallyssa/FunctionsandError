# Solidity Functions and Error

This project demonstrates the use of functions and error handling functions such as require(), revert(), and assert(). This is a simple program which can help beginners in Solidity to have a grasp of how it works.

## Description

The project allows the user to deposit, withdraw, and check current balance on their account. A user can set a maximum balance, and the user can only deposit and withdraw less than the maximum balance. 

## Getting Started

### Executing program

To run this program, you can use Remix, an online Solidity IDE. To get started, go to the Remix website at https://remix.ethereum.org/.

Once you are on the Remix website, create a new file by clicking on the "+" icon in the left-hand sidebar. Save the file with a .sol extension (e.g., balanceContract.sol). Copy and paste the following code into the file:
```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

contract ErrorHandlingContract {
    uint256 public maxBalance = 1000;
    uint256 public newBalance = 0;

    //validates the input amount
    function withdraw(uint256 amount) public {
        require(amount <= maxBalance, "Insufficient balance");
        newBalance -= amount;
    }

    //maxBalance should not change
    function maintainBalance() view public {
       assert(maxBalance==1000);
    }

    //deposit amount
    function deposit(uint amount) public {
        //newBalance should always be less than or equal to maxBalance
        if(newBalance >= maxBalance){
            revert("Cannot deposit. Balance has reached its max.");
        }else if(amount>0 && amount<=maxBalance){
            newBalance += amount;
        }
    }
}

```
To compile the code, click on the "Solidity Compiler" tab in the left-hand sidebar. Make sure the "Compiler" option is set to "0.8.23" (or another compatible version), and then click on the "Compile balanceContract.sol" button.

Once the code is compiled, you can deploy the contract by clicking on the "Deploy & Run Transactions" tab in the left-hand sidebar. Select the "balanceContract" contract from the dropdown menu, and then click on the "Deploy" button.

Once the contract is deployed, you can interact with it by calling the functions "deposit", "withdraw", "maxBalance", "maintainBalance", and "newBalance". 

## Authors

Kristine Garcia

## License

This project is licensed under the MIT License - see the LICENSE.md file for details
