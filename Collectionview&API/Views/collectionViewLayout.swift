//
//  collectionViewLayout.swift
//  Collectionview&API
//
//  Created by IwasakIYuta on 2021/08/02.
//

import Foundation
import UIKit
class CollectionViewLayout: NSObject {
    weak var delegate: UIViewController?
    static let sectionHeaderElementKind = "section-headerだよおおお"
    static let sectionFooterElementKind = "section-footerだよおおお"
    func createLayout() -> UICollectionViewLayout {
        
        let sideInset: CGFloat = 18
        let insideInset: CGFloat = 8
        let topInset: CGFloat = 8
        let viewWidth: CGFloat = self.delegate!.view.bounds.width
        let smallSquareWidth: CGFloat = (viewWidth - (sideInset * 2 + insideInset * 2)) / 3//120
        let mediumSquareWidth: CGFloat = smallSquareWidth * 2 + insideInset
        let nestedGroupHeight: CGFloat = mediumSquareWidth + topInset
        let smallSquareGroupHeight: CGFloat = smallSquareWidth + topInset
        
        
        //collectionViewの全体のレイアウト
        let layout = UICollectionViewCompositionalLayout {
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            //Group
            let nestedGroupTypeA: NSCollectionLayoutGroup = {
                //小セルアイテム
                let smallSquareItem = NSCollectionLayoutItem(
                    //小アイテムのサイズ
                    layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), //
                                                       heightDimension: .absolute(smallSquareWidth + insideInset)))//128
                smallSquareItem.contentInsets = NSDirectionalEdgeInsets(top: topInset, leading: 0, bottom: 0, trailing: insideInset)
                
                //小さなグループ
                let smallSquareGroup = NSCollectionLayoutGroup.horizontal(
                    
                    layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(smallSquareWidth + insideInset),
                                                       heightDimension: .fractionalHeight(1.0)),
                    subitem: smallSquareItem, count: 2)//アイテムを二つ小さなグループhorizontalだから平行に
                
                //中サイズアイテム
                let mediumSquareItem = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(mediumSquareWidth),
                                                       heightDimension: .fractionalHeight(1.0)))
                mediumSquareItem.contentInsets = NSDirectionalEdgeInsets(top: topInset, leading: 0, bottom: 0, trailing: 0)
                
                let mediumSquareGroup = NSCollectionLayoutGroup.horizontal(
                    
                    layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(smallSquareWidth + insideInset),
                                                       heightDimension: .fractionalHeight(1.0)),
                    subitem: mediumSquareItem, count: 2)//verticalで二つ並べる？
               
                //
                let nestedGroup = NSCollectionLayoutGroup.vertical(
                    layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                       heightDimension: .absolute(nestedGroupHeight)),
                    subitems: [smallSquareGroup, mediumSquareGroup])
                return nestedGroup
            
            }()
            
            let nestedGroupTypeB: NSCollectionLayoutGroup = {
                let mediumSquareItem = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(mediumSquareWidth + insideInset),
                                                       heightDimension: .fractionalHeight(1.0)))
                mediumSquareItem.contentInsets = NSDirectionalEdgeInsets(top: topInset, leading: 0, bottom: 0, trailing: insideInset)
                
                let smallSquareItem = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                       heightDimension: .absolute(smallSquareWidth + insideInset)))
                smallSquareItem.contentInsets = NSDirectionalEdgeInsets(top: topInset, leading: 0, bottom: 0, trailing: 0)
                let smallSquareGroup = NSCollectionLayoutGroup.vertical(
                    layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(smallSquareWidth),
                                                       heightDimension: .fractionalHeight(1.0)),
                    subitem: smallSquareItem, count: 2)
                
                let nestedGroup = NSCollectionLayoutGroup.horizontal(
                    layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                       heightDimension: .absolute(nestedGroupHeight)),
                    subitems: [mediumSquareItem, smallSquareGroup])
                return nestedGroup
            }()
            
            let group = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .absolute(nestedGroupHeight * 2 + smallSquareGroupHeight * 2)),
                subitems: [nestedGroupTypeA,nestedGroupTypeB])
           
            //セッションを指定
            let section = NSCollectionLayoutSection(group: group)
            //セッション毎の間を指定
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: sideInset, bottom: -100, trailing: sideInset)
            
            let headerFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                                          heightDimension: .estimated(0.1))
                
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerFooterSize,
                                                                           elementKind: CollectionViewLayout.sectionHeaderElementKind,
                                                                             alignment: .top)
            let sectionFooter = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerFooterSize,
                                                                           elementKind: CollectionViewLayout.sectionFooterElementKind,
                                                                             alignment: .bottom)
            
            section.boundarySupplementaryItems = [sectionHeader, sectionFooter]
            //Scroll機能
            section.orthogonalScrollingBehavior = .paging
            
            return section
            
        }
        
        return layout
        
        
    }
    
}

