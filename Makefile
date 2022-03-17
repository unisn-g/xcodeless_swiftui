APPNAME := main
BUNDLEID := me.$(shell whoami)
STORYBOARDNAME := Main

SRC := src
TEMP := temp
SCRIPT := scripts

SOURCES := $(wildcard $(SRC)/*.swift)

BUILD := build

$(BUILD)/$(APPNAME).app/Contents/MacOS/$(APPNAME) $(BUILD)/$(APPNAME).app/Contents/Info.plist $(BUILD)/$(APPNAME).app/Contents/Resources/Assets.car: $(APPNAME) $(TEMP)/Info.plist $(SRC)/Assets.xcassets/*
	mkdir -p $(BUILD)/$(APPNAME).app/Contents/Resources
	mkdir -p $(BUILD)/$(APPNAME).app/Contents/MacOS
	cp $(TEMP)/Info.plist $(BUILD)/$(APPNAME).app/Contents/Info.plist
	actool $(SRC)/Assets.xcassets --compile $(BUILD)/$(APPNAME).app/Contents/Resources/ --platform macosx --target-device mac --minimum-deployment-target 12.0 --app-icon AppIcon --output-partial-info-plist ./partial.plist
	rm partial.plist
	cp $(APPNAME) $(BUILD)/$(APPNAME).app/Contents/MacOS/$(APPNAME)
	rm -rf $(TEMP)

$(TEMP)/Info.plist:
	python3 $(SRC)/$(SCRIPT)/plistgen.py $(APPNAME) $(BUNDLEID) $(STORYBOARDNAME)
	mkdir -p $(TEMP)
	mv $(SRC)/$(SCRIPT)/Info.plist $(TEMP)/Info.plist

$(APPNAME): $(SOURCES)
	swiftc $(OPTS) $(LIBS) $^ -o $@

image: $(BUILD)/$(APPNAME).app/Contents/MacOS/$(APPNAME) $(BUILD)/$(APPNAME).app/Contents/Info.plist $(BUILD)/$(APPNAME).app/Contents/Resources/Assets.car
	mkdir $(BUILD)/temp
	cp -r $(BUILD)/$(APPNAME).app $(BUILD)/temp/$(APPNAME).app
	ln -s /Applications $(BUILD)/temp
	hdiutil create -srcfolder $(BUILD)/temp -volname $(APPNAME) $(BUILD)/$(APPNAME)_installer.dmg
	rm -rf $(BUILD)/temp

clean:
	rm -rf $(APPNAME) $(BUILD)/* $(TEMP)/*