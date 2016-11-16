# richSelectionTool

Steps to test:
-          Build the plugin using Makefile (Makefile tested in OSX), You can create new project in VC++ and build the sample
-          Copy richSelectionProperities.mel and richSelectionValues.mel to Maya script folder “/Applications/Autodesk/maya2017/Maya.app/Contents/scripts/others”
-          Launch Maya 2017
-          Load richSelectionTool plug-in
-          Run mel scirpts:
            richSelectionContext richSelectionContext1;
            setToolTo richSelectionContext1;
            toolPropertyWindow;
-          They you should be on this rich selection tool and could change the soft selection and symmetrical selection options. Double clicking to select shell, edge loop/rings should also works
