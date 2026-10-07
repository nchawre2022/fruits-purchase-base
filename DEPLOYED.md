# Deployment

Network: Base mainnet (chain id 8453)
Contract: FruitsPurchase
Address: 0x419B93Fd505911D0B26623934F4bFeCb604174af
Explorer: https://base.blockscout.com/address/0x419B93Fd505911D0B26623934F4bFeCb604174af
Status: deployed, balance 0 ETH (no purchase yet)

## Next calls in Remix

Environment: Injected Provider - MetaMask, network Base mainnet.
At the bottom of Deploy & Run, paste the address into "At Address" and load FruitsPurchase. Do not deploy again.

1. listFruit (Value = 0), from the owner wallet:
   - name: Apple
   - priceWei: 20000000000000
   - stock: 10
   That price is 0.00002 ETH.

2. buyFruit, from any wallet with Base ETH:
   - fruitId: 0
   - quantity: 1
   - Value: 0.00002 ETH

3. Owner withdraw(yourAddress) to take the contract balance.
