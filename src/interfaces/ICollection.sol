// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity ^0.8.19;

interface ICollections {
    // Event declarations
    event CollectionAdded(string ipfsPointer, bytes32 key, bool featured, address creatorAddress);
    event CollectionUpdated(string ipfsPointer, bytes32 key, bool featured, address creatorAddress);
    event UserCollectionAdded(string ipfsPointer, bytes32 key, bool featured, address creatorAddress);
    event UserCollectionUpdated(string ipfsPointer, bytes32 key, bool featured, address creatorAddress);
    event CollectionFeatured(string ipfsPointer, bytes32 key, bool featured, address creatorAddress);

    // Struct declaration (optional in interfaces depending on the compiler and usage context)
    struct Collection {
        string ipfsPointer;
        bytes32 key;
        bool featured;
        address creatorAddress;
    }

    // Function declarations
    function addCollection(Collection memory _collection) external;
    function updateCollection(Collection memory _collection) external;
    function addUserCollection(Collection memory _collection) external;
    function updateUserCollection(Collection memory _collection) external;
    function featureCollection(bytes32 _key, bool _isFeatured) external;
}
