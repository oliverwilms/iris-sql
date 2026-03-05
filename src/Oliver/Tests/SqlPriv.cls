Class Oliver.Tests.SqlPriv Extends %RegisteredObject
{

Parameter Priv = "s";

// "s" for SELECT

Parameter SqlClass = "HS.Local.VA.eSCM.Feeder.ResponseTime";

Parameter SqlTable = "HS_Local_VA_eSCM_Feeder.ResponseTime";

Parameter Type = "Table";

Parameter User = "eccmon";

ClassMethod Test0() As %String
{
    Set oTest = $ClassMethod(..#SqlClass,"%New")
    Set test = $IsObject(oTest)
    Quit test
}

ClassMethod Test1() As %String
{
    Set pType = 1  // 1 for tables
    Set result = $System.SQL.Security.CheckPrivilege(..#User,pType,..#SqlClass,..#Priv)
    If result {
        Write "The user has privilege on the class.",!
    } Else {
        Write "The user does NOT have SELECT privilege on the class.",!
    }
    Set result = $System.SQL.Security.CheckPrivilege(..#User,pType,..#SqlTable,..#Priv)
    If result {
        Write "The user has privilege on the table.",!
    } Else {
        Write "The user does NOT have SELECT privilege on the table.",!
    }
    Quit result
}

ClassMethod Test2() As %Status
{
    Set pAction = "SELECT"
    Set tSC = $System.SQL.Security.GrantPrivilege(pAction,..#SqlClass,..#Type,..#User)
    If $$$ISERR(tSC) {
        Write $System.Status.GetErrorText(tSC),!
    } Else {
        Write "Grant OK",!
    }
    Set tSC = $System.SQL.Security.GrantPrivilege(pAction,..#SqlTable,..#Type,..#User)
    If $$$ISERR(tSC) {
        Write $System.Status.GetErrorText(tSC),!
    } Else {
        Write "Grant OK",!
    }
    Quit tSC
}

}
