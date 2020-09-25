// "BatchProcessFolders"

//

// This macro batch processes all the files in a folder and any

// subfolders in that folder. In this example, it runs the Subtract

// Background command of TIFF files. For other kinds of processing,

// edit the processFile() function at the end of this macro.
//Set Pixel

 

   requires("1.33s");

   dir = getDirectory("Choose a Directory ");
  

   setBatchMode(true);

   count = 1;

   countFiles(dir);

   n = 800;

   processFiles(dir);

   //print(count+" files processed");

  

   function countFiles(dir) {

      list = getFileList(dir);

      for (i=0; i<list.length; i++) {

          if (endsWith(list[i], "/"))

              countFiles(""+dir+list[i]);

          else

              count++;

      }

  }

 

   function processFiles(dir) {

      list = getFileList(dir);

      for (i=0; i<list.length; i++) {

          if (endsWith(list[i], "/"))

              processFiles(""+dir+list[i]);

          else {

             showProgress(n++, count);

             path = dir+list[i];

             processFile(path);

          }

      }

  }

 

  function processFile(path) {

       if (endsWith(path, ".tif")) {                         // Replace .tif with relevant extension

// DOING STUFF IN HERE
//Set Pixel
open(path);
run("Properties...", "channels=1 slices=1 frames=1 unit=mm pixel_width=30 pixel_height=30 voxel_depth=50");
//////////////////////////////
run("Set Measurements...", "area mean min perimeter feret's redirect=None decimal=3");
run("Threshold...");
setThreshold(1, 255);
run("Create Selection");
run("Measure");

                      // may not be required….

           saveAs("Results", replace(path, ".tif", ".csv"));
           run("Clear Results");
           //selectWindow("ROI Manager"); 
          
        

// FINISHED DOING STUFF

      }

  }

 