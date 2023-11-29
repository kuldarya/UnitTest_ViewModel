//
//  UnitTestingViewModel_Tests.swift
//  UnitTestingTests
//
//  Created by Darya Kuliashova on 23/11/2023.
//

import XCTest
@testable import UnitTesting

final class UnitTestingViewModel_Tests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }
    
    func test_UnitTestingViewModel_isPremium_shouldBeTrue() {
        // Given
        let isPremium: Bool = true
        
        // When
        let vm = UnitTestingViewModel(isPremium: isPremium)
        
        // Then
        XCTAssertTrue(vm.isPremium)
    }
    
    func test_UnitTestingViewModel_isPremium_shouldBeFalse() {
        // Given
        let isPremium: Bool = false
        
        // When
        let vm = UnitTestingViewModel(isPremium: isPremium)
        
        // Then
        XCTAssertFalse(vm.isPremium)
    }
    
    func test_UnitTestingViewModel_isPremium_shouldBeInjectedValue() {
        // Given
        let userIsPremium: Bool = Bool.random()
        
        // When
        let vm = UnitTestingViewModel(isPremium: userIsPremium)
        
        // Then
        XCTAssertEqual(vm.isPremium, userIsPremium)
    }
    
    func test_UnitTestingViewModel_isPremium_shouldBeInjectedValue_stressTest() {
        for _ in 0..<10 {
            // Given
            let userIsPremium: Bool = Bool.random()
            
            // When
            let vm = UnitTestingViewModel(isPremium: userIsPremium)
            
            // Then
            XCTAssertEqual(vm.isPremium, userIsPremium)
        }
    }
    
    func test_UnitTestingViewModel_dataArray_shouldBeEmpty() {
        // Given
        
        // When
        let vm = UnitTestingViewModel(isPremium: Bool.random())
        
        // Then
        XCTAssertTrue(vm.dataArray.isEmpty)
        XCTAssertEqual(vm.dataArray.count, 0)
    }
    
    func test_UnitTestingViewModel_dataArray_shouldAddItem() {
        // Given
        let vm = UnitTestingViewModel(isPremium: Bool.random())
        
        // When
        vm.addItem(item: "Hello")
        
        // Then
        XCTAssertTrue(!vm.dataArray.isEmpty)
        XCTAssertFalse(vm.dataArray.isEmpty)
        XCTAssertEqual(vm.dataArray.count, 1)
        XCTAssertNotEqual(vm.dataArray.count, 0)
        XCTAssertGreaterThan(vm.dataArray.count, 0)
    }
    
    func test_UnitTestingViewModel_dataArray_shouldNotAddBlankString() {
        // Given
        let vm = UnitTestingViewModel(isPremium: Bool.random())
        
        // When
        vm.addItem(item: "")
        
        // Then
        XCTAssertTrue(vm.dataArray.isEmpty)
    }
    
    func test_UnitTestingViewModel_dataArray_shouldAddMoreThanOneItem() {
        // Given
        let vm = UnitTestingViewModel(isPremium: Bool.random())
        
        // When
        let loopCount: Int = Int.random(in: 0..<100)
        for _ in 0..<loopCount {
            vm.addItem(item: "Hello")
        }
        
        // Then
        XCTAssertEqual(vm.dataArray.count, loopCount)
    }
    
    func test_UnitTestingViewModel_dataArray_shouldNotAddEmptyString() {
        // Given
        let vm = UnitTestingViewModel(isPremium: Bool.random())
        
        // When
        vm.addItem(item: "")
        
        // Then
        XCTAssertTrue(vm.dataArray.isEmpty)
    }
    
    func test_UnitTestingViewModel_selectedItem_shouldStartAsNil() {
        // Given
        
        // When
        let vm = UnitTestingViewModel(isPremium: Bool.random())
        
        // Then
        XCTAssertNil(vm.selectedItem)
    }
    
    func test_UnitTestingViewModel_selectedItem_shouldBeNilWhenSelectingInvalidItem() {
        // Given
        let vm = UnitTestingViewModel(isPremium: Bool.random())
        
        // When
        
        // Select valid item
        let newItem = UUID().uuidString
        vm.addItem(item: newItem)
        vm.selectItem(item: newItem)
        
        // Select invalid item
        vm.selectItem(item: UUID().uuidString)
        
        // Then
        XCTAssertNil(vm.selectedItem)
    }
    
    func test_UnitTestingViewModel_selectedItem_shouldBeSelected() {
        // Given
        let vm = UnitTestingViewModel(isPremium: Bool.random())
        
        // When
        let newItem = UUID().uuidString
        vm.addItem(item: newItem)
        vm.selectItem(item: newItem)
        
        // Then
        XCTAssertNotNil(vm.selectedItem)
        XCTAssertEqual(vm.selectedItem, newItem)
    }
    
    func test_UnitTestingViewModel_selectedItem_shouldBeSelected_stress() {
        // Given
        let vm = UnitTestingViewModel(isPremium: Bool.random())
        
        // When
        let loopCount: Int = Int.random(in: 0..<100)
        var itemsArray: [String] = []
        
        for _ in 0..<loopCount {
            let newItem = UUID().uuidString
            vm.addItem(item: newItem)
            itemsArray.append(newItem)
        }
        
        let randomItem = itemsArray.randomElement() ?? ""
        vm.selectItem(item: randomItem)
        
        // Then
        XCTAssertNotNil(vm.selectedItem)
        XCTAssertEqual(vm.selectedItem, randomItem)
    }
    
    func test_UnitTestingViewModel_saveItem_shouldThrowError_itemNotFound() {
        // Given
        let vm = UnitTestingViewModel(isPremium: Bool.random())
        
        // When
        let loopCount: Int = Int.random(in: 0..<100)
        for _ in 0..<loopCount {
            vm.addItem(item: UUID().uuidString)
        }
        
        // Then
        XCTAssertThrowsError(try vm.saveItem(item: UUID().uuidString))
        XCTAssertThrowsError(try vm.saveItem(item: UUID().uuidString), "Should throw itemNotFound Error") { error in
            let returnedError = error as? UnitTestingViewModel.DataError
            XCTAssertEqual(returnedError, UnitTestingViewModel.DataError.itemNotFound)
        }
    }
    
    func test_UnitTestingViewModel_saveItem_shouldThrowError_noData() {
        // Given
        let vm = UnitTestingViewModel(isPremium: Bool.random())
        
        // When
        let loopCount: Int = Int.random(in: 0..<100)
        for _ in 0..<loopCount {
            vm.addItem(item: UUID().uuidString)
        }
        
        // Then
        do {
            try vm.saveItem(item: "")
        } catch let error {
            let returnedError = error as? UnitTestingViewModel.DataError
            XCTAssertEqual(returnedError, UnitTestingViewModel.DataError.noData)
        }
    }
    
    func test_UnitTestingViewModel_saveItem_shouldSaveItem() {
        // Given
        let vm = UnitTestingViewModel(isPremium: Bool.random())
        
        // When
        let loopCount: Int = Int.random(in: 0..<100)
        var itemsArray: [String] = []
        
        for _ in 0..<loopCount {
            let newItem = UUID().uuidString
            vm.addItem(item: newItem)
            itemsArray.append(newItem)
        }
        
        let randomItem = itemsArray.randomElement() ?? ""
        XCTAssertFalse(randomItem.isEmpty)
        
        // Then
        XCTAssertNoThrow(try vm.saveItem(item: randomItem))
        
        do {
            try vm.saveItem(item: randomItem)
        } catch {
            XCTFail()
        }
    }
}
