import Foundation

// Basic Network Fow struct used as data structure
struct FMMFlowEntry : Hashable {
    var proto : String // Protocol
    var srcIP : String // source IP
    var srcPort : Int
    var dstIP : String // destination IP
    var dstPort : Int
    var firstSeen : Date?
    var lastSeen : Date?
    
}

let flow1 = FMMFlowEntry(proto: "tcp", srcIP: "10.1.1.1", srcPort: 1024, dstIP: "10.1.1.2", dstPort: 80)
let flow2 = FMMFlowEntry(proto: "tcp", srcIP: "10.1.1.20", srcPort: 1024, dstIP: "10.1.1.2", dstPort: 80)
let flow3 = FMMFlowEntry(proto: "tcp", srcIP: "10.1.1.8", srcPort: 1024, dstIP: "10.1.1.2", dstPort: 80)
let flow4 = FMMFlowEntry(proto: "tcp", srcIP: "10.1.1.1", srcPort: 1055, dstIP: "10.1.1.2", dstPort: 80)
var allFlows : Set<FMMFlowEntry> = Set()
allFlows.insert(flow1)
allFlows.insert(flow3)
allFlows.insert(flow4)

print("Set contains flow1: \(allFlows.contains(flow1))")
print("Set contains flow2: \(allFlows.contains(flow2))")
