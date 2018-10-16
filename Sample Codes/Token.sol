pragma solidity ^0.4.22;

contract OwnedToken {
    TokenCreator creator;
    address owner;
    bytes32 name;

    constructor(bytes32 _name) public {
        owner = msg.sender;
        creator = TokenCreator(msg.sender);
        name = _name;
    }
    function changeName(bytes32 newName) public {
        if (msg.sender == address(creator))
            name = newName;
    }
    function transfer(address newOwner) public {
        if (msg.sender != owner) return;
        if (creator.isTokenTransferOK(owner, newOwner))
            owner = newOwner;
    }
}

contract TokenCreator {
    function createToken(bytes32 name)
       public
       returns (OwnedToken tokenAddress)
    {
        return new OwnedToken(name);
    }
    function changeName(OwnedToken tokenAddress, bytes32 name)  public {
        tokenAddress.changeName(name);
    }
    function isTokenTransferOK(address currentOwner, address newOwner)
        public
        view
        returns (bool ok)
    {
        address tokenAddress = msg.sender;
        return (keccak256(newOwner) & 0xff) == (bytes20(tokenAddress) & 0xff);
    }
}
