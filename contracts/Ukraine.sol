//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";

/*
struct Auction { 
   address seller;
   string item;
   uint endTime;
   address highestBider;
   uint256 highestBid;
}
*/

struct Sale { 
   address seller;
   address beneficiary;
   string item;
   uint256 price;
   bool sold;
}

contract Ukraine {
    address owner;
    //uint256 auctionsIndex;
    uint256 saleIndex;
    //mapping(uint256 => Auction) auctions;
    mapping(uint256 => Sale) sales;

    constructor() {
        owner = msg.sender;
        //auctionsIndex = 0;
        saleIndex = 0;
    }

/*
    function startAuction(string memory item, uint length) public {
        auctions[auctionsIndex] = Auction(msg.sender, item, block.timestamp + length, address(0), 0);
    }

    function placeBid(uint256 index, uint256 bid) public {
        if(bid > auctions[index].highestBid){
            auctions[index].highestBid = bid;
            auctions[index].highestBider = msg.sender;
            // move funds
        }
    }

    function viewAuction(uint256 index) public view returns (Auction memory) {
        return auctions[index];
    }

    //use sale
    function endAuction(uint256 index) public {
        if(block.timestamp > auctions[index].endTime){
            //send money to who?
            //how do they claim their NFT?
            delete auctions[index];
            //what if no one bids?
        }
    }
*/
    function startSale(address beneficiary, string memory item, uint price) public {
        sales[saleIndex] = Sale(msg.sender, beneficiary, item, price, false);//msg.sender, item, block.timestamp + length, address(0), 0);
    }

    function viewSale(uint256 index) public view returns (Sale memory) {
        return sales[index];
    }

    /*function buyNFT(uint256 index, uint256 bid) public {
        if(sales[index]){
            //sales[index].highestBid = bid;
            //sales[index].highestBider = msg.sender;
            // move funds
        }
    }*/

    function sellerClaimFunds(uint256 index) public {
        if(sales[index].sold) {
            //uint amount = sales[index].price;
            delete sales[index];//delete first to stop rentry attack
            //transfur funds to seller
        }
        
    }


/*
    function setGreeting(string memory _greeting) public {
        console.log("Changing greeting from '%s' to '%s'", greeting, _greeting);
        greeting = _greeting;

    }
*/
}
