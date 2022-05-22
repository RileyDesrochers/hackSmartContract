const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Ukraine", function () {
  it("test Ukraine contract", async function () {
    const Ukraine = await ethers.getContractFactory("Ukraine");
    const ukraine = await Ukraine.deploy();
    await ukraine.deployed();

    //expect(await ukraine.greet()).to.equal("Hello, world!"); viewAuction

    //const setGreetingTx = await ukraine.startAuction('https://mirror-api.com/editions')

    //const auct = await ukraine.viewAuction(0)

    //console.log(auct.highestBid)

    //expect(auct.highestBid).to.equal(0)


    //const setGreetingTx = await ukraine.setGreeting("Hola, mundo!");

    // wait until the transaction is mined
    //await setGreetingTx.wait();

    //expect(await greeter.greet()).to.equal("Hola, mundo!");
  });
});
