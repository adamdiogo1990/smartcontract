import { ethers } from "hardhat";

const main = async () => {
  const voteContractFactory =  await ethers.getContractFactory("ElectionPortal");
  const lockedAmount = ethers.utils.parseEther("0.001");
  const voteContract = await voteContractFactory.deploy({ value: lockedAmount });

  let contractBalance = await ethers.provider.getBalance(
    voteContract.address
  )

  await voteContract.deployed();
  console.log("Contrato addy:" ,voteContract.address);
  console.log("Contract Balance:", ethers.utils.formatEther(contractBalance))
}

const runMain = async () => {
  try {
    await main();
    process.exit(0);
  } catch (error) {
    console.log(error);
    process.exit(1);
  }
}

runMain();