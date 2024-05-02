// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import { Script, console2 } from "forge-std/Script.sol";
import { Collections } from "src/Collections.sol";

contract Deployer is Script {
    function run() public {
        vm.startBroadcast();
        deploy();
        vm.stopBroadcast();
    }

    function deploy() public returns (Collections) {
        Collections counter = new Collections();
        return counter;
    }
}
