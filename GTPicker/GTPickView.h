//
//  GTPickView.h
//  GTPicker
//
//  Created by gut on 16/5/19.
//  Copyright © 2016年 com.DSDAI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GTPickView : UIView

/**
 *  初始化创建对象
 *
 *  @param frame 创建时frame设置为屏幕大小
 *
 *  @return self
 */
- (instancetype)initWithFrame:(CGRect)frame;

/**
 *  picker的区数组，里面元素包含每个区选择数据的数组
 */
@property (nonatomic,strong) NSArray<NSArray *> *pickerSectionArray;

/**
 *  picker展示的标题
 */
@property (nonatomic,copy) NSString *titleString;

/**
 *  标题颜色
 */
@property (nonatomic,strong) UIColor *labelTitleColor;

/**
 *  按钮颜色
 */
@property (nonatomic,strong) UIColor *barItemColor;

/**
 *  确定选择后的回调
 */
@property (nonatomic,copy) void(^PickerSelectedBlock)(NSString *selectedItem);

@end
