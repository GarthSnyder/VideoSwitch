//
//  ViewController.h
//  Video Switch
//
//  Created by Lion User on 3/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController : UIViewController
{
    NSMutableArray *players;
    AVPlayerLayer *playerLayer;
}

@property (nonatomic) IBOutlet UIView *videoView;

- (IBAction) selectVideo:(id)sender;

@end
