//
//  vmgitTest.swift
//  vmgitTest
//
//  Created by joon-ho kil on 4/22/19.
//  Copyright © 2019 길준호. All rights reserved.
//

import XCTest

class vmgitTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testInit () {
        var git = Git()
        XCTAssertEqual(git.command("init document"), "created document repository.")
        XCTAssertTrue(git.repositoryNames.contains("document"))
        XCTAssertEqual(git.command("init a b c"), "repository 이름에 공백이 들어갈 수 없습니다")
        XCTAssertFalse(git.repositoryNames.contains("a b c"), "repository 이름에 공백이 들어갈 수 없습니다.")
    }
    
    func testStatus () {
        var git = Git()
        git.command("init document")
        XCTAssertEqual(git.command("status"), "document/")
        XCTAssertEqual(git.command("status local no"), "document/")
        XCTAssertEqual(git.command("status local document"), "아직 파일이 없습니다.")
    }
    
    func testCheckout () {
        var git = Git()
        git.command("checkout document")
        XCTAssertEqual(git.currentRepository, "")
        git.command("init document")
        git.command("checkout document")
        XCTAssertEqual(git.currentRepository, "document")
        git.command("checkout abc")
        XCTAssertEqual(git.currentRepository, "")
        git.command("checkout document")
        XCTAssertEqual(git.currentRepository, "document")
        git.command("checkout")
        XCTAssertEqual(git.currentRepository, "")
    }
    
    func testNew () {
        var git = Git()
        XCTAssertNotEqual(git.command("init document"), "잘못된 명령어입니다.")
        XCTAssertNotEqual(git.command("checkout document"), "잘못된 명령어입니다.")
        XCTAssertNotEqual(git.command("new readme"), "잘못된 명령어입니다.")
        let fileName = git.workingDirectory["document"]
        XCTAssertNotNil(fileName)
        XCTAssertTrue(fileName?.contains("readme") ?? false)
    }
}

