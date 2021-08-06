Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3B333E2010
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 02:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242888AbhHFAlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 20:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241355AbhHFAk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 20:40:56 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF54C061798
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 17:40:40 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id k38-20020a05600c1ca6b029025af5e0f38bso7607979wms.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 17:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4TWZ5J8EA9PdwXQbnZm0NmkDugYJ6Fik3NJSFa1FJGI=;
        b=P3VNnbc/AhZe985bqnZnrKKVn8yAS+KrHFBJGMIVtKK93RpDN60etB6Vo39+7h4Q3A
         hY/POGxNVLS9wCXKQ8gAamYgwI2j6VXviGL3ESoS0cYb5aW7h+3v6npTCS5PeICMCkdt
         6sTcVgjHrjuvzojUiT7ZigQ+/T/xtZ+a4tZojTvaS6bgguS9YAu34Wh6ZLSan+Fge/d0
         O4PVZOMAhC3W5GuCFXZD4mCb8f1uyg3bNShLEj4HLz44Shgh/2spDyG5SzGn5EAiZuJ2
         RmckEQ5iJ+nKBcr0KHam+cFTlFjc/Iv1YYLIflLmcKT+3PrB6sEnIVBGkMLlkhrqk9k4
         BKjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4TWZ5J8EA9PdwXQbnZm0NmkDugYJ6Fik3NJSFa1FJGI=;
        b=NRaioig6ty8Htm0GaBX++j5jgfl4cNQDwP4ZiohkB9LNanrrGIFgle/CvK+VgFQJ7F
         kN2n+dVQx7Ih+eRBG+Y0+D86cVMQDsUT0xVCkF/635Oc+Wpl1Sl8sxhNNoNqIw0bOfe9
         kU09cDhvtcifzwIBn3WKcMEM3PzkKY1xizHJ5PiYe9aNaI5ilVUbCw6kvrBpNOCmZaXP
         vtCGmADPVGGrIAkXZ3JgdBMtuv5vg3fUCDbSb3OJnVq3tK4XXuCkFMxp/QPgSgJOqepm
         Ya6a4T3Wy3A9JkicyBJqw3uRfcOu1qtvdreoHc/kV9Fu93AlMCI07Dl3HpG1BXeMkbRc
         JCDA==
X-Gm-Message-State: AOAM530+W9v0BZZIi7csHo3cp3/gwDJjPzYuvtSijjn2r91p58nth3C9
        d7MjzPySpRzl6hqHuoxhgJ99Sg==
X-Google-Smtp-Source: ABdhPJz4sNhu15S1S/puGmk3r5k5M+rRg0OUWxllNWk2DqOl19JhHu6bYhi+mYc9W6kiCxQMCRxmBw==
X-Received: by 2002:a05:600c:35c1:: with SMTP id r1mr640374wmq.101.1628210439052;
        Thu, 05 Aug 2021 17:40:39 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id y19sm10727181wmq.5.2021.08.05.17.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 17:40:38 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, martin@kaiser.cx
Subject: [PATCH v2 02/11] staging: r8188eu: remove RT_TRACE calls from core/rtw_ioctl_set.c
Date:   Fri,  6 Aug 2021 01:40:25 +0100
Message-Id: <20210806004034.82233-3-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210806004034.82233-1-phil@philpotter.co.uk>
References: <20210806004034.82233-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove RT_TRACE macro calls from core/rtw_ioctl_set.c, so that ultimately the
macro definition itself can eventually be removed.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/core/rtw_ioctl_set.c | 218 +------------------
 1 file changed, 7 insertions(+), 211 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_ioctl_set.c b/drivers/staging/r8188eu/core/rtw_ioctl_set.c
index 3e2add5409cc..a7f966ad7082 100644
--- a/drivers/staging/r8188eu/core/rtw_ioctl_set.c
+++ b/drivers/staging/r8188eu/core/rtw_ioctl_set.c
@@ -26,7 +26,6 @@ u8 rtw_validate_ssid(struct ndis_802_11_ssid *ssid)
 	u8	ret = true;
 
 	if (ssid->SsidLength > 32) {
-		RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("ssid length >32\n"));
 		ret = false;
 		goto exit;
 	}
@@ -34,7 +33,6 @@ u8 rtw_validate_ssid(struct ndis_802_11_ssid *ssid)
 	for (i = 0; i < ssid->SsidLength; i++) {
 		/* wifi, printable ascii code must be supported */
 		if (!((ssid->Ssid[i] >= 0x20) && (ssid->Ssid[i] <= 0x7e))) {
-			RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("ssid has nonprintabl ascii\n"));
 			ret = false;
 			break;
 		}
@@ -57,8 +55,6 @@ u8 rtw_do_join(struct adapter *padapter)
 	phead = get_list_head(queue);
 	plist = phead->next;
 
-	RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_, ("\n rtw_do_join: phead = %p; plist = %p\n\n\n", phead, plist));
-
 	pmlmepriv->cur_network.join_res = -2;
 
 	set_fwstate(pmlmepriv, _FW_UNDER_LINKING);
@@ -76,13 +72,10 @@ u8 rtw_do_join(struct adapter *padapter)
 
 		if (!pmlmepriv->LinkDetectInfo.bBusyTraffic ||
 		    pmlmepriv->to_roaming > 0) {
-			RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_, ("rtw_do_join(): site survey if scanned_queue is empty\n."));
 			/*  submit site_survey_cmd */
 			ret = rtw_sitesurvey_cmd(padapter, &pmlmepriv->assoc_ssid, 1, NULL, 0);
-			if (_SUCCESS != ret) {
+			if (_SUCCESS != ret)
 				pmlmepriv->to_join = false;
-				RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("rtw_do_join(): site survey return error\n."));
-			}
 		} else {
 			pmlmepriv->to_join = false;
 			ret = _FAIL;
@@ -116,14 +109,10 @@ u8 rtw_do_join(struct adapter *padapter)
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
@@ -133,10 +122,8 @@ u8 rtw_do_join(struct adapter *padapter)
 				if (!pmlmepriv->LinkDetectInfo.bBusyTraffic ||
 				    pmlmepriv->to_roaming > 0) {
 					ret = rtw_sitesurvey_cmd(padapter, &pmlmepriv->assoc_ssid, 1, NULL, 0);
-					if (_SUCCESS != ret) {
+					if (_SUCCESS != ret)
 						pmlmepriv->to_join = false;
-						RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("do_join(): site survey return error\n."));
-					}
 				} else {
 					ret = _FAIL;
 					pmlmepriv->to_join = false;
@@ -175,16 +162,10 @@ u8 rtw_set_802_11_bssid(struct adapter *padapter, u8 *bssid)
 		goto release_mlme_lock;
 
 	if (check_fwstate(pmlmepriv, _FW_LINKED|WIFI_ADHOC_MASTER_STATE)) {
-		RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_, ("set_bssid: _FW_LINKED||WIFI_ADHOC_MASTER_STATE\n"));
-
 		if (!memcmp(&pmlmepriv->cur_network.network.MacAddress, bssid, ETH_ALEN)) {
 			if (check_fwstate(pmlmepriv, WIFI_STATION_STATE) == false)
 				goto release_mlme_lock;/* it means driver is in WIFI_ADHOC_MASTER_STATE, we needn't create bss again. */
 		} else {
-			RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_, ("Set BSSID not the same bssid\n"));
-			RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_, ("set_bssid =%pM\n", (bssid)));
-			RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_, ("cur_bssid =%pM\n", (pmlmepriv->cur_network.network.MacAddress)));
-
 			rtw_disassoc_cmd(padapter, 0, true);
 
 			if (check_fwstate(pmlmepriv, _FW_LINKED) == true)
@@ -226,9 +207,6 @@ u8 rtw_set_802_11_bssid(struct adapter *padapter, u8 *bssid)
 	spin_unlock_bh(&pmlmepriv->lock);
 
 exit:
-	RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_,
-		 ("rtw_set_802_11_bssid: status=%d\n", status));
-
 	return status;
 }
 
@@ -244,8 +222,6 @@ u8 rtw_set_802_11_ssid(struct adapter *padapter, struct ndis_802_11_ssid *ssid)
 		      ssid->Ssid, get_fwstate(pmlmepriv));
 
 	if (!padapter->hw_init_completed) {
-		RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_,
-			 ("set_ssid: hw_init_completed == false =>exit!!!\n"));
 		status = _FAIL;
 		goto exit;
 	}
@@ -260,16 +236,9 @@ u8 rtw_set_802_11_ssid(struct adapter *padapter, struct ndis_802_11_ssid *ssid)
 	}
 
 	if (check_fwstate(pmlmepriv, _FW_LINKED|WIFI_ADHOC_MASTER_STATE)) {
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
 				if (!rtw_is_same_ibss(padapter, pnetwork)) {
 					/* if in WIFI_ADHOC_MASTER_STATE | WIFI_ADHOC_STATE, create bss or rejoin again */
 					rtw_disassoc_cmd(padapter, 0, true);
@@ -290,10 +259,6 @@ u8 rtw_set_802_11_ssid(struct adapter *padapter, struct ndis_802_11_ssid *ssid)
 				rtw_lps_ctrl_wk_cmd(padapter, LPS_CTRL_JOINBSS, 1);
 			}
 		} else {
-			RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_, ("Set SSID not the same ssid\n"));
-			RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_, ("set_ssid =[%s] len = 0x%x\n", ssid->Ssid, (unsigned int)ssid->SsidLength));
-			RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_, ("assoc_ssid =[%s] len = 0x%x\n", pmlmepriv->assoc_ssid.Ssid, (unsigned int)pmlmepriv->assoc_ssid.SsidLength));
-
 			rtw_disassoc_cmd(padapter, 0, true);
 
 			if (check_fwstate(pmlmepriv, _FW_LINKED) == true)
@@ -335,9 +300,6 @@ u8 rtw_set_802_11_ssid(struct adapter *padapter, struct ndis_802_11_ssid *ssid)
 	spin_unlock_bh(&pmlmepriv->lock);
 
 exit:
-	RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_,
-		 ("-rtw_set_802_11_ssid: status =%d\n", status));
-
 	return status;
 }
 
@@ -348,14 +310,9 @@ u8 rtw_set_802_11_infrastructure_mode(struct adapter *padapter,
 	struct	wlan_network	*cur_network = &pmlmepriv->cur_network;
 	enum ndis_802_11_network_infra *pold_state = &(cur_network->network.InfrastructureMode);
 
-	RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_notice_,
-		 ("+rtw_set_802_11_infrastructure_mode: old =%d new =%d fw_state = 0x%08x\n",
-		  *pold_state, networktype, get_fwstate(pmlmepriv)));
-
 	if (*pold_state != networktype) {
 		spin_lock_bh(&pmlmepriv->lock);
 
-		RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_, (" change mode!"));
 		/* DBG_88E("change mode, old_mode =%d, new_mode =%d, fw_state = 0x%x\n", *pold_state, networktype, get_fwstate(pmlmepriv)); */
 
 		if (*pold_state == Ndis802_11APMode) {
@@ -414,9 +371,6 @@ u8 rtw_set_802_11_disassociate(struct adapter *padapter)
 	spin_lock_bh(&pmlmepriv->lock);
 
 	if (check_fwstate(pmlmepriv, _FW_LINKED)) {
-		RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_,
-			 ("MgntActrtw_set_802_11_disassociate: rtw_indicate_disconnect\n"));
-
 		rtw_disassoc_cmd(padapter, 0, true);
 		rtw_indicate_disconnect(padapter);
 		rtw_free_assoc_resources(padapter, 1);
@@ -433,29 +387,19 @@ u8 rtw_set_802_11_bssid_list_scan(struct adapter *padapter, struct ndis_802_11_s
 	struct	mlme_priv		*pmlmepriv = &padapter->mlmepriv;
 	u8	res = true;
 
-	RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("+rtw_set_802_11_bssid_list_scan(), fw_state =%x\n", get_fwstate(pmlmepriv)));
-
 	if (!padapter) {
 		res = false;
 		goto exit;
 	}
 	if (!padapter->hw_init_completed) {
 		res = false;
-		RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("\n === rtw_set_802_11_bssid_list_scan:hw_init_completed == false ===\n"));
 		goto exit;
 	}
 
 	if ((check_fwstate(pmlmepriv, _FW_UNDER_SURVEY|_FW_UNDER_LINKING)) ||
 	    (pmlmepriv->LinkDetectInfo.bBusyTraffic)) {
 		/*  Scan or linking is in progress, do nothing. */
-		RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("rtw_set_802_11_bssid_list_scan fail since fw_state = %x\n", get_fwstate(pmlmepriv)));
 		res = true;
-
-		if (check_fwstate(pmlmepriv, (_FW_UNDER_SURVEY|_FW_UNDER_LINKING)) == true) {
-			RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("\n###_FW_UNDER_SURVEY|_FW_UNDER_LINKING\n\n"));
-		} else {
-			RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("\n###pmlmepriv->sitesurveyctrl.traffic_busy == true\n\n"));
-		}
 	} else {
 		if (rtw_is_scan_deny(padapter)) {
 			DBG_88E(FUNC_ADPT_FMT": scan deny\n", FUNC_ADPT_ARG(padapter));
@@ -480,14 +424,8 @@ u8 rtw_set_802_11_authentication_mode(struct adapter *padapter, enum ndis_802_11
 	int res;
 	u8 ret;
 
-	RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_, ("set_802_11_auth.mode(): mode =%x\n", authmode));
-
 	psecuritypriv->ndisauthtype = authmode;
 
-	RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_,
-		 ("rtw_set_802_11_authentication_mode:psecuritypriv->ndisauthtype=%d",
-		 psecuritypriv->ndisauthtype));
-
 	if (psecuritypriv->ndisauthtype > 3)
 		psecuritypriv->dot11AuthAlgrthm = dot11AuthAlgrthm_8021X;
 
@@ -510,7 +448,6 @@ u8 rtw_set_802_11_add_wep(struct adapter *padapter, struct ndis_802_11_wep *wep)
 	keyid = wep->KeyIndex & 0x3fffffff;
 
 	if (keyid >= 4) {
-		RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("MgntActrtw_set_802_11_add_wep:keyid>4 =>fail\n"));
 		ret = false;
 		goto exit;
 	}
@@ -518,20 +455,14 @@ u8 rtw_set_802_11_add_wep(struct adapter *padapter, struct ndis_802_11_wep *wep)
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
-		 ("rtw_set_802_11_add_wep:befor memcpy, wep->KeyLength = 0x%x wep->KeyIndex = 0x%x  keyid =%x\n",
-		 wep->KeyLength, wep->KeyIndex, keyid));
 
 	memcpy(&(psecuritypriv->dot11DefKey[keyid].skey[0]), &(wep->KeyMaterial), wep->KeyLength);
 
@@ -539,22 +470,6 @@ u8 rtw_set_802_11_add_wep(struct adapter *padapter, struct ndis_802_11_wep *wep)
 
 	psecuritypriv->dot11PrivacyKeyIndex = keyid;
 
-	RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_,
-		 ("rtw_set_802_11_add_wep:security key material : %x %x %x %x %x %x %x %x %x %x %x %x %x\n",
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
@@ -601,15 +516,6 @@ u8 rtw_set_802_11_add_key(struct adapter *padapter, struct ndis_802_11_key *key)
 	if (((key->KeyIndex & 0x80000000) == 0) && ((key->KeyIndex & 0x40000000) > 0)) {
 		/*  It is invalid to clear bit 31 and set bit 30. If the miniport driver encounters this combination, */
 		/*  it must fail the request and return NDIS_STATUS_INVALID_DATA. */
-		RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_,
-			 ("rtw_set_802_11_add_key: ((key->KeyIndex & 0x80000000)==0)[=%d]",
-			 (int)(key->KeyIndex & 0x80000000) == 0));
-		RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_,
-			 ("rtw_set_802_11_add_key:((key->KeyIndex & 0x40000000)>0)[=%d]",
-			 (int)(key->KeyIndex & 0x40000000) > 0));
-		RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_,
-			 ("rtw_set_802_11_add_key: key->KeyIndex=%d\n",
-			 (int)key->KeyIndex));
 		ret = _FAIL;
 		goto exit;
 	}
@@ -617,54 +523,30 @@ u8 rtw_set_802_11_add_key(struct adapter *padapter, struct ndis_802_11_key *key)
 	if (key->KeyIndex & 0x40000000) {
 		/*  Pairwise key */
 
-		RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("OID_802_11_ADD_KEY: +++++ Pairwise key +++++\n"));
-
 		pbssid = get_bssid(&padapter->mlmepriv);
 		stainfo = rtw_get_stainfo(&padapter->stapriv, pbssid);
 
-		if (stainfo && padapter->securitypriv.dot11AuthAlgrthm == dot11AuthAlgrthm_8021X) {
-			RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_,
-				 ("OID_802_11_ADD_KEY:(stainfo!=NULL)&&(Adapter->securitypriv.dot11AuthAlgrthm==dot11AuthAlgrthm_8021X)\n"));
+		if (stainfo && padapter->securitypriv.dot11AuthAlgrthm == dot11AuthAlgrthm_8021X)
 			encryptionalgo = stainfo->dot118021XPrivacy;
-		} else {
-			RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("OID_802_11_ADD_KEY: stainfo == NULL)||(Adapter->securitypriv.dot11AuthAlgrthm!= dot11AuthAlgrthm_8021X)\n"));
+		else
 			encryptionalgo = padapter->securitypriv.dot11PrivacyAlgrthm;
-		}
-
-		RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_,
-			 ("rtw_set_802_11_add_key: (encryptionalgo==%d)!\n",
-			 encryptionalgo));
-		RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_,
-			 ("rtw_set_802_11_add_key: (Adapter->securitypriv.dot11PrivacyAlgrthm==%d)!\n",
-			 padapter->securitypriv.dot11PrivacyAlgrthm));
-		RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_,
-			 ("rtw_set_802_11_add_key: (Adapter->securitypriv.dot11AuthAlgrthm==%d)!\n",
-			 padapter->securitypriv.dot11AuthAlgrthm));
-
-		if (stainfo)
-			RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_,
-				 ("rtw_set_802_11_add_key: (stainfo->dot118021XPrivacy==%d)!\n",
-				 stainfo->dot118021XPrivacy));
 
 		if (key->KeyIndex & 0x000000FF) {
 			/*  The key index is specified in the lower 8 bits by values of zero to 255. */
 			/*  The key index should be set to zero for a Pairwise key, and the driver should fail with */
 			/*  NDIS_STATUS_INVALID_DATA if the lower 8 bits is not zero */
-			RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, (" key->KeyIndex & 0x000000FF.\n"));
 			ret = _FAIL;
 			goto exit;
 		}
 
 		/*  check BSSID */
 		if (IS_MAC_ADDRESS_BROADCAST(key->BSSID) == true) {
-			RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("MacAddr_isBcst(key->BSSID)\n"));
 			ret = false;
 			goto exit;
 		}
 
 		/*  Check key length for TKIP. */
 		if ((encryptionalgo == _TKIP_) && (key->KeyLength != 32)) {
-			RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("TKIP KeyLength:0x%x != 32\n", key->KeyLength));
 			ret = _FAIL;
 			goto exit;
 		}
@@ -683,95 +565,52 @@ u8 rtw_set_802_11_add_key(struct adapter *padapter, struct ndis_802_11_key *key)
 		/*  Check key length for WEP. For NDTEST, 2005.01.27, by rcnjko. */
 		if ((encryptionalgo == _WEP40_ || encryptionalgo == _WEP104_) &&
 		    (key->KeyLength != 5 && key->KeyLength != 13)) {
-			RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("WEP KeyLength:0x%x != 5 or 13\n", key->KeyLength));
 			ret = _FAIL;
 			goto exit;
 		}
 
 		bgroup = false;
-
-		/*  Check the pairwise key. Added by Annie, 2005-07-06. */
-		RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("------------------------------------------\n"));
-		RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("[Pairwise Key set]\n"));
-		RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("------------------------------------------\n"));
-		RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("key index: 0x%8x(0x%8x)\n", key->KeyIndex, (key->KeyIndex&0x3)));
-		RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("key Length: %d\n", key->KeyLength));
-		RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("------------------------------------------\n"));
-
 	} else {
 		/*  Group key - KeyIndex(BIT30 == 0) */
-		RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("OID_802_11_ADD_KEY: +++++ Group key +++++\n"));
-
 		/*  when add wep key through add key and didn't assigned encryption type before */
 		if ((padapter->securitypriv.ndisauthtype <= 3) &&
 		    (padapter->securitypriv.dot118021XGrpPrivacy == 0)) {
-			RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_,
-				 ("keylen =%d(Adapter->securitypriv.dot11PrivacyAlgrthm=%x )padapter->securitypriv.dot118021XGrpPrivacy(%x)\n",
-				 key->KeyLength, padapter->securitypriv.dot11PrivacyAlgrthm,
-				 padapter->securitypriv.dot118021XGrpPrivacy));
 			switch (key->KeyLength) {
 			case 5:
 				padapter->securitypriv.dot11PrivacyAlgrthm = _WEP40_;
-				RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_,
-					 ("Adapter->securitypriv.dot11PrivacyAlgrthm=%x key->KeyLength=%u\n",
-					 padapter->securitypriv.dot11PrivacyAlgrthm, key->KeyLength));
 				break;
 			case 13:
 				padapter->securitypriv.dot11PrivacyAlgrthm = _WEP104_;
-				RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_,
-					 ("Adapter->securitypriv.dot11PrivacyAlgrthm=%x key->KeyLength=%u\n",
-					 padapter->securitypriv.dot11PrivacyAlgrthm, key->KeyLength));
 				break;
 			default:
 				padapter->securitypriv.dot11PrivacyAlgrthm = _NO_PRIVACY_;
-				RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_,
-					 ("Adapter->securitypriv.dot11PrivacyAlgrthm=%x key->KeyLength=%u\n",
-					 padapter->securitypriv.dot11PrivacyAlgrthm, key->KeyLength));
 				break;
 			}
 
 			encryptionalgo = padapter->securitypriv.dot11PrivacyAlgrthm;
-
-			RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_,
-				 (" Adapter->securitypriv.dot11PrivacyAlgrthm=%x\n",
-				 padapter->securitypriv.dot11PrivacyAlgrthm));
-
 		} else {
 			encryptionalgo = padapter->securitypriv.dot118021XGrpPrivacy;
-			RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_,
-				 ("(Adapter->securitypriv.dot11PrivacyAlgrthm=%x)encryptionalgo(%x)=padapter->securitypriv.dot118021XGrpPrivacy(%x)keylen=%d\n",
-				 padapter->securitypriv.dot11PrivacyAlgrthm, encryptionalgo,
-				 padapter->securitypriv.dot118021XGrpPrivacy, key->KeyLength));
 		}
 
 		if ((check_fwstate(&padapter->mlmepriv, WIFI_ADHOC_STATE) == true) && (IS_MAC_ADDRESS_BROADCAST(key->BSSID) == false)) {
-			RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_,
-				 (" IBSS but BSSID is not Broadcast Address.\n"));
 			ret = _FAIL;
 			goto exit;
 		}
 
 		/*  Check key length for TKIP */
 		if ((encryptionalgo == _TKIP_) && (key->KeyLength != 32)) {
-			RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_,
-				 (" TKIP GTK KeyLength:%u != 32\n", key->KeyLength));
 			ret = _FAIL;
 			goto exit;
 		} else if (encryptionalgo == _AES_ && (key->KeyLength != 16 && key->KeyLength != 32)) {
 			/*  Check key length for AES */
 			/*  For NDTEST, we allow keylen = 32 in this case. 2005.01.27, by rcnjko. */
-			RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_,
-				 ("<=== SetInfo, OID_802_11_ADD_KEY: AES GTK KeyLength:%u != 16 or 32\n",
-				 key->KeyLength));
 			ret = _FAIL;
 			goto exit;
 		}
 
 		/*  Change the key length for EAPPkt9x.vxd. Added by Annie, 2005-11-03. */
-		if ((encryptionalgo ==  _AES_) && (key->KeyLength == 32)) {
+		if ((encryptionalgo ==  _AES_) && (key->KeyLength == 32))
 			key->KeyLength = 16;
-			RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("AES key length changed: %u\n", key->KeyLength));
-		}
 
 		if (key->KeyIndex & 0x8000000) {/* error ??? 0x8000_0000 */
 			bgrouptkey = true;
@@ -781,12 +620,6 @@ u8 rtw_set_802_11_add_key(struct adapter *padapter, struct ndis_802_11_key *key)
 		    (check_fwstate(&padapter->mlmepriv, _FW_LINKED)))
 			bgrouptkey = true;
 		bgroup = true;
-		RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("------------------------------------------\n"));
-		RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("[Group Key set]\n"));
-		RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("------------------------------------------\n")) ;
-		RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("key index: 0x%8x(0x%8x)\n", key->KeyIndex, (key->KeyIndex&0x3)));
-		RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("key Length: %d\n", key->KeyLength)) ;
-		RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("------------------------------------------\n"));
 	}
 
 	/*  If WEP encryption algorithm, just call rtw_set_802_11_add_wep(). */
@@ -796,15 +629,11 @@ u8 rtw_set_802_11_add_key(struct adapter *padapter, struct ndis_802_11_key *key)
 		u32 len = FIELD_OFFSET(struct ndis_802_11_key, KeyMaterial) + key->KeyLength;
 		struct ndis_802_11_wep *wep = &padapter->securitypriv.ndiswep;
 
-		RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("OID_802_11_ADD_KEY: +++++ WEP key +++++\n"));
-
 		wep->Length = len;
 		keyindex = key->KeyIndex&0x7fffffff;
 		wep->KeyIndex = keyindex ;
 		wep->KeyLength = key->KeyLength;
 
-		RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("OID_802_11_ADD_KEY:Before memcpy\n"));
-
 		memcpy(wep->KeyMaterial, key->KeyMaterial, key->KeyLength);
 		memcpy(&(padapter->securitypriv.dot11DefKey[keyindex].skey[0]), key->KeyMaterial, key->KeyLength);
 
@@ -816,7 +645,6 @@ u8 rtw_set_802_11_add_key(struct adapter *padapter, struct ndis_802_11_key *key)
 	}
 	if (key->KeyIndex & 0x20000000) {
 		/*  SetRSC */
-		RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("OID_802_11_ADD_KEY: +++++ SetRSC+++++\n"));
 		if (bgroup) {
 			unsigned long long keysrc = key->KeyRSC & 0x00FFFFFFFFFFFFULL;
 			memcpy(&padapter->securitypriv.dot11Grprxpn, &keysrc, 8);
@@ -844,34 +672,9 @@ u8 rtw_set_802_11_add_key(struct adapter *padapter, struct ndis_802_11_key *key)
 		if ((key->KeyIndex & 0x10000000)) {
 			memcpy(&padapter->securitypriv.dot118021XGrptxmickey[(u8)((key->KeyIndex) & 0x03)], key->KeyMaterial + 16, 8);
 			memcpy(&padapter->securitypriv.dot118021XGrprxmickey[(u8)((key->KeyIndex) & 0x03)], key->KeyMaterial + 24, 8);
-
-			RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_,
-				 ("\n rtw_set_802_11_add_key:rx mic :0x%02x:0x%02x:0x%02x:0x%02x:0x%02x:0x%02x:0x%02x:0x%02x\n",
-				 padapter->securitypriv.dot118021XGrprxmickey[(u8)((key->KeyIndex) & 0x03)].skey[0],
-				 padapter->securitypriv.dot118021XGrprxmickey[(u8)((key->KeyIndex-1) & 0x03)].skey[1],
-				 padapter->securitypriv.dot118021XGrprxmickey[(u8)((key->KeyIndex) & 0x03)].skey[2],
-				 padapter->securitypriv.dot118021XGrprxmickey[(u8)((key->KeyIndex-1) & 0x03)].skey[3],
-				 padapter->securitypriv.dot118021XGrprxmickey[(u8)((key->KeyIndex) & 0x03)].skey[4],
-				 padapter->securitypriv.dot118021XGrprxmickey[(u8)((key->KeyIndex-1) & 0x03)].skey[5],
-				 padapter->securitypriv.dot118021XGrprxmickey[(u8)((key->KeyIndex) & 0x03)].skey[6],
-				 padapter->securitypriv.dot118021XGrprxmickey[(u8)((key->KeyIndex-1) & 0x03)].skey[7]));
-			RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("\n rtw_set_802_11_add_key:set Group mic key!!!!!!!!\n"));
 		} else {
 			memcpy(&padapter->securitypriv.dot118021XGrptxmickey[(u8)((key->KeyIndex) & 0x03)], key->KeyMaterial + 24, 8);
 			memcpy(&padapter->securitypriv.dot118021XGrprxmickey[(u8)((key->KeyIndex) & 0x03)], key->KeyMaterial + 16, 8);
-
-			RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_,
-				 ("\n rtw_set_802_11_add_key:rx mic :0x%02x:0x%02x:0x%02x:0x%02x:0x%02x:0x%02x:0x%02x:0x%02x\n",
-				 padapter->securitypriv.dot118021XGrprxmickey[(u8)((key->KeyIndex) & 0x03)].skey[0],
-				 padapter->securitypriv.dot118021XGrprxmickey[(u8)((key->KeyIndex-1) & 0x03)].skey[1],
-				 padapter->securitypriv.dot118021XGrprxmickey[(u8)((key->KeyIndex) & 0x03)].skey[2],
-				 padapter->securitypriv.dot118021XGrprxmickey[(u8)((key->KeyIndex-1) & 0x03)].skey[3],
-				 padapter->securitypriv.dot118021XGrprxmickey[(u8)((key->KeyIndex) & 0x03)].skey[4],
-				 padapter->securitypriv.dot118021XGrprxmickey[(u8)((key->KeyIndex-1) & 0x03)].skey[5],
-				 padapter->securitypriv.dot118021XGrprxmickey[(u8)((key->KeyIndex) & 0x03)].skey[6],
-				 padapter->securitypriv.dot118021XGrprxmickey[(u8)((key->KeyIndex-1) & 0x03)].skey[7]));
-			RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_,
-				 ("\n rtw_set_802_11_add_key:set Group mic key!!!!!!!!\n"));
 		}
 
 		/* set group key by index */
@@ -883,8 +686,6 @@ u8 rtw_set_802_11_add_key(struct adapter *padapter, struct ndis_802_11_key *key)
 
 		padapter->securitypriv.bcheck_grpkey = false;
 
-		RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("reset group key"));
-
 		res = rtw_set_key(padapter, &padapter->securitypriv, key->KeyIndex, 1);
 
 		if (res == _FAIL)
@@ -908,8 +709,6 @@ u8 rtw_set_802_11_add_key(struct adapter *padapter, struct ndis_802_11_key *key)
 
 				/* _set_timer(&padapter->securitypriv.tkip_timer, 50); */
 
-				RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("\n========== _set_timer\n"));
-
 				/*  if TKIP, save the Receive/Transmit MIC key in KeyMaterial[128-255] */
 				if ((key->KeyIndex & 0x10000000)) {
 					memcpy(&stainfo->dot11tkiptxmickey, key->KeyMaterial + 16, 8);
@@ -922,13 +721,10 @@ u8 rtw_set_802_11_add_key(struct adapter *padapter, struct ndis_802_11_key *key)
 			}
 
 			/* Set key to CAM through H2C command */
-			if (bgrouptkey) { /* never go to here */
+			if (bgrouptkey) /* never go to here */
 				res = rtw_setstakey_cmd(padapter, (unsigned char *)stainfo, false);
-				RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("\n rtw_set_802_11_add_key:rtw_setstakey_cmd(group)\n"));
-			} else {
+			else
 				res = rtw_setstakey_cmd(padapter, (unsigned char *)stainfo, true);
-				RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("\n rtw_set_802_11_add_key:rtw_setstakey_cmd(unicast)\n"));
-			}
 			if (!res)
 				ret = _FAIL;
 		}
-- 
2.31.1

