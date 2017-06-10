/*-----------------------------------------------------------------*/
/*                                                                 */
/*  Firebird Package Manager, v0.0.1, for Firebird 3               */
/*                                                                 */
/*  Менеджер пакетов предназначен для управления и автоматической  */
/*  установки и отката SQL пакетов (не путайте с объектами БД)     */
/*                                                                 */
/*  (c) Сергей Ворошилов, 2017 <vorosilov.grk@yandex.ru>           */
/*                                                                 */
/*-----------------------------------------------------------------*/

set term ^;

/*-----------------------------------------------------------------*/
/*                              Роли                               */
/*-----------------------------------------------------------------*/

create role fpm$installer^

/*-----------------------------------------------------------------*/
/*                             Домены                              */
/*-----------------------------------------------------------------*/

create domain fpm$version as varchar(11)
check (value like '%.%.%')^

create domain fpm$script as blob sub_type 1 segment size 80^

/*-----------------------------------------------------------------*/
/*                             Ошибки                              */
/*-----------------------------------------------------------------*/

create exception fpm$cant_insert 'Запрещена вставка записей в таблицу'^
create exception fpm$cant_delete 'Не может быть удалено'^
create exception fpm$version_already_installed 'Эта версия уже установлена'^

/*-----------------------------------------------------------------*/
/*                             Таблицы                             */
/*-----------------------------------------------------------------*/

create table fpm$config (
  autoupgrade boolean default false not null,
  recursive_install boolean default false not null
)^

comment on column fpm$config.autoupgrade is
  'Автоматическая установка после заливки модуля'^
comment on column fpm$config.recursive_install is
  'Рекурсивная установка зависимостей'^
comment on table fpm$config is 'Таблица конфигурации менеджера пакетов'^

grant select, update on fpm$config to installer^



-- create table fpm$packages
-- (
--   package_name varchar(15) not null,
--   package_version fpm$version not null,
--   description varchar(255),
--   install_script fpm$script,
--   uninstall_script fpm$script,
--   dependencies fpm$script,
--   is_install boolean default false not null,
--   last_user varchar(31) not null,
--   last_change timestamp not null,
--
--   constraint pk_fpm$packages primary key (package_name, package_version)
-- );
--
-- comment on column fpm$packages.package_name is 'Имя пакета'^
-- comment on column fpm$packages.package_version is 'Версия пакета'^
-- comment on column fpm$packages.description is 'Краткое описание пакета'^
-- comment on column fpm$packages.install_script is 'Скрипт установки'^
-- comment on column fpm$packages.uninstall_script is 'Скрипт отката'^
-- comment on column fpm$packages.dependencies is 'Зависимости пакета'^
-- comment on column fpm$packages.is_install is 'Флаг установки'^
-- comment on column fpm$packages.last_user is 'Пользователь, изменивший запись'^
-- comment on column fpm$packages.last_change is 'Время последнего изменения'^
-- comment on table fpm$packages is 'Хранилище пакетов'^


/*-----------------------------------------------------------------*/
/*                             Триггеры                            */
/*-----------------------------------------------------------------*/

create trigger fpm$config_bi0 for fpm$config
active before insert position 0
as
begin
  if (exists(select * from fpm$config)) then
  begin
    update fpm$config
    set autoupgrade = new.autoupgrade,
        recursive_install = new.recursive_install;
    exception fpm$cant_insert
      'Запрещена вставка записей в кофигурационную таблицу';
  end
end^

commit^

/*-----------------------------------------------------------------*/
/*                              Данные                             */
/*-----------------------------------------------------------------*/

insert into fpm$config(autoupgrade, recursive_install)
values (false, false)^

commit^

set term ;^
