// SPDX-License-Identifier: GPL-3.0;
 
pragma solidity >=0.5.0<0.9.0;

contract Bank{

  mapping(address=>uint) user;

  function deposit() payable public{
    user[msg.sender]+= msg.value;
  }
  function withdraw(uint e)  public returns(string memory)
  {
   if(address(msg.sender).balance<(e*(10**18)))
   {
     return "Not enough balance";
   }
   else
   {
    payable(msg.sender).transfer(e*(10**18));
   }
  return "sucessful withdraw";
  }
  function My_balance() public view returns(uint){
    return address(msg.sender).balance;
  }
  function Bank_Wallet() public view returns(uint){
    return address(this).balance;
  }
  function transfer(address user1 ,uint e) public  returns(string memory){
   

    if(address(msg.sender).balance<(e*(10**18)))
   {
     return "Not enough balance";
   }
   else
   {
    payable(user1).transfer(e*(10**18));
   }
    return " Transfer sucessful";
  }
}