Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1A963E200E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 02:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241380AbhHFAk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 20:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbhHFAky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 20:40:54 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D335C061798
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 17:40:39 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id l34-20020a05600c1d22b02902573c214807so7640547wms.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 17:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l/sGu1/p2tJ2elIqrXWf19C40IL1tkxxyrfc4FpgguE=;
        b=Dm5QaU6eD45VIe3p0aQosIV0Znnl94VDpd24KP8PK3CgiaymJb5jUzqhtVotnHrBvV
         Kces78rCUXx3WRpS6Dd2UoMHh1+Hwe+1zYc5zbb3ndxiDua7ByJ2MG2J8rt60JcPS/eJ
         NPrD0+4obcoX5VCxFw92/J+o+0j8m9o9k+uayDGJ0ybVJujGFJ+XMUNFyzM3QfAeKw0D
         WNZs7/JYOUyc1Efd/puU/jR1H0rmThgg/6lKmjc8Q6QQP21D0nxdF/YqeWpmXUc81+qd
         Tj1KAw+wilhZXbPiSpDQAvswTq5fX9Bu33qfIR90jfTkmz9Z10F0tFXaqVwuTSUP64Hb
         j7Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l/sGu1/p2tJ2elIqrXWf19C40IL1tkxxyrfc4FpgguE=;
        b=qf9YB5OUuZMIA3RAu6Azbw9FbZwhBSRSNMVNk/JT4FwdBmxah5eYNCspZt+sMsP0ha
         GNlWHQ/K5Jv/tazyp1ISa0TkEwh/acUQa7NWqqABZLmwyXIBcbIBtKXlqdjUONw+Wtj7
         MNHcvu290E/BzOk+/sICRGGYTG1kiypH0xofltQuCUZWReg2Tm1HvObPZuOf0uu+EXVn
         dnAHLE6js9o7ypaDhkeKWZKrhE3IJ3jhD0hKB9p3UZy9JQwZT3Gs/f9yZi7CDsT1k901
         TbhjDG85427/OfH3c6GZ1XMmhwmsQSppFC5lB9ZcRQSToJHulv3xDgIgkJ0bLHBPKoP1
         NS2g==
X-Gm-Message-State: AOAM533jUDLHDH0hJWkdE+FGOfMZdJjhs2weHeNPdIDk8GkWp4Nswb7L
        NVr1opZYnL24Y4iO1+i+BSNJPA==
X-Google-Smtp-Source: ABdhPJz822b7pOlf70+Y31FNBMTlswy3L5m++rkmIxyBBAIR0rg9iaOS09MvOrCpxIDhhw0cV9w64g==
X-Received: by 2002:a05:600c:4fd3:: with SMTP id o19mr684543wmq.34.1628210438165;
        Thu, 05 Aug 2021 17:40:38 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id y19sm10727181wmq.5.2021.08.05.17.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 17:40:37 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, martin@kaiser.cx
Subject: [PATCH v2 01/11] staging: r8188eu: remove RT_TRACE calls from core/rtw_cmd.c
Date:   Fri,  6 Aug 2021 01:40:24 +0100
Message-Id: <20210806004034.82233-2-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210806004034.82233-1-phil@philpotter.co.uk>
References: <20210806004034.82233-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove RT_TRACE macro calls from core/rtw_cmd.c, so that ultimately the
macro definition itself can eventually be removed.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/core/rtw_cmd.c | 66 +++-----------------------
 1 file changed, 7 insertions(+), 59 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index 3462543ae143..c3a9051ca10c 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -76,9 +76,6 @@ int _rtw_init_evt_priv(struct evt_priv *pevtpriv)
 
 void rtw_free_evt_priv(struct	evt_priv *pevtpriv)
 {
-
-	RT_TRACE(_module_rtl871x_cmd_c_, _drv_info_, ("+rtw_free_evt_priv\n"));
-
 	_cancel_workitem_sync(&pevtpriv->c2h_wk);
 	while (pevtpriv->c2h_wk_alive)
 		msleep(10);
@@ -88,8 +85,6 @@ void rtw_free_evt_priv(struct	evt_priv *pevtpriv)
 		if (c2h && c2h != (void *)pevtpriv)
 			kfree(c2h);
 	}
-	RT_TRACE(_module_rtl871x_cmd_c_, _drv_info_, ("-rtw_free_evt_priv\n"));
-
 }
 
 void _rtw_free_cmd_priv (struct	cmd_priv *pcmdpriv)
@@ -170,10 +165,7 @@ u32	rtw_init_evt_priv (struct	evt_priv *pevtpriv)
 
 void rtw_free_cmd_priv(struct	cmd_priv *pcmdpriv)
 {
-
-	RT_TRACE(_module_rtl871x_cmd_c_, _drv_info_, ("rtw_free_cmd_priv\n"));
 	_rtw_free_cmd_priv(pcmdpriv);
-
 }
 
 static int rtw_cmd_filter(struct cmd_priv *pcmdpriv, struct cmd_obj *cmd_obj)
@@ -279,8 +271,6 @@ int rtw_cmd_thread(void *context)
 	pcmdpriv->cmdthd_running = true;
 	up(&pcmdpriv->terminate_cmdthread_sema);
 
-	RT_TRACE(_module_rtl871x_cmd_c_, _drv_info_, ("start r871x rtw_cmd_thread !!!!\n"));
-
 	while (1) {
 		if (_rtw_down_sema(&pcmdpriv->cmd_queue_sema) == _FAIL)
 			break;
@@ -334,15 +324,12 @@ int rtw_cmd_thread(void *context)
 		/* call callback function for post-processed */
 		if (pcmd->cmdcode < ARRAY_SIZE(rtw_cmd_callback)) {
 			pcmd_callback = rtw_cmd_callback[pcmd->cmdcode].callback;
-			if (!pcmd_callback) {
-				RT_TRACE(_module_rtl871x_cmd_c_, _drv_info_, ("mlme_cmd_hdl(): pcmd_callback = 0x%p, cmdcode = 0x%x\n", pcmd_callback, pcmd->cmdcode));
+			if (!pcmd_callback)
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
 
@@ -434,8 +421,6 @@ u8 rtw_sitesurvey_cmd(struct adapter  *padapter, struct ndis_802_11_ssid *ssid,
 
 	rtw_free_network_queue(padapter, false);
 
-	RT_TRACE(_module_rtl871x_cmd_c_, _drv_info_, ("%s: flush network queue\n", __func__));
-
 	init_h2fwcmd_w_parm_no_rsp(ph2c, psurveyPara, GEN_CMD_CODE(_SiteSurvey));
 
 	/* psurveyPara->bsslimit = 48; */
@@ -576,8 +561,6 @@ u8 rtw_setphy_cmd(struct adapter *padapter, u8 modem, u8 ch)
 
 	init_h2fwcmd_w_parm_no_rsp(ph2c, psetphypara, _SetPhy_CMD_);
 
-	RT_TRACE(_module_rtl871x_cmd_c_, _drv_info_, ("CH =%d, modem =%d", ch, modem));
-
 	psetphypara->modem = modem;
 	psetphypara->rfchannel = ch;
 
@@ -747,17 +730,11 @@ u8 rtw_createbss_cmd(struct adapter  *padapter)
 {
 	struct cmd_obj *pcmd;
 	struct cmd_priv	*pcmdpriv = &padapter->cmdpriv;
-	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct wlan_bssid_ex *pdev_network = &padapter->registrypriv.dev_network;
 	u8	res = _SUCCESS;
 
 	rtw_led_control(padapter, LED_CTL_START_TO_LINK);
 
-	if (pmlmepriv->assoc_ssid.SsidLength == 0)
-		RT_TRACE(_module_rtl871x_cmd_c_, _drv_info_, (" createbss for Any SSid:%s\n", pmlmepriv->assoc_ssid.Ssid));
-	else
-		RT_TRACE(_module_rtl871x_cmd_c_, _drv_info_, (" createbss for SSid:%s\n", pmlmepriv->assoc_ssid.Ssid));
-
 	pcmd = kzalloc(sizeof(struct cmd_obj), GFP_KERNEL);
 	if (!pcmd) {
 		res = _FAIL;
@@ -821,16 +798,9 @@ u8 rtw_joinbss_cmd(struct adapter  *padapter, struct wlan_network *pnetwork)
 
 	rtw_led_control(padapter, LED_CTL_START_TO_LINK);
 
-	if (pmlmepriv->assoc_ssid.SsidLength == 0) {
-		RT_TRACE(_module_rtl871x_cmd_c_, _drv_info_, ("+Join cmd: Any SSid\n"));
-	} else {
-		RT_TRACE(_module_rtl871x_cmd_c_, _drv_notice_, ("+Join cmd: SSid =[%s]\n", pmlmepriv->assoc_ssid.Ssid));
-	}
-
 	pcmd = kzalloc(sizeof(struct cmd_obj), GFP_ATOMIC);
 	if (!pcmd) {
 		res = _FAIL;
-		RT_TRACE(_module_rtl871x_cmd_c_, _drv_err_, ("rtw_joinbss_cmd: memory allocate for cmd_obj fail!!!\n"));
 		goto exit;
 	}
 	/* for IEs is fix buf size */
@@ -859,8 +829,6 @@ u8 rtw_joinbss_cmd(struct adapter  *padapter, struct wlan_network *pnetwork)
 
 		res = _FAIL;
 
-		RT_TRACE(_module_rtl871x_cmd_c_, _drv_err_, ("rtw_joinbss_cmd :psecnetwork == NULL!!!\n"));
-
 		goto exit;
 	}
 
@@ -947,8 +915,6 @@ u8 rtw_disassoc_cmd(struct adapter *padapter, u32 deauth_timeout_ms, bool enqueu
 	struct cmd_priv *cmdpriv = &padapter->cmdpriv;
 	u8 res = _SUCCESS;
 
-	RT_TRACE(_module_rtl871x_cmd_c_, _drv_notice_, ("+rtw_disassoc_cmd\n"));
-
 	/* prepare cmd parameter */
 	param = kzalloc(sizeof(*param), GFP_ATOMIC);
 	if (!param) {
@@ -1357,8 +1323,6 @@ u8 rtw_set_chplan_cmd(struct adapter *padapter, u8 chplan, u8 enqueue)
 
 	u8	res = _SUCCESS;
 
-	RT_TRACE(_module_rtl871x_cmd_c_, _drv_notice_, ("+rtw_set_chplan_cmd\n"));
-
 	/* check input parameter */
 	if (!rtw_is_channel_plan_valid(chplan)) {
 		res = _FAIL;
@@ -1410,8 +1374,6 @@ u8 rtw_led_blink_cmd(struct adapter *padapter, struct LED_871x *pLed)
 
 	u8	res = _SUCCESS;
 
-	RT_TRACE(_module_rtl871x_cmd_c_, _drv_notice_, ("+rtw_led_blink_cmd\n"));
-
 	pcmdobj = kzalloc(sizeof(struct cmd_obj), GFP_ATOMIC);
 	if (!pcmdobj) {
 		res = _FAIL;
@@ -1443,8 +1405,6 @@ u8 rtw_set_csa_cmd(struct adapter *padapter, u8 new_ch_no)
 
 	u8	res = _SUCCESS;
 
-	RT_TRACE(_module_rtl871x_cmd_c_, _drv_notice_, ("+rtw_set_csa_cmd\n"));
-
 	pcmdobj = kzalloc(sizeof(struct cmd_obj), GFP_ATOMIC);
 	if (!pcmdobj) {
 		res = _FAIL;
@@ -2040,7 +2000,6 @@ void rtw_survey_cmd_callback(struct adapter *padapter,  struct cmd_obj *pcmd)
 		_set_timer(&pmlmepriv->scan_to_timer, 1);
 		} else if (pcmd->res != H2C_SUCCESS) {
 		_set_timer(&pmlmepriv->scan_to_timer, 1);
-		RT_TRACE(_module_rtl871x_cmd_c_, _drv_err_, ("\n ********Error: MgntActrtw_set_802_11_bssid_LIST_SCAN Fail ************\n\n."));
 	}
 
 	/*  free cmd */
@@ -2056,7 +2015,6 @@ void rtw_disassoc_cmd_callback(struct adapter *padapter, struct cmd_obj *pcmd)
 		set_fwstate(pmlmepriv, _FW_LINKED);
 		spin_unlock_bh(&pmlmepriv->lock);
 
-		RT_TRACE(_module_rtl871x_cmd_c_, _drv_err_, ("\n ***Error: disconnect_cmd_callback Fail ***\n."));
 		return;
 	} else /* clear bridge database */
 		nat25_db_cleanup(padapter);
@@ -2074,7 +2032,6 @@ void rtw_joinbss_cmd_callback(struct adapter *padapter,  struct cmd_obj *pcmd)
 		/* need to make timeout handlerOS independent */
 		_set_timer(&pmlmepriv->assoc_timer, 1);
 	} else if (pcmd->res != H2C_SUCCESS) {
-		RT_TRACE(_module_rtl871x_cmd_c_, _drv_err_, ("********Error:rtw_select_and_join_from_scanned_queue Wait Sema  Fail ************\n"));
 		_set_timer(&pmlmepriv->assoc_timer, 1);
 	}
 
@@ -2090,10 +2047,8 @@ void rtw_createbss_cmd_callback(struct adapter *padapter, struct cmd_obj *pcmd)
 	struct wlan_bssid_ex *pnetwork = (struct wlan_bssid_ex *)pcmd->parmbuf;
 	struct wlan_network *tgt_network = &(pmlmepriv->cur_network);
 
-	if ((pcmd->res != H2C_SUCCESS)) {
-		RT_TRACE(_module_rtl871x_cmd_c_, _drv_err_, ("\n ********Error: rtw_createbss_cmd_callback  Fail ************\n\n."));
+	if ((pcmd->res != H2C_SUCCESS))
 		_set_timer(&pmlmepriv->assoc_timer, 1);
-	}
 
 	_cancel_timer(&pmlmepriv->assoc_timer, &timer_cancelled);
 
@@ -2103,10 +2058,8 @@ void rtw_createbss_cmd_callback(struct adapter *padapter, struct cmd_obj *pcmd)
 		psta = rtw_get_stainfo(&padapter->stapriv, pnetwork->MacAddress);
 		if (!psta) {
 			psta = rtw_alloc_stainfo(&padapter->stapriv, pnetwork->MacAddress);
-			if (!psta) {
-				RT_TRACE(_module_rtl871x_cmd_c_, _drv_err_, ("\nCan't alloc sta_info when createbss_cmd_callback\n"));
-				goto createbss_cmd_fail ;
-			}
+			if (!psta)
+				goto createbss_cmd_fail;
 		}
 
 		rtw_indicate_connect(padapter);
@@ -2117,7 +2070,6 @@ void rtw_createbss_cmd_callback(struct adapter *padapter, struct cmd_obj *pcmd)
 		if (!pwlan) {
 			pwlan = rtw_get_oldest_wlan_network(&pmlmepriv->scanned_queue);
 			if (!pwlan) {
-				RT_TRACE(_module_rtl871x_cmd_c_, _drv_err_, ("\n Error:  can't get pwlan in rtw_joinbss_event_callback\n"));
 				spin_unlock_bh(&(pmlmepriv->scanned_queue.lock));
 				goto createbss_cmd_fail;
 			}
@@ -2151,10 +2103,8 @@ void rtw_setstaKey_cmdrsp_callback(struct adapter *padapter,  struct cmd_obj *pc
 	struct set_stakey_rsp *psetstakey_rsp = (struct set_stakey_rsp *)(pcmd->rsp);
 	struct sta_info *psta = rtw_get_stainfo(pstapriv, psetstakey_rsp->addr);
 
-	if (!psta) {
-		RT_TRACE(_module_rtl871x_cmd_c_, _drv_err_, ("\nERROR: rtw_setstaKey_cmdrsp_callback => can't get sta_info\n\n"));
+	if (!psta)
 		goto exit;
-	}
 exit:
 	rtw_free_cmd_obj(pcmd);
 
@@ -2168,10 +2118,8 @@ void rtw_setassocsta_cmdrsp_callback(struct adapter *padapter,  struct cmd_obj *
 	struct set_assocsta_rsp *passocsta_rsp = (struct set_assocsta_rsp *)(pcmd->rsp);
 	struct sta_info *psta = rtw_get_stainfo(pstapriv, passocsta_parm->addr);
 
-	if (!psta) {
-		RT_TRACE(_module_rtl871x_cmd_c_, _drv_err_, ("\nERROR: setassocsta_cmdrsp_callbac => can't get sta_info\n\n"));
+	if (!psta)
 		goto exit;
-	}
 
 	psta->aid = passocsta_rsp->cam_id;
 	psta->mac_id = passocsta_rsp->cam_id;
-- 
2.31.1

