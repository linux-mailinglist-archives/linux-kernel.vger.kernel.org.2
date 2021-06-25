Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A57F3B3A00
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 02:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233160AbhFYAL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 20:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233006AbhFYAKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 20:10:41 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E417DC061574
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 17:08:20 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id bl4so17365288qkb.8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 17:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OuG+mt5ZX0IkJLsgXP9b/SL7LGuz4ZjZXvqn2GWyCUc=;
        b=wl+stEeC9jB7lK9SHVqX1jhQ/m3BK9S/Vnn7mQjzfW+FURkcJlZ1tR9vD6IH5i/YAf
         Lf8kBb//sLBQ4BQCrXK6hoVG1YT/ABAw0eIoeuo8M2ktfehm6Dz0PxommjzzdJTab4n3
         D36CH6eTxg9Wzln+KMnx+vA6qjVksAjB/YXq/BN7KixrdUj1zZ9IbAnBWAKr6bmICHUB
         5CigZKwCD7Q0D9ORaJWc2w18f0fMocrJh1qWIefk3151h7xBTQKjVQb0hOT6NkQw55en
         1mNDxhlUtmH+VMJE7oRn1pIbutb8snOcnXVHCR4p35cP5eJM40F2xQg0soUkcBZHkC0B
         4snA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OuG+mt5ZX0IkJLsgXP9b/SL7LGuz4ZjZXvqn2GWyCUc=;
        b=Mc2jFQPAk5r2hL0Z9kvC9fiLamQYm1Y6Am4tyjrNvF6osHWWXwDB8UDTuQnUtoBiXU
         I9xRbgWqCm8ZXtcp3yI8GDK2RCKJOmgthkXTEH9vCjp3tEjK8C3Yn4WBTgQhZxLhe4Yu
         yqRsZ07FD1hVu5J9/L7e7ehraQMG32Xuh8NZmOv+0LWdMY98zUA1L6/pkSRMMfuPQJWO
         xTyHhxtgtvduWR1Y7WmmuC5+ICwdDr9MAt5jQh8TPEU7eZLZB1F0fTN4DoergvBikuGC
         mfZSAkPMvThrJTRxW82f4A5Wy2a8h919QHgYAivLUjUCBUV/EUS3QwurkY6u5yV+39F0
         8TOw==
X-Gm-Message-State: AOAM532+NTninJ7HPgOyfA6+pMPt7+4gFONyjw1Qp/Y+0wQX7l5+5yP2
        HsYjE4Vb0FCRcC38fE+lFIgpJQ==
X-Google-Smtp-Source: ABdhPJwelUcRPu7ETOVpqcF2bSfva4YxRTqGZRAOYloWB/c+jCwDQ0QWFBhuz96OSYA9I6Ap8a7Opw==
X-Received: by 2002:a37:4685:: with SMTP id t127mr8598578qka.384.1624579700095;
        Thu, 24 Jun 2021 17:08:20 -0700 (PDT)
Received: from kerneldevvm.. (5.6.a.8.a.a.b.f.c.9.4.c.a.9.a.a.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:aa9a:c49c:fbaa:8a65])
        by smtp.gmail.com with ESMTPSA id m187sm3629014qkd.131.2021.06.24.17.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 17:08:19 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH 13/23] staging: rtl8188eu: remove all RT_TRACE calls from core/rtw_ioctl_set.c
Date:   Fri, 25 Jun 2021 01:07:46 +0100
Message-Id: <20210625000756.6313-14-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210625000756.6313-1-phil@philpotter.co.uk>
References: <20210625000756.6313-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove all RT_TRACE calls from core/rtw_ioctl_set.c as this macro is
unnecessary, and these calls are dubious in terms of necessity.
Removing all calls will ultimately allow the removal of the macro
itself.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 .../staging/rtl8188eu/core/rtw_ioctl_set.c    | 89 +------------------
 1 file changed, 2 insertions(+), 87 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_ioctl_set.c b/drivers/staging/rtl8188eu/core/rtw_ioctl_set.c
index adf772e7bac0..f679a7f8fe75 100644
--- a/drivers/staging/rtl8188eu/core/rtw_ioctl_set.c
+++ b/drivers/staging/rtl8188eu/core/rtw_ioctl_set.c
@@ -33,8 +33,6 @@ u8 rtw_do_join(struct adapter *padapter)
 	phead = get_list_head(queue);
 	plist = phead->next;
 
-	RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_, ("\n %s: phead = %p; plist = %p\n\n\n", __func__, phead, plist));
-
 	pmlmepriv->cur_network.join_res = -2;
 
 	set_fwstate(pmlmepriv, _FW_UNDER_LINKING);
@@ -52,13 +50,10 @@ u8 rtw_do_join(struct adapter *padapter)
 
 		if (!pmlmepriv->LinkDetectInfo.bBusyTraffic ||
 		    pmlmepriv->to_roaming > 0) {
-			RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_, ("%s: site survey if scanned_queue is empty\n.", __func__));
 			/*  submit site_survey_cmd */
 			ret = rtw_sitesurvey_cmd(padapter, &pmlmepriv->assoc_ssid, 1, NULL, 0);
-			if (ret != _SUCCESS) {
+			if (ret != _SUCCESS)
 				pmlmepriv->to_join = false;
-				RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("%s: site survey return error\n.", __func__));
-			}
 		} else {
 			pmlmepriv->to_join = false;
 			ret = _FAIL;
@@ -92,14 +87,10 @@ u8 rtw_do_join(struct adapter *padapter)
 				rtw_generate_random_ibss(pibss);
 
 				if (rtw_createbss_cmd(padapter) != _SUCCESS) {
-					RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("***Error =>do_goin: rtw_createbss_cmd status FAIL***\n "));
 					ret =  false;
 					goto exit;
 				}
 				pmlmepriv->to_join = false;
-
-				RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_,
-					 ("***Error => rtw_select_and_join_from_scanned_queue FAIL under STA_Mode***\n "));
 			} else {
 				/*  can't associate ; reset under-linking */
 				_clr_fwstate_(pmlmepriv, _FW_UNDER_LINKING);
@@ -109,10 +100,8 @@ u8 rtw_do_join(struct adapter *padapter)
 				if (!pmlmepriv->LinkDetectInfo.bBusyTraffic ||
 				    pmlmepriv->to_roaming > 0) {
 					ret = rtw_sitesurvey_cmd(padapter, &pmlmepriv->assoc_ssid, 1, NULL, 0);
-					if (ret != _SUCCESS) {
+					if (ret != _SUCCESS)
 						pmlmepriv->to_join = false;
-						RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("do_join(): site survey return error\n."));
-					}
 				} else {
 					ret = _FAIL;
 					pmlmepriv->to_join = false;
@@ -147,16 +136,10 @@ u8 rtw_set_802_11_bssid(struct adapter *padapter, u8 *bssid)
 		goto release_mlme_lock;
 
 	if (check_fwstate(pmlmepriv, _FW_LINKED | WIFI_ADHOC_MASTER_STATE)) {
-		RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_, ("set_bssid: _FW_LINKED||WIFI_ADHOC_MASTER_STATE\n"));
-
 		if (!memcmp(&pmlmepriv->cur_network.network.MacAddress, bssid, ETH_ALEN)) {
 			if (!check_fwstate(pmlmepriv, WIFI_STATION_STATE))
 				goto release_mlme_lock;/* it means driver is in WIFI_ADHOC_MASTER_STATE, we needn't create bss again. */
 		} else {
-			RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_, ("Set BSSID not the same bssid\n"));
-			RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_, ("set_bssid =%pM\n", (bssid)));
-			RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_, ("cur_bssid =%pM\n", (pmlmepriv->cur_network.network.MacAddress)));
-
 			rtw_disassoc_cmd(padapter, 0, true);
 
 			if (check_fwstate(pmlmepriv, _FW_LINKED))
@@ -198,9 +181,6 @@ u8 rtw_set_802_11_bssid(struct adapter *padapter, u8 *bssid)
 	spin_unlock_bh(&pmlmepriv->lock);
 
 exit:
-	RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_,
-		 ("%s: status=%d\n", __func__, status));
-
 	return status;
 }
 
@@ -213,8 +193,6 @@ u8 rtw_set_802_11_ssid(struct adapter *padapter, struct ndis_802_11_ssid *ssid)
 	struct wlan_network *pnetwork = &pmlmepriv->cur_network;
 
 	if (!padapter->hw_init_completed) {
-		RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_,
-			 ("set_ssid: hw_init_completed == false =>exit!!!\n"));
 		status = _FAIL;
 		goto exit;
 	}
@@ -227,16 +205,9 @@ u8 rtw_set_802_11_ssid(struct adapter *padapter, struct ndis_802_11_ssid *ssid)
 		goto release_mlme_lock;
 
 	if (check_fwstate(pmlmepriv, _FW_LINKED | WIFI_ADHOC_MASTER_STATE)) {
-		RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_,
-			 ("set_ssid: _FW_LINKED||WIFI_ADHOC_MASTER_STATE\n"));
-
 		if (pmlmepriv->assoc_ssid.ssid_length == ssid->ssid_length &&
 		    !memcmp(&pmlmepriv->assoc_ssid.ssid, ssid->ssid, ssid->ssid_length)) {
 			if (!check_fwstate(pmlmepriv, WIFI_STATION_STATE)) {
-				RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_,
-					 ("Set SSID is the same ssid, fw_state = 0x%08x\n",
-					  get_fwstate(pmlmepriv)));
-
 				if (!rtw_is_same_ibss(padapter, pnetwork)) {
 					/* if in WIFI_ADHOC_MASTER_STATE | WIFI_ADHOC_STATE, create bss or rejoin again */
 					rtw_disassoc_cmd(padapter, 0, true);
@@ -257,10 +228,6 @@ u8 rtw_set_802_11_ssid(struct adapter *padapter, struct ndis_802_11_ssid *ssid)
 				rtw_lps_ctrl_wk_cmd(padapter, LPS_CTRL_JOINBSS, 1);
 			}
 		} else {
-			RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_, ("Set SSID not the same ssid\n"));
-			RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_, ("set_ssid =[%s] len = 0x%x\n", ssid->ssid, (unsigned int)ssid->ssid_length));
-			RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_, ("assoc_ssid =[%s] len = 0x%x\n", pmlmepriv->assoc_ssid.ssid, (unsigned int)pmlmepriv->assoc_ssid.ssid_length));
-
 			rtw_disassoc_cmd(padapter, 0, true);
 
 			if (check_fwstate(pmlmepriv, _FW_LINKED))
@@ -301,8 +268,6 @@ u8 rtw_set_802_11_ssid(struct adapter *padapter, struct ndis_802_11_ssid *ssid)
 	spin_unlock_bh(&pmlmepriv->lock);
 
 exit:
-	RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_,
-		 ("-%s: status =%d\n", __func__, status));
 	return status;
 }
 
@@ -313,15 +278,9 @@ u8 rtw_set_802_11_infrastructure_mode(struct adapter *padapter,
 	struct wlan_network *cur_network = &pmlmepriv->cur_network;
 	enum ndis_802_11_network_infra *pold_state = &cur_network->network.InfrastructureMode;
 
-	RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_notice_,
-		 ("+%s: old =%d new =%d fw_state = 0x%08x\n", __func__,
-		  *pold_state, networktype, get_fwstate(pmlmepriv)));
-
 	if (*pold_state != networktype) {
 		spin_lock_bh(&pmlmepriv->lock);
 
-		RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_, (" change mode!"));
-
 		if (*pold_state == Ndis802_11APMode) {
 			/* change to other mode from Ndis802_11APMode */
 			cur_network->join_res = -1;
@@ -379,9 +338,6 @@ u8 rtw_set_802_11_disassociate(struct adapter *padapter)
 	spin_lock_bh(&pmlmepriv->lock);
 
 	if (check_fwstate(pmlmepriv, _FW_LINKED)) {
-		RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_,
-			 ("MgntActrtw_set_802_11_disassociate: rtw_indicate_disconnect\n"));
-
 		rtw_disassoc_cmd(padapter, 0, true);
 		rtw_indicate_disconnect(padapter);
 		rtw_free_assoc_resources(padapter);
@@ -398,30 +354,19 @@ u8 rtw_set_802_11_bssid_list_scan(struct adapter *padapter, struct ndis_802_11_s
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	u8 res = true;
 
-	RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("+%s(), fw_state =%x\n", __func__, get_fwstate(pmlmepriv)));
-
 	if (!padapter) {
 		res = false;
 		goto exit;
 	}
 	if (!padapter->hw_init_completed) {
 		res = false;
-		RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("\n === %s:hw_init_completed == false ===\n", __func__));
 		goto exit;
 	}
 
 	if (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY | _FW_UNDER_LINKING) ||
 	    pmlmepriv->LinkDetectInfo.bBusyTraffic) {
 		/*  Scan or linking is in progress, do nothing. */
-		RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("%s fail since fw_state = %x\n", __func__, get_fwstate(pmlmepriv)));
 		res = true;
-
-		if (check_fwstate(pmlmepriv,
-				  _FW_UNDER_SURVEY | _FW_UNDER_LINKING))
-			RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("\n###_FW_UNDER_SURVEY|_FW_UNDER_LINKING\n\n"));
-		else
-			RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("\n###pmlmepriv->sitesurveyctrl.traffic_busy == true\n\n"));
-
 	} else {
 		if (rtw_is_scan_deny(padapter)) {
 			indicate_wx_scan_complete_event(padapter);
@@ -444,15 +389,8 @@ u8 rtw_set_802_11_authentication_mode(struct adapter *padapter, enum ndis_802_11
 	int res;
 	u8 ret;
 
-	RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_,
-		 ("set_802_11_auth.mode(): mode =%x\n", authmode));
-
 	psecuritypriv->ndisauthtype = authmode;
 
-	RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_,
-		 ("%s:psecuritypriv->ndisauthtype=%d", __func__,
-		 psecuritypriv->ndisauthtype));
-
 	if (psecuritypriv->ndisauthtype > 3)
 		psecuritypriv->dot11AuthAlgrthm = dot11AuthAlgrthm_8021X;
 
@@ -475,7 +413,6 @@ u8 rtw_set_802_11_add_wep(struct adapter *padapter, struct ndis_802_11_wep *wep)
 	keyid = wep->KeyIndex & 0x3fffffff;
 
 	if (keyid >= 4) {
-		RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("MgntActrtw_set_802_11_add_wep:keyid>4 =>fail\n"));
 		ret = false;
 		goto exit;
 	}
@@ -483,20 +420,14 @@ u8 rtw_set_802_11_add_wep(struct adapter *padapter, struct ndis_802_11_wep *wep)
 	switch (wep->KeyLength) {
 	case 5:
 		psecuritypriv->dot11PrivacyAlgrthm = _WEP40_;
-		RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_, ("MgntActrtw_set_802_11_add_wep:wep->KeyLength = 5\n"));
 		break;
 	case 13:
 		psecuritypriv->dot11PrivacyAlgrthm = _WEP104_;
-		RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_, ("MgntActrtw_set_802_11_add_wep:wep->KeyLength = 13\n"));
 		break;
 	default:
 		psecuritypriv->dot11PrivacyAlgrthm = _NO_PRIVACY_;
-		RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_, ("MgntActrtw_set_802_11_add_wep:wep->KeyLength!= 5 or 13\n"));
 		break;
 	}
-	RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_,
-		 ("%s:before memcpy, wep->KeyLength = 0x%x wep->KeyIndex = 0x%x  keyid =%x\n", __func__,
-		 wep->KeyLength, wep->KeyIndex, keyid));
 
 	memcpy(&psecuritypriv->dot11DefKey[keyid].skey[0],
 	       &wep->KeyMaterial, wep->KeyLength);
@@ -505,22 +436,6 @@ u8 rtw_set_802_11_add_wep(struct adapter *padapter, struct ndis_802_11_wep *wep)
 
 	psecuritypriv->dot11PrivacyKeyIndex = keyid;
 
-	RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_,
-		 ("%s:security key material : %x %x %x %x %x %x %x %x %x %x %x %x %x\n", __func__,
-		 psecuritypriv->dot11DefKey[keyid].skey[0],
-		 psecuritypriv->dot11DefKey[keyid].skey[1],
-		 psecuritypriv->dot11DefKey[keyid].skey[2],
-		 psecuritypriv->dot11DefKey[keyid].skey[3],
-		 psecuritypriv->dot11DefKey[keyid].skey[4],
-		 psecuritypriv->dot11DefKey[keyid].skey[5],
-		 psecuritypriv->dot11DefKey[keyid].skey[6],
-		 psecuritypriv->dot11DefKey[keyid].skey[7],
-		 psecuritypriv->dot11DefKey[keyid].skey[8],
-		 psecuritypriv->dot11DefKey[keyid].skey[9],
-		 psecuritypriv->dot11DefKey[keyid].skey[10],
-		 psecuritypriv->dot11DefKey[keyid].skey[11],
-		 psecuritypriv->dot11DefKey[keyid].skey[12]));
-
 	res = rtw_set_key(padapter, psecuritypriv, keyid, 1);
 
 	if (res == _FAIL)
-- 
2.31.1

