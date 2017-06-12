/*-----------------------------------------------------------------*/
/*                                                                 */
/*  Firebird Package Manager Uninstaller, v0.0.1, for Firebird 3   */
/*                                                                 */
/*  (c) Сергей Ворошилов, 2017 <vorosilov.grk@yandex.ru>           */
/*                                                                 */
/*-----------------------------------------------------------------*/

set term ^;

/*-----------------------------------------------------------------*/
/*                             Триггеры                            */
/*-----------------------------------------------------------------*/

-- drop trigger fpm$packages_ad100^
drop trigger fpm$packages_bd100^
-- drop trigger fpm$packages_au100^
drop trigger fpm$packages_bu100^
-- drop trigger fpm$packages_ai100^
drop trigger fpm$packages_bi100^
drop trigger fpm$config_bi100^

/*-----------------------------------------------------------------*/
/*                             Таблицы                             */
/*-----------------------------------------------------------------*/

drop table fpm$history^
drop table fpm$packages^
drop table fpm$config^

/*-----------------------------------------------------------------*/
/*                             Ошибки                              */
/*-----------------------------------------------------------------*/

drop exception fpm$cant_insert^
drop exception fpm$cant_delete^
drop exception fpm$version_already_installed^

/*-----------------------------------------------------------------*/
/*                             Домены                              */
/*-----------------------------------------------------------------*/

drop domain fpm$action^
drop domain fpm$version^
drop domain fpm$script^

/*-----------------------------------------------------------------*/
/*                              Роли                               */
/*-----------------------------------------------------------------*/

drop role fpm$installer^

commit^

set term ;^
