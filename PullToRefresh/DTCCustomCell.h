//
//  DTCCustomCell.h
//  PullToRefresh
//
//  Created by David de Tena on 25/04/16.
//  Copyright © 2016 David de Tena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DTCCustomCell : UITableViewCell

#pragma mark - Properties
@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;


#pragma mark - Class Methods
+(NSString *) cellId;
+(CGFloat) cellHeight;

@end
