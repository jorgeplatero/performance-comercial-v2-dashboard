/*Medida Selecionada Rank Vendedor*/
/*-----------------------------------------------------*/
Medida Selecionada Rank Vendedor = 
/*
0 = Faturamento
1 = Resultado
2 = Comissão
*/
VAR vSelecao = SELECTEDVALUE('pMedidaRankVendedor'[Id])
VAR vResultado = SWITCH(
    vSelecao,
    1, [Resultado],
    2, [Comissao],
    [Faturamento]
)
RETURN
vResultado

/*Rank Vendedor*/
/*-----------------------------------------------------*/
Medida Selecionada Rank Vendedor = 
/*
0 = Faturamento
1 = Resultado
2 = Comissão
*/
VAR vSelecao = SELECTEDVALUE('pMedidaRankVendedor'[Id])
VAR vResultado = SWITCH(
    vSelecao,
    1, [Resultado],
    2, [Comissao],
    [Faturamento]
)
RETURN
vResultado

/*Rank Vendedor*/
/*-----------------------------------------------------*/
Rank Vendedor = 
VAR vTabela = ALL('dVendedores'[Vendedor])
VAR vResultado = RANK(
    DENSE,
    vTabela,
    ORDERBY(
        [Medida Selecionada Rank Vendedor], DESC, --1° critério de desempate
        [Faturamento], DESC,
        [Resultado], DESC, --2° critério de desempate
        [Comissao], DESC, --3° critério de desempate
        'dVendedores'[Vendedor], ASC --4° critério de desempate
    )
)
RETURN
vResultado

/*Faturamento Top 3*/
/*-----------------------------------------------------*/
Faturamento Top 3 = CALCULATE(
    [Faturamento],
    FILTER(
         VALUES('dVendedores'[Vendedor]),
         [Rank Vendedor] <= 3
    )
)

/*Faturamento Top 3 %*/
/*-----------------------------------------------------*/
Faturamento Top 3 % = DIVIDE(
    [Faturamento Top 3], [Faturamento]
)

/*Comissao Top 3*/
/*-----------------------------------------------------*/
Comissao Top 3 = CALCULATE(
    [Comissao],
    FILTER(
         VALUES('dVendedores'[Vendedor]),
         [Rank Vendedor] <= 3
    )
)

/*Comissao Top 3 %*/
/*-----------------------------------------------------*/
Comissao Top 3 % = DIVIDE(
    [Comissao Top 3], [Comissao]
)

/*Resultado Top 3 */
/*-----------------------------------------------------*/
Resultado Top 3 = CALCULATE(
    [Resultado],
    FILTER(
         VALUES('dVendedores'[Vendedor]),
         [Rank Vendedor] <= 3
    )
)

/*Resultado Top 3 %*/
/*-----------------------------------------------------*/
Resultado Top 3 % = DIVIDE(
    [Resultado Top 3], [Resultado]
)

/*Podio*/
/*-----------------------------------------------------*/
Podio = 
/*formatacao------------------------------*/
VAR vFonte = "Segoe UI"
VAR vTamanhoNome  = 12
VAR vCorNome  = "#F1F1F1"
VAR vPesoNome = 500
VAR vTamanhoValor = 14
VAR vCorValor  = "#F1F1F1"
VAR vPesoValor = 600
VAR vVariacaoTamanho = 10
VAR vCorVariacao  = [Meta Cor] 
VAR vPesoVariacao = 700
/*----------------------------------------*/
VAR vVendedor = SELECTEDVALUE('dVendedores'[Vendedor])
VAR vFoto = SELECTEDVALUE('dVendedores'[URL Foto])
VAR vValor = [Medida Selecionada Rank Vendedor]
VAR vValorFormatado = SWITCH(
    TRUE(),
    ABS(vValor) >= 1e9, FORMAT(vValor, "R$ #,,,.00 Bi"),
    ABS(vValor) >= 1e6, FORMAT(vValor, "R$ #,,.00 Mi"),
    ABS(vValor) >= 1e3, FORMAT(vValor, "R$ #,.00 K"),
    FORMAT(vValor, "R$ #")
)
VAR vVariacaoPercentual = [Meta %] - 1
VAR vVariacaoPercentualFormatado = FORMAT(vVariacaoPercentual, "⮝ 0.00%; ⮟ 0.00%; -")
VAR vVariacaoValor = [Faturamento] - [Meta]
VAR vVariacaoValorFormatado = SWITCH(
        TRUE(),
        ABS( vVariacaoValor ) >= 1E9, FORMAT(vVariacaoValor, "R$ #,,,.00 Bi;R$ #,,,.0 Bi;-"),
        ABS( vVariacaoValor ) >= 1E6, FORMAT(vVariacaoValor, "R$ #,,.00 Mi;R$ #,,.0 Mi;-"),
        ABS( vVariacaoValor ) >= 1E3, FORMAT(vVariacaoValor, "R$ #,.00 K;R$ #,.0 K;-"),
        FORMAT(vVariacaoValor, "R$ #;R$ #;-")

    )
RETURN
"
<svg viewBox='0 0 150 170' fill='none' xmlns='http://www.w3.org/2000/svg'>
	
    <g id='podio'>
		
        <image href='"&vFoto&"' id='foto' x='32' y='7' width='85' height='85' fill='#D9D9D9'/>
		
        <text id='nome_vendedor' text-anchor='middle' fill='"&vCorNome&"' font-family='Inter' font-size='"&vTamanhoNome&"' font-weight='"&vPesoNome&"'>
            <tspan x='75' y='110'>"&vVendedor&"</tspan>
        </text>
		
        <text id='valor' text-anchor='middle' fill='"&vCorValor&"' font-family='Inter' font-size='"&vTamanhoValor&"' font-weight='"&vPesoValor&"'>
            <tspan x='75' y='140.864'>"&vValorFormatado&"</tspan>
        </text>
		
        <text id='porcentagem' text-anchor='middle' fill='"&vCorVariacao&"' font-family='"&vFonte&"' font-size='"&vVariacaoTamanho&"' font-weight='"&vPesoVariacao&"'>
            <tspan x='75' y='160.864'>"&vVariacaoPercentualFormatado&" | "&vVariacaoValorFormatado&"</tspan>
        </text>
	
    </g>

</svg>
"

/*Imagem Cartao Comissao Rank Vendedores*/
/*-----------------------------------------------------*/
Imagem Cartao Comissao Rank Vendedores = 
/*formatacao------------------------------*/
VAR vFonte = "Segoe UI"
VAR vTamanhoTextoComissaoGeral  = 11
VAR vCorTextoComissaoGeral  = "#D1D1D1"
VAR vPesoTextoComissaoGeral = 400
VAR vTamanhoValorComissaoGeral = 20
VAR vCorValorComissaoGeral  = "#D1783C"
VAR vPesoValorComissaoGeral = 600
VAR vTamanhoTextoComissaoTop3  = 11
VAR vCorTextoComissaoTop3  = "#D1D1D1"
VAR vPesoTextoComissaoTop3 = 400
VAR vTamanhoValorComissaoTop3 = 20
VAR vCorValorComissaoTop3  = "#D1783C"
VAR vPesoValorComissaoTop3 = 600
VAR vTamanhoValorComissaoTop3Percentual = 10
VAR vCorValorComissaoTop3Percentual  = "#D1783C"
VAR vPesoValorComissaoTop3Percentual = 400
VAR CorBarraTotal = "#D8D9DA"
VAR CorBarraParcial = "#D1783C"
/*----------------------------------------*/
/*formatacao hover------------------------------*/
VAR vCorFundoHover = "#D1783C"
VAR vCorValoresHover = "#0E1620"
VAR vCorTitulosHover = "#FFFFFF"
VAR vCorBarraParcialHover = "#0E1620"
/*----------------------------------------*/
VAR vComissaoGeral = [Comissao]
VAR vComissaoGeralFormatado = SWITCH(
    TRUE(),
    ABS(vComissaoGeral) >= 1e9, FORMAT(vComissaoGeral, "R$ #,,,.00 Bi"),
    ABS(vComissaoGeral) >= 1e6, FORMAT(vComissaoGeral, "R$ #,,.00 Mi"),
    ABS(vComissaoGeral) >= 1e3, FORMAT(vComissaoGeral, "R$ #,.00 K"),
    FORMAT(vComissaoGeral, "R$ #")
)
VAR vComissaoTop3 = [Comissao Top 3]
VAR vvComissaoTop3Formatado = SWITCH(
    TRUE(),
    ABS(vComissaoTop3) >= 1e9, FORMAT(vComissaoTop3, "R$ #,,,.00 Bi"),
    ABS(vComissaoTop3) >= 1e6, FORMAT(vComissaoTop3, "R$ #,,.00 Mi"),
    ABS(vComissaoTop3) >= 1e3, FORMAT(vComissaoTop3, "R$ #,.00 K"),
    FORMAT(vComissaoTop3, "R$ #")
)
VAR vComissaoTop3Percentual = [Comissao Top 3 %]
VAR vComissaoTop3PercentualFormatado = FORMAT(vComissaoTop3Percentual, "0% do Total")
VAR vLarguraBarraTotal = 140
VAR vLarguraBarraParcial = ROUND(vLarguraBarraTotal * vComissaoTop3Percentual, 0)
RETURN
"
<svg width='170' height='166' viewBox='0 0 170 166' fill='none' xmlns='http://www.w3.org/2000/svg'>
<style>
    svg:hover{
        background: "&vCorFundoHover&";
        border-radius: 10px
    }
    svg:hover #valor_Comissao,
    svg:hover #valor_Comissao_top_3,
    svg:hover #valor_Comissao_top_3_percentual{
        fill: "&vCorValoresHover&"
    }
    svg:hover #texto_Comissao_geral,
    svg:hover #texto_Comissao_top_3{
        fill: "&vCorTitulosHover&"
    }
    svg:hover #barra_parcial{
        fill: "&vCorBarraParcialHover&"
    }
</style>
<g id='cartao_rank_vendedores'>
	<rect x='0.5' y='0.5' width='169' height='165'/>
    <text id='texto_Comissao_geral' fill='"&vCorTextoComissaoGeral&"' font-family='"&vFonte&"' font-size='"&vTamanhoTextoComissaoGeral&"' font-weight='"&vPesoTextoComissaoGeral&"'>
		<tspan x='15' y='22.6364'>Comissao Geral</tspan>
	</text>
	<text id='valor_Comissao' fill='"&vCorValorComissaoGeral&"' font-family='"&vFonte&"' font-size='"&vTamanhoValorComissaoGeral&"' font-weight='"&vPesoValorComissaoGeral&"'>
		<tspan x='15' y='44.5909'>"&vComissaoGeralFormatado&"</tspan>
	</text>
    	<text id='texto_Comissao_top_3' fill='"&vCorTextoComissaoTop3&"' font-family='"&vFonte&"' font-size='"&vTamanhoTextoComissaoTop3&"' font-weight='"&vPesoTextoComissaoTop3&"'>
		<tspan x='15' y='75.6364'>Comissao | Top 3</tspan>
	</text>
	<text id='valor_Comissao_top_3' fill='"&vCorValorComissaoTop3&"' font-family='"&vFonte&"' font-size='"&vTamanhoValorComissaoTop3&"' font-weight='"&vPesoValorComissaoTop3&"'>
		<tspan x='15' y='97.5909'>"&vvComissaoTop3Formatado&"</tspan>
	</text>
    <rect id='barra_total' x='15' y='120' width='"&vLarguraBarraTotal&"' height='15' rx='5' fill='"&CorBarraTotal&"'/>
	<rect id='barra_parcial' x='15' y='120' width='"&vLarguraBarraParcial&"' height='15' rx='5' fill='"&CorBarraParcial&"'/>
	<text id='valor_Comissao_top_3_percentual' fill='"&vCorValorComissaoTop3Percentual&"' font-family='"&vFonte&"' font-size='"&vTamanhoValorComissaoTop3Percentual&"' font-weight='"&vPesoValorComissaoTop3Percentual&"'>
		<tspan x='54' y='150'>"&vComissaoTop3PercentualFormatado&"</tspan>
	</text>
</g>
"

/*Imagem Cartao Faturamento Rank Vendedores*/
/*-----------------------------------------------------*/
Imagem Cartao Faturamento Rank Vendedores = 
/*formatacao------------------------------*/
VAR vFonte = "Segoe UI"
VAR vTamanhoTextoFaturamentoGeral  = 11
VAR vCorTextoFaturamentoGeral  = "#D1D1D1"
VAR vPesoTextoFaturamentoGeral = 400
VAR vTamanhoValorFaturamentoGeral = 20
VAR vCorValorFaturamentoGeral  = "#59B7C8"
VAR vPesoValorFaturamentoGeral = 600
VAR vTamanhoTextoFaturamentoTop3  = 11
VAR vCorTextoFaturamentoTop3  = "#D1D1D1"
VAR vPesoTextoFaturamentoTop3 = 400
VAR vTamanhoValorFaturamentoTop3 = 20
VAR vCorValorFaturamentoTop3  = "#59B7C8"
VAR vPesoValorFaturamentoTop3 = 600
VAR vTamanhoValorFaturamentoTop3Percentual = 10
VAR vCorValorFaturamentoTop3Percentual  = "#59B7C8"
VAR vPesoValorFaturamentoTop3Percentual = 400
VAR CorBarraTotal = "#D8D9DA"
VAR CorBarraParcial = "#59B7C8"
/*----------------------------------------*/
/*formatacao hover------------------------------*/
VAR vCorFundoHover = "#59B7C8"
VAR vCorValoresHover = "#0E1620"
VAR vCorTitulosHover = "#FFFFFF"
VAR vCorBarraParcialHover = "#0E1620"
/*----------------------------------------*/
VAR vFaturamentoGeral = [Faturamento]
VAR vFaturamentoGeralFormatado = SWITCH(
    TRUE(),
    ABS(vFaturamentoGeral) >= 1e9, FORMAT(vFaturamentoGeral, "R$ #,,,.00 Bi"),
    ABS(vFaturamentoGeral) >= 1e6, FORMAT(vFaturamentoGeral, "R$ #,,.00 Mi"),
    ABS(vFaturamentoGeral) >= 1e3, FORMAT(vFaturamentoGeral, "R$ #,.00 K"),
    FORMAT(vFaturamentoGeral, "R$ #")
)
VAR vFaturamentoTop3 = [Faturamento Top 3]
VAR vvFaturamentoTop3Formatado = SWITCH(
    TRUE(),
    ABS(vFaturamentoTop3) >= 1e9, FORMAT(vFaturamentoTop3, "R$ #,,,.00 Bi"),
    ABS(vFaturamentoTop3) >= 1e6, FORMAT(vFaturamentoTop3, "R$ #,,.00 Mi"),
    ABS(vFaturamentoTop3) >= 1e3, FORMAT(vFaturamentoTop3, "R$ #,.00 K"),
    FORMAT(vFaturamentoTop3, "R$ #")
)
VAR vFaturamentoTop3Percentual = [Faturamento Top 3 %]
VAR vFaturamentoTop3PercentualFormatado = FORMAT(vFaturamentoTop3Percentual, "0% do Total")
VAR vLarguraBarraTotal = 140
VAR vLarguraBarraParcial = ROUND(vLarguraBarraTotal * vFaturamentoTop3Percentual, 0)
RETURN
"
<svg width='170' height='166' viewBox='0 0 170 166' fill='none' xmlns='http://www.w3.org/2000/svg'>
<style>
    svg:hover{
        background: "&vCorFundoHover&";
        border-radius: 10px
    }
    svg:hover #valor_faturamento,
    svg:hover #valor_faturamento_top_3,
    svg:hover #valor_faturamento_top_3_percentual{
        fill: "&vCorValoresHover&"
    }
    svg:hover #texto_faturamento_geral,
    svg:hover #texto_faturamento_top_3{
        fill: "&vCorTitulosHover&"
    }
    svg:hover #barra_parcial{
        fill: "&vCorBarraParcialHover&"
    }
</style>
<g id='cartao_rank_vendedores'>
	<rect x='0.5' y='0.5' width='169' height='165'/>
    <text id='texto_faturamento_geral' fill='"&vCorTextoFaturamentoGeral&"' font-family='"&vFonte&"' font-size='"&vTamanhoTextoFaturamentoGeral&"' font-weight='"&vPesoTextoFaturamentoGeral&"'>
		<tspan x='15' y='22.6364'>Faturamento Geral</tspan>
	</text>
	<text id='valor_faturamento' fill='"&vCorValorFaturamentoGeral&"' font-family='"&vFonte&"' font-size='"&vTamanhoValorFaturamentoGeral&"' font-weight='"&vPesoValorFaturamentoGeral&"'>
		<tspan x='15' y='44.5909'>"&vFaturamentoGeralFormatado&"</tspan>
	</text>
    	<text id='texto_faturamento_top_3' fill='"&vCorTextoFaturamentoTop3&"' font-family='"&vFonte&"' font-size='"&vTamanhoTextoFaturamentoTop3&"' font-weight='"&vPesoTextoFaturamentoTop3&"'>
		<tspan x='15' y='75.6364'>Faturamento | Top 3</tspan>
	</text>
	<text id='valor_faturamento_top_3' fill='"&vCorValorFaturamentoTop3&"' font-family='"&vFonte&"' font-size='"&vTamanhoValorFaturamentoTop3&"' font-weight='"&vPesoValorFaturamentoTop3&"'>
		<tspan x='15' y='97.5909'>"&vvFaturamentoTop3Formatado&"</tspan>
	</text>
    <rect id='barra_total' x='15' y='120' width='"&vLarguraBarraTotal&"' height='15' rx='5' fill='"&CorBarraTotal&"'/>
	<rect id='barra_parcial' x='15' y='120' width='"&vLarguraBarraParcial&"' height='15' rx='5' fill='"&CorBarraParcial&"'/>
	<text id='valor_faturamento_top_3_percentual' fill='"&vCorValorFaturamentoTop3Percentual&"' font-family='"&vFonte&"' font-size='"&vTamanhoValorFaturamentoTop3Percentual&"' font-weight='"&vPesoValorFaturamentoTop3Percentual&"'>
		<tspan x='54' y='150'>"&vFaturamentoTop3PercentualFormatado&"</tspan>
	</text>
</g>
"

/*Imagem Cartao Resultado Rank Vendedores*/
/*-----------------------------------------------------*/
Imagem Cartao Resultado Rank Vendedores = 
/*formatacao------------------------------*/
VAR vFonte = "Segoe UI"
VAR vTamanhoTextoResultadoGeral  = 11
VAR vCorTextoResultadoGeral  = "#D1D1D1"
VAR vPesoTextoResultadoGeral = 400
VAR vTamanhoValorResultadoGeral = 20
VAR vCorValorResultadoGeral  = "#9D79AA"
VAR vPesoValorResultadoGeral = 600
VAR vTamanhoTextoResultadoTop3  = 11
VAR vCorTextoResultadoTop3  = "#D1D1D1"
VAR vPesoTextoResultadoTop3 = 400
VAR vTamanhoValorResultadoTop3 = 20
VAR vCorValorResultadoTop3  = "#9D79AA"
VAR vPesoValorResultadoTop3 = 600
VAR vTamanhoValorResultadoTop3Percentual = 10
VAR vCorValorResultadoTop3Percentual  = "#9D79AA"
VAR vPesoValorResultadoTop3Percentual = 400
VAR CorBarraTotal = "#D8D9DA"
VAR CorBarraParcial = "#9D79AA"
/*----------------------------------------*/
/*formatacao hover------------------------------*/
VAR vCorFundoHover = "#9D79AA"
VAR vCorValoresHover = "#0E1620"
VAR vCorTitulosHover = "#FFFFFF"
VAR vCorBarraParcialHover = "#0E1620"
/*----------------------------------------*/
VAR vResultadoGeral = [Resultado]
VAR vResultadoGeralFormatado = SWITCH(
    TRUE(),
    ABS(vResultadoGeral) >= 1e9, FORMAT(vResultadoGeral, "R$ #,,,.00 Bi"),
    ABS(vResultadoGeral) >= 1e6, FORMAT(vResultadoGeral, "R$ #,,.00 Mi"),
    ABS(vResultadoGeral) >= 1e3, FORMAT(vResultadoGeral, "R$ #,.00 K"),
    FORMAT(vResultadoGeral, "R$ #")
)
VAR vResultadoTop3 = [Resultado Top 3]
VAR vvResultadoTop3Formatado = SWITCH(
    TRUE(),
    ABS(vResultadoTop3) >= 1e9, FORMAT(vResultadoTop3, "R$ #,,,.00 Bi"),
    ABS(vResultadoTop3) >= 1e6, FORMAT(vResultadoTop3, "R$ #,,.00 Mi"),
    ABS(vResultadoTop3) >= 1e3, FORMAT(vResultadoTop3, "R$ #,.00 K"),
    FORMAT(vResultadoTop3, "R$ #")
)
VAR vResultadoTop3Percentual = [Resultado Top 3 %]
VAR vResultadoTop3PercentualFormatado = FORMAT(vResultadoTop3Percentual, "0% do Total")
VAR vLarguraBarraTotal = 140
VAR vLarguraBarraParcial = ROUND(vLarguraBarraTotal * vResultadoTop3Percentual, 0)
RETURN
"
<svg width='170' height='166' viewBox='0 0 170 166' fill='none' xmlns='http://www.w3.org/2000/svg'>
<style>
    svg:hover{
        background: "&vCorFundoHover&";
        border-radius: 10px
    }
    svg:hover #valor_Resultado,
    svg:hover #valor_Resultado_top_3,
    svg:hover #valor_Resultado_top_3_percentual{
        fill: "&vCorValoresHover&"
    }
    svg:hover #texto_Resultado_geral,
    svg:hover #texto_Resultado_top_3{
        fill: "&vCorTitulosHover&"
    }
    svg:hover #barra_parcial{
        fill: "&vCorBarraParcialHover&"
    }
</style>
<g id='cartao_rank_vendedores'>
	<rect x='0.5' y='0.5' width='169' height='165'/>
    <text id='texto_Resultado_geral' fill='"&vCorTextoResultadoGeral&"' font-family='"&vFonte&"' font-size='"&vTamanhoTextoResultadoGeral&"' font-weight='"&vPesoTextoResultadoGeral&"'>
		<tspan x='15' y='22.6364'>Resultado Geral</tspan>
	</text>
	<text id='valor_Resultado' fill='"&vCorValorResultadoGeral&"' font-family='"&vFonte&"' font-size='"&vTamanhoValorResultadoGeral&"' font-weight='"&vPesoValorResultadoGeral&"'>
		<tspan x='15' y='44.5909'>"&vResultadoGeralFormatado&"</tspan>
	</text>
    	<text id='texto_Resultado_top_3' fill='"&vCorTextoResultadoTop3&"' font-family='"&vFonte&"' font-size='"&vTamanhoTextoResultadoTop3&"' font-weight='"&vPesoTextoResultadoTop3&"'>
		<tspan x='15' y='75.6364'>Resultado | Top 3</tspan>
	</text>
	<text id='valor_Resultado_top_3' fill='"&vCorValorResultadoTop3&"' font-family='"&vFonte&"' font-size='"&vTamanhoValorResultadoTop3&"' font-weight='"&vPesoValorResultadoTop3&"'>
		<tspan x='15' y='97.5909'>"&vvResultadoTop3Formatado&"</tspan>
	</text>
    <rect id='barra_total' x='15' y='120' width='"&vLarguraBarraTotal&"' height='15' rx='5' fill='"&CorBarraTotal&"'/>
	<rect id='barra_parcial' x='15' y='120' width='"&vLarguraBarraParcial&"' height='15' rx='5' fill='"&CorBarraParcial&"'/>
	<text id='valor_Resultado_top_3_percentual' fill='"&vCorValorResultadoTop3Percentual&"' font-family='"&vFonte&"' font-size='"&vTamanhoValorResultadoTop3Percentual&"' font-weight='"&vPesoValorResultadoTop3Percentual&"'>
		<tspan x='54' y='150'>"&vResultadoTop3PercentualFormatado&"</tspan>
	</text>
</g>
"

/*Imagem Tabela Rank Vendedores*/
/*-----------------------------------------------------*/
Imagem Tabela Rank Vendedores = 
/*formatacao------------------------------*/
VAR vFonte = "Segoe UI"
VAR vTamanhoNome  = 10
VAR vCorNome  = "#F1F1F1"
VAR vPesoNome = 500
VAR vTamanhoValores = 14
VAR vPesoValores = 600
VAR vCorFaturamento = "#59B7C8"
VAR vCorResultado = "#9D79AA"
VAR vCorComissao = "#D1783C"


/*----------------------------------------*/
VAR vPosicao = [Rank Vendedor]
VAR vNome = SELECTEDVALUE('dVendedores'[Vendedor])
VAR vFoto = SELECTEDVALUE('dVendedores'[URL Foto])
VAR vFaturamento = [Faturamento]
VAR vFaturamentoFormatado = SWITCH(
    TRUE(),
    ABS(vFaturamento) >= 1e9, FORMAT(vFaturamento, "R$ #,,,.00 Bi"),
    ABS(vFaturamento) >= 1e6, FORMAT(vFaturamento, "R$ #,,.00 Mi"),
    ABS(vFaturamento) >= 1e3, FORMAT(vFaturamento, "R$ #,.00 K"),
    FORMAT(vFaturamento, "R$ #")
)
VAR vResultado = [Resultado]
VAR vResultadoFormatado = SWITCH(
    TRUE(),
    ABS(vResultado) >= 1e9, FORMAT(vResultado, "R$ #,,,.00 Bi"),
    ABS(vResultado) >= 1e6, FORMAT(vResultado, "R$ #,,.00 Mi"),
    ABS(vResultado) >= 1e3, FORMAT(vResultado, "R$ #,.00 k"),
    FORMAT(vResultado, "R$ #")
)
VAR vComissao = [Comissao]
VAR vComissaoFormatado = SWITCH(
    TRUE(),
    ABS(vComissao) >= 1e9, FORMAT(vComissao, "R$ #,,,.00 Bi"),
    ABS(vComissao) >= 1e6, FORMAT(vComissao, "R$ #,,.00 Mi"),
    ABS(vComissao) >= 1e3, FORMAT(vComissao, "R$ #,.00 K"),
    FORMAT(vComissao, "R$ #")
)
RETURN
"
<svg width='456' height='73' viewBox='0 0 456 73' fill='none' xmlns='http://www.w3.org/2000/svg'>
    <style>
        svg{
            margin-top: 15px;
        }
        #quadro_fundo:hover{
            fill: #59B7C8;
            fill-opacity: 0.15
        }
    </style>
	<g id='tabela_rank_vendedores' clip-path='url(#clip0_89_21)'>
		<rect id='quadro_fundo' x='0.5' y='0.5' width='455' height='71.8571' rx='9.5' fill='#0E1620' fill-opacity:'0.01' stroke='url(#paint0_linear_89_21)'/>
		<text id='posicao' fill='#F1F1F1' font-family='"&vFonte&"' font-size='20' font-weight='600'>
			<tspan x='15' y='43.2727'>"&vPosicao&"</tspan>
		</text>
		<text id='nome' text-anchor='middle' fill='"&vCorNome&"' font-family='"&vFonte&"' font-size='"&vTamanhoNome&"' font-weight='"&vPesoNome&"'>
			<tspan x='85' y='60.8636'>"&vNome&"</tspan>
		</text>
		<text id='faturamento' fill='"&vCorFaturamento&"' font-family='"&vFonte&"' font-size='"&vTamanhoValores&"' font-weight='"&vPesoValores&"'>
			<tspan x='140' y='41.5909'>"&vFaturamentoFormatado&"</tspan>
		</text>
		<text id='resultado' fill='"&vCorResultado&"' font-family='"&vFonte&"' font-size='"&vTamanhoValores&"' font-weight='"&vPesoValores&"'>
			<tspan x='249' y='41.5909'>"&vResultadoFormatado&"</tspan>
		</text>
		<text id='comissao' fill='"&vCorComissao&"' font-family='"&vFonte&"' font-size='"&vTamanhoValores&"' font-weight='"&vPesoValores&"'>
			<tspan x='357' y='41.5909'>"&vComissaoFormatado&"</tspan>
		</text>
		<image id='foto' href='"&vFoto&"' x='67' y='8' width='36' height='36' fill='#F1F1F1'/>
	</g>
	<defs>
		<linearGradient id='paint0_linear_89_21' x1='456' y1='18' x2='452' y2='-9.99999' gradientUnits='userSpaceOnUse'>
			<stop offset='0.04' stop-color='#010409'/>
			<stop offset='1' stop-color='#59B7C8' stop-opacity='0.2'/>
		</linearGradient>
	</defs>
</svg>
"