// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract EtherWallet{

    mapping(address => uint256) accountToAmount;

    
    function deposit() public payable {
        require(msg.sender != address(0));
        require(msg.value != 0);

        accountToAmount[msg.sender] += msg.value;
    }


    function withdraw() public {
        uint256 amount  = accountToAmount[msg.sender];
        accountToAmount[msg.sender] = 0;
        (bool sent,) = payable(msg.sender).call{value: amount }("");
        if(!sent){
            accountToAmount[msg.sender] = amount;
        }

    }

    function getBalance() public view returns(uint256){
        return accountToAmount[msg.sender];
    }
}