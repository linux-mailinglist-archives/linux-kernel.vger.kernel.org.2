Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48AC134FD26
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 11:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234813AbhCaJlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 05:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234121AbhCaJkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 05:40:22 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50690C061574
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 02:40:22 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id b7so29095516ejv.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 02:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PEBPHtDWRs3To8LCuwFNGPOTZk+e0qcMCe86PRgpR3E=;
        b=kZ/YCv83utmE1QDhL3WlKmDs13teHTfzaMjB8whvfXadNJT6syP95Q0G2zfid8ALjE
         j6mAlZJhb7HZCZ9iBABSkNqiOD47Z2L82MImxIUqLcOIJl5iF/vCeWcawu3jImCdbebV
         aGh7p8YYO99rNkQguGXc8/nVrkRWfqS+ruzMkX5sqOC9gFhNGTgDlwFy+EU/1x/H06LU
         nSM9Z6YURravjg1OOV5TVqThpRGQTr37cES2fq2dVnnYxxrtOesrkhJd7Ri5fJC5yOP6
         TxSAlWIcZFHbjCWzOZu+ZNM215Nf7BgH9t2IGfzaPVOagPbDnMROj6L24oqDD9RQwp8e
         m41Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PEBPHtDWRs3To8LCuwFNGPOTZk+e0qcMCe86PRgpR3E=;
        b=G/fydWauDnkuMY0W45tll1xHvCR9IpW6gQA4Z1fkrraPvK9Er3rz1ntT/k/N3/N7AJ
         dMMcKYLCi+lWo1bM15M/szuYSZwn1a/G5vPWm/DXsEEexsNsYLrA9vOWL+Z4r4y5ynND
         tBdoSV5CdN5AOGvvbc891gffSHGu6kGCEBzKjrN3yNJ2PUbf2mXxmCAIBoj5moI4P+Ic
         VW0uHpkS9WERGHZxjr+NKw8ZLtpd4ET/1H15powuhDla3gbtUtVLhP7oOOIRhcQBGOUE
         HW3npcyGu9DkZTSDTQhTo7cuUOtjQNA53lDZvE+2Nsdem+ugEdRJjrpQNa6MTLu/nrDi
         oTeQ==
X-Gm-Message-State: AOAM531KtL3wRyXFNa1RKh3HWlvzEfHCKHOFXW9GwPTB71xYbgQRm9Pm
        gLX2utQEA2jGV+RNgL67IOU=
X-Google-Smtp-Source: ABdhPJyEyU7lnl6cf6HA5pKcS2w5gMy9S1k90Si3Tu1gIdjz5couXoV3G7BsCu5Zv6HyCk1kX5zhfA==
X-Received: by 2002:a17:907:3e92:: with SMTP id hs18mr2519942ejc.396.1617183621061;
        Wed, 31 Mar 2021 02:40:21 -0700 (PDT)
Received: from agape ([5.171.73.44])
        by smtp.gmail.com with ESMTPSA id v25sm1135106edr.18.2021.03.31.02.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 02:40:20 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 05/40] staging: rtl8723bs: replace RT_TRACE with public printk wrappers in core/rtw_cmd.c
Date:   Wed, 31 Mar 2021 11:39:33 +0200
Message-Id: <4d2784349f2c22f635bf5f200025c62baa7a8108.1617183374.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617183374.git.fabioaiuto83@gmail.com>
References: <cover.1617183374.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

replace private macro RT_TRACE for tracing with in-kernel
pr_* printk wrappers

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_cmd.c | 55 +++++++++++++-----------
 1 file changed, 31 insertions(+), 24 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
index 2aaf25b48f96..63b5351d9f63 100644
--- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
+++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
@@ -221,7 +221,7 @@ int rtw_init_evt_priv(struct evt_priv *pevtpriv)
 
 void _rtw_free_evt_priv(struct	evt_priv *pevtpriv)
 {
-	RT_TRACE(_module_rtl871x_cmd_c_, _drv_info_, ("+_rtw_free_evt_priv\n"));
+	pr_info("%s+%s\n", DRIVER_PREFIX, __func__);
 
 	_cancel_workitem_sync(&pevtpriv->c2h_wk);
 	while (pevtpriv->c2h_wk_alive)
@@ -234,7 +234,7 @@ void _rtw_free_evt_priv(struct	evt_priv *pevtpriv)
 	}
 	kfree(pevtpriv->c2h_queue);
 
-	RT_TRACE(_module_rtl871x_cmd_c_, _drv_info_, ("-_rtw_free_evt_priv\n"));
+	pr_info("%s-%s\n", DRIVER_PREFIX, __func__);
 }
 
 void _rtw_free_cmd_priv(struct	cmd_priv *pcmdpriv)
@@ -299,13 +299,13 @@ struct	cmd_obj	*_rtw_dequeue_cmd(struct __queue *queue)
 
 void rtw_free_evt_priv(struct	evt_priv *pevtpriv)
 {
-	RT_TRACE(_module_rtl871x_cmd_c_, _drv_info_, ("rtw_free_evt_priv\n"));
+	pr_info("%s %s\n", DRIVER_PREFIX, __func__);
 	_rtw_free_evt_priv(pevtpriv);
 }
 
 void rtw_free_cmd_priv(struct	cmd_priv *pcmdpriv)
 {
-	RT_TRACE(_module_rtl871x_cmd_c_, _drv_info_, ("rtw_free_cmd_priv\n"));
+	pr_info("%s %s\n", DRIVER_PREFIX, __func__);
 	_rtw_free_cmd_priv(pcmdpriv);
 }
 
@@ -415,7 +415,7 @@ int rtw_cmd_thread(void *context)
 	atomic_set(&(pcmdpriv->cmdthd_running), true);
 	complete(&pcmdpriv->terminate_cmdthread_comp);
 
-	RT_TRACE(_module_rtl871x_cmd_c_, _drv_info_, ("start r871x rtw_cmd_thread !!!!\n"));
+	pr_info("%s start r871x %s !!!!\n", DRIVER_PREFIX, __func__);
 
 	while (1) {
 		if (wait_for_completion_interruptible(&pcmdpriv->cmd_queue_comp)) {
@@ -440,8 +440,7 @@ int rtw_cmd_thread(void *context)
 		}
 
 		if (rtw_register_cmd_alive(padapter) != _SUCCESS) {
-			RT_TRACE(_module_hal_xmit_c_, _drv_notice_,
-					 ("%s: wait to leave LPS_LCLK\n", __func__));
+			pr_notice("%s %s: wait to leave LPS_LCLK\n", DRIVER_PREFIX, __func__);
 			continue;
 		}
 
@@ -512,14 +511,16 @@ int rtw_cmd_thread(void *context)
 		if (pcmd->cmdcode < ARRAY_SIZE(rtw_cmd_callback)) {
 			pcmd_callback = rtw_cmd_callback[pcmd->cmdcode].callback;
 			if (pcmd_callback == NULL) {
-				RT_TRACE(_module_rtl871x_cmd_c_, _drv_info_, ("mlme_cmd_hdl(): pcmd_callback = 0x%p, cmdcode = 0x%x\n", pcmd_callback, pcmd->cmdcode));
+				pr_info("%s mlme_cmd_hdl(): pcmd_callback = 0x%p, cmdcode = 0x%x\n",
+					DRIVER_PREFIX, pcmd_callback, pcmd->cmdcode);
 				rtw_free_cmd_obj(pcmd);
 			} else {
 				/* todo: !!! fill rsp_buf to pcmd->rsp if (pcmd->rsp!= NULL) */
 				pcmd_callback(pcmd->padapter, pcmd);/* need consider that free cmd_obj in rtw_cmd_callback */
 			}
 		} else {
-			RT_TRACE(_module_rtl871x_cmd_c_, _drv_err_, ("%s: cmdcode = 0x%x callback not defined!\n", __func__, pcmd->cmdcode));
+			pr_err("%s %s: cmdcode = 0x%x callback not defined!\n",
+			       DRIVER_PREFIX, __func__, pcmd->cmdcode);
 			rtw_free_cmd_obj(pcmd);
 		}
 
@@ -583,7 +584,7 @@ u8 rtw_sitesurvey_cmd(struct adapter  *padapter, struct ndis_802_11_ssid *ssid,
 
 	rtw_free_network_queue(padapter, false);
 
-	RT_TRACE(_module_rtl871x_cmd_c_, _drv_info_, ("%s: flush network queue\n", __func__));
+	pr_info("%s %s: flush network queue\n", DRIVER_PREFIX, __func__);
 
 	init_h2fwcmd_w_parm_no_rsp(ph2c, psurveyPara, GEN_CMD_CODE(_SiteSurvey));
 
@@ -677,9 +678,11 @@ u8 rtw_createbss_cmd(struct adapter  *padapter)
 	u8 res = _SUCCESS;
 
 	if (pmlmepriv->assoc_ssid.SsidLength == 0)
-		RT_TRACE(_module_rtl871x_cmd_c_, _drv_info_, (" createbss for Any SSid:%s\n", pmlmepriv->assoc_ssid.Ssid));
+		pr_info("%s createbss for Any SSid:%s\n",
+			DRIVER_PREFIX, pmlmepriv->assoc_ssid.Ssid);
 	else
-		RT_TRACE(_module_rtl871x_cmd_c_, _drv_info_, (" createbss for SSid:%s\n", pmlmepriv->assoc_ssid.Ssid));
+		pr_info("%s createbss for SSid:%s\n",
+			DRIVER_PREFIX, pmlmepriv->assoc_ssid.Ssid);
 
 	pcmd = rtw_zmalloc(sizeof(struct cmd_obj));
 	if (pcmd == NULL) {
@@ -767,14 +770,16 @@ u8 rtw_joinbss_cmd(struct adapter  *padapter, struct wlan_network *pnetwork)
 	u8 *ptmp = NULL;
 
 	if (pmlmepriv->assoc_ssid.SsidLength == 0)
-		RT_TRACE(_module_rtl871x_cmd_c_, _drv_info_, ("+Join cmd: Any SSid\n"));
+		pr_info("%s +Join cmd: Any SSid\n", DRIVER_PREFIX);
 	else
-		RT_TRACE(_module_rtl871x_cmd_c_, _drv_notice_, ("+Join cmd: SSid =[%s]\n", pmlmepriv->assoc_ssid.Ssid));
+		pr_notice("%s +Join cmd: SSid =[%s]\n", DRIVER_PREFIX,
+			  pmlmepriv->assoc_ssid.Ssid);
 
 	pcmd = rtw_zmalloc(sizeof(struct cmd_obj));
 	if (pcmd == NULL) {
 		res = _FAIL;
-		RT_TRACE(_module_rtl871x_cmd_c_, _drv_err_, ("rtw_joinbss_cmd: memory allocate for cmd_obj fail!!!\n"));
+		pr_err("%s %s: memory allocate for cmd_obj fail!!!\n", DRIVER_PREFIX,
+		       __func__);
 		goto exit;
 	}
 	/* for IEs is fix buf size */
@@ -883,7 +888,7 @@ u8 rtw_disassoc_cmd(struct adapter *padapter, u32 deauth_timeout_ms, bool enqueu
 	struct cmd_priv *cmdpriv = &padapter->cmdpriv;
 	u8 res = _SUCCESS;
 
-	RT_TRACE(_module_rtl871x_cmd_c_, _drv_notice_, ("+rtw_disassoc_cmd\n"));
+	pr_notice("%s +%s\n", DRIVER_PREFIX, __func__);
 
 	/* prepare cmd parameter */
 	param = rtw_zmalloc(sizeof(*param));
@@ -1209,7 +1214,7 @@ u8 rtw_set_chplan_cmd(struct adapter *padapter, u8 chplan, u8 enqueue, u8 swconf
 
 	u8 res = _SUCCESS;
 
-	RT_TRACE(_module_rtl871x_cmd_c_, _drv_notice_, ("+rtw_set_chplan_cmd\n"));
+	pr_notice("%s+%s\n", DRIVER_PREFIX, __func__);
 
 	/*  check if allow software config */
 	if (swconfig && rtw_hal_is_disable_sw_channel_plan(padapter) == true) {
@@ -1981,7 +1986,7 @@ void rtw_survey_cmd_callback(struct adapter *padapter,  struct cmd_obj *pcmd)
 		_set_timer(&pmlmepriv->scan_to_timer, 1);
 	} else if (pcmd->res != H2C_SUCCESS) {
 		_set_timer(&pmlmepriv->scan_to_timer, 1);
-		RT_TRACE(_module_rtl871x_cmd_c_, _drv_err_, ("\n ********Error: MgntActrtw_set_802_11_bssid_LIST_SCAN Fail ************\n\n."));
+		pr_err("%s ********Error: MgntActrtw_set_802_11_bssid_LIST_SCAN Fail ************\n\n.", DRIVER_PREFIX);
 	}
 
 	/*  free cmd */
@@ -1997,7 +2002,7 @@ void rtw_disassoc_cmd_callback(struct adapter *padapter,  struct cmd_obj *pcmd)
 		set_fwstate(pmlmepriv, _FW_LINKED);
 		spin_unlock_bh(&pmlmepriv->lock);
 
-		RT_TRACE(_module_rtl871x_cmd_c_, _drv_err_, ("\n ***Error: disconnect_cmd_callback Fail ***\n."));
+		pr_err("%s ***Error: disconnect_cmd_callback Fail ***\n.", DRIVER_PREFIX);
 		return;
 	}
 	/*  free cmd */
@@ -2031,7 +2036,7 @@ void rtw_createbss_cmd_callback(struct adapter *padapter, struct cmd_obj *pcmd)
 		goto exit;
 
 	if ((pcmd->res != H2C_SUCCESS)) {
-		RT_TRACE(_module_rtl871x_cmd_c_, _drv_err_, ("\n ********Error: rtw_createbss_cmd_callback  Fail ************\n\n."));
+		pr_err("%s ********Error: %s Fail ************\n\n.", DRIVER_PREFIX, __func__);
 		_set_timer(&pmlmepriv->assoc_timer, 1);
 	}
 
@@ -2045,7 +2050,8 @@ void rtw_createbss_cmd_callback(struct adapter *padapter, struct cmd_obj *pcmd)
 		if (!psta) {
 			psta = rtw_alloc_stainfo(&padapter->stapriv, pnetwork->MacAddress);
 			if (psta == NULL) {
-				RT_TRACE(_module_rtl871x_cmd_c_, _drv_err_, ("\nCan't alloc sta_info when createbss_cmd_callback\n"));
+				pr_err("%s Can't alloc sta_info when createbss_cmd_callback\n",
+				       DRIVER_PREFIX);
 				goto createbss_cmd_fail;
 			}
 		}
@@ -2057,7 +2063,8 @@ void rtw_createbss_cmd_callback(struct adapter *padapter, struct cmd_obj *pcmd)
 		if (pwlan == NULL) {
 			pwlan = rtw_get_oldest_wlan_network(&pmlmepriv->scanned_queue);
 			if (pwlan == NULL) {
-				RT_TRACE(_module_rtl871x_cmd_c_, _drv_err_, ("\n Error:  can't get pwlan in rtw_joinbss_event_callback\n"));
+				pr_err("%s Error:  can't get pwlan in rtw_joinbss_event_callback\n",
+				       DRIVER_PREFIX);
 				spin_unlock_bh(&(pmlmepriv->scanned_queue.lock));
 				goto createbss_cmd_fail;
 			}
@@ -2102,7 +2109,7 @@ void rtw_setstaKey_cmdrsp_callback(struct adapter *padapter,  struct cmd_obj *pc
 	struct sta_info *psta = rtw_get_stainfo(pstapriv, psetstakey_rsp->addr);
 
 	if (psta == NULL) {
-		RT_TRACE(_module_rtl871x_cmd_c_, _drv_err_, ("\nERROR: rtw_setstaKey_cmdrsp_callback => can't get sta_info\n\n"));
+		pr_err("%s ERROR: %s => can't get sta_info\n", DRIVER_PREFIX, __func__);
 		goto exit;
 	}
 exit:
@@ -2118,7 +2125,7 @@ void rtw_setassocsta_cmdrsp_callback(struct adapter *padapter,  struct cmd_obj *
 	struct sta_info *psta = rtw_get_stainfo(pstapriv, passocsta_parm->addr);
 
 	if (psta == NULL) {
-		RT_TRACE(_module_rtl871x_cmd_c_, _drv_err_, ("\nERROR: setassocsta_cmdrsp_callbac => can't get sta_info\n\n"));
+		pr_err("%s ERROR: %s => can't get sta_info\n", DRIVER_PREFIX, __func__);
 		goto exit;
 	}
 
-- 
2.20.1

