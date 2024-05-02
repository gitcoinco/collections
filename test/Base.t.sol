// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import { Test, console } from "forge-std/Test.sol";
import { Collections } from "src/Collections.sol";
import { Deployer } from "script/Deployer.s.sol";

contract CollectionsTest is Test {
    Collections public collections;
    Deployer public deployer;

    function setUp() public {
        deployer = new Deployer();
        collections = deployer.deploy();
    }

    // function test_Increment() public {
    //     collections.increment();
    //     assertEq(collections.number(), 1);
    // }

    // function testFuzz_SetNumber(uint256 x) public {
    //     collections.setNumber(x);
    //     assertEq(collections.number(), x);
    // }
}
