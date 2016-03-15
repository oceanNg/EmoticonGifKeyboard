//
//  KeyboardViewController.m
//  emoticonsKeyboardFrame
//
//  Created by admin on 3/13/16.
//  Copyright © 2016 carpediem. All rights reserved.
//

#import "KeyboardViewController.h"
#define screenWidth [UIScreen mainScreen].bounds.size.width

static const CGFloat stickerWight = 60;
static const CGFloat  gifWight = 100;


static const

@interface KeyboardViewController ()
{

    CGSize keyBoardSize;
}
@property (nonatomic, strong) UIButton *nextKeyboardButton;
@end

@implementation KeyboardViewController

- (void)updateViewConstraints {
    [super updateViewConstraints];
    
    // Add custom view sizing constraints here
}

- (void)viewDidLoad {
    [super viewDidLoad];
    isShowsTickers = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardDidchange:) name:UIKeyboardDidChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    
    [self setupViewChangeWhileShowSticker];
    [self loadGifsData];
    [self loadStickersData];

    [self setupScrollView];
    
   

    
    // Perform custom UI setup here
//    self.nextKeyboardButton = [UIButton buttonWithType:UIButtonTypeSystem];
//    
//    [self.nextKeyboardButton setTitle:NSLocalizedString(@"Next Keyboard", @"Title for 'Next Keyboard' button") forState:UIControlStateNormal];
//    [self.nextKeyboardButton sizeToFit];
//    self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = NO;
//    
//    [self.nextKeyboardButton addTarget:self action:@selector(advanceToNextInputMode) forControlEvents:UIControlEventTouchUpInside];
//    
//    [self.view addSubview:self.nextKeyboardButton];
//    
//    NSLayoutConstraint *nextKeyboardButtonLeftSideConstraint = [NSLayoutConstraint constraintWithItem:self.nextKeyboardButton attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0];
//    NSLayoutConstraint *nextKeyboardButtonBottomConstraint = [NSLayoutConstraint constraintWithItem:self.nextKeyboardButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0];
//    [self.view addConstraints:@[nextKeyboardButtonLeftSideConstraint, nextKeyboardButtonBottomConstraint]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated
}

- (void) setupViewChangeWhileShowSticker
{
    [backBtn setHidden:!isShowsTickers];
    [nextBtn setHidden:isShowsTickers];
    titleLabel.text = isShowsTickers ? @"GIFS" : @"STICKERS";
    
 }

#pragma  mark == keyboard ==

- (void) keyBoardDidchange:(NSNotification *) notifi
{
    keyBoardSize = [[[notifi userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    [self setUpSubScrollView];
    
}
- (void) keyboardDidShow:(NSNotification *)notifi
{
    
    keyBoardSize= [[[notifi userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    [self setUpSubScrollView];


}
#pragma  mark -- load data list --

-(void)loadStickersData
{
    NSArray *PhotoArray = [[NSBundle mainBundle] pathsForResourcesOfType:@"png" inDirectory:@"sticker"];
    NSMutableArray *imgQueue = [[NSMutableArray alloc] initWithCapacity:PhotoArray.count];
    for (NSString* path in PhotoArray) {
        [imgQueue addObject:[UIImage imageWithContentsOfFile:path]];
    }
    stickersDatalist =[@[]mutableCopy];
    stickersDatalist = imgQueue;
    
}
-  (void) loadGifsData
{
    NSArray *PhotoArray = [[NSBundle mainBundle] pathsForResourcesOfType:@"gif" inDirectory:@"gif"];
    NSMutableArray *imgQueue = [[NSMutableArray alloc] initWithCapacity:PhotoArray.count];
    for (NSString* path in PhotoArray) {
        [imgQueue addObject:[UIImage imageWithContentsOfFile:path]];
    }
    gifsDatalist =[@[]mutableCopy];
    gifsDatalist = imgQueue;

}

- (void) removeAllSubViews :(UIScrollView *)viewHeader{
    
    for (UIImageView *vioew in viewHeader.subviews) {
        [vioew removeFromSuperview];
        
    }
}


#pragma  mark == setup ScrollView ==

- (void) setupScrollView
{
    scrollview.contentSize = CGSizeMake(screenWidth  * 2, scrollview.frame.size.height -5);
    scrollview.tag = 10;
    scrollview.alwaysBounceVertical= NO;
    scrollview.scrollsToTop = NO;
    scrollviewSticker =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, scrollview.frame.size.width, scrollview.frame.size.height)];
    scrollviewSticker.tag = 15;
    scrollviewSticker.backgroundColor =[UIColor clearColor];
    scrollviewSticker.alwaysBounceVertical= YES;
    scrollviewSticker.alwaysBounceHorizontal = NO;
    
    scrollviewGifs =[[UIScrollView alloc] initWithFrame:CGRectMake(screenWidth, 0, scrollview.frame.size.width, scrollview.frame.size.height)];
    scrollviewGifs.tag = 20;
    scrollviewGifs.alwaysBounceVertical= YES;
    scrollviewGifs.alwaysBounceHorizontal = NO;
    scrollviewGifs.backgroundColor =[UIColor clearColor];
    scrollview.backgroundColor =[UIColor clearColor];

    [scrollview addSubview:scrollviewSticker];
    [scrollview addSubview:scrollviewGifs];
    [self setUpSubScrollView];
//    [self.view addSubview:stickersCollectionView];
    

}

-(void)setUpSubScrollView
{
   
    int colNumStiker = (int) (screenWidth /stickerWight);
    int rowNumSticker = (int)(stickersDatalist.count / colNumStiker);
    
    NSInteger rows = 0;
    NSInteger columns = 0;
    for (int i = 0; i < stickersDatalist.count; i++) {
        
        // Pagination
        if (i % (rowNumSticker * colNumStiker) == 0) {
            rows = 0;    // the number of lines is 0
            columns = 0; // the number of columns is 0
        }else if (i % colNumStiker == 0) {
            // NewLine
            rows += 1;   // Increase the number of lines
            columns = 0; // The number of columns is 0
        }
        
        CGRect currentRect = CGRectMake(columns * stickerWight,
                                        rows * stickerWight,
                                        stickerWight,
                                        stickerWight);
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:currentRect];
        imageView.image = stickersDatalist[i];
        imageView.userInteractionEnabled = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
         columns++;
        imageView.clipsToBounds = YES;
        [scrollviewSticker addSubview:imageView];
        scrollviewSticker.contentSize = CGSizeMake(screenWidth,stickerWight * rowNumSticker);
        
    }
    
    int colNumGifs = (int) (screenWidth /gifWight);
    int rowNumGits = (int)(gifsDatalist.count / colNumGifs);
    
    NSInteger rowG = 0;
    NSInteger columnG = 0;
    for (int k = 0; k < gifsDatalist.count; k++) {
        
        // Pagination
        if (k % (rowNumGits * colNumGifs) == 0) {
            rowG = 0;    // the number of lines is 0
            columnG = 0; // the number of columns is 0
        }else if (k % colNumGifs == 0) {
            // NewLine
            rowG += 1;   // Increase the number of lines
            columnG = 0; // The number of columns is 0
        }
        
        CGRect currentRect = CGRectMake((columnG * gifWight) +3 + columnG * 3 ,
                                        rowG * gifWight +3 + rowG * 3,
                                        gifWight,
                                        gifWight);
        
        UIImageView *imageViews = [[UIImageView alloc] initWithFrame:currentRect];
        
        imageViews.userInteractionEnabled = YES;
        imageViews.contentMode = UIViewContentModeScaleToFill;
        columnG++;
        imageViews.image = [gifsDatalist objectAtIndex:k];
        imageViews.clipsToBounds = YES;
       
        
        [scrollviewGifs addSubview:imageViews];
        scrollviewGifs.contentSize = CGSizeMake(screenWidth ,gifWight * rowNumGits +10 + rowG * 3    );
        
    }

    
    
}

- (void)scrollViewDidScroll:(UIScrollView *)_scrollView
{
    if (_scrollView.tag == 10) {
        CGFloat pageWidth = screenWidth;
        float fractionalPage = _scrollView.contentOffset.x / pageWidth;
        NSInteger pageScrollView= lround(fractionalPage);
        isShowsTickers = pageScrollView =0 ? YES : NO;
        [self setupViewChangeWhileShowSticker];
        
        
    }
}

#pragma  mark == collection view ==

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
    
}

-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return isShowsTickers ? stickersDatalist.count : gifsDatalist.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *  cell = (UICollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"collectionView" forIndexPath:indexPath];
    if(!cell)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:@"collectionView" owner:nil options:nil][0];
    }
    
    UIImageView * imageView = (UIImageView *)  [cell viewWithTag:101];
    imageView.image = isShowsTickers ? [stickersDatalist objectAtIndex: indexPath.row] : [gifsDatalist objectAtIndex:indexPath.row];
    
    
    return  cell;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((screenWidth-40)/3, (screenWidth-40)/3);
}

#pragma  mark == text input change ==

- (void)textWillChange:(id<UITextInput>)textInput
{
    // The app is about to change the document's contents. Perform any preparation here.
}

- (void)textDidChange:(id<UITextInput>)textInput
{
    // The app has just changed the document's contents, the document context has been updated.
    
    UIColor *textColor = nil;
    if (self.textDocumentProxy.keyboardAppearance == UIKeyboardAppearanceDark) {
        textColor = [UIColor whiteColor];
    } else {
        textColor = [UIColor blackColor];
    }
//    [self.nextKeyboardButton setTitleColor:textColor forState:UIControlStateNormal];
}



#pragma  mark == Action Method ==
- (IBAction)didpressBackBtn:(id)sender
{
    isShowsTickers = YES;
    [scrollview setContentOffset:CGPointMake(0, 0)];
    [self setupViewChangeWhileShowSticker];

}
- (IBAction)didPressNext:(id)sender {
    isShowsTickers = NO;
    [scrollview setContentOffset:CGPointMake(screenWidth, 0)];
    [self setupViewChangeWhileShowSticker];
}
- (IBAction)didPressBackSpaceBtn:(id)sender
{
    [self.textDocumentProxy deleteBackward];
}
- (IBAction)didPressShareBtn:(id)sender {
    
    [self.textDocumentProxy insertText:@"Hello world"];

}

- (IBAction)didPressHelpBtn:(id)sender
{
    [helpView setHidden:NO];
    
}

- (IBAction)didPressGlobebtn:(id)sender
{
    //required functionality, switches to user's next keyboard
    [self advanceToNextInputMode];
}

#pragma  mark -- help Content view --
- (IBAction)didPresshelpContentBtn:(id)sender {
}


@end
