//
//  MCTabBarController.m
//  MCTabBarDemo
//
//  Created by chh on 2017/12/4.
//  Copyright © 2017年 Mr.C. All rights reserved.
//

#import "MCTabBarController.h"
#import "ViewController.h"
#import "BaseNavigationController.h"
#import "MCTabBar.h"
@interface MCTabBarController ()<UITabBarControllerDelegate>
@property (nonatomic, strong) MCTabBar *mcTabbar;
@end

@implementation MCTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _mcTabbar = [[MCTabBar alloc] init];
     [_mcTabbar.centerBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    //选中时的颜色
    _mcTabbar.tintColor = [UIColor whiteColor];
   //透明设置为NO，显示白色，view的高度到tabbar顶部截止，YES的话到底部
    _mcTabbar.translucent = NO;
    //利用KVC 将自己的tabbar赋给系统tabBar
    [self setValue:_mcTabbar forKeyPath:@"tabBar"];
   
    self.delegate = self;
    [self addChildViewControllers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//添加子控制器
- (void)addChildViewControllers{
    //图片大小建议32*32
    [self addChildrenViewController:[[ViewController alloc] init] andTitle:@"首页" andImageName:@"tab1_n" andSelectImage:@"tab1_p"];
    [self addChildrenViewController:[[ViewController alloc] init] andTitle:@"扩展" andImageName:@"tab2_n" andSelectImage:@"tab2_p"];
    //中间这个不设置东西，只占位
    [self addChildrenViewController:[[ViewController alloc] init] andTitle:@"旋转" andImageName:@"" andSelectImage:@""];
    [self addChildrenViewController:[[ViewController alloc] init] andTitle:@"发现" andImageName:@"tab3_n" andSelectImage:@"tab3_p"];
    [self addChildrenViewController:[[ViewController alloc] init] andTitle:@"我" andImageName:@"tab4_n" andSelectImage:@"tab4_p"];
}

- (void)addChildrenViewController:(UIViewController *)childVC andTitle:(NSString *)title andImageName:(NSString *)imageName andSelectImage:(NSString *)selectedImage{
    childVC.tabBarItem.image = [UIImage imageNamed:imageName];
    childVC.tabBarItem.selectedImage =  [UIImage imageNamed:selectedImage];
    childVC.title = title;
    
    BaseNavigationController *baseNav = [[BaseNavigationController alloc] initWithRootViewController:childVC];
    
    [self addChildViewController:baseNav];
}


- (void)buttonAction:(UIButton *)button{
    self.selectedIndex = 2;//关联中间按钮
//    [self rotationAnimation];
}


//tabbar选择时的代理
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    if (tabBarController.selectedIndex == 2){//选中中间的按钮
//        [self rotationAnimation];
    }else {
//        [_mcTabbar.centerBtn.layer removeAllAnimations];
    }
}
//旋转动画
- (void)rotationAnimation{
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI*2.0];
    rotationAnimation.duration = 3.0;
    rotationAnimation.repeatCount = HUGE;
    [_mcTabbar.centerBtn.layer addAnimation:rotationAnimation forKey:@"key"];
}

@end
