//
//  PBPlayer.m
//  PlayBar
//
//  Created by Ryan Petrich on 11-11-23.
//  Copyright (c) 2011 Ryan Petrich. All rights reserved.
//

#import "PBPlayer.h"

@interface PBPlayer ()
- (id)initWithBundleIdentifier:(NSString *)bundleIdentifier;
@end

@implementation PBPlayer

+ (id)playerWithBundleIdentifier:(NSString *)bundleIdentifier
{
    return [[[self alloc] initWithBundleIdentifier:bundleIdentifier] autorelease];
}

- (id)initWithBundleIdentifier:(NSString *)bundleIdentifier
{
    if ((self = [super init])) {
        _bundleIdentifier = [bundleIdentifier copy];
    }
    return self;
}

- (void)dealloc
{
    [_bundleIdentifier release];
    [_runningApplication release];
    [_toggleScript release];
    [_nextScript release];
    [_titleScript release];
    [super dealloc];
}

- (NSRunningApplication *)application
{
    if (_runningApplication.terminated) {
        [_runningApplication release];
        _runningApplication = nil;
    }
    if (!_runningApplication) {
        _runningApplication = [[[NSRunningApplication runningApplicationsWithBundleIdentifier:_bundleIdentifier] lastObject] retain];
    }
    return _runningApplication;
}

- (NSString *)currentTitle
{
    NSRunningApplication *app = [self application];
    if (app) {
        if (!_titleScript) {
            NSString *name = [app localizedName];
            NSString *script = [NSString stringWithFormat:@"tell app \"%@\" to return artist of current track & \" - \" & name of current track", name];
            _titleScript = [[NSAppleScript alloc] initWithSource:script];
            [_titleScript compileAndReturnError:NULL];
        }
        return [[_titleScript executeAndReturnError:NULL] stringValue];
    } else {
        return nil;
    }
}

- (BOOL)togglePlaying
{
    NSRunningApplication *app = [self application];
    if (app) {
        if (!_toggleScript) {
            NSString *name = [app localizedName];
            NSString *script = [NSString stringWithFormat:@"tell app \"%@\"\nif player state as string = \"playing\" then\npause\nelse\nplay\nend if\nend tell", name];
            _toggleScript = [[NSAppleScript alloc] initWithSource:script];
            [_toggleScript compileAndReturnError:NULL];
        }
        [_toggleScript executeAndReturnError:NULL];
        return YES;
    } else {
        return NO;
    }
}

- (BOOL)nextTrack
{
    NSRunningApplication *app = [self application];
    if (app) {
        if (!_nextScript) {
            NSString *name = [app localizedName];
            NSString *script = [NSString stringWithFormat:@"tell app \"%@\" to next track", name];
            _nextScript = [[NSAppleScript alloc] initWithSource:script];
            [_nextScript compileAndReturnError:NULL];
        }
        [_nextScript executeAndReturnError:NULL];
        return YES;
    } else {
        return NO;
    }
}


@end
