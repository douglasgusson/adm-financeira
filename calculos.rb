
class App


    def initialize
        menu
    end

    
    # função para exibição do menu e escolha de opção
    def menu

        puts
        puts "---------------------------------------------"
        puts "|                   MENU                    |"
        puts "---------------------------------------------"
        puts "| 1. Calcular valor futuro (VF)             |"
        puts "| 2. Calcular valor presente (VP)           |"
        puts "| 3. Calcular valor presente líquido (VPL)  |"
        puts "| 4. Calcular Payback                       |"
        puts "| 5. Calcular taxa interna de retorno (TIR) |"
        puts "| 0. SAIR                                   |"
        puts "---------------------------------------------"
        puts "| OBS.: Para valores DECIMAIS utilize ponto |"
        puts "|       invés de vírgula                    |"
        puts "---------------------------------------------"
        print "Informe a opção desejada: "

        case gets.strip
            when "1"
                valor_futuro
            when "2"
                valor_presente
            when "3"
                valor_presente_liquido
            when "4"
                payback
            when "5"
                taxa_interna_retorno
            when "0"
                print "\nObrigado por utilizar este software!\n\n"
                exit
            else
              puts "\nDesculpe, opção inválida!"
              menu
        end
    end



    # função para calculo de valor futuro (VF) utilizando juros compostos
    def valor_futuro

        puts "---------------------------------------------"
        puts "|            VALOR FUTURO (VF)              |"
        puts "---------------------------------------------"
        puts "Informe o valor presente: " 
        vp = gets.to_f
        
        puts "Informe o total de períodos: "    
        t = gets.to_i
        
        puts "Informe o valor da taxa (%): "    
        i = gets.to_f

        m = (vp*(1+(i/100))**t).round(2)

        puts "\nAO FIM DE #{t} PERÍODOS COM TAXA DE #{i}\% O VALOR SERÁ R$ #{m}."

        menu

    end


    # função para calculo de valor presente (VP) utilizando juros compostos
    def valor_presente

        puts "---------------------------------------------"
        puts "|           VALOR PRESENTE (VP)             |"
        puts "---------------------------------------------"
        puts "Informe o valor futuro: " 
        vp = gets.to_f
        
        puts "Informe o total de períodos: "    
        t = gets.to_i
        
        puts "Informe o valor da taxa (%): "    
        i = gets.to_f

        m = (vp/(1+(i/100))**t).round(2)

        puts "\nAO FIM DE #{t} PERÍODOS COM TAXA DE #{i}\% O VALOR SERÁ R$ #{m}."

        menu

    end


    # função para calculo de valor presente líquido (VPL)
    def valor_presente_liquido

        fluxos = []
        vpls = []

        puts "---------------------------------------------"
        puts "|      VALOR PRESENTE LÍQUIDO (VPL)         |"
        puts "---------------------------------------------"
        puts "Informe o valor do investimento inicial: "   
        fluxos << gets.to_f * (-1)
        
        puts "Informe o número total de períodos: "    
        t = gets.to_i
        
        puts "Informe o valor da taxa (%, Ex.: 10):"    
        i = gets.to_f

        for x in 1..t
            
            puts "Informe o valor do fluxo de caixa (FC) para o período #{x}: "   
            fluxos << gets.to_f     

            vpls << (fluxos[x]/(1+(i/100))**x).round(2)

        end

        vpl = (vpls.inject(0, :+) + fluxos.first).round(2) 

        puts "\nAO FIM DE #{t} PERÍODOS COM TAXA DE #{i}\% O VALOR SERÁ R$ #{vpl}."

        menu

    end


    def taxa_interna_retorno

        fluxos = []
        tir = 0
        
        puts "---------------------------------------------"
        puts "|      TAXA INTERNA DE RETORNO (TIR)        |"
        puts "---------------------------------------------"
        puts "Informe o valor do investimento inicial: "   
        fluxos << gets.to_f * (-1) # inverte o sinal do valor investido   

        puts "Informe o número total de períodos: "    
        t = gets.to_i  

        for i in 1..t            
            puts "Informe o valor do fluxo de caixa (FC) para o período #{i}: "   
            fluxos << gets.to_f     
        end

        loop do

            aux = 0 # variável auxiliar para o cálculo
            tir += 0.01 # incrementa o valor da TIR para a próxima tentativa 

            # aux é o somatório dos resultados do cálculo de valor presente para cada fluxo de caixa (no for)
            # a cada interação do do..while a variável aux é zerada e o valor da tir é incrementado (+0.01)
            # a condição de parada do do..while é quando aux chega a um resultado menor ou igual a zero.
            # quando o valor de aux é menor ou igual a zero quer dizer que atingimos o valor de 
            # taxa (TIR) necessária para igualar o valor de um investimento.    
            # Fórmula: (fluxos[i]/(1+(tir/100))**(i)) 

            for i in 0..fluxos.size-1                     
                aux += (fluxos[i]/(1+(tir/100))**(i)).round(2)               
            end

            break if not aux > 0
        end  

        puts "A TAXA INTERNA DE RETORNO (TIR) É IGUAL A #{tir.round(2)}\%"

        menu

    end
    

    # função para calculo de payback
    def payback

        fluxos = []
        vpls = []
        acumulados = []

        puts "---------------------------------------------"
        puts "|                 PAYBACK                   |"
        puts "---------------------------------------------"
        puts "Informe o valor do investimento inicial: "   
        fluxos << gets.to_f * (-1) # inverte o sinal do valor investido
        
        puts "Informe o número total de períodos: "    
        t = gets.to_i
        
        puts "Informe o valor da taxa (%, Ex.: 10):"    
        i = gets.to_f

        vpls << (fluxos[0]/(1+(i/100))**0).round(2)
        acumulados << vpls[0]
        
        for x in 1..t            
            puts "Informe o valor do fluxo de caixa (FC) para o período #{x}: "   
            fluxos << gets.to_f     

            vpls << (fluxos[x]/(1+(i/100))**x).round(2)
        end

        for x in 1..t
            acumulados[x] = vpls[x] - acumulados[x-1] * (-1)
        end

        positivo = -1

        for x in 0..t
            if acumulados[x] > 0
                positivo = x
            end
        end

        if positivo != -1
           pbk = ((positivo-1) + (acumulados[positivo-1]*(-1)/vpls[positivo])).round(2)
           puts "\nO PAYBACK SERÁ DE #{pbk} PERÍODOS."  
        else
           puts "\nNÃO HOUVE PAYBACK MENOR QUE #{t} PERÍODOS." 
        end     

        menu

    end

end


App.new # Run App
