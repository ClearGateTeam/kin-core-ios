//
//  KinMisc.swift
//  KinSDK
//
//  Created by Kin Foundation
//  Copyright © 2017 Kin Foundation. All rights reserved.
//

import Foundation
import StellarKit

/**
 A protocol to encapsulate the formation of the endpoint `URL` and the `NetworkId`.
 */
public protocol ServiceProvider {
    /**
     The `URL` of the block chain node.
     */
    var url: URL { get }

    /**
     The `NetworkId` to be used.
     */
    var networkId: NetworkId { get }
}

public typealias Balance = Decimal
public typealias TransactionId = String

/**
 Closure type used by the send transaction API upon completion, which contains a `TransactionId` in
 case of success, or an error in case of failure.
 */
public typealias TransactionCompletion = (TransactionId?, Error?) -> Void

/**
 Closure type used by the balance API upon completion, which contains the `Balance` in case of
 success, or an error in case of failure.
 */
public typealias BalanceCompletion = (Balance?, Error?) -> Void

public enum AccountStatus {
    case notCreated
    case notActivated
    case activated
}

public struct PaymentInfo {
    private let txInfo: TxInfo
    private let account: String
    private let asset: Asset

    public var createdAt: String {
        return txInfo.createdAt
    }

    public var credit: Bool {
        return account == destination
    }

    public var debit: Bool {
        return !credit
    }

    public var source: String {
        return txInfo.payments.filter({ $0.asset == asset }).first?.source ?? txInfo.source
    }

    public var hash: String {
        return txInfo.hash
    }

    public var amount: Decimal {
        return txInfo.payments.filter({ $0.asset == asset }).first?.amount ?? Decimal(0)
    }

    public var destination: String {
        return txInfo.payments.filter({ $0.asset == asset }).first?.destination ?? ""
    }

    public var memoText: String? {
        return txInfo.memoText
    }

    public var memoData: Data? {
        return txInfo.memoData
    }

    public var sequence: UInt64 {
        return txInfo.sequence
    }

    init(txInfo: TxInfo, account: String, asset: Asset) {
        self.txInfo = txInfo
        self.account = account
        self.asset = asset
    }
}

