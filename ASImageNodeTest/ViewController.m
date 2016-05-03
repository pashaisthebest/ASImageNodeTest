//
//  ViewController.m
//  ASImageNodeTest
//
//  Created by Pavel Gurov on 03/05/16.
//  Copyright © 2016 Pavel Gurov. All rights reserved.
//

#import "ViewController.h"
#import "CCProfileBackgroundHeaderView.h"

static CGFloat const HEADER_HEIGHT = 170;
static CGFloat const HEADER_TOP_OFFSET = 20;

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) UITableViewController *embeddedTableViewController;
@property (weak, nonatomic) IBOutlet CCProfileBackgroundHeaderView *viewHeaderBackground;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerBackgroundHeightConstraint;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.embeddedTableViewController.clearsSelectionOnViewWillAppear = NO;
    self.embeddedTableViewController.tableView.dataSource = self;
    self.embeddedTableViewController.tableView.delegate = self;
    self.embeddedTableViewController.tableView.rowHeight = UITableViewAutomaticDimension;
    self.embeddedTableViewController.tableView.estimatedRowHeight = 50;
    
    UIView *header = [UIView new];
    header.backgroundColor = [UIColor clearColor];
    self.embeddedTableViewController.tableView.tableHeaderView = header;
    [self.viewHeaderBackground configure];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self sizeHeaderToFit];
}

- (void)sizeHeaderToFit {
    UIView *header = self.embeddedTableViewController.tableView.tableHeaderView;
    
    [header setNeedsLayout];
    [header layoutIfNeeded];
    
    CGFloat height = HEADER_HEIGHT;
    CGRect frame = header.frame;
    frame.size.height = height;
    header.frame = frame;
    
    self.embeddedTableViewController.tableView.tableHeaderView = header;
}


#pragma mark - Table view

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"show_detail" sender:self];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.headerBackgroundHeightConstraint.constant = MAX(20, (HEADER_TOP_OFFSET + HEADER_HEIGHT) - scrollView.contentOffset.y);
    [self.viewHeaderBackground layoutIfNeeded];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"embed_table"]) {
        self.embeddedTableViewController = segue.destinationViewController;
    }
}

@end
