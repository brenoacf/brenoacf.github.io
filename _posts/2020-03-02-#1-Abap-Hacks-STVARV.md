---
layout: post
title:  #1 AbapHacks - STVARV
date:   2020-03-02 11:38:00
categories: ['SAP', 'ABAP']
---

Este é o primeiro post falando sobre o repositório [**abap-hacks**](https://github.com/brenoacf/abap-hacks/) aqui do GitHub. Neste repositório espero colocar alguns códigos úteis que possam ser utilizados no dia a dia para agilizar o processo de desenvolvimento em ABAP.

O primeiro código que disponibilizei no repositório é uma [classe para acesso à TVARVC](https://github.com/brenoacf/abap-hacks/tree/master/stvarvc-extract), que é responsável por armazenar variáveis globais do ambiente, de uso geral. Muitos projetos costumam utilizar esta tabela para o armazenamento de configurações utilizados em programas Z ou customizações no geral.

A classe possue métodos estáticos que agilizam o trabalho de acesso à TVARVC para buscar os valores das constantes diretamente para dentro de RANGES. É possível acessar tanto parâmetros simples como parâmetros de vários itens. Também é possível buscar parâmetros com a utilização do caracter %.

Para incorporá-la ao SAP você pode utilizar o arquivo NUGG, carregando-o para dentro do ZSAPLINK e importando como classe global no SAP. Você também pode optar por importá-la de uma classe local Z.

Para carregá-la pelo ZSAPLINK acesse o programa e apenas carregue o NUGG para o sistema:

![Importando via ZSAPLINK](/assets/images/abap-hacks/img1.png)

Para carregá-la por uma classe local, acesse a SE24 e vá ao menu importar->Classes locais do programa:

![Importando via ZSAPLINK](/assets/images/abap-hacks/img2.png)

Segue o exemplo de utilização que também se [encontra no arquivo README](https://github.com/brenoacf/abap-hacks/tree/master/stvarvc-extract) da pasta no repositório:

```abap
"! This code show how to use the zcl_stvarv_extract class.

DATA: lv_value        TYPE rvari_val_255,
      lr_range        TYPE ace_generic_range_t,
      lv_range        TYPE ace_generic_range,
      lr_range_result TYPE ace_generic_range_t.

* 1 - Fetching a single parameter
lv_value = zcl_stvarv_extract=>get_parameter( 'Z_SINGLE_PARAM' ).

* 2 - Seeking various parameters using the special character pattern
lr_range = zcl_stvarv_extract=>get_parameters( 'Z_WERKS_%' ).

* 3 - Searching for a range of parameters (LOW values)
REFRESH lr_range.
lv_range-sign = 'I'.
lv_range-option = 'EQ'.

lv_range-low = 'Z_BUKRS'.
APPEND lv_range TO lr_range.

lv_range-low = 'Z_WERDS'.
APPEND lv_range TO lr_range.

lv_range-low = 'Z_GJAHR'.
APPEND lv_range TO lr_range.

lr_range_result = zcl_stvarv_extract=>get_parameters_by_range( lr_range ).

* 4 - Seeking a "Select Options"
REFRESH lr_range_result.
lr_range_result = zcl_stvarv_extract=>get_selection_options( 'Z_SELECTION_PARAM').
```

Assim que tiver mais tempo, colocarei mais classes, rotinas e códigos para facilitar o desenvolvimento ABAP aqui no blog.

Abraços.
