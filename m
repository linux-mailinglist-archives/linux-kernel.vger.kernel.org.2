Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3E639C9FB
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 18:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbhFERBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 13:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbhFERBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 13:01:13 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD767C061766;
        Sat,  5 Jun 2021 09:59:24 -0700 (PDT)
Received: from dslb-188-096-145-192.188.096.pools.vodafone-ip.de ([188.96.145.192] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1lpZdo-0002hw-9k; Sat, 05 Jun 2021 18:59:20 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 2/9] staging: rtl8188eu: remove RT_TRACE and DBG_88E prints from rtw_cmd.c
Date:   Sat,  5 Jun 2021 18:58:51 +0200
Message-Id: <20210605165858.3175-2-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210605165858.3175-1-martin@kaiser.cx>
References: <20210605165858.3175-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rtl8188eu driver implements driver-specific debug prints which use
their own definitions for debug levels. By default, these prints are
disabled. You'd have to modify the code or set a module parameter to
enable them.

The rtl8723bs staging driver has already removed those prints. We should
do the same. Let's start with removing RT_TRACE and DBG_88E prints from
rtw_cmd.c.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/rtl8188eu/core/rtw_cmd.c | 77 ++----------------------
 1 file changed, 4 insertions(+), 73 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_cmd.c b/drivers/staging/rtl8188eu/core/rtw_cmd.c
index 64e83684fb81..e8d6978ad477 100644
--- a/drivers/staging/rtl8188eu/core/rtw_cmd.c
+++ b/drivers/staging/rtl8188eu/core/rtw_cmd.c
@@ -37,7 +37,7 @@ static struct _cmd_callback rtw_cmd_callback[] = {
 	{_SiteSurvey_CMD_, &rtw_survey_cmd_callback},
 	{_SetAuth_CMD_, NULL},
 	{_SetKey_CMD_, NULL},
-	{_SetStaKey_CMD_, &rtw_setstaKey_cmdrsp_callback},
+	{_SetStaKey_CMD_, NULL},
 	{_SetAssocSta_CMD_, &rtw_setassocsta_cmdrsp_callback},
 	{_AddBAReq_CMD_, NULL},
 	{_SetChannel_CMD_, NULL},
@@ -183,17 +183,9 @@ int rtw_cmd_thread(void *context)
 
 	pcmdpriv->cmdthd_running = true;
 
-	RT_TRACE(_module_rtl871x_cmd_c_, _drv_info_,
-		 ("start r871x %s !!!!\n", __func__));
-
 	while (1) {
-		if (padapter->bDriverStopped ||
-		    padapter->bSurpriseRemoved) {
-			DBG_88E("%s: DriverStopped(%d) SurpriseRemoved(%d) break at line %d\n",
-				__func__, padapter->bDriverStopped,
-				padapter->bSurpriseRemoved, __LINE__);
+		if (padapter->bDriverStopped || padapter->bSurpriseRemoved)
 			break;
-		}
 
 		pcmd = rtw_dequeue_cmd(&pcmdpriv->cmd_queue);
 		if (!pcmd) {
@@ -222,18 +214,10 @@ int rtw_cmd_thread(void *context)
 		/* call callback function for post-processed */
 		if (pcmd->cmdcode < ARRAY_SIZE(rtw_cmd_callback)) {
 			pcmd_callback = rtw_cmd_callback[pcmd->cmdcode].callback;
-			if (!pcmd_callback) {
-				RT_TRACE(_module_rtl871x_cmd_c_, _drv_info_,
-					 ("mlme_cmd_hdl(): pcmd_callback = 0x%p, cmdcode = 0x%x\n",
-					  pcmd_callback, pcmd->cmdcode));
-			} else {
+			if (pcmd_callback) {
 				/* todo: !!! fill rsp_buf to pcmd->rsp if (pcmd->rsp!= NULL) */
 				pcmd_callback(pcmd->padapter, pcmd);
 			}
-		} else {
-			RT_TRACE(_module_rtl871x_cmd_c_, _drv_err_,
-				 ("%s: cmdcode = 0x%x callback not defined!\n",
-				  __func__, pcmd->cmdcode));
 		}
 		rtw_free_cmd_obj(pcmd);
 
@@ -281,8 +265,6 @@ u8 rtw_sitesurvey_cmd(struct adapter  *padapter, struct ndis_802_11_ssid *ssid,
 
 	rtw_free_network_queue(padapter, false);
 
-	RT_TRACE(_module_rtl871x_cmd_c_, _drv_info_, ("%s: flush network queue\n", __func__));
-
 	init_h2fwcmd_w_parm_no_rsp(ph2c, psurveyPara, _SiteSurvey_CMD_);
 
 	psurveyPara->scan_mode = pmlmepriv->scan_mode;
@@ -341,19 +323,11 @@ u8 rtw_createbss_cmd(struct adapter  *padapter)
 {
 	struct cmd_obj *pcmd;
 	struct cmd_priv	*pcmdpriv = &padapter->cmdpriv;
-	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct wlan_bssid_ex *pdev_network = &padapter->registrypriv.dev_network;
 	u8	res = _SUCCESS;
 
 	led_control_8188eu(padapter, LED_CTL_START_TO_LINK);
 
-	if (pmlmepriv->assoc_ssid.ssid_length == 0)
-		RT_TRACE(_module_rtl871x_cmd_c_, _drv_info_,
-			 (" createbss for Any SSid:%s\n", pmlmepriv->assoc_ssid.ssid));
-	else
-		RT_TRACE(_module_rtl871x_cmd_c_, _drv_info_,
-			 (" createbss for SSid:%s\n", pmlmepriv->assoc_ssid.ssid));
-
 	pcmd = kzalloc(sizeof(*pcmd), GFP_ATOMIC);
 	if (!pcmd) {
 		res = _FAIL;
@@ -391,12 +365,6 @@ u8 rtw_joinbss_cmd(struct adapter  *padapter, struct wlan_network *pnetwork)
 
 	led_control_8188eu(padapter, LED_CTL_START_TO_LINK);
 
-	if (pmlmepriv->assoc_ssid.ssid_length == 0)
-		RT_TRACE(_module_rtl871x_cmd_c_, _drv_info_, ("+Join cmd: Any SSid\n"));
-	else
-		RT_TRACE(_module_rtl871x_cmd_c_, _drv_notice_,
-			 ("+Join cmd: SSid =[%s]\n", pmlmepriv->assoc_ssid.ssid));
-
 	pcmd = kzalloc(sizeof(*pcmd), GFP_ATOMIC);
 	if (!pcmd) {
 		res = _FAIL;
@@ -427,9 +395,6 @@ u8 rtw_joinbss_cmd(struct adapter  *padapter, struct wlan_network *pnetwork)
 
 		res = _FAIL;
 
-		RT_TRACE(_module_rtl871x_cmd_c_, _drv_err_,
-			 ("%s :psecnetwork == NULL!!!\n", __func__));
-
 		goto exit;
 	}
 
@@ -501,8 +466,6 @@ u8 rtw_joinbss_cmd(struct adapter  *padapter, struct wlan_network *pnetwork)
 	else
 		padapter->pwrctrlpriv.smart_ps = padapter->registrypriv.smart_ps;
 
-	DBG_88E("%s: smart_ps =%d\n", __func__, padapter->pwrctrlpriv.smart_ps);
-
 	pcmd->cmdsz = get_wlan_bssid_ex_sz(psecnetwork);/* get cmdsz before endian conversion */
 
 	INIT_LIST_HEAD(&pcmd->list);
@@ -525,8 +488,6 @@ u8 rtw_disassoc_cmd(struct adapter *padapter, u32 deauth_timeout_ms, bool enqueu
 	struct cmd_priv *cmdpriv = &padapter->cmdpriv;
 	u8 res = _SUCCESS;
 
-	RT_TRACE(_module_rtl871x_cmd_c_, _drv_notice_, ("+%s\n", __func__));
-
 	/* prepare cmd parameter */
 	param = kzalloc(sizeof(*param), GFP_ATOMIC);
 	if (!param) {
@@ -744,8 +705,6 @@ u8 rtw_set_chplan_cmd(struct adapter *padapter, u8 chplan, u8 enqueue)
 
 	u8	res = _SUCCESS;
 
-	RT_TRACE(_module_rtl871x_cmd_c_, _drv_notice_, ("+%s\n", __func__));
-
 	/* check input parameter */
 	if (!rtw_is_channel_plan_valid(chplan)) {
 		res = _FAIL;
@@ -1171,8 +1130,6 @@ void rtw_survey_cmd_callback(struct adapter *padapter,  struct cmd_obj *pcmd)
 	} else if (pcmd->res != H2C_SUCCESS) {
 		mod_timer(&pmlmepriv->scan_to_timer,
 			  jiffies + msecs_to_jiffies(1));
-		RT_TRACE(_module_rtl871x_cmd_c_, _drv_err_,
-			 ("\n ********Error: MgntActrtw_set_802_11_bssid_LIST_SCAN Fail ************\n\n."));
 	}
 }
 
@@ -1184,9 +1141,6 @@ void rtw_disassoc_cmd_callback(struct adapter *padapter, struct cmd_obj *pcmd)
 		spin_lock_bh(&pmlmepriv->lock);
 		set_fwstate(pmlmepriv, _FW_LINKED);
 		spin_unlock_bh(&pmlmepriv->lock);
-
-		RT_TRACE(_module_rtl871x_cmd_c_, _drv_err_,
-			 ("\n ***Error: disconnect_cmd_callback Fail ***\n."));
 	}
 }
 
@@ -1200,8 +1154,6 @@ void rtw_joinbss_cmd_callback(struct adapter *padapter,  struct cmd_obj *pcmd)
 		mod_timer(&pmlmepriv->assoc_timer,
 			  jiffies + msecs_to_jiffies(1));
 	} else if (pcmd->res != H2C_SUCCESS) {
-		RT_TRACE(_module_rtl871x_cmd_c_, _drv_err_,
-			 ("********Error:rtw_select_and_join_from_scanned_queue Wait Sema  Fail ************\n"));
 		mod_timer(&pmlmepriv->assoc_timer,
 			  jiffies + msecs_to_jiffies(1));
 	}
@@ -1216,8 +1168,6 @@ void rtw_createbss_cmd_callback(struct adapter *padapter, struct cmd_obj *pcmd)
 	struct wlan_network *tgt_network = &pmlmepriv->cur_network;
 
 	if (pcmd->res != H2C_SUCCESS) {
-		RT_TRACE(_module_rtl871x_cmd_c_, _drv_err_,
-			 ("\n **** Error: %s  Fail ****\n\n.", __func__));
 		mod_timer(&pmlmepriv->assoc_timer,
 			  jiffies + msecs_to_jiffies(1));
 	}
@@ -1231,8 +1181,6 @@ void rtw_createbss_cmd_callback(struct adapter *padapter, struct cmd_obj *pcmd)
 		if (!psta) {
 			psta = rtw_alloc_stainfo(&padapter->stapriv, pnetwork->MacAddress);
 			if (!psta) {
-				RT_TRACE(_module_rtl871x_cmd_c_, _drv_err_,
-					 ("\nCan't alloc sta_info when createbss_cmd_callback\n"));
 				goto createbss_cmd_fail;
 			}
 		}
@@ -1244,8 +1192,6 @@ void rtw_createbss_cmd_callback(struct adapter *padapter, struct cmd_obj *pcmd)
 		if (!pwlan) {
 			pwlan = rtw_get_oldest_wlan_network(&pmlmepriv->scanned_queue);
 			if (!pwlan) {
-				RT_TRACE(_module_rtl871x_cmd_c_, _drv_err_,
-					 ("\n Error:  can't get pwlan in rtw_joinbss_event_callback\n"));
 				spin_unlock_bh(&pmlmepriv->scanned_queue.lock);
 				goto createbss_cmd_fail;
 			}
@@ -1273,18 +1219,6 @@ void rtw_createbss_cmd_callback(struct adapter *padapter, struct cmd_obj *pcmd)
 	spin_unlock_bh(&pmlmepriv->lock);
 }
 
-void rtw_setstaKey_cmdrsp_callback(struct adapter *padapter,  struct cmd_obj *pcmd)
-{
-	struct sta_priv *pstapriv = &padapter->stapriv;
-	struct set_stakey_rsp *psetstakey_rsp = (struct set_stakey_rsp *)(pcmd->rsp);
-	struct sta_info *psta = rtw_get_stainfo(pstapriv, psetstakey_rsp->addr);
-
-	if (!psta) {
-		RT_TRACE(_module_rtl871x_cmd_c_, _drv_err_,
-			 ("\nERROR: %s => can't get sta_info\n\n", __func__));
-	}
-}
-
 void rtw_setassocsta_cmdrsp_callback(struct adapter *padapter,  struct cmd_obj *pcmd)
 {
 	struct sta_priv *pstapriv = &padapter->stapriv;
@@ -1293,11 +1227,8 @@ void rtw_setassocsta_cmdrsp_callback(struct adapter *padapter,  struct cmd_obj *
 	struct set_assocsta_rsp *passocsta_rsp = (struct set_assocsta_rsp *)(pcmd->rsp);
 	struct sta_info *psta = rtw_get_stainfo(pstapriv, passocsta_parm->addr);
 
-	if (!psta) {
-		RT_TRACE(_module_rtl871x_cmd_c_, _drv_err_,
-			 ("\nERROR: %s => can't get sta_info\n\n", __func__));
+	if (!psta)
 		return;
-	}
 
 	psta->aid = passocsta_rsp->cam_id;
 	psta->mac_id = passocsta_rsp->cam_id;
-- 
2.20.1

