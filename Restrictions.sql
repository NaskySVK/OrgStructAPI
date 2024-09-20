--1 zamestnanec môže v 1 organizácii pracovať len na 1 pozícii
--nepoužitý kompozitný primárny kľúč kvôli výkonnosti DB
ALTER TABLE EmpPos
ADD CONSTRAINT UQ_EmpPos UNIQUE (emp_id, unit_id);


GO


--mazanie jednotky zmaže aj jednotky jej podriadené
CREATE TRIGGER trg_DeleteOrgUnitChildren
ON OrgUnit
FOR DELETE
AS
BEGIN
    DELETE FROM OrgUnit
    WHERE parent_unit_id IN (SELECT unit_id FROM deleted);
END;

--riaditel jednotky má automaticky pridanú pozíciu ako riaditel tejto jednotky
CREATE TRIGGER trg_AddOrgUnitDirector
ON OrgUnit
AFTER INSERT
AS
BEGIN
    INSERT INTO EmpPos (emp_id, unit_id, pos_name)
    SELECT director_id, unit_id, 'director'
    FROM inserted;
END;

--úroveň podriadenej jednotky je "vyššia" ako nadriadenej (1 - firma, 2 - divízia, 3 - projekt, 4 - oddelenie)
CREATE TRIGGER trg_CheckOrgChildUnitLevel
ON OrgUnit
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN OrgUnit p ON i.parent_unit_id = p.unit_id
        WHERE i.level <= p.level
    )
    BEGIN
        RAISERROR('The child OrgUnit level must be greater than the parent OrgUnit level.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;