//
//  MyTableViewCell.m
//  TableViewCell_openAndClosedemo
//
//  Created by 陈小明 on 2017/3/30.
//  Copyright © 2017年 qianfeng. All rights reserved.
//

#import "MyTableViewCell.h"
@interface MyTableViewCell()
{
    UILabel *titleLabel;
}
@end
@implementation MyTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if(self){
      
        self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
        [self makeMainUI];
    }
    
    return self;

}
-(void)makeMainUI{

    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 5, 200, 20)];
    titleLabel.font = [UIFont systemFontOfSize:16];
    titleLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:titleLabel];

}
-(void)setIndexPath:(NSIndexPath *)indexPath{

    _indexPath = indexPath;
    
    titleLabel.text = [NSString stringWithFormat:@"section %ld row = %ld",(long)indexPath.section,(long)indexPath.row];

}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
