//
//  DetailViewController.m
//  ASImageNodeTest
//
//  Created by Pavel Gurov on 03/05/16.
//  Copyright © 2016 Pavel Gurov. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
- (IBAction)returnTap:(UIButton *)sender;
@end

@implementation DetailViewController

- (IBAction)returnTap:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
