// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract Escrow {
	address payable public arbiter;
	address payable public beneficiary;
	address payable public depositor;

	bool public isApproved;

	constructor(address _arbiter, address _beneficiary) payable {
		arbiter = payable (_arbiter);
		beneficiary = payable(_beneficiary);
		depositor = payable(msg.sender);
	}

	event Approved(uint);

    function getBalance() external view returns (uint) {
        return address(this).balance;
    }

	function approve() external payable{
		require(msg.sender == arbiter);
		uint balance = address(this).balance;
        uint amount = msg.value * 1 ether;
		(bool sent, bytes memory data ) = payable(beneficiary).call{value: msg.value}("");
 		require(sent, "Failed to send Ether");
		emit Approved(balance);
		isApproved = true;
	}
}