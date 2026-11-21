**راهنمای فارسی اندیکاتور Volume Profile Fixed Range در متاتریدر ۵**



این راهنما برای اندیکاتور Volume\_Profile\_Fixed\_Range.ex5 تهیه شده است تا بتوانید آن را نصب کنید، محدوده موردنظر خود را روی نمودار بررسی کنید و از اطلاعات حجم معاملات برای تحلیل حمایت، مقاومت و نقاط احتمالی برگشت قیمت استفاده کنید.



**اندیکاتور Volume Profile چیست؟**

اندیکاتور Volume Profile حجم معاملات را در سطوح مختلف قیمت نمایش می‌دهد، نه صرفاً در بازه‌های زمانی مانند اندیکاتور حجم معمولی.

برای مثال، فرض کنید قیمت طلا از ۲۶۴۰ دلار به ۲۶۸۰ دلار حرکت کرده است. در این مسیر ممکن است بخش عمده معاملات در محدوده ۲۶۵۵ تا ۲۶۶۲ انجام شده باشد. Volume Profile کمک می‌کند بفهمید فعالیت معاملاتی در کدام قیمت‌ها متمرکز بوده است.



**تفاوت اصلی:**



**حجم معمولی (Volume):** حجم هر کندل را نشان می‌دهد.

**توزیع حجمVolume Profile:**  توزیع حجم را در قیمت‌های مختلف یک محدوده مشخص نشان می‌دهد.

**تحلیل حجمFixed Range:**  تحلیل حجم را به یک محدوده انتخاب‌شده محدود می‌کند، به‌جای آنکه الزاماً تمام نمودار بررسی شود.



**اصطلاحات مهم در Volume Profile**



**بیشترین حجم معاملات POC — Point of Control** نقطه‌ای که بیشترین حجم معاملات در محدوده انتخاب‌شده در آن ثبت شده است. این سطح برای بررسی واکنش احتمالی قیمت اهمیت دارد.



**محدوده ارزشVAH و VAL**

مرز بالایی محدوده ارزش VAH

مرز پایینی محدوده ارزش VAL

این محدوده معمولاً درصد مشخصی از کل حجم معاملات را در بر می‌گیرد؛ مقدار رایج در بسیاری از ابزارها ۷۰٪ است، اما مقدار واقعی این اندیکاتور باید بررسی شود.



**نواحی حجم بالا و پایینHVN و LVN**

ناحیه‌ای با حجم معاملاتی زیاد؛ ممکن است قیمت در آن مکث یا نوسان کند. HVN

ناحیه‌ای با حجم معاملاتی کم؛ قیمت ممکن است با سرعت بیشتری از آن عبور کند. LVN

این رفتارها احتمالی هستند و تضمینی برای واکنش قیمت محسوب نمی‌شوند.



**نحوه نصب در MetaTrader 5**

از لینک گیت‌هاب، فایل Volume\_Profile\_Fixed\_Range.ex5 را دریافت کنید.

متاتریدر ۵ را باز کنید و از منوی File → Open Data Folder وارد پوشه اطلاعات برنامه شوید.

وارد مسیر MQL5 → Indicators شوید.

فایل EX5 را در پوشه Indicators کپی کنید.

در متاتریدر، پنجره Navigator را باز کنید و روی Indicators راست‌کلیک کرده و Refresh را بزنید؛ در صورت نیاز، متاتریدر را مجددا باز کنید.

اندیکاتور را روی نمودار موردنظر، مثلا XAUUSD، بکشید و پنجره تنظیمات آن را بررسی کنید.



**چگونه از اندیکاتور استفاده کنیم؟**

روش کار پیشنهادی برای تحلیل یک حرکت مشخص در بازار:

**مرحله اول: انتخاب محدوده**

یک حرکت مشخص قیمت را انتخاب کنید؛ برای مثال، حرکت از یک کف معتبر تا سقف بعدی. در تحلیل حرکت نزولی نیز می‌توانید محدوده سقف تا کف را بررسی کنید.

**مرحله دوم: بررسی توزیع حجم**

به محل تمرکز میله‌های افقی نگاه کنید. ناحیه‌ای که حجم بیشتری دارد، نشان می‌دهد فعالیت معاملاتی در آن قیمت بیشتر بوده است.

**مرحله سوم: بررسی واکنش قیمت**

هنگام بازگشت قیمت به POC یا مرزهای محدوده ارزش، واکنش کندل‌ها را بررسی کنید. این سطوح به‌تنهایی سیگنال خرید یا فروش قطعی نیستند.

---------------------------------------------------------------------


# User Guide for the Volume Profile Fixed Range Indicator in MetaTrader 5

This guide has been prepared for the `Volume_Profile_Fixed_Range.ex5` indicator to help you install it, analyze your desired price range on the chart, and use trading volume information to identify potential support and resistance levels, as well as possible price reversal points.

## What Is the Volume Profile Indicator?

The Volume Profile indicator displays trading volume at different price levels, rather than simply showing volume over time, as conventional volume indicators do.

For example, suppose the price of gold moves from $2,640 to $2,680. During this move, the majority of trading activity may have taken place within the $2,655–$2,662 price range. Volume Profile helps you identify the price levels where trading activity was concentrated.

## Key Differences

**Regular Volume:** Displays the trading volume of each individual candle.

**Volume Profile:** Displays the distribution of trading volume across different price levels within a specified range.

**Fixed Range Volume Analysis:** Restricts volume analysis to a user-selected price range, rather than necessarily analyzing the entire chart.

## Important Volume Profile Terminology

### Point of Control (POC)

The price level at which the highest trading volume was recorded within the selected range. This level is important when analyzing potential price reactions.

### Value Area (VAH and VAL)

- **VAH (Value Area High):** The upper boundary of the Value Area.
- **VAL (Value Area Low):** The lower boundary of the Value Area.

The Value Area typically contains a specified percentage of the total trading volume. A commonly used setting across many tools is 70%, although the actual setting used by this indicator should be verified.

### High Volume Nodes (HVN) and Low Volume Nodes (LVN)

- **HVN (High Volume Node):** A price area with high trading volume. Price may pause or consolidate in this area.
- **LVN (Low Volume Node):** A price area with low trading volume. Price may move through this area more quickly.

These behaviors are possibilities, not guarantees of how price will react.

## How to Install the Indicator in MetaTrader 5

1. Download the `Volume_Profile_Fixed_Range.ex5` file from the GitHub link.
2. Open MetaTrader 5 and navigate to **File → Open Data Folder**.
3. Open the `MQL5 → Indicators` directory.
4. Copy the EX5 file into the `Indicators` folder.
5. In MetaTrader 5, open the **Navigator** window, right-click on **Indicators**, and select **Refresh**. If necessary, restart MetaTrader 5.
6. Drag the indicator onto your desired chart, such as XAUUSD, and review its settings window.

## How to Use the Indicator

The following is a suggested approach for analyzing a specific market movement:

### Step 1: Select a Price Range

Choose a specific price movement. For example, select a move from a significant swing low to the subsequent swing high. For analyzing a downward move, you can also select the range from a swing high to a swing low.

### Step 2: Analyze Volume Distribution

Examine where the horizontal volume bars are concentrated. Areas with higher volume indicate that more trading activity took place at those price levels.

### Step 3: Analyze Price Reactions

When price returns to the POC or the boundaries of the Value Area, observe how the candlesticks react.

These levels alone do not constitute definitive buy or sell signals.


\--------------------------------------------------------------------------------------------









Copyright 2026 | Siavash Ahi | @Siavash.Trader | +98-937-162-5332

https://rahkarenovin.ir

این نرم افزار توسط مهندس سیاوش آهی طراحی و برنامه نویس شده است

این نرم افزار دارای کپی رایت است، استفاده و کپی بدون اجازه آن پیگرد قانونی دارد

+98-937-162-5332 | Telegram, WhatsApp, Bale

https://RahkareNovin.ir

https://Aparat.com/Siavash.Trader

https://Youtube.com/@Siavash.Trader

https://Instagram.com/Siavash.Trader

