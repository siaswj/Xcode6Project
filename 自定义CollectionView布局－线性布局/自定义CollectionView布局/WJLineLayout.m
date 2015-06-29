//
//  WJLineLayout.m
//  自定义CollectionView布局
//
//  Created by wangjie on 15-4-15.
//  Copyright (c) 2015年 sias. All rights reserved.
//

#import "WJLineLayout.h"

@implementation WJLineLayout

- (instancetype)init
{
    if (self = [super init]) {
        self.itemSize = CGSizeMake(100, 100);
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.minimumInteritemSpacing = 50;
        self.minimumLineSpacing = 50;
    }
    return self;
}



// 应该使之前的layout失效吗？－－－意思就是重新计算layout
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

/**
 *  只要布局刷新了，首先就会调用这个方法
 */
- (void)prepareLayout
{
    CGFloat inset = (self.collectionView.bounds.size.width - self.itemSize.width) * 0.5;
    self.sectionInset = UIEdgeInsetsMake(0, inset, 0, inset);
    // 用self.sectionInset替代self.collectionView.contentInsets设置间距
    // self.sectionInset会保留collectionView之前的contentInsets
}

/**
 *  这个方法的作用：控制collectionView停止滚动时停留的位置
 *  @param proposedContentOffset 不加干扰的情况下，collectionView默认要停留的位置
 *  @param velocity              力度/速度
 *  @return collectionView停留的最终的位置
 */
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    // 计算最中间的x值
    CGFloat screenCenterX = proposedContentOffset.x + self.collectionView.bounds.size.width * 0.5;
    
    // 计算屏幕的可见范围
    CGRect visiableRect;
    visiableRect.origin = proposedContentOffset;
    visiableRect.size = self.collectionView.bounds.size;
    
    // 获得可见范围内的cell的布局属性
    NSArray *array = [super layoutAttributesForElementsInRect:visiableRect];
    CGFloat minDelta = MAXFLOAT;
    for (UICollectionViewLayoutAttributes *attrs in array) { // 遍历所有cell的布局属性
        if (ABS(attrs.center.x - screenCenterX) < ABS(minDelta)) {
            minDelta = attrs.center.x - screenCenterX;
        }
    }
    
    return CGPointMake(proposedContentOffset.x + minDelta, proposedContentOffset.y);
}



/**
 *  设置collectionView内部所有元素的布局参数，就是cell的参数，然后返回这个数组(数组中装的是每个cell的布局属性参数)
 *  一个 cell 对应一个 UICollectionViewLayoutAttributes
 */
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    
    // 计算最中间的x值
    CGFloat screenCenterX = self.collectionView.contentOffset.x + self.collectionView.bounds.size.width * 0.5;
    
    // 可见范围
//    CGRect visiableRect;
//    visiableRect.size = self.collectionView.bounds.size;
//    visiableRect.origin = self.collectionView.contentOffset;
    
    for (UICollectionViewLayoutAttributes *attrs in array) {
        CGFloat scale = 1.0 + 0.5 * (1.0 - (ABS(screenCenterX - attrs.center.x) / 200));
        attrs.transform = CGAffineTransformMakeScale(scale, scale);
//        attrs.transform3D = CATransform3DMakeScale(scale, scale, 1.0);
//        CGFloat distance = ABS(screenCenterX - attrs.center.x);
//        attrs.transform3D = CATransform3DMakeRotation(M_PI_2 * (distance / 200), 0, 1, 0);
    }
    return array;
}

@end