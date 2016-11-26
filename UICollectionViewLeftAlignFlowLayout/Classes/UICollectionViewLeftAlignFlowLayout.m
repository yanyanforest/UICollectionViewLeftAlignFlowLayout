//
//  UICollectionViewLeftAlignFlowLayout.m
//  KHMall
//
//  Created by yanyan on 16/8/19.
//  Copyright © 2016年 198. All rights reserved.
//

#import "UICollectionViewLeftAlignFlowLayout.h"
@interface UICollectionViewLayoutAttributes (LeftAligned)

- (void)leftAlignFrameWithSectionInset:(UIEdgeInsets)sectionInset;

@end

@implementation UICollectionViewLayoutAttributes (LeftAligned)

- (void)leftAlignFrameWithSectionInset:(UIEdgeInsets)sectionInset
{
    CGRect frame = self.frame;
    frame.origin.x = sectionInset.left;
    self.frame = frame;
}

@end

@implementation UICollectionViewLeftAlignFlowLayout

- (instancetype)init
{
    if (self = [super init]) {
        
    }
    return self;
}
//返回整个collectionview中所有cell和view 的属性
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
//    NSArray *attributesArrayReturn = [super layoutAttributesForElementsInRect:rect];
//    NSArray *attributesArrayReturn = [NSArray arrayWithArray:[super layoutAttributesForElementsInRect:rect]];//这两句都会出现控制台的警告信息
    NSArray *attributesArrayReturn = [[NSArray alloc] initWithArray:[super layoutAttributesForElementsInRect:rect] copyItems:YES];

    for (UICollectionViewLayoutAttributes *attributes in attributesArrayReturn) {
        //这代表的是当元素cell 时返回 cell的UICollectionElementCategoryCell
        if (attributes.representedElementKind == nil) {
            UICollectionViewLayoutAttributes *curAttributes = [[self layoutAttributesForItemAtIndexPath:attributes.indexPath] copy];
            attributes.frame = curAttributes.frame;
        }
    }
    return attributesArrayReturn;
}
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *curAttributes = [[super layoutAttributesForItemAtIndexPath:indexPath] copy];
    UIEdgeInsets sectionInset = [self evaluateSectionInsetForItemAtIndexPath:indexPath];
    
    BOOL isFirstItemInSection = indexPath.item == 0;
    CGFloat layoutWidth = CGRectGetWidth(self.collectionView.frame) - sectionInset.left - sectionInset.right;
    
    if (isFirstItemInSection) {
        [curAttributes leftAlignFrameWithSectionInset:sectionInset];
        return curAttributes;
    }
    
    NSIndexPath *previousIndexPath = [NSIndexPath indexPathForItem:indexPath.item - 1 inSection:indexPath.section];
    UICollectionViewLayoutAttributes *tmpAttributes = [[self layoutAttributesForItemAtIndexPath:previousIndexPath] copy];

    CGRect previousFrame = tmpAttributes.frame;
    CGFloat previousFrameRightPoint = previousFrame.origin.x + previousFrame.size.width;
    CGRect currentFrame = curAttributes.frame;
    CGRect strecthedCurrentFrame = CGRectMake(sectionInset.left,currentFrame.origin.y,layoutWidth,currentFrame.size.height);
    // if the current frame, once left aligned to the left and stretched to the full collection view
    // widht intersects the previous frame then they are on the same line
    BOOL isFirstItemInRow = !CGRectIntersectsRect(previousFrame, strecthedCurrentFrame);
    
    if (isFirstItemInRow) {
        //确保第一个cell在行的左侧
        [curAttributes leftAlignFrameWithSectionInset:sectionInset];
        return curAttributes;
    }
    
    CGRect frame = curAttributes.frame;
    frame.origin.x = previousFrameRightPoint + [self evaluateMinimumInteritemSpacingForItemAtIndexPath:indexPath];
    curAttributes.frame = frame;
    return curAttributes;
}
#pragma  mark -  下面是计算的方法，不是重写父类
//行
- (UIEdgeInsets)evaluateSectionInsetForItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:insetForSectionAtIndex:)]) {
        id<UICollectionViewDelegateFlowLayout> delegate = (id<UICollectionViewDelegateFlowLayout>)self.collectionView.delegate;
        return [delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:indexPath.section];
    } else {
        return self.sectionInset;
    }
}
//列
- (CGFloat)evaluateMinimumInteritemSpacingForItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:minimumInteritemSpacingForSectionAtIndex:)]) {
        id<UICollectionViewDelegateFlowLayout> delegate = (id<UICollectionViewDelegateFlowLayout>)self.collectionView.delegate;
        return [delegate collectionView:self.collectionView layout:self minimumInteritemSpacingForSectionAtIndex:indexPath.row];
    } else {
        return self.minimumInteritemSpacing;
    }
}
@end
