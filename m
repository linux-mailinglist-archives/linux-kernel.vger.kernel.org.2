Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 044593DCD28
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Aug 2021 21:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbhHATFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 15:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbhHATEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 15:04:55 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B206FC06175F
        for <linux-kernel@vger.kernel.org>; Sun,  1 Aug 2021 12:04:46 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id a192-20020a1c7fc90000b0290253b32e8796so9978503wmd.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 Aug 2021 12:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kttLdaGvW7x3nXrJqKXA3c0Mejq7M9B4N+Wp8huNdzs=;
        b=wbROOeFejNEvc6USZZRPfIzONAsFVrQtTXgK78O74d75Y5v3Veaplt+wzA+5yhRGIo
         b8hq+hJfhARgDeIxFGWh9PBVixkR2U62PATHhe8ZnJkiYzYgDXMXQ7X3KhWdIyIWRJAY
         x/l57aV2xPPu8vq7bskmIUHFULclWyY3zBbYDtVkmEK94hm4En9ryIiRt6vqyDrnJIiC
         Fz7lkdyG2Pmp0UABPxezpxzOTEQEZyhg2ROm4/Reka6D4SfkgglctoDwMaXsSg4qsV3E
         TIjcbVVsUe3bk85nNZk0IfmmwuYvSePLgt3qWMYI6RMpD42zsChfyQgc88Ktq2buDtPk
         zsYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kttLdaGvW7x3nXrJqKXA3c0Mejq7M9B4N+Wp8huNdzs=;
        b=WvbaSV2mnJg7yix5OMzLPw6gaUZDssCvq65YfNrEnI0E6NrRghTsUubk7HtplTR54z
         aSzOXPtAsQ06JU8roGw67a75DQkb9H9iaAH54AuWEkg6c4L3q36/fLMv1UWyFOBK5mTi
         jiDyDzOn7TPfgb1fwlGvDoOIkIZqEixJhSiSwv1+nZHdv603HLr8f6Ydo+qN/tHRKW5D
         rBY2dpoQri+pTXMB+UkkoZox+Wf6oms9e6bAxOYWu1rfNY/aKXMiQ8/jwJk+3eRFlWKO
         skrmVm1hEwGbMHZWyVBs9P6Od34hvKx6igWsTlc0iNQFYPxmJkTJZzY+lWADiwwQtp8L
         +fHA==
X-Gm-Message-State: AOAM530MnQ2I96fqzzYihTQTIVQca/9A0nc0uhRv4ySG7L7GFZWlm+1i
        0ZuG3tQbVtaFHKMxIGg6SE8FIA==
X-Google-Smtp-Source: ABdhPJxbkU3do8oA/gMqO+hDhVuCFBI6Zod0jAlwtaK6eakfhhwP9Hs3vGuMBM6WDq3V3CepPElnMg==
X-Received: by 2002:a7b:ce89:: with SMTP id q9mr12756492wmj.156.1627844685240;
        Sun, 01 Aug 2021 12:04:45 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id c10sm8196026wmb.40.2021.08.01.12.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Aug 2021 12:04:44 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, martin@kaiser.cx
Subject: [PATCH 07/15] staging: r8188eu: remove RT_TRACE calls from core/rtw_mlme.c
Date:   Sun,  1 Aug 2021 20:04:29 +0100
Message-Id: <20210801190437.82017-8-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210801190437.82017-1-phil@philpotter.co.uk>
References: <20210801190437.82017-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove RT_TRACE macro calls from core/rtw_mlme.c, so that ultimately the
macro definition itself can eventually be removed. Also remove the (now) empty
functions rtw_atimdone_event_callback and rtw_cpwm_event_callback, as
well as their declarations and struct inclusions in the relevant header
files.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/core/rtw_mlme.c       | 134 ++----------------
 drivers/staging/r8188eu/include/rtw_mlme.h    |   2 -
 .../staging/r8188eu/include/rtw_mlme_ext.h    |   4 +-
 3 files changed, 16 insertions(+), 124 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index d692f1477cc8..c597bd706927 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -194,7 +194,6 @@ struct	wlan_network *_rtw_alloc_network(struct	mlme_priv *pmlmepriv)/* _queue *f
 
 	list_del_init(&pnetwork->list);
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("_rtw_alloc_network: ptr=%p\n", plist));
 	pnetwork->network_type = 0;
 	pnetwork->fixed = false;
 	pnetwork->last_scanned = jiffies;
@@ -308,14 +307,10 @@ int rtw_if_up(struct adapter *padapter)
 	int res;
 
 	if (padapter->bDriverStopped || padapter->bSurpriseRemoved ||
-	    (check_fwstate(&padapter->mlmepriv, _FW_LINKED) == false)) {
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_,
-			 ("rtw_if_up:bDriverStopped(%d) OR bSurpriseRemoved(%d)",
-			 padapter->bDriverStopped, padapter->bSurpriseRemoved));
+	    (check_fwstate(&padapter->mlmepriv, _FW_LINKED) == false))
 		res = false;
-	} else {
+	else
 		res =  true;
-	}
 
 	return res;
 }
@@ -369,10 +364,7 @@ int	rtw_init_mlme_priv (struct adapter *padapter)/* struct	mlme_priv *pmlmepriv)
 
 void rtw_free_mlme_priv (struct mlme_priv *pmlmepriv)
 {
-
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("rtw_free_mlme_priv\n"));
 	_rtw_free_mlme_priv (pmlmepriv);
-
 }
 
 static struct wlan_network *rtw_alloc_network(struct mlme_priv *pmlmepriv)
@@ -588,10 +580,8 @@ void rtw_update_scanned_network(struct adapter *adapter, struct wlan_bssid_ex *t
 
 			pnetwork = rtw_alloc_network(pmlmepriv); /*  will update scan_time */
 
-			if (pnetwork == NULL) {
-				RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("\n\n\nsomething wrong here\n\n\n"));
+			if (pnetwork == NULL)
 				goto exit;
-			}
 
 			bssid_ex_sz = get_wlan_bssid_ex_sz(target);
 			target->Length = bssid_ex_sz;
@@ -699,15 +689,6 @@ static int rtw_is_desired_network(struct adapter *adapter, struct wlan_network *
 	return bselected;
 }
 
-/* TODO: Perry: For Power Management */
-void rtw_atimdone_event_callback(struct adapter	*adapter, u8 *pbuf)
-{
-
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("receive atimdone_evet\n"));
-
-	return;
-}
-
 void rtw_survey_event_callback(struct adapter	*adapter, u8 *pbuf)
 {
 	u32 len;
@@ -716,13 +697,9 @@ void rtw_survey_event_callback(struct adapter	*adapter, u8 *pbuf)
 
 	pnetwork = (struct wlan_bssid_ex *)pbuf;
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_survey_event_callback, ssid=%s\n",  pnetwork->Ssid.Ssid));
-
 	len = get_wlan_bssid_ex_sz(pnetwork);
-	if (len > (sizeof(struct wlan_bssid_ex))) {
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("\n****rtw_survey_event_callback: return a wrong bss ***\n"));
+	if (len > (sizeof(struct wlan_bssid_ex)))
 		return;
-	}
 	spin_lock_bh(&pmlmepriv->lock);
 
 	/*  update IBSS_network 's timestamp */
@@ -770,14 +747,10 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
 		pmlmepriv->wps_probe_req_ie = NULL;
 	}
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_surveydone_event_callback: fw_state:%x\n\n", get_fwstate(pmlmepriv)));
-
 	if (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY)) {
 		timer_cancelled = 1;
 
 		_clr_fwstate_(pmlmepriv, _FW_UNDER_SURVEY);
-	} else {
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("nic status=%x, survey done event comes too late!\n", get_fwstate(pmlmepriv)));
 	}
 
 	spin_unlock_bh(&pmlmepriv->lock);
@@ -801,8 +774,6 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
 
 					_clr_fwstate_(pmlmepriv, _FW_UNDER_SURVEY);
 
-					RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("switching to adhoc master\n"));
-
 					memset(&pdev_network->Ssid, 0, sizeof(struct ndis_802_11_ssid));
 					memcpy(&pdev_network->Ssid, &pmlmepriv->assoc_ssid, sizeof(struct ndis_802_11_ssid));
 
@@ -811,8 +782,7 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
 
 					pmlmepriv->fw_state = WIFI_ADHOC_MASTER_STATE;
 
-					if (rtw_createbss_cmd(adapter) != _SUCCESS)
-						RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("Error=>rtw_createbss_cmd status FAIL\n"));
+					rtw_createbss_cmd(adapter);
 					pmlmepriv->to_join = false;
 				}
 			}
@@ -873,7 +843,6 @@ static void free_scanqueue(struct	mlme_priv *pmlmepriv)
 	struct __queue *scan_queue = &pmlmepriv->scanned_queue;
 	struct list_head *plist, *phead, *ptemp;
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_notice_, ("+free_scanqueue\n"));
 	spin_lock_bh(&scan_queue->lock);
 	spin_lock_bh(&free_queue->lock);
 
@@ -902,11 +871,6 @@ void rtw_free_assoc_resources(struct adapter *adapter, int lock_scanned_queue)
 	struct	sta_priv *pstapriv = &adapter->stapriv;
 	struct wlan_network *tgt_network = &pmlmepriv->cur_network;
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_notice_, ("+rtw_free_assoc_resources\n"));
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_,
-		 ("tgt_network->network.MacAddress=%pM ssid=%s\n",
-		 tgt_network->network.MacAddress, tgt_network->network.Ssid.Ssid));
-
 	if (check_fwstate(pmlmepriv, WIFI_STATION_STATE | WIFI_AP_STATE)) {
 		struct sta_info *psta;
 
@@ -936,8 +900,6 @@ void rtw_free_assoc_resources(struct adapter *adapter, int lock_scanned_queue)
 	pwlan = rtw_find_network(&pmlmepriv->scanned_queue, tgt_network->network.MacAddress);
 	if (pwlan)
 		pwlan->fixed = false;
-	else
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("rtw_free_assoc_resources:pwlan==NULL\n\n"));
 
 	if ((check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE) && (adapter->stapriv.asoc_sta_count == 1)))
 		rtw_free_network_nolock(pmlmepriv, pwlan);
@@ -955,8 +917,6 @@ void rtw_indicate_connect(struct adapter *padapter)
 {
 	struct mlme_priv	*pmlmepriv = &padapter->mlmepriv;
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("+rtw_indicate_connect\n"));
-
 	pmlmepriv->to_join = false;
 
 	if (!check_fwstate(&padapter->mlmepriv, _FW_LINKED)) {
@@ -970,9 +930,6 @@ void rtw_indicate_connect(struct adapter *padapter)
 	pmlmepriv->to_roaming = 0;
 
 	rtw_set_scan_deny(padapter, 3000);
-
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("-rtw_indicate_connect: fw_state=0x%08x\n", get_fwstate(pmlmepriv)));
-
 }
 
 /*
@@ -982,8 +939,6 @@ void rtw_indicate_disconnect(struct adapter *padapter)
 {
 	struct	mlme_priv *pmlmepriv = &padapter->mlmepriv;
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("+rtw_indicate_disconnect\n"));
-
 	_clr_fwstate_(pmlmepriv, _FW_UNDER_LINKING | WIFI_UNDER_WPS);
 
 	if (pmlmepriv->to_roaming > 0)
@@ -1105,10 +1060,6 @@ static void rtw_joinbss_update_network(struct adapter *padapter, struct wlan_net
 
 	DBG_88E("%s\n", __func__);
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_,
-		 ("\nfw_state:%x, BSSID:%pM\n",
-		 get_fwstate(pmlmepriv), pnetwork->network.MacAddress));
-
 	/*  why not use ptarget_wlan?? */
 	memcpy(&cur_network->network, &pnetwork->network, pnetwork->network.Length);
 	/*  some IEs in pnetwork is wrong, so we should use ptarget_wlan IEs */
@@ -1137,7 +1088,6 @@ static void rtw_joinbss_update_network(struct adapter *padapter, struct wlan_net
 		break;
 	default:
 		pmlmepriv->fw_state = WIFI_NULL_STATE;
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("Invalid network_mode\n"));
 		break;
 	}
 
@@ -1165,27 +1115,16 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
 	struct wlan_network	*pcur_wlan = NULL, *ptarget_wlan = NULL;
 	unsigned int		the_same_macaddr = false;
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("joinbss event call back received with res=%d\n", pnetwork->join_res));
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
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("\nrtw_joinbss_event_callback!! spin_lock_init\n"));
-
 	if (pnetwork->join_res > 0) {
 		spin_lock_bh(&pmlmepriv->scanned_queue.lock);
 		if (check_fwstate(pmlmepriv, _FW_UNDER_LINKING)) {
@@ -1223,7 +1162,6 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
 			if (ptarget_wlan) {
 				rtw_joinbss_update_network(adapter, ptarget_wlan, pnetwork);
 			} else {
-				RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("Can't find ptarget_wlan when joinbss_event callback\n"));
 				spin_unlock_bh(&pmlmepriv->scanned_queue.lock);
 				goto ignore_joinbss_callback;
 			}
@@ -1232,7 +1170,6 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
 			if (check_fwstate(pmlmepriv, WIFI_STATION_STATE) == true) {
 				ptarget_sta = rtw_joinbss_update_stainfo(adapter, pnetwork);
 				if (ptarget_sta == NULL) {
-					RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("Can't update stainfo when joinbss_event callback\n"));
 					spin_unlock_bh(&pmlmepriv->scanned_queue.lock);
 					goto ignore_joinbss_callback;
 				}
@@ -1242,18 +1179,11 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
 				if (check_fwstate(pmlmepriv, WIFI_STATION_STATE) == true) {
 					pmlmepriv->cur_network_scanned = ptarget_wlan;
 					rtw_indicate_connect(adapter);
-				} else {
-					/* adhoc mode will rtw_indicate_connect when rtw_stassoc_event_callback */
-					RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("adhoc mode, fw_state:%x", get_fwstate(pmlmepriv)));
 				}
 
 			/* s5. Cancle assoc_timer */
 			_cancel_timer(&pmlmepriv->assoc_timer, &timer_cancelled);
-
-			RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("Cancle assoc_timer\n"));
-
 		} else {
-			RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("rtw_joinbss_event_callback err: fw_state:%x", get_fwstate(pmlmepriv)));
 			spin_unlock_bh(&pmlmepriv->scanned_queue.lock);
 			goto ignore_joinbss_callback;
 		}
@@ -1264,10 +1194,8 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
 		rtw_reset_securitypriv(adapter);
 		_set_timer(&pmlmepriv->assoc_timer, 1);
 
-		if ((check_fwstate(pmlmepriv, _FW_UNDER_LINKING)) == true) {
-			RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("fail! clear _FW_UNDER_LINKING ^^^fw_state=%x\n", get_fwstate(pmlmepriv)));
+		if ((check_fwstate(pmlmepriv, _FW_UNDER_LINKING)) == true)
 			_clr_fwstate_(pmlmepriv, _FW_UNDER_LINKING);
-		}
 	} else { /* if join_res < 0 (join fails), then try again */
 		_set_timer(&pmlmepriv->assoc_timer, 1);
 		_clr_fwstate_(pmlmepriv, _FW_UNDER_LINKING);
@@ -1355,16 +1283,14 @@ void rtw_stassoc_event_callback(struct adapter *adapter, u8 *pbuf)
 #endif
 	/* for AD-HOC mode */
 	psta = rtw_get_stainfo(&adapter->stapriv, pstassoc->macaddr);
-	if (psta != NULL) {
+	if (psta != NULL)
 		/* the sta have been in sta_info_queue => do nothing */
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("Error: rtw_stassoc_event_callback: sta has been in sta_hash_queue\n"));
 		return; /* between drv has received this event before and  fw have not yet to set key to CAM_ENTRY) */
-	}
+
 	psta = rtw_alloc_stainfo(&adapter->stapriv, pstassoc->macaddr);
-	if (psta == NULL) {
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("Can't alloc sta_info when rtw_stassoc_event_callback\n"));
+	if (psta == NULL)
 		return;
-	}
+
 	/* to do: init sta_info variable */
 	psta->qos_option = 0;
 	psta->mac_id = (uint)pstassoc->cam_id;
@@ -1486,21 +1412,13 @@ void rtw_stadel_event_callback(struct adapter *adapter, u8 *pbuf)
 				_clr_fwstate_(pmlmepriv, WIFI_ADHOC_STATE);
 			}
 
-			if (rtw_createbss_cmd(adapter) != _SUCCESS)
-				RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("***Error=>stadel_event_callback: rtw_createbss_cmd status FAIL***\n "));
+			rtw_createbss_cmd(adapter);
 		}
 	}
 	spin_unlock_bh(&pmlmepriv->lock);
 
 }
 
-void rtw_cpwm_event_callback(struct adapter *padapter, u8 *pbuf)
-{
-
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("+rtw_cpwm_event_callback !!!\n"));
-
-}
-
 /*
 * _rtw_join_timeout_handler - Timeout/faliure handler for CMD JoinBss
 * @adapter: pointer to struct adapter structure
@@ -1699,7 +1617,6 @@ int rtw_select_and_join_from_scanned_queue(struct mlme_priv *pmlmepriv)
 	while (phead != pmlmepriv->pscanned) {
 		pnetwork = container_of(pmlmepriv->pscanned, struct wlan_network, list);
 		if (pnetwork == NULL) {
-			RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("%s return _FAIL:(pnetwork==NULL)\n", __func__));
 			ret = _FAIL;
 			goto exit;
 		}
@@ -1770,9 +1687,6 @@ int rtw_set_auth(struct adapter *adapter, struct security_priv *psecuritypriv)
 	pcmd->rsp = NULL;
 	pcmd->rspsz = 0;
 	INIT_LIST_HEAD(&pcmd->list);
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_,
-		 ("after enqueue set_auth_cmd, auth_mode=%x\n",
-		 psecuritypriv->dot11AuthAlgrthm));
 	res = rtw_enqueue_cmd(pcmdpriv, pcmd);
 exit:
 
@@ -1802,25 +1716,15 @@ int rtw_set_key(struct adapter *adapter, struct security_priv *psecuritypriv, in
 
 	memset(psetkeyparm, 0, sizeof(struct setkey_parm));
 
-	if (psecuritypriv->dot11AuthAlgrthm == dot11AuthAlgrthm_8021X) {
+	if (psecuritypriv->dot11AuthAlgrthm == dot11AuthAlgrthm_8021X)
 		psetkeyparm->algorithm = (unsigned char)psecuritypriv->dot118021XGrpPrivacy;
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_,
-			 ("\n rtw_set_key: psetkeyparm->algorithm=(unsigned char)psecuritypriv->dot118021XGrpPrivacy=%d\n",
-			 psetkeyparm->algorithm));
-	} else {
+	else
 		psetkeyparm->algorithm = (u8)psecuritypriv->dot11PrivacyAlgrthm;
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_,
-			 ("\n rtw_set_key: psetkeyparm->algorithm=(u8)psecuritypriv->dot11PrivacyAlgrthm=%d\n",
-			 psetkeyparm->algorithm));
-	}
 	psetkeyparm->keyid = (u8)keyid;/* 0~3 */
 	psetkeyparm->set_tx = set_tx;
 	pmlmepriv->key_mask |= BIT(psetkeyparm->keyid);
 	DBG_88E("==> rtw_set_key algorithm(%x), keyid(%x), key_mask(%x)\n",
 		psetkeyparm->algorithm, psetkeyparm->keyid, pmlmepriv->key_mask);
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_,
-		 ("\n rtw_set_key: psetkeyparm->algorithm=%d psetkeyparm->keyid=(u8)keyid=%d\n",
-		 psetkeyparm->algorithm, keyid));
 
 	switch (psetkeyparm->algorithm) {
 	case _WEP40_:
@@ -1842,9 +1746,6 @@ int rtw_set_key(struct adapter *adapter, struct security_priv *psecuritypriv, in
 		psetkeyparm->grpkey = 1;
 		break;
 	default:
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_,
-			 ("\n rtw_set_key:psecuritypriv->dot11PrivacyAlgrthm=%x (must be 1 or 2 or 4 or 5)\n",
-			 psecuritypriv->dot11PrivacyAlgrthm));
 		res = _FAIL;
 		goto exit;
 	}
@@ -1960,10 +1861,6 @@ int rtw_restruct_sec_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie, uint in_
 	uint	ndisauthmode = psecuritypriv->ndisauthtype;
 	uint ndissecuritytype = psecuritypriv->ndisencryptstatus;
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_notice_,
-		 ("+rtw_restruct_sec_ie: ndisauthmode=%d ndissecuritytype=%d\n",
-		  ndisauthmode, ndissecuritytype));
-
 	/* copy fixed ie only */
 	memcpy(out_ie, in_ie, 12);
 	ielength = 12;
@@ -2055,9 +1952,6 @@ void rtw_update_registrypriv_dev_network(struct adapter *adapter)
 	}
 
 	pdev_network->Configuration.DSConfig = (pregistrypriv->channel);
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_,
-		 ("pregistrypriv->channel=%d, pdev_network->Configuration.DSConfig=0x%x\n",
-		 pregistrypriv->channel, pdev_network->Configuration.DSConfig));
 
 	if (cur_network->network.InfrastructureMode == Ndis802_11IBSS)
 		pdev_network->Configuration.ATIMWindow = (0);
diff --git a/drivers/staging/r8188eu/include/rtw_mlme.h b/drivers/staging/r8188eu/include/rtw_mlme.h
index 8c54da73f1a7..11a2e176ccf7 100644
--- a/drivers/staging/r8188eu/include/rtw_mlme.h
+++ b/drivers/staging/r8188eu/include/rtw_mlme.h
@@ -453,8 +453,6 @@ void rtw_surveydone_event_callback(struct adapter *adapter, u8 *pbuf);
 void rtw_joinbss_event_callback(struct adapter *adapter, u8 *pbuf);
 void rtw_stassoc_event_callback(struct adapter *adapter, u8 *pbuf);
 void rtw_stadel_event_callback(struct adapter *adapter, u8 *pbuf);
-void rtw_atimdone_event_callback(struct adapter *adapter, u8 *pbuf);
-void rtw_cpwm_event_callback(struct adapter *adapter, u8 *pbuf);
 void indicate_wx_scan_complete_event(struct adapter *padapter);
 void rtw_indicate_wx_assoc_event(struct adapter *padapter);
 void rtw_indicate_wx_disassoc_event(struct adapter *padapter);
diff --git a/drivers/staging/r8188eu/include/rtw_mlme_ext.h b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
index b9c76f04445c..c8760b135bfd 100644
--- a/drivers/staging/r8188eu/include/rtw_mlme_ext.h
+++ b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
@@ -839,7 +839,7 @@ static struct fwevent wlanevents[] = {
 	{0, &rtw_joinbss_event_callback},		/*10*/
 	{sizeof(struct stassoc_event), &rtw_stassoc_event_callback},
 	{sizeof(struct stadel_event), &rtw_stadel_event_callback},
-	{0, &rtw_atimdone_event_callback},
+	{0, NULL},
 	{0, rtw_dummy_event_callback},
 	{0, NULL},	/*15*/
 	{0, NULL},
@@ -849,7 +849,7 @@ static struct fwevent wlanevents[] = {
 	{0, NULL},	 /*20*/
 	{0, NULL},
 	{0, NULL},
-	{0, &rtw_cpwm_event_callback},
+	{0, NULL},
 	{0, NULL},
 };
 
-- 
2.31.1

