//SPDX-License-Identifier:MIT

pragma solidity ^0.8.19;

import {Script} from "../lib/forge-std/src/Script.sol";
import {ObviouslyMyToken} from "../src/ObviouslyMyToken.sol";

contract DeployOMToken is Script {
    uint256 public constant INITIAL_SUPPLY = 1000 ether;

    function run() external returns (ObviouslyMyToken) {
        vm.startBroadcast();
        ObviouslyMyToken omt = new ObviouslyMyToken(INITIAL_SUPPLY);
        vm.stopBroadcast();
        return omt;
    }
}
