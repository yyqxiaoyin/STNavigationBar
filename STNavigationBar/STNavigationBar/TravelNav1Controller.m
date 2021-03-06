//
//  TravelNav1Controller.m
//  STNavigationBar
//
//  Created by 沈兆良 on 16/5/4.
//  Copyright © 2016年 ST. All rights reserved.
//

#import "TravelNav1Controller.h"

#import "STConfig.h"
@interface TravelNav1Controller ()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIView *navigationView;
@property (nonatomic, strong) UILabel *titleView;
@property (nonatomic, strong) UIButton *buttonBack;
@property (nonatomic, assign) CGFloat headerHeight;
@end

@implementation TravelNav1Controller

#pragma mark - --- lift cycle 生命周期 ---

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.tableView];

    // 1.去掉背景图片和底部线条
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];

    [self.navigationController.navigationBar addSubview:self.navigationView];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.buttonBack];

    UIView *tableHeaderView = [[UIView alloc] initWithFrame:self.imageView.bounds];
    [tableHeaderView addSubview:self.imageView];
    self.tableView.tableHeaderView = tableHeaderView;

}
#pragma mark - --- delegate 视图委托 ---
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY = scrollView.contentInset.top + scrollView.contentOffset.y;
    CGFloat progress = offsetY / (self.headerHeight - 20);
    CGFloat progressChange = offsetY / (self.headerHeight - 64*2);
    NSLog(@"%s, %f, %f, %f", __FUNCTION__ ,progressChange, progress, offsetY);
    if (progress <= 0) {
        self.imageView.y = offsetY;
        self.imageView.height = self.headerHeight - offsetY;
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    }

    if (progressChange >= 1) {

        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
             self.navigationView.y = - STStatusBarHeight;
        } completion:^(BOOL finished) {
        }];
    }else {

        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            self.navigationView.y = - (STNavigationBarHeight + STStatusBarHeight * 2);
        } completion:^(BOOL finished) {
        }];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"
                                                            forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"cell %ld", (long)indexPath.row];
    return cell;
}
#pragma mark - --- event response 事件相应 ---

#pragma mark - --- private methods 私有方法 ---

#pragma mark - --- getters and setters 属性 ---

- (UITableView *)tableView
{
    if (!_tableView) {
        CGFloat tableX = 0;
        CGFloat tableY = -(STNavigationBarHeight + STStatusBarHeight);
        CGFloat tableW = ScreenWidth;
        CGFloat tableH = ScreenHeight - tableY;
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(tableX, tableY, tableW, tableH) style:UITableViewStylePlain];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (UIView *)navigationView
{
    if (!_navigationView) {
        CGFloat viewX = 0;
        CGFloat viewY = - (STNavigationBarHeight + STStatusBarHeight * 2);
        CGFloat viewW = ScreenWidth;
        CGFloat viewH = STNavigationBarHeight+STStatusBarHeight;
        _navigationView = [[UIView alloc]initWithFrame:CGRectMake(viewX, viewY, viewW, viewH)];
        _navigationView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.85];
        [_navigationView addSubview:self.titleView];
    }
    return _navigationView;
}

- (UILabel *)titleView
{
    if (!_titleView) {
        CGFloat viewX = 100;
        CGFloat viewY = STStatusBarHeight;
        CGFloat viewW = ScreenWidth - 2 * viewX;
        CGFloat viewH = STNavigationBarHeight;
        _titleView = [[UILabel alloc]initWithFrame:CGRectMake(viewX, viewY, viewW, viewH)];
        _titleView.textAlignment = NSTextAlignmentCenter;
        _titleView.text = @"香港";
    }
    return _titleView;
}

- (UIImageView *)imageView
{
    if (!_imageView) {
        CGFloat viewX = 0;
        CGFloat viewY = 0;
        CGFloat viewW = ScreenWidth;
        CGFloat viewH = self.headerHeight;
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(viewX, viewY, viewW, viewH)];
        _imageView.image  = [UIImage imageNamed:@"xianggang"];
        [_imageView.layer setMasksToBounds:YES];
    }
    return _imageView;
}

- (UIButton *)buttonBack
{
    if (!_buttonBack) {
        CGFloat viewX = 0;
        CGFloat viewY = 0;
        CGFloat viewW = 13;
        CGFloat viewH = 21;
        _buttonBack = [[UIButton alloc]initWithFrame:CGRectMake(viewX, viewY, viewW, viewH)];
        [_buttonBack setBackgroundImage:[UIImage imageNamed:@"backArrow"] forState:UIControlStateNormal];
    }
    return _buttonBack;
}

- (CGFloat)headerHeight
{
    return ScreenWidth / 2;
}


@end


