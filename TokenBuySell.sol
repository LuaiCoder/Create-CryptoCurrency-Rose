pragma solidity >=0.4.22 <0.9.0;

import "./RoseToken.sol";

contract TokenBuySell {
    address payable  admin;
    RoseToken public tokenContract;
    uint256 public tokenPrice;
    uint256 public tokensSold;


    event Sell(address _buyer, uint256 _amount);

   		constructor(RoseToken _tokenContract, uint256 _tokenPrice) public {
        admin = msg.sender;
        tokenContract = _tokenContract;
        tokenPrice = _tokenPrice; 

	}

	 function multiply(uint x, uint y) internal pure returns (uint z) {
        require(y == 0 || (z = x * y) / y == x);
    }

	//Buy Tokens
	function buyTokens(uint256 _numberOfTokens) public payable{

		// Require that value is equal to token

		require(msg.value ==  multiply(_numberOfTokens, tokenPrice));
		require(tokenContract.balanceOf(address(this)) >= _numberOfTokens);
		require(tokenContract.transfer(msg.sender, _numberOfTokens));


		// Requirement to transfer successful

		// Keep track of tokens sold
		tokensSold += _numberOfTokens;

		// Trigger sell event
		emit Sell(msg.sender, _numberOfTokens);

	}

	function endSale () public {

		 //Require admin 
		 require(msg.sender == admin);
		 //Transfer remaining dapp tokens to admin
		 require(tokenContract.transfer(admin, tokenContract.balanceOf(address(this))));
  
		 //Destroy contract
		      // Just transfer the balance to the admin
        admin.transfer(address(this).balance);
    }
}
