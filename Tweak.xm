//#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#include <substrate.h>
#import <ifaddrs.h>
#import <arpa/inet.h>

@interface SBWallpaperEffectView : UIView
@end

@interface SBDockView : UIView
	@property(nonatomic) CGFloat alpha;
	@property(retain, nonatomic) SBWallpaperEffectView *_backgroundView;
@end

@interface SBAlertView : UIView {

	//SBAlert* _alert;
	unsigned _shouldAnimateIn : 1;

}
@end


@interface SBUIAction : NSObject
- (id)initWithTitle:(id)arg1 handler:(id /* block */)arg2;
- (id)initWithTitle:(id)arg1 subtitle:(id)arg2 handler:(id /* block */)arg3;
- (id)initWithTitle:(id)arg1 subtitle:(id)arg2 image:(id)arg3 badgeView:(id)arg4 handler:(id /* block */)arg5;
- (id)initWithTitle:(id)arg1 subtitle:(id)arg2 image:(id)arg3 handler:(id /* block */)arg4;
@end

@protocol CCUIButtonModuleDelegate <NSObject>
@required
- (void)buttonModule:(id)arg1 willExecuteSecondaryActionWithCompletionHandler:(id /* block */)arg2;
@end
   
@interface CCUIButtonModule : NSObject
- (id<CCUIButtonModuleDelegate>)delegate;
@end

@interface CCUIWiFiSetting : CCUIButtonModule
@end


/*
@interface _UIActionSlider : UIControl
	-(void)setTrackText:(NSString *)arg1 ;
@end

@interface SBPowerDownView : SBAlertView
@end

%hook SBPowerDownController


	-(void)activate{
		SBPowerDownView *powerDownView = MSHookIvar<SBPowerDownView *>(self, "_powerDownView"); // Than
		_UIActionSlider *actionSlider = MSHookIvar<_UIActionSlider *>(powerDownView, "_actionSlider");
		[actionSlider setTrackText:@"Are you sure?"];

		%orig;
	}
%end
*/


/****************************
	   Dock modifiers
****************************/

//Fjerner Doc'en
%hook SBDockView
	-(void)layoutSubviews
	{
		%orig;
		SBWallpaperEffectView *backgroundView = MSHookIvar<SBWallpaperEffectView *>(self, "_backgroundView");
		backgroundView.hidden = YES;
	}


	//Sætter Alpha på dock'en - hvis man vil beholde den.
	/*	- (void)setBackgroundAlpha:(double)arg1
	{
		%orig;
		MSHookIvar<SBWallpaperEffectView *>(self, "_backgroundView").alpha = 0.0;
	}*/
%end


/****************************
	CCSetings modifiers
****************************/

@interface SBFButton : UIButton
	-(id)initWithFrame:(CGRect)arg1 ;
	-(void)setHighlighted:(BOOL)arg1 ;
	-(void)setSelected:(BOOL)arg1 ;
	-(void)_updateSelected:(BOOL)arg1 highlighted:(BOOL)arg2 ;
	-(BOOL)_drawingAsSelected;
	-(void)_touchUpInside;
	-(void)_updateForStateChange;
@end

@protocol CCUIControlCenterButtonDelegate <NSObject>
@end

@interface CCUIControlCenterButton : SBFButton {

	unsigned long long _buttonType;
	UIColor* _selectedColor;
	UIImageView* _glyphImageView;
	UILabel* _label;
	UIImageView* _alteredStateGlyphImageView;
	UILabel* _alteredStateLabel;
	UIView* _backgroundFlatColorView;
	BOOL _animatesStateChanges;
	BOOL _showingMenu;
	id<CCUIControlCenterButtonDelegate> _delegate;
	unsigned long long _roundCorners;
	UIImage* _glyphImage;
	UIImage* _selectedGlyphImage;
	double _naturalHeight;

}

	-(void)setText:(NSString *)arg1 ;
	-(void)setEnabled:(BOOL)arg1 ;
	-(void)setText:(NSString *)arg1 ;
	-(NSString *)text;
	-(void)dealloc;

@end

@interface CCUIControlCenterPushButton : CCUIControlCenterButton {

	NSString* _identifier;
	NSNumber* _sortKey;

}

@property (nonatomic,copy) NSString * identifier;              //@synthesize identifier=_identifier - In the implementation block
@property (nonatomic,copy) NSNumber * sortKey;                 //@synthesize sortKey=_sortKey - In the implementation block
-(id)initWithFrame:(CGRect)arg1 ;
-(id)description;
-(NSString *)identifier;
-(void)setIdentifier:(NSString *)arg1 ;
-(NSNumber *)sortKey;
-(void)setSortKey:(NSNumber *)arg1 ;
@end


@interface CCUIControlCenterSectionView : UIView {

	long long _layoutStyle;

}
@end
@interface CCUINightShiftContentView : CCUIControlCenterSectionView {

	CCUIControlCenterPushButton* _button;
}
@end

@interface pkaDblBtn : CCUINightShiftContentView {

	CCUIControlCenterPushButton* _button2;

}
@end




//kan vi tilføje en ny knap til nightshift dimsen?
/*%hook SBControlCenterController


/*UIButton *btn;		
btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	btn.frame = CGRectMake(15.0, 375.0 ,280.0, 20.0);
[btn setTitle:@"Respring" forState:UIControlStateNormal];
[btn setTitle:@"Done" forState:UIControlStateHighlighted];
[btn setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
*/


//-(void)_beginPresentation{

	//BOOL* isAirPlayEnabled = MSHookIvar<CCUIAirStuffSectionController *>(MSHookIvar<id>(MSHookIvar<id>(self, "_viewController"), "_contentView"), "_airPlaySection").isVisible;
	//isAirPlayEnabled = FALSE;

/*		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connect VPN"
                                                message:@"Do you with to connect to your VPN?"
                                               delegate:self
                                      cancelButtonTitle:@"Nope"
                                      otherButtonTitles:@"Yes",nil];
		[alert show];


//		[btn addTarget:self action:@selector(respring:) forControlEvents:UIControlEventTouchDown];
//		[[self window] addSubview:btn];


		%orig;

	}
%end
*/

/*%hook CCUIControlCenterViewController
	-(double)_scrollviewContentMaxHeight{
		return 245.0;
	}

%end*/

%hook CCUIControlCenterContainerView
	-(double)_contentHeight{ return 245.0;}
%end

%hook CCUIControlCenterPushButtonSettings
	-(void)setEnabled:(BOOL)arg1{
		%orig;
		return;
}
%end


//disables colors on buttons in ControlCenter
%hook CCUIControlCenterButton
	-(id)_effectiveSelectedColor{
		return 0;
	}
%end


%hook CCUIPersonalHotspotSetting
	+(BOOL)isSupported:(int)arg1{ return TRUE; }
	+(BOOL)isInternalButton{ return FALSE; }
%end

%hook CCUILowPowerModeSetting

	+(BOOL)isSupported:(int)arg1{ return TRUE; }
	+(BOOL)isInternalButton{ return FALSE; }

	-(id)glyphImageForState:(int)arg1{
		return [UIImage imageNamed:@"IconGlyph@2x.png" inBundle:[NSBundle bundleWithPath:@"/Applications/Activator.app/"] compatibleWithTraitCollection:nil];
	}

%end

%hook CCUIRecordScreenShortcut

	+(BOOL)isSupported:(int)arg1{
		return TRUE;
	}

	+(BOOL)isInternalButton{
		return FALSE;
	}

	-(BOOL)isRestricted{
		return FALSE;
	}

	//Tilføjer et ikon til record knappen
	- (UIImage *)glyphImageForState:(UIControlState)state
	{
		return [UIImage imageNamed:@"RecordVideo-OrbHW@2x.png" inBundle:[NSBundle bundleWithPath:@"/Applications/Camera.app/"] compatibleWithTraitCollection:nil];
	}

%end


%hook CCUICalculatorShortcut

- (UIImage *)glyphImageForState:(UIControlState)state
	{
		return [UIImage imageNamed:@"IconGlyph@2x.png" inBundle:[NSBundle bundleWithPath:@"/Applications/Activator.app/"] compatibleWithTraitCollection:nil];
	}

	-(NSURL *)url{
		return [NSURL URLWithString:@"prefs:root=General&path=Network/VPN"];
	}

	-(void)activateApp{
		[[UIApplication sharedApplication] openURL:
       	[NSURL URLWithString:@"prefs:root=VPN"]];
	}
%end


/*%
hook CCUIMuteSetting

	+(BOOL)isSupported:(int)arg1{
		return TRUE;
	}
	-(BOOL)isRestricted{
		return FALSE;
	}
%end


%hook CCUIAirStuffSectionController
	-(void)_airDropTapped:(id)arg1{
	}
%end

%hook CCUIArtraceShortcut
	+(BOOL)isSupported:(int)arg1{
		return TRUE;
	}
	+(BOOL)isInternalButton{
		return FALSE;
	}

	-(NSURL *)url{
		return [NSURL URLWithString:@"prefs:root=General&path=Network/VPN"];
	}

	-(void)activateApp{
		[[UIApplication sharedApplication] openURL:
       		[NSURL URLWithString:@"prefs:root=VPN"]];
	}


%end
*/


/*%hook CCUIWiFiSetting

-(void)_setWifiEnabled:(BOOL)arg1 {

	if (arg1 == FALSE){	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connect VPN"
                                                message:@"Do you with to connect to your VPN?"
                                               delegate:self
                                      cancelButtonTitle:@"Nope"
                                      otherButtonTitles:@"Yes",nil];
	[alert show];
	}
	}
	
%end*/

/****************************
	Carrier modifiers
****************************/


//Hides the signalstrength dots..

%hook UIStatusBarSignalStrengthItemView
	- (id)contentsImage{
		return NULL;
	}
%end

//Hides the CarrierName
%hook UIStatusBarServiceItemView
	-(id)_serviceContentsImage{
		return NULL;
	}

	-(id)contentsImage{
		return NULL;
	}
%end


/****************************
	SpringBoard modifiers
****************************/

%hook SBApplicationInfo

//Fjerner navnet fra ikonerne på Springboard'et
	-(NSString *)displayName{
		return @"";
	}


- (NSString *)displayNameForLocation:(NSInteger)location
{
	return @"";
}


%end

%hook SBFolder
	-(NSString *)displayName{
		return @"";
	}
%end

//Fjerner folder background'en
%hook SBFolderBackgroundView
-(id)_tintViewBackgroundColorAtFullAlpha{

	return NULL;

}

%end



%hook BSPlatform 
- (BOOL)hasOrbCapability {
   return YES; // To support 3D touch emulating tweaks like Peek-a-boo
}
%end

%hook CCUIWiFiSetting
- (int)orbBehavior {
   return 2; // returning 2 allows the 3D touch to be enabled and also tells it where to pull the options from.
}

- (NSArray *)buttonActions {
   NSMutableArray *actions = [NSMutableArray new];

 struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    NSString *wifiAddress = nil;
    NSString *cellAddress = nil;

    // retrieve the current interfaces - returns 0 on success
    if(!getifaddrs(&interfaces)) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                NSString *name = [NSString stringWithUTF8String:temp_addr->ifa_name];
                NSString *addr = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)]; // pdp_ip0     
                //NSLog(@"NAME: \"%@\" addr: %@", name, addr); // see for yourself

                if([name isEqualToString:@"en0"]) {
                    // Interface is the wifi connection on the iPhone
                    wifiAddress = addr;    
                } 
            }
            temp_addr = temp_addr->ifa_next;
        }
        // Free memory
        freeifaddrs(interfaces);
    }
    NSString *addr = wifiAddress ? wifiAddress : cellAddress;

   // SBUIAction can be thought of as an UIApplicationShortcutItem
   SBUIAction *network = [[NSClassFromString(@"SBUIAction") alloc] initWithTitle:@"Current IP:" subtitle:addr handler:^(void) {
       [[self delegate] buttonModule:self willExecuteSecondaryActionWithCompletionHandler:nil]; // this must be called to dismiss the 3D Touch Menu
   }];
   [actions addObject:network];

   return [actions copy];
}
%end

