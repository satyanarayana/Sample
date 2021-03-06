USE [TestDB]
GO
/****** Object:  UserDefinedFunction [dbo].[pwd_decrypt]    Script Date: 18-04-2020 17:49:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
create  function  [dbo].[pwd_decrypt] (@strTxt AS VARCHAR (50)) RETURNS VARCHAR (50) as  
begin   
DECLARE @i Int  
DECLARE @c varchar(50)  
DECLARE @cTemp varchar(50)  
  
SELECT @i = 1  
SELECT @cTemp=''  
WHILE  @i <= Len(@strTxt)  
  
 BEGIN   
    If Ascii(substring(@strTxt, @i, 1)) > 127   
 begin  
        SELECT  @c = Char(Ascii(substring(@strTxt, @i, 1)) - 127)  
        SELECT @cTemp = @cTemp + @c  
 end  
    If Ascii(substring(@strTxt, @i, 1)) <= 127   
     SELECT @cTemp = @cTemp + SUBSTRING(@strTxt, @i, 1)  
SELECT @i = @i + 1  
END  
  
Return @cTemp  
END --//




 
GO
/****** Object:  UserDefinedFunction [dbo].[pwd_encrypt]    Script Date: 18-04-2020 17:49:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create  function  [dbo].[pwd_encrypt] (@strTxt AS VARCHAR (50)) RETURNS VARCHAR (50) as    
begin     
DECLARE @i Int    
DECLARE @c varchar(50)    
DECLARE @cTemp varchar(50)    
    
SELECT @i = 1    
SELECT @cTemp=''    
WHILE  @i <= Len(@strTxt)    
    
 BEGIN     
    If Ascii(substring(@strTxt, @i, 1)) < 127     
 begin    
        SELECT  @c = Char(Ascii(substring(@strTxt, @i, 1)) + 127)    
        SELECT @cTemp = @cTemp + @c    
 end    
    If Ascii(substring(@strTxt, @i, 1)) >= 127     
     SELECT @cTemp = @cTemp + SUBSTRING(@strTxt, @i, 1)    
SELECT @i = @i + 1    
END    
    
Return @cTemp    
END 
GO
/****** Object:  Table [dbo].[TBL_Messages]    Script Date: 18-04-2020 17:49:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TBL_Messages](
	[M_ID] [int] IDENTITY(1,1) NOT NULL,
	[M_UID] [int] NOT NULL,
	[M_WID] [int] NOT NULL,
	[M_Subject] [varchar](50) NOT NULL,
	[Message] [text] NOT NULL,
	[M_Website] [varchar](50) NOT NULL,
	[M_Status] [varchar](10) NOT NULL,
	[M_PostedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_TBL_Messages] PRIMARY KEY CLUSTERED 
(
	[M_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TBL_UserMaster]    Script Date: 18-04-2020 17:49:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TBL_UserMaster](
	[UID] [int] IDENTITY(1,1000) NOT NULL,
	[UName] [varchar](50) NOT NULL,
	[UPassword] [varchar](50) NOT NULL,
	[UEmail] [varchar](150) NOT NULL,
	[UStatus] [varchar](5) NOT NULL CONSTRAINT [DF_TBL_UserMaster_UStatus]  DEFAULT ((0)),
	[ULocation] [varchar](50) NOT NULL,
	[UCreatedDate] [datetime] NULL,
	[ULastLogin] [datetime] NULL,
 CONSTRAINT [PK_TBL_UserMaster] PRIMARY KEY CLUSTERED 
(
	[UID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TBL_Visitors]    Script Date: 18-04-2020 17:49:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TBL_Visitors](
	[V_ID] [int] IDENTITY(1,1) NOT NULL,
	[V_UID] [int] NOT NULL,
	[V_WID] [int] NULL,
	[V_Website] [varchar](50) NOT NULL,
	[V_IPAddress] [varchar](50) NOT NULL,
	[V_Location] [varchar](50) NOT NULL,
	[V_OS] [varchar](20) NOT NULL,
	[V_Browser] [varchar](20) NOT NULL,
	[V_Messages_Count] [varchar](10) NOT NULL,
 CONSTRAINT [PK_TBL_Visitors] PRIMARY KEY CLUSTERED 
(
	[V_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TBL_Websites]    Script Date: 18-04-2020 17:49:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TBL_Websites](
	[W_ID] [int] IDENTITY(1,1) NOT NULL,
	[W_Title] [varchar](50) NOT NULL,
	[W_URL] [varchar](50) NOT NULL,
	[W_Status] [varchar](10) NOT NULL,
	[W_Createddate] [datetime] NOT NULL,
 CONSTRAINT [PK_TBL_Websites] PRIMARY KEY CLUSTERED 
(
	[W_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  View [dbo].[Messages]    Script Date: 18-04-2020 17:49:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Messages]
AS
SELECT        M_Subject, Message, M_Website, M_Status, M_PostedDate
FROM            dbo.TBL_Messages

GO
/****** Object:  View [dbo].[Visitors]    Script Date: 18-04-2020 17:49:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Visitors]
AS
SELECT        TOP (100) PERCENT V_Website, V_IPAddress, V_Location, V_OS, V_Browser, V_Messages_Count
FROM            dbo.TBL_Visitors
ORDER BY V_Website

GO
/****** Object:  View [dbo].[Websites]    Script Date: 18-04-2020 17:49:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Websites]
AS
SELECT        TOP (100) PERCENT W_Title, W_URL, W_Createddate
FROM            dbo.TBL_Websites
ORDER BY W_Title

GO
SET IDENTITY_INSERT [dbo].[TBL_Messages] ON 

INSERT [dbo].[TBL_Messages] ([M_ID], [M_UID], [M_WID], [M_Subject], [Message], [M_Website], [M_Status], [M_PostedDate]) VALUES (1, 3001, 1, N'RblTestMessage', N'RBL Test Comment', N'RBL', N'A', CAST(N'2020-02-13 09:09:59.240' AS DateTime))
INSERT [dbo].[TBL_Messages] ([M_ID], [M_UID], [M_WID], [M_Subject], [Message], [M_Website], [M_Status], [M_PostedDate]) VALUES (2, 4001, 3, N'MkeyesTestMessage', N'Mkeyes Test Comment', N'Mkeyes', N'A', CAST(N'2020-04-12 07:09:59.290' AS DateTime))
INSERT [dbo].[TBL_Messages] ([M_ID], [M_UID], [M_WID], [M_Subject], [Message], [M_Website], [M_Status], [M_PostedDate]) VALUES (3, 5001, 1, N'RblTest', N'RBL Message', N'RBL', N'I', CAST(N'2020-02-18 11:09:59.290' AS DateTime))
INSERT [dbo].[TBL_Messages] ([M_ID], [M_UID], [M_WID], [M_Subject], [Message], [M_Website], [M_Status], [M_PostedDate]) VALUES (4, 6001, 2, N'YBL CC', N'YBL CC Message', N'YBLCC', N'A', CAST(N'2020-04-22 12:09:59.293' AS DateTime))
INSERT [dbo].[TBL_Messages] ([M_ID], [M_UID], [M_WID], [M_Subject], [Message], [M_Website], [M_Status], [M_PostedDate]) VALUES (5, 3001, 5, N'IDBI Testing', N'IDBI Test Comment', N'IDBI', N'A', CAST(N'2020-03-18 13:09:59.293' AS DateTime))
INSERT [dbo].[TBL_Messages] ([M_ID], [M_UID], [M_WID], [M_Subject], [Message], [M_Website], [M_Status], [M_PostedDate]) VALUES (6, 4001, 4, N'BOM Comment', N'BOM Comment', N'BOM', N'A', CAST(N'2020-04-11 12:09:59.293' AS DateTime))
INSERT [dbo].[TBL_Messages] ([M_ID], [M_UID], [M_WID], [M_Subject], [Message], [M_Website], [M_Status], [M_PostedDate]) VALUES (7, 7001, 1, N'RblTest3', N'RBL Message', N'RBL', N'I', CAST(N'2020-04-18 09:09:59.293' AS DateTime))
INSERT [dbo].[TBL_Messages] ([M_ID], [M_UID], [M_WID], [M_Subject], [Message], [M_Website], [M_Status], [M_PostedDate]) VALUES (8, 4001, 2, N'YBL Cooment', N'YBL CC Comment', N'YBLCC', N'A', CAST(N'2020-03-12 10:09:59.293' AS DateTime))
SET IDENTITY_INSERT [dbo].[TBL_Messages] OFF
SET IDENTITY_INSERT [dbo].[TBL_UserMaster] ON 

INSERT [dbo].[TBL_UserMaster] ([UID], [UName], [UPassword], [UEmail], [UStatus], [ULocation], [UCreatedDate], [ULastLogin]) VALUES (3001, N'Abc', N'Óäòó¿°±²', N'Abc@gmail.com', N'A', N'Hyd', CAST(N'2020-04-18 00:31:36.073' AS DateTime), NULL)
INSERT [dbo].[TBL_UserMaster] ([UID], [UName], [UPassword], [UEmail], [UStatus], [ULocation], [UCreatedDate], [ULastLogin]) VALUES (4001, N'XYZ', N'÷øù¿°±²', N'xyz@gmail.com', N'A', N'Hyd', CAST(N'2020-04-18 00:32:16.887' AS DateTime), NULL)
INSERT [dbo].[TBL_UserMaster] ([UID], [UName], [UPassword], [UEmail], [UStatus], [ULocation], [UCreatedDate], [ULastLogin]) VALUES (5001, N'XYZ', N'÷øù¿°±²', N'xyz@gmail.com', N'A', N'Hyd', CAST(N'2020-04-18 00:32:25.110' AS DateTime), NULL)
INSERT [dbo].[TBL_UserMaster] ([UID], [UName], [UPassword], [UEmail], [UStatus], [ULocation], [UCreatedDate], [ULastLogin]) VALUES (6001, N'123', N'Óäòó¿°±²', N'Abc@gmail.com', N'A', N'Hyd', CAST(N'2020-04-18 00:35:13.530' AS DateTime), NULL)
INSERT [dbo].[TBL_UserMaster] ([UID], [UName], [UPassword], [UEmail], [UStatus], [ULocation], [UCreatedDate], [ULastLogin]) VALUES (7001, N'456', N'÷øù¿°±²', N'xyz@gmail.com', N'A', N'Hyd', CAST(N'2020-04-18 00:35:13.530' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[TBL_UserMaster] OFF
SET IDENTITY_INSERT [dbo].[TBL_Visitors] ON 

INSERT [dbo].[TBL_Visitors] ([V_ID], [V_UID], [V_WID], [V_Website], [V_IPAddress], [V_Location], [V_OS], [V_Browser], [V_Messages_Count]) VALUES (1, 3001, 1, N'RBL', N'115.98.14.135', N'Hyderabad', N'Windows', N'Chrome', N'1')
INSERT [dbo].[TBL_Visitors] ([V_ID], [V_UID], [V_WID], [V_Website], [V_IPAddress], [V_Location], [V_OS], [V_Browser], [V_Messages_Count]) VALUES (2, 4001, 3, N'Mkeyes', N'124.123.73.89', N'Kakinada', N'Windows', N'IE', N'2')
INSERT [dbo].[TBL_Visitors] ([V_ID], [V_UID], [V_WID], [V_Website], [V_IPAddress], [V_Location], [V_OS], [V_Browser], [V_Messages_Count]) VALUES (3, 5001, 1, N'RBL', N'115.98.14.135', N'Chennai', N'Windows', N'Chrome', N'1')
INSERT [dbo].[TBL_Visitors] ([V_ID], [V_UID], [V_WID], [V_Website], [V_IPAddress], [V_Location], [V_OS], [V_Browser], [V_Messages_Count]) VALUES (4, 6001, 2, N'YBLCC', N'115.98.14.135', N'Pune', N'Windows', N'Chrome', N'1')
INSERT [dbo].[TBL_Visitors] ([V_ID], [V_UID], [V_WID], [V_Website], [V_IPAddress], [V_Location], [V_OS], [V_Browser], [V_Messages_Count]) VALUES (5, 3001, 5, N'IDBI', N'115.98.14.135', N'Hyderabad', N'Windows', N'Chrome', N'1')
INSERT [dbo].[TBL_Visitors] ([V_ID], [V_UID], [V_WID], [V_Website], [V_IPAddress], [V_Location], [V_OS], [V_Browser], [V_Messages_Count]) VALUES (6, 4001, 4, N'BOM', N'60.243.174.26', N'Pune', N'Windows', N'Chrome', N'1')
INSERT [dbo].[TBL_Visitors] ([V_ID], [V_UID], [V_WID], [V_Website], [V_IPAddress], [V_Location], [V_OS], [V_Browser], [V_Messages_Count]) VALUES (7, 7001, 1, N'RBL', N'60.243.174.26', N'Hyderabad', N'Windows', N'Chrome', N'1')
INSERT [dbo].[TBL_Visitors] ([V_ID], [V_UID], [V_WID], [V_Website], [V_IPAddress], [V_Location], [V_OS], [V_Browser], [V_Messages_Count]) VALUES (11, 4001, 2, N'YBLCC', N'115.98.14.135', N'Bhopal', N'Windowa', N'Chrome', N'1')
SET IDENTITY_INSERT [dbo].[TBL_Visitors] OFF
SET IDENTITY_INSERT [dbo].[TBL_Websites] ON 

INSERT [dbo].[TBL_Websites] ([W_ID], [W_Title], [W_URL], [W_Status], [W_Createddate]) VALUES (1, N'RBL', N'www.rbl.co.in', N'A', CAST(N'2020-04-18 11:50:10.113' AS DateTime))
INSERT [dbo].[TBL_Websites] ([W_ID], [W_Title], [W_URL], [W_Status], [W_Createddate]) VALUES (2, N'YBLCC', N'www.yblcc.com', N'A', CAST(N'2020-04-18 11:50:10.140' AS DateTime))
INSERT [dbo].[TBL_Websites] ([W_ID], [W_Title], [W_URL], [W_Status], [W_Createddate]) VALUES (3, N'MKeyes', N'www.mkeyes.com', N'A', CAST(N'2020-04-18 11:50:10.140' AS DateTime))
INSERT [dbo].[TBL_Websites] ([W_ID], [W_Title], [W_URL], [W_Status], [W_Createddate]) VALUES (4, N'BOM', N'www.bom.com', N'A', CAST(N'2020-04-18 11:50:10.157' AS DateTime))
INSERT [dbo].[TBL_Websites] ([W_ID], [W_Title], [W_URL], [W_Status], [W_Createddate]) VALUES (5, N'IDBI', N'www.idbi.com', N'A', CAST(N'2020-04-18 11:50:10.163' AS DateTime))
SET IDENTITY_INSERT [dbo].[TBL_Websites] OFF
ALTER TABLE [dbo].[TBL_Messages]  WITH CHECK ADD  CONSTRAINT [FK_TBL_Messages_TBL_UserMaster] FOREIGN KEY([M_UID])
REFERENCES [dbo].[TBL_UserMaster] ([UID])
GO
ALTER TABLE [dbo].[TBL_Messages] CHECK CONSTRAINT [FK_TBL_Messages_TBL_UserMaster]
GO
ALTER TABLE [dbo].[TBL_Messages]  WITH CHECK ADD  CONSTRAINT [FK_TBL_Messages_TBL_Websites] FOREIGN KEY([M_WID])
REFERENCES [dbo].[TBL_Websites] ([W_ID])
GO
ALTER TABLE [dbo].[TBL_Messages] CHECK CONSTRAINT [FK_TBL_Messages_TBL_Websites]
GO
ALTER TABLE [dbo].[TBL_Visitors]  WITH CHECK ADD  CONSTRAINT [FK_TBL_Visitors_TBL_UserMaster] FOREIGN KEY([V_UID])
REFERENCES [dbo].[TBL_UserMaster] ([UID])
GO
ALTER TABLE [dbo].[TBL_Visitors] CHECK CONSTRAINT [FK_TBL_Visitors_TBL_UserMaster]
GO
ALTER TABLE [dbo].[TBL_Visitors]  WITH CHECK ADD  CONSTRAINT [FK_TBL_Visitors_TBL_Websites] FOREIGN KEY([V_WID])
REFERENCES [dbo].[TBL_Websites] ([W_ID])
GO
ALTER TABLE [dbo].[TBL_Visitors] CHECK CONSTRAINT [FK_TBL_Visitors_TBL_Websites]
GO
/****** Object:  StoredProcedure [dbo].[TEST_BINDMASTER]    Script Date: 18-04-2020 17:49:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[TEST_BINDMASTER]
AS
BEGIN
SELECT W_ID,W_TITLE FROM  TBL_WEBSITES Order by W_Title ASC
SELECT DISTINCT V_Location FROM TBL_Visitors Order by V_Location ASC
END
GO
/****** Object:  StoredProcedure [dbo].[TEST_DELIVERED_MESSAGES]    Script Date: 18-04-2020 17:49:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--EXEC TEST_DELIVERED_MESSAGES 'MKEYES','ALL','APR 2020'
CREATE PROC [dbo].[TEST_DELIVERED_MESSAGES]
(
	@WEBSITE VARCHAR(40),
	@LOCATION VARCHAR(50),
	@DATE VARCHAR(50)
)
AS
BEGIN



;WITH CTE AS
(
SELECT DISTINCT  COUNT(1) AS CHECKED, M_STATUS
FROM 
TBL_MESSAGES M  
INNER JOIN TBL_VISITORS V ON M.M_WID=V.V_WID AND M.M_UID=V.V_UID
WHERE M_WEBSITE=CASE WHEN @WEBSITE='ALL' THEN M_WEBSITE ELSE @WEBSITE END 
AND V_LOCATION = CASE WHEN @LOCATION='ALL' THEN V_LOCATION ELSE @LOCATION END
AND  CONVERT(CHAR(4), M_POSTEDDATE, 100) + CONVERT(CHAR(4), M_POSTEDDATE, 120)=@DATE
GROUP BY M_STATUS
)

 
SELECT @WEBSITE WEBSITE,@LOCATION LOCATION,ISNULL(SUM(CASE WHEN M_STATUS = 'A' THEN CHECKED END),0) CHECKED, ISNULL(SUM(CASE WHEN M_STATUS = 'I' THEN [CHECKED] END),0) [NOT CHECKED] 
FROM CTE  ORDER BY [NOT CHECKED] DESC

END
GO
/****** Object:  StoredProcedure [dbo].[TEST_DELIVERED_MESSAGES_ONTIME]    Script Date: 18-04-2020 17:49:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--EXEC TEST_DELIVERED_MESSAGES_ONTIME 'ALL','ALL','04/18/2020'
CREATE PROC [dbo].[TEST_DELIVERED_MESSAGES_ONTIME]
(
	@WEBSITE VARCHAR(40),
	@LOCATION VARCHAR(50),
	@DATE VARCHAR(50)
)
AS
BEGIN



;WITH CTE AS
(
SELECT DISTINCT  COUNT(1) AS CHECKED
FROM 
TBL_MESSAGES M  
INNER JOIN TBL_VISITORS V ON M.M_WID=V.V_WID AND M.M_UID=V.V_UID
WHERE M_WEBSITE=CASE WHEN @WEBSITE='ALL' THEN M_WEBSITE ELSE @WEBSITE END 
AND V_LOCATION = CASE WHEN @LOCATION='ALL' THEN V_LOCATION ELSE @LOCATION END
AND  CONVERT(Varchar(15), M_POSTEDDATE, 101)=@DATE
GROUP BY M_STATUS
)

 
SELECT @WEBSITE WEBSITE,@LOCATION LOCATION,SUM(CHECKED) MessagesCount
FROM CTE  ORDER BY MessagesCount DESC

END
GO
/****** Object:  StoredProcedure [dbo].[TEST_MESSAGESDELIVERED_BYBROWSERTYPE]    Script Date: 18-04-2020 17:49:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--EXEC TEST_MESSAGESDELIVERED_BYBROWSERTYPE 'RBL','Pune','APR 2020'
CREATE PROC [dbo].[TEST_MESSAGESDELIVERED_BYBROWSERTYPE]
(
	@WEBSITE VARCHAR(40),
	@LOCATION VARCHAR(50),
	@DATE VARCHAR(50)
)
AS
BEGIN



;WITH CTE AS
(
SELECT DISTINCT V_BROWSER BROWSER, COUNT(1) AS TOTAL,COUNT(M.M_WEBSITE) MESSAAGESCOUNT
FROM 
TBL_MESSAGES M  
INNER JOIN TBL_VISITORS V ON M.M_WID=V.V_WID AND M.M_UID=V.V_UID
WHERE M_WEBSITE=CASE WHEN @WEBSITE='ALL' THEN M_WEBSITE ELSE @WEBSITE END 
AND V_LOCATION = CASE WHEN @LOCATION='ALL' THEN V_LOCATION ELSE @LOCATION END
AND  CONVERT(CHAR(4), M_POSTEDDATE, 100) + CONVERT(CHAR(4), M_POSTEDDATE, 120)=@DATE
GROUP BY V_BROWSER,M_WEBSITE
)

 
SELECT @WEBSITE WEBSITE,@LOCATION LOCATION,BROWSER,SUM(TOTAL) BROWSERCOUNT ,SUM(MESSAAGESCOUNT) MESSAAGESCOUNT
FROM CTE  GROUP BY BROWSER 






END
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "TBL_Messages"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 211
               Right = 287
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Messages'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Messages'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "TBL_Visitors"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 211
               Right = 303
            End
            DisplayFlags = 280
            TopColumn = 1
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Visitors'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Visitors'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "TBL_Websites"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 1
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Websites'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Websites'
GO
