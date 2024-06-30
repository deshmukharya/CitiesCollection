//
//  CitiesCollectionTests.swift
//  CitiesCollectionTests
//
//  Created by E5000861 on 30/06/24.
//

import XCTest
@testable import CitiesCollection

final class CitiesCollectionTests: XCTestCase {

    var sut: CityCollectionViewController!
     
     override func setUp() {
         super.setUp()
         let storyboard = UIStoryboard(name: "Main", bundle: nil) // Replace with your storyboard name
         sut = storyboard.instantiateViewController(withIdentifier: "CityCollectionViewController") as? CityCollectionViewController
         sut.loadViewIfNeeded()
     }
     
     override func tearDown() {
         sut = nil
         super.tearDown()
     }
     
     func testCollectionView_NumberOfSections() {
         let numberOfSections = sut.numberOfSections(in: sut.collectionView!)
         XCTAssertEqual(numberOfSections, 1)
     }
     
     func testCollectionView_NumberOfItemsInSection() {
         let numberOfItems = sut.collectionView(sut.collectionView!, numberOfItemsInSection: 0)
         XCTAssertEqual(numberOfItems, sut.cities.count)
     }
     
     func testCollectionView_CellForItemAtIndexPath() {
         let indexPath = IndexPath(item: 0, section: 0)
         let cell = sut.collectionView(sut.collectionView!, cellForItemAt: indexPath) as! CityCollectionViewCell
         XCTAssertEqual(cell.cityNameLabel.text, sut.cities[indexPath.row].name)
         XCTAssertEqual(cell.cityImageView.image, UIImage(named: sut.cities[indexPath.row].image))
     }
     
    func testCollectionView_DidSelectItemAtIndexPath() {
        let indexPath = IndexPath(item: 0, section: 0)
        sut.collectionView(sut.collectionView!, didSelectItemAt: indexPath)

        // After selection, check if a segue is performed correctly
        XCTAssertTrue(sut.presentedViewController is CityDetailViewController)
    }

    func testPrepareForSegue() {
        let indexPath = IndexPath(item: 0, section: 0)
        sut.collectionView(sut.collectionView!, didSelectItemAt: indexPath)

        // Verify that the destination view controller is CityDetailViewController
        guard let destination = sut.presentedViewController as? CityDetailViewController else {
            XCTFail("Expected CityDetailViewController, but got \(String(describing: sut.presentedViewController))")
            return
        }

        // Check if the city object passed matches the expected city in the data source
        XCTAssertEqual(destination.city?.name, sut.cities[indexPath.row].name)
    }

}
