Class Oliver.SQL
{

ClassMethod Query1() As %Status
{
  set query = "SELECT ID, Caption, Href, InitialTimestamp, MedKazId, ProviderName, ResultText FROM Oliver_Epic.TestResult"
  set statement = ##class(%SQL.Statement).%New(1)  ; 1 - ODBC mode
  set status = statement.%Prepare(query)
  if $$$ISERR(status) {write "%Prepare failed:" do $SYSTEM.Status.DisplayError(status) quit}

  set rset = statement.%Execute()
  if (rset.%SQLCODE '= 0) {write "%Execute failed:", !, "SQLCODE ", rset.%SQLCODE, ": ", rset.%Message quit}

  while rset.%Next()
  {
    write "Row count ",rset.%ROWCOUNT,!
    write rset.ID
    write ", Href ",rset.Href,!!
  }
  if (rset.%SQLCODE < 0) {write "%Next failed:", !, "SQLCODE ", rset.%SQLCODE, ": ", rset.%Message quit}
  write !,"End of data"
  write !,"Total row count=",rset.%ROWCOUNT
  Quit 1
}

}
