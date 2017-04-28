//
//  OYRPopOption.m
//  OYRPopSelected
//
//  Created by 欧阳荣 on 17/4/20.
//  Copyright © 2017年 HengTaiXin. All rights reserved.
//

#import "OYRPopOption.h"


//动态获取设备高度
#define IPHONE_HEIGHT [UIScreen mainScreen].bounds.size.height
//动态获取设备宽度
#define IPHONE_WIDTH [UIScreen mainScreen].bounds.size.width
#define kColor(R,G,B) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0]

@interface OYRPopOption ()
@property (nonnull, strong) UIView *backgroundView;
@property (nonatomic, strong) OYRPopOptionBlock optionBlock;
@property (nonatomic,strong) UIImageView * cornerImgView;
@end


@implementation OYRPopOption
- (instancetype) initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.frame = frame;
        self.alpha = 0.0f;
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3f];
    }
    return self;
}

- (instancetype) option_setupPopOption:(OYRPopOptionBlock)block whichFrame:(CGRect)frame animate:(BOOL)animate {
    self.optionBlock = block;
    [self _setupParams:animate];//设置默认状态下行高 行宽 消失时间等
    [self _setupBackgourndview:frame];
    return self;
}


- (void) option_show {
    [UIView animateWithDuration:self.option_animateTime animations:^{
        self.alpha = 1.0f;
    } completion:^(BOOL finished) {
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_tapGesturePressed)];
        [self addGestureRecognizer:tapGesture];
    }];
}


#pragma mark - private
-(void) _setupParams:(BOOL)animate {
    if (self.option_lineHeight == 0) {
        self.option_lineHeight = 0.3 * 90 * IPHONE_WIDTH /215;
    }
    if (self.option_mutiple == 0) {
        self.option_mutiple = 0.3f;///0.4f;
    }
    if (animate) {
        if (self.option_animateTime == 0) {
            self.option_animateTime = 0.2f;
        }
    } else {
        self.option_animateTime = 0;
    }
}

// 创建背景 显示按钮的背景
- (void) _setupBackgourndview:(CGRect)whichFrame {
    self.backgroundView = [UIView new];
    //self.backgroundView.userInteractionEnabled = YES;
    self.backgroundView.backgroundColor = [UIColor whiteColor];
    //self.backgroundView.layer.cornerRadius = 5;
    //self.backgroundView.layer.masksToBounds = YES;
    [self addSubview:self.backgroundView];//生成背景
    [self _setupOptionButton];//设置点击的按钮
    [self _tochangeBackgroudViewFrame:whichFrame];//设置背景的坐标

}
- (void) _setupOptionButton {
    if ((self.option_optionContents&&self.option_optionContents.count>0)) {
        for (NSInteger i = 0; i < self.option_optionContents.count; i++) {
            UIButton *optionButton = [UIButton buttonWithType:UIButtonTypeCustom];
            optionButton.frame = CGRectMake(0,
                                            self.option_lineHeight*i,
                                            self.frame.size.width * self.option_mutiple,
                                            self.option_lineHeight);//实例化选项按钮
            optionButton.tag = i;
            [optionButton addTarget:self action:@selector(_buttonSelectPressed:)
                   forControlEvents:UIControlEventTouchUpInside];
            [optionButton addTarget:self action:@selector(_buttonSelectDown:)
                   forControlEvents:UIControlEventTouchDown];
            [optionButton addTarget:self action:@selector(_buttonSelectOutside:)
                   forControlEvents:UIControlEventTouchUpOutside];
            //optionButton.backgroundColor = [UIColor redColor];
            [self.backgroundView addSubview:optionButton];
            [self _setupOptionContent:optionButton];
        }
    }
}
- (void) _setupOptionContent:(UIButton *)optionButton {
    if(self.option_optionImages&&self.option_optionImages.count>0) {
        UIImageView *headImageView = [UIImageView new];
        headImageView.frame = CGRectMake(15, self.option_lineHeight/3, self.option_lineHeight/3, self.option_lineHeight/3);
        headImageView.image = [UIImage imageNamed:self.option_optionImages[optionButton.tag]];
        [optionButton addSubview:headImageView];
        
        UILabel *contentLabel = [UILabel new];
        contentLabel.frame = CGRectMake(25 + self.option_lineHeight/3,
                                        0,
                                        self.frame.size.width - (25 + self.option_lineHeight/3),
                                        self.option_lineHeight);//
        contentLabel.text = self.option_optionContents[optionButton.tag];
        contentLabel.textColor = kColor(128, 128, 128);//[UIColor darkGrayColor];
        contentLabel.font = [UIFont systemFontOfSize:14];
        [optionButton addSubview:contentLabel];
        //contentLabel.backgroundColor = [UIColor redColor];
    } else {
        UILabel *contentLabel = [UILabel new];
        [optionButton addSubview:contentLabel];
        contentLabel.frame = optionButton.bounds;
        contentLabel.textAlignment = NSTextAlignmentCenter;
        contentLabel.text = self.option_optionContents[optionButton.tag];
        contentLabel.textColor = [UIColor darkGrayColor];
        contentLabel.font = [UIFont systemFontOfSize:15];
    }
    
    if(optionButton.tag != 0) {
        UIView *lineView = [UIView new];
        lineView.backgroundColor = [kColor(204, 204, 204) colorWithAlphaComponent:0.3];
        lineView.frame = CGRectMake(25 + self.option_lineHeight/3,
                                    self.option_lineHeight * optionButton.tag,
                                    self.frame.size.width * self.option_mutiple - (25 + self.option_lineHeight/3),
                                    0.5);
        [self.backgroundView addSubview:lineView];//除了第一个都划上线
    }
}
- (void) _tochangeBackgroudViewFrame:(CGRect)whichFrame {//这个是按钮的坐标
    CGFloat self_w = self.frame.size.width;//375  667
    
    CGFloat which_x = whichFrame.origin.x;//137.5
    CGFloat which_w = whichFrame.size.width;//100
    CGFloat which_h = whichFrame.size.height;//30
    
    CGFloat background_x = which_x-((self_w*self.option_mutiple/2)-which_w/2);//112.5  使中间点位置一样
    CGFloat background_y = whichFrame.origin.y+which_h + 10 + 15;//140 origin.y 100  往下移动10个点
    CGFloat background_w = self_w * self.option_mutiple;//150   背景的宽度
    CGFloat background_h = self.option_lineHeight*self.option_optionContents.count;//200  背景的高度
    
    if (background_x < 10) {
        background_x = 10;// 设置最小的x
    }
    if (self_w-(which_x+which_w)<=10||
        ((self_w * self.option_mutiple/2)-which_w/2>=(self_w-(which_x+which_w)))) {//一半的差 不能  大于等于 总的差 就是不能跑到界限外面去
        background_x = self_w-(self_w*self.option_mutiple)-10;
    }//最大的x
    
    self.backgroundView.frame = CGRectMake(background_x, background_y, background_w, background_h);//frame = (112.5 140; 150 200)
    self.cornerImgView.frame = CGRectMake(background_w * 0.65, - 10, 20, 15);
    //self.backgroundView.image = [UIImage imageNamed:@"bg_popover_matchdetail"];
    //self.backgroundView.backgroundColor = [UIColor redColor];
    /*
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Select"]];
    [self addSubview:imageView];
    imageView.frame = CGRectMake(which_x+which_w/2-10,
                                 background_y -15,
                                 20,
                                 15);//frame = (177.5 125; 20 15)
    */
    //imageView.frame = CGRectMake(which_w/2 - 10, -15, 20, 15);
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}
// 点击消失
- (void) _tapGesturePressed {
    [UIView animateWithDuration:self.option_animateTime animations:^{
        self.alpha = 1.0f;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:self.option_animateTime animations:^{
            self.alpha = 0.0f;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }];
}


#pragma mark - inside outside down

- (void) _buttonSelectPressed:(UIButton *)button {
    self.optionBlock(button.tag, self.option_optionContents[button.tag]);
    button.backgroundColor = [UIColor whiteColor];
    [self _tapGesturePressed];
}
- (void) _buttonSelectDown:(UIButton *)button {
    button.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
}
- (void) _buttonSelectOutside:(UIButton *)button {
    button.backgroundColor = [UIColor whiteColor];
}

-(UIImageView *)cornerImgView{
    if (!_cornerImgView) {
        _cornerImgView = [[UIImageView alloc]init];
        _cornerImgView.image = [UIImage imageNamed:@"select"];//btn_label_delete@2x  select
        [self.backgroundView addSubview:_cornerImgView];
    }
    return _cornerImgView;
}


#pragma mark - dealloc

- (void)dealloc {
    self.optionBlock = nil;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
