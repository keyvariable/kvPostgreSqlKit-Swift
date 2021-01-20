//===----------------------------------------------------------------------===//
//
//  Copyright (c) 2021 Svyatoslav Popov.
//
//  Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with
//  the License. You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on
//  an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the
//  specific language governing permissions and limitations under the License.
//
//  SPDX-License-Identifier: Apache-2.0
//
//===----------------------------------------------------------------------===//
//
//  KvPostgreSqlKitTests.swift
//  kvPostgreSqlKit
//
//  Created by Svyatoslav Popov on 17.04.2020.
//

import XCTest

@testable import kvPostgreSqlKit



final class KvPostgreSqlKitTests : XCTestCase {

    static var allTests = [
        ("default", testApplication),
    ]



    func testApplication() {
        do {
            let db = try KvPostgreSQL(with: .init(credential: .init(user: NSUserName())))

            let expectation = XCTestExpectation(description: "PostgreSQL version")
            defer { wait(for: [expectation], timeout: 10.0) }

            let statement = try db.prepared("SELECT version()")

            statement.execute { (result) in
                do {
                    try IteratorSequence(result.get()).forEach { row in
                        print(try row.get())
                    }

                } catch {
                    XCTFail(error.localizedDescription)
                }

                expectation.fulfill()
            }

        } catch {
            XCTFail(error.localizedDescription)
        }
    }

}
