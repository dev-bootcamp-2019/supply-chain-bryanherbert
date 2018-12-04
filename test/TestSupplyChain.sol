pragma solidity ^0.4.13;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/SupplyChain.sol";

contract TestSupplyChain {

    /*function testConstructor() {
        SupplyChain supplyChain = SupplyChain(DeployedAddresses.SupplyChain());

        uint expected_sku = 0;

        Assert.equal(supplyChain.skuCount(), expected_sku, "Sku count is not initialized to 0");
    }*/

    //State Variables
    SupplyChain supplyChain;
    Seller seller;
    Buyer buyer;
    uint skuCount;
    uint price;
    uint public initialBalance = 10 ether;

    function beforeAll(){
        //Setup - needs a constructor or a hook
        //Deploy SupplyChain, Seller and Buyer contracts
        supplyChain = new SupplyChain();
        seller = new Seller();
        buyer = new Buyer();
        address(buyer).transfer(initialBalance);
    }
    
    function testAddItem() {
        
        string memory name = "tuxedo t-shirt";
        price = 1 ether;
        skuCount = 0;
        uint state = 0;
        address itemSeller = address(seller);
        address itemBuyer = 0;

        //Have seller contract add item
        seller.addItem2supply(supplyChain, name, price);

        //store return values
        string memory a;
        uint b;
        uint c;
        uint d;
        address e;
        address f;
        
        (a, b, c, d, e, f) = supplyChain.fetchItem(skuCount);

        Assert.equal(a, name, "Name of last added item does not match expected value");
        Assert.equal(b, skuCount, "SKU count of last added item does not match expected value");
        Assert.equal(c, price, "Price of last added item does not match expected value");
        Assert.equal(d, state, "State of last added item does not match expected value");
        Assert.equal(e, itemSeller, "Seller of last added item does not match expected value");
        Assert.equal(f, itemBuyer, "Buyer of last added item is not 0");


    }

    // Test for failing conditions in this contracts
    // test that every modifier is working

    // buyItem
    
    function testBuyItem() {

        //Check account balances before transactions
        //Seller
        Assert.equal(address(seller).balance, 0 ether, "Seller's balance is not 0 ether");
        //Buyer
        Assert.equal(address(buyer).balance, 10 ether, "Buyer's balance does not match initial value");
        /*
        //Have buyer contract buy item
        buyer.buyItem(supplyChain, skuCount);

        //store return values
        string memory a;
        uint b;
        uint c;
        uint d;
        address e;
        address f;
        
        (a, b, c, d, e, f) = supplyChain.fetchItem(skuCount);

        Assert.equal(a, name, "Name of last added item does not match expected value");
        Assert.equal(b, skuCount, "SKU count of last added item does not match expected value");
        Assert.equal(c, price, "Price of last added item does not match expected value");
        Assert.equal(d, state, "State of last added item does not match expected value");
        Assert.equal(e, itemSeller, "Seller of last added item does not match expected value");
        Assert.equal(f, itemBuyer, "Buyer of last added item is not 0");*/


    }
    

    // test for failure if user does not send enough funds
    // test for purchasing an item that is not for Sale


    // shipItem

    // test for calls that are made by not the seller
    // test for trying to ship an item that is not marked Sold

    // receiveItem

    // test calling the function from an address that is not the buyer
    // test calling the function on an item not marked Shipped

     


}

contract Seller {

    function addItem2supply(SupplyChain _supplyChain, string _item, uint _price) public returns (bool) {
        
        return _supplyChain.addItem(_item, _price);
    }
}

contract Buyer {

    function buyItem(SupplyChain _supplyChain, uint _sku) public returns(bool){

        uint amount = 2 ether;
        
        _supplyChain.buyItem.value(amount)(_sku);

    }

    function() payable {

    }

}
