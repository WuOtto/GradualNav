//
//  SecondViewController.m
//  GradualNavDemo
//
//  Created by halo on 2018/11/17.
//  Copyright © 2018 otto. All rights reserved.
//

#import "SecondViewController.h"
#import "UINavigationBar+ChangeColor.h"

#define kScreenW CGRectGetWidth([UIScreen mainScreen].bounds)
#define kScreenH CGRectGetHeight([UIScreen mainScreen].bounds)
#define kTabBarH (kScreenH >= 812?83:49)
#define kNavH (kScreenH >= 812?88:64)

@interface SecondViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableview;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self initBaseUI];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar start];
    
    //该页面呈现时手动调用计算导航栏此时应当显示的颜色
    //    [self scrollViewDidScroll:_tableview];
    [self.navigationController.navigationBar changeColor:[UIColor colorWithRed:64/255.0 green:224/255.0 blue:208/255.0 alpha:1] withOffsetY:0];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController.navigationBar reset];
}

- (void)initBaseUI {
    //导航栏左按钮
    UIImage *imgLeft = [[UIImage imageNamed:@"btn_nav_scan"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:imgLeft style:UIBarButtonItemStylePlain target:self action:@selector(onLeftNavBtnClick)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    //导航栏右按钮
    UIImage *imgRight = [[UIImage imageNamed:@"btn_nav_message"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:imgRight style:UIBarButtonItemStylePlain target:self action:@selector(onRightNavBtnClick)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    //中间搜索框
    UITextField *tfSearch = [[UITextField alloc] init];
    tfSearch.bounds = CGRectMake(0, 0, kScreenW - 100, 28);
    tfSearch.backgroundColor = [UIColor colorWithRed:0.918 green:0.918 blue:0.918 alpha:0.80];
    tfSearch.placeholder = @"搜索";
    tfSearch.borderStyle = UITextBorderStyleRoundedRect;
    tfSearch.font = [UIFont systemFontOfSize:14];
    self.navigationItem.titleView = tfSearch;
    
    _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, -kNavH, kScreenW, kScreenH) style:UITableViewStyleGrouped];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableview];
    
    //模拟轮播
    UIView *bannerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenW * 691 / 864 - kNavH)];
    bannerView.backgroundColor = [UIColor grayColor];
    _tableview.tableHeaderView = bannerView;
    
}

- (UIImage *)imageWithColor:(UIColor *)color {
    //创建1像素区域并开始图片绘图
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    
    //创建画板并填充颜色和区域
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    //从画板上获取图片并关闭图片绘图
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

#pragma mark - Tableview Datasource & Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 25;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuse = @"reuseCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.001f;
}

/* 滑动过程中做处理 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.navigationController.navigationBar changeColor:[UIColor redColor] withOffsetY:scrollView.contentOffset.y];
}

#pragma mark - NavItem
- (void)onLeftNavBtnClick {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)onRightNavBtnClick {
    
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
