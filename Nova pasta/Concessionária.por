programa
{
	inclua biblioteca Arquivos
	inclua biblioteca Texto
	inclua biblioteca Util
	
	cadeia carros[100],decisao="!",sair,veiculo=""
	inteiro preco[100],estoque[100],i,j,numeroDeCarros=6,caixa=15000
	
	funcao inicio()
	{
		variaveis()
		enquanto (decisao!=""){
			limpa()
			escreva("O que você deseja fazer?\n\n(C) Comprar um carro da concessionária\n(V) Vender um carro para a concessionária\n(A) Alugar um carro da concessionária\n\n")
			leia(decisao)														// MENU INICIAL
			decisao=Texto.caixa_alta(decisao)										// CAIXA ALTA PARA EVITAR ERROS 
			se(decisao==""){													// BRAKE CASO QUEIRA QUE PARE
				pare
			}
			se(decisao=="V"){													// FUNÇÃO VENDAS
				venda()
			}senao se(decisao=="C"){												// FUNÇÃO COMPRAR
				compra()
			}senao se(decisao=="A"){												// FUNÇÃO ALUGUEL
				aluguel()
			}

			escreva("\nDeseja fazer algo mais? [S/N]  ")								//CASO QUERIA REALIZAR MAIS OPERAÇÕES
			leia(sair)
			sair=Texto.caixa_alta(sair)
			se(sair=="N"){
				pare
			}
		}
		arquivo()																// MOSTRA O RESULTADO FINAL
	}
	
	funcao venda(){															// FUNÇÃO DE VENDA //
		inteiro precoVenda=0,aux=0,trava=0,trava2=0
		cadeia respDono=""
		limpa()
		escreva("\nQue veículo você deseja oferecer? ")								// DEFINE VEÍCULO A SER VENDIDO
		leia(veiculo)
		veiculo=Texto.caixa_alta(veiculo)
		escreva("Por quanto irá vender: ")											// DEFINE PREÇO
		leia(precoVenda)

		para(i=0;i<100;i++){													// PARA QUE PERCORRE TODOS OS NOMES DOS CARROS NO ARRAY
			se(veiculo==carros[i]){												// SE ALGUM VEÍCULO TIVE O MESMO NOME
				estoque[i]+=1													// ESTOQUE NA MESMA POSIÇÃO INCREMENTA
				aux=i														// AUXILIAR TORNA-SE A POSIÇÃO 
				trava2=1														// TRAVA AUXILIAR
				pare
			}senao se((veiculo!=carros[i]) e (i==99)){								// SE NENHUM DOS NOMES NO ARRAY FOR 
				estoque[numeroDeCarros-1]+=1										// OS CARROS VÃO DE 0 A 4 E AGORA POSSUEM 6 CARROS, O NOVO CARRO ESTARÁ NA POSIÇÃO 6-1 = 5
				aux=numeroDeCarros												
				carros[aux-1]=veiculo											// CARRO NA POSIÇÃO 5 SE TORNARÁ O VEÍCULO VENDIDO	
				numeroDeCarros++ trava=1											// AUMENTA E COLOCA UMA TRAVA AUXILIAR	
				pare
			}
		}
		
		para(i=0;i<1;i++){														// 'PARA' ESTRATÉGICO PARA BREAK
			se((preco[aux]*0.84)>=precoVenda){										// SE O PREÇO FOR ABAIXO DOS 16%, COMPRE	
				escreva("\nO carro foi vendido!!!\n\n")
				caixa-=precoVenda												// SUBTRAI O PREÇO DO CAIXA APÓS COMPRA
				pare
			}senao{
				escreva("\nO dono da concessionária aceitará a Oferta? [S/N]  ")			// DECISÃO DE COMPRA
				leia(respDono)
				respDono=Texto.caixa_alta(respDono)
				se(respDono=="S"){												// SE 'SIM'
					escreva("\nO carro foi vendido!!!\n\n")
					preco[numeroDeCarros-2]=precoVenda								// PREÇO NA POSIÇÃO NUMERO - 2, POIS ATULAMENTE O NUMERO DE CARROS VALE 7
					caixa-=precoVenda
				}senao se(respDono=="N"){										// SE 'NÃO'
					escreva("\nO carro não foi vendido!!!\n\n")
					se(trava==1){												// CHECA AS TRAVAS PARA SUBTRAIR O NUMERO DE CARROS E ESTOQUES
						numeroDeCarros--
					}senao se(trava2==1){
						estoque[aux]--
					}
				}
			}
				
		}
		veiculo=""															// VEÍCULOS VOLTAM AO VALOR ORIGINAL PARA 
	}																		// PROTEGER CÓDIGOS SEGUINTES

	funcao compra(){
		inteiro i,aux,num=1,precoCarro=1
		cadeia carroComprado="",resp
		limpa()
		escreva("Essas são as opções de Compra:\n\n")								// LISTA DE CARROS QUE PODEM SER ALUGADOS
		para(i=0;i<100;i++){
			se(estoque[i]>0){
				escreva(num,". ",carros[i],"\n")									// GERADOR DO MENU
				num+=1
			}
		}
		escreva("\nQue veículo você deseja Comprar? ")								// DEFINE VEÍCULO A SER VENDIDO
		leia(carroComprado)
		carroComprado=Texto.caixa_alta(carroComprado)
		para(i=0;i<100;i++){
			se(carroComprado==carros[i]){
				precoCarro=preco[i]*1.31
				escreva("\nO preço do carro será: ",precoCarro,"\n\nVocê aceita essa venda? [S/N] ")									// GERADOR DO MENU
				leia(resp)
				resp=Texto.caixa_alta(resp)
				se(resp=="S"){
					escreva("\n\nCarro Vendido!\n")
					estoque[i]-=1
					caixa+=precoCarro
					se(estoque[i]==0){
						para(i;i<100;i++){
							se(i!=99){
								estoque[i]=estoque[i+1]
								carros[i]=carros[i+1]
								preco[i]=preco[i+1]	
							}
						}
						numeroDeCarros-=1
					}
					pare
				}senao se(resp=="N"){
					escreva("\n\nCarro não foi Vendido!\n")
					pare
				}
			}senao se(carroComprado!=carros[i] e i==99){
				escreva("\nO carro não foi encontrado")
			}
		}
	}

	funcao aluguel(){
		inteiro i=0,trava=0,aluguel=85,dias=0
		cadeia carroAlugado="",aceita=""
		limpa()
		escreva("Essas são as opções de aluguel:\n\n")									// LISTA DE CARROS QUE PODEM SER ALUGADOS
		para(i=0;i<numeroDeCarros-1;i++){
			se(estoque[i]>0){
				escreva((i+1),". ",carros[i],"\n")									// GERADOR DO MENU
			}
		}
		enquanto(trava!=1){														// TRAVA DE REPETIÇÃO DO ENQUANTO
			escreva("\nDiga qual carro você irá querer alugar: ")						// DIGA O CARRO
			leia(carroAlugado)
			se(carroAlugado==""){
					pare
			}
			carroAlugado=Texto.caixa_alta(carroAlugado)
			enquanto(carroAlugado!=""){
				para(i=0;i<numeroDeCarros-1;i++){									// PARA PARA CHECAR SE O CARRO DIGITADO ESTÁ NA LISTA DE CARROS DO MENU
					se(carroAlugado == carros[i]){								// SE O CARRO DIGITADO ESTIVER NA LISTA
						escreva("\nPor quantos dias você deseja alugar o carro? ")
						leia(dias)
						escreva("\nO aluguel do carro custará: ",(aluguel*dias),"\nVocê Aceita? [S/N] ")	// PERGUNTA 
						leia(aceita)
						aceita=Texto.caixa_alta(aceita)
						se(aceita=="S"){
							escreva("\nO carro foi Alugado!!!\n")
							caixa=caixa+(aluguel*dias)
							trava=1
							carroAlugado=""
							pare
						}senao se(aceita=="N"){
							escreva("\nO carro não foi Alugado...\n")
							trava=0
							pare
						}
					}senao se(carroAlugado != carros[i] e i==numeroDeCarros-2){		// SE O CARRO DIGITADO NÃO ESTIVER NA LISTA
						escreva("\nOpção Inválidaz!\n")						// OPÇÃO SERÁ INVÁLIDA
						trava=0
					}
				}	
			}
		}
	}																		// LISTA ORIGINAL
	
	funcao variaveis(){
		carros[0] = "MUSTANG" carros[1]="FERRARI" carros[2]="BUGGATI" carros[3]="LAMBORGNI" carros[4]="LIMOSINE"
		preco[0] = 10000 preco[1] = 15000 preco[2]=14000 preco[3]=20000 preco[4]=30000
		estoque[0]=1 estoque[1]=1 estoque[2]=1 estoque[3]=1 estoque[4]=1
	}

	funcao arquivo(){															// MOSTRA O RESULTADO DA PLANILHA COM TODOS OS DADOS
		limpa()
		escreva("Planilha da Empresa:\n")
		para(i=0;i<numeroDeCarros-1;i++){
			escreva("O carro ",carros[i],", que custa ",preco[i],", com estoque de ",estoque[i]," carros.\n")
		}
		escreva("\nO caixa da Empresa é de: ",caixa,"\n")
	}
}
/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 644; 
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */