//
//  BB_WaveView.h
//  demo
//
//  Created by BigBear on 2018/6/4.
//  Copyright © 2018年 BigBear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BB_WaveInfoModel.h"

@interface BB_WaveView : UIView
+ (instancetype)addToView:(UIView*)view frame:(CGRect)frame waveArr:(NSArray<BB_WaveInfoModel*>*)waveArr;
- (void)showAnimation;
- (void)stopAnimation;
@end
