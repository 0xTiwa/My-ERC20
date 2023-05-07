// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

    //write token = DvT = Divine Token
    // uint totalsupply and maxsupply
    //mappping balanceOf 
    //constructor
    //transfer and mint(can only be called in the constructor) and burn function
    //approve function and transferfrom function
    //add a third event burn, burn event person burning and amount they are burning

contract DvT {
    uint256 public totalSupply;
    uint256 public constant maxSupply = 1_000_000 * 10 ** 18;
    address public deployer;
    uint8 public decimals = 18;
    string public name;
    string public symbol;

    mapping(address => uint) public balanceOf;

    //.....tokenowner.........spender
    mapping(address => mapping(address => uint)) public allowance;

    event Transfer(address from, address to, uint value);
    event Approval(address owner, address spender, uint value);
    event Burning(address person, uint amount);

    constructor(string memory _tokenname, string memory _tokensymbol) {
        deployer = msg.sender;
        _mint(250_000 * 10 ** 18);
        name = _tokenname;
        symbol = _tokensymbol;
    }
    
    function transfer(address receiver, uint amount) external {
        require(receiver != address(0));
        require(amount <= balanceOf[msg.sender]);
        balanceOf[msg.sender] -= amount;
        balanceOf[receiver] += amount;
        emit Transfer(msg.sender, receiver, amount);
    }
    function approve(address spender, uint amount) external {
        allowance[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
    }
    function transferFrom(address account, address receiver, uint amount) external { 
        require(amount <= allowance[account][msg.sender]);
        require(amount <= balanceOf[account]);
        allowance[account][msg.sender] -= amount;
        balanceOf[account] -= amount;
        balanceOf[receiver] += amount;
    }
    function _mint(uint _amount) internal{
        require(totalSupply + _amount <= maxSupply, "greater than maxSupply");
        balanceOf[msg.sender] += _amount;
        totalSupply += _amount;
    }
    function burn(uint amount) external {
        require(amount <= balanceOf[msg.sender]);
        balanceOf[msg.sender] -= amount;
        totalSupply -= amount;
        emit Burning(msg.sender, amount);
    }
}
