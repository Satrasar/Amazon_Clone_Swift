//
//  PhotoCollectionViewCell.swift
//  Amazon
//
//  Created by ozlemkumtas on 19.08.2023.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    static let identifier = "PhotoCollectionViewCell"

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    override init(frame: CGRect){
        super.init(frame: frame)
        contentView.addSubview(imageView)

    }
    required init?(coder: NSCoder) {
        fatalError()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds
    }

    public func configure(width image: UIImage){
        imageView.image = image

    }

}
