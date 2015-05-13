//
//  VStarRatingView.m
//  VStarRatingView
//
//  Created by Vols on 15/5/12.
//  Copyright (c) 2015年 Vols. All rights reserved.
//

#import "VStarRatingView.h"

@interface VStarRatingView ()

@property (nonatomic, strong) UIView *starBackgroundView;
@property (nonatomic, strong) UIView *starForegroundView;

@end

@implementation VStarRatingView

- (id)initWithFrame:(CGRect)frame{
    return [self initWithFrame:frame numberOfStar:5];
}

- (id)initWithFrame:(CGRect)frame numberOfStar:(int)number
{
    self = [super initWithFrame:frame];
    if (self) {
        _numberOfStar = number;
        [self initialization];

    }
    return self;
}

- (void)initialization{
    self.starBackgroundView = [self buidlStarViewWithImageName:@"backgroundStar"];
    self.starForegroundView = [self buidlStarViewWithImageName:@"foregroundStar"];
    [self addSubview:self.starBackgroundView];
    [self addSubview:self.starForegroundView];
}


#pragma mark -
#pragma mark - Set Score

- (void)setScore:(float)score withAnimation:(bool)isAnimate{
    [self setScore:score withAnimation:isAnimate completion:nil];
}

- (void)setScore:(float)score withAnimation:(bool)isAnimate completion:(void (^)(BOOL finished))completion
{
    NSAssert((score >= 0.0)&&(score <= 1.0), @"score must be between 0 and 1");
    
    if (score < 0){
        score = 0;
    }
    
    if (score > 1){
        score = 1;
    }
    
    CGPoint point = CGPointMake(score * self.frame.size.width, 0);
    
    if(isAnimate) {
        __weak __typeof(self)weakSelf = self;
        
        [UIView animateWithDuration:0.2 animations:^{
             [weakSelf changeStarForegroundViewWithPoint:point];
             
         } completion:^(BOOL finished){
             if (completion){
                 completion(finished);
             }
         }];
    }
    else{
        [self changeStarForegroundViewWithPoint:point];
    }
}


#pragma mark -
#pragma mark - Touche Event

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    CGRect rect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    if(CGRectContainsPoint(rect,point)) {
        [self changeStarForegroundViewWithPoint:point];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    __weak VStarRatingView * weekSelf = self;
    
    [UIView transitionWithView:self.starForegroundView
                      duration:0.2
                       options:UIViewAnimationOptionCurveEaseInOut
                    animations:^{
                        [weekSelf changeStarForegroundViewWithPoint:point];
                    }
                    completion:^(BOOL finished){
                    }
     ];
}

#pragma mark -
#pragma mark - Buidl Star View

/**
 *  通过图片构建星星视图
 *
 *  @param imageName 图片名称
 *
 *  @return 星星视图
 */
- (UIView *)buidlStarViewWithImageName:(NSString *)imageName {
    
    CGRect frame = self.bounds;
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.clipsToBounds = YES;
    for (int i = 0; i < self.numberOfStar; i ++){
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        imageView.frame = CGRectMake(i * frame.size.width / self.numberOfStar, 0, frame.size.width / self.numberOfStar, frame.size.height);
        [view addSubview:imageView];
    }
    return view;
}

#pragma mark -
#pragma mark - Change Star Foreground With Point
/**
 *  通过坐标改变前景视图
 *
 *  @param point 坐标
 */
- (void)changeStarForegroundViewWithPoint:(CGPoint)point
{
    CGPoint p = point;
    
    if (p.x < 0){
        p.x = 0;
    }
    else if (p.x > self.frame.size.width){
        p.x = self.frame.size.width;
    }
    
    NSString * str = [NSString stringWithFormat:@"%0.2f",p.x / self.frame.size.width];
    float score = [str floatValue];
    p.x = score * self.frame.size.width;
    self.starForegroundView.frame = CGRectMake(0, 0, p.x, self.frame.size.height);
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(starRatingView: score:)]){
        [self.delegate starRatingView:self score:score];
    }
}


@end
