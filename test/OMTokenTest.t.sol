//SPDX-License-Identifier:MIT

pragma solidity ^0.8.19;

import {Test} from "../lib/forge-std/src/Test.sol";
import {DeployOMToken} from "../script/DeployOMToken.s.sol";
import {ObviouslyMyToken} from "../src/ObviouslyMyToken.sol";

interface MintableToken {
    function mint(address, uint256) external;
}

contract OMTokenTest is Test {
    ObviouslyMyToken public omt;
    DeployOMToken public deployer;

    address irfan = makeAddr("irfan");
    address faraaz = makeAddr("faraaz");

    uint256 public constant STARTING_BALANCE = 100 ether;

    function setUp() public {
        deployer = new DeployOMToken();
        omt = deployer.run();

        vm.prank(msg.sender);
        omt.transfer(irfan, STARTING_BALANCE);
    }

    function testIrfanBalance() public view {
        assertEq(STARTING_BALANCE, omt.balanceOf(irfan));
    }

    function testAllowances() public {
        uint256 initialAllowance = 100;

        // irfan approves faraaz to spend tokens on his behalf
        vm.prank(irfan);
        omt.approve(faraaz, initialAllowance);

        uint256 transferAmount = 50;
        vm.prank(faraaz);
        omt.transferFrom(irfan, faraaz, transferAmount);
        assertEq(transferAmount, transferAmount);
        assertEq(omt.balanceOf(irfan), STARTING_BALANCE - transferAmount);
    }

    function testInitialSupply() public view {
        assertEq(omt.totalSupply(), deployer.INITIAL_SUPPLY());
    }

    function testUsersCantMint() public {
        vm.expectRevert();
        MintableToken(address(omt)).mint(address(this), 1);
    }
}
