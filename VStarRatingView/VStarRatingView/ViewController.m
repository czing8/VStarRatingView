//
//  ViewController.m
//  VStarRatingView
//
//  Created by Vols on 15/5/12.
//  Copyright (c) 2015年 Vols. All rights reserved.
//

#import "ViewController.h"
#import "VStarRatingView.h"


@interface ViewController () <VStarRatingViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    VStarRatingView *starRatingView = [[VStarRatingView alloc] initWithFrame:CGRectMake(20, 100, 250, 50) numberOfStar:5];
    starRatingView.delegate = self;
    [self.view addSubview:starRatingView];
    
}

-(void)starRatingView:(VStarRatingView *)view score:(float)score
{
//    self.scoreLabel.text = [NSString stringWithFormat:@"%0.2f",score * 10 ];
    NSLog(@"%@",[NSString stringWithFormat:@"%0.2f",score * 10 ]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
