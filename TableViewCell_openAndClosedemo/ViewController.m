//
//  ViewController.m
//  TableViewCell_openAndClosedemo
//
//  Created by qianfeng on 15/11/25.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "ViewController.h"
#import "MyTableViewCell.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_origionArr;
    NSArray *_arr0;
    NSArray *_arr1;
    NSArray *_arr2;
   
    NSInteger selectSection;// 第一次选中的section
    NSInteger oldSection; // 旧的section

}

@end

@implementation ViewController

#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

#define SCREEN_WIDTH     [UIScreen mainScreen].bounds.size.width

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self makeTableView];

}
-(void)initData{

    self.view.backgroundColor =[UIColor redColor];
    _origionArr =[[NSMutableArray alloc] initWithCapacity:0];
    selectSection =0;
    oldSection = 0;
    // 展示数据源
    _arr0 =@[@"数据源0",@"数据源1",@"数据源2",@"数据源3"];
    _arr1 =@[@"数据源4",@"数据源5",@"数据源6",@"数据源7"];
    _arr2 =@[@"数据源8",@"数据源9",@"数据源10",@"数据源11"];
    
    
    [_origionArr addObject:_arr0];
    [_origionArr addObject:_arr1];
    [_origionArr addObject:_arr2];

}
-(void)makeTableView{
    
    _tableView =[[UITableView alloc] initWithFrame:CGRectMake(0,64,self.view.frame.size.width, self.view.frame.size.height)];
    _tableView.backgroundColor =[UIColor whiteColor];
    _tableView.delegate =self;
    _tableView . sectionFooterHeight = 1.0;
    _tableView.dataSource =self;
    [self.view addSubview:_tableView];
    UIView *footView = [[UIView alloc] init];
    _tableView.tableFooterView = footView;

}
#pragma mark - TableView Delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _origionArr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
// 这个地方要全部加载进去 要不然单独刷新某Section时会崩溃 使用`heightForRowAtIndexPath`代理方法来控制展开与关闭
    NSArray *array =[_origionArr objectAtIndex:section];
    
    return array.count;

}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 55;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat result = 0;

    UIScrollView *scrollView=(UIScrollView*)[self.view viewWithTag:selectSection+1000];
    
       if(selectSection == indexPath.section) {
           
           if(scrollView.contentOffset.y ==40){
           
               result = 0;
           }else{
           
               result = 30;
           }
           
        }else{
            result = 0;
        }
    return result;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    CGFloat headerHeight = 55;
    UIView* headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, headerHeight)];
    [headerView setBackgroundColor:[UIColor whiteColor]];
    // 选择头View
    UIView *selectView =[[UIView alloc] initWithFrame:CGRectMake(10, 15, SCREEN_WIDTH-20,40)];
    selectView.layer.masksToBounds=YES;
    selectView.layer.cornerRadius =3.0f;
    selectView.tag =7000+section;
    [headerView addSubview:selectView];
    if(selectSection !=section){
        selectView.layer.borderColor =RGBACOLOR(187, 187, 187, 1).CGColor;
        selectView.layer.borderWidth=1.0f;
    }else{
        
        selectView.layer.borderColor =RGBACOLOR(29, 187, 214, 1).CGColor;
        selectView.layer.borderWidth=1.0f;
    }
    // 图片背景
    UIView *imageBackView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    if(selectSection!=section){
        imageBackView.backgroundColor =RGBACOLOR(187, 187, 187, 1);
    }else{
        imageBackView.backgroundColor =RGBACOLOR(29, 187, 214, 1);
    }
    [selectView addSubview:imageBackView];
    
    // 动画scrollView
    UIScrollView *imageScroll =[[UIScrollView alloc] initWithFrame:CGRectMake(0,0,40, 40)];
    imageScroll.contentSize =CGSizeMake(40,40*2);
    imageScroll.bounces =NO;
    imageScroll.pagingEnabled =YES;
    imageScroll.tag =section+1000;
    imageScroll.backgroundColor =[UIColor clearColor];
    [selectView addSubview:imageScroll];
    
    NSArray *imageArr =@[[UIImage imageNamed:@"pluse"],[UIImage imageNamed:@"minus"]];
    
    for (NSInteger i=0; i<2; i++) {
        UIImageView *imageView =[[UIImageView alloc] initWithFrame:CGRectMake(0,i*40,40,40)];
        imageView.backgroundColor =[UIColor clearColor];
        imageView.image =imageArr[i];
        [imageScroll addSubview:imageView];
    }
    
    if(selectSection==section){
        imageScroll.contentOffset=CGPointMake(0,40);
    }else{
        
        imageScroll.contentOffset=CGPointMake(0,0);
    }
    
    UILabel* sectionLabel = [[UILabel alloc] initWithFrame:CGRectMake(55, 10, SCREEN_WIDTH - 80, 20)];
    [sectionLabel setBackgroundColor:[UIColor clearColor]];
    [sectionLabel setTextColor:RGBACOLOR(29, 187, 214, 1)];
    [sectionLabel setFont:[UIFont systemFontOfSize:17]];
    
    sectionLabel.text = [NSString stringWithFormat:@"Section %ld 号",(long)section];
    
    [selectView addSubview:sectionLabel];
    
    UITapGestureRecognizer *tapGes =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapgesDown:)];
    
    [selectView addGestureRecognizer:tapGes];

    return headerView;
}
- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell* cell = nil;
    NSString* cellIdentifier = [NSString stringWithFormat:@"courseDetailCells_%d_%d",(int)indexPath.section,(int)indexPath.row];
    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    

    if (cell == nil) {
    
        MyTableViewCell* myCell = [[MyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        [cell setBackgroundColor:[UIColor whiteColor]];
        [myCell setIndexPath:indexPath];
        cell = myCell;
        cell.clipsToBounds = YES;
    }

    
    return cell;
}
#pragma mark - 手势方法
-(void)tapgesDown:(UITapGestureRecognizer*)tapges{
    //  NSLog(@"====%ld",tapges.view.tag);
    
    oldSection = selectSection;
    selectSection = tapges.view.tag-7000;
   // NSLog(@"selectSection==%ld",(long)selectSection);
    NSInteger oldCount = [[_origionArr objectAtIndex:oldSection] count];
    NSInteger selectedCount = [[_origionArr objectAtIndex:selectSection] count];
    // 改变背景边框
    UIView *selectView =(UIView*)[self.view viewWithTag:selectSection+7000];
    UIView *oldView =(UIView*)[self.view viewWithTag:oldSection+7000];
    oldView.layer.borderColor =RGBACOLOR(187, 187, 187, 1).CGColor;
    oldView.layer.borderWidth=1.0f;
    selectView.layer.borderColor =RGBACOLOR(29, 187, 214, 1).CGColor;
    selectView.layer.borderWidth=1.0f;
    // 刷新indexpath row的标准方式
    if(oldSection != selectSection){
        
        NSMutableArray* oldIndexPathArray = [NSMutableArray arrayWithCapacity:0];
        
        for (int i = 0; i < oldCount; i++) {
            NSIndexPath* indexPath = [NSIndexPath indexPathForRow:i inSection:oldSection];
            [oldIndexPathArray addObject:indexPath];
        }
        
        NSMutableArray* selectedIndexPathArray = [NSMutableArray arrayWithCapacity:0];
        for (int i = 0; i < selectedCount; i++) {
            NSIndexPath* indexPath = [NSIndexPath indexPathForRow:i inSection:selectSection];
            [selectedIndexPathArray addObject:indexPath];
        }
        
        NSMutableArray* rowsArray = [NSMutableArray arrayWithCapacity:0];
        [rowsArray addObjectsFromArray:oldIndexPathArray];
        [rowsArray addObjectsFromArray:selectedIndexPathArray];
        
        [_tableView reloadRowsAtIndexPaths:rowsArray withRowAnimation:UITableViewRowAnimationBottom];
        [NSTimer scheduledTimerWithTimeInterval:0.2f target:self selector:@selector(chnageScrollView) userInfo: nil repeats:NO];
    }else{
    
       // NSLog(@">>>");
        
        NSMutableArray* oldIndexPathArray = [NSMutableArray arrayWithCapacity:0];
        
        for (int i = 0; i < oldCount; i++) {
            NSIndexPath* indexPath = [NSIndexPath indexPathForRow:i inSection:oldSection];
            [oldIndexPathArray addObject:indexPath];
        }

        [_tableView reloadRowsAtIndexPaths:oldIndexPathArray withRowAnimation:UITableViewRowAnimationBottom];
        [NSTimer scheduledTimerWithTimeInterval:0.2f target:self selector:@selector(chnageScrollView) userInfo: nil repeats:NO];
    
    }
}
-(void)chnageScrollView{
    
    UIScrollView *scrollView=(UIScrollView*)[self.view viewWithTag:selectSection+1000];
    UIScrollView *scrollView2=(UIScrollView*)[self.view viewWithTag:oldSection+1000];
    
    if(oldSection !=selectSection){
        scrollView2.contentOffset =CGPointMake(0,40);
        scrollView.contentOffset = CGPointMake(0, 0);
        [UIView animateWithDuration:0.3f animations:^{
            scrollView.contentOffset =CGPointMake(0,40);
            scrollView2.contentOffset =CGPointMake(0,0);
        }];
    }else{

        if(scrollView2.contentOffset.y ==40){
        
            [UIView animateWithDuration:0.3f animations:^{

                scrollView2.contentOffset =CGPointMake(0,0);
            }];
        
        }else{
        
            [UIView animateWithDuration:0.3f animations:^{
                scrollView2.contentOffset =CGPointMake(0,40);
            }];
        }
    }
}


@end
