//
//  MainViewController.m
//  GradualNavDemo
//
//  Created by halo on 2018/11/17.
//  Copyright © 2018 otto. All rights reserved.
//

#import "MainViewController.h"
#import "ViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifierStr = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierStr];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierStr];
    }
    switch (indexPath.row) {
        case 0:
        {
            cell.textLabel.text = @"The first";
        }
            break;
        case 1:
        {
            cell.textLabel.text = @"Second VC";
        }
            break;
        case 2:
        {
            cell.textLabel.text = @"Third VC";
        }
            break;
        default:
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
        {
            UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            
            //将第二个控制器实例化，"SecondViewController"为我们设置的控制器的ID
            ViewController *vc = [mainStoryBoard instantiateViewControllerWithIdentifier:@"ViewController"];
            
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
            SecondViewController *secondVC = [[SecondViewController alloc] init];
            [self.navigationController pushViewController:secondVC animated:YES];
        }
            break;
        case 2:
        {
            ThirdViewController *thirdVC = [[ThirdViewController alloc] init];
            [self.navigationController pushViewController:thirdVC animated:YES];
        }
            break;
        default:
            break;
    }
}

@end
