// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract HotelRoom {

//Vacant
//Occupied
enum Status { Vacant, Occupied}
Status currStatus;

event Occupy(address _occupant, uint _value);

address payable public owner;

constructor()  {
     owner = payable(msg.sender);
    currStatus =  Status.Vacant;
}

modifier onlyWhileVacant{
require(currStatus == Status.Vacant, "Currently Occupied");
_;
}

modifier costs(uint _amt){
require(msg.value >= _amt, "Not enough ether provided");
_;
}

// function bookHotel() payable onlyWhileVacant costs(2 ether){
//     //check price and check status
    
//     // require(msg.value >= 2 ether, "Not enough ether provided");
//     owner.transfer(msg.value);
//     currStatus= Status.Occupied;
//     emit Occupy(msg.sender, msg.value)
// }


receive() external payable onlyWhileVacant costs(2 ether) {
    //check price and check status
    
    // require(msg.value >= 2 ether, "Not enough ether provided");
    owner.transfer(msg.value);
    currStatus= Status.Occupied;
    emit Occupy(msg.sender, msg.value);
}


}