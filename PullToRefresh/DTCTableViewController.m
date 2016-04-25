//
//  DTCTableViewController.m
//  PullToRefresh
//
//  Created by David de Tena on 25/04/16.
//  Copyright © 2016 David de Tena. All rights reserved.
//

#import "DTCTableViewController.h"
#import "DTCCustomCell.h"

@interface DTCTableViewController ()
@property (nonatomic, strong) NSNumber *numberOfItems;
@end


@implementation DTCTableViewController

#pragma mark - View lifecycle


- (id) initWithStyle:(UITableViewStyle) style{
    if(self = [super initWithStyle:style]){
        // Custom number of items
        _numberOfItems = @5;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self registerNib];
    self.title = @"Pull To Refresh";
    
    // Add pull to refresh feature
    [self addPullToRefresh];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// Register nib for the table w/ our custom cell
-(void) registerNib{
    // Register nib for custom cell
    UINib *nib = [UINib nibWithNibName:@"DTCCustomCellViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:[DTCCustomCell cellId]];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.numberOfItems integerValue];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Grab custom cell and configure UI
    DTCCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:[DTCCustomCell cellId]];
    cell.titleLabel.text = @"Uncharted 4: A thief's end";
    cell.descLabel.text = @"May 10th, 2016";
    cell.photoView.image = [UIImage imageNamed:@"uncharted4.jpg"];
    cell.iconView.image = [UIImage imageNamed:@"favorite.png"];
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [DTCCustomCell cellHeight];
}


#pragma mark - Utils

// Implement pull to refresh feature
-(void) addPullToRefresh{
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor colorWithWhite:0.8f alpha:1.0f];
    self.refreshControl.tintColor = [UIColor whiteColor];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc]
                                           initWithString:@"Downloading..."
                                           attributes:@{NSFontAttributeName:[UIFont italicSystemFontOfSize:12]}];
    
    //add a target/action
    [self.refreshControl addTarget:self
                            action:@selector(refreshedByPullingTable:)
                  forControlEvents:UIControlEventValueChanged];
}

// What to do when pulling table
-(void) refreshedByPullingTable:(UITableView *)aTableView{
    
    // Start refreshing control
    [self.refreshControl beginRefreshing];
    
    // Add 10 new items after refreshing
    NSInteger items = [self.numberOfItems integerValue];
    self.numberOfItems = @(items + 10);
    
    // Delay 3 seconds to simulate that new data is being downloaded and reload table data in main queue
    double delayInSeconds = 3.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW,(int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self.refreshControl endRefreshing];
        [self.tableView reloadData];
    });
}

@end
