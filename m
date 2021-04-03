Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E27C353330
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 11:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236686AbhDCJOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 05:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236586AbhDCJOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 05:14:36 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276FFC0613E6
        for <linux-kernel@vger.kernel.org>; Sat,  3 Apr 2021 02:14:33 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id e18so6533395wrt.6
        for <linux-kernel@vger.kernel.org>; Sat, 03 Apr 2021 02:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5cjIqzfmvOIN61FZL8Gmla9CB+ueBD5TY6cubLiJ9rY=;
        b=iR1Px07eUU3dvh96r3whkL9hTijVquEqqL+zXSXSlktvPUP1BBq03gcy7L5hiNRWAz
         fYAZLJ3zUoMseR7WdkSLNBupCBBkraD6tt0t/dDkY9X8O/tpxbNVQ/ruBheJANGtHIsP
         qDQWG9ZO/3NT0Scnz+c/DDj5Kqif+oFN7Id9HwqFy3y1/QmMW2g2jIWJ9O3yXoysHAKo
         LZPaWbSscLI0ylvvq1pFdtk0uU9Vf7EfXrlMfYUkKhImsGdiitQHf/9zcF2zz1mGgU+9
         AWDDWaIBxXWquoAN6FLN1Rz7dp3vFriKm/HUPz59HDnt+aS4N9ph3IIMG4rSgBE2BN1J
         ljGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5cjIqzfmvOIN61FZL8Gmla9CB+ueBD5TY6cubLiJ9rY=;
        b=Cxd7rUOjSzeTxJdrEfZOBU70rZSpU81P901ngx9Ig33G2j6FNsQEJhcflEuiKWYLKH
         7dmqd/yagStWXy+u/6GRFa6HiioQH95KC3BCoWGUhT4Hid1Ig8Cz1mtY7JnXCTinBZTM
         Mc/xfcxDw13POqEo5TwQ5op1wqZ8wsZlBZtWHS/R3JSujwad/SlSt6U3t81KfiAMKO9T
         Y0RR75R5NpcWq3Rt0lBVvhpF3z4bHRECKD+h854s6uR0k41wHw2jJbYKiKO9D1Om7fJF
         FJh1Hu7hAMmNvQzdFwtR1UpJOImZUv+ZEiD5wSINuGjJwIbjBy+v7NGZY3P8G4r/CM6T
         1Xfw==
X-Gm-Message-State: AOAM530bPB90ofkMV4blnm75EqaS1fAI/ECqE4iheioJCWsZc/CpMz+2
        Xy+M+rbuK3+TC367uTbNr3o=
X-Google-Smtp-Source: ABdhPJyYzoNGLbA6Lx8x4ZqHlYZf0yqcQi/3ePbKqpUs6/YkcsmmH1JHu0QyXna+WDzrtT+L3gZzmA==
X-Received: by 2002:adf:ce8a:: with SMTP id r10mr19258259wrn.17.1617441271890;
        Sat, 03 Apr 2021 02:14:31 -0700 (PDT)
Received: from agape ([5.171.72.64])
        by smtp.gmail.com with ESMTPSA id a131sm15561669wmc.48.2021.04.03.02.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Apr 2021 02:14:31 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH v3 11/30] staging: rtl8723bs: remove RT_TRACE logs in core/rtw_cmd.c
Date:   Sat,  3 Apr 2021 11:13:33 +0200
Message-Id: <6480425f7b4211ff1fe0bad0e8062d63c4ed9af3.1617440834.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617440833.git.fabioaiuto83@gmail.com>
References: <cover.1617440833.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove all of the RT_TRACE logs in the core/rtw_cmd.c file as they
currently do nothing as they require the code to be modified by
hand in order to be turned on. This obviously has not happened
since the code was merged. Moreover it relies on an unneeded
private log level tracing which overrides the in-kernel public one,
so just remove them as they are unused.

removed a variable, left unused after RT_TRACE removal

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_cmd.c | 53 +++---------------------
 1 file changed, 6 insertions(+), 47 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
index 2aaf25b48f96..2086df056c44 100644
--- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
+++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
@@ -221,8 +221,6 @@ int rtw_init_evt_priv(struct evt_priv *pevtpriv)
 
 void _rtw_free_evt_priv(struct	evt_priv *pevtpriv)
 {
-	RT_TRACE(_module_rtl871x_cmd_c_, _drv_info_, ("+_rtw_free_evt_priv\n"));
-
 	_cancel_workitem_sync(&pevtpriv->c2h_wk);
 	while (pevtpriv->c2h_wk_alive)
 		msleep(10);
@@ -233,8 +231,6 @@ void _rtw_free_evt_priv(struct	evt_priv *pevtpriv)
 			kfree(c2h);
 	}
 	kfree(pevtpriv->c2h_queue);
-
-	RT_TRACE(_module_rtl871x_cmd_c_, _drv_info_, ("-_rtw_free_evt_priv\n"));
 }
 
 void _rtw_free_cmd_priv(struct	cmd_priv *pcmdpriv)
@@ -299,13 +295,11 @@ struct	cmd_obj	*_rtw_dequeue_cmd(struct __queue *queue)
 
 void rtw_free_evt_priv(struct	evt_priv *pevtpriv)
 {
-	RT_TRACE(_module_rtl871x_cmd_c_, _drv_info_, ("rtw_free_evt_priv\n"));
 	_rtw_free_evt_priv(pevtpriv);
 }
 
 void rtw_free_cmd_priv(struct	cmd_priv *pcmdpriv)
 {
-	RT_TRACE(_module_rtl871x_cmd_c_, _drv_info_, ("rtw_free_cmd_priv\n"));
 	_rtw_free_cmd_priv(pcmdpriv);
 }
 
@@ -415,8 +409,6 @@ int rtw_cmd_thread(void *context)
 	atomic_set(&(pcmdpriv->cmdthd_running), true);
 	complete(&pcmdpriv->terminate_cmdthread_comp);
 
-	RT_TRACE(_module_rtl871x_cmd_c_, _drv_info_, ("start r871x rtw_cmd_thread !!!!\n"));
-
 	while (1) {
 		if (wait_for_completion_interruptible(&pcmdpriv->cmd_queue_comp)) {
 			DBG_871X_LEVEL(_drv_always_, FUNC_ADPT_FMT" wait_for_completion_interruptible(&pcmdpriv->cmd_queue_comp) return != 0, break\n", FUNC_ADPT_ARG(padapter));
@@ -439,11 +431,8 @@ int rtw_cmd_thread(void *context)
 			continue;
 		}
 
-		if (rtw_register_cmd_alive(padapter) != _SUCCESS) {
-			RT_TRACE(_module_hal_xmit_c_, _drv_notice_,
-					 ("%s: wait to leave LPS_LCLK\n", __func__));
+		if (rtw_register_cmd_alive(padapter) != _SUCCESS)
 			continue;
-		}
 
 _next:
 		if ((padapter->bDriverStopped == true) || (padapter->bSurpriseRemoved == true)) {
@@ -512,14 +501,12 @@ int rtw_cmd_thread(void *context)
 		if (pcmd->cmdcode < ARRAY_SIZE(rtw_cmd_callback)) {
 			pcmd_callback = rtw_cmd_callback[pcmd->cmdcode].callback;
 			if (pcmd_callback == NULL) {
-				RT_TRACE(_module_rtl871x_cmd_c_, _drv_info_, ("mlme_cmd_hdl(): pcmd_callback = 0x%p, cmdcode = 0x%x\n", pcmd_callback, pcmd->cmdcode));
 				rtw_free_cmd_obj(pcmd);
 			} else {
 				/* todo: !!! fill rsp_buf to pcmd->rsp if (pcmd->rsp!= NULL) */
 				pcmd_callback(pcmd->padapter, pcmd);/* need consider that free cmd_obj in rtw_cmd_callback */
 			}
 		} else {
-			RT_TRACE(_module_rtl871x_cmd_c_, _drv_err_, ("%s: cmdcode = 0x%x callback not defined!\n", __func__, pcmd->cmdcode));
 			rtw_free_cmd_obj(pcmd);
 		}
 
@@ -583,8 +570,6 @@ u8 rtw_sitesurvey_cmd(struct adapter  *padapter, struct ndis_802_11_ssid *ssid,
 
 	rtw_free_network_queue(padapter, false);
 
-	RT_TRACE(_module_rtl871x_cmd_c_, _drv_info_, ("%s: flush network queue\n", __func__));
-
 	init_h2fwcmd_w_parm_no_rsp(ph2c, psurveyPara, GEN_CMD_CODE(_SiteSurvey));
 
 	/* psurveyPara->bsslimit = 48; */
@@ -672,15 +657,9 @@ u8 rtw_createbss_cmd(struct adapter  *padapter)
 {
 	struct cmd_obj *pcmd;
 	struct cmd_priv 			*pcmdpriv = &padapter->cmdpriv;
-	struct mlme_priv 		*pmlmepriv = &padapter->mlmepriv;
 	struct wlan_bssid_ex		*pdev_network = &padapter->registrypriv.dev_network;
 	u8 res = _SUCCESS;
 
-	if (pmlmepriv->assoc_ssid.SsidLength == 0)
-		RT_TRACE(_module_rtl871x_cmd_c_, _drv_info_, (" createbss for Any SSid:%s\n", pmlmepriv->assoc_ssid.Ssid));
-	else
-		RT_TRACE(_module_rtl871x_cmd_c_, _drv_info_, (" createbss for SSid:%s\n", pmlmepriv->assoc_ssid.Ssid));
-
 	pcmd = rtw_zmalloc(sizeof(struct cmd_obj));
 	if (pcmd == NULL) {
 		res = _FAIL;
@@ -766,15 +745,9 @@ u8 rtw_joinbss_cmd(struct adapter  *padapter, struct wlan_network *pnetwork)
 	u32 tmp_len;
 	u8 *ptmp = NULL;
 
-	if (pmlmepriv->assoc_ssid.SsidLength == 0)
-		RT_TRACE(_module_rtl871x_cmd_c_, _drv_info_, ("+Join cmd: Any SSid\n"));
-	else
-		RT_TRACE(_module_rtl871x_cmd_c_, _drv_notice_, ("+Join cmd: SSid =[%s]\n", pmlmepriv->assoc_ssid.Ssid));
-
 	pcmd = rtw_zmalloc(sizeof(struct cmd_obj));
 	if (pcmd == NULL) {
 		res = _FAIL;
-		RT_TRACE(_module_rtl871x_cmd_c_, _drv_err_, ("rtw_joinbss_cmd: memory allocate for cmd_obj fail!!!\n"));
 		goto exit;
 	}
 	/* for IEs is fix buf size */
@@ -883,8 +856,6 @@ u8 rtw_disassoc_cmd(struct adapter *padapter, u32 deauth_timeout_ms, bool enqueu
 	struct cmd_priv *cmdpriv = &padapter->cmdpriv;
 	u8 res = _SUCCESS;
 
-	RT_TRACE(_module_rtl871x_cmd_c_, _drv_notice_, ("+rtw_disassoc_cmd\n"));
-
 	/* prepare cmd parameter */
 	param = rtw_zmalloc(sizeof(*param));
 	if (param == NULL) {
@@ -1209,8 +1180,6 @@ u8 rtw_set_chplan_cmd(struct adapter *padapter, u8 chplan, u8 enqueue, u8 swconf
 
 	u8 res = _SUCCESS;
 
-	RT_TRACE(_module_rtl871x_cmd_c_, _drv_notice_, ("+rtw_set_chplan_cmd\n"));
-
 	/*  check if allow software config */
 	if (swconfig && rtw_hal_is_disable_sw_channel_plan(padapter) == true) {
 		res = _FAIL;
@@ -1981,7 +1950,6 @@ void rtw_survey_cmd_callback(struct adapter *padapter,  struct cmd_obj *pcmd)
 		_set_timer(&pmlmepriv->scan_to_timer, 1);
 	} else if (pcmd->res != H2C_SUCCESS) {
 		_set_timer(&pmlmepriv->scan_to_timer, 1);
-		RT_TRACE(_module_rtl871x_cmd_c_, _drv_err_, ("\n ********Error: MgntActrtw_set_802_11_bssid_LIST_SCAN Fail ************\n\n."));
 	}
 
 	/*  free cmd */
@@ -1997,7 +1965,6 @@ void rtw_disassoc_cmd_callback(struct adapter *padapter,  struct cmd_obj *pcmd)
 		set_fwstate(pmlmepriv, _FW_LINKED);
 		spin_unlock_bh(&pmlmepriv->lock);
 
-		RT_TRACE(_module_rtl871x_cmd_c_, _drv_err_, ("\n ***Error: disconnect_cmd_callback Fail ***\n."));
 		return;
 	}
 	/*  free cmd */
@@ -2030,10 +1997,8 @@ void rtw_createbss_cmd_callback(struct adapter *padapter, struct cmd_obj *pcmd)
 	if (pcmd->parmbuf == NULL)
 		goto exit;
 
-	if ((pcmd->res != H2C_SUCCESS)) {
-		RT_TRACE(_module_rtl871x_cmd_c_, _drv_err_, ("\n ********Error: rtw_createbss_cmd_callback  Fail ************\n\n."));
+	if ((pcmd->res != H2C_SUCCESS))
 		_set_timer(&pmlmepriv->assoc_timer, 1);
-	}
 
 	del_timer_sync(&pmlmepriv->assoc_timer);
 
@@ -2044,10 +2009,8 @@ void rtw_createbss_cmd_callback(struct adapter *padapter, struct cmd_obj *pcmd)
 		psta = rtw_get_stainfo(&padapter->stapriv, pnetwork->MacAddress);
 		if (!psta) {
 			psta = rtw_alloc_stainfo(&padapter->stapriv, pnetwork->MacAddress);
-			if (psta == NULL) {
-				RT_TRACE(_module_rtl871x_cmd_c_, _drv_err_, ("\nCan't alloc sta_info when createbss_cmd_callback\n"));
+			if (psta == NULL)
 				goto createbss_cmd_fail;
-			}
 		}
 
 		rtw_indicate_connect(padapter);
@@ -2057,7 +2020,6 @@ void rtw_createbss_cmd_callback(struct adapter *padapter, struct cmd_obj *pcmd)
 		if (pwlan == NULL) {
 			pwlan = rtw_get_oldest_wlan_network(&pmlmepriv->scanned_queue);
 			if (pwlan == NULL) {
-				RT_TRACE(_module_rtl871x_cmd_c_, _drv_err_, ("\n Error:  can't get pwlan in rtw_joinbss_event_callback\n"));
 				spin_unlock_bh(&(pmlmepriv->scanned_queue.lock));
 				goto createbss_cmd_fail;
 			}
@@ -2101,10 +2063,9 @@ void rtw_setstaKey_cmdrsp_callback(struct adapter *padapter,  struct cmd_obj *pc
 	struct set_stakey_rsp *psetstakey_rsp = (struct set_stakey_rsp *) (pcmd->rsp);
 	struct sta_info *psta = rtw_get_stainfo(pstapriv, psetstakey_rsp->addr);
 
-	if (psta == NULL) {
-		RT_TRACE(_module_rtl871x_cmd_c_, _drv_err_, ("\nERROR: rtw_setstaKey_cmdrsp_callback => can't get sta_info\n\n"));
+	if (psta == NULL)
 		goto exit;
-	}
+
 exit:
 	rtw_free_cmd_obj(pcmd);
 }
@@ -2117,10 +2078,8 @@ void rtw_setassocsta_cmdrsp_callback(struct adapter *padapter,  struct cmd_obj *
 	struct set_assocsta_rsp *passocsta_rsp = (struct set_assocsta_rsp *) (pcmd->rsp);
 	struct sta_info *psta = rtw_get_stainfo(pstapriv, passocsta_parm->addr);
 
-	if (psta == NULL) {
-		RT_TRACE(_module_rtl871x_cmd_c_, _drv_err_, ("\nERROR: setassocsta_cmdrsp_callbac => can't get sta_info\n\n"));
+	if (psta == NULL)
 		goto exit;
-	}
 
 	psta->aid = passocsta_rsp->cam_id;
 	psta->mac_id = passocsta_rsp->cam_id;
-- 
2.20.1

