// SPDX-License-Identifier: GPL-3.0-or-later

pragma solidity ^0.8.10;

import "../KodiaqERC20.sol";

contract ERC20 is KodiaqERC20 {
    constructor(uint256 _totalSupply) KodiaqERC20("Kodiaq", "KDAQ", 18) {
        _mint(msg.sender, _totalSupply);
    }
}
