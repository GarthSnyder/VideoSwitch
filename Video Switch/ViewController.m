//
//  ViewController.m
//  Video Switch
//
//  Created by Garth Snyder on 3/9/12.
//

#import "ViewController.h"

@interface ViewController ()

- (void) playItemAtIndex:(NSUInteger)idx;

@end

@implementation ViewController

@synthesize videoView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSArray *videoTitles = [NSArray arrayWithObjects:@"Ultimate Dog Tease", @"Backin Up", @"Herman Cain", nil];
	players = [NSMutableArray array];
    for (NSString *title in videoTitles) {
        AVPlayerItem *player = [AVPlayer playerWithURL:[[NSBundle mainBundle] URLForResource:title withExtension:@"mp4"]];
        [player addObserver:self forKeyPath:@"status" options:0 context:nil];
        [players addObject:player];
    }
    playerLayer = [AVPlayerLayer playerLayerWithPlayer:[players objectAtIndex:0]];
    playerLayer.frame = self.videoView.layer.bounds;
    playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    [self.videoView.layer addSublayer:playerLayer];
}

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [object removeObserver:self forKeyPath:@"status"];
    for (AVPlayer *player in players) {
         if (player.status != AVPlayerStatusReadyToPlay) {
             return;
         }
    }
    // All videos are ready to go
    [self playItemAtIndex:0];
}

- (void) playItemAtIndex:(NSUInteger)idx
{
    AVPlayer *newPlayer = [players objectAtIndex:idx];
    if (newPlayer != playerLayer.player) {
        [playerLayer.player pause];
        playerLayer.player = newPlayer;
    }
    [newPlayer play];
}

- (IBAction) selectVideo:(id)sender 
{
    [self playItemAtIndex:((UILabel *)sender).tag];
}

@end


