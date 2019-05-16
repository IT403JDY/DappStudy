pragma solidity >=0.4.22 <0.6.0;

contract Vote{
     
    //structure //voting rate exc...
    struct candidator{
        string name;
        uint upVote;
    }
    
    //variable 
    bool live;
    address owner;
    candidator[] public candidatorList;
    
    //mapping 
    mapping(address => bool) Voted;
    
    //event // what to do? list (event brodcasting to other) 
    event addCandidatorEvent(string name); //candidator add success! bordcast
    event upVoteEvent(string candidator, uint upVoteCount);
    event finishVoteEvent(bool live);
    event votingEvent(address owner);
    //modifier //(=limiter)grant
    modifier onlyOwner{
        require(msg.sender == owner);
        _;
    }
    //constructor //create contract
    constructor() public{
        owner = msg.sender;
        live = true;
        
        emit votingEvent(owner);
    }
    
    // candidator
    function addCandidator(string memory _name)public onlyOwner{
        require(live == true);
        require(candidatorList.length < 5); //like if() use reason is that edther gas reduce 
        candidatorList.push(candidator(_name,0));
        
        //emit event
        emit addCandidatorEvent(_name);
        
    }
    
    // voting
    function upVote(uint _intdexOfCandidator) public{
        require(live == true);
        require(_intdexOfCandidator < candidatorList.length);
        require(Voted[msg.sender]==false);
        candidatorList[_intdexOfCandidator].upVote++;
        
        Voted[msg.sender] = true;
        //msg.sender is variable of solidity, it's value is massage sender address.
        emit upVoteEvent(candidatorList[_intdexOfCandidator].name, candidatorList[_intdexOfCandidator].upVote);
    }
    
    // finish vote
    function finishVote() public onlyOwner{
        require(live == true);
        live = false;
        
        emit finishVoteEvent(live);
    }
}


