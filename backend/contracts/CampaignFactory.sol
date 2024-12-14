// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

import "./Campaign.sol"; // Updated the import path to a relative path

/**
 * @title CampaignFactory
 * @dev Creates and deploys a new Campaign smart contract whenever any beneficiary creates a campaign
 */
contract CampaignFactory {
    // events
    // Logs the creation of a new Campaign
    event CampaignCreated(
        address indexed campaignAddress // Indexed for more efficient event filtering by frontend
    );

    // functions
    /**
     * @dev Allows beneficiaries to create a Campaign with the required details
     * @param _name Name of the Campaign
     * @param _description Description of the Campaign
     * @param _fundingGoal Funding Goal for the Campaign in cryptocurrency (e.g., SepoliaETH)
     * @param _deadline Timestamp of when the Campaign should be fully funded before it becomes inactive
     */
    function createCampaign(
        bytes32 _name,
        string calldata _description,
        uint256 _fundingGoal,
        uint48 _deadline
    ) external {
        // Create a new campaign smart contract
        Campaign campaign = new Campaign(
            msg.sender, // The beneficiary
            _name,
            _description,
            _fundingGoal,
            _deadline
        );

        // Emit CampaignCreated event to allow the frontend to retrieve the Campaign's address by filtering the logs for the CampaignCreated event
        emit CampaignCreated(address(campaign));
    }
}
