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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(paste:) name:UIPasteboardChangedNotification object:nil];

    NSURL *url1 = [[NSBundle mainBundle] URLForResource:@"gif/box_jumping" withExtension:@"gif"];
    self.imageViews.image = [UIImage animatedImageWithAnimatedGIFURL:url1];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)copyImage:(id)sender
{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    NSURL *url1 = [[NSBundle mainBundle] URLForResource:@"sticker/at-work-icon" withExtension:@"png"];
    NSData *data = [NSData dataWithContentsOfURL:url1];
    UIImage* image =[UIImage imageWithData:data];
    pasteboard.image =image;
    
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    
    UIImage *img = [UIPasteboard generalPasteboard].image;

    
    if (action == @selector(paste:))
    {
        
        return  YES;
    }
    else
        return [super canPerformAction:action withSender:sender];

}
- (void)paste:(id)sender
{

   UIImage *img = [UIPasteboard generalPasteboard].image;
    
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
