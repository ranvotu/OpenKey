#import <Cocoa/Cocoa.h>

int main() {
    NSArray *apps = [[NSWorkspace sharedWorkspace] runningApplications];
    for (NSRunningApplication *app in apps) {
        if (app.activationPolicy == NSApplicationActivationPolicyRegular) {
            NSLog(@"App: %@ (%@)", app.localizedName, app.bundleIdentifier);
        }
    }
    return 0;
}
