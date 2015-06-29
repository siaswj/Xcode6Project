//
//  ViewController.m
//  自定义CollectionView布局
//
//  Created by wangjie on 15-4-15.
//  Copyright (c) 2015年 sias. All rights reserved.
//

#import "ViewController.h"
#import "WJCollectionViewCell.h"
#import "WJLineLayout.h"

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGRect collectionViewFrame = CGRectMake(0, 100, 375, 200);
//    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    WJLineLayout *line = [[WJLineLayout alloc] init];

    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:collectionViewFrame collectionViewLayout:line];
    
//    [collectionView registerClass:[WJCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [collectionView registerNib:[UINib nibWithNibName:@"WJCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    
    collectionView.dataSource = self;
    collectionView.delegate = self;
    
    [self.view addSubview:collectionView];
    
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WJCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.index = indexPath.row;
    return cell;
}

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击了%zd", indexPath.row);
}
@end
