Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A786E34FD2C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 11:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234851AbhCaJlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 05:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234834AbhCaJkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 05:40:36 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D50C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 02:40:36 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id o19so21530136edc.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 02:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LYjw/FrtWSONBsWFnEtZK/Xsed9JzNWFzjXI515mgus=;
        b=akYCwN87NWvaWJnJD8VTccBvScazetkldk2vK4NEjvcSCKy0tARsPb2Smzv2fxNTog
         SsAknxyy4dyqKZWr7XG5nlh1FiibREK98oDrtg3oiGkq87ccp8E+rNq5wDj4G66JzOrt
         bEPcK8JfwN74zV3h24wAkcvjPzIWj7uaY7uWITrYf9V9E+ISAaR15QeKy5dTn2kAAHVV
         5bdZGGIlNpZHYTv26EQugdeXnTq0VgPZcpSFU3Fu1xR4LVieWGLrErZ4rmZFMJV7NV0P
         Su4s8+JR+dQsRbZFdC9FYuULNekScvChwrvdlWCZ2bHCFx82pR924KJxRY3ccawzS94O
         u29A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LYjw/FrtWSONBsWFnEtZK/Xsed9JzNWFzjXI515mgus=;
        b=cGPkKyCMUyVYmfwAt3brIFrKPD9mWo9tH4F/KNBfWyKFIuWrPU2i2raauQeqydR1Z5
         QvDuR1xlUTlxOo9Ke+3mYVLUMFTnrevWN1UY0ygiG19ExUhf8S6DfKQsUAQS3eW+NY0H
         KbK36tifIQZFawv6ZMV85AqUGunL+havu8KZtlVW3F6iyKNvAeTf+KKpujGn2HkrfVtM
         xfhSvzt+siNGR57SW5UZBDqppL9FRgU3Fm12YhlrljzTMe3s4QjDr/m7uYnskAIUS+9n
         in5b2hnAnUiPlsFwzxOQTKioY9gmgyM4eGtNgTd43iNiHXeNKKzB8OQDFlgJYe51TW5/
         Q62A==
X-Gm-Message-State: AOAM533NVLAyOlsI+nUuOU5R/gFTUQu2G8bhYi6FYt8+ELKjiR+zphdV
        sT7OvwIJ0K9B5vqKquO7gFg=
X-Google-Smtp-Source: ABdhPJwhRJSIoOuVcpGEQKJEV1KELRbAee6QPLI5A4hFPjrKcgBWsoHsi2UjdJA5Ob5wN1yxuWUEUw==
X-Received: by 2002:aa7:df84:: with SMTP id b4mr2592616edy.240.1617183634981;
        Wed, 31 Mar 2021 02:40:34 -0700 (PDT)
Received: from agape ([5.171.73.44])
        by smtp.gmail.com with ESMTPSA id r17sm1126020edt.70.2021.03.31.02.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 02:40:34 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 12/40] staging: rtl8723bs: replace RT_TRACE with public printk wrappers in core/rtw_ioctl_set.c
Date:   Wed, 31 Mar 2021 11:39:40 +0200
Message-Id: <6a765753383184de416e9565165491ae84c89778.1617183374.git.fabioaiuto83@gmail.com>
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
 .../staging/rtl8723bs/core/rtw_ioctl_set.c    | 126 ++++++++++--------
 1 file changed, 74 insertions(+), 52 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c b/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
index 14eb01df69b0..21409307bb66 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
@@ -28,7 +28,7 @@ u8 rtw_validate_ssid(struct ndis_802_11_ssid *ssid)
 	u8 ret = true;
 
 	if (ssid->SsidLength > 32) {
-		RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("ssid length >32\n"));
+		pr_err("%s ssid length >32\n", DRIVER_PREFIX);
 		ret = false;
 		goto exit;
 	}
@@ -49,7 +49,8 @@ u8 rtw_do_join(struct adapter *padapter)
 	phead = get_list_head(queue);
 	plist = get_next(phead);
 
-	RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_, ("\n rtw_do_join: phead = %p; plist = %p\n\n\n", phead, plist));
+	pr_info("%s %s: phead = %p; plist = %p\n",
+		DRIVER_PREFIX, __func__, phead, plist);
 
 	pmlmepriv->cur_network.join_res = -2;
 
@@ -69,12 +70,14 @@ u8 rtw_do_join(struct adapter *padapter)
 		if (pmlmepriv->LinkDetectInfo.bBusyTraffic == false
 			|| rtw_to_roam(padapter) > 0
 		) {
-			RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_, ("rtw_do_join(): site survey if scanned_queue is empty\n."));
+			pr_info("%s %s: site survey if scanned_queue is empty\n.",
+				DRIVER_PREFIX, __func__);
 			/*  submit site_survey_cmd */
 			ret = rtw_sitesurvey_cmd(padapter, &pmlmepriv->assoc_ssid, 1, NULL, 0);
 			if (_SUCCESS != ret) {
 				pmlmepriv->to_join = false;
-				RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("rtw_do_join(): site survey return error\n."));
+				pr_err("%s %s: site survey return error\n.",
+				       DRIVER_PREFIX, __func__);
 			}
 		} else {
 			pmlmepriv->to_join = false;
@@ -107,14 +110,16 @@ u8 rtw_do_join(struct adapter *padapter)
 				rtw_generate_random_ibss(pibss);
 
 				if (rtw_createbss_cmd(padapter) != _SUCCESS) {
-					RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("***Error =>do_goin: rtw_createbss_cmd status FAIL***\n "));
+					pr_err("%s ***Error => %s: rtw_createbss_cmd status FAIL***\n ",
+					       DRIVER_PREFIX, __func__);
 					ret =  false;
 					goto exit;
 				}
 
 				pmlmepriv->to_join = false;
 
-				RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_, ("***Error => rtw_select_and_join_from_scanned_queue FAIL under STA_Mode***\n "));
+				pr_info("%s ***Error => rtw_select_and_join_from_scanned_queue FAIL under STA_Mode***\n",
+					DRIVER_PREFIX);
 
 			} else {
 				/*  can't associate ; reset under-linking */
@@ -129,7 +134,8 @@ u8 rtw_do_join(struct adapter *padapter)
 					ret = rtw_sitesurvey_cmd(padapter, &pmlmepriv->assoc_ssid, 1, NULL, 0);
 					if (_SUCCESS != ret) {
 						pmlmepriv->to_join = false;
-						RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("do_join(): site survey return error\n."));
+						pr_err("%s %s: site survey return error\n.",
+						       DRIVER_PREFIX, __func__);
 					}
 				} else {
 					ret = _FAIL;
@@ -169,15 +175,17 @@ u8 rtw_set_802_11_bssid(struct adapter *padapter, u8 *bssid)
 		goto release_mlme_lock;
 
 	if (check_fwstate(pmlmepriv, _FW_LINKED|WIFI_ADHOC_MASTER_STATE) == true) {
-		RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_, ("set_bssid: _FW_LINKED||WIFI_ADHOC_MASTER_STATE\n"));
+		pr_info("%s %s: _FW_LINKED||WIFI_ADHOC_MASTER_STATE\n",
+			DRIVER_PREFIX, __func__);
 
 		if (!memcmp(&pmlmepriv->cur_network.network.MacAddress, bssid, ETH_ALEN)) {
 			if (check_fwstate(pmlmepriv, WIFI_STATION_STATE) == false)
 				goto release_mlme_lock;/* it means driver is in WIFI_ADHOC_MASTER_STATE, we needn't create bss again. */
 		} else {
-			RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_, ("Set BSSID not the same bssid\n"));
-			RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_, ("set_bssid =%pM\n", MAC_ARG(bssid)));
-			RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_, ("cur_bssid =%pM\n", MAC_ARG(pmlmepriv->cur_network.network.MacAddress)));
+			pr_info("%s Set BSSID not the same bssid\n", DRIVER_PREFIX);
+			pr_info("%s set_bssid =%pM\n", DRIVER_PREFIX, MAC_ARG(bssid));
+			pr_info("%s cur_bssid =%pM\n", DRIVER_PREFIX,
+				MAC_ARG(pmlmepriv->cur_network.network.MacAddress));
 
 			rtw_disassoc_cmd(padapter, 0, true);
 
@@ -212,8 +220,7 @@ u8 rtw_set_802_11_bssid(struct adapter *padapter, u8 *bssid)
 	spin_unlock_bh(&pmlmepriv->lock);
 
 exit:
-	RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_,
-		("rtw_set_802_11_bssid: status =%d\n", status));
+	pr_err("%s %s: status =%d\n", DRIVER_PREFIX, __func__, status);
 
 	return status;
 }
@@ -229,8 +236,8 @@ u8 rtw_set_802_11_ssid(struct adapter *padapter, struct ndis_802_11_ssid *ssid)
 			ssid->Ssid, get_fwstate(pmlmepriv));
 
 	if (padapter->hw_init_completed == false) {
-		RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_,
-			 ("set_ssid: hw_init_completed ==false =>exit!!!\n"));
+		pr_err("%s %s: hw_init_completed ==false =>exit!!!\n",
+		       DRIVER_PREFIX, __func__);
 		status = _FAIL;
 		goto exit;
 	}
@@ -244,15 +251,14 @@ u8 rtw_set_802_11_ssid(struct adapter *padapter, struct ndis_802_11_ssid *ssid)
 		goto release_mlme_lock;
 
 	if (check_fwstate(pmlmepriv, _FW_LINKED|WIFI_ADHOC_MASTER_STATE) == true) {
-		RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_,
-			 ("set_ssid: _FW_LINKED||WIFI_ADHOC_MASTER_STATE\n"));
+		pr_info("%s %s: _FW_LINKED||WIFI_ADHOC_MASTER_STATE\n",
+			DRIVER_PREFIX, __func__);
 
 		if ((pmlmepriv->assoc_ssid.SsidLength == ssid->SsidLength) &&
 		    (!memcmp(&pmlmepriv->assoc_ssid.Ssid, ssid->Ssid, ssid->SsidLength))) {
 			if ((check_fwstate(pmlmepriv, WIFI_STATION_STATE) == false)) {
-				RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_,
-					 ("Set SSID is the same ssid, fw_state = 0x%08x\n",
-					  get_fwstate(pmlmepriv)));
+				pr_err("%s Set SSID is the same ssid, fw_state = 0x%08x\n",
+				       DRIVER_PREFIX, get_fwstate(pmlmepriv));
 
 				if (rtw_is_same_ibss(padapter, pnetwork) == false) {
 					/* if in WIFI_ADHOC_MASTER_STATE | WIFI_ADHOC_STATE, create bss or rejoin again */
@@ -274,9 +280,13 @@ u8 rtw_set_802_11_ssid(struct adapter *padapter, struct ndis_802_11_ssid *ssid)
 				rtw_lps_ctrl_wk_cmd(padapter, LPS_CTRL_JOINBSS, 1);
 			}
 		} else {
-			RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_, ("Set SSID not the same ssid\n"));
-			RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_, ("set_ssid =[%s] len = 0x%x\n", ssid->Ssid, (unsigned int)ssid->SsidLength));
-			RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_, ("assoc_ssid =[%s] len = 0x%x\n", pmlmepriv->assoc_ssid.Ssid, (unsigned int)pmlmepriv->assoc_ssid.SsidLength));
+			pr_info("%s Set SSID not the same ssid\n", DRIVER_PREFIX);
+			pr_info("%s %s =[%s] len = 0x%x\n",
+				DRIVER_PREFIX, __func__, ssid->Ssid,
+			       (unsigned int)ssid->SsidLength);
+			pr_info("%s assoc_ssid =[%s] len = 0x%x\n", DRIVER_PREFIX,
+				pmlmepriv->assoc_ssid.Ssid,
+				(unsigned int)pmlmepriv->assoc_ssid.SsidLength);
 
 			rtw_disassoc_cmd(padapter, 0, true);
 
@@ -315,8 +325,7 @@ u8 rtw_set_802_11_ssid(struct adapter *padapter, struct ndis_802_11_ssid *ssid)
 	spin_unlock_bh(&pmlmepriv->lock);
 
 exit:
-	RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_,
-		("-rtw_set_802_11_ssid: status =%d\n", status));
+	pr_err("%s - %s: status =%d\n", DRIVER_PREFIX, __func__, status);
 
 	return status;
 }
@@ -342,8 +351,8 @@ u8 rtw_set_802_11_connect(struct adapter *padapter, u8 *bssid, struct ndis_802_1
 	}
 
 	if (padapter->hw_init_completed == false) {
-		RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_,
-			 ("set_ssid: hw_init_completed ==false =>exit!!!\n"));
+		pr_err("%s %s: hw_init_completed ==false =>exit!!!\n",
+		       DRIVER_PREFIX, __func__);
 		status = _FAIL;
 		goto exit;
 	}
@@ -395,12 +404,12 @@ u8 rtw_set_802_11_infrastructure_mode(struct adapter *padapter,
 	struct	wlan_network	*cur_network = &pmlmepriv->cur_network;
 	enum ndis_802_11_network_infrastructure *pold_state = &(cur_network->network.InfrastructureMode);
 
-	RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_notice_,
-		 ("+rtw_set_802_11_infrastructure_mode: old =%d new =%d fw_state = 0x%08x\n",
-		  *pold_state, networktype, get_fwstate(pmlmepriv)));
+	pr_notice("%s + %s: old =%d new =%d fw_state = 0x%08x\n",
+		  DRIVER_PREFIX, __func__, *pold_state, networktype,
+		  get_fwstate(pmlmepriv));
 
 	if (*pold_state != networktype) {
-		RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_, (" change mode!"));
+		pr_info("%s change mode!", DRIVER_PREFIX);
 		/* DBG_871X("change mode, old_mode =%d, new_mode =%d, fw_state = 0x%x\n", *pold_state, networktype, get_fwstate(pmlmepriv)); */
 
 		if (*pold_state == Ndis802_11APMode) {
@@ -464,7 +473,7 @@ u8 rtw_set_802_11_disassociate(struct adapter *padapter)
 	spin_lock_bh(&pmlmepriv->lock);
 
 	if (check_fwstate(pmlmepriv, _FW_LINKED) == true) {
-		RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_, ("MgntActrtw_set_802_11_disassociate: rtw_indicate_disconnect\n"));
+		pr_info("%s %s: rtw_indicate_disconnect\n", DRIVER_PREFIX, __func__);
 
 		rtw_disassoc_cmd(padapter, 0, true);
 		rtw_indicate_disconnect(padapter);
@@ -484,7 +493,8 @@ u8 rtw_set_802_11_bssid_list_scan(struct adapter *padapter, struct ndis_802_11_s
 	struct	mlme_priv 	*pmlmepriv = &padapter->mlmepriv;
 	u8 res = true;
 
-	RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("+rtw_set_802_11_bssid_list_scan(), fw_state =%x\n", get_fwstate(pmlmepriv)));
+	pr_err("%s + %s, fw_state =%x\n", DRIVER_PREFIX, __func__,
+	       get_fwstate(pmlmepriv));
 
 	if (padapter == NULL) {
 		res = false;
@@ -492,20 +502,23 @@ u8 rtw_set_802_11_bssid_list_scan(struct adapter *padapter, struct ndis_802_11_s
 	}
 	if (padapter->hw_init_completed == false) {
 		res = false;
-		RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("\n ===rtw_set_802_11_bssid_list_scan:hw_init_completed ==false ===\n"));
+		pr_err("%s === %s:hw_init_completed ==false ===\n",
+		       DRIVER_PREFIX, __func__);
 		goto exit;
 	}
 
 	if ((check_fwstate(pmlmepriv, _FW_UNDER_SURVEY|_FW_UNDER_LINKING) == true) ||
 		(pmlmepriv->LinkDetectInfo.bBusyTraffic == true)) {
 		/*  Scan or linking is in progress, do nothing. */
-		RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("rtw_set_802_11_bssid_list_scan fail since fw_state = %x\n", get_fwstate(pmlmepriv)));
+		pr_err("%s %s: fail since fw_state = %x\n",
+		       DRIVER_PREFIX, __func__, get_fwstate(pmlmepriv));
 		res = true;
 
 		if (check_fwstate(pmlmepriv, (_FW_UNDER_SURVEY|_FW_UNDER_LINKING)) == true)
-			RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("\n###_FW_UNDER_SURVEY|_FW_UNDER_LINKING\n\n"));
+			pr_err("%s ###_FW_UNDER_SURVEY|_FW_UNDER_LINKING\n", DRIVER_PREFIX);
 		else
-			RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("\n###pmlmepriv->sitesurveyctrl.traffic_busy ==true\n\n"));
+			pr_err("%s ###pmlmepriv->sitesurveyctrl.traffic_busy ==true\n",
+			       DRIVER_PREFIX);
 	} else {
 		if (rtw_is_scan_deny(padapter)) {
 			DBG_871X(FUNC_ADPT_FMT": scan deny\n", FUNC_ADPT_ARG(padapter));
@@ -530,11 +543,12 @@ u8 rtw_set_802_11_authentication_mode(struct adapter *padapter, enum ndis_802_11
 	int res;
 	u8 ret;
 
-	RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_, ("set_802_11_auth.mode(): mode =%x\n", authmode));
+	pr_info("%s %s: mode =%x\n", DRIVER_PREFIX, __func__, authmode);
 
 	psecuritypriv->ndisauthtype = authmode;
 
-	RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_, ("rtw_set_802_11_authentication_mode:psecuritypriv->ndisauthtype =%d", psecuritypriv->ndisauthtype));
+	pr_info("%s %s:psecuritypriv->ndisauthtype =%d", DRIVER_PREFIX,
+		__func__, psecuritypriv->ndisauthtype);
 
 	if (psecuritypriv->ndisauthtype > 3)
 		psecuritypriv->dot11AuthAlgrthm = dot11AuthAlgrthm_8021X;
@@ -559,7 +573,7 @@ u8 rtw_set_802_11_add_wep(struct adapter *padapter, struct ndis_802_11_wep *wep)
 	keyid = wep->KeyIndex & 0x3fffffff;
 
 	if (keyid >= 4) {
-		RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("MgntActrtw_set_802_11_add_wep:keyid>4 =>fail\n"));
+		pr_err("%s %s:keyid>4 =>fail\n", DRIVER_PREFIX, __func__);
 		ret = false;
 		goto exit;
 	}
@@ -567,21 +581,20 @@ u8 rtw_set_802_11_add_wep(struct adapter *padapter, struct ndis_802_11_wep *wep)
 	switch (wep->KeyLength) {
 	case 5:
 		psecuritypriv->dot11PrivacyAlgrthm = _WEP40_;
-		RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_, ("MgntActrtw_set_802_11_add_wep:wep->KeyLength =5\n"));
+		pr_info("%s %s:wep->KeyLength =5\n", DRIVER_PREFIX, __func__);
 		break;
 	case 13:
 		psecuritypriv->dot11PrivacyAlgrthm = _WEP104_;
-		RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_, ("MgntActrtw_set_802_11_add_wep:wep->KeyLength = 13\n"));
+		pr_info("%s %s:wep->KeyLength = 13\n", DRIVER_PREFIX, __func__);
 		break;
 	default:
 		psecuritypriv->dot11PrivacyAlgrthm = _NO_PRIVACY_;
-		RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_, ("MgntActrtw_set_802_11_add_wep:wep->KeyLength!=5 or 13\n"));
+		pr_info("%s %s:wep->KeyLength!=5 or 13\n", DRIVER_PREFIX, __func__);
 		break;
 	}
 
-	RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_,
-		 ("rtw_set_802_11_add_wep:before memcpy, wep->KeyLength = 0x%x wep->KeyIndex = 0x%x  keyid =%x\n",
-		  wep->KeyLength, wep->KeyIndex, keyid));
+	pr_info("%s %s:before memcpy, wep->KeyLength = 0x%x wep->KeyIndex = 0x%x  keyid =%x\n",
+		DRIVER_PREFIX, __func__, wep->KeyLength, wep->KeyIndex, keyid);
 
 	memcpy(&(psecuritypriv->dot11DefKey[keyid].skey[0]), &(wep->KeyMaterial), wep->KeyLength);
 
@@ -589,12 +602,21 @@ u8 rtw_set_802_11_add_wep(struct adapter *padapter, struct ndis_802_11_wep *wep)
 
 	psecuritypriv->dot11PrivacyKeyIndex = keyid;
 
-	RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_, ("rtw_set_802_11_add_wep:security key material : %x %x %x %x %x %x %x %x %x %x %x %x %x\n",
-		psecuritypriv->dot11DefKey[keyid].skey[0], psecuritypriv->dot11DefKey[keyid].skey[1], psecuritypriv->dot11DefKey[keyid].skey[2],
-		psecuritypriv->dot11DefKey[keyid].skey[3], psecuritypriv->dot11DefKey[keyid].skey[4], psecuritypriv->dot11DefKey[keyid].skey[5],
-		psecuritypriv->dot11DefKey[keyid].skey[6], psecuritypriv->dot11DefKey[keyid].skey[7], psecuritypriv->dot11DefKey[keyid].skey[8],
-		psecuritypriv->dot11DefKey[keyid].skey[9], psecuritypriv->dot11DefKey[keyid].skey[10], psecuritypriv->dot11DefKey[keyid].skey[11],
-		psecuritypriv->dot11DefKey[keyid].skey[12]));
+	pr_info("%s %s:security key material : %x %x %x %x %x %x %x %x %x %x %x %x %x\n",
+		DRIVER_PREFIX, __func__,
+		psecuritypriv->dot11DefKey[keyid].skey[0],
+		psecuritypriv->dot11DefKey[keyid].skey[1],
+		psecuritypriv->dot11DefKey[keyid].skey[2],
+		psecuritypriv->dot11DefKey[keyid].skey[3],
+		psecuritypriv->dot11DefKey[keyid].skey[4],
+		psecuritypriv->dot11DefKey[keyid].skey[5],
+		psecuritypriv->dot11DefKey[keyid].skey[6],
+		psecuritypriv->dot11DefKey[keyid].skey[7],
+		psecuritypriv->dot11DefKey[keyid].skey[8],
+		psecuritypriv->dot11DefKey[keyid].skey[9],
+		psecuritypriv->dot11DefKey[keyid].skey[10],
+		psecuritypriv->dot11DefKey[keyid].skey[11],
+		psecuritypriv->dot11DefKey[keyid].skey[12]);
 
 	res = rtw_set_key(padapter, psecuritypriv, keyid, 1, true);
 
-- 
2.20.1

