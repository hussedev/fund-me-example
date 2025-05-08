// SPDX-License-Identifier: MIT

pragma solidity 0.8.18;

import {PriceConverter} from "./PriceConverter.sol";

address constant mainnetPriceFeed = 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419;
address constant sepoliaPriceFeed = 0x694AA1769357215DE4FAC081bf1f309aDC325306;
address constant zksyncPriceFeed = 0x6D41d1dc818112880b40e26BD6FD347E41008eDA;
address constant zksyncSepoliaPriceFeed = 0xfEefF7c3fB57d18C5C6Cdd71e45D2D0b4F9377bF;

contract FundMe {
    using PriceConverter for uint256; // Adds the library functions to uint256 values.

    uint256 public minimumUsd = 5e18;

    address[] public funders;
    mapping(address funder => uint256 amountFunded) public addressToAmountFunded;

    function fund() public payable {
        msg.value.getConversionRate();
        require(msg.value.getConversionRate() >= minimumUsd, "didn't send enough eth"); // 1e18 = 1 ETH
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = addressToAmountFunded[msg.sender] + msg.value;
    }

    // function withdraw() public {}
}
