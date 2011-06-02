
-- verifica che i files uguali abbiano md5 uguale
select g1.name from greece2009_md5 g1, GR2009_md5 g2 where g1.name=g2.name and g1.md5 <> g2.md5;

select g1.name from greece2009_md5 g2, GR2009_md5 g1 where g1.name=g2.name and g1.md5 <> g2.md5;

-- verifica se le dir hanno files differenti, in più o in meno
Select * from greece2009_md5 g1 left join GR2009_md5 g2 on g1.name=g2.name and g1.md5=g2.md5 where g2.rowid is null;

Select * from GR2009_md5 g1 left join greece2009_md5 g2 on g1.name=g2.name and g1.md5=g2.md5 where g2.rowid is null;

-- scrive script per fare hard link dei files doppi
.output cleanup.sh
select '/bin/rm "'||g1.dir||g1.name||'"; ln "'||g2.dir||g2.name||'" "'||g1.dir||g1.name||'"' from GR2009_md5 g1 join greece2009_md5 g2 on g1.name=g2.name and g1.md5=g2.md5;
