import sys
import os

# first arg name of exec
# second arg bundle id

execname = sys.argv[1]
bundleid = sys.argv[2]
storyboard = sys.argv[3]

template = "oldInfo.plist"
newplist = "Info.plist"

oldpath = os.path.dirname(__file__) + "/" + template
newpath = os.path.dirname(__file__) + "/" + newplist

with open(oldpath, 'r') as file:
    data = file.read()
    data = data.replace("@e", execname)
    data = data.replace("@b", bundleid)
    data = data.replace("@s", storyboard)

with open(newpath, 'w') as file:
    file.write(data)