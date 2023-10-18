// SPDX-License-Identifier: Apache License 2.0
pragma solidity 0.8.15;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

contract MasterToken is ERC20Burnable, Ownable {
    bytes32 public sidechainAssetId;

    /**
     * @dev Constructor that gives the specified address all of existing tokens.
     */
    constructor(
        string memory name,
        string memory symbol,
        address beneficiary,
        uint256 supply,
        bytes32 sideChainAssetId
    ) ERC20(name, symbol) {
        sidechainAssetId = sideChainAssetId;
        _mint(beneficiary, supply);
    }

    fallback() external {
        revert();
    }

    function mintTokens(address beneficiary, uint256 amount) external onlyOwner {
        _mint(beneficiary, amount);
    }
}
