pragma solidity ^0.4.17;

contract Lottery {
    address public manager;
    address[] public players;
    
    modifier isManager() {
        require(msg.sender == manager);
        _;
    }
    
    function Lottery() public {
        manager = msg.sender;
    }
    
    function enter() public payable {
        require(msg.value > .01 ether);
        players.push(msg.sender);
    }
    
    function random() private view returns (uint) {
        return uint(keccak256(block.difficulty, block.timestamp, players));
    }
    
    function pickWinner() public isManager() {
        uint index = random() % players.length;
        players[index].transfer(address(this).balance);
        players = new address[](0);
    }
    
    function getPlayers() public view returns (address[]) {
        return players;
    }
}