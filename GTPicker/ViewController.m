//
//  ViewController.m
//  GTPicker
//
//  Created by gut on 16/5/19.
//  Copyright © 2016年 com.DSDAI. All rights reserved.
//

#import "ViewController.h"
#import "GTPickView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor redColor];
    button.frame = CGRectMake(0, 0, 200, 100);
    button.center = self.view.center;
    [button addTarget:self action:@selector(butonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];

}

- (void)butonClick{
    GTPickView *pick = [[GTPickView alloc] initWithFrame:self.view.bounds];
    pick.barItemColor = [UIColor blackColor];
    pick.labelTitleColor = [UIColor blueColor];
     pick.titleString = @"请做出选择";
    pick.pickerSectionArray = @[@[@"詹姆斯",@"科比",@"库日天",@"汤普森",@"阿杜",@"威少"],@[@"nan",@"nv",@"renyao"]];
    pick.PickerSelectedBlock = ^(NSString *fullString){
        NSLog(@"-----%@-----",fullString);
    };
    [self.view addSubview:pick];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
