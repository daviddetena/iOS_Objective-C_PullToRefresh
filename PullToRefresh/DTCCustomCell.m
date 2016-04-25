//
//  DTCCustomCell.m
//  PullToRefresh
//
//  Created by David de Tena on 25/04/16.
//  Copyright © 2016 David de Tena. All rights reserved.
//

#import "DTCCustomCell.h"

@implementation DTCCustomCell


#pragma mark - Class Methods
+(NSString *) cellId{
    return NSStringFromClass(self);
}

+(CGFloat) cellHeight{
    return 60.0f;
}


#pragma mark - View lifecycle
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
