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
