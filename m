Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73FF3353334
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 11:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236638AbhDCJPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 05:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236646AbhDCJOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 05:14:42 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51057C061788
        for <linux-kernel@vger.kernel.org>; Sat,  3 Apr 2021 02:14:39 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id a6so528745wrw.8
        for <linux-kernel@vger.kernel.org>; Sat, 03 Apr 2021 02:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4rHpbjsfHBVEJF1AGlk0EnapOnkITP8ioNJ02gJYHZY=;
        b=BiCWE04wlBxL+95aOI51pFzZalCZV2rkmp+wJZvLOlXmCRRSfH6gexEDa8Ph/ekB+h
         yS3oot+VGQ9eYPUqoDINi9qKr3DvnONP4bvRWSxN9V5lwrRsx4CbTqcbdGxeOcFcLQ5t
         vb/ZOb4vZQDZdpeYSFTNI4dj0rKNq8Zv0LV7vPcveUsmM6nFbPBk9ge2g20NV13din9b
         LKWCg6Z72Cze6geBOGJqov5elD8SWEhICo5Js9Yrj/20H47tk7Nl07Ece5kO7Kx82659
         dGEDE60pbVzCEfhLGfOiUSFRMdpEMncPovOfZuDXLZ//J6hxVe/cB6jv0hl9z9eHeqTX
         p42A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4rHpbjsfHBVEJF1AGlk0EnapOnkITP8ioNJ02gJYHZY=;
        b=t9xI+2Di8pIxObw3WQA++rEswbFwhYX5XhVUyekpQDY1wCvlJnVnoZDIBmhYZbdlk7
         /VaocMiZeT/qjMw6sm4wPNxagoghBi7NMMn+8IUVeimaIA3cltcwgpu/apXkcHM7Vb1m
         gupwym8bVJIva4/ORuxxESt/AvKVzPGWbqBPb6LNvvFB7Rs1n5KnTu6sBa2utB35eD6Z
         PUFgWb/lUg/Cgf8xmPDM/+vlqANb8ukz670xG89KGxeifpwCahxu2C7cpQobqu5Dimks
         ZbNVMR0jAX03HT6aoPnlLrnttRROkIras0P+Ik46vZVFl49rN5WKPHyuEmzmsjdEM+gA
         LtEQ==
X-Gm-Message-State: AOAM531Cy2hzGM0MLd+PS5b1l4Qk9fjhOOlOktiwsJ7AAaS4AXck9IHZ
        3dGsUfpi4L+xBggpg0OHp/I=
X-Google-Smtp-Source: ABdhPJwn55/XBj68gOCT/euDbkgwcbVXi7MtD3gwVLWA/DwDTX6tNUljEZn3u5F1kMSg6I5yRdGkxw==
X-Received: by 2002:a05:6000:18d2:: with SMTP id w18mr19264099wrq.88.1617441278066;
        Sat, 03 Apr 2021 02:14:38 -0700 (PDT)
Received: from agape ([5.171.72.64])
        by smtp.gmail.com with ESMTPSA id m5sm2348559wrx.83.2021.04.03.02.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Apr 2021 02:14:37 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH v3 15/30] staging: rtl8723bs: remove RT_TRACE logs in core/rtw_mlme.c
Date:   Sat,  3 Apr 2021 11:13:37 +0200
Message-Id: <19cc25a51af207e68a95e76ce384a3f7b7d2c408.1617440834.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617440833.git.fabioaiuto83@gmail.com>
References: <cover.1617440833.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove all of the RT_TRACE logs in the core/rtw_mlme.c file as they
currently do nothing as they require the code to be modified by
hand in order to be turned on. This obviously has not happened
since the code was merged. Moreover it relies on an unneeded
private log level tracing which overrides the in-kernel public one,
so just remove them as they are unused.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 105 ++++------------------
 1 file changed, 15 insertions(+), 90 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 4289bf40aa73..e8a39519fed8 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -155,8 +155,6 @@ struct	wlan_network *rtw_alloc_network(struct	mlme_priv *pmlmepriv)
 
 	list_del_init(&pnetwork->list);
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_,
-		 ("rtw_alloc_network: ptr =%p\n", plist));
 	pnetwork->network_type = 0;
 	pnetwork->fixed = false;
 	pnetwork->last_scanned = jiffies;
@@ -298,11 +296,11 @@ signed int rtw_if_up(struct adapter *padapter)
 	signed int res;
 
 	if (padapter->bDriverStopped || padapter->bSurpriseRemoved ||
-		(check_fwstate(&padapter->mlmepriv, _FW_LINKED) == false)) {
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_if_up:bDriverStopped(%d) OR bSurpriseRemoved(%d)", padapter->bDriverStopped, padapter->bSurpriseRemoved));
+		(check_fwstate(&padapter->mlmepriv, _FW_LINKED) == false))
 		res = false;
-	} else
+	else
 		res =  true;
+
 	return res;
 }
 
@@ -339,7 +337,6 @@ u8 *rtw_get_beacon_interval_from_ie(u8 *ie)
 
 void rtw_free_mlme_priv(struct mlme_priv *pmlmepriv)
 {
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("rtw_free_mlme_priv\n"));
 	_rtw_free_mlme_priv(pmlmepriv);
 }
 
@@ -607,10 +604,9 @@ void rtw_update_scanned_network(struct adapter *adapter, struct wlan_bssid_ex *t
 			/* If there are no more slots, expire the oldest */
 			/* list_del_init(&oldest->list); */
 			pnetwork = oldest;
-			if (!pnetwork) {
-				RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("\n\n\nsomething wrong here\n\n\n"));
+			if (!pnetwork)
 				goto exit;
-			}
+
 			memcpy(&(pnetwork->network), target,  get_wlan_bssid_ex_sz(target));
 			/*  variable initialize */
 			pnetwork->fixed = false;
@@ -628,10 +624,8 @@ void rtw_update_scanned_network(struct adapter *adapter, struct wlan_bssid_ex *t
 
 			pnetwork = rtw_alloc_network(pmlmepriv); /*  will update scan_time */
 
-			if (!pnetwork) {
-				RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("\n\n\nsomething wrong here\n\n\n"));
+			if (!pnetwork)
 				goto exit;
-			}
 
 			bssid_ex_sz = get_wlan_bssid_ex_sz(target);
 			target->Length = bssid_ex_sz;
@@ -750,7 +744,6 @@ int rtw_is_desired_network(struct adapter *adapter, struct wlan_network *pnetwor
 /* TODO: Perry : For Power Management */
 void rtw_atimdone_event_callback(struct adapter	*adapter, u8 *pbuf)
 {
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("receive atimdone_event\n"));
 }
 
 void rtw_survey_event_callback(struct adapter	*adapter, u8 *pbuf)
@@ -761,13 +754,9 @@ void rtw_survey_event_callback(struct adapter	*adapter, u8 *pbuf)
 
 	pnetwork = (struct wlan_bssid_ex *)pbuf;
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_survey_event_callback, ssid =%s\n",  pnetwork->Ssid.Ssid));
-
 	len = get_wlan_bssid_ex_sz(pnetwork);
-	if (len > (sizeof(struct wlan_bssid_ex))) {
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("\n ****rtw_survey_event_callback: return a wrong bss ***\n"));
+	if (len > (sizeof(struct wlan_bssid_ex)))
 		return;
-	}
 
 	spin_lock_bh(&pmlmepriv->lock);
 
@@ -811,14 +800,9 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
 		pmlmepriv->wps_probe_req_ie = NULL;
 	}
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_surveydone_event_callback: fw_state:%x\n\n", get_fwstate(pmlmepriv)));
-
 	if (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY)) {
 		del_timer_sync(&pmlmepriv->scan_to_timer);
 		_clr_fwstate_(pmlmepriv, _FW_UNDER_SURVEY);
-	} else {
-
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("nic status =%x, survey done event comes too late!\n", get_fwstate(pmlmepriv)));
 	}
 
 	rtw_set_signal_stat_timer(&adapter->recvpriv);
@@ -837,8 +821,6 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
 					/* pmlmepriv->fw_state ^= _FW_UNDER_SURVEY;because don't set assoc_timer */
 					_clr_fwstate_(pmlmepriv, _FW_UNDER_SURVEY);
 
-					RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("switching to adhoc master\n"));
-
 					memcpy(&pdev_network->Ssid, &pmlmepriv->assoc_ssid, sizeof(struct ndis_802_11_ssid));
 
 					rtw_update_registrypriv_dev_network(adapter);
@@ -847,7 +829,7 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
 					pmlmepriv->fw_state = WIFI_ADHOC_MASTER_STATE;
 
 					if (rtw_createbss_cmd(adapter) != _SUCCESS)
-						RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("Error =>rtw_createbss_cmd status FAIL\n"));
+						;
 
 					pmlmepriv->to_join = false;
 				}
@@ -919,7 +901,6 @@ static void free_scanqueue(struct	mlme_priv *pmlmepriv)
 	struct __queue *scan_queue = &pmlmepriv->scanned_queue;
 	struct list_head	*plist, *phead, *ptemp;
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_notice_, ("+free_scanqueue\n"));
 	spin_lock_bh(&scan_queue->lock);
 	spin_lock_bh(&free_queue->lock);
 
@@ -956,8 +937,6 @@ static void find_network(struct adapter *adapter)
 	pwlan = rtw_find_network(&pmlmepriv->scanned_queue, tgt_network->network.MacAddress);
 	if (pwlan)
 		pwlan->fixed = false;
-	else
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("rtw_free_assoc_resources : pwlan == NULL\n\n"));
 
 	if (check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE) &&
 	    (adapter->stapriv.asoc_sta_count == 1))
@@ -975,10 +954,6 @@ void rtw_free_assoc_resources(struct adapter *adapter, int lock_scanned_queue)
 	struct dvobj_priv *psdpriv = adapter->dvobj;
 	struct debug_priv *pdbgpriv = &psdpriv->drv_dbg;
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_notice_, ("+rtw_free_assoc_resources\n"));
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("tgt_network->network.MacAddress =%pM ssid =%s\n",
-		MAC_ARG(tgt_network->network.MacAddress), tgt_network->network.Ssid.Ssid));
-
 	if (check_fwstate(pmlmepriv, WIFI_STATION_STATE|WIFI_AP_STATE)) {
 		struct sta_info *psta;
 
@@ -1016,8 +991,6 @@ void rtw_indicate_connect(struct adapter *padapter)
 {
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("+rtw_indicate_connect\n"));
-
 	pmlmepriv->to_join = false;
 
 	if (!check_fwstate(&padapter->mlmepriv, _FW_LINKED)) {
@@ -1030,7 +1003,6 @@ void rtw_indicate_connect(struct adapter *padapter)
 	rtw_set_to_roam(padapter, 0);
 	rtw_set_scan_deny(padapter, 3000);
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("-rtw_indicate_connect: fw_state = 0x%08x\n", get_fwstate(pmlmepriv)));
 }
 
 /*
@@ -1040,8 +1012,6 @@ void rtw_indicate_disconnect(struct adapter *padapter)
 {
 	struct	mlme_priv *pmlmepriv = &padapter->mlmepriv;
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("+rtw_indicate_disconnect\n"));
-
 	_clr_fwstate_(pmlmepriv, _FW_UNDER_LINKING|WIFI_UNDER_WPS);
 
 	/* DBG_871X("clear wps when %s\n", __func__); */
@@ -1207,9 +1177,6 @@ static void rtw_joinbss_update_network(struct adapter *padapter, struct wlan_net
 	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
 	struct wlan_network  *cur_network = &(pmlmepriv->cur_network);
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("\nfw_state:%x, BSSID:%pM\n"
-		, get_fwstate(pmlmepriv), MAC_ARG(pnetwork->network.MacAddress)));
-
 	/*  why not use ptarget_wlan?? */
 	memcpy(&cur_network->network, &pnetwork->network, pnetwork->network.Length);
 	/*  some IEs in pnetwork is wrong, so we should use ptarget_wlan IEs */
@@ -1251,7 +1218,6 @@ static void rtw_joinbss_update_network(struct adapter *padapter, struct wlan_net
 			break;
 	default:
 			pmlmepriv->fw_state = WIFI_NULL_STATE;
-			RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("Invalid network_mode\n"));
 			break;
 	}
 
@@ -1280,30 +1246,19 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
 	struct wlan_network	*pcur_wlan = NULL, *ptarget_wlan = NULL;
 	unsigned int		the_same_macaddr = false;
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("joinbss event call back received with res =%d\n", pnetwork->join_res));
-
 	rtw_get_encrypt_decrypt_from_registrypriv(adapter);
 
-	if (pmlmepriv->assoc_ssid.SsidLength == 0)
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("@@@@@   joinbss event call back  for Any SSid\n"));
-	else
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("@@@@@   rtw_joinbss_event_callback for SSid:%s\n", pmlmepriv->assoc_ssid.Ssid));
-
 	the_same_macaddr = !memcmp(pnetwork->network.MacAddress, cur_network->network.MacAddress, ETH_ALEN);
 
 	pnetwork->network.Length = get_wlan_bssid_ex_sz(&pnetwork->network);
-	if (pnetwork->network.Length > sizeof(struct wlan_bssid_ex)) {
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("\n\n ***joinbss_evt_callback return a wrong bss ***\n\n"));
+	if (pnetwork->network.Length > sizeof(struct wlan_bssid_ex))
 		return;
-	}
 
 	spin_lock_bh(&pmlmepriv->lock);
 
 	pmlmepriv->LinkDetectInfo.TrafficTransitionCount = 0;
 	pmlmepriv->LinkDetectInfo.LowPowerTransitionCount = 0;
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("\n rtw_joinbss_event_callback !! spin_lock_irqsave\n"));
-
 	if (pnetwork->join_res > 0) {
 		spin_lock_bh(&(pmlmepriv->scanned_queue.lock));
 		retry = 0;
@@ -1349,7 +1304,6 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
 			if (check_fwstate(pmlmepriv, WIFI_STATION_STATE) == true) {
 				ptarget_sta = rtw_joinbss_update_stainfo(adapter, pnetwork);
 				if (!ptarget_sta) {
-					RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("Can't update stainfo when joinbss_event callback\n"));
 					spin_unlock_bh(&(pmlmepriv->scanned_queue.lock));
 					goto ignore_joinbss_callback;
 				}
@@ -1359,18 +1313,12 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
 			if (check_fwstate(pmlmepriv, WIFI_STATION_STATE) == true) {
 				pmlmepriv->cur_network_scanned = ptarget_wlan;
 				rtw_indicate_connect(adapter);
-			} else {
-				/* adhoc mode will rtw_indicate_connect when rtw_stassoc_event_callback */
-				RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("adhoc mode, fw_state:%x", get_fwstate(pmlmepriv)));
 			}
 
 			/* s5. Cancel assoc_timer */
 			del_timer_sync(&pmlmepriv->assoc_timer);
 
-			RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("Cancel assoc_timer\n"));
-
 		} else {
-			RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("rtw_joinbss_event_callback err: fw_state:%x", get_fwstate(pmlmepriv)));
 			spin_unlock_bh(&(pmlmepriv->scanned_queue.lock));
 			goto ignore_joinbss_callback;
 		}
@@ -1383,19 +1331,15 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
 
 		/* rtw_free_assoc_resources(adapter, 1); */
 
-		if ((check_fwstate(pmlmepriv, _FW_UNDER_LINKING)) == true) {
-			RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("fail! clear _FW_UNDER_LINKING ^^^fw_state =%x\n", get_fwstate(pmlmepriv)));
+		if ((check_fwstate(pmlmepriv, _FW_UNDER_LINKING)) == true)
 			_clr_fwstate_(pmlmepriv, _FW_UNDER_LINKING);
-		}
 
 	} else {/* if join_res < 0 (join fails), then try again */
 
 		#ifdef REJOIN
 		res = _FAIL;
-		if (retry < 2) {
+		if (retry < 2)
 			res = rtw_select_and_join_from_scanned_queue(pmlmepriv);
-			RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("rtw_select_and_join_from_scanned_queue again! res:%d\n", res));
-		}
 
 		if (res == _SUCCESS) {
 			/* extend time of assoc_timer */
@@ -1405,7 +1349,6 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
 			_clr_fwstate_(pmlmepriv, _FW_UNDER_LINKING);
 			rtw_indicate_connect(adapter);
 		} else {
-			RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("Set Assoc_Timer = 1; can't find match ssid in scanned_q\n"));
 		#endif
 
 			_set_timer(&pmlmepriv->assoc_timer, 1);
@@ -1495,16 +1438,12 @@ void rtw_stassoc_event_callback(struct adapter *adapter, u8 *pbuf)
 	if (psta) {
 		/* the sta have been in sta_info_queue => do nothing */
 
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("Error: rtw_stassoc_event_callback: sta has been in sta_hash_queue\n"));
-
 		return; /* between drv has received this event before and  fw have not yet to set key to CAM_ENTRY) */
 	}
 
 	psta = rtw_alloc_stainfo(&adapter->stapriv, pstassoc->macaddr);
-	if (!psta) {
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("Can't alloc sta_info when rtw_stassoc_event_callback\n"));
+	if (!psta)
 		return;
-	}
 
 	/* to do : init sta_info variable */
 	psta->qos_option = 0;
@@ -1653,7 +1592,7 @@ void rtw_stadel_event_callback(struct adapter *adapter, u8 *pbuf)
 			}
 
 			if (rtw_createbss_cmd(adapter) != _SUCCESS)
-				RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("***Error =>stadel_event_callback: rtw_createbss_cmd status FAIL***\n "));
+				;
 		}
 
 	}
@@ -1665,7 +1604,6 @@ void rtw_cpwm_event_callback(struct adapter *padapter, u8 *pbuf)
 {
 	struct reportpwrstate_parm *preportpwrstate;
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("+rtw_cpwm_event_callback !!!\n"));
 	preportpwrstate = (struct reportpwrstate_parm *)pbuf;
 	preportpwrstate->state |= (u8)(adapter_to_pwrctl(padapter)->cpwm_tog + 0x80);
 	cpwm_int_hdl(padapter, preportpwrstate);
@@ -1931,7 +1869,6 @@ int rtw_select_roaming_candidate(struct mlme_priv *mlme)
 
 		pnetwork = container_of(mlme->pscanned, struct wlan_network, list);
 		if (!pnetwork) {
-			RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("%s return _FAIL:(pnetwork == NULL)\n", __func__));
 			ret = _FAIL;
 			goto exit;
 		}
@@ -2061,7 +1998,6 @@ int rtw_select_and_join_from_scanned_queue(struct mlme_priv *pmlmepriv)
 
 		pnetwork = container_of(pmlmepriv->pscanned, struct wlan_network, list);
 		if (!pnetwork) {
-			RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("%s return _FAIL:(pnetwork == NULL)\n", __func__));
 			ret = _FAIL;
 			goto exit;
 		}
@@ -2138,8 +2074,6 @@ signed int rtw_set_auth(struct adapter *adapter, struct security_priv *psecurity
 
 	INIT_LIST_HEAD(&pcmd->list);
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("after enqueue set_auth_cmd, auth_mode =%x\n", psecuritypriv->dot11AuthAlgrthm));
-
 	res = rtw_enqueue_cmd(pcmdpriv, pcmd);
 
 exit:
@@ -2160,21 +2094,17 @@ signed int rtw_set_key(struct adapter *adapter, struct security_priv *psecurityp
 		goto exit;
 	}
 
-	if (psecuritypriv->dot11AuthAlgrthm == dot11AuthAlgrthm_8021X) {
+	if (psecuritypriv->dot11AuthAlgrthm == dot11AuthAlgrthm_8021X)
 		psetkeyparm->algorithm = (unsigned char)psecuritypriv->dot118021XGrpPrivacy;
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("\n rtw_set_key: psetkeyparm->algorithm =(unsigned char)psecuritypriv->dot118021XGrpPrivacy =%d\n", psetkeyparm->algorithm));
-	} else {
+	else
 		psetkeyparm->algorithm = (u8)psecuritypriv->dot11PrivacyAlgrthm;
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("\n rtw_set_key: psetkeyparm->algorithm =(u8)psecuritypriv->dot11PrivacyAlgrthm =%d\n", psetkeyparm->algorithm));
 
-	}
 	psetkeyparm->keyid = (u8)keyid;/* 0~3 */
 	psetkeyparm->set_tx = set_tx;
 	if (is_wep_enc(psetkeyparm->algorithm))
 		adapter->securitypriv.key_mask |= BIT(psetkeyparm->keyid);
 
 	DBG_871X("==> rtw_set_key algorithm(%x), keyid(%x), key_mask(%x)\n", psetkeyparm->algorithm, psetkeyparm->keyid, adapter->securitypriv.key_mask);
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("\n rtw_set_key: psetkeyparm->algorithm =%d psetkeyparm->keyid =(u8)keyid =%d\n", psetkeyparm->algorithm, keyid));
 
 	switch (psetkeyparm->algorithm) {
 
@@ -2197,7 +2127,6 @@ signed int rtw_set_key(struct adapter *adapter, struct security_priv *psecurityp
 		psetkeyparm->grpkey = 1;
 		break;
 	default:
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("\n rtw_set_key:psecuritypriv->dot11PrivacyAlgrthm = %x (must be 1 or 2 or 4 or 5)\n", psecuritypriv->dot11PrivacyAlgrthm));
 		res = _FAIL;
 		kfree(psetkeyparm);
 		goto exit;
@@ -2331,9 +2260,6 @@ signed int rtw_restruct_sec_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie, u
 	struct security_priv *psecuritypriv = &adapter->securitypriv;
 	uint	ndisauthmode = psecuritypriv->ndisauthtype;
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_notice_,
-		 ("+rtw_restruct_sec_ie: ndisauthmode =%d\n", ndisauthmode));
-
 	/* copy fixed ie only */
 	memcpy(out_ie, in_ie, 12);
 	ielength = 12;
@@ -2430,7 +2356,6 @@ void rtw_update_registrypriv_dev_network(struct adapter *adapter)
 	}
 
 	pdev_network->Configuration.DSConfig = (pregistrypriv->channel);
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("pregistrypriv->channel =%d, pdev_network->Configuration.DSConfig = 0x%x\n", pregistrypriv->channel, pdev_network->Configuration.DSConfig));
 
 	if (cur_network->network.InfrastructureMode == Ndis802_11IBSS)
 		pdev_network->Configuration.ATIMWindow = (0);
-- 
2.20.1

