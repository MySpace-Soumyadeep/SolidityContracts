// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Ownable{
    address owner;

constructor() {
    owner = msg.sender;
}

modifier onlyOwner() {
    require(msg.sender == owner, "Must be owner");
    _;
}
}

contract SecretVault{
    string secret;

    constructor(string memory _secret){
        secret = _secret;
    }

    function getSecret() public view returns(string memory){
        return secret;
    }
}

//MyContract will serve as proxy for  SecretVault
//this is called the factory pattern wher a contract will create another smart contract

contract MyContract is Ownable{
    address secretVault;

    constructor(string memory _secret){
        SecretVault _secretVault = new SecretVault(_secret);
        secretVault = address(_secretVault);
        super;
    }

    function getSecret() public view onlyOwner returns(string memory){
        SecretVault _secretVault = SecretVault(secretVault);
        return _secretVault.getSecret();
    }
}