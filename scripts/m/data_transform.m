let // Connect to PostgreSQL database Source = PostgreSQL.Database("localhost", "ADMISSION_DW_NEW", [Query=" SELECT dc.pk_candidat, dc.resultat, dc.orientation, dc.sexe, dc.code_pays, fa.fk_candidat, fa.moyenne_bac, fa.score, fa.date_enregistrement, dp.PkProfil, dp.skills, dp.company_name, doff.pkOffre, doff.Competence, doff.secteur, fe.fkProfil, fe.fkOffre, fe.date_Diplome, fe.position_date FROM public.Dim_candidat dc LEFT JOIN public.fact_Admission fa ON dc.pk_candidat = fa.fk_candidat LEFT JOIN public.fact_employabilite fe ON dc.pk_candidat = fe.fkProfil LEFT JOIN public.Dim_profil dp ON fe.fkProfil = dp.PkProfil LEFT JOIN public.Dim_offre doff ON fe.fkOffre = doff.pkOffre WHERE dc.resultat IN ('ADMIS(E)', 'LISTE ATTENTE', 'REFUSE(E)') "]),
// Clean and transform Dim_candidat data
Cleaned_Candidat = Table.SelectColumns(Source, {"pk_candidat", "resultat", "orientation", "sexe", "code_pays", "moyenne_bac", "score", "date_enregistrement"}),
Filtered_Candidat = Table.SelectRows(Cleaned_Candidat, each [resultat] <> null),

// Clean and transform employability data
Cleaned_Employabilite = Table.SelectColumns(Source, {"fkProfil", "fkOffre", "date_Diplome", "position_date", "skills", "company_name", "Competence", "secteur"}),
Replaced_NA = Table.ReplaceValue(Cleaned_Employabilite, "N\A", null, Replacer.ReplaceText, {"position_date"}),
Formatted_Dates = Table.TransformColumns(Replaced_NA, {
    {"date_Diplome", each if _ is null then null else DateTime.From(_), type datetime},
    {"position_date", each if _ is null then null else DateTime.From(_), type datetime}
}),

// Split skills for Competences_Communes
Split_Skills = Table.AddColumn(Formatted_Dates, "Skills_Split", each Text.Split([skills], ",")),
Expanded_Skills = Table.ExpandListColumn(Split_Skills, "Skills_Split"),
Trimmed_Skills = Table.TransformColumns(Expanded_Skills, {{"Skills_Split", Text.Trim, type text}}),

// Remove unnecessary columns
Final_Table = Table.SelectColumns(Trimmed_Skills, {
    "pk_candidat", "resultat", "orientation", "sexe", "code_pays", "moyenne_bac", "score", 
    "date_enregistrement", "fkProfil", "fkOffre", "date_Diplome", "position_date", 
    "Skills_Split", "company_name", "Competence", "secteur"
}),

// Ensure data types
Typed_Table = Table.TransformColumnTypes(Final_Table, {
    {"moyenne_bac", type number},
    {"score", type number},
    {"date_enregistrement", type datetime}
})