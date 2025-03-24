//+------------------------------------------------------------------+
//|                                           HollowCandlesticks.mq5 |
//|                                  Copyright © 2025, EarnForex.com |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2025, EarnForex.com"
#property link      "https://www.earnforex.com/metatrader-indicators/Hollow-Candlesticks/"
#property version   "1.00"

#property description "Displays hollow candlesticks chart."
#property description "For best experience, set MT5 chart colors to None."

#property indicator_chart_window
#property indicator_buffers 24
#property indicator_plots   6

#property indicator_type1  DRAW_CANDLES
#property indicator_color1 clrGreen, clrNONE
#property indicator_label1 "Hollow Green: C > O, C > C_prev"

#property indicator_type2  DRAW_CANDLES
#property indicator_color2 clrRed, clrNONE
#property indicator_label2 "Hollow Red: C > O, C < C_prev"

#property indicator_type3  DRAW_CANDLES
#property indicator_color3 clrGray, clrNONE
#property indicator_label3 "Hollow Gray: C > O, C = C_prev"

#property indicator_type4  DRAW_CANDLES
#property indicator_color4 clrGreen
#property indicator_label4 "Solid Green: C < O, C > C_prev"

#property indicator_type5  DRAW_CANDLES
#property indicator_color5 clrRed
#property indicator_label5 "Solid Red: C < O, C < C_prev"

#property indicator_type6  DRAW_CANDLES
#property indicator_color6 clrGray
#property indicator_label6 "Solid Gray: C < O, C = C_prev"

// Indicator buffers
double HollowGreen1[];
double HollowGreen2[];
double HollowGreen3[];
double HollowGreen4[];
double HollowRed1[];
double HollowRed2[];
double HollowRed3[];
double HollowRed4[];
double HollowGray1[];
double HollowGray2[];
double HollowGray3[];
double HollowGray4[];
double SolidGreen1[];
double SolidGreen2[];
double SolidGreen3[];
double SolidGreen4[];
double SolidRed1[];
double SolidRed2[];
double SolidRed3[];
double SolidRed4[];
double SolidGray1[];
double SolidGray2[];
double SolidGray3[];
double SolidGray4[];

color ChartBackgroundColor;

void OnInit()
{
    IndicatorSetString(INDICATOR_SHORTNAME, "Hollow Candlesticks");

    SetIndexBuffer(0, HollowGreen1, INDICATOR_DATA);
    SetIndexBuffer(1, HollowGreen2, INDICATOR_DATA);
    SetIndexBuffer(2, HollowGreen3, INDICATOR_DATA);
    SetIndexBuffer(3, HollowGreen4, INDICATOR_DATA);

    SetIndexBuffer(4, HollowRed1, INDICATOR_DATA);
    SetIndexBuffer(5, HollowRed2, INDICATOR_DATA);
    SetIndexBuffer(6, HollowRed3, INDICATOR_DATA);
    SetIndexBuffer(7, HollowRed4, INDICATOR_DATA);

    SetIndexBuffer(8, HollowGray1, INDICATOR_DATA);
    SetIndexBuffer(9, HollowGray2, INDICATOR_DATA);
    SetIndexBuffer(10, HollowGray3, INDICATOR_DATA);
    SetIndexBuffer(11, HollowGray4, INDICATOR_DATA);

    SetIndexBuffer(12, SolidGreen1, INDICATOR_DATA);
    SetIndexBuffer(13, SolidGreen2, INDICATOR_DATA);
    SetIndexBuffer(14, SolidGreen3, INDICATOR_DATA);
    SetIndexBuffer(15, SolidGreen4, INDICATOR_DATA);

    SetIndexBuffer(16, SolidRed1, INDICATOR_DATA);
    SetIndexBuffer(17, SolidRed2, INDICATOR_DATA);
    SetIndexBuffer(18, SolidRed3, INDICATOR_DATA);
    SetIndexBuffer(19, SolidRed4, INDICATOR_DATA);

    SetIndexBuffer(20, SolidGray1, INDICATOR_DATA);
    SetIndexBuffer(21, SolidGray2, INDICATOR_DATA);
    SetIndexBuffer(22, SolidGray3, INDICATOR_DATA);
    SetIndexBuffer(23, SolidGray4, INDICATOR_DATA);

    // Read background color to use it instead of clrNone. Otherwise, it won't work.
    ChartBackgroundColor = (color)ChartGetInteger(0, CHART_COLOR_BACKGROUND);
    PlotIndexSetInteger(0, PLOT_LINE_COLOR, 1, ChartBackgroundColor);
    PlotIndexSetInteger(1, PLOT_LINE_COLOR, 1, ChartBackgroundColor);
    PlotIndexSetInteger(2, PLOT_LINE_COLOR, 1, ChartBackgroundColor);

    PlotIndexSetDouble(0, PLOT_EMPTY_VALUE, EMPTY_VALUE);
    PlotIndexSetDouble(1, PLOT_EMPTY_VALUE, EMPTY_VALUE);
    PlotIndexSetDouble(2, PLOT_EMPTY_VALUE, EMPTY_VALUE);
    PlotIndexSetDouble(3, PLOT_EMPTY_VALUE, EMPTY_VALUE);
    PlotIndexSetDouble(4, PLOT_EMPTY_VALUE, EMPTY_VALUE);
    PlotIndexSetDouble(5, PLOT_EMPTY_VALUE, EMPTY_VALUE);
}

int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &Open[],
                const double &High[],
                const double &Low[],
                const double &Close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
{
    int limit = 0;
    if (prev_calculated > 0) limit = prev_calculated - 1;

    // The main loop of calculations.
    for (int i = limit; i < rates_total; i++)
    {
        // Set all candles to EMPTY_VALUE to turn them off.
        // This might be required when the current candle changes its type.
        HollowGreen1[i] = EMPTY_VALUE;
        HollowGreen2[i] = EMPTY_VALUE;
        HollowGreen3[i] = EMPTY_VALUE;
        HollowGreen4[i] = EMPTY_VALUE;
        HollowRed1[i] = EMPTY_VALUE;
        HollowRed2[i] = EMPTY_VALUE;
        HollowRed3[i] = EMPTY_VALUE;
        HollowRed4[i] = EMPTY_VALUE;
        HollowGray1[i] = EMPTY_VALUE;
        HollowGray2[i] = EMPTY_VALUE;
        HollowGray3[i] = EMPTY_VALUE;
        HollowGray4[i] = EMPTY_VALUE;
        SolidGreen1[i] = EMPTY_VALUE;
        SolidGreen2[i] = EMPTY_VALUE;
        SolidGreen3[i] = EMPTY_VALUE;
        SolidGreen4[i] = EMPTY_VALUE;
        SolidRed1[i] = EMPTY_VALUE;
        SolidRed2[i] = EMPTY_VALUE;
        SolidRed3[i] = EMPTY_VALUE;
        SolidRed4[i] = EMPTY_VALUE;
        SolidGray1[i] = EMPTY_VALUE;
        SolidGray2[i] = EMPTY_VALUE;
        SolidGray3[i] = EMPTY_VALUE;
        SolidGray4[i] = EMPTY_VALUE;
        if ((i == 0) || ((i > 0) && (Close[i] > Close[i - 1]))) // Green
        {
            if (Close[i] >= Open[i]) // Hollow
            {
                HollowGreen1[i] = Open[i];
                HollowGreen2[i] = High[i];
                HollowGreen3[i] = Low[i];
                HollowGreen4[i] = Close[i];
            }
            else // Solid
            {
                SolidGreen1[i] = Open[i];
                SolidGreen2[i] = High[i];
                SolidGreen3[i] = Low[i];
                SolidGreen4[i] = Close[i];
            }
        }
        else if (Close[i] < Close[i - 1]) // Red
        {
            if (Close[i] >= Open[i]) // Hollow
            {
                HollowRed1[i] = Open[i];
                HollowRed2[i] = High[i];
                HollowRed3[i] = Low[i];
                HollowRed4[i] = Close[i];
            }
            else // Solid
            {
                SolidRed1[i] = Open[i];
                SolidRed2[i] = High[i];
                SolidRed3[i] = Low[i];
                SolidRed4[i] = Close[i];
            }
        }
        else // Gray
        {
            if (Close[i] >= Open[i]) // Hollow
            {
                HollowGray1[i] = Open[i];
                HollowGray2[i] = High[i];
                HollowGray3[i] = Low[i];
                HollowGray4[i] = Close[i];
            }
            else // Solid
            {
                SolidGray1[i] = Open[i];
                SolidGray2[i] = High[i];
                SolidGray3[i] = Low[i];
                SolidGray4[i] = Close[i];
            }
        }
    }

    return rates_total;
}

// Chart event handle to detect chart background color change.
void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
{
    if (id == CHARTEVENT_CHART_CHANGE)
    {
        if (ChartBackgroundColor != (color)ChartGetInteger(0, CHART_COLOR_BACKGROUND))
        {
            // Update hollow candles' body color to the chart's new background color.
            ChartBackgroundColor = (color)ChartGetInteger(0, CHART_COLOR_BACKGROUND);
            PlotIndexSetInteger(0, PLOT_LINE_COLOR, 1, ChartBackgroundColor);
            PlotIndexSetInteger(1, PLOT_LINE_COLOR, 1, ChartBackgroundColor);
            PlotIndexSetInteger(2, PLOT_LINE_COLOR, 1, ChartBackgroundColor);
            ChartRedraw();
        }
    }
}
//+------------------------------------------------------------------+