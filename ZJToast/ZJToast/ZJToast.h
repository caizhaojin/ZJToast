//
//  ZJToast.h
//  ZJToast
//
//  Created by Choi on 2017/4/9.
//  Copyright © 2017年 CZJ. All rights reserved.
//

#import <UIKit/UIKit.h>


#define ZJTOAST_SHOW_INTERVAL 2.5

#define ZJTOAST_SHOW_TOP(msg) [[ZJToast sharedInstance] makeToast:msg duration:ZJTOAST_SHOW_INTERVAL position:@"top"];

#define ZJTOAST_SHOW_CENTER(msg) [[ZJToast sharedInstance] makeToast:msg duration:ZJTOAST_SHOW_INTERVAL position:@"center"];

#define ZJTOAST_SHOW_BOTTOM(msg) [[ZJToast sharedInstance] makeToast:msg duration:ZJTOAST_SHOW_INTERVAL position:@"bottom"];

/** 提示吐司 */
@interface ZJToast : UIView

+ (ZJToast *)sharedInstance;

- (void)makeToast:(NSString *)message;
- (void)makeToast:(NSString *)message duration:(CGFloat)interval position:(id)position;

@end
