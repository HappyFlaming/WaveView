//
//  BB_WaveView.m
//  demo
//
//  Created by BigBear on 2018/6/4.
//  Copyright © 2018年 BigBear. All rights reserved.
//

/*
 正弦型函数解析式：y=Asin（ωx+φ）+h
 各常数值对函数图像的影响：
 φ（初相位）：决定波形与X轴位置关系或横向移动距离（左加右减） φ = 0
 ω：决定周期（最小正周期T=2π/|ω|）调整波浪密度   ω = 2π/self.frame.size.width
 A：决定峰值（即纵向拉伸压缩的倍数）调整波浪高度   A = self.frame.size.height/2
 h：表示波形在Y轴的位置关系或纵向移动距离（上加下减）h = A
 */

#import "BB_WaveView.h"
@interface BB_WaveView()
@property (nonatomic,strong) NSArray *waveArr;
@property (nonatomic,strong) NSMutableArray *waveOffsetArr;
@property (nonatomic,strong) CADisplayLink *waveDisplayLink;
@property (nonatomic,strong) NSMutableArray *waveLayerArr;
@end
@implementation BB_WaveView

+ (instancetype)addToView:(UIView *)view frame:(CGRect)frame waveArr:(NSArray<BB_WaveInfoModel *> *)waveArr {
    BB_WaveView *waveView = [[BB_WaveView alloc] initWithFrame:frame];
    waveView.backgroundColor = [UIColor clearColor];
    waveView.waveArr = waveArr;
    [view addSubview:waveView];
    return waveView;
}

- (void)showAnimation {
    [self waveDisplayLink];
}

- (void)stopAnimation {
    if (_waveDisplayLink) {
        [_waveDisplayLink invalidate];
        _waveDisplayLink = nil;
    }
}

- (void)updateWavePath {
    for (int i=0 ; i<_waveArr.count ; i++) {
        BB_WaveInfoModel *model = _waveArr[i];
        if (!model.waveAmplitude) {
            model.waveAmplitude = self.frame.size.height/2;
        }
        if (!model.waveCycle) {
            model.waveCycle = 1;
        }
        if (!model.waveSpeed) {
            model.waveSpeed = 2;
        }
        if (!model.waveColor) {
            model.waveColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.2];
        }
        CGFloat offsetX = [self.waveOffsetArr[i] floatValue];
        offsetX += model.waveSpeed;
        //修改偏移值
        [self.waveOffsetArr replaceObjectAtIndex:i withObject:@(offsetX)];
        
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathMoveToPoint(path, nil, 0, self.frame.size.height);
        
        CGFloat y = 0.f;
        for (float x=0.0f; x<self.frame.size.width; x++) {
            y = model.waveAmplitude * sin((model.waveCycle * M_PI/self.frame.size.width) * x - offsetX*M_PI/180) + (self.frame.size.height-model.waveAmplitude);
            CGPathAddLineToPoint(path, nil, x, y);
        }
        
        CGPathAddLineToPoint(path, nil, self.frame.size.width, self.frame.size.height);
        CGPathAddLineToPoint(path, nil, 0, self.frame.size.height);
        CGPathCloseSubpath(path);
        
        CAShapeLayer *layer = self.waveLayerArr[i];
        layer.path = path;
        CGPathRelease(path);
    }
}

- (CADisplayLink *)waveDisplayLink {
    if (!_waveDisplayLink) {
        _waveDisplayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateWavePath)];
        [_waveDisplayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
    return _waveDisplayLink;
}

- (NSMutableArray *)waveLayerArr {
    if (!_waveLayerArr) {
        _waveLayerArr = [NSMutableArray arrayWithCapacity:_waveArr.count];
        for (int i=0 ;i<_waveArr.count;i++) {
            BB_WaveInfoModel *model = _waveArr[i];
            CAShapeLayer *layer = [CAShapeLayer layer];
            layer.fillColor = model.waveColor.CGColor;
            layer.strokeColor = model.waveColor.CGColor;
            [self.layer addSublayer:layer];
            [_waveLayerArr addObject:layer];
        }
    }
    return _waveLayerArr;
}

- (NSMutableArray *)waveOffsetArr {
    if (!_waveOffsetArr) {
        _waveOffsetArr = [NSMutableArray arrayWithCapacity:_waveArr.count];
        for (int i=0 ;i<_waveArr.count;i++) {
            [_waveOffsetArr addObject:@0];
        }
    }
    return _waveOffsetArr;
}

- (void)dealloc {
    [self stopAnimation];
    
    for (CAShapeLayer *layer in _waveArr) {
        [layer removeFromSuperlayer];
    }
}
@end
