<?php
/**
*
* @package Icy Phoenix
* @version $Id$
* @copyright (c) 2008 Icy Phoenix
* @license http://opensource.org/licenses/gpl-license.php GNU Public License
*
*/

/**
*
* @Icy Phoenix is based on phpBB
* @copyright (c) 2008 phpBB Group
*
*/

if (!defined('IN_ICYPHOENIX'))
{
	die('Hacking attempt');
}

error_reporting(E_ALL ^ E_NOTICE); // Report all errors, except notices

// OLD extension.inc - BEGIN
//@ini_set('memory_limit', '24M');

$starttime = 0;

// Page generation time
$mtime = microtime();
$mtime = explode(' ', $mtime);
$mtime = $mtime[1] + $mtime[0];
$starttime = $mtime;

// Change this if your extension is not .php!
//@define('PHP_EXT', 'php');
//$phpbb_root_path = IP_ROOT_PATH;
//$phpEx = PHP_EXT;

// Mighty Gorgon - Debug - BEGIN
@define('DEBUG', true); // Debugging ON/OFF => TRUE/FALSE
@define('DEBUG_EXTRA', true); // Extra Debugging ON/OFF => TRUE/FALSE
if (defined('DEBUG_EXTRA') && (DEBUG_EXTRA == true))
{
	$base_memory_usage = 0;
	if (function_exists('memory_get_usage'))
	{
		$base_memory_usage = @memory_get_usage();
	}
}
// Mighty Gorgon - Debug - END
// OLD extension.inc - END

// The following code (unsetting globals)
// Thanks to Matt Kavanagh and Stefan Esser for providing feedback as well as patch files

/*
* Remove variables created by register_globals from the global scope
* Thanks to Matt Kavanagh
*/
function deregister_globals()
{
	$not_unset = array(
		'GLOBALS'						=> true,
		'_GET'							=> true,
		'_POST'							=> true,
		'_COOKIE'						=> true,
		'_REQUEST'					=> true,
		'_SERVER'						=> true,
		'_SESSION'					=> true,
		'_ENV'							=> true,
		'_FILES'						=> true,
		'no_page_header'		=> true,
		'starttime'					=> true,
		'base_memory_usage'	=> true,
	);

	// Not only will array_merge and array_keys give a warning if
	// a parameter is not an array, array_merge will actually fail.
	// So we check if _SESSION has been initialised.
	if (!isset($_SESSION) || !is_array($_SESSION))
	{
		$_SESSION = array();
	}

	// Merge all into one extremely huge array; unset this later
	$input = array_merge(
		array_keys($_GET),
		array_keys($_POST),
		array_keys($_COOKIE),
		array_keys($_SERVER),
		array_keys($_SESSION),
		array_keys($_ENV),
		array_keys($_FILES)
	);

	foreach ($input as $varname)
	{
		if (isset($not_unset[$varname]))
		{
			// Hacking attempt. No point in continuing unless it's a COOKIE
			if (($varname !== 'GLOBALS') || isset($_GET['GLOBALS']) || isset($_POST['GLOBALS']) || isset($_SERVER['GLOBALS']) || isset($_SESSION['GLOBALS']) || isset($_ENV['GLOBALS']) || isset($_FILES['GLOBALS']))
			{
				exit;
			}
			else
			{
				$cookie = &$_COOKIE;
				while (isset($cookie['GLOBALS']))
				{
					foreach ($cookie['GLOBALS'] as $registered_var => $value)
					{
						if (!isset($not_unset[$registered_var]))
						{
							unset($GLOBALS[$registered_var]);
						}
					}
					$cookie = &$cookie['GLOBALS'];
				}
			}
		}
		unset($GLOBALS[$varname]);
	}
	unset($input);
}

// If we are on PHP >= 6.0.0 we do not need some code
if (version_compare(PHP_VERSION, '6.0.0-dev', '>='))
{
	define('STRIP', false);
}
else
{
	@set_magic_quotes_runtime(0); // Disable magic_quotes_runtime
	if (@ini_get('register_globals') == '1' || (strtolower(@ini_get('register_globals')) == 'on') || !function_exists('ini_get'))
	{
		deregister_globals();
	}
	define('STRIP', (@get_magic_quotes_gpc()) ? true : false);
}

// Is this safe?
@date_default_timezone_set(@date_default_timezone_get());

// CrackerTracker v5.x
// Uncomment the following define to disable CT GET and POST parsing.
//define('GLOBAL_CTRACKER_DISABLED', true);
if(defined('IN_ADMIN') || defined('IN_CMS') || defined('CTRACKER_DISABLED') || defined('GLOBAL_CTRACKER_DISABLED'))
{
	$ct_rules = array();
	define('protection_unit_one', true);
}
else
{
	include(IP_ROOT_PATH . 'ctracker/engines/ct_security.' . PHP_EXT);
}
// CrackerTracker v5.x

// Protect against GLOBALS tricks
if (isset($_POST['GLOBALS']) || isset($_FILES['GLOBALS']) || isset($_GET['GLOBALS']) || isset($_COOKIE['GLOBALS']))
{
	die('Hacking attempt');
}

// Protect against SESSION tricks
if (isset($_SESSION) && !is_array($_SESSION))
{
	die('Hacking attempt');
}

//
// addslashes to vars if magic_quotes_gpc is off
// this is a security precaution to prevent someone
// trying to break out of a SQL statement.
//
if(!STRIP)
{
	if(is_array($_GET))
	{
		while(list($k, $v) = each($_GET))
		{
			if(is_array($_GET[$k]))
			{
				while(list($k2, $v2) = each($_GET[$k]))
				{
					$_GET[$k][$k2] = addslashes($v2);
				}
				@reset($_GET[$k]);
			}
			else
			{
				$_GET[$k] = addslashes($v);
			}
		}
		@reset($_GET);
	}

	if(is_array($_POST))
	{
		while(list($k, $v) = each($_POST))
		{
			if(is_array($_POST[$k]))
			{
				while(list($k2, $v2) = each($_POST[$k]))
				{
					$_POST[$k][$k2] = addslashes($v2);
				}
				@reset($_POST[$k]);
			}
			else
			{
				$_POST[$k] = addslashes($v);
			}
		}
		@reset($_POST);
	}

	if(is_array($_COOKIE))
	{
		while(list($k, $v) = each($_COOKIE))
		{
			if(is_array($_COOKIE[$k]))
			{
				while(list($k2, $v2) = each($_COOKIE[$k]))
				{
					$_COOKIE[$k][$k2] = addslashes($v2);
				}
				@reset($_COOKIE[$k]);
			}
			else
			{
				$_COOKIE[$k] = addslashes($v);
			}
		}
		@reset($_COOKIE);
	}
}

//
// Define some basic configuration arrays this also prevents malicious
// rewriting of language and other array values via URI params
//
$config = array();
$cms_config_layouts = array();
$userdata = array();
$theme = array();
$images = array();
$lang = array();
$tree = array();
$nav_links = array();
$dss_seeded = false;
$gen_simple_header = false;
$breadcrumbs_address = '';
$breadcrumbs_links_left = '';
$breadcrumbs_links_right = '';
//<!-- BEGIN Unread Post Information to Database Mod -->
$unread = array();
//<!-- END Unread Post Information to Database Mod -->

include(IP_ROOT_PATH . 'config.' . PHP_EXT);

if(!defined('IP_INSTALLED') && !defined('IN_INSTALL'))
{
	header('Location: ' . IP_ROOT_PATH . 'install/install.' . PHP_EXT);
	exit;
}

include(IP_ROOT_PATH . 'includes/constants.' . PHP_EXT);
include(IP_ROOT_PATH . 'includes/template.' . PHP_EXT);
include(IP_ROOT_PATH . 'includes/sessions.' . PHP_EXT);
include(IP_ROOT_PATH . 'includes/auth.' . PHP_EXT);
include(IP_ROOT_PATH . 'includes/class_cache.' . PHP_EXT);
include(IP_ROOT_PATH . 'includes/class_cache_extends.' . PHP_EXT);
include(IP_ROOT_PATH . 'includes/functions.' . PHP_EXT);
include(IP_ROOT_PATH . 'includes/functions_categories_hierarchy.' . PHP_EXT);
include(IP_ROOT_PATH . 'includes/class_cms.' . PHP_EXT);
if (defined('IN_ADMIN'))
{
	include_once(IP_ROOT_PATH . 'includes/functions_admin.' . PHP_EXT);
}

// We need to instantiate Cache Class before DB to correctly initialize DB Connection
$cache = new ip_cache();
$ip_cms = new ip_cms();

include(IP_ROOT_PATH . 'includes/db.' . PHP_EXT);

// We do not need these any longer, unset for safety purpose
unset($dbuser);
unset($dbpasswd);
unset($db->password);
unset($message);
unset($highlight);
unset($sql);

// MG Cash MOD For IP - BEGIN
if (defined('CASH_PLUGIN_ENABLED') && CASH_PLUGIN_ENABLED && defined('IN_CASHMOD'))
{
	include(IP_ROOT_PATH . 'includes/functions_cash.' . PHP_EXT);
}
// MG Cash MOD For IP - END

//
// Obtain and encode users IP
//
// I'm removing HTTP_X_FORWARDED_FOR ... this may well cause other problems such as
// private range IP's appearing instead of the guilty routable IP, tough, don't
// even bother complaining ... go scream and shout at the idiots out there who feel
// "clever" is doing harm rather than good ... karma is a great thing ... :)
//
$client_ip = (!empty($_SERVER['REMOTE_ADDR'])) ? $_SERVER['REMOTE_ADDR'] : ((!empty($_ENV['REMOTE_ADDR'])) ? $_ENV['REMOTE_ADDR'] : getenv('REMOTE_ADDR'));
$user_ip = encode_ip($client_ip);
$user_agent = (!empty($_SERVER['HTTP_USER_AGENT']) ? trim($_SERVER['HTTP_USER_AGENT']) : (!empty($_ENV['HTTP_USER_AGENT']) ? trim($_ENV['HTTP_USER_AGENT']) : trim(getenv('HTTP_USER_AGENT'))));

// Set PHP error handler to ours
set_error_handler(defined('IP_MSG_HANDLER') ? IP_MSG_HANDLER : 'msg_handler');

// Check if we are in ACP
if ((defined('IN_ADMIN') || defined('IN_CMS')) && !defined('ACP_MODULES'))
{
	$cache->destroy('config');
}
else
{
	if (!defined('IN_POSTING') && defined('TIME_LIMIT'))
	{
		@set_time_limit(TIME_LIMIT);
	}
}

// CrackerTracker v5.x
include(IP_ROOT_PATH . 'ctracker/classes/class_ct_database.' . PHP_EXT);
$ctracker_config = new ct_database();
define('protection_unit_two', true);
if ($ctracker_config->settings['ipblock_enabled'])
{
	include(IP_ROOT_PATH . 'ctracker/engines/ct_ipblocker.' . PHP_EXT);
}
define('protection_unit_three', true);
// CrackerTracker v5.x

$config = $cache->obtain_config();
$config['default_style_row'] = $cache->obtain_default_style(false);

// CMS Pages Config - BEGIN
if (!defined('SKIP_CMS_CONFIG') && !defined('IN_ADMIN') && !defined('IN_CMS'))
{
	//$cms_config_layouts = get_layouts_config(true);
	$cms_config_layouts = $cache->obtain_cms_layouts_config();
}
// CMS Pages Config - END

include(IP_ROOT_PATH . ATTACH_MOD_PATH . 'attachment_mod.' . PHP_EXT);

//<!-- BEGIN Unread Post Information to Database Mod -->
if ($config['global_disable_upi2db'])
{
	$config['upi2db_on'] = 0;
}
else
{
	include(IP_ROOT_PATH . 'includes/functions_upi2db.' . PHP_EXT);
}
//<!-- END Unread Post Information to Database Mod -->

// MG Logs - BEGIN
if ($config['mg_log_actions'] || !empty($config['db_log_actions']))
{
	include(IP_ROOT_PATH . 'includes/functions_mg_log.' . PHP_EXT);
}
// MG Logs - END

// This check could not be moved above, otherwise we may get errors due to some vars and includes not initialized
if (file_exists('install'))
{
	trigger_error('Please_remove_install_contrib');
}

if ($config['url_rw'] || $config['url_rw_guests'])
{
	include(IP_ROOT_PATH . 'includes/functions_rewrite.' . PHP_EXT);
}

if (!$config['disable_referrers'])
{
	include_once(IP_ROOT_PATH . 'includes/functions_referrers.' . PHP_EXT);
}

// Mighty Gorgon - Change Lang/Style - BEGIN
$test_language = request_var(LANG_URL, '');
if ($test_language != '')
{
	$test_language = str_replace(array('.', '/'), '', urldecode($test_language));
	$config['default_lang'] = is_dir(IP_ROOT_PATH . 'language/lang_' . $test_language) ? $test_language : $config['default_lang'];
	setcookie($config['cookie_name'] . '_lang', $config['default_lang'], (time() + 86400), $config['cookie_path'], $config['cookie_domain'], $config['cookie_secure']);
}
else
{
	if (isset($_COOKIE[$config['cookie_name'] . '_lang']))
	{
		$config['default_lang'] = $_COOKIE[$config['cookie_name'] . '_lang'];
	}
}

$test_style = request_var(STYLE_URL, 0);
if ($test_style > 0)
{
	$current_style = $config['default_style'];
	$config['default_style'] = urldecode($test_style);
	$config['default_style'] = (check_style_exists($config['default_style']) == false) ? $current_style : $config['default_style'];
	setcookie($config['cookie_name'] . '_style', $config['default_style'], (time() + 86400), $config['cookie_path'], $config['cookie_domain'], $config['cookie_secure']);
}
else
{
	if (isset($_COOKIE[$config['cookie_name'] . '_style']) && (check_style_exists($_COOKIE[$config['cookie_name'] . '_style']) != false))
	{
		$config['default_style'] = $_COOKIE[$config['cookie_name'] . '_style'];
	}
}
// Mighty Gorgon - Change Lang/Style - END

if ($config['admin_protect'])
{
	$founder_id = (defined('FOUNDER_ID') ? FOUNDER_ID : get_founder_id());
	founder_protect($founder_id);
}

if ((isset($_GET['lofi']) && (intval($_GET['lofi']) == 1)) || (isset($_COOKIE['lofi']) && (intval($_COOKIE['lofi']) == 1)))
{
	$lofi = 1;
}

/*
foreach ($cache->obtain_hooks() as $hook)
{
	@include(IP_ROOT_PATH . 'includes/hooks/' . $hook . '.' . PHP_EXT);
}
*/
?>