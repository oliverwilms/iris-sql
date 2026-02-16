Class Oliver.SQL
{

ClassMethod ExecuteQueryOneValue(pQuery As %String, ByRef pResult As %String) As %Status
{
	Set pResult = ""
	Set rs = ##class(%ResultSet).%New()
	Set tSC = rs.Prepare(pQuery)
	If $$$ISOK(tSC) {
		Set tSC = rs.Execute()
		If $$$ISOK(tSC), rs.Next() Set pResult = rs.GetData(1)
	}
	Do rs.Close()
	Set rs = ""
	Quit tSC
}

/// "SELECT ID, Name FROM dc_iris.category WHERE ...
ClassMethod ExecuteQuerySelect(pQuery As %String, ByRef pResultArray) As %Status
{
    Try {
        Set statement = ##class(%SQL.Statement).%New(1)  ; 1 - ODBC mode
        Set status = statement.%Prepare(pQuery)
        If $$$ISERR(status) {write "%Prepare failed:" do $SYSTEM.Status.DisplayError(status) quit}
        Set rset = statement.%Execute()
        If (rset.%SQLCODE '= 0) {write "%Execute failed:", !, "SQLCODE ", rset.%SQLCODE, ": ", rset.%Message quit}
        ;
        Set x = $Piece(pQuery,"SELECT ",2)
        Set columns = $Piece(x," FROM",1)
        For index = 1:1:$Length(columns,", ") {
            Set col(index) = $Piece(columns,", ",index)
        }
        ;
        While rset.%Next() {
            Set tRowCount = rset.%ROWCOUNT
            Set tID = rset.ID
            Set index = 2
            Set tData = rset.%GetData(index)
            Set pResultArray(tRowCount) = tData
        }
        If (rset.%SQLCODE < 0) {write "%Next failed:", !, "SQLCODE ", rset.%SQLCODE, ": ", rset.%Message quit}
    } Catch ex {}
    Quit $$$OK
}

ClassMethod GetDateTimeDiff(pTS1 As %String, pTS2 As %String, pTSI As %String = "SQL_TSI_FRAC_SECOND") As %String
{
	Set c = ","
	Set q = "'"
	Set pQuery = "SELECT {fn TIMESTAMPDIFF("_pTSI_c_q_pTS1_q_c_q_pTS2_q_")}"
	Set tSC = ..ExecuteQueryOneValue(pQuery,.pResult)
	Quit $Get(pResult,"<undefined>")
}


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
