//
//  ViewController.m
//  WaveView
//
//  Created by BigBear on 2018/6/7.
//  Copyright © 2018年 BigBear. All rights reserved.
//

#import "ViewController.h"
#import "BB_WaveView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    BB_WaveInfoModel *model = [[BB_WaveInfoModel alloc] init];
    model.waveColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.3 alpha:0.3];
    model.waveAmplitude = 20;
    model.waveCycle = 0.5;
    model.waveSpeed = 3;
    
    BB_WaveInfoModel *model1 = [[BB_WaveInfoModel alloc] init];
    model1.waveColor = [UIColor colorWithRed:0.5 green:0.8 blue:0.3 alpha:0.5];
    model1.waveAmplitude = 30;
    model.waveCycle = 2;
    model.waveSpeed = 3;
    
    BB_WaveInfoModel *model2 = [[BB_WaveInfoModel alloc] init];
    model2.waveColor = [UIColor colorWithRed:0.7 green:0.8 blue:0.7 alpha:0.7];
    model2.waveAmplitude = 10;
    model.waveCycle = 3;
    model.waveSpeed = 3;
    
    BB_WaveView *wave = [BB_WaveView addToView:self.view frame:CGRectMake(100, 200, 200, 100) waveArr:@[model,model1,model2]];
    [wave showAnimation];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [wave stopAnimation];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [wave showAnimation];
    });
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
