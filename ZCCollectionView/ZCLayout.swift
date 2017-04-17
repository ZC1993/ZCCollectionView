//
//  ZCLayout.swift
//  ZCCollectionView
//
//  Created by 赵晨 on 2017/4/17.
//  Copyright © 2017年 qianli. All rights reserved.
//

import UIKit

class ZCLayout: UICollectionViewFlowLayout {
    
    override func prepare() {
        // 滑动方向
        self.scrollDirection = .horizontal
        // 间距
        self.minimumLineSpacing = 15
        // 设置内边距
        self.sectionInset = UIEdgeInsetsMake(0, (self.collectionView?.frame.size.width)! * 0.1, 60, (self.collectionView?.frame.size.width)! * 0.1)
        let width  = (self.collectionView?.frame.size.width)! * 0.8
        let height = width * 1.5
        // 设置item大小
        self.itemSize = CGSize(width: width, height: height)
        
    }
    
    //允许更新位置
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let array = super.layoutAttributesForElements(in: rect)
        
        let visibleRect = CGRect(x: self.collectionView!.contentOffset.x, y: self.collectionView!.contentOffset.y, width: self.collectionView!.frame.size.width, height: self.collectionView!.frame.size.height)
        
        let offset = visibleRect.midX
        
        for  attribute in array! {
            let distance = offset - attribute.center.x
            let scaleForDistance = distance / self.itemSize.height
            // 大小变化修改
            let scaleForCell = 1 + 0.1 * (1 - fabs(scaleForDistance))
            attribute.transform3D = CATransform3DMakeScale(1, scaleForCell, 1)
            attribute.zIndex = 1
            
        }
        
        return array
    }
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
      
        let lastRect = CGRect(x: proposedContentOffset.x, y: proposedContentOffset.y, width: self.collectionView!.frame.width, height: self.collectionView!.frame.height)
        //获得collectionVIew中央的X值(即显示在屏幕中央的X)
        let centerX = proposedContentOffset.x + self.collectionView!.frame.width * 0.5;
        //这个范围内所有的属性
        let array = self.layoutAttributesForElements(in: lastRect)
        //需要移动的距离
        var adjustOffsetX = CGFloat(MAXFLOAT);
        for attri in array! {
            if abs(attri.center.x - centerX) < abs(adjustOffsetX) {
                adjustOffsetX = attri.center.x - centerX;
            }
        }
        return CGPoint(x: proposedContentOffset.x + adjustOffsetX, y: proposedContentOffset.y)
        
    }

}
