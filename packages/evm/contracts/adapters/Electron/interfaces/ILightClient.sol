// SPDX-License-Identifier: LGPL-3.0-only
pragma solidity ^0.8.20;

interface ILightClient {
    function headers(uint256 slot) external view returns (bytes32);
}
