pragma solidity ^0.4.22;

contract Purchase {
    address public seller;
    enum State { Created, Locked, Inactive } // Enum

    modifier onlySeller() { // Modifier
        require(
            msg.sender == seller,
            "Only seller can call this."
        );
        _;
    }

    function abort() public onlySeller { // Modifier usage
        // ...
    }
}
