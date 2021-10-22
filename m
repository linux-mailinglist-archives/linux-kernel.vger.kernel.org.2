Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A997437A33
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 17:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233500AbhJVPm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 11:42:56 -0400
Received: from mga09.intel.com ([134.134.136.24]:46227 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233222AbhJVPmv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 11:42:51 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10144"; a="229191019"
X-IronPort-AV: E=Sophos;i="5.87,173,1631602800"; 
   d="scan'208";a="229191019"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2021 08:40:33 -0700
X-IronPort-AV: E=Sophos;i="5.87,173,1631602800"; 
   d="scan'208";a="663226109"
Received: from alison-desk.jf.intel.com (HELO alison-desk) ([10.54.74.41])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2021 08:40:33 -0700
Date:   Fri, 22 Oct 2021 08:48:21 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Kushal Kothari <kushalkothari285@gmail.com>
Cc:     gregkh@linuxfoundation.org, kush19992810@gmail.com,
        outreachy-kernel@googlegroups.com, fabioaiuto83@gmail.com,
        ross.schm.dev@gmail.com, fmdefrancesco@gmail.com,
        marcocesati@gmail.com, straube.linux@gmail.com,
        philippesdixon@gmail.com, manuelpalenzuelamerino@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        mike.rapoport@gmail.com, kushalkotharitest@googlegroups.com
Subject: Re: [Outreachy kernel] [PATCH v3 1/4] staging: rtl8723bs: core:
 Remove true and false comparison
Message-ID: <20211022154821.GA464812@alison-desk>
References: <cover.1634906059.git.kushalkothari285@gmail.com>
 <7d5df4b8aacd961d0de367cbd73a8b75272652a8.1634906059.git.kushalkothari285@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d5df4b8aacd961d0de367cbd73a8b75272652a8.1634906059.git.kushalkothari285@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2021 at 06:43:18PM +0530, Kushal Kothari wrote:
> Remove comparison to true and false in if statement.
> Issue found with checkpatch.pl.
> CHECK: Using comparison to true is error prone
> CHECK: Using comparison to false is error prone
> 
> Signed-off-by: Kushal Kothari <kushalkothari285@gmail.com>
> 
> Changes in v3: Enclose the version number inside the square bracket.
> Changes in v2: Unnecessary parantheses handled in *v2 staging: rtl8723bs: core: Remove unnecessary parentheses*
> ---

Hi Kushal,

See "Versioning one patch revision" and "Versioning patchsets" in
https://kernelnewbies.org/Outreachyfirstpatch

Either remove the changelogs in Patch 1-4 or put them below the --- in each
patch. 

Alison

>  drivers/staging/rtl8723bs/core/rtw_cmd.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
> index 2624e994513f..acd4e8b1fad5 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
> @@ -371,7 +371,7 @@ void rtw_free_cmd_obj(struct cmd_obj *pcmd)
>  void rtw_stop_cmd_thread(struct adapter *adapter)
>  {
>  	if (adapter->cmdThread &&
> -		atomic_read(&(adapter->cmdpriv.cmdthd_running)) == true &&
> +		atomic_read(&(adapter->cmdpriv.cmdthd_running)) &&
>  		adapter->cmdpriv.stop_req == 0) {
>  		adapter->cmdpriv.stop_req = 1;
>  		complete(&adapter->cmdpriv.cmd_queue_comp);
> @@ -542,7 +542,7 @@ u8 rtw_sitesurvey_cmd(struct adapter  *padapter, struct ndis_802_11_ssid *ssid,
>  	struct cmd_priv 	*pcmdpriv = &padapter->cmdpriv;
>  	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
>  
> -	if (check_fwstate(pmlmepriv, _FW_LINKED) == true)
> +	if (check_fwstate(pmlmepriv, _FW_LINKED))
>  		rtw_lps_ctrl_wk_cmd(padapter, LPS_CTRL_SCAN, 1);
>  
>  	ph2c = rtw_zmalloc(sizeof(struct cmd_obj));
> @@ -775,7 +775,7 @@ u8 rtw_joinbss_cmd(struct adapter  *padapter, struct wlan_network *pnetwork)
>  	/*  If not,  we have to copy the connecting AP's MAC address to it so that */
>  	/*  the driver just has the bssid information for PMKIDList searching. */
>  
> -	if (pmlmepriv->assoc_by_bssid == false)
> +	if (!pmlmepriv->assoc_by_bssid)
>  		memcpy(&pmlmepriv->assoc_bssid[0], &pnetwork->network.mac_address[0], ETH_ALEN);
>  
>  	psecnetwork->ie_length = rtw_restruct_sec_ie(padapter, &pnetwork->network.ies[0], &psecnetwork->ies[0], pnetwork->network.ie_length);
> @@ -1164,7 +1164,7 @@ u8 rtw_set_chplan_cmd(struct adapter *padapter, u8 chplan, u8 enqueue, u8 swconf
>  	u8 res = _SUCCESS;
>  
>  	/*  check if allow software config */
> -	if (swconfig && rtw_hal_is_disable_sw_channel_plan(padapter) == true) {
> +	if (swconfig && rtw_hal_is_disable_sw_channel_plan(padapter)) {
>  		res = _FAIL;
>  		goto exit;
>  	}
> @@ -1250,7 +1250,7 @@ u8 traffic_status_watchdog(struct adapter *padapter, u8 from_timer)
>  	/*  */
>  	/*  Determine if our traffic is busy now */
>  	/*  */
> -	if ((check_fwstate(pmlmepriv, _FW_LINKED) == true)
> +	if ((check_fwstate(pmlmepriv, _FW_LINKED))
>  		/*&& !MgntInitAdapterInProgress(pMgntInfo)*/) {
>  		/*  if we raise bBusyTraffic in last watchdog, using lower threshold. */
>  		if (pmlmepriv->LinkDetectInfo.bBusyTraffic)
> @@ -1342,7 +1342,7 @@ static void dynamic_chk_wk_hdl(struct adapter *padapter)
>  
>  	pmlmepriv = &(padapter->mlmepriv);
>  
> -	if (check_fwstate(pmlmepriv, WIFI_AP_STATE) == true)
> +	if (check_fwstate(pmlmepriv, WIFI_AP_STATE))
>  		expire_timeout_chk(padapter);
>  
>  	/* for debug purpose */
> @@ -1377,8 +1377,8 @@ void lps_ctrl_wk_hdl(struct adapter *padapter, u8 lps_ctrl_type)
>  	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
>  	u8 mstatus;
>  
> -	if ((check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE) == true)
> -		|| (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE) == true)) {
> +	if ((check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE)) ||
> +		(check_fwstate(pmlmepriv, WIFI_ADHOC_STATE))) {
>  		return;
>  	}
>  
> @@ -1386,7 +1386,7 @@ void lps_ctrl_wk_hdl(struct adapter *padapter, u8 lps_ctrl_type)
>  	case LPS_CTRL_SCAN:
>  		hal_btcoex_ScanNotify(padapter, true);
>  
> -		if (check_fwstate(pmlmepriv, _FW_LINKED) == true) {
> +		if (check_fwstate(pmlmepriv, _FW_LINKED)) {
>  			/*  connect */
>  			LPS_Leave(padapter, "LPS_CTRL_SCAN");
>  		}
> @@ -1512,7 +1512,7 @@ static void rtw_lps_change_dtim_hdl(struct adapter *padapter, u8 dtim)
>  	if (dtim <= 0 || dtim > 16)
>  		return;
>  
> -	if (hal_btcoex_IsBtControlLps(padapter) == true)
> +	if (hal_btcoex_IsBtControlLps(padapter))
>  		return;
>  
>  	mutex_lock(&pwrpriv->lock);
> @@ -1840,7 +1840,7 @@ static void c2h_wk_callback(struct work_struct *work)
>  			continue;
>  		}
>  
> -		if (ccx_id_filter(c2h_evt) == true) {
> +		if (ccx_id_filter(c2h_evt)) {
>  			/* Handle CCX report here */
>  			rtw_hal_c2h_handler(adapter, c2h_evt);
>  			kfree(c2h_evt);
> -- 
> 2.25.1
> 
> -- 
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/7d5df4b8aacd961d0de367cbd73a8b75272652a8.1634906059.git.kushalkothari285%40gmail.com.
