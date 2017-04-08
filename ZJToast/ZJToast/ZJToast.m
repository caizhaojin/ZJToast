//
//  ZJToast.m
//  ZJToast
//
//  Created by Choi on 2017/4/9.
//  Copyright © 2017年 CZJ. All rights reserved.
//

#import "ZJToast.h"

// Screen size
#define ZJDeviceScreenWidth [UIScreen mainScreen].bounds.size.width
#define ZJDeviceScreenHeight [UIScreen mainScreen].bounds.size.height

// RGBA color
#define ZJRGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

// display duration and position
static const CGFloat ZJToastDefaultDuration    = 3.0;
static const NSString *ZJToastDefaultPosition  = @"center";

// general appearance
static const CGFloat ZJToastHorizontalMargin   = 10.0;
static const CGFloat ZJToastVerticalMargin     = 10.0;
static const CGFloat ZJToastCornerRadius       = 10.0;
static const CGFloat ZJToastFontSize           = 16.0;

// shadow appearance
static const CGFloat ZJToastShadowOpacity       = 0.8;
static const CGFloat ZJToastShadowRadius        = 6.0;
static const CGSize  ZJToastShadowOffset        = { 4.0, 4.0 };
static const BOOL    ZJToastDisplayShadow       = YES;

@interface ZJToast ()

@property (strong, nonatomic) UILabel *messageLabel;

@end

@implementation ZJToast

#pragma mark - 创建单例
+ (ZJToast *)sharedInstance
{
    static ZJToast *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[ZJToast alloc] init];
        
    });
    return sharedManager;
}

#pragma mark - toast 信息
- (void)makeToast:(NSString *)message
{
    [self makeToast:message duration:ZJToastDefaultDuration position:ZJToastDefaultPosition];
}
- (void)makeToast:(NSString *)message duration:(CGFloat)interval position:(id)position {
    [self viewForMessage:message title:nil image:nil];
    [self showToast:self duration:interval position:position];
}

#pragma mark - init 创建toast
- (instancetype)init
{
    if (self = [super init]) {
        [self createMessageAndTitleAndImage];
    }
    return self;
}
- (void)createMessageAndTitleAndImage
{
    self.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin);
    self.userInteractionEnabled = NO;
    self.layer.cornerRadius = ZJToastCornerRadius;
    
    if (ZJToastDisplayShadow) {
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOpacity = ZJToastShadowOpacity;
        self.layer.shadowRadius = ZJToastShadowRadius;
        self.layer.shadowOffset = ZJToastShadowOffset;
    }
    // color
    self.backgroundColor = ZJRGBA(0, 0, 0, 0.8);
    
    UILabel *messageLabel = [[UILabel alloc] init];
    messageLabel.font = [UIFont systemFontOfSize:ZJToastFontSize];
    messageLabel.numberOfLines = 0;
    messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
    messageLabel.textColor = [UIColor whiteColor];
    _messageLabel = messageLabel;
    [self addSubview:_messageLabel];
}

- (void)viewForMessage:(NSString *)message title:(NSString *)title image:(UIImage *)image
{
    if((message == nil) && (title == nil) && (image == nil)) return;
    
    CGRect frame = CGRectMake(0, 0, 0, 0);
    if (message != nil) {
        message = [NSString stringWithFormat:@"%@",message];
        _messageLabel.text = message;
        
        // size the message label according to the length of the text
        CGSize maxSizeMessage = CGSizeMake(ZJDeviceScreenWidth - ZJToastHorizontalMargin*2, ZJDeviceScreenHeight - ZJToastVerticalMargin*2);
        NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:ZJToastFontSize]};
        CGRect expectedSizeMessage = [message boundingRectWithSize:maxSizeMessage options: NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
        
        frame = expectedSizeMessage;
        frame.origin.x = ZJToastHorizontalMargin;
        frame.origin.y = ZJToastVerticalMargin;
        _messageLabel.frame = frame;
    } else {
        _messageLabel.frame = frame;
    }
    
    self.frame = CGRectMake(0, 0, frame.size.width + frame.origin.x*2, frame.size.height + frame.origin.y*2);
    
}
- (void)showToast:(UIView *)toast duration:(CGFloat)interval position:(id)point
{
    [self removeFromSuperview];
    toast.center = [self centerPointForPosition:point withToast:toast];
    toast.alpha = 0.0;
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    [window.subviews.lastObject addSubview:self];
    [window.subviews.lastObject bringSubviewToFront:self];
    
    [UIView animateWithDuration:0.25
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         toast.alpha = 1.0;
                     } completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.25
                                               delay:interval
                                             options:UIViewAnimationOptionCurveEaseIn
                                          animations:^{
                                              toast.alpha = 0.0;
                                          } completion:nil];
                     }];
    
}

- (CGPoint)centerPointForPosition:(id)point withToast:(UIView *)toast
{
    if([point isKindOfClass:[NSString class]]) {
        // convert string literals @"top", @"bottom", @"center", or any point wrapped in an NSValue object into a CGPoint
        CGFloat centerX = ZJDeviceScreenWidth/2;
        CGFloat centerY = ZJDeviceScreenHeight/2;
        if([point caseInsensitiveCompare:@"top"] == NSOrderedSame) {
            return CGPointMake(centerX, (toast.frame.size.height / 2) + ZJToastVerticalMargin*2);
        } else if([point caseInsensitiveCompare:@"bottom"] == NSOrderedSame) {
            return CGPointMake(centerX, (ZJDeviceScreenHeight - (toast.frame.size.height / 2)) - ZJToastVerticalMargin*5);
        } else if([point caseInsensitiveCompare:@"center"] == NSOrderedSame) {
            return CGPointMake(centerX, centerY);
        }
    } else if ([point isKindOfClass:[NSValue class]]) {
        return [point CGPointValue];
    }
    
    return [self centerPointForPosition:ZJToastDefaultPosition withToast:toast];
}

@end
