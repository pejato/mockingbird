//
//  VariadicParametersTests.swift
//  MockingbirdTests
//
//  Created by Andrew Chang on 8/21/19.
//  Copyright © 2019 Bird Rides, Inc. All rights reserved.
//

import XCTest
import Mockingbird
@testable import MockingbirdTestsHost

class VeriadicParametersTests: XCTestCase {
  
  var mock: VariadicProtocolMock!
  
  override func setUp() {
    mock = VariadicProtocolMock()
  }
  
  func callVariadicStringsMethod(on object: VariadicProtocol) {
    object.variadicMethod(objects: "a", "b", "c", param2: 1)
  }
  func callVariadicBoolsMethod(on object: VariadicProtocol) {
    object.variadicMethod(objects: true, false, true, param2: 1)
  }
  func callVariadicReturningMethod(on object: VariadicProtocol) -> Bool {
    return object.variadicReturningMethod(objects: true, false, true, param2: 1)
  }
  
  func testVariadicMethod_calledWithStrings_usingStrictMatching() {
    callVariadicStringsMethod(on: mock)
    verify(self.mock.variadicMethod(objects: "a", "b", "c", param2: 1)).wasCalled()
  }
  func testVariadicMethod_calledWithStrings_usingWildcardMatching() {
    callVariadicStringsMethod(on: mock)
    verify(self.mock.variadicMethod(objects: any([String].self), param2: 1)).wasCalled()
  }
  
  func testVariadicMethod_calledWithBools_usingStrictMatching() {
    callVariadicBoolsMethod(on: mock)
    verify(self.mock.variadicMethod(objects: true, false, true, param2: 1)).wasCalled()
  }
  func testVariadicMethod_calledWithBools_usingWildcardMatching() {
    callVariadicBoolsMethod(on: mock)
    verify(self.mock.variadicMethod(objects: any([Bool].self), param2: 1)).wasCalled()
  }
  
  func testVariadicReturningMethod_calledWithBools_usingStrictMatching() {
    given(self.mock.variadicReturningMethod(objects: true, false, true, param2: 1)) ~> true
    XCTAssertTrue(callVariadicReturningMethod(on: mock))
    verify(self.mock.variadicReturningMethod(objects: true, false, true, param2: 1)).wasCalled()
  }
  func testVariadicReturningMethod_calledWithBools_usingWildcardMatching() {
    given(self.mock.variadicReturningMethod(objects: any(), param2: 1)) ~> true
    XCTAssertTrue(callVariadicReturningMethod(on: mock))
    verify(self.mock.variadicReturningMethod(objects: any(), param2: 1)).wasCalled()
  }
}
