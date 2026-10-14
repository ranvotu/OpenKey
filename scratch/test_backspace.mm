#import <Cocoa/Cocoa.h>
#import <mach/mach_time.h>

int main() {
    NSLog(@"Testing backspace event creation...");
    CGEventSourceRef src = CGEventSourceCreate(kCGEventSourceStateHIDSystemState);
    
    // Simulate sending 4 backspaces
    for (int i = 0; i < 4; i++) {
        CGEventRef down = CGEventCreateKeyboardEvent(src, 51, true);
        CGEventRef up = CGEventCreateKeyboardEvent(src, 51, false);
        
        CGEventSetTimestamp(down, mach_absolute_time());
        CGEventSetTimestamp(up, mach_absolute_time());
        
        NSLog(@"Backspace %d: down=%p, up=%p, time=%llu", i, down, up, CGEventGetTimestamp(down));
        
        CFRelease(down);
        CFRelease(up);
        usleep(1500); // 1.5ms
    }
    
    CFRelease(src);
    NSLog(@"Done testing backspaces.");
    return 0;
}
