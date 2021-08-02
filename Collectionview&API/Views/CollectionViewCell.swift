//
//  CollectionViewCell.swift
//  Collectionview&API
//
//  Created by IwasakIYuta on 2021/08/02.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    var label: UILabel = {
         let label = UILabel()
         label.textColor = .white
        label.font = .boldSystemFont(ofSize: 33)
        label.backgroundColor = .systemGray
        label.clipsToBounds = true //cellからはみ出さないようにする
         return label
     }()
     override init(frame: CGRect) { //初期化した時に呼ばれる所
         super.init(frame: frame)
         addSubview(label)//addSubview
         label.frame.size = self.frame.size
     }
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
}
