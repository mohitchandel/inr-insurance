// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;
import "../src/Insurance.sol";

contract InsuranceTest {
    Insurance insuranceContract;
    
    constructor(address _insuranceContract) {
        insuranceContract = Insurance(_insuranceContract);
    }
    
    function testInsurance() external {
        // Prepare test data
        IInsurance.InsuranceType insuranceType = IInsurance.InsuranceType.Life;
        IInsurance.Period insurancePeriod = IInsurance.Period.OneYear;
        Insurance.UserDetails memory userDetails = IInsurance.UserDetails(
            "John Doe",
            "john@example.com",
            "1234567890",
            "123 Main St",
            "30",
            payable(msg.sender)
        );
        
        // Buy insurance
        insuranceContract.buyInsurance(insuranceType, insurancePeriod, userDetails);
        
        // Claim insurance
        bool isClaimProof = true;
        insuranceContract.claimInsurance(insuranceType, msg.sender, isClaimProof);
        
        // Renew insurance
        insuranceContract.renewInsurance(insuranceType, insurancePeriod, msg.sender);
        
        // Get insurance details
        Insurance.InsuranceDetails memory insuranceDetails = insuranceContract.getInsuranceDetails(msg.sender);
        
    }
}
