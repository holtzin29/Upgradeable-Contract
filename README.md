# Upgradeable-Contracts
# Overview
This project demonstrates the use of upgradeable smart contracts on Ethereum (or compatible networks) using the Proxy Pattern, specifically utilizing the ERC1967Proxy from OpenZeppelin. The system is composed of a set of contracts designed to store and retrieve values, while also allowing for easy upgrades to the business logic without losing any data.

# The contracts in this project include:

- BoxV1 (Initial Implementation)
- BoxV2 (Upgraded Implementation)
- DeployBox (Script to deploy BoxV1 with Proxy)
-  UpgradeBox (Script to upgrade BoxV1 to BoxV2)
- DeployAndUpgradeTest (Test contract for deployment and upgrade checks)

## Technologies Used
- Solidity: A high-level programming language for writing smart contracts on the Ethereum blockchain.
- OpenZeppelin Contracts: A library of secure and community-vetted smart contract components, such as:
- ERC1967Proxy: A standard implementation of the proxy pattern for upgradeable contracts.
- UUPSUpgradeable: A proxy upgrade pattern to facilitate efficient contract upgrades.
- Initializable: A utility to replace constructors in upgradeable contracts with initializer functions.
- OwnableUpgradeable: A utility to implement ownership functionality in upgradeable contracts.
- Foundry: A fast, portable, and modular framework for smart contract development. It provides tools like:
- Forge: A tool for testing and deploying smart contracts.
- Script: A feature to create deployable scripts and automations for smart contracts.
- Ethereum: The blockchain platform on which these upgradeable smart contracts are deployed and executed.

# Files

# Scripts

## 1. DeployBox.sol
- This script deploys the initial version of the Box contract using a proxy. It uses the ERC1967Proxy to ensure that the Box contract can be upgraded later while keeping the state in the proxy.

- Key Functions:
 
- run: Deploys the BoxV1 contract with a proxy and returns the proxy address.

- deployBox: Deploys BoxV1 and wraps it in an ERC1967Proxy. It then calls the initialize() function of the BoxV1 contract to set up initial values.

## 2. UpgradeBox.sol
- This script upgrades an existing proxy from BoxV1 to BoxV2.

- Functions:
  
- run: Finds the most recently deployed proxy, deploys BoxV2, and then upgrades the proxy to point to the new implementation.
  
- upgradeBox: Takes the proxy address and new implementation address as arguments and performs the upgrade by calling upgradeTo() on the proxy.

# Source

## 3. BoxV1.sol
- The first version of the Box contract, implementing basic functionality such as storing and retrieving values. It is designed to be upgradeable.

- Key functions:
  
- initialize: The initialization function that sets the contract’s owner and initializes UUPS functionality (required for upgradeable contracts).

- getValue: Returns the stored value.

- upgradeTo: Allows the contract owner to upgrade to a new implementation.

- _authorizeUpgrade: Ensures only the contract owner can upgrade to a new implementation.


## 4. BoxV2.sol
- The second version of the Box contract that introduces a new function, setValue(), which allows the contract owner to update the stored value. This contract is an upgrade of BoxV1.

- Key functions:

- setValue: Allows setting a new value.

- getValue: Returns the current stored value.

- _authorizeUpgrade: Restricts upgrades to the owner.

# Tests
## 5. DeployAndUpgradeTest.sol
- A testing contract that uses Foundry’s testing framework to ensure both the deployment and upgrade processes work as expected.
 
- Key Functions:
 
- testProxyStartsAsBoxV1: Verifies that the proxy initially points to BoxV1.
 
- testBoxWorks: Tests the initial functionality of BoxV1 by checking the version.
  
- testUpgradeWorks: Tests the upgrade process from BoxV1 to BoxV2, including value setting.

# Interacting with the Contract:

- BoxV1 allows the retrieval of the stored value via the getValue function.
  
- BoxV2 allows setting and retrieving the value with setValue and getValue. After the upgrade, you can interact with the new functions of BoxV2.
  
# Important Notes
- Proxy Pattern: The proxy ensures that the state of the contract is maintained even when the implementation is upgraded.
 
- UUPSUpgradeable: This pattern ensures that only authorized parties (typically the contract owner) can upgrade the contract.

- Initializable: Used to replace constructors in upgradeable contracts, allowing for an initializer function that is only called once.

# Testing with Forge
- To run the tests using Foundry, you can use the following command in the terminal:
'''
forge test 
'''
- This will execute the tests defined in the DeployAndUpgradeTest.sol contract. It will check the following:

- testProxyStartsAsBoxV1: Ensures the proxy starts with BoxV1 and prevents setting values on BoxV2 before the upgrade.
- testBoxWorks: Verifies the functionality of BoxV1 by checking the version and ensuring the contract is deployed correctly.
- testUpgradeWorks: Tests the upgrade from BoxV1 to BoxV2, verifies the version, and ensures that the new functionality (e.g., setValue()) works as expected.

# Inspired in
- This whole repo was inspired in Cyfrin Upgradeable contracts lessons.

# License
## MIT
