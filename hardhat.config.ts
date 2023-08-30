import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";


const config: HardhatUserConfig = {
  solidity: "0.8.19",
  networks: {
    aster: {
      url: "https://evm.astar.network/",
      chainId: 592,
      accounts: [`0x${process.env.RCP_PRIVATE_KEY}`]
    }
  }
};

export default config;
