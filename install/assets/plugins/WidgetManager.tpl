//<?php
/**
 * WidgetManager
 *
 * Evolution Dashboard Widget Manager
 *
 * @author    Nicola Lambathakis
 * @category    plugin
 * @version    v 1
 * @license    http://www.gnu.org/copyleft/gpl.html GNU Public License (GPL)
 * @internal    @events OnManagerWelcomeHome,OnManagerWelcomeRender
 * @internal    @installset base
 * @internal    @modx_category Dashboard
 * @internal    @properties &welcome_showhide=Show Welcome Widget:;menu;show,hide,AdminOnly;show  &welcome_sizex=Welcome x size:;list;100,75,50,25;50 &welcome_menuindex=Welcome sort order:;text;1  &onlineinfo_showhide=Show Online Info widget:;menu;show,hide,AdminOnly;show &onlineinfo_sizex=Online Info x size:;list;100,75,50,25;50 &onlineinfo_menuindex=Online Info sort order:;text;2 &recentinfo_showhide=Show Recent resource Widget:;menu;show,hide,AdminOnly;show &recentinfo_sizex=Recent resource x size:;list;100,75,50,25;100 &recentinfo_menuindex=Recent resource sort order:;text;3 &news_showhide=Show News Widget:;menu;show,hide,AdminOnly;show &news_sizex=News x size:;list;100,75,50,25;50 &news_menuindex=News sort order:;text;4 &security_showhide=Show SecurityNews Widget:;menu;show,hide,AdminOnly;show &security_sizex=SecurityNews x size:;list;100,75,50,25;50 &security_menuindex=SecurityNews order:;text;5
*/

// get manager role
$role = $_SESSION['mgrRole'];
// get language
global $_lang;
$e = &$modx->Event;
switch($e->name){
case 'OnManagerWelcomeHome':
// get manager role
$role = $_SESSION['mgrRole']; 		
//welcome
$welcome_showhide = isset($welcome_showhide) ? $welcome_showhide: 'hide';
if(($role!=1) AND ($welcome_showhide == 'AdminOnly') OR ($welcome_showhide == 'hide'))  {
$widgets['welcome']['hide']='1';
}
//onlineinfo
if(($role!=1) AND ($onlineinfo_showhide == 'AdminOnly') OR ($onlineinfo_showhide == 'hide'))  {
$widgets['onlineinfo']['hide']='1';
}
//recentinfo
if(($role!=1) AND ($recentinfo_showhide == 'AdminOnly') OR ($recentinfo_showhide == 'hide'))  {
$widgets['recentinfo']['hide']='1';
}
//news
if(($role!=1) AND ($news_showhide == 'AdminOnly') OR ($news_showhide == 'hide'))  {
$widgets['news']['hide']='1';
}
//security
if(($role!=1) AND ($security_showhide == 'AdminOnly') OR ($security_showhide == 'hide'))  {
$widgets['security']['hide']='1';
}
//cols
$widgets['welcome']['cols']='col-sm-'.$welcome_sizex.''; 
$widgets['onlineinfo']['cols']='col-sm-'.$onlineinfo_sizex.''; 
$widgets['recentinfo']['cols']='col-sm-'.$recentinfo_sizex.''; 
$widgets['news']['cols']='col-sm-'.$news_sizex.''; 
$widgets['security']['cols']='col-sm-'.$security_sizex.''; 
//menuindex
$widgets['welcome']['menuindex']=$welcome_menuindex; 
$widgets['onlineinfo']['menuindex']=$onlineinfo_menuindex; 
$widgets['recentinfo']['menuindex']=$recentinfo_menuindex; 
$widgets['news']['menuindex']=$news_menuindex; 
$widgets['security']['menuindex']=$security_menuindex; 
$e->output(serialize($widgets));
break;
case 'OnManagerWelcomeRender':
// get plugin id
$result = $modx->db->select('id', $this->getFullTableName("site_plugins"), "name='{$modx->event->activePlugin}' AND disabled=0");
$pluginid = $modx->db->getValue($result);
if($modx->hasPermission('edit_plugin')) {
$button_pl_config = '
<div class="container-fluid">
    <p class="text-muted pull-right">
    <a title="' . $_lang["settings_config"] . '" href="index.php?id='.$pluginid.'&a=102" class="btn btn-sm" ><i class="fa fa-cog"></i> ' . $_lang["settings_config"] . '</a> 
    </p>
  </div>
</div>
';
}
$e->output($button_pl_config);
break;
}