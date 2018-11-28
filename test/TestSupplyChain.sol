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

    function testAddItem() {
        SupplyChain supplyChain = new SupplyChain();
        Seller seller = new Seller();
        
        string memory name = "tuxedo t-shirt";
        uint price = 5;
        uint skuCount = 0;
        //change to an enum
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

        Assert.equal(a, name, "Seller function did not work");
        Assert.equal(b, skuCount, "Seller function did not work");
        Assert.equal(c, price, "Seller function did not work");
        Assert.equal(d, state, "Seller function did not work");
        Assert.equal(e, itemSeller, "Seller function did not work");
        Assert.equal(f, itemBuyer, "Seller function did not work");


    }

    // Test for failing conditions in this contracts
    // test that every modifier is working

    // buyItem

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
