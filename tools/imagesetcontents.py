from posixpath import split
import sys
import os
from textwrap import indent

imagename = sys.argv[1]

with open("resources/ContentsTemplate.json", mode="r") as temp:
    template = temp.read()

path = os.path.dirname(__file__) + "/" + imagename.split(".")[0] + ".imageset"
os.mkdir(path)

with open(path + "/Contents.json", mode="w") as new:
    new.write(template.replace("@i", imagename))