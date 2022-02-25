// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;
/// @title Voting with delegation.
contract Ballot {   

    struct Voter{
        address voter_address;
        bool right;
        bool voted;
    }                                                                                                 
    
    struct Proposal{
       string  name;
       uint vcount;
    }
   
    address public chairperson;
    mapping(address=>Voter) voters;
    Proposal[] proposals;

    constructor(string [] memory proposalNames){  //Name of Candidates ["?","?"]

      chairperson=msg.sender;
      voters[chairperson].right=true;   //chairPerson Right to vote

        for (uint i = 0; i < proposalNames.length; i++) {
          
            proposals.push(
                           Proposal(
                           {
                           name: proposalNames[i],
                           vcount: 0
                           }
            ));
        }

    }

   function giveRightToVote(address voter) external 
    {
      require( msg.sender == chairperson, "Only chairperson can give right to vo");
      require( !voters[voter].voted, "The voter already voted.");
      require( !voters[voter].right ,"already have Right to vote");
     
      voters[voter].right = true; //Provide Right to Vote

    }

    function vote(uint proposal) external {
       require(voters[msg.sender].right, "Voter has not been given right to vote.");
       require(!voters[msg.sender].voted, "The voter already voted.");
       require(proposal<proposals.length, "Select a valid candidate");
       voters[msg.sender].voted = true;
       proposals[proposal].vcount += 1;
    }

    function winner() public view returns(string memory,uint){
        uint winnerVote=0;
        uint win ;
        
        for(uint i=0; i<proposals.length; i+=1){

            if(winnerVote < proposals[i].vcount){
                winnerVote = proposals[i].vcount;
                win = i;
            }
        }
        return (
                proposals[win].name,
                proposals[win].vcount
               );
    }

}