// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

library PriceConverter{
    // latest price is the rate with init
   function getLatestPrice() public view returns(uint256) {
      AggregatorV3Interface priceFeed = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
         ( ,int256 price,,,) = priceFeed.latestRoundData();
         return uint256(price * 1e10);
   }

//    rate with decimal 
// price of the final function
function getConversationRate(uint256 ethamount) public view returns(uint256){
    uint256 ethPrice = getLatestPrice();
    //  rate with decimal 
    uint256 ethamountInUsd = (ethamount * ethPrice) / 1e18;

    return  ethamountInUsd;
}

}
