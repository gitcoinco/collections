// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity ^0.8.19;

contract Collections {
    error OnlyCreatorCanCallThisFunction();
    error CollectionDoesNotExist();

    // Index this event
    event CollectionAdded(string ipfsPointer, bytes32 key, bool featured, address creatorAddress);
    event CollectionUpdated(string ipfsPointer, bytes32 key, bool featured, address creatorAddress);
    event UserCollectionAdded(string ipfsPointer, bytes32 key, bool featured, address creatorAddress);
    event UserCollectionUpdated(string ipfsPointer, bytes32 key, bool featured, address creatorAddress);
    event CollectionFeatured(string ipfsPointer, bytes32 key, bool featured, address creatorAddress);

    // Collection
    struct Collection {
        string ipfsPointer;
        bytes32 key; // Type of data being published
        bool featured;
        address creatorAddress;
    }

    // key => Collection
    mapping(bytes32 => Collection) public userCollections;

    // key => Collection
    mapping(bytes32 => Collection) public featuredCollections;

    // creatorAddress => key[]
    mapping(address => bytes32[]) public userCollectionsList;

    /// @dev Throws if called by any account other than the creator
    /// @param _key The key of the collection
    modifier onlyCreator(bytes32 _key) {
        if (userCollections[_key].creatorAddress == msg.sender) revert OnlyCreatorCanCallThisFunction();
        _;
    }

    constructor() { }

    function addCollection(Collection memory _collection) public {
        userCollections[_collection.key] = _collection;

        emit CollectionAdded(_collection.ipfsPointer, _collection.key, false, _collection.creatorAddress);
    }

    function updateCollection(Collection memory _collection) public onlyCreator(_collection.key) {
        userCollections[_collection.key] = _collection;

        emit CollectionUpdated(_collection.ipfsPointer, _collection.key, false, _collection.creatorAddress);
    }

    function addUserCollection(Collection memory _collection) public onlyCreator(_collection.key) {
        userCollectionsList[_collection.creatorAddress].push(_collection.key);

        emit UserCollectionAdded(_collection.ipfsPointer, _collection.key, false, _collection.creatorAddress);
    }

    function updateUserCollection(Collection memory _collection) public onlyCreator(_collection.key) {
        userCollections[_collection.key] = _collection;

        emit UserCollectionUpdated(_collection.ipfsPointer, _collection.key, false, _collection.creatorAddress);
    }

    // todo: add some sort of restrictions to this function
    function featureCollection(bytes32 _key, bool _isFeatured) public {
        if (_isFeatured) {
            // require that the collection exists
            if (userCollections[_key].creatorAddress == address(0)) revert CollectionDoesNotExist();

            Collection memory _collection = userCollections[_key];

            featuredCollections[_key] = _collection;

            emit CollectionFeatured(_collection.ipfsPointer, _collection.key, true, _collection.creatorAddress);
        }

        // remove from featured
        delete featuredCollections[_key];
    }
}