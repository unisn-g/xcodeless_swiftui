APPNAME := main
BUNDLEID := me.$(shell whoami)
STORYBOARDNAME := Main

SRC := src
RSRC := resources

SOURCES := $(wildcard $(SRC)/*.swift)

BUILD := build

$(BUILD)/$(APPNAME).app/Contents/MacOS/$(APPNAME) $(BUILD)/$(APPNAME).app/Contents/Info.plist $(BUILD)/$(APPNAME).app/Contents/Resources/Assets.car: $(APPNAME) $(RSRC)/Info.plist $(SRC)/Assets.xcassets/*
	mkdir -p $(BUILD)/$(APPNAME).app/Contents/Resources
	mkdir -p $(BUILD)/$(APPNAME).app/Contents/MacOS
	cp $(RSRC)/Info.plist $(BUILD)/$(APPNAME).app/Contents/Info.plist
	actool $(SRC)/Assets.xcassets --compile $(BUILD)/$(APPNAME).app/Contents/Resources/ --platform macosx --target-device mac --minimum-deployment-target 12.0 --app-icon AppIcon --output-partial-info-plist ./partial.plist
	rm partial.plist
	cp $(APPNAME) $(BUILD)/$(APPNAME).app/Contents/MacOS/$(APPNAME)

$(RSRC)/Info.plist:
	python3 src/plistgen.py $(APPNAME) $(BUNDLEID) $(STORYBOARDNAME)
	mkdir -p $(RSRC)
	mv $(SRC)/Info.plist $(RSRC)/Info.plist

$(APPNAME): $(SOURCES)
	swiftc $(OPTS) $(LIBS) $^ -o $@

clean:
	rm -rf $(APPNAME) $(BUILD)/* $(RSRC)/*