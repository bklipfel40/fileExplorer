# Assignment 5


For this assignment you are provided with the outline of an app, similar to the Sw-ClassBrowser example, that uses UITableView objects and controllers to present a browser for the directories and files in the file system. Two table view controller subclasses, and associated views, are used. The RootViewController presents the information on and the contents of directories. It displays a table with three sections: Creation Date, Modification Date and Contents.

![](FileBrowser-1.png)

The FileViewcontroller presents information on files by displaying a table with three sections: Creation Date, Modification Date and Size.

![](FileBrowser-2.png)

The Contents rows of the directory table has accessory icons on the right indicating that they can be selected. Depending on whether the item is a subdirectory or file the RootViewController creates either a new instance of RootViewController or FileViewController, configures it and request the navigation controller to push the new controller. 

The starting code has stubs for the methods to be implemented and comments about the work to be performed. The storyboard contains the UINavigationController/UITableViewController pair and does not need any work.

The course notes contain an "Assignment 5" topic that lists useful properties and methods of NSFileManager, NSString, NSMutableArray, NSDate and NSValue.

When run in the simulator, the file browser actually show the filesystem of the development computer. 

## Extra Ideas

* instead of a single Contents section divide the contents into a section for subdirectories and a section for files
* add a section to FileViewController table to show file permissions


## Steps

1. Fork this project to create your own GitLab repository for this assignment (see "Using GitLab" topic).
2. Clone your copy of this repository to your local development environment. The repository will consist of only this README file.
3. Extend the project as described above. 
4. Using the iOS simulator run the project. 
5. Use the QuickTime Player app to make a screen recording of the running app. Save this screen recording movie to the base folder of this project. 
6. Add the movie to git with "git add movie-name".
7. Clean the project with Xcode > Product > Clean.
8. Commit the changes with "git commit -m "some commit message".
9. Push your repository back with gitlab with "git push -u origin master".
10. Using the GitLab interface add me as a "reporter" member of your repository. 
11. Finally, create an issue, assigned to me, on your repository indicating that it is ready for grading. In the issue please include a note about anything extra you have included in the app.
