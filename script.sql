
/****** Object:  Table [dbo].[bancos]    Script Date: 1/10/2024 4:55:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bancos](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[banco] [nvarchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cuentas_bancarias]    Script Date: 1/10/2024 4:55:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cuentas_bancarias](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[banco_id] [int] NOT NULL,
	[saldo] [decimal](10, 2) NOT NULL,
	[bloqueada] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[movimientos]    Script Date: 1/10/2024 4:55:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[movimientos](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[banco_id] [int] NOT NULL,
	[valor] [decimal](10, 2) NOT NULL,
	[tipo_movimiento] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tipos_movimientos]    Script Date: 1/10/2024 4:55:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tipos_movimientos](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[movimiento] [nvarchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[USERS]    Script Date: 1/10/2024 4:55:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[USERS](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[NAME] [nvarchar](250) NULL,
	[PASSWORD] [varbinary](350) NULL,
	[DOCUMENT] [int] NULL,
	[MAIL] [nvarchar](250) NULL,
	[created_at] [datetime] NOT NULL,
 CONSTRAINT [PK_USERS] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[bancos] ON 

INSERT [dbo].[bancos] ([id], [banco]) VALUES (1, N'Bancolombia')
INSERT [dbo].[bancos] ([id], [banco]) VALUES (2, N'Davivienda')
INSERT [dbo].[bancos] ([id], [banco]) VALUES (3, N'Nequi')
SET IDENTITY_INSERT [dbo].[bancos] OFF
GO
SET IDENTITY_INSERT [dbo].[cuentas_bancarias] ON 

INSERT [dbo].[cuentas_bancarias] ([id], [user_id], [banco_id], [saldo], [bloqueada]) VALUES (1, 1, 1, CAST(1000.00 AS Decimal(10, 2)), 0)
INSERT [dbo].[cuentas_bancarias] ([id], [user_id], [banco_id], [saldo], [bloqueada]) VALUES (2, 2, 2, CAST(500.50 AS Decimal(10, 2)), 0)
INSERT [dbo].[cuentas_bancarias] ([id], [user_id], [banco_id], [saldo], [bloqueada]) VALUES (3, 3, 3, CAST(250.00 AS Decimal(10, 2)), 1)
SET IDENTITY_INSERT [dbo].[cuentas_bancarias] OFF
GO
SET IDENTITY_INSERT [dbo].[movimientos] ON 

INSERT [dbo].[movimientos] ([id], [user_id], [banco_id], [valor], [tipo_movimiento]) VALUES (2, 1, 3, CAST(0.00 AS Decimal(10, 2)), 4)
INSERT [dbo].[movimientos] ([id], [user_id], [banco_id], [valor], [tipo_movimiento]) VALUES (3, 1, 1, CAST(0.00 AS Decimal(10, 2)), 4)
INSERT [dbo].[movimientos] ([id], [user_id], [banco_id], [valor], [tipo_movimiento]) VALUES (4, 3, 3, CAST(0.00 AS Decimal(10, 2)), 4)
INSERT [dbo].[movimientos] ([id], [user_id], [banco_id], [valor], [tipo_movimiento]) VALUES (6, 1, 1, CAST(0.00 AS Decimal(10, 2)), 4)
SET IDENTITY_INSERT [dbo].[movimientos] OFF
GO
SET IDENTITY_INSERT [dbo].[tipos_movimientos] ON 

INSERT [dbo].[tipos_movimientos] ([id], [movimiento]) VALUES (1, N'Depósito')
INSERT [dbo].[tipos_movimientos] ([id], [movimiento]) VALUES (2, N'Retiro')
INSERT [dbo].[tipos_movimientos] ([id], [movimiento]) VALUES (3, N'Transferencia')
INSERT [dbo].[tipos_movimientos] ([id], [movimiento]) VALUES (4, N'Bloqueo cuenta')
SET IDENTITY_INSERT [dbo].[tipos_movimientos] OFF
GO
SET IDENTITY_INSERT [dbo].[USERS] ON 

INSERT [dbo].[USERS] ([ID], [NAME], [PASSWORD], [DOCUMENT], [MAIL], [created_at]) VALUES (1, N'Richard', 0xFB2E52C628A01046BCC548C4242C9FA59BCFCE9B5865F33A0CC70ADCA16C20F5, 123456789, N'r1chardevmai@gmail.com', CAST(N'2024-10-01T12:51:20.533' AS DateTime))
INSERT [dbo].[USERS] ([ID], [NAME], [PASSWORD], [DOCUMENT], [MAIL], [created_at]) VALUES (2, N'Joan', 0x1445217533E7D4D0CFFD9109C4EDB60D62A02C0F0DE9537BE44F5E00D348EB4F, 12345, N'Joan@gmail.com', CAST(N'2024-10-01T15:16:52.230' AS DateTime))
INSERT [dbo].[USERS] ([ID], [NAME], [PASSWORD], [DOCUMENT], [MAIL], [created_at]) VALUES (3, N'Lenis', 0x26D6A8AD97C75FFC548F6873E5E93CE475479E3E1A1097381E54221FB53EC1D2, 123, N'lenis@gmail.com', CAST(N'2024-10-01T15:56:35.363' AS DateTime))
SET IDENTITY_INSERT [dbo].[USERS] OFF
GO
ALTER TABLE [dbo].[movimientos]  WITH CHECK ADD FOREIGN KEY([banco_id])
REFERENCES [dbo].[bancos] ([id])
GO
ALTER TABLE [dbo].[movimientos]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[USERS] ([ID])
GO
/****** Object:  StoredProcedure [dbo].[get_users]    Script Date: 1/10/2024 4:55:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[get_users] 
AS
BEGIN
	SET NOCOUNT ON;
	SELECT(SELECT        ID, NAME, [DOCUMENT], MAIL
	FROM            USERS FOR JSON PATH) AS json_data 
END
GO
/****** Object:  StoredProcedure [dbo].[insert_users]    Script Date: 1/10/2024 4:55:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--[insert_users] 'Camilo','camilo@mail.com','123456','12345'

CREATE PROCEDURE [dbo].[insert_users] 
	@Name nvarchar(250),
	@Email nvarchar(250),
	@Document int,
	@Password nvarchar(30),
	@UserId INT =0 OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRY
	if exists(SELECT TOP 1 * FROM USERS WHERE MAIL=LTRIM(RTRIM(@Email)) OR DOCUMENT=@Document)
	BEGIN
		SET @UserId=0;
		RETURN;
	end
		DECLARE @PasswordHash varbinary(32);
		SELECT @PasswordHash = HASHBYTES('SHA2_256',@Password);

		INSERT INTO dbo.USERS
			(created_at, MAIL, PASSWORD, [NAME], DOCUMENT)
		VALUES
			(GETDATE(),LTRIM(RTRIM(@Email)),@PasswordHash, @Name, @Document)

		SELECT TOP 1 @UserId=MAX(ID) from USERS
		PRINT @UserId
	
	END TRY
	BEGIN CATCH
		--EXECUTE dbo.ErrorsController
		SELECT ERROR_MESSAGE();
		RETURN;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[ObtenerMovimientosPorUsuario]    Script Date: 1/10/2024 4:55:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ObtenerMovimientosPorUsuario]
    @User_id INT,
	@response nvarchar(max)='' OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    SET @response=(SELECT         
        b.banco,
        m.valor,
        tm.movimiento AS tipo_movimiento
    FROM 
        movimientos m
    INNER JOIN 
        tipos_movimientos tm ON m.tipo_movimiento = tm.id
	INNER JOIN bancos b ON m.banco_id = b.id
    WHERE 
        m.user_id = @User_id FOR JSON PATH);
END
GO
/****** Object:  StoredProcedure [dbo].[sp_BloquearCuentaBancaria]    Script Date: 1/10/2024 4:55:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_BloquearCuentaBancaria]
    @user_id INT,
    @banco_id INT,
	@rows_affected INT =0 OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE cuentas_bancarias
    SET bloqueada = 1
    WHERE [user_id] = @user_id AND banco_id = @banco_id;

	SET @rows_affected = @@ROWCOUNT;


	insert into movimientos values(@user_id,@banco_id,0,4)
END
GO
/****** Object:  StoredProcedure [dbo].[sp_ObtenerCuentasPorUsuario]    Script Date: 1/10/2024 4:55:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ObtenerCuentasPorUsuario]
    @user_id INT,
	@response nvarchar(max)='No hay cuentas inscritas' OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    set @response=(SELECT b.banco, cb.saldo 
    FROM cuentas_bancarias cb
    INNER JOIN bancos b ON cb.banco_id = b.id
    WHERE cb.[user_id] = @user_id
    FOR JSON PATH);
END
GO
/****** Object:  StoredProcedure [dbo].[users_login]    Script Date: 1/10/2024 4:55:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--EXEC users_login '123456789',123456789
CREATE PROCEDURE [dbo].[users_login] 
@document int,
@password nvarchar(250),
@response nvarchar(max)='Usuario o contraseña erroneos' OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @PasswordHash varbinary(32);
	SELECT @PasswordHash = HASHBYTES('SHA2_256',@Password);

	IF exists(select top 1 * from USERS where document=LTRIM(RTRIM(@document)) and [PASSWORD]=@PasswordHash)
	begin
	SET @response = (
    SELECT 
        (
            SELECT u.ID, NAME, [DOCUMENT], MAIL, cb.id as id_cuenta 
            FROM USERS u
			LEFT JOIN cuentas_bancarias cb on u.id=cb.[user_id]
            WHERE DOCUMENT = LTRIM(RTRIM(@document)) 
            FOR JSON PATH
        ) );
		print @response
	end
	else
		SET @response='Usuario o contraseña erroneos'

END
GO
/****** Object:  StoredProcedure [dbo].[UsersSetPassword]    Script Date: 1/10/2024 4:55:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UsersSetPassword]
(
    @Email int,
    @OldPassword varchar(30),
    @NewPassword varchar(30)
)
AS
BEGIN
    SET NOCOUNT ON;

    -- Acciones
    BEGIN TRY
        -- El password está guardado como SHA256(Password), verificar que es igual que @OldPassword
        DECLARE @OldHashSegunUsuario varbinary(32);
        SELECT @OldHashSegunUsuario = HASHBYTES('SHA2_256', @OldPassword);

        DECLARE @Coincide int = 0;
        SELECT @Coincide = COUNT(*) FROM dbo.USERS WHERE [PASSWORD] = @OldHashSegunUsuario;
        IF @Coincide = 0
        BEGIN
            SELECT 0; 
            RETURN;
        END

        -- Si ha coincidido, se establece nuevo password
        DECLARE @NuevoHash varbinary(32);
        SELECT @NuevoHash = HASHBYTES('SHA2_256', @NewPassword);
        UPDATE dbo.USERS SET [PASSWORD] = @NuevoHash WHERE MAIL = @Email;
        SELECT 1; 
        RETURN;
    END TRY
    BEGIN CATCH
        -- Manejo de errores
        SELECT ERROR_MESSAGE();
        RETURN;
    END CATCH
END
GO
