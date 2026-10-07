# Fruits Purchase (Base)

Simple Solidity shop: the owner lists fruit, buyers pay native ETH on Base.

## Networks

| Network | Chain ID | RPC |
| --- | --- | --- |
| Base Sepolia (test) | 84532 | https://sepolia.base.org |
| Base mainnet | 8453 | https://mainnet.base.org |

Use Sepolia first. Faucet: https://www.alchemy.com/faucets/base-sepolia

## Deploy on Remix

1. Open https://remix.ethereum.org
2. Create `contracts/FruitsPurchase.sol` and paste `contracts/FruitsPurchase.sol`.
3. Compiler: Solidity `0.8.24` or newer, click Compile.
4. Deploy & Run Transactions:
   - Environment: Injected Provider - MetaMask
   - MetaMask network: Base Sepolia (chain id 84532)
   - Contract: `FruitsPurchase`
   - Click Deploy and confirm in MetaMask
5. After deploy, copy the contract address. Verify on https://sepolia.basescan.org

### Try it

Prices are in wei. `0.001 ether` = `1000000000000000` wei.

1. `listFruit` — name `Apple`, priceWei `1000000000000000`, stock `10`
2. Switch MetaMask to a buyer account
3. `buyFruit` — fruitId `0`, quantity `2`, and set Value to `0.002` ETH
4. Owner calls `withdraw` with their address to take the shop balance

## Functions

- `listFruit(name, priceWei, stock)` — owner only
- `updateFruit(fruitId, priceWei, stock, listed)` — owner only
- `buyFruit(fruitId, quantity)` — payable, exact ETH
- `withdraw(to)` — owner only
- `quote(fruitId, quantity)` — view cost
- `fruits(id)` — public getter

## License

MIT
