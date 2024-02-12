//SPDX-License-Identifier: MIT
import "@openzeppelin/contracts/interfaces/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
pragma solidity ^0.8.0;

interface ICoinConversion {
    function BRLgetChainlinkDataFeedLatestAnswer() external view returns (int);

    function BTCgetChainlinkDataFeedLatestAnswer() external view returns (int);

    function EURgetChainlinkDataFeedLatestAnswer() external view returns (int);

    function INRgetChainlinkDataFeedLatestAnswer() external view returns (int);

    function JPYgetChainlinkDataFeedLatestAnswer() external view returns (int);

    function ZARgetChainlinkDataFeedLatestAnswer() external view returns (int);
}

contract PayPerClick is Ownable{

    ICoinConversion CoinConversionContract;

    constructor () Ownable(msg.sender) {
        CoinConversionContract = ICoinConversion(0x33237931d95dB70d5e8c7386969Ab8fE176f79c3);
    }
   
    /* @notice Transfers a specified amount of ERC20 tokens from an advertiser to a content creator
    * @dev This function requires the contract to be an approved spender of the advertiser's tokens
    * @param _CC The address of the content creator to whom tokens will be credited
    * @param _amount The amount of USD that must be paid (US$ 200 -> 20000)
    * @param _token The address of the ERC20 token to be transferred
    * @return A boolean value indicating whether the transaction was successful
    */

    function payCC (address _CC, uint256 _amount, address _token) public onlyOwner returns (bool) {

    uint256 tokenAmount;

    // BRL Payment (stablecoin BRZ)
    if (_token == 0x71be881e9C5d4465B3FfF61e89c6f3651E69B5bb) {

        int BRLUSDPrice = CoinConversionContract.BRLgetChainlinkDataFeedLatestAnswer();

        tokenAmount = (_amount * 10**24) / uint256(BRLUSDPrice);

        IERC20(_token).transfer(_CC, tokenAmount);
    }

    //BTC Payment (BTCB)
    else if (_token == 0x7130d2A12B9BCbFAe4f2634d864A1Ee1Ce3Ead9c) {
        int BTCUSDPrice = CoinConversionContract.BTCgetChainlinkDataFeedLatestAnswer();

        tokenAmount = (_amount * 10**24) / uint256(BTCUSDPrice);

        IERC20(_token).transfer(_CC, tokenAmount);
    }

    //EUR Payment (AEUR)
    else if (_token == 0xA40640458FBc27b6EefEdeA1E9C9E17d4ceE7a21) {
        int EURUSDPrice = CoinConversionContract.EURgetChainlinkDataFeedLatestAnswer();

        tokenAmount = (_amount * 10**24) / uint256(EURUSDPrice);

        IERC20(_token).transfer(_CC, tokenAmount);
    }

    //USD Payment - USDT
    else {
        IERC20(_token).transfer(_CC, _amount * 10 **16);
    }
        return true;
    }
}