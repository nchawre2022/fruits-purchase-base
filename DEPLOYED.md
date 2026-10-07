# Deployment

Network: Base mainnet (chain id 8453)
Owner: 0x7acd78cb19fae5e2d0905713eb0021c3de425c17

## Contracts

| Address | Notes |
| --- | --- |
| 0x419B93Fd505911D0B26623934F4bFeCb604174af | First deploy. Stub only: owner, fruits, nextFruitId. No listFruit. |
| 0xc59…8FC5 | Full contract. listFruit(Apple, 20000000000000, 10) succeeded, value 0. |
| 0x862…f3296 | Full contract. withdraw to owner succeeded, value 0. No purchase recorded on this copy. |

Price used: 20000000000000 wei = 0.00002 ETH.

## Calls that worked

- listFruit on 0xc59…8FC5, block 52300732, tx 0x802…ab0a2, value 0 wei
- withdraw on 0x862…f3296, block 52300942, tx 0x90b…9cdfb, value 0 wei

buyFruit still needs Value set to 0.00002 ETH on the same contract that listed the fruit.
