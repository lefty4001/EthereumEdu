pragma solidity ^0.4.16;

contract Simple {
    function arithmetics(uint _a, uint _b)
        public
        pure
        returns (uint o_sum, uint o_product)
    {
        o_sum = _a + _b;
        o_product = _a * _b;
    }
}



pragma solidity ^0.4.16;

contract C {
    function g(uint a) public pure returns (uint ret) { return f(); }
    function f() internal pure returns (uint ret) { return g(7) + f(); }
}


pragma solidity ^0.4.0;

contract InfoFeed {
    function info() public payable returns (uint ret) { return 42; }
}

contract Consumer {
    InfoFeed feed;
    function setFeed(address addr) public { feed = InfoFeed(addr); }
    function callFeed() public { feed.info.value(10).gas(800)(); }
}


pragma solidity >0.4.23 <0.5.0;

contract C {
    uint[] data;

    function f() public pure returns (uint, bool, uint) {
        return (7, true, 2);
    }

    function g() public {
        // Variables declared with type and assigned from the returned tuple.
        (uint x, bool b, uint y) = f();
        // Common trick to swap values -- does not work for non-value storage types.
        (x, y) = (y, x);
        // Components can be left out (also for variable declarations).
        (data.length,,) = f(); // Sets the length to 7
        // Components can only be left out at the left-hand-side of assignments, with
        // one exception:
        (x,) = (1,);
        // (1,) is the only way to specify a 1-component tuple, because (1) is
        // equivalent to 1.
    }
}


pragma solidity ^0.4.22;

contract VendingMachine {
    function buy(uint amount) payable {
        if (amount > msg.value / 2 ether)
            revert("Not enough Ether provided.");
        // Alternative way to do it:
        require(
            amount <= msg.value / 2 ether,
            "Not enough Ether provided."
        );
        // Perform the purchase.
    }
}
