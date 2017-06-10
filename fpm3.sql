/*-----------------------------------------------------------------*/
/*                                                                 */
/*  Firebird Package Manager, v.0.0.1, for Firebird 3              */
/*                                                                 */
/*  Менеджер пакетов предназначен для управления и автоматической  */
/*  установки и отката SQL пакетов (не путайте с объектами БД)     */
/*                                                                 */
/*  (c) Ворошилов Сергей, 2017 <vorosilov.grk@yandex.ru>           */
/*                                                                 */
/*-----------------------------------------------------------------*/

set term ^;

/*-----------------------------------------------------------------*/
/*                             Домены                              */
/*-----------------------------------------------------------------*/

create domain pm$version as varchar(11) 
check (value like '%.%.%')^

create domain pm$script as blob sub_type 1 segment size 80^

update rdb$fields set rdb$system_flag = 1
where rdb$field_name in ('pm$version', 'pm$script')^

commit^

set term ;^