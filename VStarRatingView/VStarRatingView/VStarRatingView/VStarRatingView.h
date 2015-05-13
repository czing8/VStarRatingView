//
//  VStarRatingView.h
//  VStarRatingView
//
//  Created by Vols on 15/5/12.
//  Copyright (c) 2015年 Vols. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VStarRatingView;

@protocol VStarRatingViewDelegate <NSObject>

@optional

-(void)starRatingView:(VStarRatingView *)view score:(float)score;

@end

@interface VStarRatingView : UIView

@property (nonatomic, readonly) int numberOfStar;
@property (nonatomic, weak) id <VStarRatingViewDelegate> delegate;


/**
 *  初始化VStarRatingView
 *
 *  @param frame  Rectangles
 *  @param number 星星个数
 *
 *  @return VStarRatingViewObject
 */
- (id)initWithFrame:(CGRect)frame numberOfStar:(int)number;


/**
 *  设置控件分数
 *
 *  @param score     分数，必须在 0 － 1 之间
 *  @param isAnimate 是否启用动画
 */
- (void)setScore:(float)score withAnimation:(bool)isAnimate;



/**
 *  设置控件分数
 *
 *  @param score      分数，必须在 0 － 1 之间
 *  @param isAnimate  是否启用动画
 *  @param completion 动画完成block
 */
- (void)setScore:(float)score withAnimation:(bool)isAnimate completion:(void (^)(BOOL finished))completion;





@end
