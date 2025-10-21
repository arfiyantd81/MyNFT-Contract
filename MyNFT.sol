// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

/// @title Simple NFT Contract for Base Network
contract MyNFT {
    string public name = "NFTCollection";
    string public symbol = "BNFT"; // ✅ Ticker diganti
    uint256 public totalSupply;

    mapping(uint256 => address) private _owners;
    mapping(address => uint256) private _balances;
    mapping(uint256 => string) private _tokenURIs;

    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);

    function balanceOf(address owner) public view returns (uint256) {
        require(owner != address(0), "Zero address not valid");
        return _balances[owner];
    }

    function ownerOf(uint256 tokenId) public view returns (address) {
        address owner = _owners[tokenId];
        require(owner != address(0), "Token doesn't exist");
        return owner;
    }

    function tokenURI(uint256 tokenId) public view returns (string memory) {
        require(_owners[tokenId] != address(0), "Token doesn't exist");
        return _tokenURIs[tokenId];
    }

    function mint(address to, string memory uri) public returns (uint256) {
        require(to != address(0), "Zero address not valid");
        uint256 tokenId = totalSupply + 1;
        totalSupply = tokenId;

        _owners[tokenId] = to;
        _balances[to] += 1;
        _tokenURIs[tokenId] = uri;

        emit Transfer(address(0), to, tokenId);
        return tokenId;
    }

    function transferFrom(address from, address to, uint256 tokenId) public {
        require(from == _owners[tokenId], "Not owner");
        require(to != address(0), "Zero address not valid");

        _balances[from] -= 1;
        _balances[to] += 1;
        _owners[tokenId] = to;

        emit Transfer(from, to, tokenId);
    }
}
