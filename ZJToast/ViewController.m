//
//  ViewController.m
//  ZJToast
//
//  Created by Choi on 2017/4/9.
//  Copyright © 2017年 CZJ. All rights reserved.
//

#import "ViewController.h"
#import "ZJToast.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSArray *arr = @[@"顶部", @"中部", @"底部"];
    
    for (NSInteger i = 0; i<arr.count; i++) {
        UIButton *btn = [[UIButton alloc] init];
        
        btn.layer.cornerRadius = 8;
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        btn.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:0.5];
        btn.tag = i;
        [btn addTarget:self action:@selector(showToastAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        
        CGRect frame = btn.frame;
        frame.size.width = 80;
        frame.size.height = 30;
        frame.origin.y = (self.view.frame.size.height - frame.size.height) / 2;
        frame.origin.x = 20;
        if (i == 1) {
            frame.origin.x = (self.view.frame.size.width - frame.size.width) / 2;
        } else if (i == 2) {
            frame.origin.x = self.view.frame.size.width - frame.size.width - frame.origin.x;
        }
        btn.frame = frame;
    }
}


- (void)showToastAction:(UIButton *)sender
{
    if (sender.tag == 0) {
        ZJTOAST_SHOW_TOP([self toastString])
    } else if (sender.tag == 1) {
        ZJTOAST_SHOW_CENTER([self toastString])
    } else if (sender.tag == 2) {
        ZJTOAST_SHOW_BOTTOM([self toastString])
    }
}


- (NSString *)toastString
{
    NSArray *arr = @[@"这是一条toast！",
                     @"这是一条toast！这是一条toast！这是一条toast！这是一条toast！这是一条toast！这是一条toast！这是一条toast！这是一条toast！这是一条toast！这是一条toast！这是一条toast！这是一条toast！这是一条toast！这是一条toast！",
                     @"这是一条toast！\n这是一条toast！\n这是一条toast！\n这是一条toast！\n这是一条toast！\n这是一条toast！\n这是一条toast！\n这是一条toast！\n这是一条toast！\n这是一条toast！\n这是一条toast！\n这是一条toast！\n这是一条toast！\n这是一条toast！\n这是一条toast！\n这是一条toast！\n这是一条toast！\n这是一条toast！\n这是一条toast！\n这是一条toast！\n这是一条toast！",
                     @"这是一条toast！\n这是一条toast！\n这是一条toast！\n这是一条toast！\n这是一条toast！",
                     @"This is a toast!",
                     @"This is a toast!\nThis is a toast!\nThis is a toast!\nThis is a toast!\nThis is a toast!\nThis is a toast!\nThis is a toast!\nThis is a toast!\nThis is a toast!",
                     @"This is a toast!This is a toast!This is a toast!This is a toast!This is a toast!This is a toast!This is a toast!This is a toast!This is a toast!This is a toast!This is a toast!This is a toast!This is a toast!",
                     @"abcdefghjklmnopqrstuvwxyz",
                     @"谢谢使用，使用图片的吐司就是个鸡肋，简单明了才是王道！",
                     @"没有什么备注，基本也能看懂，自己到内部更改喜欢的色调。",
                     @"发现不叠加的toast才比较适合。",
                     ];
    
    NSString *str = arr[arc4random()%arr.count];
    return str;
}
@end
