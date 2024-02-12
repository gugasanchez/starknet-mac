// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract CoinConversion {

    AggregatorV3Interface internal BRLUSDDataFeed;
    AggregatorV3Interface internal BTCUSDDataFeed;
    AggregatorV3Interface internal EURUSDDataFeed;
    AggregatorV3Interface internal INRUSDDataFeed;
    AggregatorV3Interface internal JPYUSDDataFeed;
    AggregatorV3Interface internal ZARUSDDataFeed;

    /**
     * Network: Binance Smart Chain

     * Aggregator: BRL/USD
     * Address: 0x5cb1Cb3eA5FB46de1CE1D0F3BaDB3212e8d8eF48

     * Aggregator: BTC/USD
     * Address: 0x264990fbd0A4796A3E3d8E37C4d5F87a3aCa5Ebf

     * Aggregator: EUR/USD
     * Address: 0x0bf79F617988C472DcA68ff41eFe1338955b9A80

     * Aggregator: INR/USD
     * Address: 0xeF0a3109ce97e0B58557F0e3Ba95eA16Bfa4A89d

     * Aggregator: JPY/USD
     * Address: 0x22Db8397a6E77E41471dE256a7803829fDC8bC57

     * Aggregator: ZAR/USD
     * Address: 0xDE1952A1bF53f8E558cc761ad2564884E55B2c6F
     */

    constructor() {
        BRLUSDDataFeed = AggregatorV3Interface(0x5cb1Cb3eA5FB46de1CE1D0F3BaDB3212e8d8eF48);
        BTCUSDDataFeed = AggregatorV3Interface(0x264990fbd0A4796A3E3d8E37C4d5F87a3aCa5Ebf);
        EURUSDDataFeed = AggregatorV3Interface(0x0bf79F617988C472DcA68ff41eFe1338955b9A80);
        INRUSDDataFeed = AggregatorV3Interface(0xeF0a3109ce97e0B58557F0e3Ba95eA16Bfa4A89d);
        JPYUSDDataFeed = AggregatorV3Interface(0x22Db8397a6E77E41471dE256a7803829fDC8bC57);
        ZARUSDDataFeed = AggregatorV3Interface(0xDE1952A1bF53f8E558cc761ad2564884E55B2c6F);
    }

    function BRLgetChainlinkDataFeedLatestAnswer() public view returns (int) {
        // prettier-ignore
        (
            /* uint80 roundID */,
            int answer,
            /*uint startedAt*/,
            /*uint timeStamp*/,
            /*uint80 answeredInRound*/
        ) = BRLUSDDataFeed.latestRoundData();
        return answer;
    }

    function BTCgetChainlinkDataFeedLatestAnswer() public view returns (int) {
        // prettier-ignore
        (
            /* uint80 roundID */,
            int answer,
            /*uint startedAt*/,
            /*uint timeStamp*/,
            /*uint80 answeredInRound*/
        ) = BTCUSDDataFeed.latestRoundData();
        return answer;
    }

    function EURgetChainlinkDataFeedLatestAnswer() public view returns (int) {
        // prettier-ignore
        (
            /* uint80 roundID */,
            int answer,
            /*uint startedAt*/,
            /*uint timeStamp*/,
            /*uint80 answeredInRound*/
        ) = EURUSDDataFeed.latestRoundData();
        return answer;
    }

    function INRgetChainlinkDataFeedLatestAnswer() public view returns (int) {
        // prettier-ignore
        (
            /* uint80 roundID */,
            int answer,
            /*uint startedAt*/,
            /*uint timeStamp*/,
            /*uint80 answeredInRound*/
        ) = INRUSDDataFeed.latestRoundData();
        return answer;
    }

    function JPYgetChainlinkDataFeedLatestAnswer() public view returns (int) {
        // prettier-ignore
        (
            /* uint80 roundID */,
            int answer,
            /*uint startedAt*/,
            /*uint timeStamp*/,
            /*uint80 answeredInRound*/
        ) = JPYUSDDataFeed.latestRoundData();
        return answer;
    }

    function ZARgetChainlinkDataFeedLatestAnswer() public view returns (int) {
        // prettier-ignore
        (
            /* uint80 roundID */,
            int answer,
            /*uint startedAt*/,
            /*uint timeStamp*/,
            /*uint80 answeredInRound*/
        ) = ZARUSDDataFeed.latestRoundData();
        return answer;
    }
    
}
