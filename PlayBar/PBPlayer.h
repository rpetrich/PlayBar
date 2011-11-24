//
//  PBPlayer.h
//  PlayBar
//
//  Created by Ryan Petrich on 11-11-23.
//  Copyright (c) 2011 Ryan Petrich. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PBPlayer : NSObject {
@private
    NSString *_bundleIdentifier;
    NSAppleScript *_titleScript;
    NSAppleScript *_toggleScript;
    NSAppleScript *_nextScript;
    NSRunningApplication *_runningApplication;
}

+ (id)playerWithBundleIdentifier:(NSString *)bundleIdentifier;

@property (nonatomic, readonly) NSString *currentTitle;
- (BOOL)togglePlaying;
- (BOOL)nextTrack;

@end
