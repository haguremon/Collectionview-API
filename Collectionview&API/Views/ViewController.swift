//
//  ViewController.swift
//  Collectionview&API
//
//  Created by IwasakIYuta on 2021/08/02.
//

import UIKit

class ViewController: UIViewController {
    

    private var collectionViewLayout = CollectionViewLayout()
    private var collectionView: UICollectionView? = nil
    
    var testArray1 = [
        
        ["1","2","3","4","5","6","7"],
        
        ["1","2","3","4","5","6","7"]
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewLayout.delegate = self
        configureHierarchy()
    print("aaaaaaaaaa")
    }
    func configureHierarchy() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: collectionViewLayout.createLayout())
        collectionView!.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView!.backgroundColor = .blue
            
        collectionView!.register(CollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        view.addSubview(collectionView!)
            collectionView!.delegate = self
            collectionView!.dataSource = self
        }


}
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
   
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return testArray1[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        cell.label.text = testArray1[indexPath.section][indexPath.row]
        return cell
    }
}
