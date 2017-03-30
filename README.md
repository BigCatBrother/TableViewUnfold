# TableViewUnfold
这个小demo是之前项目中使用的一个需求，单独拿出来，效果还不错。主要是利用tableView自带刷新效果和scrollView的动画来实现TableView的展开与关闭功能。<br>
![TableViewCell.gif](http://upload-images.jianshu.io/upload_images/1977395-8367405549125533.gif?imageMogr2/auto-orient/strip)<br>
特别需要注意的几个点：<br>1.要在代理方法`- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
`中控制row的行高来实现展开与关闭。不要根据行数来进行控制。<br>2.刷新多个`section`的方法你要知道,很容易崩。
```
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
```
前提是方法
```
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
// 这个地方要全部加载进去 要不然单独刷新某Section时会崩溃 使用`heightForRowAtIndexPath`代理方法来控制展开与关闭
    NSArray *array =[_origionArr objectAtIndex:section];
    
    return array.count;

}
```
3.若果Section的下面有多处的cell的东西，可以添加代码`        cell.clipsToBounds = YES;
`
