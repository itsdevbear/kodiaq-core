// SPDX-License-Identifier: GPL-3.0-or-later

pragma solidity >=0.8.4;

import "../KodiaqERC20.sol";

contract ERC20 is KodiaqERC20 {
    constructor(uint256 _totalSupply) {
        _mint(msg.sender, _totalSupply);
    }
}
