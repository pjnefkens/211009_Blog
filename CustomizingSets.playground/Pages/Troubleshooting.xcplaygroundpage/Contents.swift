import Foundation

// Base class for storing network flows in memory
class FMMFlowEntry : Hashable, CustomStringConvertible {
    var proto : String = ""
    var srcIP : String = ""
    var srcPort : Int = 0
    var dstIP : String = ""
    var dstPort : Int = 0
    var firstSeen : Date?
    var lastSeen : Date?
    
    static func == (lhs: FMMFlowEntry, rhs: FMMFlowEntry) -> Bool {
        let response = lhs.dstIP == rhs.dstIP && lhs.proto == rhs.proto && lhs.dstPort == rhs.dstPort && lhs.srcIP == rhs.srcIP && lhs.srcPort == rhs.srcPort
        return response
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(proto)
        hasher.combine(srcIP)
        hasher.combine(srcPort )
        hasher.combine(dstIP)
        hasher.combine(dstPort)
    }
    
    var description : String {
        let response : String = "\(proto) \(srcIP):\(srcPort) -> \(dstIP):\(dstPort)"
        return response
    }
    
    init(proto: String, srcIP: String, srcPort: Int, dstIP : String, dstPort: Int) {
        self.proto = proto
        self.srcIP = srcIP
        self.srcPort = srcPort
        self.dstIP = dstIP
        self.dstPort = dstPort
    }

}

// Class that represents a flow record based on source IP address and destination IP address
class FMMIPFlow  : FMMFlowEntry  {
    var refCount : Int = 1
    init(from: FMMFlowEntry) {
        super.init(proto : from.proto, srcIP : from.srcIP, srcPort : from.srcPort, dstIP : from.dstIP, dstPort : from.dstPort)

    }

    override public func hash(into hasher: inout Hasher) {
        hasher.combine(srcIP)
        hasher.combine(dstIP)
    }
    
    static func == (lhs: FMMIPFlow, rhs: FMMIPFlow) -> Bool {
        let response = lhs.dstIP == rhs.dstIP && lhs.srcIP == rhs.srcIP
        return response
    }
    override var description : String {
        let response : String = "\(srcIP) -> \(dstIP) [\(refCount)]"
        return response
    }
}

var uniqueIPFlows : Set<FMMIPFlow> = Set()
let flow1 = FMMFlowEntry(proto: "tcp", srcIP: "10.1.1.1", srcPort: 1024, dstIP: "10.1.1.2", dstPort: 80)
let flow4 = FMMFlowEntry(proto: "tcp", srcIP: "10.1.1.1", srcPort: 1055, dstIP: "10.1.1.2", dstPort: 80)

uniqueIPFlows.insert(FMMIPFlow(from: flow1))
uniqueIPFlows.insert(FMMIPFlow(from: flow4))
for flow in uniqueIPFlows {
    print(flow)
}


