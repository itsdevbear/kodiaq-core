// SPDX-License-Identifier: GPL-3.0-or-later

pragma solidity >=0.8.4;

import "./interfaces/IKodiaqFactory.sol";
import "./KodiaqPair.sol";

contract KodiaqFactory is IKodiaqFactory {
    address public feeTo;
    address public feeToSetter;

    mapping(address => mapping(address => address)) public getPair;
    address[] public allPairs;

    constructor(address _feeToSetter) {
        feeToSetter = _feeToSetter;
    }

    function allPairsLength() external view returns (uint256) {
        return allPairs.length;
    }

    function createPair(address tokenA, address tokenB)
        external
       
        returns (address pair)
    {
        require(tokenA != tokenB, "Kodiaq: IDENTICAL_ADDRESSES");
        (address token0, address token1) = tokenA < tokenB
            ? (tokenA, tokenB)
            : (tokenB, tokenA);
        require(token0 != address(0), "Kodiaq: ZERO_ADDRESS");
        require(
            getPair[token0][token1] == address(0),
            "Kodiaq: PAIR_EXISTS"
        ); // single check is sufficient

        pair = address(
            new KodiaqPair{
                salt: keccak256(abi.encodePacked(token0, token1))
            }()
        );
        IKodiaqPair(pair).initialize(token0, token1);
        getPair[token0][token1] = pair;
        getPair[token1][token0] = pair; // populate mapping in the reverse direction
        allPairs.push(pair);
        emit PairCreated(token0, token1, pair, allPairs.length);
    }

    function setFeeTo(address _feeTo) external {
        require(msg.sender == feeToSetter, "Kodiaq: FORBIDDEN");
        feeTo = _feeTo;
    }

    function setFeeToSetter(address _feeToSetter) external {
        require(msg.sender == feeToSetter, "Kodiaq: FORBIDDEN");
        feeToSetter = _feeToSetter;
    }
}
