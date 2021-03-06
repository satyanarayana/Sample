USE [Sample]
GO
/****** Object:  Table [dbo].[TBL_Email]    Script Date: 10-04-2020 14:13:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TBL_Email](
	[EID] [int] NOT NULL,
	[UID] [int] NOT NULL,
	[From_Email] [varchar](150) NOT NULL,
	[To_Email] [varchar](max) NOT NULL,
	[CC_Email] [varchar](max) NULL,
	[BCC_Email] [varchar](max) NULL,
	[EDescription] [text] NULL,
	[Attcahments] [varchar](max) NULL,
	[PostedOn] [datetime] NULL,
 CONSTRAINT [PK_TBL_Email] PRIMARY KEY CLUSTERED 
(
	[EID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TBL_HistoryMails]    Script Date: 10-04-2020 14:13:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TBL_HistoryMails](
	[HID] [int] NOT NULL,
	[EID] [int] NOT NULL,
	[UID] [int] NOT NULL,
	[From_Email] [varchar](150) NOT NULL,
	[To_Email] [varchar](max) NOT NULL,
	[CC_Email] [varchar](max) NULL,
	[BCC_Email] [varchar](max) NULL,
	[SDescription] [text] NULL,
	[Attcahments] [varchar](max) NULL,
	[MovedTo] [varchar](20) NULL,
	[PostedOn] [datetime] NULL,
 CONSTRAINT [PK_TBL_HistoryMails] PRIMARY KEY CLUSTERED 
(
	[HID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TBL_SentMails]    Script Date: 10-04-2020 14:13:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TBL_SentMails](
	[SID] [int] NOT NULL,
	[EID] [int] NOT NULL,
	[UID] [int] NOT NULL,
	[From_Email] [varchar](150) NOT NULL,
	[To_Email] [varchar](max) NOT NULL,
	[CC_Email] [varchar](max) NULL,
	[BCC_Email] [varchar](max) NULL,
	[SDescription] [text] NULL,
	[Attcahments] [varchar](max) NULL,
	[PostedOn] [datetime] NULL,
 CONSTRAINT [PK_TBL_SentMails] PRIMARY KEY CLUSTERED 
(
	[SID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TBL_UserMaster]    Script Date: 10-04-2020 14:13:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TBL_UserMaster](
	[UID] [int] NOT NULL,
	[UName] [varchar](50) NOT NULL,
	[UEmail] [varchar](150) NOT NULL,
	[UStatus] [varchar](5) NOT NULL,
	[ULocation] [varchar](50) NOT NULL,
	[ULastLogin] [datetime] NULL,
	[UCreatedDate] [datetime] NULL,
 CONSTRAINT [PK_TBL_UserMaster] PRIMARY KEY CLUSTERED 
(
	[UID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[TBL_UserMaster] ADD  CONSTRAINT [DF_TBL_UserMaster_UStatus]  DEFAULT ((0)) FOR [UStatus]
GO
ALTER TABLE [dbo].[TBL_Email]  WITH CHECK ADD  CONSTRAINT [FK_TBL_Email_TBL_UserMaster] FOREIGN KEY([UID])
REFERENCES [dbo].[TBL_UserMaster] ([UID])
GO
ALTER TABLE [dbo].[TBL_Email] CHECK CONSTRAINT [FK_TBL_Email_TBL_UserMaster]
GO
ALTER TABLE [dbo].[TBL_HistoryMails]  WITH CHECK ADD  CONSTRAINT [FK_TBL_HistoryMails_TBL_Email] FOREIGN KEY([EID])
REFERENCES [dbo].[TBL_Email] ([EID])
GO
ALTER TABLE [dbo].[TBL_HistoryMails] CHECK CONSTRAINT [FK_TBL_HistoryMails_TBL_Email]
GO
ALTER TABLE [dbo].[TBL_HistoryMails]  WITH CHECK ADD  CONSTRAINT [FK_TBL_HistoryMails_TBL_UserMaster] FOREIGN KEY([UID])
REFERENCES [dbo].[TBL_UserMaster] ([UID])
GO
ALTER TABLE [dbo].[TBL_HistoryMails] CHECK CONSTRAINT [FK_TBL_HistoryMails_TBL_UserMaster]
GO
ALTER TABLE [dbo].[TBL_SentMails]  WITH CHECK ADD  CONSTRAINT [FK_TBL_SentMails_TBL_Email] FOREIGN KEY([EID])
REFERENCES [dbo].[TBL_Email] ([EID])
GO
ALTER TABLE [dbo].[TBL_SentMails] CHECK CONSTRAINT [FK_TBL_SentMails_TBL_Email]
GO
ALTER TABLE [dbo].[TBL_SentMails]  WITH CHECK ADD  CONSTRAINT [FK_TBL_SentMails_TBL_UserMaster] FOREIGN KEY([UID])
REFERENCES [dbo].[TBL_UserMaster] ([UID])
GO
ALTER TABLE [dbo].[TBL_SentMails] CHECK CONSTRAINT [FK_TBL_SentMails_TBL_UserMaster]
GO
