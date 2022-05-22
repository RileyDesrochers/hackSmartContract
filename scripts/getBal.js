// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// When running the script with `npx hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.
//const hre = require("hardhat");
const { ethers, waffle} = require("hardhat");
const provider = waffle.provider;


async function main() {
    const balance0ETH = await provider.getBalance('0x5AdA39e766c416CA083d8c7e43104f2C7cF2194A');
    console.log(balance0ETH)
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
//0x372a0400D646CF5e5e7fED74755EC87bA9D4b135