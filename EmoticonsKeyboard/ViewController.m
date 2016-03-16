//
//  ViewController.m
//  EmoticonsKeyboard
//
//  Created by duongnguyen on 3/12/16.
//  Copyright © 2016 carpediem. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

{
    NSMutableArray * gifsDatalist;
    
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadGifsData];
    
    NSURL *url1 = [[NSBundle mainBundle] URLForResource:@"gif/box_jumping" withExtension:@"gif"];
    self.imageViews.image = [UIImage animatedImageWithAnimatedGIFURL:url1];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-  (void) loadGifsData
{
    gifsDatalist =[@[]mutableCopy];
    NSString * menuPlistPath = [[NSBundle mainBundle] pathForResource:@"GifsDataList" ofType:@"plist"];
    gifsDatalist= [NSMutableArray arrayWithContentsOfFile:menuPlistPath];
    
    
    //    NSArray *PhotoArray = [[NSBundle mainBundle] pathsForResourcesOfType:@"gif" inDirectory:@"gif"];
    //    NSMutableArray *imgQueue = [[NSMutableArray alloc] initWithCapacity:PhotoArray.count];
    //    for (NSString* path in PhotoArray) {
    //        [imgQueue addObject:[UIImage imageWithContentsOfFile:path]];
    //    }
    //    gifsDatalist = imgQueue;
    
}


@end
