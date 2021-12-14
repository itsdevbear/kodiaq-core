pragma solidity =0.5.16;

import '../KodiaqERC20.sol';

contract ERC20 is KodiaqERC20 {
    constructor(uint _totalSupply) public {
        _mint(msg.sender, _totalSupply);
    }
}
