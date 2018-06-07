//
//  BB_WaveInfoModel.h
//  demo
//
//  Created by 汇数 on 2018/6/4.
//  Copyright © 2018年 BigBear. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BB_WaveInfoModel : NSObject
@property (assign,nonatomic) CGFloat waveSpeed;//波浪线速度
@property (assign,nonatomic) CGFloat waveAmplitude;//峰值（振幅）
@property (assign,nonatomic) CGFloat waveCycle;//周期
@property (strong,nonatomic) UIColor *waveColor;//携带alpha值得UIColor
@end
