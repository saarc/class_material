
testcc(){
    setGlobals 0 1
    peer chaincode install -n marblesp -v 1.0 -p github.com/chaincode/marbles02_private/go/

    setGlobals 1 1
    peer chaincode install -n marblesp -v 1.0 -p github.com/chaincode/marbles02_private/go/

    setGlobals 0 2
    peer chaincode install -n marblesp -v 1.0 -p github.com/chaincode/marbles02_private/go/

    setGlobals 1 2
    peer chaincode install -n marblesp -v 1.0 -p github.com/chaincode/marbles02_private/go/

    setGlobals 0 1
    peer chaincode instantiate -o orderer.example.com:7050 --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem -C mychannel -n marblesp -v 1.0 -c '{"Args":["init"]}' -P "OR('Org1MSP.member','Org2MSP.member')" --collections-config  /opt/gopath/src/github.com/chaincode/marbles02_private/collections_config.json

    sleep 5
    MARBLE=$(echo -n "{\"name\":\"marble1\",\"color\":\"blue\",\"size\":35,\"owner\":\"tom\",\"price\":99}" | base64 | tr -d \\n)
    peer chaincode invoke -o orderer.example.com:7050 --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem -C mychannel -n marblesp -c '{"Args":["initMarble"]}' --transient "{\"marble\":\"$MARBLE\"}"

    sleep 5

    peer chaincode query -C mychannel -n marblesp -c '{"Args":["readMarble","marble1"]}'

    peer chaincode query -C mychannel -n marblesp -c '{"Args":["readMarblePrivateDetails","marble1"]}'

    MARBLE_OWNER=$(echo -n "{\"name\":\"marble1\",\"owner\":\"joe\"}" | base64 | tr -d \\n)
    peer chaincode invoke -o orderer.example.com:7050 --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem -C mychannel -n marblesp -c '{"Args":["transferMarble"]}' --transient "{\"marble_owner\":\"$MARBLE_OWNER\"}"

    sleep 5

    MARBLE_OWNER=$(echo -n "{\"name\":\"marble1\",\"owner\":\"tom\"}" | base64 | tr -d \\n)
    peer chaincode invoke -o orderer.example.com:7050 --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem -C mychannel -n marblesp -c '{"Args":["transferMarble"]}' --transient "{\"marble_owner\":\"$MARBLE_OWNER\"}"

    sleep 5

    MARBLE_OWNER=$(echo -n "{\"name\":\"marble1\",\"owner\":\"jerry\"}" | base64 | tr -d \\n)
    peer chaincode invoke -o orderer.example.com:7050 --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem -C mychannel -n marblesp -c '{"Args":["transferMarble"]}' --transient "{\"marble_owner\":\"$MARBLE_OWNER\"}"

    sleep 5

    MARBLE_OWNER=$(echo -n "{\"name\":\"marble1\",\"owner\":\"choi\"}" | base64 | tr -d \\n)
    peer chaincode invoke -o orderer.example.com:7050 --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem -C mychannel -n marblesp -c '{"Args":["transferMarble"]}' --transient "{\"marble_owner\":\"$MARBLE_OWNER\"}"

    sleep 5

    peer chaincode query -C mychannel -n marblesp -c '{"Args":["readMarblePrivateDetails","marble1"]}'

}