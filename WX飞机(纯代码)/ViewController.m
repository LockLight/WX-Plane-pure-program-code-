//
//  ViewController.m
//  WX飞机(纯代码)
//
//  Created by locklight on 16/12/25.
//  Copyright © 2016年 LockLight. All rights reserved.
//

#import "ViewController.h"

typedef enum : NSUInteger {
    KMoveUpBtn = 100,
    KMoveLeftBtn,
    KMovebottomBtn,
    KMoveRightBtn,
} KMoveDirection;

@interface ViewController ()

@property(weak,nonatomic)UIButton *planeButton;

@end

@implementation ViewController


/**
 *  控制器根视图加载"创建完成之后系统会调用此方法"
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // 添加UI按钮
    [self setupUI];
}


- (void)setupUI {
    // 1.添加背景图片
    UIImageView *bgView = [[UIImageView alloc]init];
    bgView.frame = self.view.frame;
    bgView.image = [UIImage imageNamed:@"background"];
    // 2.添加飞机按钮
    UIButton *planebtn = [[UIButton alloc]init];
    [planebtn setImage:[UIImage imageNamed:@"hero1"] forState:UIControlStateNormal];
    [planebtn setImage:[UIImage imageNamed:@"hero2"] forState:UIControlStateHighlighted];
    // 根据内容调整按钮的大小
    [planebtn sizeToFit];
    // 设置按钮的位置
    planebtn.center = self.view.center;
    [self.view addSubview:planebtn];
    self.planeButton = planebtn;
    // 3.添加操作按钮
    [self setupActionButtons];
}

- (void)setupActionButtons {
    //设定动作按钮中心点
    CGPoint center = self.view.center;
    //动作按钮单位长度
    CGFloat width = 50;
    //动作按钮在视图中的位置
    CGRect rect = CGRectMake(center.x - width, center.y + 200, width, width);
    
    [self buttonWithImageName:@"top" rect:rect offsetX:0 offsetY:-width tag:KMoveUpBtn];
    [self buttonWithImageName:@"left" rect:rect offsetX:-width offsetY:0 tag:KMoveLeftBtn];
    [self buttonWithImageName:@"bottom" rect:rect offsetX:0 offsetY:width tag:KMovebottomBtn];
    [self buttonWithImageName:@"right" rect:rect offsetX:width offsetY:0 tag:KMoveRightBtn];
}

/**
 当前按钮信息

 @param imageName 按钮名称
 @param rect 按钮大小
 @param offsetX X方向偏移量
 @param offsetY Y方向偏移量
 @param tag 按钮标签
 @return 返回已经设置好的按钮本身
 */
- (UIButton *)buttonWithImageName:(NSString *)imageName rect:(CGRect)rect offsetX:(CGFloat)offsetX offsetY:(CGFloat)offsetY tag:(NSInteger)tag {
    // 1.实例化按钮
    UIButton *ActionButton = [[UIButton alloc]init];
    // 2.拼接图片名称
    NSString *normalName = [imageName stringByAppendingString:@"_normal"];
    NSString *highlightedName = [imageName stringByAppendingString:@"_highlighted"];
    // 2.1.设置按钮图片
    [ActionButton setImage:[UIImage imageNamed:normalName] forState:UIControlStateNormal];
    [ActionButton setImage:[UIImage imageNamed:highlightedName] forState:UIControlStateHighlighted];
    // 3.设置按钮位置和大小
    ActionButton.frame = CGRectOffset(rect, offsetX, offsetY);
    // 4.设置按钮 tag
    ActionButton.tag = tag;
    // 5.给按钮添加监听方法
    [ActionButton addTarget:self action:@selector(moveBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    // 6.把按钮添加到控制器的根视图上
    [self.view addSubview:ActionButton];
    return ActionButton;
}

- (void)moveBtnClick:(UIButton *)btn {
    // 0.移动距离
    CGFloat distance = 10;
    // 1.获取飞机按钮的frame
    CGRect planeBtnFrame = self.planeButton.frame;
    // 2.修改结构体变量
    switch (btn.tag) {
        case KMoveUpBtn:
            planeBtnFrame.origin.y -= distance;
            break;
        case KMoveLeftBtn:
            planeBtnFrame.origin.x -= distance;
            break;
        case KMovebottomBtn:
            planeBtnFrame.origin.y += distance;
            break;
        case KMoveRightBtn:
            planeBtnFrame.origin.x += distance;
            break;
    }
    // 3.修改飞机按钮的frame
    self.planeButton.frame = planeBtnFrame;
}

@end
