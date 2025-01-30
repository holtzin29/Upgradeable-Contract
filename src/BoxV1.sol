//SPDX-License-Identifier: MIT

pragma solidity 0.8.28;
import {UUPSUpgradeable} from "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import {OwnableUpgradeable} from "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

// storage is stored in the proxy not in the implementation
// proxy is borrowing functions -> implemantations
// proxy -> deploy implementations -> call an initializer function

contract BoxV1 is Initializable, UUPSUpgradeable, OwnableUpgradeable {
    uint256 internal value;

    // you are using a constructor in a upgradeable contract(let it happen)
    constructor() {
        _disableInitializers(); // dont let any initializer happen // you can't use constructor with our proxies(it addes storage to the implemantation)
    }

    // this is like an constructor for a proxy, you can only initialize once
    function initialize() public initializer {
        __Ownable_init(msg.sender); // sets the owner to msg.sender and it should only be called to initialize
        __UUPSUpgradeable_init();
    }

    function getValue() external view returns (uint256) {
        return value;
    }

    function version() external pure returns (uint256) {
        return 1;
    }

    function _authorizeUpgrade(
        address newImplementation
    ) internal override onlyOwner {}

    function upgradeTo(address newImplementation) external onlyOwner {}
}
