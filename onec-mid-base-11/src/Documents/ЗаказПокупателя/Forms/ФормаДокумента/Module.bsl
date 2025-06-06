
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКоманды.ПриСозданииНаСервере(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
	// {{Алдошин
	
	НоваяКоманда = Команды.Добавить("Команда");
	НоваяКоманда.Действие = "ИзменениеИКонтроль";
	НоваяКоманда.Заголовок = "Пересчетать сумму с учетом скидки";
	
	НоваяКнопка = Элементы.Добавить("ПересчетатьСуммуСУчетомСкидки", Тип("КнопкаФормы"), Элементы.ГруппаШапкаЛево);
	НоваяКнопка.ИмяКоманды = "Команда";
	НоваяКнопка.Вид = ВидКнопкиФормы.ОбычнаяКнопка;
	
	ПолеВвода = Элементы.Найти("СогласованнаяСкидка");
	
	Если Не ПолеВвода = Неопределено Тогда	
		ПолеВвода.УстановитьДействие("ПриИзменении","ИТ_СогласованнаяСкидкаПриИзменении");
	КонецЕсли;
	
	// Алдошин }}
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
    // СтандартныеПодсистемы.ПодключаемыеКоманды
    ПодключаемыеКомандыКлиент.НачатьОбновлениеКоманд(ЭтотОбъект);
    // Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
    // СтандартныеПодсистемы.ПодключаемыеКоманды
    ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
    // Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
    ПодключаемыеКомандыКлиент.ПослеЗаписи(ЭтотОбъект, Объект, ПараметрыЗаписи);
КонецПроцедуры

#КонецОбласти


#Область ДоработкаПрограммы

&НаКлиенте
Процедура ИзменениеИКонтроль()   //Пересчет скидки в таблице товаров и в таблице услуг построчно 
	// {{Алдошин
	Для Каждого ТекущиеДанные Из Объект.Товары Цикл 
		РассчитатьСуммуСтроки(ТекущиеДанные);
	КонецЦикла;
	Для Каждого ТекущиеДанные Из Объект.Услуги Цикл 
		РассчитатьСуммуСтроки(ТекущиеДанные);
	КонецЦикла;
	// Алдошин }}	
КонецПроцедуры

&НаКлиенте
Процедура ПоказатьВопросЗавершение(РезультатВопроса, ДополнительныеПараметры)  Экспорт
	// {{Алдошин
	Если РезультатВопроса = КодВозвратаДиалога.Да Тогда
		ИзменениеИКонтроль();
	КонецЕсли;
	// Алдошин }}
КонецПроцедуры

&НаКлиенте
Процедура ИТ_СогласованнаяСкидкаПриИзменении()
	// {{Алдошин
	ТекДанныеТовары = Элементы.Товары.ТекущиеДанные;
	ТекДанныеУслуги = Элементы.Услуги.ТекущиеДанные;
	Если ТекДанныеТовары <> Неопределено Или ТекДанныеУслуги <> Неопределено  Тогда
		Текст = "Пересчитат Сумму по Скидке? ";
		ОписаниеОповещения = Новый ОписаниеОповещения("ПоказатьВопросЗавершение",ЭтотОбъект);
		ПоказатьВопрос(ОписаниеОповещения,Текст,РежимДиалогаВопрос.ДаНет);
	Конецесли;
	// Алдошин }}
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыТовары

&НаКлиенте
Процедура ТоварыКоличествоПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Товары.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура ТоварыЦенаПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Товары.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура ТоварыПриИзменении(Элемент)
	РассчитатьСуммуДокумента();
КонецПроцедуры

&НаКлиенте
Процедура ТоварыСкидкаПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Товары.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыУслуги

&НаКлиенте
Процедура УслугиКоличествоПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Услуги.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура УслугиЦенаПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Услуги.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура УслугиСкидкаПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Услуги.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура УслугиПриИзменении(Элемент)
	РассчитатьСуммуДокумента();
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура РассчитатьСуммуСтроки(ТекущиеДанные)
	
	// {{Алдошин
	//КоэффициентСкидки = 1 - ТекущиеДанные.Скидка / 100;
	//ТекущиеДанные.Сумма = ТекущиеДанные.Цена * ТекущиеДанные.Количество * КоэффициентСкидки;
	
	СкидкаДокумента = Объект.ИТ_СогласованнаяСкидка;
	СкидкаСтроки = ТекущиеДанные.Скидка;
	ОбщаяСкидка = СкидкаДокумента + СкидкаСтроки;
	
	Если ОбщаяСкидка > 100  Тогда
		Сообщение = Новый СообщениеПользователю;
		Сообщение.Текст = СтрШаблон("Текущие скидки %1  больше 100 процентов",ОбщаяСкидка);
		Сообщение.Поле = "";
		Сообщение.УстановитьДанные(ЭтотОбъект);
		Сообщение.Сообщить();
		ОбщаяСкидка = 100;
	КонецЕсли;
	
	КоэффициентСкидки = 1 - ОбщаяСкидка / 100;
	ТекущиеДанные.Сумма = ТекущиеДанные.Цена * ТекущиеДанные.Количество * КоэффициентСкидки;
	
	РассчитатьСуммуДокумента();
	
	// Алдошин }}
	
КонецПроцедуры

&НаКлиенте
Процедура РассчитатьСуммуДокумента()
	
	Объект.СуммаДокумента = Объект.Товары.Итог("Сумма") + Объект.Услуги.Итог("Сумма");
	
КонецПроцедуры

#Область ПодключаемыеКоманды

// СтандартныеПодсистемы.ПодключаемыеКоманды
&НаКлиенте
Процедура Подключаемый_ВыполнитьКоманду(Команда)
    ПодключаемыеКомандыКлиент.НачатьВыполнениеКоманды(ЭтотОбъект, Команда, Объект);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ПродолжитьВыполнениеКомандыНаСервере(ПараметрыВыполнения, ДополнительныеПараметры) Экспорт
    ВыполнитьКомандуНаСервере(ПараметрыВыполнения);
КонецПроцедуры

&НаСервере
Процедура ВыполнитьКомандуНаСервере(ПараметрыВыполнения)
    ПодключаемыеКоманды.ВыполнитьКоманду(ЭтотОбъект, ПараметрыВыполнения, Объект);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ОбновитьКоманды()
    ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
КонецПроцедуры
// Конец СтандартныеПодсистемы.ПодключаемыеКоманды

#КонецОбласти

#КонецОбласти
