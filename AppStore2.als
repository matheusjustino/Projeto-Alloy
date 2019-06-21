sig Usuario {
	conta: one Conta
}

sig Conta {
	apps: set App,
	disps: set Dispositivo
}

abstract sig App {}
sig AppGratis extends App {}
sig AppPago extends App {
	cartao: one Cartao
}

sig Dispositivo {
	appsInstalados: set App
}

sig Cartao {}

fact usuarios {
	all c:Conta | one c.~conta
	all c:Conta | #(c.disps) > 0
	all d:Dispositivo | one d.~disps
	all a:App | one a.~apps
	all a:App, d:Dispositivo | (a in d.appsInstalados) => d.~disps = a.~apps -- | one c.~conta
	--all c:Conta | all d:c.disps | d.appsInstalados = c.apps
	all ca:Cartao | one ca.~cartao
}

pred show{}

run show for 4
