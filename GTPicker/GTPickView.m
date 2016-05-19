//
//  GTPickView.m
//  GTPicker
//
//  Created by gut on 16/5/19.
//  Copyright © 2016年 com.DSDAI. All rights reserved.
//

#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight ([UIScreen mainScreen].bounds.size.height)

// 背景视图高度
#define kBgViewHeight ([UIScreen mainScreen].bounds.size.height) / 667 * 260

#define RGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

#import "GTPickView.h"

@interface GTPickView ()<UIPickerViewDelegate,UIPickerViewDataSource>

// 背景视图
@property (nonatomic,strong)UIView *bgView;

// picker视图
@property (nonatomic,strong)UIPickerView *pickerView;

@property (nonatomic,copy)NSArray *dataArray;

@end

@implementation GTPickView{
    UIButton *_cancleButton;
    UIButton *_confirmButton;
    UILabel  *_titleLabel;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = RGBA(51, 51, 51, 0.8);

        [self setupBackgroundView];
        [self showBgViewWithAnimation];
        
        [self setupBarItemAndMessageLabel];
        [self setupPickerView];
    }
    return self;
}

#pragma mark - UI

- (void)setupBackgroundView{
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, kBgViewHeight)];
    _bgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_bgView];
}

- (void)setupBarItemAndMessageLabel{
    
    // 创建左右两个按钮
    for (int i = 0; i<2; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i*(kScreenWidth - 70), 0, 70, 40);
        button.tag = i;
        [button setTitle:@[@"取消",@"确定"][i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:16];
        [button addTarget:self action:@selector(butonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_bgView addSubview:button];
        
        if (i == 0) {
            _cancleButton = button;
        }else{
            _confirmButton = button;
        }
    }
    
    // 创建一个LB
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(70, 0, kScreenWidth - 70*2, 40)];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont systemFontOfSize:16];
    [_bgView addSubview:_titleLabel];
    
    // 创建一个线条
    CALayer *lineLayer = [CALayer layer];
    lineLayer.frame = CGRectMake(0, 40, kScreenWidth, 0.5);
    lineLayer.backgroundColor = RGBA(224, 224, 224, 1).CGColor;
    [_bgView.layer addSublayer:lineLayer];

}

- (void)setupPickerView{
    _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 45, kScreenWidth, _bgView.frame.size.height - 45)];
    _pickerView.delegate = self;
    _pickerView.dataSource = self;
    [_bgView addSubview:_pickerView];
}

#pragma mark - set

- (void)setTitleString:(NSString *)titleString{
    _titleString = titleString;
    _titleLabel.text = titleString;
}

- (void)setLabelTitleColor:(UIColor *)labelTitleColor{
    _labelTitleColor = labelTitleColor;
    _titleLabel.textColor = labelTitleColor;
}

- (void)setBarItemColor:(UIColor *)barItemColor{
    _barItemColor = barItemColor;
    [_cancleButton setTitleColor:barItemColor forState:UIControlStateNormal];
    [_confirmButton setTitleColor:barItemColor forState:UIControlStateNormal];
}

- (void)setPickerSectionArray:(NSArray<NSArray *> *)pickerSectionArray{
    _pickerSectionArray = pickerSectionArray;
    self.dataArray = pickerSectionArray;
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{

    return self.dataArray.count;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{

    NSArray *rowArray = self.dataArray[component];
    return rowArray.count;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    UILabel *label=[[UILabel alloc] init];
    label.textAlignment = NSTextAlignmentCenter;
    label.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    
    return label;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    // 此处做了简单的Array数据展示，若想达到几组数据一一对应，可以将 self.pickerSectionArray 换成Dictionary，再进行一一对应
    NSArray *arr = (NSArray *)[self.dataArray objectAtIndex:component];
    return arr[row];
    
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    if (self.dataArray.count == 1) {
        return 120;
    }else if (self.dataArray.count == 2){
        return 120;
    }else{
        return 60;
    }
}

#pragma mark - buttonAction

- (void)butonClick:(id)sender{
    UIButton *button = (UIButton *)sender;
    NSLog(@"-----%ld---",(long)button.tag);
    if (button.tag == 0) {
        
        [self hideBgViewWithAnimation];
        
    }else{
        
        NSString *fullString = [NSString string];
        for (int i = 0; i < self.dataArray.count; i++) {
            
            NSArray *array = [self.dataArray objectAtIndex:i];
            
            NSString *string = [array objectAtIndex:[self.pickerView selectedRowInComponent:i]% array.count];
            fullString = [fullString stringByAppendingString:string];
                
            }
        self.PickerSelectedBlock(fullString);
        [self hideBgViewWithAnimation];
    }
}

/**
 *  显示BgView动画
 */
- (void)showBgViewWithAnimation{
    [UIView animateWithDuration:0.5 animations:^{
        
        CGRect frame = _bgView.frame;
        frame.origin.y = kScreenHeight-kBgViewHeight;
        _bgView.frame = frame;
    }];
}

/**
 *  隐藏BgView动画
 */
- (void)hideBgViewWithAnimation{
    [UIView animateWithDuration:0.5 animations:^{
        
        CGRect frame = _bgView.frame;
        frame.origin.y = kScreenHeight;
        _bgView.frame = frame;
        
    } completion:^(BOOL finished) {
        
        [_bgView removeFromSuperview];
        [self removeFromSuperview];
        
    }];
}

/**
 *  touch事件隐藏
 */
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self hideBgViewWithAnimation];
}

@end
