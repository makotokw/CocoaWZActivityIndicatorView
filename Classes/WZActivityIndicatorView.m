//
//  WZActivityIndicatorView.m
//  WZActivityIndicatorView
//
//  Copyright (c) 2013 makoto_kw. All rights reserved.
//

#import "WZActivityIndicatorView.h"
#import <QuartzCore/QuartzCore.h>

@implementation WZActivityIndicatorView

{
    CALayer *_animationLayer;
    CFTimeInterval _duration;
}

@dynamic duration;
@synthesize hidesWhenStopped = _hidesWhenStopped;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    
    return self;
}

- (id)initWithActivityIndicatorImage:(UIImage *)image
{
    CGRect indicatorFrame = CGRectMake(0, 0, image.size.width, image.size.height);
    self = [super initWithFrame:indicatorFrame];
    if (self) {
        [self setActivityIndicatorImage:image];
    }
    
    return self;
}

- (void)awakeFromNib
{
    _duration            = 2.0f;
    _hidesWhenStopped    = YES;
    self.backgroundColor = [UIColor clearColor];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

- (void)layoutSubviews
{
    [super layoutSubviews];
    _animationLayer.frame = self.bounds;
}

- (void)setActivityIndicatorImage:(UIImage *)image
{
    CGRect   indicatorFrame = CGRectMake(0, 0, image.size.width, image.size.height);
    CALayer *animationLayer = _animationLayer;
    if (!animationLayer) {
        animationLayer               = [CALayer layer];
        animationLayer.masksToBounds = YES;
        [self addRotationAnimationToLayer:animationLayer];
        [self.layer addSublayer:animationLayer];
        _animationLayer = animationLayer;
    }
    animationLayer.frame    = indicatorFrame;
    animationLayer.contents = (id)[image CGImage];
}

- (void)addRotationAnimationToLayer:(CALayer *)layer
{
    CABasicAnimation *rotation =
    [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotation.duration            = _duration;
    rotation.removedOnCompletion = NO;
    rotation.repeatCount         = HUGE_VALF;
    rotation.fillMode            = kCAFillModeForwards;
    rotation.fromValue           = @0.0;
    rotation.toValue             = [NSNumber numberWithFloat:M_PI * 2];
    [layer addAnimation:rotation forKey:@"rotate"];
}

- (void)pauseLayer:(CALayer *)layer
{
    CFTimeInterval pausedTime =
    [layer convertTime:CACurrentMediaTime()
             fromLayer:nil];
    layer.speed      = 0.0;
    layer.timeOffset = pausedTime;
}

- (void)resumeLayer:(CALayer *)layer
{
    CFTimeInterval pausedTime = layer.timeOffset;
    layer.speed      = 1.0;
    layer.timeOffset = 0.0;
    layer.beginTime  = 0.0;
    CFTimeInterval timeSincePause =
    [layer convertTime:CACurrentMediaTime()
             fromLayer:nil] - pausedTime;
    layer.beginTime = timeSincePause;
}

- (void)startAnimating
{
    if (_hidesWhenStopped) {
        self.hidden = NO;
    }
    [self resumeLayer:_animationLayer];
}

- (void)stopAnimating
{
    if (_hidesWhenStopped) {
        self.hidden = YES;
    }
    [self pauseLayer:_animationLayer];
}

- (BOOL)isAnimating
{
    return (_animationLayer && _animationLayer.speed != 0.0);
}

- (CFTimeInterval)duration
{
    return _duration;
}

- (void)setDuration:(CFTimeInterval)duration
{
    if (_duration != duration) {
        _duration = duration;
        _animationLayer.duration = duration;
    }
}

@end
