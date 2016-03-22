//
//  viewDrawToRect.m
//  EmoticonsKeyboard
//
//  Created by duongnguyen on 3/22/16.
//  Copyright © 2016 carpediem. All rights reserved.
//

#import "viewDrawToRect.h"

@implementation viewDrawToRect

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

#pragma  mark == ve duong thang ==
// ve duong cheo
//- (void)drawRect:(CGRect)rect
//{
//    // Drawing code
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    
//    CGContextSetLineWidth(context, 3.0);
//    
//    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
//    
//    CGFloat components[] ={0.9, 0.0,1.0, 1.0}; // mau sac cho line
//    
//    CGColorRef color = CGColorCreate(colorSpace, components);
//    
//    CGContextSetStrokeColorWithColor(context, color);
//    
//    CGContextMoveToPoint(context, 30, 30);
//    
//    CGContextAddLineToPoint(context, 300, 400);
//    
//    CGContextStrokePath(context);
//    
//    CGColorSpaceRelease(colorSpace);
//    
//    CGColorRelease(color);
//    
//}

#pragma mark == ve tu giac (hinh thoi) ==

//- (void)drawRect:(CGRect)rect{
//    [super drawRect:rect];
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    
//    CGContextSetLineWidth(context, 2);
//    
//    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
//    
//    CGContextMoveToPoint(context, 100, 100);
//    
//    CGContextAddLineToPoint(context, 150, 150);
//    
//    CGContextAddLineToPoint(context, 100, 200);
//    
//    CGContextAddLineToPoint(context, 50, 150);
//
//    CGContextAddLineToPoint(context, 100, 100);
//
//    CGContextStrokePath(context);
//    
//}

#pragma mark == ve hinh chu nhat // vuong ==

//- (void)drawRect:(CGRect)rect{
//    [super drawRect:rect];
//    
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    
//    CGContextSetLineWidth(context, 3.5);
//    
//    CGContextSetStrokeColorWithColor(context, [UIColor yellowColor].CGColor);
//    
//    CGRect rectange = CGRectMake(60, 100, 200, 100); // vi tri va kich thuoc
//    
//    CGContextAddRect(context, rectange);
//    CGContextStrokePath(context);
//
//    CGContextSetFillColorWithColor(context, [UIColor blueColor].CGColor); // fill mua
//    CGContextFillRect(context, rectange);
//}

#pragma  mark == ve hinh tron // eclip

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    // shadows

    CGSize shadowOffset = CGSizeMake(-10, 5);
    
    CGContextSaveGState(context);
    
    CGContextSetShadow(context, shadowOffset, 5);
    
    CGContextSetLineWidth(context, 4);
    
    CGContextSetStrokeColorWithColor(context, [UIColor brownColor].CGColor);
    
    CGRect rectange = CGRectMake(60, 100, 200, 200);
    
    CGContextAddEllipseInRect(context, rectange);
    
    CGContextStrokePath(context);
    
    CGContextRestoreGState(context);
    
}


@end
