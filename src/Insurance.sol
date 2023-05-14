// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;
import "./IInsurance.sol";

contract Insurance is IInsurance {
    mapping(address => InsuranceDetails) private insuranceDetails;
    mapping(address => UserDetails) private userDetails;

    function buyInsurance(
        InsuranceType insType,
        Period period,
        UserDetails calldata userData
    ) external payable override {
        require(checkForUserData(userData) == true, "Invalid user data");
        require(
            msg.value == getInsurancePremium(insType, period),
            "Invalid amount"
        );
        userDetails[msg.sender] = userData;

        uint8 insurancesCanClaim;
        if (period == Period.OneYear) {
            insurancesCanClaim = 1;
        } else if (period == Period.TwoYear) {
            insurancesCanClaim = 2;
        } else if (period == Period.ThreeYear) {
            insurancesCanClaim = 3;
        } else if (period == Period.FourYear) {
            insurancesCanClaim = 4;
        }
        insuranceDetails[msg.sender] = InsuranceDetails(
            userData,
            insType,
            period,
            insurancesCanClaim,
            false
        );
    }

    function claimInsurance(
        InsuranceType insType,
        address insId,
        bool isClaimProof
    ) external payable override {
        require(
            checkForInsuranceClaim(insType, insId, isClaimProof) == true,
            "Invalid claim"
        );
        uint8 claimLeft = insuranceDetails[insId].insuranceCailmsLeft;
        require(claimLeft > 0, "No claims left");

        getInsuranceClaim(insType);
        uint8 claimLeftAfter;
        if (insuranceDetails[insId].insuranceCailmsLeft > 0) {
            claimLeftAfter = insuranceDetails[insId].insuranceCailmsLeft - 1;
        }
        if (claimLeftAfter == 0) {
            insuranceDetails[insId].hasClaimedAll = true;
        }
        insuranceDetails[insId].InsuredUser.claimedAddress.transfer(
            getInsuranceClaim(insType)
        );
    }

    function renewInsurance(
        InsuranceType insType,
        Period period,
        address insId
    ) external payable {
        require(
            insuranceDetails[insId].InsuredUser.claimedAddress != address(0),
            "Invalid insurance id"
        );
        require(
            insuranceDetails[insId].hasClaimedAll == true,
            "Insurance not claimed"
        );
        require(
            insuranceDetails[insId].InsuredUser.claimedAddress == msg.sender,
            "Invalid User"
        );
        require(
            msg.value == getInsurancePremium(insType, period),
            "Invalid amount"
        );
        insuranceDetails[insId].period = period;
        insuranceDetails[insId].hasClaimedAll = false;

        if (period == Period.OneYear) {
            insuranceDetails[insId].insuranceCailmsLeft = 1;
        } else if (period == Period.TwoYear) {
            insuranceDetails[insId].insuranceCailmsLeft = 2;
        } else if (period == Period.ThreeYear) {
            insuranceDetails[insId].insuranceCailmsLeft = 3;
        } else if (period == Period.FourYear) {
            insuranceDetails[insId].insuranceCailmsLeft = 4;
        }
    }

    function getInsuranceDetails(
        address insId
    ) external view override returns (InsuranceDetails memory) {
        return insuranceDetails[insId];
    }

    function checkForUserData(
        UserDetails calldata userData
    ) internal pure returns (bool) {
        require(keccak256(bytes(userData.fullName)) != keccak256(bytes("")));
        require(keccak256(bytes(userData.email)) != keccak256(bytes("")));
        require(keccak256(bytes(userData.phone)) != keccak256(bytes("")));
        require(
            keccak256(bytes(userData.residenceAddress)) != keccak256(bytes(""))
        );
        require(keccak256(bytes(userData.age)) != keccak256(bytes("")));
        require(userData.claimedAddress != address(0));
        return true;
    }

    function checkForInsuranceClaim(
        InsuranceType insType,
        address insId,
        bool isClaimProof
    ) internal view returns (bool) {
        require(
            insuranceDetails[insId].InsuredUser.claimedAddress != address(0),
            "Invalid insurance id"
        );
        require(isClaimProof == true, "Valid proof required");
        require(
            insuranceDetails[insId].insuramceType == insType,
            "Invalid insurance type"
        );
        require(
            insuranceDetails[insId].hasClaimedAll == false,
            "Insurance already claimed"
        );
        require(
            insuranceDetails[insId].InsuredUser.claimedAddress == msg.sender,
            "Invalid claimer"
        );
        return true;
    }

    function getInsurancePremium(
        InsuranceType insType,
        Period period
    ) internal pure returns (uint256) {
        uint256 premium = 0;
        if (insType == InsuranceType.Life) {
            if (period == Period.OneYear) {
                premium = 1 ether;
            } else if (period == Period.TwoYear) {
                premium = 2 ether;
            } else if (period == Period.ThreeYear) {
                premium = 3 ether;
            } else if (period == Period.FourYear) {
                premium = 4 ether;
            }
        } else if (insType == InsuranceType.Health) {
            if (period == Period.OneYear) {
                premium = 0.5 ether;
            } else if (period == Period.TwoYear) {
                premium = 0.7 ether;
            } else if (period == Period.ThreeYear) {
                premium = 1 ether;
            } else if (period == Period.FourYear) {
                premium = 1.2 ether;
            }
        } else if (insType == InsuranceType.Vehicle) {
            if (period == Period.OneYear) {
                premium = 0.05 ether;
            } else if (period == Period.TwoYear) {
                premium = 0.075 ether;
            } else if (period == Period.ThreeYear) {
                premium = 0.1 ether;
            } else if (period == Period.FourYear) {
                premium = 0.25 ether;
            }
        }
        return premium;
    }

    function getInsuranceClaim(
        InsuranceType insType
    ) internal pure returns (uint256) {
        uint256 claim = 0;
        if (insType == InsuranceType.Life) {
            claim = 4 ether;
        } else if (insType == InsuranceType.Health) {
            claim = 2.5 ether;
        } else if (insType == InsuranceType.Vehicle) {
            claim = 1 ether;
        }
        return claim;
    }
}
