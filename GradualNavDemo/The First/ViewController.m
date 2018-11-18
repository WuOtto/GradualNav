//
//  ViewController.m
//  GradualNavDemo
//
//  Created by halo on 2018/11/17.
//  Copyright © 2018 otto. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+imageWithColor.h"

#define kScreenW CGRectGetWidth([UIScreen mainScreen].bounds)
#define kScreenH CGRectGetHeight([UIScreen mainScreen].bounds)
#define kTabBarH (kScreenH >= 812?83:49)
#define kNavH (kScreenH >= 812?88:64)

#define oriOfftY -244
#define oriHeight 200

static NSString *identifierStr = @"cell";

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageHeight;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self navigationSettings];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifierStr];
    //当调用contentInset会自动调用scrollViewDidScroll
    self.tableView.contentInset = UIEdgeInsetsMake(244, 0, 0, 0);
}

#pragma mark - navigation settings
- (void)navigationSettings {
    // 设置导航栏的背景
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    // 取消掉底部的那根线
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    //设置标题
    UILabel *title = [[UILabel alloc] init];
    title.text = @"个人主页";
    [title sizeToFit];
    // 开始的时候看不见，所以alpha值为0
    title.textColor = [UIColor colorWithWhite:0 alpha:0];
    
    self.navigationItem.titleView = title;
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierStr];
    cell.textLabel.text = [NSString stringWithFormat:@"%u",arc4random()%255];
    return cell;
}

#pragma mark - scrollview
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    NSLog(@"%f", scrollView.contentOffset.y);
    CGFloat offset = scrollView.contentOffset.y - oriOfftY;
    
    CGFloat imgH = oriHeight - offset;
    if (imgH < kNavH) {
        imgH = kNavH;
    }
    self.imageHeight.constant = imgH;
    
    //根据透明度来生成图片
    //找最大值/
    CGFloat alpha = offset * 1 / 136.0;   // (200 - 64) / 136.0f
    if (alpha >= 1) {
        alpha = 0.99;
    }
    
    //拿到标题 标题文字的随着移动高度的变化而变化
    UILabel *titleL = (UILabel *)self.navigationItem.titleView;
    titleL.textColor = [UIColor colorWithWhite:0 alpha:alpha];
    
    //把颜色生成图片
    UIColor *alphaColor = [UIColor colorWithWhite:1 alpha:alpha];
    //把颜色生成图片
    UIImage *alphaImage = [UIImage imageWithColor:alphaColor];
    //修改导航条背景图片
    [self.navigationController.navigationBar setBackgroundImage:alphaImage forBarMetrics:UIBarMetricsDefault];
    
}


@end
