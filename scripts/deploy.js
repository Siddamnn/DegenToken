const hre = require("hardhat");
async function main(){
  const [deployer]=await ethers.getSigners();
  console.log("Deploying contract using account:", deployer.address);

  const Token= await ethers.deployContract("DegenToken");
  console.log("Contract address:",await Token.address);


}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});