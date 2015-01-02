#/* mehPL:
# *    This is Open Source, but NOT GPL. I call it mehPL.
# *    I'm not too fond of long licenses at the top of the file.
# *    Please see the bottom.
# *    Enjoy!
# */
#
#
#
#

#commonTestEasyVersion.mk

# For commonCode tests, there are a few cases in which we can determine the
# commonCode's version-number automatically...
# This makes life easier for me
# But may be a bit ugly for the general-user
# Hopefully moving that code here will make it nicer.
# (and more functional!)
# Yes, this entire mess is all to make my life just a tiny bit easier so I
# don't have to change a single line in a makefile or two each time I 
# create a new version of a commonThing... crazy, huh?


## GENERALLY:
# A project makefile should include e.g. VER_HEARTBEAT=<version>
# Don't use commonTestEasyVersion.mk unless you know what you're doing.

# commonTestEasyVersion.mk requires e.g. 
# THIS_COMMONTHING = HEARTBEAT
# THIS_commonThing = heartbeat

ifdef COMMONTESTEASYVERSION_MK
$(error easyVersion.mk can only be included once!)
endif

COMMONTESTEASYVERSION_MK = 1


#Include this in COM_MAKE so it will be copied when e.g. 'make localize'
COM_MAKE += $(COMDIR)/_make/commonTestEasyVersion.mk


ifndef THIS_COMMONTHING
$(error "commonTestEasyVersion.mk requires THIS_COMMONTHING to be defined")
endif

ifndef THIS_commonThing
$(error "commonTestEasyVersion.mk requires THIS_commonThing to be defined")
endif


SETVER_WARNING = "YOU NEED TO set VER_$(THIS_COMMONTHING) in your makefile. Unless you know what you are doing, use the version this came with... it can be determined by looking for the version-directory in $(LOCAL_COMDIR)/$(THIS_commonThing)/ (set VER_$(THIS_COMMONTHING)=<that directory name>)"

USE_SETVER_ENDWARNING = 0




# For commonCode tests, we'll extract the version-number from the
# current working directory, so that the test-code's makefile needn't be 
# modified with each version...

ifndef VER_$(THIS_COMMONTHING)

ifeq ($(LOCAL),1)

# If running local, we can extract the version from LOCAL_COMDIR with the
# presumption that there's only one version...

VER_$(THIS_COMMONTHING) = $(notdir $(wildcard $(COMDIR)/$(THIS_commonThing)/*))

END_WARNINGS += "Running Local: Auto-Assigning VER_$(THIS_COMMONTHING)=$(VER_$(THIS_COMMONTHING))"


# This is only used if we run 'make delocalize'
# The message will be emitted via END_WARNINGS otherwise.
DELOCALIZE_END_WARNINGS += "$(SETVER_WARNING)"


else

# If running from within the centralized _commonCode directory
# (e.g. running in: _commonCode/heartbeat/<version>/testMega328p/)
# we can extract the version from the parent directory

# First, though, we need to verify that we're running in this directory
PARENT_DIR = $(realpath $(dir $(patsubst %/,%,$(dir $(abspath ./)))))
$(warning parentDir=$(PARENT_DIR))

ifeq ($(PARENT_DIR), $(realpath $(COMDIR)/$(THIS_commonThing)))
VER_$(THIS_COMMONTHING) = $(notdir $(patsubst %/,%,$(dir $(CURDIR))))
END_WARNINGS += "Running in the $(THIS_commonThing) test directory: Auto-Assigning VER_$(THIS_COMMONTHING)=$(VER_$(THIS_COMMONTHING))"

else
# Not running local Nor in _commonCode/...  (running centralized)
# The only case we can handle, then, is if there's only one version in the
# central _commonCode directory




#Check how many versions there are...
# CURRENTLY DOES NOT HANDLE ignoring of .zips, etc!
VERSIONS_$(THIS_COMMONTHING) = $(wildcard $(COMDIR)/$(THIS_commonThing)/*)
NUMVERSIONS_$(THIS_COMMONTHING) = $(words $(VERSIONS_$(THIS_COMMONTHING)))
$(warning "$(NUMVERSIONS_$(THIS_COMMONTHING)) $(THIS_COMMONTHING)_VERSIONS='$(VERSIONS_$(THIS_COMMONTHING))'")



ifeq ($(NUMVERSIONS_$(THIS_COMMONTHING)),1)
VER_$(THIS_COMMONTHING) = $(notdir $(wildcard $(COMDIR)/$(THIS_commonThing)/*))

END_WARNINGS += "Only one version of $(THIS_commonThing) in $(CENTRAL_COMDIR): Auto-Assigning VER_$(THIS_COMMONTHING)=$(VER_$(THIS_COMMONTHING))"

USE_SETVER_ENDWARNING = 1

else
#More than one version, we can't determine which to use...
$(error "$(SETVER_WARNING)")
endif




endif

endif

endif


ifeq ($(USE_SETVER_ENDWARNING), 1)
END_WARNINGS += "$(SETVER_WARNING)"
endif

#/* mehPL:
# *    I would love to believe in a world where licensing shouldn't be
# *    necessary; where people would respect others' work and wishes, 
# *    and give credit where it's due. 
# *    A world where those who find people's work useful would at least 
# *    send positive vibes--if not an email.
# *    A world where we wouldn't have to think about the potential
# *    legal-loopholes that others may take advantage of.
# *
# *    Until that world exists:
# *
# *    This software and associated hardware design is free to use,
# *    modify, and even redistribute, etc. with only a few exceptions
# *    I've thought-up as-yet (this list may be appended-to, hopefully it
# *    doesn't have to be):
# * 
# *    1) Please do not change/remove this licensing info.
# *    2) Please do not change/remove others' credit/licensing/copyright 
# *         info, where noted. 
# *    3) If you find yourself profiting from my work, please send me a
# *         beer, a trinket, or cash is always handy as well.
# *         (Please be considerate. E.G. if you've reposted my work on a
# *          revenue-making (ad-based) website, please think of the
# *          years and years of hard work that went into this!)
# *    4) If you *intend* to profit from my work, you must get my
# *         permission, first. 
# *    5) No permission is given for my work to be used in Military, NSA,
# *         or other creepy-ass purposes. No exceptions. And if there's 
# *         any question in your mind as to whether your project qualifies
# *         under this category, you must get my explicit permission.
# *
# *    The open-sourced project this originated from is ~98% the work of
# *    the original author, except where otherwise noted.
# *    That includes the "commonCode" and makefiles.
# *    Thanks, of course, should be given to those who worked on the tools
# *    I've used: avr-dude, avr-gcc, gnu-make, vim, usb-tiny, and 
# *    I'm certain many others. 
# *    And, as well, to the countless coders who've taken time to post
# *    solutions to issues I couldn't solve, all over the internets.
# *
# *
# *    I'd love to hear of how this is being used, suggestions for
# *    improvements, etc!
# *         
# *    The creator of the original code and original hardware can be
# *    contacted at:
# *
# *        EricWazHung At Gmail Dotcom
# *
# *    This code's origin (and latest versions) can be found at:
# *
# *        https://code.google.com/u/ericwazhung/
# *
# *    The site associated with the original open-sourced project is at:
# *
# *        https://sites.google.com/site/geekattempts/
# *
# *    If any of that ever changes, I will be sure to note it here, 
# *    and add a link at the pages above.
# *
# * This license added to the original file located at:
# * /home/meh/_commonCode/heartbeat/2.00-gitHubbing_+revisions/testMega328P+button+DMS/_commonCode_localized/_make/commonTestEasyVersion.mk
# *
# *    (Wow, that's a lot longer than I'd hoped).
# *
# *    Enjoy!
# */
