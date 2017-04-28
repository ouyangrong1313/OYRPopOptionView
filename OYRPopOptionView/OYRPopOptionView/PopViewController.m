//
//  PopViewController.m
//  OYRPopOptionView
//
//  Created by 欧阳荣 on 17/4/28.
//  Copyright © 2017年 HengTaiXin. All rights reserved.
//

#import "PopViewController.h"
#import "OYRPopOption.h"

//动态获取设备高度
#define IPHONE_HEIGHT [UIScreen mainScreen].bounds.size.height
//动态获取设备宽度
#define IPHONE_WIDTH [UIScreen mainScreen].bounds.size.width


@interface PopViewController ()

@end

@implementation PopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"PopDemo_OYR";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;

    [self createRightBtn];
}
-(void)createRightBtn{
    
    UIImage *img = [UIImage imageNamed:@"icon_profile_more"];//tj_t@2x.jpg/xdpy
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 36 * 0.6, 28 * 0.6);
    [btn setImage:img forState:UIControlStateNormal];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    [btn addTarget:self action:@selector(righBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = item;
    
    
}

-(void)righBtnClick:(UIButton *)optionButton{
    
    NSLog(@"点击弹出框");
    // 注意：由convertRect: toView 获取到屏幕上该控件的绝对位置。
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    CGRect frame = [optionButton convertRect:optionButton.bounds toView:window];
    
    
    OYRPopOption *s = [[OYRPopOption alloc] initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, IPHONE_HEIGHT)];
    s.option_optionContents = @[@"退出", @"分享", @"邀请好友"];
    s.option_optionImages = @[@"icon_quit_matchdetail",@"icon_nav_share",@"icon_invite_matchdetail"];
            // 使用链式语法直接展示 无需再写 [s option_show];
    [[s option_setupPopOption:^(NSInteger index, NSString *content) {
                
        NSLog(@"你选中了第%ld行选项为：%@", (long)index, content);
        NSString *popStr = [NSString stringWithFormat:@"你选中了第%ld行选项为：%@", (long)index, content];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:popStr preferredStyle:UIAlertControllerStyleAlert];
        
        //添加的输入框
        //WS(weakSelf);
        UIAlertAction *Action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction *twoAc = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            //添加的带输入框的提示框
        }];
        
        [alert addAction:Action];
        [alert addAction:twoAc];
        
        [self presentViewController:alert animated:YES completion:nil];

                if (index == 0) {

                }else if (index == 1){

                }else if (index == 2){

                }
                
            } whichFrame:frame animate:YES] option_show];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
