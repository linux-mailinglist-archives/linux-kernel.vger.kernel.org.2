Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38C5935333E
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 11:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236802AbhDCJPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 05:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236653AbhDCJPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 05:15:01 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C796FC061788
        for <linux-kernel@vger.kernel.org>; Sat,  3 Apr 2021 02:14:54 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id f12so559971wro.0
        for <linux-kernel@vger.kernel.org>; Sat, 03 Apr 2021 02:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OLHclJWAAGSal4qLAM8+Sh73eRrl+EyBVK5jLJlEiO0=;
        b=WLK2AK+oc/GHjHQJxE2JK5SzsGPnMqQHayB+i1lMXDKPFbAl6EMiS61ShagOEB+l8/
         owi2cP5+vzPU/d7WbY8me0IGT6Em01D+03TgQgKoEl6h4z52nqHGibMu5LHKrfY39o59
         gwc+GkEmYDC+mNowa9bUzNwymQLSoeGozBOz9uFoIcsSWc/UJlSYrcuYpsno5Zkw/eVp
         kphc2ePAgB7vbs+rzkVzfihnLyN9ZVofk+CQaxgpSIfamINxyBD5XgDj2aLmVFCHYeO+
         wyYsKQ6TAQ/AQOInv4Rh8bICp0OrSbID7/utmgAa5MVX+1kTSKArBzuT8G+aeNjwEhO1
         LPqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OLHclJWAAGSal4qLAM8+Sh73eRrl+EyBVK5jLJlEiO0=;
        b=Mmmo5Fo5Lb4/pLsyXBGmLgp12N3EghlXRKZyqbEN8hB7qTOharibnFKP83YtTpDeum
         PBUxRpQ84rp6uusd3tvytJf/0gOdyiTU3K7c+zTVgvF+3Ma0aF+ap0/VjMY77szJHn4p
         LfoHLX9k/UvKH92q2GX/QmxDBxTvPSe2DsjBCp5LN4o6qU1gKDvgedIjeo/JG2QSBZpa
         1vEi/CGKp7AW0Ag0XvGctn3c0D61gX2/P7Hc3U1IXljmh6DyzjUWJV7HZ9duniibxTM0
         woH9LIt+3QmuWsAYqPKzz3kmSAZ6mfbKp6dsL1JXk3Izw604dxi3OKCq4VHG5YWINFuG
         aZqQ==
X-Gm-Message-State: AOAM5331vGvqcSP/QIo5Mur4HxaFBu8P/asbpsa8XOYDTv41ZLTc1zid
        tEILtjYzg1V3WDdhRfG2/Qs=
X-Google-Smtp-Source: ABdhPJwDV/1KRyDLxv9+u/TDWcze5QDAs6QpOcckiU1KQzdLlcYO9Sk5xCc5Vp9eBehqxburjEYMhw==
X-Received: by 2002:a05:6000:18d2:: with SMTP id w18mr19264993wrq.88.1617441293539;
        Sat, 03 Apr 2021 02:14:53 -0700 (PDT)
Received: from agape ([5.171.72.64])
        by smtp.gmail.com with ESMTPSA id m3sm17970145wme.40.2021.04.03.02.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Apr 2021 02:14:53 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH v3 25/30] staging: rtl8723bs: remove RT_TRACE logs in core/rtw_ioctl_set.c
Date:   Sat,  3 Apr 2021 11:13:47 +0200
Message-Id: <a7244d72001659a16ab789d10730c80daecc6793.1617440834.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617440833.git.fabioaiuto83@gmail.com>
References: <cover.1617440833.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove all of the RT_TRACE logs in the core/rtw_ioctl_set.c file as they
currently do nothing as they require the code to be modified by
hand in order to be turned on. This obviously has not happened
since the code was merged. Moreover it relies on an unneeded
private log level tracing which overrides the in-kernel public one,
so just remove them as they are unused.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 .../staging/rtl8723bs/core/rtw_ioctl_set.c    | 76 +------------------
 1 file changed, 4 insertions(+), 72 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c b/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
index 14eb01df69b0..d4920d7d2452 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
@@ -28,7 +28,6 @@ u8 rtw_validate_ssid(struct ndis_802_11_ssid *ssid)
 	u8 ret = true;
 
 	if (ssid->SsidLength > 32) {
-		RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("ssid length >32\n"));
 		ret = false;
 		goto exit;
 	}
@@ -49,8 +48,6 @@ u8 rtw_do_join(struct adapter *padapter)
 	phead = get_list_head(queue);
 	plist = get_next(phead);
 
-	RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_, ("\n rtw_do_join: phead = %p; plist = %p\n\n\n", phead, plist));
-
 	pmlmepriv->cur_network.join_res = -2;
 
 	set_fwstate(pmlmepriv, _FW_UNDER_LINKING);
@@ -69,13 +66,11 @@ u8 rtw_do_join(struct adapter *padapter)
 		if (pmlmepriv->LinkDetectInfo.bBusyTraffic == false
 			|| rtw_to_roam(padapter) > 0
 		) {
-			RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_, ("rtw_do_join(): site survey if scanned_queue is empty\n."));
 			/*  submit site_survey_cmd */
 			ret = rtw_sitesurvey_cmd(padapter, &pmlmepriv->assoc_ssid, 1, NULL, 0);
-			if (_SUCCESS != ret) {
+			if (_SUCCESS != ret)
 				pmlmepriv->to_join = false;
-				RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("rtw_do_join(): site survey return error\n."));
-			}
+
 		} else {
 			pmlmepriv->to_join = false;
 			ret = _FAIL;
@@ -107,15 +102,12 @@ u8 rtw_do_join(struct adapter *padapter)
 				rtw_generate_random_ibss(pibss);
 
 				if (rtw_createbss_cmd(padapter) != _SUCCESS) {
-					RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("***Error =>do_goin: rtw_createbss_cmd status FAIL***\n "));
 					ret =  false;
 					goto exit;
 				}
 
 				pmlmepriv->to_join = false;
 
-				RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_, ("***Error => rtw_select_and_join_from_scanned_queue FAIL under STA_Mode***\n "));
-
 			} else {
 				/*  can't associate ; reset under-linking */
 				_clr_fwstate_(pmlmepriv, _FW_UNDER_LINKING);
@@ -127,10 +119,9 @@ u8 rtw_do_join(struct adapter *padapter)
 				) {
 					/* DBG_871X("rtw_do_join() when   no desired bss in scanning queue\n"); */
 					ret = rtw_sitesurvey_cmd(padapter, &pmlmepriv->assoc_ssid, 1, NULL, 0);
-					if (_SUCCESS != ret) {
+					if (_SUCCESS != ret)
 						pmlmepriv->to_join = false;
-						RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("do_join(): site survey return error\n."));
-					}
+
 				} else {
 					ret = _FAIL;
 					pmlmepriv->to_join = false;
@@ -169,16 +160,10 @@ u8 rtw_set_802_11_bssid(struct adapter *padapter, u8 *bssid)
 		goto release_mlme_lock;
 
 	if (check_fwstate(pmlmepriv, _FW_LINKED|WIFI_ADHOC_MASTER_STATE) == true) {
-		RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_, ("set_bssid: _FW_LINKED||WIFI_ADHOC_MASTER_STATE\n"));
-
 		if (!memcmp(&pmlmepriv->cur_network.network.MacAddress, bssid, ETH_ALEN)) {
 			if (check_fwstate(pmlmepriv, WIFI_STATION_STATE) == false)
 				goto release_mlme_lock;/* it means driver is in WIFI_ADHOC_MASTER_STATE, we needn't create bss again. */
 		} else {
-			RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_, ("Set BSSID not the same bssid\n"));
-			RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_, ("set_bssid =%pM\n", MAC_ARG(bssid)));
-			RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_, ("cur_bssid =%pM\n", MAC_ARG(pmlmepriv->cur_network.network.MacAddress)));
-
 			rtw_disassoc_cmd(padapter, 0, true);
 
 			if (check_fwstate(pmlmepriv, _FW_LINKED) == true)
@@ -212,8 +197,6 @@ u8 rtw_set_802_11_bssid(struct adapter *padapter, u8 *bssid)
 	spin_unlock_bh(&pmlmepriv->lock);
 
 exit:
-	RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_,
-		("rtw_set_802_11_bssid: status =%d\n", status));
 
 	return status;
 }
@@ -229,8 +212,6 @@ u8 rtw_set_802_11_ssid(struct adapter *padapter, struct ndis_802_11_ssid *ssid)
 			ssid->Ssid, get_fwstate(pmlmepriv));
 
 	if (padapter->hw_init_completed == false) {
-		RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_,
-			 ("set_ssid: hw_init_completed ==false =>exit!!!\n"));
 		status = _FAIL;
 		goto exit;
 	}
@@ -244,16 +225,9 @@ u8 rtw_set_802_11_ssid(struct adapter *padapter, struct ndis_802_11_ssid *ssid)
 		goto release_mlme_lock;
 
 	if (check_fwstate(pmlmepriv, _FW_LINKED|WIFI_ADHOC_MASTER_STATE) == true) {
-		RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_,
-			 ("set_ssid: _FW_LINKED||WIFI_ADHOC_MASTER_STATE\n"));
-
 		if ((pmlmepriv->assoc_ssid.SsidLength == ssid->SsidLength) &&
 		    (!memcmp(&pmlmepriv->assoc_ssid.Ssid, ssid->Ssid, ssid->SsidLength))) {
 			if ((check_fwstate(pmlmepriv, WIFI_STATION_STATE) == false)) {
-				RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_,
-					 ("Set SSID is the same ssid, fw_state = 0x%08x\n",
-					  get_fwstate(pmlmepriv)));
-
 				if (rtw_is_same_ibss(padapter, pnetwork) == false) {
 					/* if in WIFI_ADHOC_MASTER_STATE | WIFI_ADHOC_STATE, create bss or rejoin again */
 					rtw_disassoc_cmd(padapter, 0, true);
@@ -274,10 +248,6 @@ u8 rtw_set_802_11_ssid(struct adapter *padapter, struct ndis_802_11_ssid *ssid)
 				rtw_lps_ctrl_wk_cmd(padapter, LPS_CTRL_JOINBSS, 1);
 			}
 		} else {
-			RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_, ("Set SSID not the same ssid\n"));
-			RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_, ("set_ssid =[%s] len = 0x%x\n", ssid->Ssid, (unsigned int)ssid->SsidLength));
-			RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_, ("assoc_ssid =[%s] len = 0x%x\n", pmlmepriv->assoc_ssid.Ssid, (unsigned int)pmlmepriv->assoc_ssid.SsidLength));
-
 			rtw_disassoc_cmd(padapter, 0, true);
 
 			if (check_fwstate(pmlmepriv, _FW_LINKED) == true)
@@ -315,8 +285,6 @@ u8 rtw_set_802_11_ssid(struct adapter *padapter, struct ndis_802_11_ssid *ssid)
 	spin_unlock_bh(&pmlmepriv->lock);
 
 exit:
-	RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_,
-		("-rtw_set_802_11_ssid: status =%d\n", status));
 
 	return status;
 }
@@ -342,8 +310,6 @@ u8 rtw_set_802_11_connect(struct adapter *padapter, u8 *bssid, struct ndis_802_1
 	}
 
 	if (padapter->hw_init_completed == false) {
-		RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_,
-			 ("set_ssid: hw_init_completed ==false =>exit!!!\n"));
 		status = _FAIL;
 		goto exit;
 	}
@@ -395,12 +361,7 @@ u8 rtw_set_802_11_infrastructure_mode(struct adapter *padapter,
 	struct	wlan_network	*cur_network = &pmlmepriv->cur_network;
 	enum ndis_802_11_network_infrastructure *pold_state = &(cur_network->network.InfrastructureMode);
 
-	RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_notice_,
-		 ("+rtw_set_802_11_infrastructure_mode: old =%d new =%d fw_state = 0x%08x\n",
-		  *pold_state, networktype, get_fwstate(pmlmepriv)));
-
 	if (*pold_state != networktype) {
-		RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_, (" change mode!"));
 		/* DBG_871X("change mode, old_mode =%d, new_mode =%d, fw_state = 0x%x\n", *pold_state, networktype, get_fwstate(pmlmepriv)); */
 
 		if (*pold_state == Ndis802_11APMode) {
@@ -464,8 +425,6 @@ u8 rtw_set_802_11_disassociate(struct adapter *padapter)
 	spin_lock_bh(&pmlmepriv->lock);
 
 	if (check_fwstate(pmlmepriv, _FW_LINKED) == true) {
-		RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_, ("MgntActrtw_set_802_11_disassociate: rtw_indicate_disconnect\n"));
-
 		rtw_disassoc_cmd(padapter, 0, true);
 		rtw_indicate_disconnect(padapter);
 		/* modify for CONFIG_IEEE80211W, none 11w can use it */
@@ -484,28 +443,20 @@ u8 rtw_set_802_11_bssid_list_scan(struct adapter *padapter, struct ndis_802_11_s
 	struct	mlme_priv 	*pmlmepriv = &padapter->mlmepriv;
 	u8 res = true;
 
-	RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("+rtw_set_802_11_bssid_list_scan(), fw_state =%x\n", get_fwstate(pmlmepriv)));
-
 	if (padapter == NULL) {
 		res = false;
 		goto exit;
 	}
 	if (padapter->hw_init_completed == false) {
 		res = false;
-		RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("\n ===rtw_set_802_11_bssid_list_scan:hw_init_completed ==false ===\n"));
 		goto exit;
 	}
 
 	if ((check_fwstate(pmlmepriv, _FW_UNDER_SURVEY|_FW_UNDER_LINKING) == true) ||
 		(pmlmepriv->LinkDetectInfo.bBusyTraffic == true)) {
 		/*  Scan or linking is in progress, do nothing. */
-		RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("rtw_set_802_11_bssid_list_scan fail since fw_state = %x\n", get_fwstate(pmlmepriv)));
 		res = true;
 
-		if (check_fwstate(pmlmepriv, (_FW_UNDER_SURVEY|_FW_UNDER_LINKING)) == true)
-			RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("\n###_FW_UNDER_SURVEY|_FW_UNDER_LINKING\n\n"));
-		else
-			RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("\n###pmlmepriv->sitesurveyctrl.traffic_busy ==true\n\n"));
 	} else {
 		if (rtw_is_scan_deny(padapter)) {
 			DBG_871X(FUNC_ADPT_FMT": scan deny\n", FUNC_ADPT_ARG(padapter));
@@ -530,12 +481,8 @@ u8 rtw_set_802_11_authentication_mode(struct adapter *padapter, enum ndis_802_11
 	int res;
 	u8 ret;
 
-	RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_, ("set_802_11_auth.mode(): mode =%x\n", authmode));
-
 	psecuritypriv->ndisauthtype = authmode;
 
-	RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_, ("rtw_set_802_11_authentication_mode:psecuritypriv->ndisauthtype =%d", psecuritypriv->ndisauthtype));
-
 	if (psecuritypriv->ndisauthtype > 3)
 		psecuritypriv->dot11AuthAlgrthm = dot11AuthAlgrthm_8021X;
 
@@ -559,7 +506,6 @@ u8 rtw_set_802_11_add_wep(struct adapter *padapter, struct ndis_802_11_wep *wep)
 	keyid = wep->KeyIndex & 0x3fffffff;
 
 	if (keyid >= 4) {
-		RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("MgntActrtw_set_802_11_add_wep:keyid>4 =>fail\n"));
 		ret = false;
 		goto exit;
 	}
@@ -567,35 +513,21 @@ u8 rtw_set_802_11_add_wep(struct adapter *padapter, struct ndis_802_11_wep *wep)
 	switch (wep->KeyLength) {
 	case 5:
 		psecuritypriv->dot11PrivacyAlgrthm = _WEP40_;
-		RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_, ("MgntActrtw_set_802_11_add_wep:wep->KeyLength =5\n"));
 		break;
 	case 13:
 		psecuritypriv->dot11PrivacyAlgrthm = _WEP104_;
-		RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_, ("MgntActrtw_set_802_11_add_wep:wep->KeyLength = 13\n"));
 		break;
 	default:
 		psecuritypriv->dot11PrivacyAlgrthm = _NO_PRIVACY_;
-		RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_, ("MgntActrtw_set_802_11_add_wep:wep->KeyLength!=5 or 13\n"));
 		break;
 	}
 
-	RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_,
-		 ("rtw_set_802_11_add_wep:before memcpy, wep->KeyLength = 0x%x wep->KeyIndex = 0x%x  keyid =%x\n",
-		  wep->KeyLength, wep->KeyIndex, keyid));
-
 	memcpy(&(psecuritypriv->dot11DefKey[keyid].skey[0]), &(wep->KeyMaterial), wep->KeyLength);
 
 	psecuritypriv->dot11DefKeylen[keyid] = wep->KeyLength;
 
 	psecuritypriv->dot11PrivacyKeyIndex = keyid;
 
-	RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_, ("rtw_set_802_11_add_wep:security key material : %x %x %x %x %x %x %x %x %x %x %x %x %x\n",
-		psecuritypriv->dot11DefKey[keyid].skey[0], psecuritypriv->dot11DefKey[keyid].skey[1], psecuritypriv->dot11DefKey[keyid].skey[2],
-		psecuritypriv->dot11DefKey[keyid].skey[3], psecuritypriv->dot11DefKey[keyid].skey[4], psecuritypriv->dot11DefKey[keyid].skey[5],
-		psecuritypriv->dot11DefKey[keyid].skey[6], psecuritypriv->dot11DefKey[keyid].skey[7], psecuritypriv->dot11DefKey[keyid].skey[8],
-		psecuritypriv->dot11DefKey[keyid].skey[9], psecuritypriv->dot11DefKey[keyid].skey[10], psecuritypriv->dot11DefKey[keyid].skey[11],
-		psecuritypriv->dot11DefKey[keyid].skey[12]));
-
 	res = rtw_set_key(padapter, psecuritypriv, keyid, 1, true);
 
 	if (res == _FAIL)
-- 
2.20.1

