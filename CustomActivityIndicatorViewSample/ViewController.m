//
//  ViewController.m
//  CustomActivityIndicatorViewSample
//
//  Copyright (c) 2013 makoto_kw. All rights reserved.
//

#import "ViewController.h"
#import "WZActivityIndicatorView.h"

@interface ViewController ()

{
    IBOutlet WZActivityIndicatorView *indicatorView;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [indicatorView setActivityIndicatorImage:[UIImage imageNamed:@"Loader"]];
    [indicatorView startAnimating];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
