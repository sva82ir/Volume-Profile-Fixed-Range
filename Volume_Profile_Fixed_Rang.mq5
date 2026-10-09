//+------------------------------------------------------------------+
//| Volume Profile Fixed Rang.mq5                                    |
//| Copyright 2026, Siavash Dev                                      |
//| https://www.rahkarenovin.ir                                      |
//+------------------------------------------------------------------+
#property copyright "Copyright 2026 | Siavash Ahi | @Siavash.Trader | +98-937-162-5332"
#property link      "https://rahkarenovin.ir"
#property version   "1.00"
#property strict
#property description "این نرم افزار توسط مهندس سیاوش آهی طراحی و برنامه نویس شده است"
#property description "این نرم افزار دارای کپی رایت است، استفاده و کپی بدون اجازه آن پیگرد قانونی دارد"
#property description "+98-937-162-5332 | Telegram, WhatsApp, Bale"
#property description "RahkareNovin.ir"
#property description "Aparat.com/Siavash.Trader"
#property description "Youtube.com/@Siavash.Trader"
#property description "Instagram.com/Siavash.Trader"


#property indicator_chart_window
#property indicator_buffers 0
#property indicator_plots   0

input int    NumberOfBars       = 150; // Number Of Bars
input int    RowSize            = 24; // Row Size
input double ValueAreaVolumePct = 70.0; // Value Area Volume %
input color  POCColor           = clrRed; // POC Color
input int    POCWidth           = 2; // POC Width
input ENUM_LINE_STYLE POCLineStyle = STYLE_SOLID; // POC Line Style
input color  ValueAreaUpColor   = clrBlue; // Value Area Up Color
input int    VAHLineWidth       = 2; // VAH Line Width
input ENUM_LINE_STYLE VAHLineStyle = STYLE_SOLID; // VAH Line Style
input color  ValueAreaDownColor = clrOrange; // Value Area Down Color
input int    VALLineWidth       = 2; // VAL Line Width
input ENUM_LINE_STYLE VALLineStyle = STYLE_SOLID; // VAL Line Style
input color  UpVolumeColor      = clrBlue; // Up Volume Color
input color  DownVolumeColor    = clrOrange; // Down Volume Color
input bool   ShowPOCLabel       = true; // Show POC Label

string g_object_prefix;

color BlendWithBackground(const color foreground, const color background, const int transparency)
{
   int opacity = 100 - transparency;
   int red = (((int)foreground & 0xFF) * opacity + ((int)background & 0xFF) * transparency) / 100;
   int green = ((((int)foreground >> 8) & 0xFF) * opacity + (((int)background >> 8) & 0xFF) * transparency) / 100;
   int blue = ((((int)foreground >> 16) & 0xFF) * opacity + (((int)background >> 16) & 0xFF) * transparency) / 100;
   return (color)(red | (green << 8) | (blue << 16));
}

double GetIntersectingVolume(const double level_low,
                             const double level_high,
                             const double price_low,
                             const double price_high,
                             const double height,
                             const double volume_value)
{
   if(height <= 0.0)
      return 0.0;

   double overlap = MathMax(MathMin(MathMax(level_low, level_high), MathMax(price_low, price_high)) -
                            MathMax(MathMin(level_low, level_high), MathMin(price_low, price_high)), 0.0);
   return overlap * volume_value / height;
}

datetime TimeAtLogicalIndex(const int logical_index, const int rates_total, const datetime &time[])
{
   int shift = rates_total - 1 - logical_index;
   if(shift >= 0)
      return time[shift];

   int seconds = PeriodSeconds(_Period);
   if(seconds <= 0)
      seconds = 60;
   return time[0] + (datetime)(-shift * seconds);
}

void SetRectangle(const string name,
                  const datetime time1,
                  const double price1,
                  const datetime time2,
                  const double price2,
                  const color fill_color)
{
   if(ObjectFind(0, name) < 0)
   {
      if(!ObjectCreate(0, name, OBJ_RECTANGLE, 0, time1, price1, time2, price2))
         return;
      ObjectSetInteger(0, name, OBJPROP_FILL, true);
      ObjectSetInteger(0, name, OBJPROP_BACK, false);
      ObjectSetInteger(0, name, OBJPROP_SELECTABLE, false);
      ObjectSetInteger(0, name, OBJPROP_HIDDEN, true);
      ObjectSetInteger(0, name, OBJPROP_STYLE, STYLE_SOLID);
      ObjectSetInteger(0, name, OBJPROP_WIDTH, 1);
   }
   else
   {
      ObjectMove(0, name, 0, time1, price1);
      ObjectMove(0, name, 1, time2, price2);
   }
   ObjectSetInteger(0, name, OBJPROP_COLOR, fill_color);
}

void SetPOCLine(const datetime time1, const datetime time2, const double price)
{
   string name = g_object_prefix + "POC_LINE";
   if(ObjectFind(0, name) < 0)
   {
      if(!ObjectCreate(0, name, OBJ_TREND, 0, time1, price, time2, price))
         return;
      ObjectSetInteger(0, name, OBJPROP_RAY_RIGHT, true);
      ObjectSetInteger(0, name, OBJPROP_SELECTABLE, false);
      ObjectSetInteger(0, name, OBJPROP_HIDDEN, true);
   }
   else
   {
      ObjectMove(0, name, 0, time1, price);
      ObjectMove(0, name, 1, time2, price);
   }
   ObjectSetInteger(0, name, OBJPROP_COLOR, POCColor);
   ObjectSetInteger(0, name, OBJPROP_WIDTH, POCWidth);
   ObjectSetInteger(0, name, OBJPROP_STYLE, POCLineStyle);
}

void SetValueAreaLine(const string suffix,
                      const datetime time1,
                      const datetime time2,
                      const double price,
                      const color line_color,
                      const int line_width,
                      const ENUM_LINE_STYLE line_style)
{
   string name = g_object_prefix + suffix;
   if(ObjectFind(0, name) < 0)
   {
      if(!ObjectCreate(0, name, OBJ_TREND, 0, time1, price, time2, price))
         return;
      ObjectSetInteger(0, name, OBJPROP_RAY_RIGHT, true);
      ObjectSetInteger(0, name, OBJPROP_SELECTABLE, false);
      ObjectSetInteger(0, name, OBJPROP_HIDDEN, true);
   }
   else
   {
      ObjectMove(0, name, 0, time1, price);
      ObjectMove(0, name, 1, time2, price);
   }
   ObjectSetInteger(0, name, OBJPROP_COLOR, line_color);
   ObjectSetInteger(0, name, OBJPROP_WIDTH, line_width);
   ObjectSetInteger(0, name, OBJPROP_STYLE, line_style);
}

void SetPOCLabel(const datetime label_time, const double price, const bool label_above)
{
   string name = g_object_prefix + "POC_LABEL";
   if(ObjectFind(0, name) < 0)
   {
      if(!ObjectCreate(0, name, OBJ_TEXT, 0, label_time, price))
         return;
      ObjectSetInteger(0, name, OBJPROP_SELECTABLE, false);
      ObjectSetInteger(0, name, OBJPROP_HIDDEN, true);
      ObjectSetInteger(0, name, OBJPROP_FONTSIZE, 8);
      ObjectSetString(0, name, OBJPROP_FONT, "Arial");
      ObjectSetInteger(0, name, OBJPROP_COLOR, clrWhite);
   }
   else
      ObjectMove(0, name, 0, label_time, price);

   double tick_size = SymbolInfoDouble(_Symbol, SYMBOL_TRADE_TICK_SIZE);
   if(tick_size <= 0.0)
      tick_size = _Point;
   double rounded_price = MathRound(price / tick_size) * tick_size;
   ObjectSetString(0, name, OBJPROP_TEXT, "POC: " + DoubleToString(rounded_price, _Digits));
   ObjectSetInteger(0, name, OBJPROP_ANCHOR, label_above ? ANCHOR_LEFT_LOWER : ANCHOR_LEFT_UPPER);
}

int OnInit()
{
   if(NumberOfBars < 1 || NumberOfBars > 500 || RowSize < 5 || RowSize > 100 ||
      ValueAreaVolumePct < 0.0 || ValueAreaVolumePct > 100.0 || POCWidth < 1 || POCWidth > 5 ||
      VAHLineWidth < 1 || VAHLineWidth > 5 || VALLineWidth < 1 || VALLineWidth > 5)
   {
      Print("Input values are outside the supported Pine Script ranges.");
      return INIT_PARAMETERS_INCORRECT;
   }

   g_object_prefix = "VPFR_" + IntegerToString(ChartID()) + "_" + IntegerToString((int)GetTickCount()) + "_";
   IndicatorSetString(INDICATOR_SHORTNAME, "Volume Profile / Fixed Range");
   return INIT_SUCCEEDED;
}

void OnDeinit(const int reason)
{
   ObjectsDeleteAll(0, g_object_prefix);
}

int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
{
   ArraySetAsSeries(time, true);
   ArraySetAsSeries(open, true);
   ArraySetAsSeries(high, true);
   ArraySetAsSeries(low, true);
   ArraySetAsSeries(close, true);
   ArraySetAsSeries(tick_volume, true);
   ArraySetAsSeries(volume, true);

   if(rates_total < NumberOfBars)
   {
      ObjectsDeleteAll(0, g_object_prefix);
      return rates_total;
   }

   double range_top = high[0];
   double range_bottom = low[0];
   bool has_real_volume = false;
   for(int bar = 0; bar < NumberOfBars; bar++)
   {
      range_top = MathMax(range_top, high[bar]);
      range_bottom = MathMin(range_bottom, low[bar]);
      if(volume[bar] > 0)
         has_real_volume = true;
   }

   double distance = (range_top - range_bottom) / 500.0;
   double step = (range_top - range_bottom) / RowSize;
   double levels[];
   double row_volumes[];
   double total_volumes[];
   ArrayResize(levels, RowSize + 1);
   ArrayResize(row_volumes, RowSize * 2);
   ArrayResize(total_volumes, RowSize);
   ArrayInitialize(row_volumes, 0.0);
   ArrayInitialize(total_volumes, 0.0);

   for(int row = 0; row <= RowSize; row++)
      levels[row] = range_bottom + step * row;

   for(int bar = 0; bar < NumberOfBars; bar++)
   {
      double body_top = MathMax(close[bar], open[bar]);
      double body_bottom = MathMin(close[bar], open[bar]);
      bool is_green = close[bar] >= open[bar];
      double top_wick = high[bar] - body_top;
      double bottom_wick = body_bottom - low[bar];
      double body = body_top - body_bottom;
      double denominator = 2.0 * top_wick + 2.0 * bottom_wick + body;
      double bar_volume = (double)(has_real_volume ? volume[bar] : tick_volume[bar]);
      double body_volume = denominator > 0.0 ? body * bar_volume / denominator : 0.0;
      double top_wick_volume = denominator > 0.0 ? 2.0 * top_wick * bar_volume / denominator : 0.0;
      double bottom_wick_volume = denominator > 0.0 ? 2.0 * bottom_wick * bar_volume / denominator : 0.0;

      for(int row = 0; row < RowSize; row++)
      {
         double level_low = levels[row];
         double level_high = levels[row + 1];
         double up_volume = (is_green ? GetIntersectingVolume(level_low, level_high, body_bottom, body_top, body, body_volume) : 0.0) +
                            GetIntersectingVolume(level_low, level_high, body_top, high[bar], top_wick, top_wick_volume) / 2.0 +
                            GetIntersectingVolume(level_low, level_high, body_bottom, low[bar], bottom_wick, bottom_wick_volume) / 2.0;
         double down_volume = (is_green ? 0.0 : GetIntersectingVolume(level_low, level_high, body_bottom, body_top, body, body_volume)) +
                              GetIntersectingVolume(level_low, level_high, body_top, high[bar], top_wick, top_wick_volume) / 2.0 +
                              GetIntersectingVolume(level_low, level_high, body_bottom, low[bar], bottom_wick, bottom_wick_volume) / 2.0;
         row_volumes[row] += up_volume;
         row_volumes[row + RowSize] += down_volume;
      }
   }

   int poc = 0;
   double maximum_volume = 0.0;
   double sum_volume = 0.0;
   for(int row = 0; row < RowSize; row++)
   {
      total_volumes[row] = row_volumes[row] + row_volumes[row + RowSize];
      sum_volume += total_volumes[row];
      if(total_volumes[row] > maximum_volume)
      {
         maximum_volume = total_volumes[row];
         poc = row;
      }
   }

   double target_value_area = sum_volume * ValueAreaVolumePct / 100.0;
   double value_area_volume = total_volumes[poc];
   int up = poc;
   int down = poc;
   for(int row = 0; row < RowSize; row++)
   {
      if(value_area_volume >= target_value_area)
         break;
      double upper_volume = up < RowSize - 1 ? total_volumes[up + 1] : 0.0;
      double lower_volume = down > 0 ? total_volumes[down - 1] : 0.0;
      if(upper_volume == 0.0 && lower_volume == 0.0)
         break;
      if(upper_volume >= lower_volume)
      {
         value_area_volume += upper_volume;
         up++;
      }
      else
      {
         value_area_volume += lower_volume;
         down--;
      }
   }

   datetime first_time = time[NumberOfBars - 1];
   int first_index = rates_total - NumberOfBars;
   color background = (color)ChartGetInteger(0, CHART_COLOR_BACKGROUND);
   color value_up = BlendWithBackground(ValueAreaUpColor, background, 30);
   color value_down = BlendWithBackground(ValueAreaDownColor, background, 30);
   color regular_up = BlendWithBackground(UpVolumeColor, background, 75);
   color regular_down = BlendWithBackground(DownVolumeColor, background, 75);

   for(int row = 0; row < RowSize; row++)
   {
      int up_width = maximum_volume > 0.0 ? (int)MathRound(row_volumes[row] * NumberOfBars / (3.0 * maximum_volume)) : 0;
      int down_width = maximum_volume > 0.0 ? (int)MathRound(row_volumes[row + RowSize] * NumberOfBars / (3.0 * maximum_volume)) : 0;
      datetime up_end = TimeAtLogicalIndex(first_index + up_width, rates_total, time);
      datetime down_end = TimeAtLogicalIndex(first_index + up_width + down_width, rates_total, time);
      bool in_value_area = row >= down && row <= up;

      SetRectangle(g_object_prefix + "UP_" + IntegerToString(row), first_time,
                   levels[row + 1] - distance, up_end, levels[row] + distance,
                   in_value_area ? value_up : regular_up);
      SetRectangle(g_object_prefix + "DOWN_" + IntegerToString(row), up_end,
                   levels[row + 1] - distance, down_end, levels[row] + distance,
                   in_value_area ? value_down : regular_down);
   }

   double poc_level = (levels[poc] + levels[poc + 1]) / 2.0;
   datetime line_end = TimeAtLogicalIndex(first_index + 1, rates_total, time);
   SetPOCLine(first_time, line_end, poc_level);
   SetValueAreaLine("VAH_LINE", first_time, line_end, levels[up + 1], ValueAreaUpColor, VAHLineWidth, VAHLineStyle);
   SetValueAreaLine("VAL_LINE", first_time, line_end, levels[down], ValueAreaDownColor, VALLineWidth, VALLineStyle);
   string label_name = g_object_prefix + "POC_LABEL";
   if(ShowPOCLabel)
      SetPOCLabel(TimeAtLogicalIndex(rates_total + 14, rates_total, time), poc_level, close[0] >= poc_level);
   else
      ObjectDelete(0, label_name);

   ChartRedraw(0);
   return rates_total;
}