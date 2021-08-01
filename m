Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD0133DCD21
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Aug 2021 21:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbhHATEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 15:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbhHATEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 15:04:51 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7ECC0613D5
        for <linux-kernel@vger.kernel.org>; Sun,  1 Aug 2021 12:04:43 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id b13so7930171wrs.3
        for <linux-kernel@vger.kernel.org>; Sun, 01 Aug 2021 12:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+bHzFqlCEBl9DPFBvDoZPn3VBvm/ryyAOajFQrlee24=;
        b=03Y9WCc+azymkvQqJam8QU05fZL2/7VWEJ0UpFHr87pWj9fpxRW92cqyFN1fKGGF6P
         XeNxFD43LGq/ZZGEMB07VmMVzJHL9954oK8tkzAIjwwLkpBPDbBQCDuQTV6MpG6dHpIc
         kVYIPDmEZGVBq2g1CF11hGHKks5VVTiCVlNsd87oEbNTr8WbP+zuRO0bGgbofWMDXz2Z
         uWnJfIyzSehj35DmAP25ffxOcHdpCZiU7+e5TV0gRqP2f4rKEAo1HLepatz1RlBhy9lE
         UcMIkkdh1ohgEATu6l494xPE3r+6Am6g0iwEFF3t88SzFYsKeg7yleITYRTNN0WrWJnb
         aQ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+bHzFqlCEBl9DPFBvDoZPn3VBvm/ryyAOajFQrlee24=;
        b=XiKKnh+PCMvDfcvkvluxpX3Ht6l3KsjuWdmUtLUovyZE7dVlXOF+33UDfsBB1lDmZj
         hXpCidWLYZrrmuSpD1QU1sNmeLe+EA5PiJPTL5jgLx0UXruQ/wOfYgazZW8Q1EyipxbU
         DZuh5peo19E/3ha3WPz0LU4R1L6Q+sZEOzlx9yvHMuup1eMviEtobfX6OzmgcWEU02DP
         NjAeVlKV9Alb5Oz6qmFOOCctRbPQOjCdoElCcK/aXICIMXVy43cPmGYVYmqdRn4sXrn3
         PMtsKmQYJBGckkRO7uRogrZd32sLEJ3I4NGTCW7cdKArImKB02R5BnPCJxdLeSnLWfc6
         VtsQ==
X-Gm-Message-State: AOAM530R5PpxuFxi1xefniaLRJsnJoLQpzeF+xnWja4+baBSZM2jhtSg
        aD7Kw5f/gcbvzixEqXp4UKsVaA==
X-Google-Smtp-Source: ABdhPJwWShi9rHzrBZdmT0zVhTQmwM58V8T7jX09jjlcJv+kDh0hfkMMkeaH+Fb+KN+ApAzdGx0xjg==
X-Received: by 2002:adf:f5d1:: with SMTP id k17mr14028728wrp.123.1627844680686;
        Sun, 01 Aug 2021 12:04:40 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id c10sm8196026wmb.40.2021.08.01.12.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Aug 2021 12:04:40 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, martin@kaiser.cx
Subject: [PATCH 01/15] staging: r8188eu: remove RT_TRACE calls from core/rtw_cmd.c
Date:   Sun,  1 Aug 2021 20:04:23 +0100
Message-Id: <20210801190437.82017-2-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210801190437.82017-1-phil@philpotter.co.uk>
References: <20210801190437.82017-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove RT_TRACE macro calls from core/rtw_cmd.c, so that ultimately the
macro definition itself can eventually be removed.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/core/rtw_cmd.c | 64 +++-----------------------
 1 file changed, 7 insertions(+), 57 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index 4e17972ee66e..aad69078f67d 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -77,8 +77,6 @@ int _rtw_init_evt_priv(struct evt_priv *pevtpriv)
 void rtw_free_evt_priv(struct	evt_priv *pevtpriv)
 {
 
-	RT_TRACE(_module_rtl871x_cmd_c_, _drv_info_, ("+rtw_free_evt_priv\n"));
-
 	_cancel_workitem_sync(&pevtpriv->c2h_wk);
 	while (pevtpriv->c2h_wk_alive)
 		rtw_msleep_os(10);
@@ -88,8 +86,6 @@ void rtw_free_evt_priv(struct	evt_priv *pevtpriv)
 		if (c2h != NULL && c2h != (void *)pevtpriv)
 			kfree(c2h);
 	}
-	RT_TRACE(_module_rtl871x_cmd_c_, _drv_info_, ("-rtw_free_evt_priv\n"));
-
 }
 
 void _rtw_free_cmd_priv (struct	cmd_priv *pcmdpriv)
@@ -173,10 +169,7 @@ u32	rtw_init_evt_priv (struct	evt_priv *pevtpriv)
 
 void rtw_free_cmd_priv(struct	cmd_priv *pcmdpriv)
 {
-
-	RT_TRACE(_module_rtl871x_cmd_c_, _drv_info_, ("rtw_free_cmd_priv\n"));
 	_rtw_free_cmd_priv(pcmdpriv);
-
 }
 
 static int rtw_cmd_filter(struct cmd_priv *pcmdpriv, struct cmd_obj *cmd_obj)
@@ -282,8 +275,6 @@ int rtw_cmd_thread(void *context)
 	pcmdpriv->cmdthd_running = true;
 	up(&pcmdpriv->terminate_cmdthread_sema);
 
-	RT_TRACE(_module_rtl871x_cmd_c_, _drv_info_, ("start r871x rtw_cmd_thread !!!!\n"));
-
 	while (1) {
 		if (_rtw_down_sema(&pcmdpriv->cmd_queue_sema) == _FAIL)
 			break;
@@ -337,15 +328,12 @@ int rtw_cmd_thread(void *context)
 		/* call callback function for post-processed */
 		if (pcmd->cmdcode < ARRAY_SIZE(rtw_cmd_callback)) {
 			pcmd_callback = rtw_cmd_callback[pcmd->cmdcode].callback;
-			if (pcmd_callback == NULL) {
-				RT_TRACE(_module_rtl871x_cmd_c_, _drv_info_, ("mlme_cmd_hdl(): pcmd_callback = 0x%p, cmdcode = 0x%x\n", pcmd_callback, pcmd->cmdcode));
+			if (pcmd_callback == NULL)
 				rtw_free_cmd_obj(pcmd);
-			} else {
+			else
 				/* todo: !!! fill rsp_buf to pcmd->rsp if (pcmd->rsp!= NULL) */
 				pcmd_callback(pcmd->padapter, pcmd);/* need conider that free cmd_obj in rtw_cmd_callback */
-			}
 		} else {
-			RT_TRACE(_module_rtl871x_cmd_c_, _drv_err_, ("%s: cmdcode = 0x%x callback not defined!\n", __func__, pcmd->cmdcode));
 			rtw_free_cmd_obj(pcmd);
 		}
 
@@ -437,8 +425,6 @@ u8 rtw_sitesurvey_cmd(struct adapter  *padapter, struct ndis_802_11_ssid *ssid,
 
 	rtw_free_network_queue(padapter, false);
 
-	RT_TRACE(_module_rtl871x_cmd_c_, _drv_info_, ("%s: flush network queue\n", __func__));
-
 	init_h2fwcmd_w_parm_no_rsp(ph2c, psurveyPara, GEN_CMD_CODE(_SiteSurvey));
 
 	/* psurveyPara->bsslimit = 48; */
@@ -579,8 +565,6 @@ u8 rtw_setphy_cmd(struct adapter *padapter, u8 modem, u8 ch)
 
 	init_h2fwcmd_w_parm_no_rsp(ph2c, psetphypara, _SetPhy_CMD_);
 
-	RT_TRACE(_module_rtl871x_cmd_c_, _drv_info_, ("CH =%d, modem =%d", ch, modem));
-
 	psetphypara->modem = modem;
 	psetphypara->rfchannel = ch;
 
@@ -756,11 +740,6 @@ u8 rtw_createbss_cmd(struct adapter  *padapter)
 
 	rtw_led_control(padapter, LED_CTL_START_TO_LINK);
 
-	if (pmlmepriv->assoc_ssid.SsidLength == 0)
-		RT_TRACE(_module_rtl871x_cmd_c_, _drv_info_, (" createbss for Any SSid:%s\n", pmlmepriv->assoc_ssid.Ssid));
-	else
-		RT_TRACE(_module_rtl871x_cmd_c_, _drv_info_, (" createbss for SSid:%s\n", pmlmepriv->assoc_ssid.Ssid));
-
 	pcmd = kzalloc(sizeof(struct cmd_obj), GFP_KERNEL);
 	if (pcmd == NULL) {
 		res = _FAIL;
@@ -824,16 +803,9 @@ u8 rtw_joinbss_cmd(struct adapter  *padapter, struct wlan_network *pnetwork)
 
 	rtw_led_control(padapter, LED_CTL_START_TO_LINK);
 
-	if (pmlmepriv->assoc_ssid.SsidLength == 0) {
-		RT_TRACE(_module_rtl871x_cmd_c_, _drv_info_, ("+Join cmd: Any SSid\n"));
-	} else {
-		RT_TRACE(_module_rtl871x_cmd_c_, _drv_notice_, ("+Join cmd: SSid =[%s]\n", pmlmepriv->assoc_ssid.Ssid));
-	}
-
 	pcmd = kzalloc(sizeof(struct cmd_obj), GFP_ATOMIC);
 	if (pcmd == NULL) {
 		res = _FAIL;
-		RT_TRACE(_module_rtl871x_cmd_c_, _drv_err_, ("rtw_joinbss_cmd: memory allocate for cmd_obj fail!!!\n"));
 		goto exit;
 	}
 	/* for IEs is fix buf size */
@@ -862,8 +834,6 @@ u8 rtw_joinbss_cmd(struct adapter  *padapter, struct wlan_network *pnetwork)
 
 		res = _FAIL;
 
-		RT_TRACE(_module_rtl871x_cmd_c_, _drv_err_, ("rtw_joinbss_cmd :psecnetwork == NULL!!!\n"));
-
 		goto exit;
 	}
 
@@ -950,8 +920,6 @@ u8 rtw_disassoc_cmd(struct adapter *padapter, u32 deauth_timeout_ms, bool enqueu
 	struct cmd_priv *cmdpriv = &padapter->cmdpriv;
 	u8 res = _SUCCESS;
 
-	RT_TRACE(_module_rtl871x_cmd_c_, _drv_notice_, ("+rtw_disassoc_cmd\n"));
-
 	/* prepare cmd parameter */
 	param = kzalloc(sizeof(*param), GFP_ATOMIC);
 	if (param == NULL) {
@@ -1360,8 +1328,6 @@ u8 rtw_set_chplan_cmd(struct adapter *padapter, u8 chplan, u8 enqueue)
 
 	u8	res = _SUCCESS;
 
-	RT_TRACE(_module_rtl871x_cmd_c_, _drv_notice_, ("+rtw_set_chplan_cmd\n"));
-
 	/* check input parameter */
 	if (!rtw_is_channel_plan_valid(chplan)) {
 		res = _FAIL;
@@ -1413,8 +1379,6 @@ u8 rtw_led_blink_cmd(struct adapter *padapter, struct LED_871x *pLed)
 
 	u8	res = _SUCCESS;
 
-	RT_TRACE(_module_rtl871x_cmd_c_, _drv_notice_, ("+rtw_led_blink_cmd\n"));
-
 	pcmdobj = kzalloc(sizeof(struct cmd_obj), GFP_ATOMIC);
 	if (pcmdobj == NULL) {
 		res = _FAIL;
@@ -1446,8 +1410,6 @@ u8 rtw_set_csa_cmd(struct adapter *padapter, u8 new_ch_no)
 
 	u8	res = _SUCCESS;
 
-	RT_TRACE(_module_rtl871x_cmd_c_, _drv_notice_, ("+rtw_set_csa_cmd\n"));
-
 	pcmdobj = kzalloc(sizeof(struct cmd_obj), GFP_ATOMIC);
 	if (pcmdobj == NULL) {
 		res = _FAIL;
@@ -2038,9 +2000,8 @@ void rtw_survey_cmd_callback(struct adapter *padapter,  struct cmd_obj *pcmd)
 		/* TODO: cancel timer and do timeout handler directly... */
 		/* need to make timeout handlerOS independent */
 		_set_timer(&pmlmepriv->scan_to_timer, 1);
-		} else if (pcmd->res != H2C_SUCCESS) {
+	} else if (pcmd->res != H2C_SUCCESS) {
 		_set_timer(&pmlmepriv->scan_to_timer, 1);
-		RT_TRACE(_module_rtl871x_cmd_c_, _drv_err_, ("\n ********Error: MgntActrtw_set_802_11_bssid_LIST_SCAN Fail ************\n\n."));
 	}
 
 	/*  free cmd */
@@ -2056,7 +2017,6 @@ void rtw_disassoc_cmd_callback(struct adapter *padapter, struct cmd_obj *pcmd)
 		set_fwstate(pmlmepriv, _FW_LINKED);
 		spin_unlock_bh(&pmlmepriv->lock);
 
-		RT_TRACE(_module_rtl871x_cmd_c_, _drv_err_, ("\n ***Error: disconnect_cmd_callback Fail ***\n."));
 		return;
 	} else /* clear bridge database */
 		nat25_db_cleanup(padapter);
@@ -2074,7 +2034,6 @@ void rtw_joinbss_cmd_callback(struct adapter *padapter,  struct cmd_obj *pcmd)
 		/* need to make timeout handlerOS independent */
 		_set_timer(&pmlmepriv->assoc_timer, 1);
 	} else if (pcmd->res != H2C_SUCCESS) {
-		RT_TRACE(_module_rtl871x_cmd_c_, _drv_err_, ("********Error:rtw_select_and_join_from_scanned_queue Wait Sema  Fail ************\n"));
 		_set_timer(&pmlmepriv->assoc_timer, 1);
 	}
 
@@ -2090,10 +2049,8 @@ void rtw_createbss_cmd_callback(struct adapter *padapter, struct cmd_obj *pcmd)
 	struct wlan_bssid_ex *pnetwork = (struct wlan_bssid_ex *)pcmd->parmbuf;
 	struct wlan_network *tgt_network = &(pmlmepriv->cur_network);
 
-	if ((pcmd->res != H2C_SUCCESS)) {
-		RT_TRACE(_module_rtl871x_cmd_c_, _drv_err_, ("\n ********Error: rtw_createbss_cmd_callback  Fail ************\n\n."));
+	if ((pcmd->res != H2C_SUCCESS))
 		_set_timer(&pmlmepriv->assoc_timer, 1);
-	}
 
 	_cancel_timer(&pmlmepriv->assoc_timer, &timer_cancelled);
 
@@ -2103,10 +2060,8 @@ void rtw_createbss_cmd_callback(struct adapter *padapter, struct cmd_obj *pcmd)
 		psta = rtw_get_stainfo(&padapter->stapriv, pnetwork->MacAddress);
 		if (!psta) {
 			psta = rtw_alloc_stainfo(&padapter->stapriv, pnetwork->MacAddress);
-			if (psta == NULL) {
-				RT_TRACE(_module_rtl871x_cmd_c_, _drv_err_, ("\nCan't alloc sta_info when createbss_cmd_callback\n"));
+			if (psta == NULL)
 				goto createbss_cmd_fail ;
-			}
 		}
 
 		rtw_indicate_connect(padapter);
@@ -2117,7 +2072,6 @@ void rtw_createbss_cmd_callback(struct adapter *padapter, struct cmd_obj *pcmd)
 		if (pwlan == NULL) {
 			pwlan = rtw_get_oldest_wlan_network(&pmlmepriv->scanned_queue);
 			if (pwlan == NULL) {
-				RT_TRACE(_module_rtl871x_cmd_c_, _drv_err_, ("\n Error:  can't get pwlan in rtw_joinbss_event_callback\n"));
 				spin_unlock_bh(&(pmlmepriv->scanned_queue.lock));
 				goto createbss_cmd_fail;
 			}
@@ -2151,10 +2105,8 @@ void rtw_setstaKey_cmdrsp_callback(struct adapter *padapter,  struct cmd_obj *pc
 	struct set_stakey_rsp *psetstakey_rsp = (struct set_stakey_rsp *)(pcmd->rsp);
 	struct sta_info *psta = rtw_get_stainfo(pstapriv, psetstakey_rsp->addr);
 
-	if (psta == NULL) {
-		RT_TRACE(_module_rtl871x_cmd_c_, _drv_err_, ("\nERROR: rtw_setstaKey_cmdrsp_callback => can't get sta_info\n\n"));
+	if (psta == NULL)
 		goto exit;
-	}
 exit:
 	rtw_free_cmd_obj(pcmd);
 
@@ -2168,10 +2120,8 @@ void rtw_setassocsta_cmdrsp_callback(struct adapter *padapter,  struct cmd_obj *
 	struct set_assocsta_rsp *passocsta_rsp = (struct set_assocsta_rsp *)(pcmd->rsp);
 	struct sta_info *psta = rtw_get_stainfo(pstapriv, passocsta_parm->addr);
 
-	if (psta == NULL) {
-		RT_TRACE(_module_rtl871x_cmd_c_, _drv_err_, ("\nERROR: setassocsta_cmdrsp_callbac => can't get sta_info\n\n"));
+	if (psta == NULL)
 		goto exit;
-	}
 
 	psta->aid = passocsta_rsp->cam_id;
 	psta->mac_id = passocsta_rsp->cam_id;
-- 
2.31.1

