#!/usr/bin/ruby
puts "\nOBS.: Para valores decimais utilize pontos ao invés de vírgula."

# função para calculo de montante utilizando juros compostos
def juros_composto

	puts "Informe o valor do capital: "	
	capital = gets.to_f
	
	puts "Informe o total de períodos: "	
	t = gets.to_i
	
	puts "Informe o valor da taxa (%): "	
	i = gets.to_f

	m = (capital*(1+(i/100))**t).round(2)

	puts "\nAo final de #{t} períodos com taxa de #{i} \% o valor será #{m}."

end


# função para calculo de valor presente líquido (VPL)
def valor_presente_liquido

	puts "Informe o valor do fluxo inicial: "	
	fluxo_inicial = gets.to_f
	
	puts "Informe o total de períodos: "	
	t = gets.to_i
	
	puts "Informe o valor da taxa (%): "	
	i = gets.to_f

	vpl = fluxo_inicial * (-1)

	for x in 1..t

		puts "Informe o valor do fluxo para o período #{x}: "	
		fluxo = gets.to_f		

		vplx = (fluxo/(1+(i/100))**x).round(2)
		puts "=> VPL#{x} = #{vplx}"

		vpl = vpl + vplx

	end

	puts "\nAo final de #{t} períodos com taxa de #{i} \% o valor será #{vpl}."

end

#juros_composto
valor_presente_liquido