Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AFEB3E2011
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 02:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242903AbhHFAlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 20:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242724AbhHFAk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 20:40:57 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88EB5C0613D5
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 17:40:41 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id i10-20020a05600c354ab029025a0f317abfso7630011wmq.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 17:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z60+DrpOM6MB9WiEOXbIBIIGLgTJQjgFiY7TDoQySVc=;
        b=V4qZGzZhX5vSrVhrjxCmT/iJGLNe4g5vHpewPsysllJYOrIpsaPMGF526YKb0tJDl3
         W9EnZhtZgXiBJsimuFMuFe3dR8ZroKrp9YxhFahDsZcoU4vjwLgltNvGugAa7Mzp5xrk
         v/KUjYnQDH40eOSf6yknL45RZag+Kvjbi4Uobjv/Xb3RGKnwhnJXvqCRd2YHTdKDXMfy
         cqSoRLrItn3PjmeafkcDVBAAfXlD8PCLOZyHKYTap0HnteZxNkGOj4rXNM4e2qOLmXzk
         4BFKJfG515UqVV2uGz/moeTAy07ylD3q0tCg4ZUiPxOZ91wC3IaKcb9U58gKM7LYQcfu
         HU2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z60+DrpOM6MB9WiEOXbIBIIGLgTJQjgFiY7TDoQySVc=;
        b=RLZDUqtICeMsVs/LvWxsUd7axeNjr72s80EEBVLa00M9aPXGvzQBzFW1DYN4ldEemQ
         IQAdjj6sXnQoioqUlfhORj7RqYm5J6oo6eK/qTp0ArEKEEp58TbpOn6qTkpkjyCi9V7e
         5WUTEuumjsEJQC/2k6VfpIu+p6LmkeWlI2BhJKuke9Won3fl5OJUf7aAoM5P2A8QHnBF
         gnrFp908wQCCohhsKFTQAY0/oXxhEAU1cOULOiez0tRvPWV2gduZjFu3RqwaOizSpIZW
         aZqrjDVDhucsInIgCCZn/Xq8Nwr2ldbe2AFb0fX/YOOtkfjAI6LRlx6ANc8cwZE7XJ7b
         lK5g==
X-Gm-Message-State: AOAM533xackpbHJKXs1Q4qP9XWIaqwzSatEj0Imkn2ZTInLlagi/UQER
        YmwyeOpVRe1jy5YcMLOxRzX3RQ==
X-Google-Smtp-Source: ABdhPJxv+BJjMbFOrdLpP2MKOE47KjP1KqpIep+n5wegP6UgwTTp8R3oLllZYT2eeCnN6G17OYEnsw==
X-Received: by 2002:a1c:2390:: with SMTP id j138mr651125wmj.66.1628210440135;
        Thu, 05 Aug 2021 17:40:40 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id y19sm10727181wmq.5.2021.08.05.17.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 17:40:39 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, martin@kaiser.cx
Subject: [PATCH v2 03/11] staging: r8188eu: remove RT_TRACE calls from core/rtw_mlme.c
Date:   Fri,  6 Aug 2021 01:40:26 +0100
Message-Id: <20210806004034.82233-4-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210806004034.82233-1-phil@philpotter.co.uk>
References: <20210806004034.82233-1-phil@philpotter.co.uk>
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
 drivers/staging/r8188eu/core/rtw_mlme.c       | 130 ++----------------
 drivers/staging/r8188eu/include/rtw_mlme.h    |   2 -
 .../staging/r8188eu/include/rtw_mlme_ext.h    |   4 +-
 3 files changed, 14 insertions(+), 122 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index ea1e6d1cd2b7..4768d3ef350e 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -185,7 +185,6 @@ struct	wlan_network *_rtw_alloc_network(struct	mlme_priv *pmlmepriv)/* _queue *f
 
 	list_del_init(&pnetwork->list);
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("_rtw_alloc_network: ptr=%p\n", plist));
 	pnetwork->network_type = 0;
 	pnetwork->fixed = false;
 	pnetwork->last_scanned = jiffies;
@@ -299,14 +298,10 @@ int rtw_if_up(struct adapter *padapter)
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
@@ -358,10 +353,7 @@ int	rtw_init_mlme_priv (struct adapter *padapter)/* struct	mlme_priv *pmlmepriv)
 
 void rtw_free_mlme_priv (struct mlme_priv *pmlmepriv)
 {
-
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("rtw_free_mlme_priv\n"));
 	_rtw_free_mlme_priv (pmlmepriv);
-
 }
 
 static struct wlan_network *rtw_alloc_network(struct mlme_priv *pmlmepriv)
@@ -577,10 +569,8 @@ void rtw_update_scanned_network(struct adapter *adapter, struct wlan_bssid_ex *t
 
 			pnetwork = rtw_alloc_network(pmlmepriv); /*  will update scan_time */
 
-			if (!pnetwork) {
-				RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("\n\n\nsomething wrong here\n\n\n"));
+			if (!pnetwork)
 				goto exit;
-			}
 
 			bssid_ex_sz = get_wlan_bssid_ex_sz(target);
 			target->Length = bssid_ex_sz;
@@ -688,12 +678,6 @@ static int rtw_is_desired_network(struct adapter *adapter, struct wlan_network *
 	return bselected;
 }
 
-/* TODO: Perry: For Power Management */
-void rtw_atimdone_event_callback(struct adapter	*adapter, u8 *pbuf)
-{
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("receive atimdone_evet\n"));
-}
-
 void rtw_survey_event_callback(struct adapter	*adapter, u8 *pbuf)
 {
 	u32 len;
@@ -702,13 +686,9 @@ void rtw_survey_event_callback(struct adapter	*adapter, u8 *pbuf)
 
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
@@ -753,14 +733,10 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
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
@@ -784,8 +760,6 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
 
 					_clr_fwstate_(pmlmepriv, _FW_UNDER_SURVEY);
 
-					RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("switching to adhoc master\n"));
-
 					memset(&pdev_network->Ssid, 0, sizeof(struct ndis_802_11_ssid));
 					memcpy(&pdev_network->Ssid, &pmlmepriv->assoc_ssid, sizeof(struct ndis_802_11_ssid));
 
@@ -794,8 +768,7 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
 
 					pmlmepriv->fw_state = WIFI_ADHOC_MASTER_STATE;
 
-					if (rtw_createbss_cmd(adapter) != _SUCCESS)
-						RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("Error=>rtw_createbss_cmd status FAIL\n"));
+					rtw_createbss_cmd(adapter);
 					pmlmepriv->to_join = false;
 				}
 			}
@@ -853,7 +826,6 @@ static void free_scanqueue(struct	mlme_priv *pmlmepriv)
 	struct __queue *scan_queue = &pmlmepriv->scanned_queue;
 	struct list_head *plist, *phead, *ptemp;
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_notice_, ("+free_scanqueue\n"));
 	spin_lock_bh(&scan_queue->lock);
 	spin_lock_bh(&free_queue->lock);
 
@@ -882,11 +854,6 @@ void rtw_free_assoc_resources(struct adapter *adapter, int lock_scanned_queue)
 	struct	sta_priv *pstapriv = &adapter->stapriv;
 	struct wlan_network *tgt_network = &pmlmepriv->cur_network;
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_notice_, ("+rtw_free_assoc_resources\n"));
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_,
-		 ("tgt_network->network.MacAddress=%pM ssid=%s\n",
-		 tgt_network->network.MacAddress, tgt_network->network.Ssid.Ssid));
-
 	if (check_fwstate(pmlmepriv, WIFI_STATION_STATE | WIFI_AP_STATE)) {
 		struct sta_info *psta;
 
@@ -916,8 +883,6 @@ void rtw_free_assoc_resources(struct adapter *adapter, int lock_scanned_queue)
 	pwlan = rtw_find_network(&pmlmepriv->scanned_queue, tgt_network->network.MacAddress);
 	if (pwlan)
 		pwlan->fixed = false;
-	else
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("rtw_free_assoc_resources:pwlan==NULL\n\n"));
 
 	if ((check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE) && (adapter->stapriv.asoc_sta_count == 1)))
 		rtw_free_network_nolock(pmlmepriv, pwlan);
@@ -935,8 +900,6 @@ void rtw_indicate_connect(struct adapter *padapter)
 {
 	struct mlme_priv	*pmlmepriv = &padapter->mlmepriv;
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("+rtw_indicate_connect\n"));
-
 	pmlmepriv->to_join = false;
 
 	if (!check_fwstate(&padapter->mlmepriv, _FW_LINKED)) {
@@ -950,9 +913,6 @@ void rtw_indicate_connect(struct adapter *padapter)
 	pmlmepriv->to_roaming = 0;
 
 	rtw_set_scan_deny(padapter, 3000);
-
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("-rtw_indicate_connect: fw_state=0x%08x\n", get_fwstate(pmlmepriv)));
-
 }
 
 /*
@@ -962,8 +922,6 @@ void rtw_indicate_disconnect(struct adapter *padapter)
 {
 	struct	mlme_priv *pmlmepriv = &padapter->mlmepriv;
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("+rtw_indicate_disconnect\n"));
-
 	_clr_fwstate_(pmlmepriv, _FW_UNDER_LINKING | WIFI_UNDER_WPS);
 
 	if (pmlmepriv->to_roaming > 0)
@@ -1085,10 +1043,6 @@ static void rtw_joinbss_update_network(struct adapter *padapter, struct wlan_net
 
 	DBG_88E("%s\n", __func__);
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_,
-		 ("\nfw_state:%x, BSSID:%pM\n",
-		 get_fwstate(pmlmepriv), pnetwork->network.MacAddress));
-
 	/*  why not use ptarget_wlan?? */
 	memcpy(&cur_network->network, &pnetwork->network, pnetwork->network.Length);
 	/*  some IEs in pnetwork is wrong, so we should use ptarget_wlan IEs */
@@ -1117,7 +1071,6 @@ static void rtw_joinbss_update_network(struct adapter *padapter, struct wlan_net
 		break;
 	default:
 		pmlmepriv->fw_state = WIFI_NULL_STATE;
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("Invalid network_mode\n"));
 		break;
 	}
 
@@ -1145,27 +1098,16 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
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
@@ -1203,7 +1145,6 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
 			if (ptarget_wlan) {
 				rtw_joinbss_update_network(adapter, ptarget_wlan, pnetwork);
 			} else {
-				RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("Can't find ptarget_wlan when joinbss_event callback\n"));
 				spin_unlock_bh(&pmlmepriv->scanned_queue.lock);
 				goto ignore_joinbss_callback;
 			}
@@ -1212,7 +1153,6 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
 			if (check_fwstate(pmlmepriv, WIFI_STATION_STATE) == true) {
 				ptarget_sta = rtw_joinbss_update_stainfo(adapter, pnetwork);
 				if (!ptarget_sta) {
-					RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("Can't update stainfo when joinbss_event callback\n"));
 					spin_unlock_bh(&pmlmepriv->scanned_queue.lock);
 					goto ignore_joinbss_callback;
 				}
@@ -1222,18 +1162,11 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
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
@@ -1244,10 +1177,8 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
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
@@ -1335,16 +1266,12 @@ void rtw_stassoc_event_callback(struct adapter *adapter, u8 *pbuf)
 #endif
 	/* for AD-HOC mode */
 	psta = rtw_get_stainfo(&adapter->stapriv, pstassoc->macaddr);
-	if (psta) {
+	if (psta)
 		/* the sta have been in sta_info_queue => do nothing */
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("Error: rtw_stassoc_event_callback: sta has been in sta_hash_queue\n"));
 		return; /* between drv has received this event before and  fw have not yet to set key to CAM_ENTRY) */
-	}
 	psta = rtw_alloc_stainfo(&adapter->stapriv, pstassoc->macaddr);
-	if (!psta) {
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("Can't alloc sta_info when rtw_stassoc_event_callback\n"));
+	if (!psta)
 		return;
-	}
 	/* to do: init sta_info variable */
 	psta->qos_option = 0;
 	psta->mac_id = (uint)pstassoc->cam_id;
@@ -1466,21 +1393,13 @@ void rtw_stadel_event_callback(struct adapter *adapter, u8 *pbuf)
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
@@ -1679,7 +1598,6 @@ int rtw_select_and_join_from_scanned_queue(struct mlme_priv *pmlmepriv)
 	while (phead != pmlmepriv->pscanned) {
 		pnetwork = container_of(pmlmepriv->pscanned, struct wlan_network, list);
 		if (!pnetwork) {
-			RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("%s return _FAIL:(pnetwork==NULL)\n", __func__));
 			ret = _FAIL;
 			goto exit;
 		}
@@ -1750,9 +1668,6 @@ int rtw_set_auth(struct adapter *adapter, struct security_priv *psecuritypriv)
 	pcmd->rsp = NULL;
 	pcmd->rspsz = 0;
 	INIT_LIST_HEAD(&pcmd->list);
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_,
-		 ("after enqueue set_auth_cmd, auth_mode=%x\n",
-		 psecuritypriv->dot11AuthAlgrthm));
 	res = rtw_enqueue_cmd(pcmdpriv, pcmd);
 exit:
 
@@ -1782,25 +1697,15 @@ int rtw_set_key(struct adapter *adapter, struct security_priv *psecuritypriv, in
 
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
@@ -1822,9 +1727,6 @@ int rtw_set_key(struct adapter *adapter, struct security_priv *psecuritypriv, in
 		psetkeyparm->grpkey = 1;
 		break;
 	default:
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_,
-			 ("\n rtw_set_key:psecuritypriv->dot11PrivacyAlgrthm=%x (must be 1 or 2 or 4 or 5)\n",
-			 psecuritypriv->dot11PrivacyAlgrthm));
 		res = _FAIL;
 		goto exit;
 	}
@@ -1938,11 +1840,6 @@ int rtw_restruct_sec_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie, uint in_
 	struct mlme_priv *pmlmepriv = &adapter->mlmepriv;
 	struct security_priv *psecuritypriv = &adapter->securitypriv;
 	uint	ndisauthmode = psecuritypriv->ndisauthtype;
-	uint ndissecuritytype = psecuritypriv->ndisencryptstatus;
-
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_notice_,
-		 ("+rtw_restruct_sec_ie: ndisauthmode=%d ndissecuritytype=%d\n",
-		  ndisauthmode, ndissecuritytype));
 
 	/* copy fixed ie only */
 	memcpy(out_ie, in_ie, 12);
@@ -2035,9 +1932,6 @@ void rtw_update_registrypriv_dev_network(struct adapter *adapter)
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
index 88d4ec073723..3b6e3ae92c9f 100644
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

