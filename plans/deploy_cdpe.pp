plan cdpe::deploy_cdpe(
  TargetSpec $cdpe_server,
  String $mysqluser,
  String $mysqlpass,
  String $database,
  String $user,
  String $pass,  
  String $root_email,
  String $root_password,
) {
  run_task('cdpe::install_docker', $cdpe_server)
  run_task('cdpe::install_mysql', $cdpe_server, password => $mysqlpass)
  run_task('cdpe::create_database', $cdpe_server, mysqluser => $mysqluser, mysqlpass => $mysqlpass, database => $database, user => $user, pass => $pass)
  run_task('cdpe::install_cdpe', $cdpe_server, dbserver => $cdpe_server, database => $database, user => $user, pass => $pass)
  run_task('cd4pe::root_configuration', $cdpe_server, root_email => $root_email, root_password => $root_password)
}
