//
//  MainVIewCollectionDataSource.swift
//  multithreading
//
//  Created by Damir Rakhmatullin on 21.11.24.
//

import Foundation
import UIKit

class MainVIewCollectionDataSource: NSObject, UICollectionViewDataSource {
    var dataSource: [UIImage] = [UIImage(resource: .kitten), UIImage(resource: .kitten2), UIImage(resource: .kitten3), UIImage(resource: .kitten4), UIImage(resource: .kitten5), UIImage(resource: .kitten6), UIImage(resource: .kitten7), UIImage(resource: .kitten8), UIImage(resource: .kitten9), UIImage(resource: .kitten10), UIImage(resource: .kitten11)] 
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.reuseIdentifier, for: indexPath) as! CollectionViewCell
        cell.configureCell(with: dataSource[indexPath.row])

        return cell
    }
    
}
