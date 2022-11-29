create proc insert_update_reg 
@username nvarchar(50),
@passeword nvarchar(50),
@email nvarchar(50),
@phone nvarchar(50)

as
begin transaction
begin try

declare @register table (username nvarchar(50) , password_ nvarchar(50) , email nvarchar(50) , phone nvarchar(50))
merge into registration as tgt
using (values(@username , @passeword , @email , @phone)) as src (username , password_ , email , phone) on
tgt.username = src.username when matched then update set password_ = src.password_
when not matched by target then insert (username,password_, email , phone) values (username,password_, email , phone);

commit transaction
end try

begin catch 
if @@TRANCOUNT > 0
begin 
rollback transaction
end
end catch



