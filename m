Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04F013511E6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 11:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233851AbhDAJWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 05:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233740AbhDAJVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 05:21:42 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246BFC061788
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 02:21:42 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id w18so1199802edc.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 02:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i6TEIriYigjvMqxxH0A1G3A0oS3Dme3lqyuL2ViYcdo=;
        b=BdKP8iFuCH3k7heceSmql+DfxbS/H+9Df+qjE6a6/4kCibcQpXYFWaLtCK2iSDYtmn
         paALVoLRKPNEI2kP4b2dam2o30E4c1YGGgB5MWNDKKJrNH+A6FgOd4JR+Dmcch5DSu3J
         nTclIlbHuIsqM49qbE850vf5W4Ld1o6eLdJDopb8CSoQQOWUxiXpVnmC2HJfCP6Uag50
         Fp0ZbW4DyKMQvnacCiI5lxl7onTPDx7MHlRGSvqwMIyUD9udCQGg9CShlSNrnqJj6T/0
         FNEr50pf/lja2Jt5lnc/FCaoFERqM4vLvoc1iOV+tzi1GnmjfKp4ZpkOyMrPb8ryh481
         mYzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i6TEIriYigjvMqxxH0A1G3A0oS3Dme3lqyuL2ViYcdo=;
        b=T6y869ZLjvRtHikuED7RPYxzimXO6LqFyxKHYS/6HIt5DjX4OLhvcf4E01ysHLMbRq
         OgODpKkyJXRq6s/c5EahnhfUZMO1Xrx7JTb1GXY7Y12D6BvcmrhfDq/JIGnPaZa2i9Qj
         kycdkJeaB+YiPl5RO57rC687sbakRoFN4X5zfPfSNlIyr0LOCZ4UTAIuVpRdGiDWQcGK
         1TsL4B9LfcEUh368EounuBJW43jZnFe9dUSIRnML9CMKbuaps4lTssX0Xq9jrMG0X8GD
         zTRGSHpkYm7vmr4vhDsP26+Shkwby3q2cgHG4WYuzJs0x8ySI/aLpyu5EnEaAdWlux3c
         ZvoQ==
X-Gm-Message-State: AOAM5303eP1EVLDN4eDActSiYXT7o93Gd7tZGBSywb8lkR6Yf6kABmcH
        HvVnBs/51OJHQNTv43XBHZ8=
X-Google-Smtp-Source: ABdhPJzJcP3n6EMFFi0ayUsWAfUyCLLOa/HBZtAol4wtet1Tx3BM2MzhfYN8eRsdutYCLnZWH3Wg4w==
X-Received: by 2002:a05:6402:51d4:: with SMTP id r20mr8800480edd.112.1617268900897;
        Thu, 01 Apr 2021 02:21:40 -0700 (PDT)
Received: from agape ([5.171.80.247])
        by smtp.gmail.com with ESMTPSA id va9sm2499503ejb.31.2021.04.01.02.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 02:21:40 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, dan.carpenter@oracle.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 11/49] staging: rtl8723bs: remove RT_TRACE logs in core/rtw_mlme.c
Date:   Thu,  1 Apr 2021 11:20:41 +0200
Message-Id: <d708bc82b584f18ae28825ef238a009ee14d3b93.1617268327.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617268327.git.fabioaiuto83@gmail.com>
References: <cover.1617268327.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove all RT_TRACE logs

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 68 +----------------------
 1 file changed, 3 insertions(+), 65 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 4289bf40aa73..09409330bf9d 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -155,8 +155,6 @@ struct	wlan_network *rtw_alloc_network(struct	mlme_priv *pmlmepriv)
 
 	list_del_init(&pnetwork->list);
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_,
-		 ("rtw_alloc_network: ptr =%p\n", plist));
 	pnetwork->network_type = 0;
 	pnetwork->fixed = false;
 	pnetwork->last_scanned = jiffies;
@@ -299,7 +297,6 @@ signed int rtw_if_up(struct adapter *padapter)
 
 	if (padapter->bDriverStopped || padapter->bSurpriseRemoved ||
 		(check_fwstate(&padapter->mlmepriv, _FW_LINKED) == false)) {
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_if_up:bDriverStopped(%d) OR bSurpriseRemoved(%d)", padapter->bDriverStopped, padapter->bSurpriseRemoved));
 		res = false;
 	} else
 		res =  true;
@@ -339,7 +336,6 @@ u8 *rtw_get_beacon_interval_from_ie(u8 *ie)
 
 void rtw_free_mlme_priv(struct mlme_priv *pmlmepriv)
 {
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("rtw_free_mlme_priv\n"));
 	_rtw_free_mlme_priv(pmlmepriv);
 }
 
@@ -608,7 +604,6 @@ void rtw_update_scanned_network(struct adapter *adapter, struct wlan_bssid_ex *t
 			/* list_del_init(&oldest->list); */
 			pnetwork = oldest;
 			if (!pnetwork) {
-				RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("\n\n\nsomething wrong here\n\n\n"));
 				goto exit;
 			}
 			memcpy(&(pnetwork->network), target,  get_wlan_bssid_ex_sz(target));
@@ -629,7 +624,6 @@ void rtw_update_scanned_network(struct adapter *adapter, struct wlan_bssid_ex *t
 			pnetwork = rtw_alloc_network(pmlmepriv); /*  will update scan_time */
 
 			if (!pnetwork) {
-				RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("\n\n\nsomething wrong here\n\n\n"));
 				goto exit;
 			}
 
@@ -750,7 +744,6 @@ int rtw_is_desired_network(struct adapter *adapter, struct wlan_network *pnetwor
 /* TODO: Perry : For Power Management */
 void rtw_atimdone_event_callback(struct adapter	*adapter, u8 *pbuf)
 {
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("receive atimdone_event\n"));
 }
 
 void rtw_survey_event_callback(struct adapter	*adapter, u8 *pbuf)
@@ -761,11 +754,8 @@ void rtw_survey_event_callback(struct adapter	*adapter, u8 *pbuf)
 
 	pnetwork = (struct wlan_bssid_ex *)pbuf;
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_survey_event_callback, ssid =%s\n",  pnetwork->Ssid.Ssid));
-
 	len = get_wlan_bssid_ex_sz(pnetwork);
 	if (len > (sizeof(struct wlan_bssid_ex))) {
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("\n ****rtw_survey_event_callback: return a wrong bss ***\n"));
 		return;
 	}
 
@@ -811,14 +801,10 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
 		pmlmepriv->wps_probe_req_ie = NULL;
 	}
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_surveydone_event_callback: fw_state:%x\n\n", get_fwstate(pmlmepriv)));
-
 	if (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY)) {
 		del_timer_sync(&pmlmepriv->scan_to_timer);
 		_clr_fwstate_(pmlmepriv, _FW_UNDER_SURVEY);
 	} else {
-
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("nic status =%x, survey done event comes too late!\n", get_fwstate(pmlmepriv)));
 	}
 
 	rtw_set_signal_stat_timer(&adapter->recvpriv);
@@ -837,8 +823,6 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
 					/* pmlmepriv->fw_state ^= _FW_UNDER_SURVEY;because don't set assoc_timer */
 					_clr_fwstate_(pmlmepriv, _FW_UNDER_SURVEY);
 
-					RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("switching to adhoc master\n"));
-
 					memcpy(&pdev_network->Ssid, &pmlmepriv->assoc_ssid, sizeof(struct ndis_802_11_ssid));
 
 					rtw_update_registrypriv_dev_network(adapter);
@@ -847,7 +831,7 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
 					pmlmepriv->fw_state = WIFI_ADHOC_MASTER_STATE;
 
 					if (rtw_createbss_cmd(adapter) != _SUCCESS)
-						RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("Error =>rtw_createbss_cmd status FAIL\n"));
+						;
 
 					pmlmepriv->to_join = false;
 				}
@@ -919,7 +903,6 @@ static void free_scanqueue(struct	mlme_priv *pmlmepriv)
 	struct __queue *scan_queue = &pmlmepriv->scanned_queue;
 	struct list_head	*plist, *phead, *ptemp;
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_notice_, ("+free_scanqueue\n"));
 	spin_lock_bh(&scan_queue->lock);
 	spin_lock_bh(&free_queue->lock);
 
@@ -957,7 +940,6 @@ static void find_network(struct adapter *adapter)
 	if (pwlan)
 		pwlan->fixed = false;
 	else
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("rtw_free_assoc_resources : pwlan == NULL\n\n"));
 
 	if (check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE) &&
 	    (adapter->stapriv.asoc_sta_count == 1))
@@ -975,10 +957,6 @@ void rtw_free_assoc_resources(struct adapter *adapter, int lock_scanned_queue)
 	struct dvobj_priv *psdpriv = adapter->dvobj;
 	struct debug_priv *pdbgpriv = &psdpriv->drv_dbg;
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_notice_, ("+rtw_free_assoc_resources\n"));
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("tgt_network->network.MacAddress =%pM ssid =%s\n",
-		MAC_ARG(tgt_network->network.MacAddress), tgt_network->network.Ssid.Ssid));
-
 	if (check_fwstate(pmlmepriv, WIFI_STATION_STATE|WIFI_AP_STATE)) {
 		struct sta_info *psta;
 
@@ -1016,8 +994,6 @@ void rtw_indicate_connect(struct adapter *padapter)
 {
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("+rtw_indicate_connect\n"));
-
 	pmlmepriv->to_join = false;
 
 	if (!check_fwstate(&padapter->mlmepriv, _FW_LINKED)) {
@@ -1030,7 +1006,6 @@ void rtw_indicate_connect(struct adapter *padapter)
 	rtw_set_to_roam(padapter, 0);
 	rtw_set_scan_deny(padapter, 3000);
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("-rtw_indicate_connect: fw_state = 0x%08x\n", get_fwstate(pmlmepriv)));
 }
 
 /*
@@ -1040,8 +1015,6 @@ void rtw_indicate_disconnect(struct adapter *padapter)
 {
 	struct	mlme_priv *pmlmepriv = &padapter->mlmepriv;
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("+rtw_indicate_disconnect\n"));
-
 	_clr_fwstate_(pmlmepriv, _FW_UNDER_LINKING|WIFI_UNDER_WPS);
 
 	/* DBG_871X("clear wps when %s\n", __func__); */
@@ -1207,9 +1180,6 @@ static void rtw_joinbss_update_network(struct adapter *padapter, struct wlan_net
 	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
 	struct wlan_network  *cur_network = &(pmlmepriv->cur_network);
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("\nfw_state:%x, BSSID:%pM\n"
-		, get_fwstate(pmlmepriv), MAC_ARG(pnetwork->network.MacAddress)));
-
 	/*  why not use ptarget_wlan?? */
 	memcpy(&cur_network->network, &pnetwork->network, pnetwork->network.Length);
 	/*  some IEs in pnetwork is wrong, so we should use ptarget_wlan IEs */
@@ -1251,7 +1221,6 @@ static void rtw_joinbss_update_network(struct adapter *padapter, struct wlan_net
 			break;
 	default:
 			pmlmepriv->fw_state = WIFI_NULL_STATE;
-			RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("Invalid network_mode\n"));
 			break;
 	}
 
@@ -1280,20 +1249,16 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
 	struct wlan_network	*pcur_wlan = NULL, *ptarget_wlan = NULL;
 	unsigned int		the_same_macaddr = false;
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("joinbss event call back received with res =%d\n", pnetwork->join_res));
-
 	rtw_get_encrypt_decrypt_from_registrypriv(adapter);
 
 	if (pmlmepriv->assoc_ssid.SsidLength == 0)
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("@@@@@   joinbss event call back  for Any SSid\n"));
+		;
 	else
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("@@@@@   rtw_joinbss_event_callback for SSid:%s\n", pmlmepriv->assoc_ssid.Ssid));
 
 	the_same_macaddr = !memcmp(pnetwork->network.MacAddress, cur_network->network.MacAddress, ETH_ALEN);
 
 	pnetwork->network.Length = get_wlan_bssid_ex_sz(&pnetwork->network);
 	if (pnetwork->network.Length > sizeof(struct wlan_bssid_ex)) {
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("\n\n ***joinbss_evt_callback return a wrong bss ***\n\n"));
 		return;
 	}
 
@@ -1302,8 +1267,6 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
 	pmlmepriv->LinkDetectInfo.TrafficTransitionCount = 0;
 	pmlmepriv->LinkDetectInfo.LowPowerTransitionCount = 0;
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("\n rtw_joinbss_event_callback !! spin_lock_irqsave\n"));
-
 	if (pnetwork->join_res > 0) {
 		spin_lock_bh(&(pmlmepriv->scanned_queue.lock));
 		retry = 0;
@@ -1349,7 +1312,6 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
 			if (check_fwstate(pmlmepriv, WIFI_STATION_STATE) == true) {
 				ptarget_sta = rtw_joinbss_update_stainfo(adapter, pnetwork);
 				if (!ptarget_sta) {
-					RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("Can't update stainfo when joinbss_event callback\n"));
 					spin_unlock_bh(&(pmlmepriv->scanned_queue.lock));
 					goto ignore_joinbss_callback;
 				}
@@ -1361,16 +1323,12 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
 				rtw_indicate_connect(adapter);
 			} else {
 				/* adhoc mode will rtw_indicate_connect when rtw_stassoc_event_callback */
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
@@ -1384,7 +1342,6 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
 		/* rtw_free_assoc_resources(adapter, 1); */
 
 		if ((check_fwstate(pmlmepriv, _FW_UNDER_LINKING)) == true) {
-			RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("fail! clear _FW_UNDER_LINKING ^^^fw_state =%x\n", get_fwstate(pmlmepriv)));
 			_clr_fwstate_(pmlmepriv, _FW_UNDER_LINKING);
 		}
 
@@ -1394,7 +1351,6 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
 		res = _FAIL;
 		if (retry < 2) {
 			res = rtw_select_and_join_from_scanned_queue(pmlmepriv);
-			RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("rtw_select_and_join_from_scanned_queue again! res:%d\n", res));
 		}
 
 		if (res == _SUCCESS) {
@@ -1405,7 +1361,6 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
 			_clr_fwstate_(pmlmepriv, _FW_UNDER_LINKING);
 			rtw_indicate_connect(adapter);
 		} else {
-			RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("Set Assoc_Timer = 1; can't find match ssid in scanned_q\n"));
 		#endif
 
 			_set_timer(&pmlmepriv->assoc_timer, 1);
@@ -1495,14 +1450,11 @@ void rtw_stassoc_event_callback(struct adapter *adapter, u8 *pbuf)
 	if (psta) {
 		/* the sta have been in sta_info_queue => do nothing */
 
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("Error: rtw_stassoc_event_callback: sta has been in sta_hash_queue\n"));
-
 		return; /* between drv has received this event before and  fw have not yet to set key to CAM_ENTRY) */
 	}
 
 	psta = rtw_alloc_stainfo(&adapter->stapriv, pstassoc->macaddr);
 	if (!psta) {
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("Can't alloc sta_info when rtw_stassoc_event_callback\n"));
 		return;
 	}
 
@@ -1653,7 +1605,7 @@ void rtw_stadel_event_callback(struct adapter *adapter, u8 *pbuf)
 			}
 
 			if (rtw_createbss_cmd(adapter) != _SUCCESS)
-				RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("***Error =>stadel_event_callback: rtw_createbss_cmd status FAIL***\n "));
+				;
 		}
 
 	}
@@ -1665,7 +1617,6 @@ void rtw_cpwm_event_callback(struct adapter *padapter, u8 *pbuf)
 {
 	struct reportpwrstate_parm *preportpwrstate;
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("+rtw_cpwm_event_callback !!!\n"));
 	preportpwrstate = (struct reportpwrstate_parm *)pbuf;
 	preportpwrstate->state |= (u8)(adapter_to_pwrctl(padapter)->cpwm_tog + 0x80);
 	cpwm_int_hdl(padapter, preportpwrstate);
@@ -1931,7 +1882,6 @@ int rtw_select_roaming_candidate(struct mlme_priv *mlme)
 
 		pnetwork = container_of(mlme->pscanned, struct wlan_network, list);
 		if (!pnetwork) {
-			RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("%s return _FAIL:(pnetwork == NULL)\n", __func__));
 			ret = _FAIL;
 			goto exit;
 		}
@@ -2061,7 +2011,6 @@ int rtw_select_and_join_from_scanned_queue(struct mlme_priv *pmlmepriv)
 
 		pnetwork = container_of(pmlmepriv->pscanned, struct wlan_network, list);
 		if (!pnetwork) {
-			RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("%s return _FAIL:(pnetwork == NULL)\n", __func__));
 			ret = _FAIL;
 			goto exit;
 		}
@@ -2138,8 +2087,6 @@ signed int rtw_set_auth(struct adapter *adapter, struct security_priv *psecurity
 
 	INIT_LIST_HEAD(&pcmd->list);
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("after enqueue set_auth_cmd, auth_mode =%x\n", psecuritypriv->dot11AuthAlgrthm));
-
 	res = rtw_enqueue_cmd(pcmdpriv, pcmd);
 
 exit:
@@ -2162,11 +2109,8 @@ signed int rtw_set_key(struct adapter *adapter, struct security_priv *psecurityp
 
 	if (psecuritypriv->dot11AuthAlgrthm == dot11AuthAlgrthm_8021X) {
 		psetkeyparm->algorithm = (unsigned char)psecuritypriv->dot118021XGrpPrivacy;
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("\n rtw_set_key: psetkeyparm->algorithm =(unsigned char)psecuritypriv->dot118021XGrpPrivacy =%d\n", psetkeyparm->algorithm));
 	} else {
 		psetkeyparm->algorithm = (u8)psecuritypriv->dot11PrivacyAlgrthm;
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("\n rtw_set_key: psetkeyparm->algorithm =(u8)psecuritypriv->dot11PrivacyAlgrthm =%d\n", psetkeyparm->algorithm));
-
 	}
 	psetkeyparm->keyid = (u8)keyid;/* 0~3 */
 	psetkeyparm->set_tx = set_tx;
@@ -2174,7 +2118,6 @@ signed int rtw_set_key(struct adapter *adapter, struct security_priv *psecurityp
 		adapter->securitypriv.key_mask |= BIT(psetkeyparm->keyid);
 
 	DBG_871X("==> rtw_set_key algorithm(%x), keyid(%x), key_mask(%x)\n", psetkeyparm->algorithm, psetkeyparm->keyid, adapter->securitypriv.key_mask);
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("\n rtw_set_key: psetkeyparm->algorithm =%d psetkeyparm->keyid =(u8)keyid =%d\n", psetkeyparm->algorithm, keyid));
 
 	switch (psetkeyparm->algorithm) {
 
@@ -2197,7 +2140,6 @@ signed int rtw_set_key(struct adapter *adapter, struct security_priv *psecurityp
 		psetkeyparm->grpkey = 1;
 		break;
 	default:
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("\n rtw_set_key:psecuritypriv->dot11PrivacyAlgrthm = %x (must be 1 or 2 or 4 or 5)\n", psecuritypriv->dot11PrivacyAlgrthm));
 		res = _FAIL;
 		kfree(psetkeyparm);
 		goto exit;
@@ -2331,9 +2273,6 @@ signed int rtw_restruct_sec_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie, u
 	struct security_priv *psecuritypriv = &adapter->securitypriv;
 	uint	ndisauthmode = psecuritypriv->ndisauthtype;
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_notice_,
-		 ("+rtw_restruct_sec_ie: ndisauthmode =%d\n", ndisauthmode));
-
 	/* copy fixed ie only */
 	memcpy(out_ie, in_ie, 12);
 	ielength = 12;
@@ -2430,7 +2369,6 @@ void rtw_update_registrypriv_dev_network(struct adapter *adapter)
 	}
 
 	pdev_network->Configuration.DSConfig = (pregistrypriv->channel);
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("pregistrypriv->channel =%d, pdev_network->Configuration.DSConfig = 0x%x\n", pregistrypriv->channel, pdev_network->Configuration.DSConfig));
 
 	if (cur_network->network.InfrastructureMode == Ndis802_11IBSS)
 		pdev_network->Configuration.ATIMWindow = (0);
-- 
2.20.1

