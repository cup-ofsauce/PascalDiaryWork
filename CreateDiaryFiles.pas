PROGRAM CreateDiaryFile;
  USES
    SYSUTILS,CRT;
  TYPE
    DiaryRec = RECORD
                 Date:TdateTime;
                 StartTime:TdateTime;
                 EndTime:TDATETIME;
                 EventID:STRING[8];
                 LocID:STRING[4];
               END;
    DiaryFileType = FILE OF DiaryRec;

    EventRec = RECORD
                 EventID:STRING[8];
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
                   DocID:STRING[9];
                   DocName:STRING[20];
                 END;
    DocumentFileType = FILE OF DocumentRec;
  VAR
    Diary: DiaryRec;
    DiaryFile: DiaryFileType;
    Event: EventRec;
    EventFile: EventFileType;
    EventEmployee: EventEmployeeRec;
    EventEmployeeFile: EventEmployeeFileType;
    Employee: EmployeeRec;
    EmployeeFile: EmployeeFileType;
    location: LocationRec;
    LocationFile: LocationFileType;
    Description: DescriptionRec;
    DescriptionFile: DescriptionFileType;
    Document: DocumentRec;
    DocumentFile: DocumentFileType;

  PROCEDURE CreateEventFile;
    BEGIN;
      ASSIGN(EventFile,'c:\Users\harry\Documents\CompSci\Event.dta');
      REWRITE(EventFile);
      With Event DO
        BEGIN
          EventID := '65387915';
          Desc := 'Meeting';
          WRITE(EventFile, Event);

          EventID := '35529682';
          Desc := 'Document B Update';
          WRITE(EventFile, Event);

          EventID := '53693578';
          Desc := 'Terms Of Services Update';
          WRITE(EventFile, Event);

        END;
    END;

  PROCEDURE CreateLocationFile;
    BEGIN
      ASSIGN(LocationFile,'c:\Users\harry\Documents\CompSci\Location.dta');
      REWRITE(LocationFile);
      With Location DO
        BEGIN
          Loc := 'london office';
          LocID :='1110';
          WRITE(LocationFile, Location);

          Loc := 'Microsoft Teams';
          LocID:= '1111';
          WRITE(LocationFile, Location);

          Loc := 'Zoom call';
          LocID :='1112';
          WRITE(LocationFile, Location);
        END;
    END;

  PROCEDURE CreateDocumentFile;
    BEGIN
      ASSIGN(DocumentFile,'c:\Users\harry\Documents\CompSci\Document.dta');
      REWRITE(DocumentFile);
      With Document DO
        BEGIN
          DocID := '123456789';
          DocName := 'terms of services';
          WRITE(DocumentFile, Document);

          DocID := '987654321';
          DocName := 'user agreement';
          WRITE(DocumentFile, Document);

          DocID := '543216789';
          DocName := 'terms of use';
          WRITE(DocumentFile, Document);

          DocID := '678954321';
          DocName := 'document';
          WRITE(DocumentFile, Document);
        END;
    END;

  PROCEDURE CreateTheDiaryFile;
    BEGIN
      ASSIGN(DiaryFile,'c:\Users\harry\Documents\CompSci\Diary.dta');
      REWRITE(DiaryFile);
      with Diary DO
        BEGIN
          Date:=STRTODATE('16/3/2024');
          StartTime:=STRTOTIME('10:00');
          EndTime:=STRTOTIME('10:45');
          EventID:='65387915';
          LocID:='1111';
          WRITE(DiaryFile, Diary);

          Date:=STRTODATE('17/3/2024');
          StartTime:=STRTOTIME('10:00');
          EndTime:=STRTOTIME('10:45');
          EventID:='65387915';
          LocID:='1112';
          WRITE(DiaryFile, Diary);

          Date:=STRTODATE('17/3/2024');
          StartTime:=STRTOTIME('11:00');
          EndTime:=STRTOTIME('11:55');
          EventID:='65387915';
          LocID:='1112';
          WRITE(DiaryFile, Diary);

          Date:=STRTODATE('17/3/2024');
          StartTime:=STRTOTIME('14:00');
          EndTime:=STRTOTIME('14:30');
          EventID:='65387915';
          LocID:='1111';
          WRITE(DiaryFile, Diary);

          Date:=STRTODATE('19/3/2024');
          StartTime:=STRTOTIME('10:00');
          EndTime:=STRTOTIME('10:45');
          EventID:='65387915';
          LocID:='1110';
          WRITE(DiaryFile, Diary);

          Date:=STRTODATE('19/3/2024');
          StartTime:=STRTOTIME('10:00');
          EndTime:=STRTOTIME('10:45');
          EventID:='65387915';
          LocID:='1112';
          WRITE(DiaryFile, Diary);

          Date:=STRTODATE('20/4/2024');
          StartTime:=STRTOTIME('10:00');
          EndTime:=STRTOTIME('10:45');
          EventID:='65387915';
          LocID:='1111';
          WRITE(DiaryFile, Diary);

          Date:=STRTODATE('21/4/2024');
          StartTime:=STRTOTIME('10:00');
          EndTime:=STRTOTIME('10:45');
          EventID:='65387915';
          LocID:='1111';
          WRITE(DiaryFile, Diary);
        end;
    end;

  PROCEDURE CreateEmployeeFile;
    BEGIN
      ASSIGN(EmployeeFile,'c:\Users\harry\Documents\CompSci\Employee.dta');
      REWRITE(EmployeeFile);
      With Employee DO
        BEGIN
          EmployeeID:= '1234567890';
          Surname := 'Tyrell';
          Firstname :='Harrison';
          WRITE(EmployeeFile, Employee);

          EmployeeID := '0987654321';
          Surname := 'Cooper';
          Firstname :='Andy';
          WRITE(EmployeeFile, Employee);

          EmployeeID := '5432167890';
          Surname := 'Davis';
          Firstname :='Harvey';
          WRITE(EmployeeFile, Employee);

          EmployeeID := '6789054321';
          Surname := 'Adams';
          Firstname :='Jack';
          WRITE(EmployeeFile, Employee);
        END;
    END;

  PROCEDURE CreateEventEmployeeFile;
    BEGIN
      Assign(EventEmployeeFile,'c:\Users\harry\Documents\CompSci\EventEmployee.dta');
      REWRITE(EventEmployeeFile);
      With  EventEmployee DO
        BEGIN
          EventID:= '65387915';
          EmployeeID:='1234567890';
          WRITE(EventEmployeeFile, EventEmployee);

          EventID:='35523682';
          EmployeeID:='0987654321';
          WRITE(EventEmployeeFile, EventEmployee);

          EventID:='53693578';
          EmployeeID:='5432167890';
          WRITE(EventEmployeeFile, EventEmployee);
        END;
    END;

  BEGIN
    CreateEmployeeFile;
    CreateLocationFile;
    CreateDocumentFile;
    CreateEventFile;
    CreateEventEmployeeFile;
    CreateTheDiaryFile;
  END.

