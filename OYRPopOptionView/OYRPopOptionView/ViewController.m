//
//  ViewController.m
//  OYRPopOptionView
//
//  Created by 欧阳荣 on 17/4/28.
//  Copyright © 2017年 HengTaiXin. All rights reserved.
//

#import "ViewController.h"
#import "PopViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 100, 100);
    btn.center = self.view.center;
    [btn setTitle:@"点我开始^_^" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor grayColor];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)btnClick:(id)sender{
    PopViewController * VC = [[PopViewController alloc]init];
    UINavigationController * Nav = [[UINavigationController alloc]initWithRootViewController:VC];
    [self presentViewController:Nav animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
