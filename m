Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5577B3B39F8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 02:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233064AbhFYALG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 20:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232982AbhFYAKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 20:10:35 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E205C061574
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 17:08:15 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id u2so4287726qvp.13
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 17:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VWg2rDRAgwg4NMLKSrAWhWlgZM586mT0drtHH5IMmTc=;
        b=gHicoEfCtxtqSXXJy7rhAbFw9cMYHsITm5mknh42SnJknwFk806hKJFvUlhL/65BeP
         MGzkNKBhRpFRCGF0Z9x0Mr0gt5ygZXntDrX11qDIGL47oyAFbhVm3qWiypN8NnIBsvg2
         6Sz7G22Bz3DO5lyJzok1dEQ4qfVyRITjMTS/6IODSA0Ys7kEoa6BwudazTKjDj5Pd4GA
         TvBGVy0gU7h+7r8oL+WoOSVT+/BQ4g+2uUe6FgKX9GmKbFgZG8nxHToi3Jft11tOpkrj
         SY1mj5uxRojZUsrV+2wfNe5n1tbFGa10ThGtlyEu1Mz5w773m0ICX/GtvHf4d0ID8Epd
         +RLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VWg2rDRAgwg4NMLKSrAWhWlgZM586mT0drtHH5IMmTc=;
        b=UT50QHCZYTWNyEKe2YmHhEu4yijtg1ZxOke5ohWLrwYx98fApHOIr2N0komO2Aakho
         saSkRO7m6gjDxKhSnsXTwTcljO2/mDfPORCoqN8bFaAPGHLNkp78rzTXVIobgIXj7V1b
         va+1fOk1uV3aBr/gvd7HNn89lofGUA/1OEQInm40CbYK8RWnzEHJ8YusfuxEnDH+Jucl
         S6o/9Rn62whJlMNrDguehl4zvt3VuO0rP2UQVltIQXAf7c+1JVkZqAsENELiPmvqZdW0
         1rEeSfJhargBQ+tnPBMYyGMjjSFKm0E9F2XrJTmTiG0ADur+sv/hQJurnJ5w1or0fLO7
         WC1w==
X-Gm-Message-State: AOAM533hHnCJ6Pw0jWREEf2Dqxv2yXPXsnWkTg2MHvJZlJg6L1TdmUdX
        85GeECP3HTvloR2GgACCIirtPQ==
X-Google-Smtp-Source: ABdhPJzdxEAhELciu6j2fgfx/48f2HjMf+nNvmTs/wUvCTAs86pVteJ3GOSVU77c4GUkJTq/AvM9MQ==
X-Received: by 2002:a0c:a362:: with SMTP id u89mr8008854qvu.50.1624579694368;
        Thu, 24 Jun 2021 17:08:14 -0700 (PDT)
Received: from kerneldevvm.. (5.6.a.8.a.a.b.f.c.9.4.c.a.9.a.a.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:aa9a:c49c:fbaa:8a65])
        by smtp.gmail.com with ESMTPSA id m187sm3629014qkd.131.2021.06.24.17.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 17:08:14 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH 09/23] staging: rtl8188eu: remove all RT_TRACE calls from core/rtw_mlme.c
Date:   Fri, 25 Jun 2021 01:07:42 +0100
Message-Id: <20210625000756.6313-10-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210625000756.6313-1-phil@philpotter.co.uk>
References: <20210625000756.6313-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove all RT_TRACE calls from core/rtw_mlme.c as this macro is
unnecessary, and these calls are dubious in terms of necessity.
Removing all calls will ultimately allow the removal of the macro
itself.

Also remove rtw_atimdone_event_callback and rtw_cpwm_event_callback
functions and their associated header declarations/usages, as all
they do is call RT_TRACE and nothing else.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/rtl8188eu/core/rtw_mlme.c     | 133 ++----------------
 drivers/staging/rtl8188eu/include/rtw_mlme.h  |   2 -
 .../staging/rtl8188eu/include/rtw_mlme_ext.h  |   4 +-
 3 files changed, 15 insertions(+), 124 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme.c b/drivers/staging/rtl8188eu/core/rtw_mlme.c
index 9ab3c6fbf268..71d205f3d73d 100644
--- a/drivers/staging/rtl8188eu/core/rtw_mlme.c
+++ b/drivers/staging/rtl8188eu/core/rtw_mlme.c
@@ -117,8 +117,6 @@ struct wlan_network *rtw_alloc_network(struct mlme_priv *pmlmepriv)
 
 	list_del_init(&pnetwork->list);
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_,
-		 ("rtw_alloc_network: ptr=%p\n", &pnetwork->list));
 	pnetwork->network_type = 0;
 	pnetwork->fixed = false;
 	pnetwork->last_scanned = jiffies;
@@ -218,15 +216,10 @@ int rtw_if_up(struct adapter *padapter)
 	int res;
 
 	if (padapter->bDriverStopped || padapter->bSurpriseRemoved ||
-	    !check_fwstate(&padapter->mlmepriv, _FW_LINKED)) {
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_,
-			 ("%s:bDriverStopped(%d) OR bSurpriseRemoved(%d)",
-			  __func__, padapter->bDriverStopped,
-			  padapter->bSurpriseRemoved));
+	    !check_fwstate(&padapter->mlmepriv, _FW_LINKED))
 		res = false;
-	} else {
+	else
 		res =  true;
-	}
 	return res;
 }
 
@@ -426,11 +419,8 @@ void rtw_update_scanned_network(struct adapter *adapter, struct wlan_bssid_ex *t
 
 			pnetwork = rtw_alloc_network(pmlmepriv); /*  will update scan_time */
 
-			if (!pnetwork) {
-				RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_,
-					 ("\n\n\nsomething wrong here\n\n\n"));
+			if (!pnetwork)
 				goto exit;
-			}
 
 			bssid_ex_sz = get_wlan_bssid_ex_sz(target);
 			target->Length = bssid_ex_sz;
@@ -517,12 +507,6 @@ static int rtw_is_desired_network(struct adapter *adapter, struct wlan_network *
 	return bselected;
 }
 
-/* TODO: Perry: For Power Management */
-void rtw_atimdone_event_callback(struct adapter *adapter, u8 *pbuf)
-{
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("receive atimdone_event\n"));
-}
-
 void rtw_survey_event_callback(struct adapter	*adapter, u8 *pbuf)
 {
 	u32 len;
@@ -531,15 +515,9 @@ void rtw_survey_event_callback(struct adapter	*adapter, u8 *pbuf)
 
 	pnetwork = (struct wlan_bssid_ex *)pbuf;
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_,
-		 ("%s, ssid=%s\n", __func__, pnetwork->ssid.ssid));
-
 	len = get_wlan_bssid_ex_sz(pnetwork);
-	if (len > (sizeof(struct wlan_bssid_ex))) {
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_,
-			 ("\n****%s: return a wrong bss ***\n", __func__));
+	if (len > (sizeof(struct wlan_bssid_ex)))
 		return;
-	}
 	spin_lock_bh(&pmlmepriv->lock);
 
 	/*  update IBSS_network 's timestamp */
@@ -582,14 +560,9 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
 		pmlmepriv->wps_probe_req_ie = NULL;
 	}
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_,
-		 ("%s: fw_state:%x\n\n", __func__, get_fwstate(pmlmepriv)));
-
 	if (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY)) {
 		del_timer_sync(&pmlmepriv->scan_to_timer);
 		_clr_fwstate_(pmlmepriv, _FW_UNDER_SURVEY);
-	} else {
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("nic status=%x, survey done event comes too late!\n", get_fwstate(pmlmepriv)));
 	}
 
 	rtw_set_signal_stat_timer(&adapter->recvpriv);
@@ -608,8 +581,6 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
 
 					_clr_fwstate_(pmlmepriv, _FW_UNDER_SURVEY);
 
-					RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("switching to adhoc master\n"));
-
 					memcpy(&pdev_network->ssid, &pmlmepriv->assoc_ssid, sizeof(struct ndis_802_11_ssid));
 
 					rtw_update_registrypriv_dev_network(adapter);
@@ -617,8 +588,7 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
 
 					pmlmepriv->fw_state = WIFI_ADHOC_MASTER_STATE;
 
-					if (rtw_createbss_cmd(adapter) != _SUCCESS)
-						RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("Error=>rtw_createbss_cmd status FAIL\n"));
+					rtw_createbss_cmd(adapter);
 					pmlmepriv->to_join = false;
 				}
 			}
@@ -671,7 +641,6 @@ static void free_scanqueue(struct	mlme_priv *pmlmepriv)
 	struct __queue *scan_queue = &pmlmepriv->scanned_queue;
 	struct list_head *plist, *phead, *ptemp;
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_notice_, ("+%s\n", __func__));
 	spin_lock_bh(&scan_queue->lock);
 	spin_lock_bh(&free_queue->lock);
 
@@ -711,11 +680,6 @@ void rtw_free_assoc_resources_locked(struct adapter *adapter)
 	struct sta_priv *pstapriv = &adapter->stapriv;
 	struct wlan_network *tgt_network = &pmlmepriv->cur_network;
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_notice_, ("+rtw_free_assoc_resources\n"));
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_,
-		 ("tgt_network->network.MacAddress=%pM ssid=%s\n",
-		 tgt_network->network.MacAddress, tgt_network->network.ssid.ssid));
-
 	if (check_fwstate(pmlmepriv, WIFI_STATION_STATE | WIFI_AP_STATE)) {
 		struct sta_info *psta;
 
@@ -742,8 +706,6 @@ void rtw_free_assoc_resources_locked(struct adapter *adapter)
 	pwlan = rtw_find_network(&pmlmepriv->scanned_queue, tgt_network->network.MacAddress);
 	if (pwlan)
 		pwlan->fixed = false;
-	else
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("rtw_free_assoc_resources:pwlan==NULL\n\n"));
 
 	if ((check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE) && (adapter->stapriv.asoc_sta_count == 1)))
 		rtw_free_network_nolock(pmlmepriv, pwlan);
@@ -758,8 +720,6 @@ void rtw_indicate_connect(struct adapter *padapter)
 {
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("+%s\n", __func__));
-
 	pmlmepriv->to_join = false;
 
 	if (!check_fwstate(&padapter->mlmepriv, _FW_LINKED)) {
@@ -773,8 +733,6 @@ void rtw_indicate_connect(struct adapter *padapter)
 	pmlmepriv->to_roaming = 0;
 
 	rtw_set_scan_deny(padapter, 3000);
-
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("-%s: fw_state=0x%08x\n", __func__, get_fwstate(pmlmepriv)));
 }
 
 /*
@@ -784,8 +742,6 @@ void rtw_indicate_disconnect(struct adapter *padapter)
 {
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("+%s\n", __func__));
-
 	_clr_fwstate_(pmlmepriv, _FW_UNDER_LINKING | WIFI_UNDER_WPS);
 
 	if (pmlmepriv->to_roaming > 0)
@@ -882,10 +838,6 @@ static void rtw_joinbss_update_network(struct adapter *padapter, struct wlan_net
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct wlan_network *cur_network = &pmlmepriv->cur_network;
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_,
-		 ("\nfw_state:%x, BSSID:%pM\n",
-		 get_fwstate(pmlmepriv), pnetwork->network.MacAddress));
-
 	/*  why not use ptarget_wlan?? */
 	memcpy(&cur_network->network, &pnetwork->network, pnetwork->network.Length);
 	/*  some ies in pnetwork is wrong, so we should use ptarget_wlan ies */
@@ -914,7 +866,6 @@ static void rtw_joinbss_update_network(struct adapter *padapter, struct wlan_net
 		break;
 	default:
 		pmlmepriv->fw_state = WIFI_NULL_STATE;
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("Invalid network_mode\n"));
 		break;
 	}
 
@@ -941,27 +892,16 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
 	struct wlan_network *pcur_wlan = NULL, *ptarget_wlan = NULL;
 	unsigned int the_same_macaddr = false;
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("joinbss event call back received with res=%d\n", pnetwork->join_res));
-
 	rtw_get_encrypt_decrypt_from_registrypriv(adapter);
 
-	if (pmlmepriv->assoc_ssid.ssid_length == 0)
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("@@@@@   joinbss event call back  for Any SSid\n"));
-	else
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("@@@@@   rtw_joinbss_event_callback for SSid:%s\n", pmlmepriv->assoc_ssid.ssid));
-
 	the_same_macaddr = !memcmp(pnetwork->network.MacAddress, cur_network->network.MacAddress, ETH_ALEN);
 
 	pnetwork->network.Length = get_wlan_bssid_ex_sz(&pnetwork->network);
-	if (pnetwork->network.Length > sizeof(struct wlan_bssid_ex)) {
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("\n\n ***joinbss_evt_callback return a wrong bss ***\n\n"));
+	if (pnetwork->network.Length > sizeof(struct wlan_bssid_ex))
 		return;
-	}
 
 	spin_lock_bh(&pmlmepriv->lock);
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("\nrtw_joinbss_event_callback!! _enter_critical\n"));
-
 	if (pnetwork->join_res > 0) {
 		spin_lock_bh(&pmlmepriv->scanned_queue.lock);
 		if (check_fwstate(pmlmepriv, _FW_UNDER_LINKING)) {
@@ -999,7 +939,6 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
 			if (ptarget_wlan) {
 				rtw_joinbss_update_network(adapter, ptarget_wlan, pnetwork);
 			} else {
-				RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("Can't find ptarget_wlan when joinbss_event callback\n"));
 				spin_unlock_bh(&pmlmepriv->scanned_queue.lock);
 				goto ignore_joinbss_callback;
 			}
@@ -1008,7 +947,6 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
 			if (check_fwstate(pmlmepriv, WIFI_STATION_STATE)) {
 				ptarget_sta = rtw_joinbss_update_stainfo(adapter, pnetwork);
 				if (!ptarget_sta) {
-					RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("Can't update stainfo when joinbss_event callback\n"));
 					spin_unlock_bh(&pmlmepriv->scanned_queue.lock);
 					goto ignore_joinbss_callback;
 				}
@@ -1017,18 +955,11 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
 			/* s4. indicate connect */
 			if (check_fwstate(pmlmepriv, WIFI_STATION_STATE)) {
 				rtw_indicate_connect(adapter);
-			} else {
-				/* adhoc mode will rtw_indicate_connect when rtw_stassoc_event_callback */
-				RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("adhoc mode, fw_state:%x", get_fwstate(pmlmepriv)));
 			}
 
 			/* s5. Cancel assoc_timer */
 			del_timer_sync(&pmlmepriv->assoc_timer);
-
-			RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("Cancel assoc_timer\n"));
-
 		} else {
-			RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("rtw_joinbss_event_callback err: fw_state:%x", get_fwstate(pmlmepriv)));
 			spin_unlock_bh(&pmlmepriv->scanned_queue.lock);
 			goto ignore_joinbss_callback;
 		}
@@ -1040,10 +971,8 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
 		mod_timer(&pmlmepriv->assoc_timer,
 			  jiffies + msecs_to_jiffies(1));
 
-		if (check_fwstate(pmlmepriv, _FW_UNDER_LINKING)) {
-			RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("fail! clear _FW_UNDER_LINKING ^^^fw_state=%x\n", get_fwstate(pmlmepriv)));
+		if (check_fwstate(pmlmepriv, _FW_UNDER_LINKING))
 			_clr_fwstate_(pmlmepriv, _FW_UNDER_LINKING);
-		}
 	} else { /* if join_res < 0 (join fails), then try again */
 		mod_timer(&pmlmepriv->assoc_timer,
 			  jiffies + msecs_to_jiffies(1));
@@ -1130,19 +1059,13 @@ void rtw_stassoc_event_callback(struct adapter *adapter, u8 *pbuf)
 #endif
 	/* for AD-HOC mode */
 	psta = rtw_get_stainfo(&adapter->stapriv, pstassoc->macaddr);
-	if (psta) {
+	if (psta)
 		/* the sta have been in sta_info_queue => do nothing */
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_,
-			 ("Error: %s: sta has been in sta_hash_queue\n",
-			  __func__));
 		return; /* between drv has received this event before and  fw have not yet to set key to CAM_ENTRY) */
-	}
 	psta = rtw_alloc_stainfo(&adapter->stapriv, pstassoc->macaddr);
-	if (!psta) {
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_,
-			 ("Can't alloc sta_info when %s\n", __func__));
+	if (!psta)
 		return;
-	}
+
 	/* to do: init sta_info variable */
 	psta->qos_option = 0;
 	psta->mac_id = (uint)pstassoc->cam_id;
@@ -1257,18 +1180,12 @@ void rtw_stadel_event_callback(struct adapter *adapter, u8 *pbuf)
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
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("+%s !!!\n", __func__));
-}
-
 /*
  * _rtw_join_timeout_handler - Timeout/failure handler for CMD JoinBss
  * @adapter: pointer to struct adapter structure
@@ -1481,9 +1398,6 @@ int rtw_set_auth(struct adapter *adapter, struct security_priv *psecuritypriv)
 	pcmd->rsp = NULL;
 	pcmd->rspsz = 0;
 	INIT_LIST_HEAD(&pcmd->list);
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_,
-		 ("after enqueue set_auth_cmd, auth_mode=%x\n",
-		 psecuritypriv->dot11AuthAlgrthm));
 	res = rtw_enqueue_cmd(pcmdpriv, pcmd);
 exit:
 	return res;
@@ -1508,23 +1422,13 @@ int rtw_set_key(struct adapter *adapter, struct security_priv *psecuritypriv, in
 		goto err_free_cmd;
 	}
 
-	if (psecuritypriv->dot11AuthAlgrthm == dot11AuthAlgrthm_8021X) {
+	if (psecuritypriv->dot11AuthAlgrthm == dot11AuthAlgrthm_8021X)
 		psetkeyparm->algorithm = (unsigned char)psecuritypriv->dot118021XGrpPrivacy;
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_,
-			 ("\n %s: psetkeyparm->algorithm=(unsigned char)psecuritypriv->dot118021XGrpPrivacy=%d\n",
-			  __func__, psetkeyparm->algorithm));
-	} else {
+	else
 		psetkeyparm->algorithm = (u8)psecuritypriv->dot11PrivacyAlgrthm;
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_,
-			 ("\n %s: psetkeyparm->algorithm=(u8)psecuritypriv->dot11PrivacyAlgrthm=%d\n",
-			  __func__, psetkeyparm->algorithm));
-	}
 	psetkeyparm->keyid = (u8)keyid;/* 0~3 */
 	psetkeyparm->set_tx = set_tx;
 	pmlmepriv->key_mask |= BIT(psetkeyparm->keyid);
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_,
-		 ("\n %s: psetkeyparm->algorithm=%d psetkeyparm->keyid=(u8)keyid=%d\n",
-		  __func__, psetkeyparm->algorithm, keyid));
 
 	switch (psetkeyparm->algorithm) {
 	case _WEP40_:
@@ -1548,9 +1452,6 @@ int rtw_set_key(struct adapter *adapter, struct security_priv *psecuritypriv, in
 		psetkeyparm->grpkey = 1;
 		break;
 	default:
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_,
-			 ("\n %s:psecuritypriv->dot11PrivacyAlgrthm=%x (must be 1 or 2 or 4 or 5)\n",
-			  __func__, psecuritypriv->dot11PrivacyAlgrthm));
 		res = _FAIL;
 		goto err_free_parm;
 	}
@@ -1656,11 +1557,6 @@ int rtw_restruct_sec_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie, uint in_
 	struct mlme_priv *pmlmepriv = &adapter->mlmepriv;
 	struct security_priv *psecuritypriv = &adapter->securitypriv;
 	uint ndisauthmode = psecuritypriv->ndisauthtype;
-	uint ndissecuritytype = psecuritypriv->ndisencryptstatus;
-
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_notice_,
-		 ("+%s: ndisauthmode=%d ndissecuritytype=%d\n", __func__,
-		  ndisauthmode, ndissecuritytype));
 
 	/* copy fixed ie only */
 	memcpy(out_ie, in_ie, 12);
@@ -1740,9 +1636,6 @@ void rtw_update_registrypriv_dev_network(struct adapter *adapter)
 	}
 
 	pdev_network->Configuration.DSConfig = pregistrypriv->channel;
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_,
-		 ("pregistrypriv->channel=%d, pdev_network->Configuration.DSConfig=0x%x\n",
-		 pregistrypriv->channel, pdev_network->Configuration.DSConfig));
 
 	if (cur_network->network.InfrastructureMode == Ndis802_11IBSS)
 		pdev_network->Configuration.ATIMWindow = 0;
diff --git a/drivers/staging/rtl8188eu/include/rtw_mlme.h b/drivers/staging/rtl8188eu/include/rtw_mlme.h
index f5e805c13442..2f02316906d0 100644
--- a/drivers/staging/rtl8188eu/include/rtw_mlme.h
+++ b/drivers/staging/rtl8188eu/include/rtw_mlme.h
@@ -220,8 +220,6 @@ void rtw_surveydone_event_callback(struct adapter *adapter, u8 *pbuf);
 void rtw_joinbss_event_callback(struct adapter *adapter, u8 *pbuf);
 void rtw_stassoc_event_callback(struct adapter *adapter, u8 *pbuf);
 void rtw_stadel_event_callback(struct adapter *adapter, u8 *pbuf);
-void rtw_atimdone_event_callback(struct adapter *adapter, u8 *pbuf);
-void rtw_cpwm_event_callback(struct adapter *adapter, u8 *pbuf);
 void indicate_wx_scan_complete_event(struct adapter *padapter);
 void rtw_indicate_wx_assoc_event(struct adapter *padapter);
 void rtw_indicate_wx_disassoc_event(struct adapter *padapter);
diff --git a/drivers/staging/rtl8188eu/include/rtw_mlme_ext.h b/drivers/staging/rtl8188eu/include/rtw_mlme_ext.h
index fcf366f9be90..c4fcfa986726 100644
--- a/drivers/staging/rtl8188eu/include/rtw_mlme_ext.h
+++ b/drivers/staging/rtl8188eu/include/rtw_mlme_ext.h
@@ -661,7 +661,7 @@ static struct fwevent wlanevents[] = {
 	{0, &rtw_joinbss_event_callback},		/*10*/
 	{sizeof(struct stassoc_event), &rtw_stassoc_event_callback},
 	{sizeof(struct stadel_event), &rtw_stadel_event_callback},
-	{0, &rtw_atimdone_event_callback},
+	{0, NULL},
 	{0, rtw_dummy_event_callback},
 	{0, NULL},	/*15*/
 	{0, NULL},
@@ -671,7 +671,7 @@ static struct fwevent wlanevents[] = {
 	{0, NULL},	 /*20*/
 	{0, NULL},
 	{0, NULL},
-	{0, &rtw_cpwm_event_callback},
+	{0, NULL},
 	{0, NULL},
 };
 
-- 
2.31.1

