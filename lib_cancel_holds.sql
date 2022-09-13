WBVardef today=@"select to_char(current_date,'mmddyyyy')";
WBExport -type=text
         -file='C:/Shoutbomb/FTP/lib_cancel_holds/lib_cancel_holds$[today].txt'
         -delimiter='|'
		 -quotechar='"'
		 -quoteCharEscaping=escape
         -lineEnding=crlf
         -encoding=utf8;
		 
		 
SELECT
	(SPLIT_PART(brp.best_title,':',1)) ||' by '|| REPLACE(SPLIT_PART(SPLIT_PART(brp.best_author,' (',1),', ',2),'.','')||' '||SPLIT_PART(brp.best_author,', ',1) as title,
	(SELECT barcode from sierra_view.patron_view as pv where pv.id = p.id LIMIT 1)  as patron_barcode

FROM  sierra_view.bib_view b
	JOIN sierra_view.hold h ON h.record_id = b.id
	left outer join
		sierra_view.patron_record as p ON p.record_id = h.patron_record_id
	left outer join 
		sierra_view.patron_record_fullname n ON n.patron_record_id = p.id
	left outer join 
		sierra_view.item_record i ON i.id = h.record_id
	left outer join  
		sierra_view.item_record_property irp ON irp.item_record_id = i.record_id
	left outer join 
		sierra_view.bib_record_item_record_link bil ON bil.item_record_id = i.id
	left outer join 
	sierra_view.item_record ir ON ir.record_id = irp.item_record_id
	left outer join 
		sierra_view.patron_view pv ON pv.id = p.id
	left outer join 
		sierra_view.patron_record_phone t ON t.patron_record_id = p.id
	left outer join 
		sierra_view.itype_property_myuser ip ON ip.code = ir.itype_code_num
	left join 
	sierra_view.bib_record_property brp ON b.id = brp.bib_record_id

WHERE b.bcode3 IN ('m','h','v') and p.notification_medium_code IN ('t','p')
GROUP BY 1,2
ORDER BY 1 desc