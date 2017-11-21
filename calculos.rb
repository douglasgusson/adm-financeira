
class App


    def initialize
        menu
    end

    
    # função para exibição do menu e escolha de opção
    def menu

        puts
        puts " _----------------- MENU ------------------_"
        puts "| 1. Calcular juros compostos               |"           
        puts "| 2. Calcular valor presente líquido (VPL)  |"
        puts "| 3. Calcular taxa interna de retorno (TIR) |"
        puts "| 0. SAIR                                   |"
        puts "---------------------------------------------"
        puts "| OBS.: Para valores DECIMAIS utilize ponto |"
        puts "|       invés de vírgula                    |"
        puts "---------------------------------------------"
        print "Informe a opção desejada: "

        case gets.strip
            when "1"
                juros_composto
            when "2"
                valor_presente_liquido
            when "3"
                taxa_interna_retorno
            when "0"
                print "\nObrigado por utilizar este software!\n\n"
                exit
            else
              puts "\nDesculpe, opção inválida!"
              menu
        end
    end


    # função para calculo de montante utilizando juros compostos
    def juros_composto

        puts
        puts "Informe o valor do capital: " 
        capital = gets.to_f
        
        puts "Informe o total de períodos: "    
        t = gets.to_i
        
        puts "Informe o valor da taxa (%): "    
        i = gets.to_f

        m = (capital*(1+(i/100))**t).round(2)

        puts "\nAO FIM DE #{t} PERÍODOS COM TAXA DE #{i}\% O VALOR SERÁ R$ #{vpl}."

        menu

    end


    # função para calculo de valor presente líquido (VPL)
    def valor_presente_liquido

        fluxos = []
        vpls = []

        puts
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
        
        puts
        puts "Informe o valor do investimento inicial: "   
        fluxos << gets.to_f * (-1)    

        puts "Informe o número total de períodos: "    
        t = gets.to_i  

        for i in 1..t            
            puts "Informe o valor do fluxo de caixa (FC) para o período #{i}: "   
            fluxos << gets.to_f     
        end

        loop do
            aux = 0
            tir += 0.01  
            for i in 0..fluxos.size-1
                aux += (fluxos[i]/(1+(tir/100))**(i)).round(2)
            end
            break if not aux > 0
        end  

        puts "A TAXA INTERNA DE RETORNO (TIR) É IGUAL A #{tir.round(2)}\%"

        menu

    end

end


App.new # Run App
