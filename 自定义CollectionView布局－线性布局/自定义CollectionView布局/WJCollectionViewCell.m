//
//  WJCollectionViewCell.m
//  自定义CollectionView布局
//
//  Created by wangjie on 15-4-15.
//  Copyright (c) 2015年 sias. All rights reserved.
//

#import "WJCollectionViewCell.h"

@interface WJCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *label;
@end

@implementation WJCollectionViewCell

- (void)setIndex:(NSUInteger)index
{
    _index = index;
    
    self.label.text = [NSString stringWithFormat:@"%zd", index];
}

- (void)awakeFromNib
{
    // Initialization code
}

@end
