//
//  ZCCollectionViewCell.swift
//  ZCCollectionView
//
//  Created by 赵晨 on 2017/4/17.
//  Copyright © 2017年 qianli. All rights reserved.
//

import UIKit

class ZCCollectionViewCell: UICollectionViewCell {
    /// 图片
    var backImage     = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpUI()
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setUpUI() {
        backImage.backgroundColor = UIColor.red
        backImage.frame = CGRect(x: 0, y: 0, width: self.contentView.frame.size.width, height: self.contentView.frame.size.height)
        self.contentView.addSubview(backImage)
    }
    
   
}
