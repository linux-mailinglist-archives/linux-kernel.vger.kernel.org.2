Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 953B234FD27
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 11:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234870AbhCaJlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 05:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234794AbhCaJk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 05:40:26 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2681C061574
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 02:40:25 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id r12so29088551ejr.5
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 02:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ph8+jplus+8b/t7jNe8xHtMICcKAjOpPOhXK7EXTFKw=;
        b=Cj3QsyYGIhZAWwdmc8fG3zeSdEuZockWmjhe52BY8R4vox35zPt9osqlhDDBAQmeQP
         n5rDMyJWEPZj96RYapuRa1m86ActvB7/Xdejz7M8NlHkmv8oi7kUpmPrP06OWtnqHv72
         SqhqzO/7Lqtu1JPbgrahu48H9apl245y5WjsH1okFdOfydUOzpBAYaM3mEqDpP4ZGKY1
         7kDEygQmMPXOlscKDJl3gFJI0zH/oCyEBM9F770wAd+XEehWLO3oJ5otrhlefNd3pRQP
         v0kDdlHIxRGCDLnGNM+FIZfzoJ/2uMVvDynxapfybN+TEvOQkjfA9xvnHhvNZSGFfW30
         WwnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ph8+jplus+8b/t7jNe8xHtMICcKAjOpPOhXK7EXTFKw=;
        b=pTOcNDtvvy7GF6yCsDzh8W6Ev9xIMZJGS3vZa+biWwuRCFicJe455e9BIe0cjewDSz
         HnlppuPm8xtW57NuewzbQLRnlWx6aUhtNsXOIAyTFqvQxk/3aMdwtmG8UMWZIPuaZRgM
         ohAx3U/iRfyEOBjMBpZdQAFVl1sbppvGrjPecJT4fVO1xVZGmJGqqXj2/l/byZWMw6H+
         ZRuIPNXdIGMBi2v6CkkmBL5oXRZeCT/1GPQVQe5xQcePwVT+HYByUH6OM3YYTNKG/Bqk
         OV12j1b9o2DwN3lzLambhUhqSNeEuqdzm3VvH7BBZJzVPVvnfG1SBtbCkrxbLbYAtfIo
         AUuA==
X-Gm-Message-State: AOAM5314lbRh4sKIuq8yJJPt5dW7fzf6LDp2zlkYtUz8pr3gG5PbVgAf
        OXd/1yTjCrBEcMSwSgjA298=
X-Google-Smtp-Source: ABdhPJw3MecRT1BSwoCDRAh5DuESVXqYTSwwimKLl9QxNZWpIDyp9vRlT6KVlVlD+LvjvOuXXeBL2g==
X-Received: by 2002:a17:906:4e57:: with SMTP id g23mr2549439ejw.47.1617183624357;
        Wed, 31 Mar 2021 02:40:24 -0700 (PDT)
Received: from agape ([5.171.73.44])
        by smtp.gmail.com with ESMTPSA id f21sm821278ejw.124.2021.03.31.02.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 02:40:24 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 07/40] staging: rtl8723bs: replace RT_TRACE with public printk wrappers in core/rtw_mlme.c
Date:   Wed, 31 Mar 2021 11:39:35 +0200
Message-Id: <013f52bf1becc53480a96554b2a808d6b9f81030.1617183374.git.fabioaiuto83@gmail.com>
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
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 122 +++++++++++++---------
 1 file changed, 72 insertions(+), 50 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 4289bf40aa73..5e070ba6fb92 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -155,8 +155,7 @@ struct	wlan_network *rtw_alloc_network(struct	mlme_priv *pmlmepriv)
 
 	list_del_init(&pnetwork->list);
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_,
-		 ("rtw_alloc_network: ptr =%p\n", plist));
+	pr_info("%s %s: ptr =%p\n", DRIVER_PREFIX, __func__, plist);
 	pnetwork->network_type = 0;
 	pnetwork->fixed = false;
 	pnetwork->last_scanned = jiffies;
@@ -299,7 +298,9 @@ signed int rtw_if_up(struct adapter *padapter)
 
 	if (padapter->bDriverStopped || padapter->bSurpriseRemoved ||
 		(check_fwstate(&padapter->mlmepriv, _FW_LINKED) == false)) {
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_if_up:bDriverStopped(%d) OR bSurpriseRemoved(%d)", padapter->bDriverStopped, padapter->bSurpriseRemoved));
+		pr_info("%s %s:bDriverStopped(%d) OR bSurpriseRemoved(%d)",
+			DRIVER_PREFIX, __func__, padapter->bDriverStopped,
+			padapter->bSurpriseRemoved);
 		res = false;
 	} else
 		res =  true;
@@ -339,7 +340,7 @@ u8 *rtw_get_beacon_interval_from_ie(u8 *ie)
 
 void rtw_free_mlme_priv(struct mlme_priv *pmlmepriv)
 {
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("rtw_free_mlme_priv\n"));
+	pr_err("%s %s\n", DRIVER_PREFIX, __func__);
 	_rtw_free_mlme_priv(pmlmepriv);
 }
 
@@ -608,7 +609,7 @@ void rtw_update_scanned_network(struct adapter *adapter, struct wlan_bssid_ex *t
 			/* list_del_init(&oldest->list); */
 			pnetwork = oldest;
 			if (!pnetwork) {
-				RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("\n\n\nsomething wrong here\n\n\n"));
+				pr_err("%s something wrong here\n", DRIVER_PREFIX);
 				goto exit;
 			}
 			memcpy(&(pnetwork->network), target,  get_wlan_bssid_ex_sz(target));
@@ -629,7 +630,7 @@ void rtw_update_scanned_network(struct adapter *adapter, struct wlan_bssid_ex *t
 			pnetwork = rtw_alloc_network(pmlmepriv); /*  will update scan_time */
 
 			if (!pnetwork) {
-				RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("\n\n\nsomething wrong here\n\n\n"));
+				pr_err("%s something wrong here\n", DRIVER_PREFIX);
 				goto exit;
 			}
 
@@ -750,7 +751,7 @@ int rtw_is_desired_network(struct adapter *adapter, struct wlan_network *pnetwor
 /* TODO: Perry : For Power Management */
 void rtw_atimdone_event_callback(struct adapter	*adapter, u8 *pbuf)
 {
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("receive atimdone_event\n"));
+	pr_err("%s receive atimdone_event\n", DRIVER_PREFIX);
 }
 
 void rtw_survey_event_callback(struct adapter	*adapter, u8 *pbuf)
@@ -761,11 +762,11 @@ void rtw_survey_event_callback(struct adapter	*adapter, u8 *pbuf)
 
 	pnetwork = (struct wlan_bssid_ex *)pbuf;
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_survey_event_callback, ssid =%s\n",  pnetwork->Ssid.Ssid));
+	pr_info("%s %s, ssid =%s\n", DRIVER_PREFIX, __func__, pnetwork->Ssid.Ssid);
 
 	len = get_wlan_bssid_ex_sz(pnetwork);
 	if (len > (sizeof(struct wlan_bssid_ex))) {
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("\n ****rtw_survey_event_callback: return a wrong bss ***\n"));
+		pr_err("%s ****%s: return a wrong bss ***\n", DRIVER_PREFIX, __func__);
 		return;
 	}
 
@@ -811,14 +812,15 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
 		pmlmepriv->wps_probe_req_ie = NULL;
 	}
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_surveydone_event_callback: fw_state:%x\n\n", get_fwstate(pmlmepriv)));
+	pr_info("%s %s: fw_state:%x\n\n", DRIVER_PREFIX, __func__, get_fwstate(pmlmepriv));
 
 	if (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY)) {
 		del_timer_sync(&pmlmepriv->scan_to_timer);
 		_clr_fwstate_(pmlmepriv, _FW_UNDER_SURVEY);
 	} else {
 
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("nic status =%x, survey done event comes too late!\n", get_fwstate(pmlmepriv)));
+		pr_err("%s nic status =%x, survey done event comes too late!\n",
+		       DRIVER_PREFIX, get_fwstate(pmlmepriv));
 	}
 
 	rtw_set_signal_stat_timer(&adapter->recvpriv);
@@ -837,7 +839,7 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
 					/* pmlmepriv->fw_state ^= _FW_UNDER_SURVEY;because don't set assoc_timer */
 					_clr_fwstate_(pmlmepriv, _FW_UNDER_SURVEY);
 
-					RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("switching to adhoc master\n"));
+					pr_err("%s switching to adhoc master\n", DRIVER_PREFIX);
 
 					memcpy(&pdev_network->Ssid, &pmlmepriv->assoc_ssid, sizeof(struct ndis_802_11_ssid));
 
@@ -847,7 +849,8 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
 					pmlmepriv->fw_state = WIFI_ADHOC_MASTER_STATE;
 
 					if (rtw_createbss_cmd(adapter) != _SUCCESS)
-						RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("Error =>rtw_createbss_cmd status FAIL\n"));
+						pr_err("%s Error =>rtw_createbss_cmd status FAIL\n",
+						       DRIVER_PREFIX);
 
 					pmlmepriv->to_join = false;
 				}
@@ -919,7 +922,7 @@ static void free_scanqueue(struct	mlme_priv *pmlmepriv)
 	struct __queue *scan_queue = &pmlmepriv->scanned_queue;
 	struct list_head	*plist, *phead, *ptemp;
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_notice_, ("+free_scanqueue\n"));
+	pr_notice("%s+%s\n", DRIVER_PREFIX, __func__);
 	spin_lock_bh(&scan_queue->lock);
 	spin_lock_bh(&free_queue->lock);
 
@@ -957,7 +960,7 @@ static void find_network(struct adapter *adapter)
 	if (pwlan)
 		pwlan->fixed = false;
 	else
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("rtw_free_assoc_resources : pwlan == NULL\n\n"));
+		pr_err("%s rtw_free_assoc_resources : pwlan == NULL\n", DRIVER_PREFIX);
 
 	if (check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE) &&
 	    (adapter->stapriv.asoc_sta_count == 1))
@@ -975,9 +978,9 @@ void rtw_free_assoc_resources(struct adapter *adapter, int lock_scanned_queue)
 	struct dvobj_priv *psdpriv = adapter->dvobj;
 	struct debug_priv *pdbgpriv = &psdpriv->drv_dbg;
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_notice_, ("+rtw_free_assoc_resources\n"));
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("tgt_network->network.MacAddress =%pM ssid =%s\n",
-		MAC_ARG(tgt_network->network.MacAddress), tgt_network->network.Ssid.Ssid));
+	pr_notice("%s+%s\n", DRIVER_PREFIX, __func__);
+	pr_info("%s tgt_network->network.MacAddress =%pM ssid =%s\n", DRIVER_PREFIX,
+		MAC_ARG(tgt_network->network.MacAddress), tgt_network->network.Ssid.Ssid);
 
 	if (check_fwstate(pmlmepriv, WIFI_STATION_STATE|WIFI_AP_STATE)) {
 		struct sta_info *psta;
@@ -1016,7 +1019,7 @@ void rtw_indicate_connect(struct adapter *padapter)
 {
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("+rtw_indicate_connect\n"));
+	pr_err("%s+%s\n", DRIVER_PREFIX, __func__);
 
 	pmlmepriv->to_join = false;
 
@@ -1030,7 +1033,7 @@ void rtw_indicate_connect(struct adapter *padapter)
 	rtw_set_to_roam(padapter, 0);
 	rtw_set_scan_deny(padapter, 3000);
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("-rtw_indicate_connect: fw_state = 0x%08x\n", get_fwstate(pmlmepriv)));
+	pr_err("%s-%s: fw_state = 0x%08x\n", DRIVER_PREFIX, __func__, get_fwstate(pmlmepriv));
 }
 
 /*
@@ -1040,7 +1043,7 @@ void rtw_indicate_disconnect(struct adapter *padapter)
 {
 	struct	mlme_priv *pmlmepriv = &padapter->mlmepriv;
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("+rtw_indicate_disconnect\n"));
+	pr_err("%s+%s\n", DRIVER_PREFIX, __func__);
 
 	_clr_fwstate_(pmlmepriv, _FW_UNDER_LINKING|WIFI_UNDER_WPS);
 
@@ -1207,8 +1210,8 @@ static void rtw_joinbss_update_network(struct adapter *padapter, struct wlan_net
 	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
 	struct wlan_network  *cur_network = &(pmlmepriv->cur_network);
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("\nfw_state:%x, BSSID:%pM\n"
-		, get_fwstate(pmlmepriv), MAC_ARG(pnetwork->network.MacAddress)));
+	pr_info("%s fw_state:%x, BSSID:%pM\n", DRIVER_PREFIX,
+		get_fwstate(pmlmepriv), MAC_ARG(pnetwork->network.MacAddress));
 
 	/*  why not use ptarget_wlan?? */
 	memcpy(&cur_network->network, &pnetwork->network, pnetwork->network.Length);
@@ -1251,7 +1254,7 @@ static void rtw_joinbss_update_network(struct adapter *padapter, struct wlan_net
 			break;
 	default:
 			pmlmepriv->fw_state = WIFI_NULL_STATE;
-			RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("Invalid network_mode\n"));
+			pr_err("%s Invalid network_mode\n", DRIVER_PREFIX);
 			break;
 	}
 
@@ -1280,20 +1283,23 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
 	struct wlan_network	*pcur_wlan = NULL, *ptarget_wlan = NULL;
 	unsigned int		the_same_macaddr = false;
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("joinbss event call back received with res =%d\n", pnetwork->join_res));
+	pr_info("%s joinbss event call back received with res =%d\n",
+		DRIVER_PREFIX, pnetwork->join_res);
 
 	rtw_get_encrypt_decrypt_from_registrypriv(adapter);
 
 	if (pmlmepriv->assoc_ssid.SsidLength == 0)
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("@@@@@   joinbss event call back  for Any SSid\n"));
+		pr_err("%s @@@@@   joinbss event call back  for Any SSid\n", DRIVER_PREFIX);
 	else
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("@@@@@   rtw_joinbss_event_callback for SSid:%s\n", pmlmepriv->assoc_ssid.Ssid));
+		pr_err("%s @@@@@   rtw_joinbss_event_callback for SSid:%s\n",
+		       DRIVER_PREFIX, pmlmepriv->assoc_ssid.Ssid);
 
 	the_same_macaddr = !memcmp(pnetwork->network.MacAddress, cur_network->network.MacAddress, ETH_ALEN);
 
 	pnetwork->network.Length = get_wlan_bssid_ex_sz(&pnetwork->network);
 	if (pnetwork->network.Length > sizeof(struct wlan_bssid_ex)) {
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("\n\n ***joinbss_evt_callback return a wrong bss ***\n\n"));
+		pr_err("%s ***joinbss_evt_callback return a wrong bss ***\n\n",
+		       DRIVER_PREFIX);
 		return;
 	}
 
@@ -1302,7 +1308,7 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
 	pmlmepriv->LinkDetectInfo.TrafficTransitionCount = 0;
 	pmlmepriv->LinkDetectInfo.LowPowerTransitionCount = 0;
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("\n rtw_joinbss_event_callback !! spin_lock_irqsave\n"));
+	pr_info("%s rtw_joinbss_event_callback !! spin_lock_irqsave\n", DRIVER_PREFIX);
 
 	if (pnetwork->join_res > 0) {
 		spin_lock_bh(&(pmlmepriv->scanned_queue.lock));
@@ -1349,7 +1355,8 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
 			if (check_fwstate(pmlmepriv, WIFI_STATION_STATE) == true) {
 				ptarget_sta = rtw_joinbss_update_stainfo(adapter, pnetwork);
 				if (!ptarget_sta) {
-					RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("Can't update stainfo when joinbss_event callback\n"));
+					pr_err("%s Can't update stainfo when joinbss_event callback\n",
+					       DRIVER_PREFIX);
 					spin_unlock_bh(&(pmlmepriv->scanned_queue.lock));
 					goto ignore_joinbss_callback;
 				}
@@ -1361,16 +1368,18 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
 				rtw_indicate_connect(adapter);
 			} else {
 				/* adhoc mode will rtw_indicate_connect when rtw_stassoc_event_callback */
-				RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("adhoc mode, fw_state:%x", get_fwstate(pmlmepriv)));
+				pr_info("%s adhoc mode, fw_state:%x",
+					DRIVER_PREFIX, get_fwstate(pmlmepriv));
 			}
 
 			/* s5. Cancel assoc_timer */
 			del_timer_sync(&pmlmepriv->assoc_timer);
 
-			RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("Cancel assoc_timer\n"));
+			pr_info("%s Cancel assoc_timer\n", DRIVER_PREFIX);
 
 		} else {
-			RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("rtw_joinbss_event_callback err: fw_state:%x", get_fwstate(pmlmepriv)));
+			pr_err("%s rtw_joinbss_event_callback err: fw_state:%x",
+			       DRIVER_PREFIX, get_fwstate(pmlmepriv));
 			spin_unlock_bh(&(pmlmepriv->scanned_queue.lock));
 			goto ignore_joinbss_callback;
 		}
@@ -1384,7 +1393,8 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
 		/* rtw_free_assoc_resources(adapter, 1); */
 
 		if ((check_fwstate(pmlmepriv, _FW_UNDER_LINKING)) == true) {
-			RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("fail! clear _FW_UNDER_LINKING ^^^fw_state =%x\n", get_fwstate(pmlmepriv)));
+			pr_err("%s fail! clear _FW_UNDER_LINKING ^^^fw_state =%x\n",
+			       DRIVER_PREFIX, get_fwstate(pmlmepriv));
 			_clr_fwstate_(pmlmepriv, _FW_UNDER_LINKING);
 		}
 
@@ -1394,7 +1404,8 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
 		res = _FAIL;
 		if (retry < 2) {
 			res = rtw_select_and_join_from_scanned_queue(pmlmepriv);
-			RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("rtw_select_and_join_from_scanned_queue again! res:%d\n", res));
+			pr_err("%s rtw_select_and_join_from_scanned_queue again! res:%d\n",
+			       DRIVER_PREFIX, res);
 		}
 
 		if (res == _SUCCESS) {
@@ -1405,7 +1416,8 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
 			_clr_fwstate_(pmlmepriv, _FW_UNDER_LINKING);
 			rtw_indicate_connect(adapter);
 		} else {
-			RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("Set Assoc_Timer = 1; can't find match ssid in scanned_q\n"));
+			pr_err("%s Set Assoc_Timer = 1; can't find match ssid in scanned_q\n",
+			       DRIVER_PREFIX);
 		#endif
 
 			_set_timer(&pmlmepriv->assoc_timer, 1);
@@ -1495,14 +1507,16 @@ void rtw_stassoc_event_callback(struct adapter *adapter, u8 *pbuf)
 	if (psta) {
 		/* the sta have been in sta_info_queue => do nothing */
 
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("Error: rtw_stassoc_event_callback: sta has been in sta_hash_queue\n"));
+		pr_err("%s Error: %s: sta has been in sta_hash_queue\n",
+		       DRIVER_PREFIX, __func__);
 
 		return; /* between drv has received this event before and  fw have not yet to set key to CAM_ENTRY) */
 	}
 
 	psta = rtw_alloc_stainfo(&adapter->stapriv, pstassoc->macaddr);
 	if (!psta) {
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("Can't alloc sta_info when rtw_stassoc_event_callback\n"));
+		pr_err("%s Can't alloc sta_info when %s\n",
+		       DRIVER_PREFIX, __func__);
 		return;
 	}
 
@@ -1653,7 +1667,8 @@ void rtw_stadel_event_callback(struct adapter *adapter, u8 *pbuf)
 			}
 
 			if (rtw_createbss_cmd(adapter) != _SUCCESS)
-				RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("***Error =>stadel_event_callback: rtw_createbss_cmd status FAIL***\n "));
+				pr_err("%s ***Error =>%s: rtw_createbss_cmd status FAIL***\n ",
+				       DRIVER_PREFIX, __func__);
 		}
 
 	}
@@ -1665,7 +1680,7 @@ void rtw_cpwm_event_callback(struct adapter *padapter, u8 *pbuf)
 {
 	struct reportpwrstate_parm *preportpwrstate;
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("+rtw_cpwm_event_callback !!!\n"));
+	pr_err("%s+%s !!!\n", DRIVER_PREFIX, __func__);
 	preportpwrstate = (struct reportpwrstate_parm *)pbuf;
 	preportpwrstate->state |= (u8)(adapter_to_pwrctl(padapter)->cpwm_tog + 0x80);
 	cpwm_int_hdl(padapter, preportpwrstate);
@@ -1931,7 +1946,7 @@ int rtw_select_roaming_candidate(struct mlme_priv *mlme)
 
 		pnetwork = container_of(mlme->pscanned, struct wlan_network, list);
 		if (!pnetwork) {
-			RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("%s return _FAIL:(pnetwork == NULL)\n", __func__));
+			pr_err("%s %s return _FAIL:(pnetwork == NULL)\n", DRIVER_PREFIX, __func__);
 			ret = _FAIL;
 			goto exit;
 		}
@@ -2061,7 +2076,8 @@ int rtw_select_and_join_from_scanned_queue(struct mlme_priv *pmlmepriv)
 
 		pnetwork = container_of(pmlmepriv->pscanned, struct wlan_network, list);
 		if (!pnetwork) {
-			RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("%s return _FAIL:(pnetwork == NULL)\n", __func__));
+			pr_err("%s %s return _FAIL:(pnetwork == NULL)\n",
+			       DRIVER_PREFIX, __func__);
 			ret = _FAIL;
 			goto exit;
 		}
@@ -2138,7 +2154,8 @@ signed int rtw_set_auth(struct adapter *adapter, struct security_priv *psecurity
 
 	INIT_LIST_HEAD(&pcmd->list);
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("after enqueue set_auth_cmd, auth_mode =%x\n", psecuritypriv->dot11AuthAlgrthm));
+	pr_err("%s after enqueue set_auth_cmd, auth_mode =%x\n",
+	       DRIVER_PREFIX, psecuritypriv->dot11AuthAlgrthm);
 
 	res = rtw_enqueue_cmd(pcmdpriv, pcmd);
 
@@ -2162,10 +2179,12 @@ signed int rtw_set_key(struct adapter *adapter, struct security_priv *psecurityp
 
 	if (psecuritypriv->dot11AuthAlgrthm == dot11AuthAlgrthm_8021X) {
 		psetkeyparm->algorithm = (unsigned char)psecuritypriv->dot118021XGrpPrivacy;
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("\n rtw_set_key: psetkeyparm->algorithm =(unsigned char)psecuritypriv->dot118021XGrpPrivacy =%d\n", psetkeyparm->algorithm));
+		pr_err("%s %s: psetkeyparm->algorithm =(unsigned char)psecuritypriv->dot118021XGrpPrivacy =%d\n",
+		       DRIVER_PREFIX, __func__, psetkeyparm->algorithm);
 	} else {
 		psetkeyparm->algorithm = (u8)psecuritypriv->dot11PrivacyAlgrthm;
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("\n rtw_set_key: psetkeyparm->algorithm =(u8)psecuritypriv->dot11PrivacyAlgrthm =%d\n", psetkeyparm->algorithm));
+		pr_err("%s %s: psetkeyparm->algorithm =(u8)psecuritypriv->dot11PrivacyAlgrthm =%d\n",
+		       DRIVER_PREFIX, __func__, psetkeyparm->algorithm);
 
 	}
 	psetkeyparm->keyid = (u8)keyid;/* 0~3 */
@@ -2174,7 +2193,8 @@ signed int rtw_set_key(struct adapter *adapter, struct security_priv *psecurityp
 		adapter->securitypriv.key_mask |= BIT(psetkeyparm->keyid);
 
 	DBG_871X("==> rtw_set_key algorithm(%x), keyid(%x), key_mask(%x)\n", psetkeyparm->algorithm, psetkeyparm->keyid, adapter->securitypriv.key_mask);
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("\n rtw_set_key: psetkeyparm->algorithm =%d psetkeyparm->keyid =(u8)keyid =%d\n", psetkeyparm->algorithm, keyid));
+	pr_err("%s %s: psetkeyparm->algorithm =%d psetkeyparm->keyid =(u8)keyid =%d\n",
+	       DRIVER_PREFIX, __func__, psetkeyparm->algorithm, keyid);
 
 	switch (psetkeyparm->algorithm) {
 
@@ -2197,7 +2217,8 @@ signed int rtw_set_key(struct adapter *adapter, struct security_priv *psecurityp
 		psetkeyparm->grpkey = 1;
 		break;
 	default:
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("\n rtw_set_key:psecuritypriv->dot11PrivacyAlgrthm = %x (must be 1 or 2 or 4 or 5)\n", psecuritypriv->dot11PrivacyAlgrthm));
+		pr_err("%s %s:psecuritypriv->dot11PrivacyAlgrthm = %x (must be 1 or 2 or 4 or 5)\n",
+		       DRIVER_PREFIX, __func__, psecuritypriv->dot11PrivacyAlgrthm);
 		res = _FAIL;
 		kfree(psetkeyparm);
 		goto exit;
@@ -2331,8 +2352,8 @@ signed int rtw_restruct_sec_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie, u
 	struct security_priv *psecuritypriv = &adapter->securitypriv;
 	uint	ndisauthmode = psecuritypriv->ndisauthtype;
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_notice_,
-		 ("+rtw_restruct_sec_ie: ndisauthmode =%d\n", ndisauthmode));
+	pr_notice("%s+%s: ndisauthmode =%d\n", DRIVER_PREFIX,
+		  __func__, ndisauthmode);
 
 	/* copy fixed ie only */
 	memcpy(out_ie, in_ie, 12);
@@ -2430,7 +2451,8 @@ void rtw_update_registrypriv_dev_network(struct adapter *adapter)
 	}
 
 	pdev_network->Configuration.DSConfig = (pregistrypriv->channel);
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("pregistrypriv->channel =%d, pdev_network->Configuration.DSConfig = 0x%x\n", pregistrypriv->channel, pdev_network->Configuration.DSConfig));
+	pr_info("%s pregistrypriv->channel =%d, pdev_network->Configuration.DSConfig = 0x%x\n",
+		DRIVER_PREFIX, pregistrypriv->channel, pdev_network->Configuration.DSConfig);
 
 	if (cur_network->network.InfrastructureMode == Ndis802_11IBSS)
 		pdev_network->Configuration.ATIMWindow = (0);
-- 
2.20.1

