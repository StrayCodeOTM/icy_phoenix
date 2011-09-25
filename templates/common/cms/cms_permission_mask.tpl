<script type="text/javascript">
// <![CDATA[
	var active_pmask = '0';
	var active_fmask = '0';
	var active_cat = '0';

	var id = '000';

	var role_options = new Array();

	<!-- IF S_ROLE_JS_ARRAY -->
		{S_ROLE_JS_ARRAY}
	<!-- ENDIF -->
// ]]>
</script>
<script type="text/javascript" src="{FULL_SITE_PATH}{T_COMMON_TPL_PATH}js/permissions.js"></script>

<!-- BEGIN p_mask -->
<div class="clearfix"></div>
<h3 style="text-align: left;">{p_mask.NAME}<!-- IF p_mask.S_LOCAL --> <span class="gensmall"> [{p_mask.L_ACL_TYPE}]</span><!-- ENDIF --></h3>

<!-- BEGIN f_mask -->
<div class="clearfix"></div>
<fieldset class="permissions phpbb" id="perm{p_mask.S_ROW_COUNT}{p_mask.f_mask.S_ROW_COUNT}">
	<legend id="legend{p_mask.S_ROW_COUNT}{p_mask.f_mask.S_ROW_COUNT}" class="phpbb">
		<!-- IF not p_mask.S_VIEW -->
			<input type="checkbox" style="display: none;" class="permissions-checkbox" name="inherit[{p_mask.f_mask.UG_ID}][{p_mask.f_mask.FORUM_ID}]" id="checkbox{p_mask.S_ROW_COUNT}{p_mask.f_mask.S_ROW_COUNT}" value="1" onclick="toggle_opacity('{p_mask.S_ROW_COUNT}{p_mask.f_mask.S_ROW_COUNT}')" /> 
		<!-- ELSE -->
		<!-- ENDIF -->
		<!-- IF p_mask.f_mask.PADDING --><span class="padding">{p_mask.f_mask.PADDING}{p_mask.f_mask.PADDING}</span><!-- ENDIF -->{p_mask.f_mask.NAME}
	</legend>
	<!-- IF not p_mask.S_VIEW -->
		<div class="permissions-switch">
			<div class="permissions-reset">
				<a href="#" onclick="mark_options('perm{p_mask.S_ROW_COUNT}{p_mask.f_mask.S_ROW_COUNT}', 'y'); reset_role('role{p_mask.S_ROW_COUNT}{p_mask.f_mask.S_ROW_COUNT}'); init_colours('{p_mask.S_ROW_COUNT}{p_mask.f_mask.S_ROW_COUNT}'); return false;">{L_ALL_YES}</a> &middot; <a href="#" onclick="mark_options('perm{p_mask.S_ROW_COUNT}{p_mask.f_mask.S_ROW_COUNT}', 'u'); reset_role('role{p_mask.S_ROW_COUNT}{p_mask.f_mask.S_ROW_COUNT}'); init_colours('{p_mask.S_ROW_COUNT}{p_mask.f_mask.S_ROW_COUNT}'); return false;">{L_ALL_NO}</a> &middot; <a href="#" onclick="mark_options('perm{p_mask.S_ROW_COUNT}{p_mask.f_mask.S_ROW_COUNT}', 'n'); reset_role('role{p_mask.S_ROW_COUNT}{p_mask.f_mask.S_ROW_COUNT}'); init_colours('{p_mask.S_ROW_COUNT}{p_mask.f_mask.S_ROW_COUNT}'); return false;">{L_ALL_NEVER}</a>
			</div>
			<a href="#" onclick="swap_options('{p_mask.S_ROW_COUNT}', '{p_mask.f_mask.S_ROW_COUNT}', '0', true); return false;">{L_ADVANCED_PERMISSIONS}</a><!-- IF not p_mask.S_VIEW and p_mask.f_mask.S_CUSTOM --> *<!-- ENDIF -->
		</div>
		<dl class="permissions-simple">
			<dt style="width: 20%"><label for="role{p_mask.S_ROW_COUNT}{p_mask.f_mask.S_ROW_COUNT}">{L_ROLE}:</label></dt>
			<!-- IF p_mask.f_mask.S_ROLE_OPTIONS -->
				<dd style="margin-left: 20%"><select id="role{p_mask.S_ROW_COUNT}{p_mask.f_mask.S_ROW_COUNT}" name="role[{p_mask.f_mask.UG_ID}][{p_mask.f_mask.FORUM_ID}]" onchange="set_role_settings(this.options[selectedIndex].value, 'advanced{p_mask.S_ROW_COUNT}{p_mask.f_mask.S_ROW_COUNT}'); init_colours('{p_mask.S_ROW_COUNT}{p_mask.f_mask.S_ROW_COUNT}')">{p_mask.f_mask.S_ROLE_OPTIONS}</select></dd>
			<!-- ELSE -->
				<dd>{L_NO_ROLE_AVAILABLE}</dd>
			<!-- ENDIF -->
		</dl>
	<!-- ENDIF -->

	<!-- BEGIN category -->
		<!-- IF p_mask.f_mask.category.S_FIRST_ROW -->
			<!-- IF not p_mask.S_VIEW -->
				<div class="permissions-advanced" id="advanced{p_mask.S_ROW_COUNT}{p_mask.f_mask.S_ROW_COUNT}" style="display: none;">
			<!-- ELSE -->
				<div class="permissions-advanced" id="advanced{p_mask.S_ROW_COUNT}{p_mask.f_mask.S_ROW_COUNT}">
			<!-- ENDIF -->

			<div class="permissions-category">
				<ul>
		<!-- ENDIF -->
		
		<!-- IF p_mask.f_mask.category.S_YES -->
			<li class="permissions-preset-yes<!-- IF p_mask.S_FIRST_ROW and p_mask.f_mask.S_FIRST_ROW and p_mask.f_mask.category.S_FIRST_ROW --> activetab<!-- ENDIF -->" id="tab{p_mask.S_ROW_COUNT}{p_mask.f_mask.S_ROW_COUNT}{p_mask.f_mask.category.S_ROW_COUNT}">
		<!-- ELSEIF p_mask.f_mask.category.S_NEVER -->
			<li class="permissions-preset-never<!-- IF p_mask.S_FIRST_ROW and p_mask.f_mask.S_FIRST_ROW and p_mask.f_mask.category.S_FIRST_ROW --> activetab<!-- ENDIF -->" id="tab{p_mask.S_ROW_COUNT}{p_mask.f_mask.S_ROW_COUNT}{p_mask.f_mask.category.S_ROW_COUNT}">
		<!-- ELSEIF p_mask.f_mask.category.S_NO -->
			<li class="permissions-preset-no<!-- IF p_mask.S_FIRST_ROW and p_mask.f_mask.S_FIRST_ROW and p_mask.f_mask.category.S_FIRST_ROW --> activetab<!-- ENDIF -->" id="tab{p_mask.S_ROW_COUNT}{p_mask.f_mask.S_ROW_COUNT}{p_mask.f_mask.category.S_ROW_COUNT}">
		<!-- ELSE -->
			<li class="permissions-preset-custom<!-- IF p_mask.S_FIRST_ROW and p_mask.f_mask.S_FIRST_ROW and p_mask.f_mask.category.S_FIRST_ROW --> activetab<!-- ENDIF -->" id="tab{p_mask.S_ROW_COUNT}{p_mask.f_mask.S_ROW_COUNT}{p_mask.f_mask.category.S_ROW_COUNT}">
		<!-- ENDIF -->
		<a href="#" onclick="swap_options('{p_mask.S_ROW_COUNT}', '{p_mask.f_mask.S_ROW_COUNT}', '{p_mask.f_mask.category.S_ROW_COUNT}', false<!-- IF p_mask.S_VIEW -->, true<!-- ENDIF -->); return false;"><span class="tabbg"><span class="colour"></span>{p_mask.f_mask.category.CAT_NAME}</span></a></li>
	<!-- END category -->
				</ul>
			</div>

	<!-- BEGIN category -->
		<div class="permissions-panel" id="options{p_mask.S_ROW_COUNT}{p_mask.f_mask.S_ROW_COUNT}{p_mask.f_mask.category.S_ROW_COUNT}" <!-- IF p_mask.S_FIRST_ROW and p_mask.f_mask.S_FIRST_ROW and p_mask.f_mask.category.S_FIRST_ROW --><!-- ELSE --> style="display: none;"<!-- ENDIF -->>
			<span class="corners-top"><span></span></span>
			<div class="tablewrap">
				<table id="table{p_mask.S_ROW_COUNT}{p_mask.f_mask.S_ROW_COUNT}{p_mask.f_mask.category.S_ROW_COUNT}" cellspacing="1">
				<colgroup>
					<col class="permissions-name" />
					<col class="permissions-yes" />
					<col class="permissions-no" />
					<!-- IF not p_mask.S_VIEW -->
						<col class="permissions-never" />
					<!-- ENDIF -->
				</colgroup>
				<thead>
				<tr>
					<th class="name" scope="col"><strong>{L_ACL_SETTING}</strong></th>
				<!-- IF p_mask.S_VIEW -->
					<th class="value" scope="col">{L_ACL_YES}</th>
					<th class="value" scope="col">{L_ACL_NEVER}</th>
				<!-- ELSE -->
					<th class="value permissions-yes" scope="col"><a href="#" onclick="mark_options('options{p_mask.S_ROW_COUNT}{p_mask.f_mask.S_ROW_COUNT}{p_mask.f_mask.category.S_ROW_COUNT}', 'y'); reset_role('role{p_mask.S_ROW_COUNT}{p_mask.f_mask.S_ROW_COUNT}'); set_colours('{p_mask.S_ROW_COUNT}{p_mask.f_mask.S_ROW_COUNT}{p_mask.f_mask.category.S_ROW_COUNT}', false, 'yes'); return false;">{L_ACL_YES}</a></th>
					<th class="value permissions-no" scope="col"><a href="#" onclick="mark_options('options{p_mask.S_ROW_COUNT}{p_mask.f_mask.S_ROW_COUNT}{p_mask.f_mask.category.S_ROW_COUNT}', 'u'); reset_role('role{p_mask.S_ROW_COUNT}{p_mask.f_mask.S_ROW_COUNT}'); set_colours('{p_mask.S_ROW_COUNT}{p_mask.f_mask.S_ROW_COUNT}{p_mask.f_mask.category.S_ROW_COUNT}', false, 'no'); return false;">{L_ACL_NO}</a></th>
					<th class="value permissions-never" scope="col"><a href="#" onclick="mark_options('options{p_mask.S_ROW_COUNT}{p_mask.f_mask.S_ROW_COUNT}{p_mask.f_mask.category.S_ROW_COUNT}', 'n'); reset_role('role{p_mask.S_ROW_COUNT}{p_mask.f_mask.S_ROW_COUNT}'); set_colours('{p_mask.S_ROW_COUNT}{p_mask.f_mask.S_ROW_COUNT}{p_mask.f_mask.category.S_ROW_COUNT}', false, 'never'); return false;">{L_ACL_NEVER}</a></th>
				<!-- ENDIF -->
				</tr>
				</thead>
				<tbody>
				<!-- BEGIN mask -->
					<!-- IF p_mask.f_mask.category.mask.S_ROW_COUNT is even --><tr class="bbrow4"><!-- ELSE --><tr class="bbrow3"><!-- ENDIF -->
					<th class="permissions-name<!-- IF p_mask.f_mask.category.mask.S_ROW_COUNT is even --> bbrow4<!-- ELSE --> bbrow3<!-- ENDIF -->"><!-- IF p_mask.f_mask.category.mask.U_TRACE --><a href="{p_mask.f_mask.category.mask.U_TRACE}" class="trace" onclick="popup(this.href, 750, 515, '_trace'); return false;" title="{L_TRACE_SETTING}"><img src="images/icon_trace.gif" alt="{L_TRACE_SETTING}" /></a> <!-- ENDIF -->{p_mask.f_mask.category.mask.PERMISSION}</th>
					<!-- IF p_mask.S_VIEW -->
						<td<!-- IF p_mask.f_mask.category.mask.S_YES --> class="yes"<!-- ENDIF -->>&nbsp;</td>
						<td<!-- IF p_mask.f_mask.category.mask.S_NEVER --> class="never"<!-- ENDIF -->></td>
					<!-- ELSE -->
						<td class="permissions-yes"><label for="{p_mask.f_mask.category.mask.S_FIELD_NAME}_y"><input onclick="reset_role('role{p_mask.S_ROW_COUNT}{p_mask.f_mask.S_ROW_COUNT}'); set_colours('{p_mask.S_ROW_COUNT}{p_mask.f_mask.S_ROW_COUNT}{p_mask.f_mask.category.S_ROW_COUNT}', false)" id="{p_mask.f_mask.category.mask.S_FIELD_NAME}_y" name="{p_mask.f_mask.category.mask.S_FIELD_NAME}" class="radio" type="radio"<!-- IF p_mask.f_mask.category.mask.S_YES --> checked="checked"<!-- ENDIF --> value="1" /></label></td>
						<td class="permissions-no"><label for="{p_mask.f_mask.category.mask.S_FIELD_NAME}_u"><input onclick="reset_role('role{p_mask.S_ROW_COUNT}{p_mask.f_mask.S_ROW_COUNT}'); set_colours('{p_mask.S_ROW_COUNT}{p_mask.f_mask.S_ROW_COUNT}{p_mask.f_mask.category.S_ROW_COUNT}', false)" id="{p_mask.f_mask.category.mask.S_FIELD_NAME}_u" name="{p_mask.f_mask.category.mask.S_FIELD_NAME}" class="radio" type="radio"<!-- IF p_mask.f_mask.category.mask.S_NO --> checked="checked"<!-- ENDIF --> value="-1" /></label></td>
						<td class="permissions-never"><label for="{p_mask.f_mask.category.mask.S_FIELD_NAME}_n"><input onclick="reset_role('role{p_mask.S_ROW_COUNT}{p_mask.f_mask.S_ROW_COUNT}'); set_colours('{p_mask.S_ROW_COUNT}{p_mask.f_mask.S_ROW_COUNT}{p_mask.f_mask.category.S_ROW_COUNT}', false)" id="{p_mask.f_mask.category.mask.S_FIELD_NAME}_n" name="{p_mask.f_mask.category.mask.S_FIELD_NAME}" class="radio" type="radio"<!-- IF p_mask.f_mask.category.mask.S_NEVER --> checked="checked"<!-- ENDIF --> value="0" /></label></td>
					<!-- ENDIF -->
				</tr>
				<!-- END mask -->
				</tbody>
				</table>
			</div>
			
			<!-- IF not p_mask.S_VIEW -->
			<fieldset class="quick" style="margin-left: 11px;">
				<p class="small">{L_APPLY_PERMISSIONS_EXPLAIN}</p>
				<input class="mainoption" type="submit" name="psubmit[{p_mask.f_mask.UG_ID}][{p_mask.f_mask.FORUM_ID}]" value="{L_APPLY_PERMISSIONS}" />&nbsp;
				<!-- IF .p_mask.f_mask gt 1 or .p_mask gt 1 -->
					<p class="small"><a href="#" onclick="reset_opacity(0, '{p_mask.S_ROW_COUNT}{p_mask.f_mask.S_ROW_COUNT}'); return false;">{L_MARK_ALL}</a> &bull; <a href="#" onclick="reset_opacity(1, '{p_mask.S_ROW_COUNT}{p_mask.f_mask.S_ROW_COUNT}'); return false;">{L_UNMARK_ALL}</a></p>
				<!-- ENDIF -->
			</fieldset>
		
			<!-- ENDIF -->

			<span class="corners-bottom"><span></span></span>
		</div>
	<!-- END category -->
			<div class="clearfix"></div>
	</div>
</fieldset>
<!-- END f_mask -->

<!-- END p_mask -->
