// SPDX-License-Identifier: MIT

pragma solidity 0.8.18;

contract FundMe {
    function fund() public payable {
        // require(msg.value > 1e18); // 1e18 = 1 ETH
        require(msg.value > 1e18, "didn't send enough eth"); // 1e18 = 1 ETH

    }

    // function withdraw() public {}
}