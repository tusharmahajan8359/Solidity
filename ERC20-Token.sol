// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.5.0<0.9.0;

interface ERC20{

function totalSupply() external view returns(uint256);
function balanceOf(address tokenOwner) external view returns(uint256);
function transfer(address _to,uint value) external  returns(bool);
function allowence(address _owner ,address _spender) external view returns(uint256);
function approve(address _spender,uint value) external returns(bool);
function TransferFrom(address _from,address _to,uint value)external returns(bool);
event Transfer(address indexed from,address indexed to,uint value);
event  Approve(address indexed from,address indexed to,uint value);

}

contract MyToken is ERC20{

 uint  totalTokenSupply; 
 string public  Name;
 string public Symbol;
 address public owner;
 mapping(address=>uint) balances;
 mapping(address=>mapping(address=>uint)) allowed;

 constructor(string memory _name,string memory _symbol,uint _totalSupply)public {
     Name=_name;
     Symbol=_symbol;
     owner=msg.sender;
     
    totalTokenSupply=_totalSupply;
    balances[msg.sender]=_totalSupply;
 }

 function totalSupply() public override view returns(uint256){

     return totalTokenSupply;

 }   
 function balanceOf(address tokenOwner) public override view returns(uint256){
  
   return balances[tokenOwner];

 }
 function transfer(address Receiver,uint numOfToken) public override returns(bool){
   
   require(numOfToken<=balances[msg.sender],"Not enough balance");
   balances[msg.sender]-=numOfToken;
   balances[Receiver]+=numOfToken;
   emit Transfer(msg.sender,Receiver,numOfToken);
   return true;

 }

 function allowence(address _owner ,address _spender) public override view returns(uint256){
   return allowed[_owner][_spender];
 }

 function approve(address _spender,uint value) public override returns(bool){
  allowed[msg.sender][_spender]=value;
   emit Approve(msg.sender,_spender,value);
   return true;
 }

 function TransferFrom(address _from,address _to,uint value)public override returns(bool){
     require(value<=allowed[_from][msg.sender],"Not enough balance");
     allowed[_from][msg.sender]-=value;
     balances[_from]-=value;
     balances[_to]+=value;
     emit Transfer(_from,_to,value);
     return true;
 }
}