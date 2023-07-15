// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.18;

import "hardhat/console.sol";

contract Registration {
    address public owner;

    constructor() {
        owner = msg.sender;
        console.log("Welcome to registration dapp");
    }

    struct User {
        address user;
        string complaint;
        uint256 timestamp;
        bool resolved;
    }
    mapping(uint256 => User) private users;
    uint256 public totalUsers;
    event registercomplaint(address user, string complaint, uint256 timestamp);
    event resolvecomplaint(uint256 id, bool resolved);
    modifier onlyOwner() {
        require(owner == msg.sender, "not owner");
        _;
    }

    function register(string memory _complaint) public {
        totalUsers++;
        users[totalUsers] = User(
            msg.sender,
            _complaint,
            block.timestamp,
            false
        );
        emit registercomplaint(msg.sender, _complaint, block.timestamp);
    }

    function resolved(uint256 _id) public onlyOwner {
        require(!users[_id].resolved, "resolve");
        users[_id].resolved = true;
        emit resolvecomplaint(_id, true);
    }

    function getComplaints(uint256 _id)
        public
        view
        onlyOwner
        returns (
            string memory,
            address,
            bool
        )
    {
        require(_id > 0, "id cant be negative or zero");
        return (users[_id].complaint, users[_id].user, users[_id].resolved);
    }
}
