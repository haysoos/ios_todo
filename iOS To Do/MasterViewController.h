//
//  MasterViewController.h
//  iOS To Do
//
//  Created by Y.CORP.YAHOO.COM\jmedrano on 8/4/13.
//  Copyright (c) 2013 Y.CORP.YAHOO.COM\jmedrano. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface MasterViewController : UITableViewController

@property (strong, nonatomic) DetailViewController *detailViewController;

@end
