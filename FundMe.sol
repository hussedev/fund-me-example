// SPDX-License-Identifier: MIT

pragma solidity 0.8.18;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

address constant mainnetPriceFeed = 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419;
address constant sepoliaPriceFeed = 0x694AA1769357215DE4FAC081bf1f309aDC325306;
address constant zksyncPriceFeed = 0x6D41d1dc818112880b40e26BD6FD347E41008eDA;
address constant zksyncSepoliaPriceFeed = 0xfEefF7c3fB57d18C5C6Cdd71e45D2D0b4F9377bF;

contract FundMe {
    address priceFeedAddress = sepoliaPriceFeed;

    address[] public funders;
    mapping(address funder => uint256 amountFunded) public addressToAmountFunded;

    uint256 public minimumUsd = 5e18;

    function fund() public payable {
        require(getConversionRate(msg.value) >= minimumUsd, "didn't send enough eth"); // 1e18 = 1 ETH
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = addressToAmountFunded[msg.sender] + msg.value;
    }

    // function withdraw() public {}

    function getPrice() public view returns (uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(priceFeedAddress);
        (,int256 price,,,) = priceFeed.latestRoundData();

        // Price is with 8 decimals and int256
        // We want it in uint256 and 18 decimals
        return uint256(price * 1e10);
    }

    function getConversionRate(uint256 ethAmount) public view returns (uint256) {
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18;
        return ethAmountInUsd;
    }
}
