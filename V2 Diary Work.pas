Program DiaryProject;
  USES
    SYSUTILS,CRT;
  TYPE
    DiaryRec = RECORD
                 Date:TdateTime;
                 StartTime:TdateTime;
                 EndTime:TDATETIME;
                 EventID:STRING[8];
                 LocID:STRING[10];
               END;
    DiaryFileType = FILE OF DiaryRec;

    EventRec = RECORD
                 EventID:STRING[15];
                 Desc:STRING[100];
               END;
    EventFileType = FILE OF EventRec;

    EventEmployeeRec = RECORD
                         EventID:STRING[10];
                         EmployeeID:STRING[10];
                       END;
    EventEmployeeFileType = FILE OF EventEmployeeRec;

    EmployeeRec = RECORD
                    EmployeeID:STRING[10];
                    Surname:STRING[35];
                    FirstName:STRING[35];
                 END;
    EmployeeFileType = FILE OF EmployeeRec;

    LocationRec= RECORD
                   Loc:STRING[25];
                   LocID:String[4];
                 END;
    LocationFileType = FILE OF LocationRec;

    DescriptionRec = RECORD
                       Desc:STRING[50];
                       DocID:STRING[10];
                     END;
    DescriptionFileType = FILE OF DescriptionRec;

    DocumentRec= RECORD
                   DocID:STRING[10];
                   DocName:STRING[20];
                 END;
    DocumentFileType = FILE OF DocumentRec;

  // Comment this please

  VAR

    Diary, NewDiary, PrevDiary, NextDiary: DiaryRec;
    DiaryFile :DiaryFileType;
    Event, NewEvent: EventRec;
    EventFile: EventFileType;
    EventEmployee, NewEventEmployee: EventEmployeeRec;
    EventEmployeeFile:EventEmployeeFileType;
    Employee, NewEmployee: EmployeeRec;
    EmployeeFile:EmployeeFileType;
    location, NewLocation: LocationRec;
    LocationFile: LocationFileType;
    Description, NewDescription: DescriptionRec;
    DescriptionFile: DescriptionFileType;
    Document, NewDocument: DocumentRec;
    DocumentFile: DocumentFileType;
    TempEmployee: EmployeeRec;

    CurrentTime:TdateTime;
    MenuChoice:CHAR;
    First,Sur,EMPID:STRING;


  PROCEDURE InitiliseFiles;
    BEGIN
      CLRSCR;
      Assign(DiaryFile,'c:\Users\harry\Documents\CompSci\Diary.dta');
      RESET(DiaryFile);

      ASSIGN(EventFile,'c:\Users\harry\Documents\CompSci\Event.dta');
      RESET(EventFile);

      ASSIGN(EmployeeFile,'c:\Users\harry\Documents\CompSci\Employee.dta');
      RESET(EmployeeFile);

      ASSIGN(EventEmployeeFile,'c:\Users\harry\Documents\CompSci\EventEmployee.dta');
      RESET(EventEmployeeFile);

      ASSIGN(LocationFile,'c:\Users\harry\Documents\CompSci\Location.dta');
      RESET(LocationFile);

      WRITELN('Diary');
      WRITELN;
      WRITELN('A: Display options.');
      WRITELN('B: Removing/ deleting options.');
      WRITELN('C: Addition to file options.');
      WRITELN('D: Editing file options.');
      WRITELN;
      WRITELN('X: Exit');
      WRITELN;
      WRITELN('Please pick a menu choice');
      READLN(MenuChoice);
      MenuChoice:=UPCASE(MenuChoice);
    END;

  PROCEDURE DiarySearch;
    VAR
      DateSearch:TDATETIME;
      Found:BOOLEAN;
      StrDate:STRING;
      BEGIN
        RESET(DiaryFile);
        WRITELN('enter Date to search for in the from dd/mm/yy');
        readln(DateSearch);
        DateSearch:=STRTODATE(StrDate);
        Found:=False;
        IF FILESIZE(DiaryFile)=0 THEN
          WRITELN('the file is empty')
        else
          BEGIN
            REPEAT
              READ(DiaryFile,Diary);
              IF Diary.Date = DateSearch THEN
                BEGIN
                  Found:=TRUE;
                  WITH Diary DO
                    BEGIN
                      WRITELN;
                      WRITELN(Date);
                      WRITELN(StartTime);
                      WRITELN(EndTime);
                      WRITELN(EventID);
                      WRITELN(LocID);
                    end;
                end;
            UNTIL (Found);
          end;
        IF NOT(Found) THEN
          WRITELN('Sorry but there was no date set to that time.');
      end;

  PROCEDURE EditDiaryFile;
    BEGIN
      DiarySearch;
      WRITELN('Enter what you would like to change');
      WRITELN('A: Date ');
      WRITELN('B: Time ');
      WRITELN('C: Duration');
      WRITELN('D: EventID ');
      WRITELN('E: LocID ');
      WRITELN;
      READLN(MenuChoice);
      MenuChoice:=UPCASE(MenuChoice);
      CASE MenuChoice OF
        'A':BEGIN
              WRITELN('Enter new Date for the event.');
              READLN(Diary.Date);
            end;
        'B':BEGIN
              WRITELN('Enter new Start Time for the event.');
              READLN(Diary.StartTime);
            end;
        'C':BEGIN
              WRITELN('Enter the end time for the event.');
              READLN(Diary.EndTime);
            END;
        'D':BEGIN
              WRITELN('Enter new Event ID.');
              READLN(Diary.EventID);
            END;
        'E':BEGIN
              WRITELN('Enter new Location ID.');
              READLN(Diary.LocID);
            END;
      end;
      SEEK(DocumentFile,FILEPOS(DocumentFile)-1);
      WRITE(DocumentFile,Document);
    end;

  PROCEDURE LocationSearch;
    VAR
      Search:STRING;
      Found:BOOLEAN;
      BEGIN
        RESET(LocationFile);
        WRITELN('enter locationid to search for');
        readln(Search);
        Found:=False;
        IF FILESIZE(LocationFile)=0 THEN
          WRITELN('the file is empty')
        else
          BEGIN
            REPEAT
              READ(LocationFile,Location);
              IF Location.LocID = Search THEN
                BEGIN
                  Found:=TRUE;
                  WITH Location DO
                    BEGIN
                      WRITELN;
                      WRITELN(Loc);
                      WRITELN(LocID);
                    end;
                end;
            UNTIL (Found);
          end;
        IF NOT(Found) THEN
          WRITELN('Sorry but there was locations set to that ID');
      end;

  PROCEDURE EditLocationFile;
    BEGIN
      LocationSearch;
      WRITELN('Enter what you would like to change');
      WRITELN('A: location');
      WRITELN('B: LocationID');
      WRITELN;
      READLN(MenuChoice);
      MenuChoice:=UPCASE(MenuChoice);
      CASE MenuChoice OF
        'A':BEGIN
              WRITELN('Enter new location name');
              READLN(Location.Loc);
            end;
        'B':BEGIN
              WRITELN('Enter new locationID');
              READLN(Location.LocID);
            end;
      end;
      SEEK(LocationFile,FILEPOS(EmployeeFile)-1);
      WRITE(EmployeeFile,Employee);
    end;

  PROCEDURE AddDocument;
    BEGIN
      WITH NewDocument DO
        BEGIN
          WRITELN('Please enter the Firstname That you would like to add to the employee Database');
          READLN(DocID);
          WRITELN('please enter the Lastname that you would like to add to the employee Database');
          READLN(DocName);
        END;

      RESET(DocumentFile);
      SEEK(DocumentFile,FILESIZE(DocumentFile)-1);
      WRITE(DocumentFile,NewDocument);
    END;

  PROCEDURE AddEvent;
    BEGIN
      WITH NewEvent DO
        BEGIN
          WRITELN('Please enter a new event ID');
          READLN(EventID);
          WRITELN('please enter a event name please');
          READLN(Desc);
        END;

      RESET(EventFile);
      SEEK(EventFile,FILESIZE(EventFile)-1);
      WRITE(EventFile,NewEvent);
    END;

  PROCEDURE AddLocation;
    BEGIN
      WITH NewLocation DO
        BEGIN
          WRITELN('Please enter a location name');
          READLN(Loc);
          WRITELN('please enter a location that you would like to add');
          READLN(LocID);
        END;

      RESET(LocationFile);
      SEEK(LocationFile,FILESIZE(LocationFile)-1);
      WRITE(LocationFile,NewLocation);
    END;

  PROCEDURE DisplayEvents;
    BEGIN
      READ(DiaryFile, Diary);
      With Diary DO
        BEGIN
          WRITELN('Date     : ',Date);                                                          //Add other fields later
          WRITELN('Start Time     : ',StartTime);
          WRITELN('EndTime : ',EndTime);
        END;
    END;

  PROCEDURE EventSearch;
    VAR
      Search:STRING;
      Found:BOOLEAN;
      BEGIN
        RESET(EventFile);
        WRITELN('enter Event ID to search for');
        readln(Search);
        Found:=False;
        IF FILESIZE(EventFile)=0 THEN
          WRITELN('the file is empty')
        else
          BEGIN
            REPEAT
              READ(EventFile,Event);
              IF Event.EventID = Search THEN
                BEGIN
                  Found:=TRUE;
                  WITH Event DO
                    BEGIN
                      WRITELN;
                      WRITELN(EventID);
                      WRITELN(Desc);
                    end;
                end;
            UNTIL (Found);
          end;
        IF NOT(Found) THEN
          WRITELN('Sorry but there was no Event set to that ID');
      end;

  PROCEDURE EditEventFile;
    BEGIN
      EventSearch;
      WRITELN('Enter what you would like to change');
      WRITELN('A: Event ID ');
      WRITELN('B: Event Name');
      WRITELN;
      READLN(MenuChoice);
      MenuChoice:=UPCASE(MenuChoice);
      CASE MenuChoice OF
        'A':BEGIN
              WRITELN('Enter new Ecvent ID');
              READLN(Event.EventID);
            end;
        'B':BEGIN
              WRITELN('Enter new Event Name');
              READLN(Event.Desc);
            end;
      end;
      SEEK(EventFile,FILEPOS(EventFile)-1);
      WRITE(EventFile,Event);
    end;

  PROCEDURE DocumentSearch;
    VAR
      Search:STRING;
      Found:BOOLEAN;
      BEGIN
        RESET(DocumentFile);
        WRITELN('enter Document ID to search for');
        readln(Search);
        Found:=False;
        IF FILESIZE(DocumentFile)=0 THEN
          WRITELN('the file is empty')
        else
          BEGIN
            REPEAT
              READ(DocumentFile,Document);
              IF Document.DocID = Search THEN
                BEGIN
                  Found:=TRUE;
                  WITH Document DO
                    BEGIN
                      WRITELN;
                      WRITELN(DocID);
                      WRITELN(DocName);
                    end;
                end;
            UNTIL (Found);
          end;
        IF NOT(Found) THEN
          WRITELN('Sorry but there was no location set to that ID');
      end;

  PROCEDURE EditDocumentFile;
    BEGIN
      DocumentSearch;
      WRITELN('Enter what you would like to change');
      WRITELN('A: Document ID ');
      WRITELN('B: Document Name');
      WRITELN;
      READLN(MenuChoice);
      MenuChoice:=UPCASE(MenuChoice);
      CASE MenuChoice OF
        'A':BEGIN
              WRITELN('Enter new Document ID');
              READLN(Document.DocID);
            end;
        'B':BEGIN
              WRITELN('Enter new Document Name');
              READLN(Document.DocName);
            end;
      end;
      SEEK(DocumentFile,FILEPOS(DocumentFile)-1);
      WRITE(DocumentFile,Document);
    end;

  PROCEDURE DisplayAllEmployees;
    BEGIN
      RESET(EmployeeFile);
      REPEAT
        READ(EmployeeFile,Employee);
        WITH Employee DO
          BEGIN
            WRITELN('FIRSTNAME:',Firstname);
            WRITELN(Surname);
            WRITELN(EmployeeID);
            WRITELN;
          END;
      UNTIL EOF(EmployeeFile);
    END;

  PROCEDURE DisplayAllEvents;                                                            //only for displaying events
    BEGIN
      RESET(DiaryFile);                                                                 //Add other required files later
      REPEAT
        DisplayEvents;
      UNTIL EOF(DiaryFile);
    END;


  PROCEDURE AddDiary;
    BEGIN
      RESET(DiaryFile);
      REPEAT
        READ(DiaryFile,Diary);
      UNTIL(NewDiary.Date+NewDiary.StartTime)<(Diary.Date+Diary.StartTime);
      NextDiary:=Diary;
      SEEK(DiaryFile,FILEPOS(DiaryFile)-2);
      READ(DiaryFile,PrevDiary);
      IF(NewDiary.Date+NewDiary.StartTime)>=(PrevDiary.Date + PrevDiary.EndTime) AND (NewDiary.Date+NewDiary.EndTime)<=(NextDiary.Date + NextDiary.StartTime) THEN
        Begin
          WRITE(DiaryFile,Diary);
          SEEK(DiaryFile,FILEPOS(DiaryFile-3);
          READ(DiaryFile,Diary);
        end;
      Write(DiaryFile,NewDiary);
      Else
        BEGIN
          CLRSCR;
          WRITELN('You cannot fit this appointement in here');
          WRITELN('Would You Like to :'):
          WRITELN('A : Shuffle other meetings around to fit this in');
          WRITELN('B : Cancel previous meeting to fit new one in');
          WRITELN('C : Cancel next meeting to fit this one in');
          WRITELN;
          READLN(MenuChoice);
          MenuChoice:=UPCASE(MenuChoice);
          Case MenuChoice OF
            'A':
            'B':
            'C':
          END;
        END;
    END;


  PROCEDURE SearchForDate;
    VAR
      DateSearch:TdateTime;
      Found,LFound:BOOLEAN;
      StrDate,I:STRING;
    BEGIN
      CLRSCR;
      RESET(DiaryFile);
      WRITELN('Please enter a date to search for in form:');
      WRITELN('DD/MM/YYYY');
      READLN(StrDate);
      DateSearch:= STRTODATE(StrDate);

      Found:=False;

      IF FILESIZE(DiaryFile) = 0 THEN
        WRITELN('The file is empty')
      ELSE
        BEGIN
          REPEAT
            READ(DiaryFile, Diary);
            IF Diary.Date = DateSearch THEN
              BEGIN
                Found:=True;
    READKEY;
                WITH Diary Do
                  BEGIN
                    WRITELN('Date: ',(FormatDateTime('dd/mm/yy',DATE)));
                    WRITELN('Time: ',(FormatDateTime('HH:MM',TIME)));
                    WRITELN('Duaration: ',Dura,' Minutes');
                  END;
    READKEY;
                  RESET(LocationFile);
                  LFound:=FALSE;
                  REPEAT
                    READ(LocationFile, Location);
                    IF Location.LocID = Diary.LocID THEN
                      WITH Location DO
                        BEGIN
                          WRITELN('Location: ',Loc);
                          WRITELN;
                          LFound:=True;
                        END;
                  UNTIL (EOF(LocationFile)) OR (LFound);
              END;
          UNTIL (EOF(DiaryFile));
        END;
      IF NOT(Found) THEN
        WRITELN('Theres no events on that date');
    END;

  PROCEDURE EmployeeSearch;
    VAR
      Search:STRING;
      Found:BOOLEAN;
    BEGIN
      RESET(EmployeeFile);
      WRITELN('Enter Employee ID to Search for');
      READLN(Search);
      Found:=False;
      IF FILESIZE(EmployeeFile)= 0 THEN
        WRITELN('You have no Employees')
      ELSE
        BEGIN
          REPEAT
            READ(EmployeeFile,Employee);
            IF Employee.EmployeeID = Search THEN
              BEGIN
                Found:=TRUE;
                WITH Employee DO
                  BEGIN
                    WRITELN;
                    WRITELN('FirstnamE: ',Firstname);
                    WRITELN('Surname: ',Surname);
                    WRITELN('EmployeeID: ',EmployeeID);
                  END;
              END;
          UNTIL (Found);
        END;
      IF NOT(Found) THEN
        WRITELN('Sorry but there was no one by that id.');
    end;

  PROCEDURE SearchEmployeeSurname;
    VAR
      Search:String;
      Found:BOOLEAN;
    BEGIN
      RESET(EmployeeFile);
      WRITELN('Please enter the surname to seaarch for');
      READLN(Search);
      Found:=False;
      IF FILESIZE(EmployeeFile) = 0 then
        WRITELN('The EmployeeFile is empty or missing')
      else
        begin
          REPEAT
            READ(EmployeeFile,Employee);
            IF Search = Employee.Surname THEN
              BEGIN
                Found:=True;
                With Employee DO
                  BEGIN
                    Writeln('Firstname :',Firstname);
                    WRITELN('Surname :',Surname);
                    WRITELN('EmployeeID :',EmployeeID);
                  END;
              END;
          UNTIL(EOF(EmployeeFile));
        end;
        IF NOT(Found) THEN
          WRITELN('a');
    END;



  PROCEDURE AddEmployee;
    BEGIN
      WITH NewEmployee DO
        BEGIN
          WRITELN('Please enter the Firstname That you would like to add to the employee Database');
          READLN(Firstname);
          WRITELN('please enter the Lastname that you would like to add to the employee Database');
          READLN(Surname);
          WRITELN('please eneter a new employee ID');
          READLN(EmployeeID);
        END;

      RESET(EmployeeFile);
      SEEK(EmployeeFile,FILESIZE(EmployeeFile)-1);
      WRITE(EmployeeFile,NewEmployee);
    END;


  PROCEDURE EditEmployeeFile;
    BEGIN
      EmployeeSearch;
      WRITELN('Enter an item to change.');
      WRITELN('A: Firstname');
      WRITELN('B: lastname');
      WRITELN('C: EmployeeID');
      WRITELN;
      READLN(MenuChoice);
      MenuChoice:=UPCASE(MenuChoice);
      CASE MenuChoice OF
        'A':BEGIN
              WRITELN('Enter the new Firstname');
              READLN(Employee.Firstname);
            end;
        'B':BEGIN
              WRITELN('Enter the new lastname');
              READLN(Employee.Surname);
            END;
        'C':BEGIN
              WRITELN('Enter the new Employee ID');
              READLN(Employee.EmployeeID);
            end;
      end;
      SEEK(EmployeeFile,FILEPOS(EmployeeFile)-1);
      WRITE(EmployeeFile,Employee);
    end;

  PROCEDURE MenuOptionA;
    BEGIN
      CLRSCR;
      WRITELN('A: Display all Current Events');
      WRITELN('B: Search for a day');
      WRITELN('C: Display All Employees');
      WRITELN;
      WRITELN('X:Back');
      READLN(MenuChoice);
      MenuChoice:=UPCASE(MenuChoice);
      CASE MenuChoice OF
         'A': WRITELN('Temp');
         'B': SearchForDate;
         'C': DisplayAllEmployees;
         'X': InitiliseFiles;
       END;
    END;

  PROCEDURE MenuOptionB;
    BEGIN
      CLRSCR;
      WRITELN('A: Remove From Employee File');
      WRITELN('B: Remove From Diary File');
      WRITELN('C: Remove From locaition File');
      WRITELN('D: Remove From Document File');
      WRITELN('E: Remove From Event File');
      WRITELN;
      WRITELN('X: Back');
      READLN(MenuChoice);
      MenuChoice:=UPCASE(MenuChoice);
      CASE MenuChoice OF
         'A': Writeln('temp');
         'B': Writeln('temp');
         'C': Writeln('temp');
         'D': Writeln('temp');
         'E': Writeln('temp');
         'X': InitiliseFiles;
       END;
    end;

  PROCEDURE MenuOptionC;
    begin
      CLRSCR;
      WRITELN('A: Add to Employee File');
      WRITELN('B: Add to Diary File');
      WRITELN('C: Add to locaition File');
      WRITELN('D: Add to Document File');
      WRITELN('E: Add to Event File');
      WRITELN;
      WRITELN('X:back');
      READLN(MenuChoice);
      MenuChoice:=UPCASE(MenuChoice);
      CASE MenuChoice OF
         'A': AddEmployee;
         'B': AddDiary;
         'C': AddLocation;
         'D': AddDocument;
         'E': AddEvent;
         'X': InitiliseFiles;
       END;
    end;

   PROCEDURE MenuOptionD;
     begin
       CLRSCR;
       WRITELN('A: Edit Employee File');
       WRITELN('B: Edit Diary File');
       WRITELN('C: Edit locaition File');
       WRITELN('D: Edit Document File');
       WRITELN('E: Edit Event File');
       WRITELN;
       WRITELN('X:back');
       READLN(MenuChoice);
       MenuChoice:=UPCASE(MenuChoice);
       CASE MenuChoice OF
         'A': EditEmployeeFile;
         'B': EditDiaryFile;
         'C': EditLocationFile;
         'D': EditDocumentFile;
         'E': EditEventFile;
         'X': InitiliseFiles;
       END;
     end;

  PROCEDURE MainMenu;
    BEGIN
      CASE MenuChoice OF
        'A' : MenuOptionA;
        'B' : MenuOptionB;
        'C' : MenuOptionC;
        'D' : MenuOptionD;
        'x' : writeln('goodbye');
      end;
    end;

  PROCEDURE CloseFiles;
    BEGIN
      CLOSE(DiaryFile);
      CLOSE(EventFile);
      CLOSE(EventEmployeeFile);
      CLOSE(EmployeeFile);
      CLOSE(LocationFile);
      CLOSE(DocumentFile);
    END;

  BEGIN
    InitiliseFiles;
    MainMenu;
    CloseFiles;
    READLN;
  END.


