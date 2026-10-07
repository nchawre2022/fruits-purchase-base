// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/// @title FruitsPurchase
/// @notice Simple fruit shop on Base. Owner lists fruit; buyers pay native ETH.
/// @dev Deploy on Base Sepolia (84532) first, then Base mainnet (8453).
contract FruitsPurchase {
    address public owner;

    struct Fruit {
        string name;
        uint256 priceWei;
        uint256 stock;
        bool listed;
    }

    uint256 public nextFruitId;
    mapping(uint256 => Fruit) public fruits;

    event FruitListed(uint256 indexed fruitId, string name, uint256 priceWei, uint256 stock);
    event FruitUpdated(uint256 indexed fruitId, uint256 priceWei, uint256 stock, bool listed);
    event FruitPurchased(
        uint256 indexed fruitId,
        address indexed buyer,
        uint256 quantity,
        uint256 paidWei
    );
    event Withdrawn(address indexed to, uint256 amountWei);

    error NotOwner();
    error InvalidFruit();
    error NotListed();
    error InsufficientStock();
    error WrongPayment();
    error ZeroQuantity();
    error TransferFailed();

    modifier onlyOwner() {
        if (msg.sender != owner) revert NotOwner();
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function listFruit(string calldata name, uint256 priceWei, uint256 stock)
        external
        onlyOwner
        returns (uint256 fruitId)
    {
        if (bytes(name).length == 0 || priceWei == 0) revert InvalidFruit();
        fruitId = nextFruitId++;
        fruits[fruitId] = Fruit({name: name, priceWei: priceWei, stock: stock, listed: true});
        emit FruitListed(fruitId, name, priceWei, stock);
    }

    function updateFruit(uint256 fruitId, uint256 priceWei, uint256 stock, bool listed) external onlyOwner {
        Fruit storage fruit = fruits[fruitId];
        if (bytes(fruit.name).length == 0 || priceWei == 0) revert InvalidFruit();
        fruit.priceWei = priceWei;
        fruit.stock = stock;
        fruit.listed = listed;
        emit FruitUpdated(fruitId, priceWei, stock, listed);
    }

    /// @notice Buy `quantity` of a listed fruit. Send exactly priceWei * quantity.
    function buyFruit(uint256 fruitId, uint256 quantity) external payable {
        if (quantity == 0) revert ZeroQuantity();
        Fruit storage fruit = fruits[fruitId];
        if (bytes(fruit.name).length == 0) revert InvalidFruit();
        if (!fruit.listed) revert NotListed();
        if (fruit.stock < quantity) revert InsufficientStock();

        uint256 cost = fruit.priceWei * quantity;
        if (msg.value != cost) revert WrongPayment();

        fruit.stock -= quantity;
        emit FruitPurchased(fruitId, msg.sender, quantity, msg.value);
    }

    function withdraw(address payable to) external onlyOwner {
        uint256 amount = address(this).balance;
        (bool ok, ) = to.call{value: amount}("");
        if (!ok) revert TransferFailed();
        emit Withdrawn(to, amount);
    }

    function quote(uint256 fruitId, uint256 quantity) external view returns (uint256 costWei) {
        Fruit memory fruit = fruits[fruitId];
        if (bytes(fruit.name).length == 0) revert InvalidFruit();
        costWei = fruit.priceWei * quantity;
    }
}
