//
//  NetworkId.swift
//  KinSDK
//
//  Created by Kin Foundation
//  Copyright © 2017 Kin Foundation. All rights reserved.
//

import Foundation
import StellarKit

/**
 `NetworkId` represents the block chain network to which `KinClient` will connect.
 */
public enum NetworkId {
    /**
     A production node.
     */
    case mainNet

    /**
    The Stellar test net.
     */
    case testNet

    /**
     A network with a custom ID. **Currently unsupported**
     */
    case custom(issuer: String, stellarNetworkId: StellarKit.NetworkId)
}

extension NetworkId {
    public var issuer: String {
        switch self {
        case .mainNet:
            return ""
        case .testNet:
            return "GCKG5WGBIJP74UDNRIRDFGENNIH5Y3KBI5IHREFAJKV4MQXLELT7EX6V"
        case .custom (let issuer, _):
            return issuer
        }
    }

    public var stellarNetworkId: StellarKit.NetworkId {
        switch self {
        case .mainNet:
            return .main
        case .testNet:
            return .test
        case .custom(_, let stellarNetworkId):
            return stellarNetworkId
        }
    }
}

extension NetworkId: CustomStringConvertible {
    /// :nodoc:
    public var description: String {
        switch self {
        case .mainNet:
            return "main"
        case .testNet:
            return "test"
        default:
            return "custom network"
        }
    }
}

extension NetworkId: Equatable {
    public static func ==(lhs: NetworkId, rhs: NetworkId) -> Bool {
        switch lhs {
        case .mainNet:
            switch rhs {
            case .mainNet:
                return true
            default:
                return false
            }
        case .testNet:
            switch rhs {
            case .testNet:
                return true
            default:
                return false
            }
        default:
            return false
        }
    }
}
