# Insurance Smart Contract

This project implements an insurance smart contract on the Ethereum blockchain. The smart contract allows users to buy insurance, make claims, renew insurance policies, and retrieve insurance details. It is designed to be upgradable and supports multiple insurance types and periods.

## Features

- Buy insurance: Users can purchase insurance policies by specifying the insurance type, period, and providing their personal details.
- Make claims: Insured users can file claims for their insurance policies, subject to certain conditions and proof requirements.
- Renew insurance: Insured users can renew their existing insurance policies by extending the period and paying the premium.
- Get insurance details: Users can retrieve the details of their insurance policies, including the insured user's information, insurance type, period, and claims information.

## Installation

Clone the repository:
```bash
git clone https://github.com/mohitchandel/inr-insurance.git
```
Install the required dependencies:
```bash
cd inr-insurance
```

Build the smart contracts:
```bash
forge build
```

Run Tests
```bash
forge test
```
## Usage
To interact with the insurance smart contract, you can use a web interface or directly interact with the contract using a tool like Remix or MyEtherWallet.

Instantiate the Insurance contract using the contract address.

Use the following functions to interact with the contract:

***buyInsurance(insType, period, userData)***: Buy insurance by specifying the insurance type, period, and user details.

***claimInsurance(insType, insId, isClaimProof)***: Make a claim for a specific insurance policy by providing the insurance type, policy ID, and proof of claim.

***renewInsurance(insType, period, insId)***: Renew an existing insurance policy by extending the period.

***getInsuranceDetails(insId)***: Retrieve the details of an insurance policy by providing the policy ID.