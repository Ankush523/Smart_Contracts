//SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;
import "./PriceConvertor.sol";
contract FundMe
{   
    using PriceConverter for uint256;
    uint256 public minimumUsd = 50 * 1e18;
    // want to be able to set a minimum fund amount

    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;
    function fund() public payable {

        //how do we send eth to this contract
        require(msg.value.getConversionRate() > minimumUsd, "Didn't send enough!");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = msg.value;
    }


    function withdraw() public {
        for(uint256 funderIndex = 0; funderIndex < funders.length ; funderIndex++)
        {
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        funders = address[](0);

        //withdraw the funds in 3 different ways
        //1)transfer

        // payable(msg.sender.transfer(address(this).balance));


        // //2)send

        // bool success = payable(msg.sender.send(address(this).balance));
        // require(success,"Send failed"); 


        //3)call

        (bool callSuccess, ) = payable(msg.sender).call{value : address(this).balance}("");
        require(callSuccess, "Call failed"); 


    }
}