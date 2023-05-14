// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

interface IInsurance {
    struct UserDetails {
        string fullName;
        string email;
        string phone;
        string residenceAddress;
        string age;
        address payable claimedAddress;
    }

    struct InsuranceDetails {
        UserDetails InsuredUser;
        InsuranceType insuramceType;
        Period period;
        uint8 insuranceCailmsLeft;
        bool hasClaimedAll;
    }

    enum InsuranceType {
        Life,
        Health,
        Vehicle
    }

    enum Period {
        OneYear,
        TwoYear,
        ThreeYear,
        FourYear
    }

    function buyInsurance(
        InsuranceType insType,
        Period period,
        UserDetails calldata userDetails
    ) external payable;

    function claimInsurance(
        InsuranceType insType,
        address insId,
        bool isClaimProof
    ) external payable;

    function renewInsurance(
        InsuranceType insType,
        Period period,
        address insId
    ) external payable;

    function getInsuranceDetails(
        address insId
    ) external view returns (InsuranceDetails memory);
}
