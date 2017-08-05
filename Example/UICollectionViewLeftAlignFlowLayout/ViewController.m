//
//  UIViewController.m
//  UICollectionViewLeftAlignFlowLayout
//
//  Created by 2570583222 on 11/26/2016.
//  Copyright (c) 2016 2570583222. All rights reserved.
//

#import "ViewController.h"
#import <UICollectionViewLeftAlignFlowLayout/UICollectionViewLeftAlignFlowLayout.h>
@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate>
@property(nonatomic,strong)UICollectionViewLeftAlignFlowLayout *flowout;
@property(nonatomic,strong)UICollectionView *specCollectionView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.flowout = [[UICollectionViewLeftAlignFlowLayout alloc]init];
    self.flowout.minimumLineSpacing = 5;
    self.flowout.minimumInteritemSpacing = 10;
    self.specCollectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:self.flowout];
    self.specCollectionView.backgroundColor = [UIColor whiteColor];
    self.specCollectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin;
    self.specCollectionView.scrollEnabled = YES;
    self.specCollectionView.delegate = self;
    self.specCollectionView.dataSource = self;
    self.specCollectionView.allowsMultipleSelection = YES;
    [self.specCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:self.specCollectionView];
    
}
#pragma mark - UICollectionView  Delegate -
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    return 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    for (UIView *v in cell.subviews) {
        if ([v isMemberOfClass:[UILabel class]]) {
            [v removeFromSuperview];
        }
    }
    UILabel *label = [[UILabel alloc]initWithFrame:cell.bounds];
    [cell addSubview:label];
    label.text = [NSString stringWithFormat:@"%ld第%ld个",(long)indexPath.section,(long)indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - UICollectionViewDelegateFlowLayout -
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
        return CGSizeMake(collectionView.frame.size.width / 4.0, 50);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0,10,0,10);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
        return CGSizeMake(collectionView.frame.size.width , 30);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
