Pre správne fungovanie programu treba:
1. vytvoriť databázu vykonaním sql skriptu "OrgStructSQLQuery.sql" cez Microsoft SQL Server (pre "Restrictions.sql" nie sú spravené API hlásenia chýb)
2. prepísať connection string v "appsettings.json" v "OrgStruct.sln"
3. Ak treba aktualizovať databázu: 
	a) zavolať príkaz "Scaffold-DbContext -Connection Name=OrgStructdb Microsoft.EntityFrameworkCore.SqlServer -OutputDir Models -force" cez Package Manager Console
	b) zakomentovať všetky kolekcie a objekty v modeloch a k nim príslušné referencie v "OrgStructdbContext.cs"

Pri vkladaní do databázy sa nesmú explicitne pridávať primárne kľúče, keďže sa generujú implicitne.