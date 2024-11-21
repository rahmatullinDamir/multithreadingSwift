//
//  CollectionViewCell.swift
//  multithreading
//
//  Created by Damir Rakhmatullin on 21.11.24.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    private lazy var imageView: UIImageView = {
           let imageView = UIImageView()
           imageView.translatesAutoresizingMaskIntoConstraints = false
           imageView.contentMode = .scaleAspectFill
           imageView.clipsToBounds = true
           return imageView
    }()
    
    override init(frame: CGRect) {
           super.init(frame: frame)
           setupLayout()
    }
    
    required init?(coder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
    }
     
    private func setupLayout() {
        contentView.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    func configureCell(with image: UIImage) {
           imageView.image = image
    }
}

extension CollectionViewCell {
    static var reuseIdentifier: String {
          return String(describing: self)
    }
}
