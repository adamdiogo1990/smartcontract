// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract ElectionPortal {

    uint256 totalVotes;

    event NewVote(address indexed from, uint256 timestamp, string candidate);

    struct Vote {
        address voter;
        string candidate;
        uint256 timestamp;
    }

    Vote[] votes;

    constructor() payable {
    console.log("We have been constructed!");
    }

    function vote(string memory _message) public {
        totalVotes += 1;
        console.log("%s has voted!", msg.sender, _message);

        votes.push(Vote(msg.sender, _message, block.timestamp));

        emit NewVote(msg.sender, block.timestamp, _message);

        uint256 prizeAmount = 0.0001 ether;
        require(
            prizeAmount <= address(this).balance,
            "Trying to withdraw more money than the contract has."
        );
        (bool success, ) = (msg.sender).call{value: prizeAmount}("");
        require(success, "Failed to withdraw money from contract.");
    }

    function getTotalVotes() public view returns (uint256) {
        console.log("We have %d total votes!", totalVotes);
        return totalVotes;
    }

    function getAllVotes() public view returns (Vote[] memory) {
        return votes;
    }
}