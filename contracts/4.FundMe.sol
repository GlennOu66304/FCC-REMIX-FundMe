// SPDX-License-Identifier: GPL-3.0
// Goal
// 1.deposit the toen into the contract
// 1.1 ge the conversation rate from the chain link feeds
// 1.2 by using this function get the token back
// 2.withdraw the token from the contract
pragma solidity >=0.7.0 <0.9.0;
import "./5.PriceConverter.sol";
  /**
     * Network: Goerli
     * Aggregator: ETH/USD
     * Address: 0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e
     */

     error NotOwner();
contract FundMe {
    using PriceConverter for uint256;
    uint256  constant MINIMUM_USD = 50*1e18;
    address[] public funders;
    mapping(address=>uint256) public addressToAmountFunded;

    address public  immutable i_onlyOwner;
// beofre immutable 23600
// immutable 	21464 gas 
    constructor(){   
        i_onlyOwner = msg.sender;
    }
        
    

    function fund() public payable{
    // no constant 674892
    // constant 653869
        require(msg.value.getConversationRate() >= MINIMUM_USD, "You need to spend more ETH!");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender]=msg.value;

    }

// reset the fund amount to 0
  function withdraw() public  i_Owner{
     
//  no immutable 653869
// 
      for(uint256 funderIndex=0; funderIndex < funders.length;funderIndex++){
         address funder = funders[funderIndex];
          addressToAmountFunded[funder]=  0;
      }
// reset the address array to empty element array
      funders = new address[](0);

    //   send the ethrenum
    (bool callSuccess,) = payable(msg.sender).call{value:address(this).balance}("");
    require(callSuccess,"call Failed");
  }

modifier  i_Owner(){
// require(msg.sender == i_onlyOwner,"you need to be the project owner!");
if(msg.sender!=i_onlyOwner) revert NotOwner();
_;
}

// receive

receive() external payable{
fund();
}
  
// fallback
fallback() external payable{
  fund();
}
}