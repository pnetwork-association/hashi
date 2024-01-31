// SPDX-License-Identifier: LGPL-3.0-only
pragma solidity ^0.8.20;

import { IOracleAdapter } from "../interfaces/IOracleAdapter.sol";

abstract contract OracleAdapter is IOracleAdapter {
    mapping(uint256 => mapping(uint256 => bytes32)) private _hashes;

    /// @inheritdoc IOracleAdapter
    function getHashFromOracle(uint256 domain, uint256 id) public view returns (bytes32) {
        return _hashes[domain][id];
    }

    function _storeHashes(uint256 domain, uint256[] memory ids, bytes32[] memory hashes) internal {
        for (uint256 i = 0; i < ids.length; ) {
            _storeHash(domain, ids[i], hashes[i]);
            unchecked {
                ++i;
            }
        }
    }

    function _storeHash(uint256 domain, uint256 id, bytes32 hash) internal {
        bytes32 currentHash = _hashes[domain][id];
        if (currentHash != hash) {
            _hashes[domain][id] = hash;
            emit HashStored(id, hash);
        }
    }
}
