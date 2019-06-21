----- Assinaturas -----
sig Usuario {
	conta: lone Conta
}

sig Conta {
	aplicativos: set App,
	dispositivos: set Dispositivo
}

abstract sig App {
	versaoAtual: one Versao
}
sig AppGratis extends App {}
sig AppPago extends App {
	cartao: one Cartao
}

abstract sig Versao {}
sig Atualizado extends Versao {}
sig Deprecado extends Versao {}

sig Cartao {}

sig Dispositivo {
	appsInstalados: set App
}

-- Usuário pode possuir uma (ou nenhuma) conta e Conta possui apenas um usuário
fact usuarioEconta {
	all c: Conta | one c.~conta
}
-- Fatos das contas
fact conta {
	all c: Conta | #(c.dispositivos) > 0 /* Todas as contas possuem ao menos
	uma conta */
}


----- Fatos -----
-- Fatos dos dispositivos
fact dispositivoEaplicativos {
	/* Dispositivos só podem estar ligados a uma conta de um único usuário */
	all d: Dispositivo | one d.~dispositivos
	all a: App | one a.~aplicativos
	all a: App, d: Dispositivo | (a in d.appsInstalados) => d.~dispositivos = a.~aplicativos
}
-- Fatos do cartao
fact cartao {
	/* Um cartao só pode está ligado um aplicativo pago */
	all ca: Cartao | one ca.~cartao
}
-- Fatos da versao
fact versao {
	-- Só existem duas versões: atual e antiga
	#(Atualizado) = 1
	#(Deprecado) = 1
}



pred show{}

run show for 5
