//
//  ViewController.m
//  testBadge1210
//
//  Created by liuzhu on 15/12/10.
//  Copyright © 2015年 liuzhu. All rights reserved.
//

#import "ViewController.h"
#define MENU_COUNT 4

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置图标
    NSArray *imageSelNameArray = [NSArray arrayWithObjects:
                                  @"menu_homepage_sel",
                                  @"menu_class_sel",
                                  @"menu_index_sel",
                                  @"menu_mine_sel", nil];
    
    NSArray *imageNameArray = [NSArray arrayWithObjects:
                               @"menu_homepage",
                               @"menu_class",
                               @"menu_index",
                               @"menu_mine", nil];
    
    for(int n=0;n!=MENU_COUNT;n++)
    {
        UITabBarItem *item =  [self.tabBar.items objectAtIndex:n];
        UIImage *imageSel = [UIImage imageNamed:imageSelNameArray[n]];
        imageSel = [imageSel imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [item setSelectedImage:imageSel];
        UIImage *image = [UIImage imageNamed:imageNameArray[n]];
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [item setImage:image];
    }

}



#pragma mark - 以下是UITabBar角标的部分,显示角标的函数必须在viewDidAppear:方法中调用
- (void)viewDidAppear:(BOOL)animated{
    [self showBadgeInController:1 width:10];
    [self showBadgeInController:2 width:10];
    [self showBadgeInController:3 width:10];
    [self showBadgeInController:0 width:10];
}
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    [self removeBadgeInController:[tabBar.items indexOfObject:item]];
}

#pragma mark 显示自定义角标
/**
 *  在自定义UITabBarButton角标,必须在viewDidAppear:方法中调用,让其和系统的角标的中心重合.
 *
 *  @param itemNum 要把角标显示在第几个控制器上面
 *  @param width   角标的直径,默认为5.0
 */
- (void)showBadgeInController:(NSInteger)itemNum width:(CGFloat)width
{
    //设置系统角标视图
    UITabBarItem *tabBarItemWillBadge = self.tabBar.items[itemNum];
    tabBarItemWillBadge.badgeValue = @"";
    if (width <= 0) {
        width = 5.0;
    }
    
    //新建角标视图
    UIView *smallBadge = [[UIView alloc]initWithFrame:CGRectMake(0, 0, width, width)];
    smallBadge.backgroundColor = [UIColor redColor];
    smallBadge.layer.cornerRadius = smallBadge.bounds.size.width * 0.5;
    smallBadge.tag = 100099 + itemNum;
    
    //遍历查找含有系统角标的视图,用自定义的角标视图代替系统的角标视图.
    for (UIView *tabBarBtn in self.tabBar.subviews) {
        for (UIView *tabBarBtnSubview in tabBarBtn.subviews) {
            
            NSString *strSubviewName = [NSString stringWithUTF8String:object_getClassName(tabBarBtnSubview)];
            if ([strSubviewName isEqualToString:@"UITabBarButtonBadge"] ||
                [strSubviewName isEqualToString:@"_UIBadgeView"]){
                //添加自定义角标到按钮上,并移除系统角标
                smallBadge.center = tabBarBtnSubview.center;
                [tabBarBtn addSubview:smallBadge];
                [tabBarBtnSubview removeFromSuperview];
            }
        }
    }
}

#pragma mark 移除自定义角标
/**
 *  移除自定义UITabBarButton角标.
 *
 *  @param itemNum 要把第几个控制器上面的角标移除
 */
- (void)removeBadgeInController:(NSInteger)itemNum
{
    //遍历查找并移除含有自定义角标的视图.
    for (UIView *tabBarBtn in self.tabBar.subviews) {
        for (UIView *tabBarBtnSubview in tabBarBtn.subviews) {
            
            if ( tabBarBtnSubview.tag == 100099 + itemNum ){
                [tabBarBtnSubview removeFromSuperview];
                return;
            }
        }
    }
}





@end
