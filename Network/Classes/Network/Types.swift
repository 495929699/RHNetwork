//
//  Types.swift
//
//  Created by 荣恒 on 2019/4/19.
//

import Foundation
import Alamofire

@_exported import Moya
@_exported import RxSwift


public typealias ReachabilityStatus = Alamofire.NetworkReachabilityManager.NetworkReachabilityStatus

/// 网络请求Key值, 外部可根据实际需求更改值
public struct NetworkConfigure {
    public private(set) static var code = "code"
    public private(set) static var message = "msg"
    public private(set) static var data = "data"
    public private(set) static var success = 200
    
    /// 替换默认的网络请求Key
    public static func replace(
        codeKey : String = NetworkConfigure.code,
        messageKey : String = NetworkConfigure.message,
        dataKey : String = NetworkConfigure.data,
        successKey : Int = NetworkConfigure.success) {
        self.code = codeKey
        self.message = messageKey
        self.data = dataKey
        self.success = successKey
    }
}

public extension Notification.Name {
    
    /// 服务器401通知
    static let networkService_401 = Notification.Name("network_service_401")
    
    /// 服务器402 - 499通知，接收时解析code的字段为："code"
    static let networkService_4XX = Notification.Name("network_service_4XX")
    
    /// 网路可达性改变通知
    static let reachabilityChanged = Notification.Name("reachabilityChanged")
    
}


/// 分页返回结果类型
public protocol PageList {
    associatedtype Value: Equatable
    /// 数据
    var items : [Value] { get }
    /// 总数
    var total : Int { get }
}


/// 通用网络错误
public enum NetworkError : Error {
    /// 网络错误
    case network(value : Error)
    /// 服务器错误
    case service(code : Int, message : String)
    /// 返回字段不是code,msg,data 格式
    case error(value : String)
    /// 空数据错误（codew == success,但是data字段无效或者为null）
    case emptyData
}

/// 缓存类型
public enum NetworkCacheType : Int {
    /// 缓存成功结果
    case cacheResponse
    /// 缓存失败任务
    case cacheRequest
    /// 不缓存
    case none
    
    /// 缓存错误请求的Key
    static var cacheRequestKey : String {
        return "Cache.error.cacheRequest"
    }
}
