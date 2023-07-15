async function main() {
 
 const registration= await hre.ethers.deployContract("Registration");

  await registration.waitForDeployment();


  console.log("registration Contract Address:", registration.target);
}


main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });