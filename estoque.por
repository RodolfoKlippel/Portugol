programa
{
	inclua biblioteca Texto
	inclua biblioteca Util
	cadeia produtos[8]={"TOMATE","LARANJA","MIXIRICA","ABOBORA","PAO","ARROZ","FEIJAO","BATATA"},opcao=""
	inteiro estoque[8]={40		,10		,30		,4		,25	,8		,6		,30},minimo[8]={10		,2		,5		,2		,8	,3		,2		,6},i
	
	funcao inicio()
	{
		enquanto(verdadeiro){
			escreva("O que deseja fazer?\n(A) Para adicionar no Estoque\n(R) Para retirar do Estoque\n(M) Para mostrar estoque\n(S) Para Sair\n")
			leia(opcao)
			opcao=Texto.caixa_alta(opcao)
			limpa()
			se(opcao=="S"){
				pare
			}senao se(opcao=="A"){
				adicionar()
			}senao se(opcao=="R"){
				retirar()
			}senao se(opcao=="M"){
				menu()
			}
		}
		limpa()
		menu()
	}

	funcao adicionar(){
		inteiro i,quantAdicional
		cadeia produto=""
		escreva("Diga que produto você deseja modificar no estoque: ")
		leia(produto)
		produto=Texto.caixa_alta(produto)
		para(i=0;i<Util.numero_elementos(produtos);i++){
			se(produto==produtos[i]){
				escreva("Quantos(as) ",produtos[i],"(S) você deseja adicionar no estoque?")
				leia(quantAdicional)
				se(quantAdicional<0){
					escreva("\nComando inválido.\n\n")
					pare
				}senao{
					estoque[i]+=quantAdicional
					pare
				}
			}senao se(produto!=produtos[i] e i==Util.numero_elementos(produtos)-1){
				escreva("\nProduto não encontrado.\n")
			}
		}
	}
	
	funcao retirar(){
		inteiro i,quantRemovida
		cadeia produto=""
		escreva("Diga que produto você deseja modificar no estoque: ")
		leia(produto)
		produto=Texto.caixa_alta(produto)
		para(i=0;i<Util.numero_elementos(produtos);i++){
			se(produto==produtos[i]){
				escreva("Quantos(as) ",produtos[i],"(S) você deseja remover no estoque?")
				leia(quantRemovida)
				se(quantRemovida<0 ou estoque[i]-quantRemovida<0){
					escreva("\nComando inválido.\n\n")
				}senao{
					estoque[i]-=quantRemovida
					se(estoque[i]<=minimo[i]){
						escreva("Cuidado, a quantidade mínima de produtos foi ultrapassada.")
					}
				}
				pare
			}senao se(produto!=produtos[i] e i==Util.numero_elementos(produtos)-1){
				escreva("\nProduto não encontrado.\n")
			}
		}
	}

	funcao menu(){
		inteiro aux=1
		escreva("Lista de estoque abaixo:\n")
		para(i=0;i<Util.numero_elementos(produtos);i++){
			se(estoque[i]>0){
				escreva(aux,". Existem ",estoque[i]," ",produtos[i]," no estoque.\n")
				aux+=1	
			}
		}
		escreva("\n")
	}
}
/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 2350; 
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */