#!/usr/bin/php
<?php
/**** Config Area ****/
  /* Remote Server */
  $remote_server = 'user@host.com';
  $remote_port = 22; //ssh port
  $remote_path = '/home/example/dominios/';
  
  /*Local Server*/
  $local_path  = ''; // "Example: /var/www/"
/*********************/


$parametro = $argv[1];

$partesp = explode('.', $parametro);
$cantidad_de_partes = count($partesp);
if($cantidad_de_partes == 1)
{
    imp("Invalid domain");
    exit();
}
elseif($cantidad_de_partes == 2)
{
    //son 2 parametros es un dominio
    $dominio = $partesp[0].'.'.$partesp[1];
    $subdominio = 'www';
    $subdominioLocal = 'www';

    imp("It's a domain");
}
elseif($cantidad_de_partes == 3)
{
    //son 3 parametros es un subdominio
    $dominio = $partesp[1].'.'.$partesp[2];
    $subdominio = $partesp[0];
    $subdominioLocal = $subdominio;

    imp("It's a subdomain");
}
imp("Domain = $dominio");
imp("Subdomain = $subdominio");

system("rsync -e \"ssh -p $remote_port\" -axvzc --progress --stats $local_path$dominio/$subdominioLocal/ $remote_server:$remote_path$dominio/$subdominio/");

function imp($string)
{
  echo $string.PHP_EOL;
}
?>