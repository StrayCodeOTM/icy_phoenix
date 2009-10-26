<!-- IF CMS_STD_TPL -->
<!-- INCLUDE ../common/cms/page_header_std.tpl -->
<!-- ELSE -->
<!-- INCLUDE ../common/cms/page_header.tpl -->
<!-- ENDIF -->

<table class="forumline" width="100%" cellspacing="0" cellpadding="0" border="0">
<tr><th>{MESSAGE_TITLE}</th></tr>
<tr>
	<td class="row1g">
		<form action="{S_CONFIRM_ACTION}" method="post">
			{MESSAGE_TEXT}<br /><br />
			{S_HIDDEN_FIELDS}
			<input type="submit" name="confirm" value="{L_YES}" class="mainoption" />&nbsp;
			<input type="submit" name="cancel" value="{L_NO}" class="liteoption" />
		</form>
	</td>
</tr>
</table>

<br clear="all" />

<!-- IF CMS_STD_TPL -->
<!-- INCLUDE ../common/cms/page_footer_std.tpl -->
<!-- ELSE -->
<!-- INCLUDE ../common/cms/page_footer.tpl -->
<!-- ENDIF -->