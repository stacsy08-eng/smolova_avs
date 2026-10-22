# создание папок
cd lab0
mkdir -p victor/kitchen/molecular_station
mkdir -p victor/kitchen/hot_station
mkdir -p victor/hall
mkdir -p victor/office
mkdir -p experiments
mkdir -p archive_empty

#создание текст в папке
cat > victor/kitchen/molecular_station/foam_recipe << 'RRR'
Катя готовит свекольную пену для нового блюда
Лёва проверяет температуру перед подачей
Баринов требует сохранить вкус продуктов
Рецепт отправят на вечернюю дегустацию
RRR

cat > victor/kitchen/molecular_station/nitrogen_notes << 'RRR'
Баллон с азотом доставлен утром
Катя проверила защитные перчатки
Сеня держится подальше от оборудования
После опыта рабочее место нужно убрать
RRR

cat > victor/kitchen/hot_station/senya_report << 'RRR'
Сеня подготовил мясо для горячего блюда
Первая партия отправлена в зал
Шеф потребовал переделать соус
К вечеру заказ был выполнен
RRR

cat > victor/kitchen/hot_station/fedya_report << 'RRR'
Федя получил свежую рыбу
Дорадо подготовлена для постоянных гостей
Катя предложила необычную подачу блюда
Баринов одобрил только второй вариант
RRR

cat > victor/kitchen/chef_order << 'RRR'
Баринов проводит дегустацию после обеда
Каждый повар представляет одно новое блюдо
Катя отвечает за молекулярную часть меню
Результаты передать Лёве до вечерней смены
RRR

cat > victor/hall/reservations << 'RRR'
Столик два забронирован для критика
Столик пять подготовить к семнадцати часам
Большой стол оставить для команды ресторана
Вика проверит готовность зала перед открытием
RRR

cat > victor/hall/guest_reviews << 'RRR'
Гости похвалили необычную подачу блюда
Один гость попросил вернуть обычный десерт
Критик отметил точность работы Кати
Новое меню вызвало интерес у посетителей
RRR

cat > victor/office/katya_schedule << 'RRR'
Катя приходит на кухню к десяти часам
До обеда проводится первый опыт
После дегустации нужно встретиться с Бариновым
Вечером Катя помогает Лёве закрыть смену
RRR

cat > experiments/tasting_results << 'RRR'
Свекольная пена получила высокую оценку
Рыбное блюдо нужно подать горячее
Сеня предложил изменить мясной соус
Катя подготовит итоговый рецепт вечером
RRR

cat > opening_message << 'RRR'
Ресторан Victor открывается в полдень
Вика встречает первых гостей
Баринов лично проверяет новое меню
Команда собирается на кухне до открытия
RRR

#устовнока прав
chmod 755 victor
chmod u=rwx,g=rx,o= victor/kitchen
chmod 750 victor/kitchen/molecular_station
chmod u=rw,g=r,o= victor/kitchen/molecular_station/foam_recipe
chmod 640 victor/kitchen/molecular_station/nitrogen_notes
chmod 750 victor/kitchen/hot_station
chmod 644 victor/kitchen/hot_station/senya_report
chmod u=rw,g=r,o=r victor/kitchen/hot_station/fedya_report
chmod 640 victor/kitchen/chef_order
chmod u=rwx,g=rx,o=rx victor/hall
chmod 664 victor/hall/reservations
chmod u=r,g=r,o=r victor/hall/guest_reviews
chmod 750 victor/office
chmod u=rw,g=r,o= victor/office/katya_schedule
chmod u=rwx,g=rx,o= experiments
chmod 660 experiments/tasting_results
chmod 700 archive_empty
chmod u=rw,g=r,o=r opening_message

#копирование, перемещение
cp experiments/tasting_results victor/office
mv tasting_results successful_experiment
cp victor/kitchen/molecular_station experiments
mv molecular_station molecular_backup

#создание ссылок
ln -s victor/kitchen/molecular_station/foam_recipe current_recipe
ln -s victor/kitchen kitchen_entry
ln victor/kitchen/shift_order opening_message

#обьединение дополнение перемещение
cat victor/kitchen/hot_station/senya_report victor/kitchen/hot_station/fedya_report > victor/kitchen/team_report
cat experiments/tasting_results >> victor/kitchen/chef_order
mv victor/hall/reservations victor/office
mv reservations evening_reservations

cd ..
#поиск, фильтрация и обработка данных
ls -lR lab0 | grep '^- ' | sort -k5,5n | tail -n 5 #-lR подробный рекурсивный список
grep -rihE 'катя|баринов' victor experiments | grep -iv 'гост' | sort -r | head -n 6
# r-ищет рекр в кат, i игнор регстр,v-не содержит, Е-альтернатива, r-обратная алфавит строка, h-убрать имена файлов
grep -ril 'катя' victor/kitchen/molecular_station experiments/molecular_backup | wc -l
#l — выводит только один раз, wc -l — подсчитывает количество выведенных строк
(head -qn 1 victor/kitchen/hot_station/*_report; tail -qn 1 victor/kitchen/hot_station/*_report) | grep -iE 'блюд|баринов' | sort
# *_report — файлы закан. на _report., -q — откл служ заголовки
grep -ivE 'Сеня|Федя' victor/kitchen/team_report | grep -i 'блюд' | sort -r | wc -w
#sort -r сортирует в обратном алф порядке, wc -w подсчитывает общее количество слов в получившемся тексте.
ls -lR lab0 | grep '^l' | sort -k9,9r
#grep '^l' — ост симв.ссылок, sort -k9,9r — по 9 столбцу, где ссылки в обратном порядке.
ls -liR lab0 | grep -E '^[0-9]+ -[^ ]+ 2 ' | sort -n -k1,1
#i — добавляет номер inode в начало строки, grep -E '^[0-9]+ -[^ ]+ 2 ' — файлы, у кот 3 поле (число жёстких ссылок) равно 2.

cd lab0
#удалить
rm experiments/tasting_results
rm experiments/current_recipe
rm kitchen_entry
rm opening_message
rm victor/kitchen/shift_order
rm victor/kitchen/molecular_station/nitrogen_notes
rmdir archive_empty
rm -r experiments/molecular_backup