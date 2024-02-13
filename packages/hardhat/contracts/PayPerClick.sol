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

    struct Partnership {
        address advertiser;
        address cc;
        address paymentToken;
        uint256 CPM;
        uint256 totalAmount; //USD
        uint256 paidAmount; //USD
        bool status;
    }

    Partnership[] public partnerships;

    constructor () Ownable(msg.sender) {
        CoinConversionContract = ICoinConversion(0x33237931d95dB70d5e8c7386969Ab8fE176f79c3);
    }

    function createPartnership(address _advertiser, address _cc, address _paymentToken, uint256 _CPM, uint256 _totalAmount) public onlyOwner {

        uint256 tokensTotalAmount = convertUSDToToken(_totalAmount, _paymentToken);

        IERC20(_paymentToken).transferFrom(_advertiser, address(this), tokensTotalAmount);

        Partnership memory newPartnership = Partnership({
            advertiser: _advertiser,
            cc: _cc,
            paymentToken: _paymentToken,
            CPM: _CPM,
            totalAmount: _totalAmount,
            paidAmount: 0,
            status: true
        });

        partnerships.push(newPartnership);
    }
   
    /* @notice Transfers a specified amount of ERC20 tokens from an advertiser to a content creator
    * @dev This function requires the contract to be an approved spender of the advertiser's tokens
    * @param _CC The address of the content creator to whom tokens will be credited
    * @param _amount The amount of USD that must be paid (US$ 200 -> 20000)
    * @param _token The address of the ERC20 token to be transferred
    * @return A boolean value indicating whether the transaction was successful
    */

    function payCC (uint256 _partnershipIndex) public onlyOwner returns (bool) {

        Partnership storage partnership = partnerships[_partnershipIndex];

        require(partnership.totalAmount >= (partnership.paidAmount + partnership.CPM), "Maximum amount paid");
        require(partnership.status == true, "Partnership is closed");

        uint256 paymentAmount = convertUSDToToken(partnership.CPM, partnership.paymentToken);
        IERC20(partnership.paymentToken).transfer(partnership.cc, paymentAmount);

        partnership.paidAmount += partnership.CPM;

        return true;
    }

    function convertUSDToToken (uint256 _amount, address _token) public view returns (uint256){
        uint256 tokenAmount;

        if (_token == 0x71be881e9C5d4465B3FfF61e89c6f3651E69B5bb) {

        int BRLUSDPrice = CoinConversionContract.BRLgetChainlinkDataFeedLatestAnswer();
        tokenAmount = (_amount * 10**24) / uint256(BRLUSDPrice);
        }

        //BTC Payment (BTCB)
        else if (_token == 0x7130d2A12B9BCbFAe4f2634d864A1Ee1Ce3Ead9c) {

        int BTCUSDPrice = CoinConversionContract.BTCgetChainlinkDataFeedLatestAnswer();
        tokenAmount = (_amount * 10**24) / uint256(BTCUSDPrice);
        }

        //EUR Payment (AEUR)
        else if (_token == 0xA40640458FBc27b6EefEdeA1E9C9E17d4ceE7a21) {

        int EURUSDPrice = CoinConversionContract.EURgetChainlinkDataFeedLatestAnswer();
        tokenAmount = (_amount * 10**24) / uint256(EURUSDPrice);
        }

        //USD Payment - USDT
        else {
        tokenAmount = _amount * 10**16;
        }

        return tokenAmount;
    }

    function finishPartnership (uint256 _partnershipIndex) public returns (bool) {

        Partnership storage partnership = partnerships[_partnershipIndex];

        require(partnership.status = true, "Partnership is already closed");

        partnership.status = false;

        uint256 remainingUSD = partnership.totalAmount - partnership.paidAmount;

        uint256 remainingTokens = convertUSDToToken(remainingUSD, partnership.paymentToken);

        IERC20(partnership.paymentToken).transfer(partnership.advertiser, remainingTokens);

        return true;
    }

}