// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Token1 is ERC20 {

    address public deployer;
    uint256 public immutable maxSupply;

    constructor(string memory _tokenname, string memory _tokensymbol) ERC20(_tokenname,_tokensymbol) {
        deployer = msg.sender;
        maxSupply = 1_000_000 * 10 ** decimals();
        _mint(msg.sender, 250_000 * 10 ** decimals());
    }
    function mint(uint256 _amount) external {
        require(deployer == msg.sender, "not the deployer");
        require(totalSupply() + _amount <= maxSupply, "greater than maxSupply");
        _mint(msg.sender, _amount);
    }
}
