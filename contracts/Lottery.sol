// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import "@chainlink/contracts/src/v0.8/vrf/VRFConsumerBaseV2.sol";

error Raffle_NotEnoughEntranceFee();

contract Lottery is VRFConsumerBaseV2 {
    /* Variables */
    uint256 immutable i_entranceFee;
    address[] private s_players;

    /* Events */
    event raffleEntered(address indexed player);

    constructor(address vrfCoordinatorV2, uint256 entranceFee) VRFConsumerBaseV2(vrfCoordinatorV2) {
        i_entranceFee = entranceFee;
    }

    function enterRaffle() public payable {
        if (msg.value > i_entranceFee) {
            revert Raffle_NotEnoughEntranceFee();
        }
        s_players.push(payable(msg.sender));
        emit raffleEntered(msg.sender);
    }

    function requestRandomWinner() external {}

    function fulfillRandomWords(
        uint256 requestId,
        uint256[] memory randomWords
    ) internal override {}

    function getEntranceFee() public view returns (uint256) {
        return i_entranceFee;
    }

    function getPlayers(uint256 index) public view returns (address) {
        return s_players[index];
    }
}
