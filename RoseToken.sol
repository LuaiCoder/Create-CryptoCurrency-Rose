pragma solidity >=0.4.22 <0.9.0;

contract RoseToken {

	string public name = "Rose Token";
	string public symbol = "Rose";
	string public standard = "Rose Token v1.0";
	uint256 public totalSupply = 1000000000000000000000000; // 1 million tokens
  	uint8   public decimals = 18;

  event Transfer( address indexed _from, address indexed _to, uint256 _value );

  event Approval( address indexed _owner, address indexed _spender, uint256 _value );

  mapping(address => uint256) public balanceOf;
  mapping(address => mapping(address => uint256)) public allowance;

  constructor() public {
    balanceOf[msg.sender] = totalSupply;
    // allocate supply
  }

  //Transfer
  //Exception if account doesnt have enough
  //Return a boolaen
  //Transfer Event

  function _transfer(address _from, address _to, uint256 _value) internal {
    require(_to!=address(0));
    require(balanceOf[_from] >= _value);
    require(balanceOf[_to] + _value >= balanceOf[_to]);
    balanceOf[_from] -= _value;
    balanceOf[_to] += _value;

    emit Transfer(_from, _to, _value);

    }

  function transfer(address _to, uint256 _value) public returns (bool success) {
    _transfer(msg.sender, _to, _value); 

    return true;

    }

  function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
      require(_value <= allowance[_from][msg.sender]);

      allowance[_from][msg.sender] -= _value;

      _transfer(_from, _to, _value); 

      return true;

    }


  function approve(address _spender, uint256 _value) public returns (bool success) {

      // allowance

      allowance[msg.sender][_spender] = _value;

      //Approve event
      emit Approval(msg.sender, _spender, _value);


      return true;

    } 


}
