//
//  StringExtensions.swift
//  URLSessionExample
//
//  Created by Artem Mushtakov on 05.02.2022.
//

import Foundation
import CryptoKit

extension String {
    func md5() -> String {
        return Insecure.MD5.hash(data: self.data(using: .utf8) ?? Data()).map { String(format: "%02hhx", $0) }.joined()
    }
}
