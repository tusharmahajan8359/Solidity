// SPDX-License-Identifier: GPL-3.0;
pragma solidity >=0.5.0<0.9.0;

//0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db

contract Bank{

  mapping(address=>uint) user;

  function deposit() payable public{
    user[msg.sender]+= msg.value;
  }
  function withdraw(uint e)  public returns(string memory)
  {
    uint amount=e*(10**18);
    require(address(msg.sender).balance>(amount), "Not enough balance");
    user[msg.sender]-=amount;
    payable(msg.sender).transfer(e*(10**18));
   
  return "sucessful withdraw";
  }
  function My_balance() public view returns(uint){
    return address(msg.sender).balance;
  }
  function MyBank_Wallet() public view returns(uint){
    return user[msg.sender];
  }
  function transfer(address user1 ,uint e) public  returns(string memory){
     
      uint amount=e*(10**18);
      require(address(msg.sender).balance>(amount) , "Not enough balance");
      user[msg.sender]-=amount;


      user[user1]+=amount;              //wallet to wallet
     //payable(user1).transfer(amount); // wallet to aur amount

    
   
    return " Transfer sucessful";
  }
}