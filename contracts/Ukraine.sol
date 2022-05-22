//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";
import '@openzeppelin/contracts/token/ERC20/IERC20.sol';
import '@openzeppelin/contracts/token/ERC721/ERC721.sol';

/*
struct Auction { 
   address seller;
   string item;
   uint endTime;
   address highestBider;
   uint256 highestBid;
}
*/

contract JournalistMedia is ERC721 {
    address public owner;
    uint256 tokenID = 1;

    constructor() ERC721('')
}

struct Sale { 
   address seller;
   address beneficiary;
   string item;
   uint256 price;
   bool sold;
   uint timelock;
}

address constant currency = 0x765DE816845861e75A25fCA122bb6898B8B1282a; //cUSD on testnet

contract Ukraine {
    //address owner;
    //uint256 auctionsIndex;
    uint256 saleIndex;
    //mapping(uint256 => Auction) auctions;
    mapping(uint256 => Sale) sales;

    constructor() {
        //owner = msg.sender;
        //auctionsIndex = 0;
        saleIndex = 0;
    }

    modifier onlySeller(uint256 index) {
        require(sales[index].seller == msg.sender);
        _;
    }

    modifier onlyBeneficiary(uint256 index) {
        require(sales[index].beneficiary == msg.sender);
        _;
    }

    function startSale(address beneficiary, string memory item, uint price) public {
        sales[saleIndex] = Sale(msg.sender, beneficiary, item, price, false, 0);
        saleIndex += 1;
    }

    function viewSale(uint256 index) public view returns (Sale memory) {
        return sales[index];
    }

    function buyNFT(uint256 index) public {
        Sale memory s = sales[index];
        if(IERC20(currency).allowance(msg.sender, address(this)) > s.price){//does this acount for bal
            IERC20(currency).transferFrom(msg.sender, address(this), s.price);
            //mint NFT?
            sales[index].sold = true;
        }
    }

    function sellerClaimFunds(uint256 index) public onlySeller(index) {
        Sale memory s = sales[index];
        if(s.sold) {
            uint price = s.price;
            address seller = s.seller;
            delete sales[index];//delete first to stop rentry attack
            IERC20(currency).transfer(seller, price);
        }
    }

    function beneficiaryClaimFunds(uint256 index) public onlyBeneficiary(index) {
        if(sales[index].sold) {
            sales[index].timelock = block.timestamp + 14 * 24 * 60 * 60; //two weeks from now
        }
    }

    function beneficiaryReceiveFunds(uint256 index) public onlyBeneficiary(index) {
        Sale memory s = sales[index];
        if(block.timestamp > s.timelock) {
            uint price = s.price;
            address beneficiary = s.beneficiary;
            delete sales[index];//delete first to stop rentry attack
            IERC20(currency).transfer(beneficiary, price);
        }
    }

    function cancelSale(uint256 index) public onlySeller(index) {
        if(!sales[index].sold) 
            delete sales[index];
    }
    
    //IERC20(input).balanceOf(address(pair))
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


/*
    function setGreeting(string memory _greeting) public {
        console.log("Changing greeting from '%s' to '%s'", greeting, _greeting);
        greeting = _greeting;

    }
*/
}

/*
library LowGasSafeMath {
    /// @notice Returns x + y, reverts if sum overflows uint256
    /// @param x The augend
    /// @param y The addend
    /// @return z The sum of x and y
    function add(uint256 x, uint256 y) internal pure returns (uint256 z) {
        require((z = x + y) >= x);
    }

    /// @notice Returns x - y, reverts if underflows
    /// @param x The minuend
    /// @param y The subtrahend
    /// @return z The difference of x and y
    function sub(uint256 x, uint256 y) internal pure returns (uint256 z) {
        require((z = x - y) <= x);
    }

    /// @notice Returns x * y, reverts if overflows
    /// @param x The multiplicand
    /// @param y The multiplier
    /// @return z The product of x and y
    function mul(uint256 x, uint256 y) internal pure returns (uint256 z) {
        require(x == 0 || (z = x * y) / x == y);
    }

    /// @notice Returns x + y, reverts if overflows or underflows
    /// @param x The augend
    /// @param y The addend
    /// @return z The sum of x and y
    function add(int256 x, int256 y) internal pure returns (int256 z) {
        require((z = x + y) >= x == (y >= 0));
    }

    /// @notice Returns x - y, reverts if overflows or underflows
    /// @param x The minuend
    /// @param y The subtrahend
    /// @return z The difference of x and y
    function sub(int256 x, int256 y) internal pure returns (int256 z) {
        require((z = x - y) <= x == (y >= 0));
    }
}
*/