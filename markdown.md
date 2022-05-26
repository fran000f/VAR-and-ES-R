---
title: "Ilościowe miary ryzyka rynkowego"
output: 
  html_document: 
    keep_md: yes
---





# Opis danych

Zebrane dane dzienne z okresu 01.01.2006 - 31.12.2021 dotyczą wartości trzech indeksów giełdowych - BUX, BUMIX oraz CETOP i pochodzą z archiwów Giełdy Papierów Wartościowych w Budapeszcie (BSE).

<div>

**BUX** składa się z 12 do 25 największych spółek notowanych na BSE. Jest odpowiednikiem indeksów takich jak Dow Jones Industrial Average czy DAX. Indeks BUX jest składnikiem opcji i kontraktów futures notowanych na BSE pod symbolem BUX. Wartość indeksu obliczana jest w czasie rzeczywistym na podstawie kursów rynkowych akcji w koszyku. Oprócz kursów akcji uwzględnia on również prawa poboru i dywidendy. Dzienne zmiany wartości indeksu przedstawia poniższy wykres:

![](markdown_files/figure-html/unnamed-chunk-1-1.png)<!-- -->

Rozkład gęstości logarytmicznych stóp zwrotu wygląda następująco:

![](markdown_files/figure-html/unnamed-chunk-2-1.png)<!-- -->

Można zatem stwierdzić, że rozkład ten w przybliżeniu przypomina rozkład normalny.

Przeciętna wartość indeksu odnotowana w badanym okresie wyniosła 2.6886906\times 10^{4} z odchyleniem standardowym 9896.0872054. Współczynnik zmienności wynosi 0.3680634 i świadczy o umiarkowanej zmienności odnotowanych wartości indeksu. Zakres odnotowanych wartości to (9461.29 - 5.5925578\times 10^{4}). Pierwszy kwantyl wynosi 1.902226\times 10^{4}, mediana - 2.3068679\times 10^{4} , a trzeci kwartyl - 3.5391467\times 10^{4}.

</div>

------------------------------------------------------------------------

<div>

**BUMIX** składa się z 12 do 25 średniej wielkości spółek notowanych na BSE. Spółki uwzględniane w indeksie BUMIX nie mogą przekroczyć kwoty kapitalizacji 125 miliardów forintów. Podobnie jak BUX, BUMIX jest indeksem dochodowym. W badanym okresie wartość indeksu prezentowała się następująco:

![](markdown_files/figure-html/unnamed-chunk-3-1.png)<!-- -->

Rozkład gęstości logarytmicznych stóp zwrotu wygląda następująco:

![](markdown_files/figure-html/unnamed-chunk-4-1.png)<!-- -->

Można zatem stwierdzić, że rozkład ten w przybliżeniu przypomina rozkład normalny.

Przeciętna wartość indeksu odnotowana w badanym okresie wyniosła 2382.4087858 z odchyleniem standardowym 1036.7353801. Współczynnik zmienności wynosi 0.4351627 i świadczy o umiarkowanie wysokiej zmienności odnotowanych wartości indeksu. Zakres odnotowanych wartości to (958.82 - 4532.787473). Pierwszy kwantyl wynosi 1536.40667, mediana - 2011.485 , a trzeci kwartyl - 3397.425.

</div>

------------------------------------------------------------------------

<div>

**CETOP** (Central European Blue Chip Index) odzwierciedla status spółek o największej wartości rynkowej i obrotach w regionie Europy Środkowej. W jego skład wchodzą notowania m.in. KGHM, PZU czy PKN Orlen. W badanym okresie odnotowano następujące wartości indeksu:

![](markdown_files/figure-html/unnamed-chunk-5-1.png)<!-- -->

Rozkład gęstości logarytmicznych stóp zwrotu wygląda następująco:

![](markdown_files/figure-html/unnamed-chunk-6-1.png)<!-- -->

Można zatem stwierdzić, że rozkład ten w przybliżeniu przypomina rozkład normalny, aczkolwiek wydaje się odbiegać od niego nieco silniej niż dwa powyższe.

Przeciętna wartość indeksu odnotowana w badanym okresie wyniosła 2107.5652119 z odchyleniem standardowym 441.841063. Współczynnik zmienności wynosi 0.2096453 i świadczy o przeciętnej zmienności odnotowanych wartości indeksu. Zakres odnotowanych wartości to (1018.22 - 3517.5). Pierwszy kwantyl wynosi 1808.5974275, mediana - 2032.1206125 , a trzeci kwartyl - 2317.5313955.

</div>

## ---------------------------------------------------------------------------------------------

------------------------------------------------------------------------

# Wyznaczanie 95% i 99% VaR i ES

W celu wyznaczenia 95% i 99% VaR i ES dla badanych indeksów użyto metod: historycznej, EWMA oraz symulacji Monte Carlo.



## Metoda historyczna

-   indeks BUX

    ![](markdown_files/figure-html/unnamed-chunk-8-1.png)<!-- -->

-   indeks BUMIX

    ![](markdown_files/figure-html/unnamed-chunk-9-1.png)<!-- -->

-   indeks CETOP

    ![](markdown_files/figure-html/unnamed-chunk-10-1.png)<!-- -->

## Metoda zmiennej zmienności w czasie (EWMA)

-   indeks BUX

    ![](markdown_files/figure-html/unnamed-chunk-11-1.png)<!-- -->

-   indeks BUMIX

    ![](markdown_files/figure-html/unnamed-chunk-12-1.png)<!-- -->

-   indeks CETOP

    ![](markdown_files/figure-html/unnamed-chunk-13-1.png)<!-- -->

## Metoda symulacji Monte Carlo (liczba symulacji: 1000)

-   indeks BUX

    ![](markdown_files/figure-html/unnamed-chunk-14-1.png)<!-- -->

-   indeks BUMIX

    ![](markdown_files/figure-html/unnamed-chunk-15-1.png)<!-- -->

-   indeks CETOP

    ![](markdown_files/figure-html/unnamed-chunk-16-1.png)<!-- -->

## ---------------------------------------------------------------------------------------------

------------------------------------------------------------------------

# Testy wsteczne

Dla obliczonych wartości 99% VaR użyto testów: Kupca oraz Christoffersona. Wyniki testów przedstawia poniższa tabela:

| indeks | metoda      | test Kupca          | p                   | test Christoffersona | p                   |
|--------|-------------|---------------------|---------------------|----------------------|---------------------|
| BUX    | historyczna | 1.4979555   | 0.2209862   | 24.8690098    | 6.1360951\times 10^{-7}   |
| BUX    | EWMA        | 1.4979555   | 0.2209862   | 24.8690098    | 6.1360951\times 10^{-7}   |
| BUX    | Monte Carlo | 9.901949   | 0.001651   | 17.8576198    | 2.380641\times 10^{-5}   |
| BUMIX  | historyczna | 9.0265093 | 0.0026609 | 33.7281038  | 6.3378413\times 10^{-9} |
| BUMIX  | EWMA        | 9.0265093 | 0.0026609 | 33.7281038  | 6.3378413\times 10^{-9} |
| BUMIX  | Monte Carlo | 28.3166485 | 1.0300626\times 10^{-7} | 53.6952842  | 2.3414604\times 10^{-13} |
| CETOP  | historyczna | 3.88014 | 0.0488605 | 1.8315221  | 0.1759479 |
| CETOP  | EWMA        | 3.1894035 | 0.0741171 | 5.9439192  | 0.0147681 |
| CETOP  | Monte Carlo | 5.1966968 | 0.0226299 | 7.545968  | 0.0060145 |

Na przyjętym poziomie istotności najbardziej wiarygodne wyniki wydaje się dawać metoda symulacji Monte Carlo. Test Kupca odrzuca wiarygodność estymacji metodami historycznymi i EWMA dla indeksu BUX oraz wyniki wszystkich sprawdzonych metod dla indeksu CETOP; p dla metody Monte Carlo jest w tym przypadku najmniejsze. Potwierdza on z kolei wiarygodność wszystkich estymacji dla indeksu BUMIX. Test Christoffersona wskazuje na niezależność przekroczeń VaR w czasie dla wszystkich estymacji indeksów BUMIX oraz BUX. Otrzymanie wiarygodnych wyników dla wszystkich indeksów wymagałoby zmiany poziomu istotności, bądź korekty metody estymacji ze względu na kształt rozkładu logarytmicznych stóp zwrotu.

Na podstawie metody symulacji Monte Carlo można stwierdzić, że w okresie od 01.01.2006 do 31.12.2021 przeciętna wartość narażona na ryzyko dla 99% poziomu pewności dla indeksu BUX wynosiła 3.227879, a przeciętna strata po przekroczeniu tej wartości wynosiła -0.0572927. Dla indeksu BUMIX było to odpowiednio 2.5734515 i -0.0454222. Dla indeksu CETOP było to odpowiednio 3.2411452 i -0.0335424.
