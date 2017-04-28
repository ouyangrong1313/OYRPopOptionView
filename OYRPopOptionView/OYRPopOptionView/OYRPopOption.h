//
//  OYRPopOption.h
//  OYRPopSelected
//
//  Created by 欧阳荣 on 17/4/20.
//  Copyright © 2017年 HengTaiXin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^OYRPopOptionBlock)(NSInteger index, NSString *content);

@interface OYRPopOption : UIView


@property (nonatomic, strong) NSArray *option_optionContents;   // 内容数组 必要
@property (nonatomic, strong) NSArray *option_optionImages;     // 图片数组 非必要
@property (nonatomic, assign) CGFloat  option_lineHeight;       // 行高   如果不设置默认为40.0f
@property (nonatomic, assign) CGFloat  option_mutiple;          // 宽度比 如果不设置默认为0.35f
@property (nonatomic ,assign) float    option_animateTime;      // 设置动画时长 如果不设置默认0.2f秒 如果设置为0为没有动画

// 加载pop框
// block 你选中的选项
// 是否有动画
- (instancetype) option_setupPopOption:(OYRPopOptionBlock)block whichFrame:(CGRect)frame animate:(BOOL)animate;

/** 展示Pop 推荐使用链式语法 */
- (void) option_show;


@end
