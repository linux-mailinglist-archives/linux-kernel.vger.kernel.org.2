Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE8EF34FD4C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 11:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235157AbhCaJmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 05:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234938AbhCaJlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 05:41:12 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C65C061574
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 02:41:11 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id e7so21490177edu.10
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 02:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KGxxNO1+1wzxJ8J9QqLlCg7OevMiiohZgaz1srsUILk=;
        b=BCq8oMdy2ucPOpWkIyJlY/tS7Fjtj3W1OpDy19bYjuREMFsZfddP9VlkCTDrwmXwk2
         aV8u2wTgRhU0Bu26Ik6StTtnh6xLcme7SJfJo5Dh7FLorIzLLSIk89wP6RFZ9Dy1R6KB
         z+c/q8I1nzuk5Rf79bjc4cDB4G3VP0xqWoU1vtFgZZeqipXW5ObJAIrxBQLlylI0szd2
         E0V4dUTTw36BRTiqcGNUZTr1+66rwy5ZfiI6GAmTidnajUfO+/rsqL7t/+GQnA9mPF09
         7HDQJSAyrE0lHOWYoJrSVHG41VlYLc4tCxOa2csSnwlq3L+pG/yfgxQoIUKSQK9njNw0
         8JhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KGxxNO1+1wzxJ8J9QqLlCg7OevMiiohZgaz1srsUILk=;
        b=Wvc1BZPBU6E25y9Zidq2KR95khbluCG6DFiA0Kcps2QO24WsbTAMEyrx15ML2z9UHp
         8VvhxiK2Lt5Dp3h5oWbSiXZnhuGKcZADcEYSXvUCG3KZh7ODb6DzQk0WqWkb8Pmc2B95
         KARAzT+jRMV5H0Afr72QIbxUKc33vF8muExxXqkfEIdpioUOKxRpDifrY9TwpHFg/KQY
         eWwYpflDUC+KjFV5VlalCZ/Dsx5u3cm7Z8jYZMRKA3opCdCRrbCHSWv07s08PGD+kjRs
         go/0ynXI8uW6x4VZBfSF4d5rs4ltp+nQguN2sPDdBBa3P11nqZL3eGstot1XnSUHOAof
         plvg==
X-Gm-Message-State: AOAM533ibtldGicuoJTAEvq76dFqhSJatLH8ZW6xmDal4qprx8+UN5kT
        Kq/nNfhV15nfcEF2wBC84XQ=
X-Google-Smtp-Source: ABdhPJxbpNdJNsZg0GCW2k93w84ivzp4/NKu/DKP7Lfgi4TXcl8sghIaBvrqUQryaxAPmIZFSeRUDg==
X-Received: by 2002:a05:6402:3487:: with SMTP id v7mr2596843edc.302.1617183670554;
        Wed, 31 Mar 2021 02:41:10 -0700 (PDT)
Received: from agape ([5.171.73.44])
        by smtp.gmail.com with ESMTPSA id yk8sm833436ejb.123.2021.03.31.02.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 02:41:10 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 31/40] staging: rtl8723bs: replace RT_TRACE with public printk wrappers in os_dep/ioctl_linux.c
Date:   Wed, 31 Mar 2021 11:39:59 +0200
Message-Id: <ae9113ae91316d9f382bd3717bdd27de283d379f.1617183374.git.fabioaiuto83@gmail.com>
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
 .../staging/rtl8723bs/os_dep/ioctl_linux.c    | 81 ++++++++++---------
 1 file changed, 44 insertions(+), 37 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index aee4932162a9..c67064ddc88a 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -232,8 +232,10 @@ static char *translate_scan(struct adapter *padapter,
 		u16 wpa_len = 0, rsn_len = 0;
 		u8 *p;
 		rtw_get_sec_ie(pnetwork->network.IEs, pnetwork->network.IELength, rsn_ie, &rsn_len, wpa_ie, &wpa_len);
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_wx_get_scan: ssid =%s\n", pnetwork->network.Ssid.Ssid));
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_wx_get_scan: wpa_len =%d rsn_len =%d\n", wpa_len, rsn_len));
+		pr_info("%s rtw_wx_get_scan: ssid =%s\n", DRIVER_PREFIX,
+			pnetwork->network.Ssid.Ssid);
+		pr_info("%s rtw_wx_get_scan: wpa_len =%d rsn_len =%d\n",
+			DRIVER_PREFIX, wpa_len, rsn_len);
 
 		buf = kzalloc(MAX_WPA_IE_LEN*2, GFP_ATOMIC);
 		if (!buf)
@@ -423,7 +425,7 @@ static int wpa_set_encryption(struct net_device *dev, struct ieee_param *param,
 	}
 
 	if (strcmp(param->u.crypt.alg, "WEP") == 0) {
-		RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_err_, ("wpa_set_encryption, crypt.alg = WEP\n"));
+		pr_err("%s %s, crypt.alg = WEP\n", DRIVER_PREFIX, __func__);
 		DBG_871X("wpa_set_encryption, crypt.alg = WEP\n");
 
 		padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption1Enabled;
@@ -433,20 +435,21 @@ static int wpa_set_encryption(struct net_device *dev, struct ieee_param *param,
 		wep_key_idx = param->u.crypt.idx;
 		wep_key_len = param->u.crypt.key_len;
 
-		RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_info_, ("(1)wep_key_idx =%d\n", wep_key_idx));
+		pr_info("%s (1)wep_key_idx =%d\n", DRIVER_PREFIX, wep_key_idx);
 		DBG_871X("(1)wep_key_idx =%d\n", wep_key_idx);
 
 		if (wep_key_idx > WEP_KEYS)
 			return -EINVAL;
 
-		RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_info_, ("(2)wep_key_idx =%d\n", wep_key_idx));
+		pr_info("%s (2)wep_key_idx =%d\n", DRIVER_PREFIX, wep_key_idx);
 
 		if (wep_key_len > 0) {
 			wep_key_len = wep_key_len <= 5 ? 5 : 13;
 			wep_total_len = wep_key_len + FIELD_OFFSET(struct ndis_802_11_wep, KeyMaterial);
 			pwep = kzalloc(wep_total_len, GFP_KERNEL);
 			if (pwep == NULL) {
-				RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_err_, (" wpa_set_encryption: pwep allocate fail !!!\n"));
+				pr_err("%s %s: pwep allocate fail !!!\n",
+				       DRIVER_PREFIX, __func__);
 				goto exit;
 			}
 
@@ -612,7 +615,7 @@ static int rtw_set_wpa_ie(struct adapter *padapter, char *pie, unsigned short ie
 		}
 
 		if (ielen < RSN_HEADER_LEN) {
-			RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_err_, ("Ie len too short %d\n", ielen));
+			pr_err("%s Ie len too short %d\n", DRIVER_PREFIX, ielen);
 			ret  = -1;
 			goto exit;
 		}
@@ -715,9 +718,12 @@ static int rtw_set_wpa_ie(struct adapter *padapter, char *pie, unsigned short ie
                 /*  check_fwstate(&padapter->mlmepriv, WIFI_UNDER_WPS) == true) */
                 rtw_hal_set_hwreg(padapter, HW_VAR_OFF_RCR_AM, null_addr);
 
-	RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_info_,
-		 ("rtw_set_wpa_ie: pairwise_cipher = 0x%08x padapter->securitypriv.ndisencryptstatus =%d padapter->securitypriv.ndisauthtype =%d\n",
-		  pairwise_cipher, padapter->securitypriv.ndisencryptstatus, padapter->securitypriv.ndisauthtype));
+	pr_info("%s %s: pairwise_cipher = 0x%08x "
+		"padapter->securitypriv.ndisencryptstatus =%d "
+		"padapter->securitypriv.ndisauthtype =%d\n",
+		DRIVER_PREFIX, __func__, pairwise_cipher,
+		padapter->securitypriv.ndisencryptstatus,
+		padapter->securitypriv.ndisauthtype);
 
 exit:
 
@@ -738,7 +744,7 @@ static int rtw_wx_get_name(struct net_device *dev,
 	struct wlan_bssid_ex  *pcur_bss = &pmlmepriv->cur_network.network;
 	NDIS_802_11_RATES_EX *prates = NULL;
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("cmd_code =%x\n", info->cmd));
+	pr_info("%s cmd_code =%x\n", DRIVER_PREFIX, info->cmd);
 
 	if (check_fwstate(pmlmepriv, _FW_LINKED|WIFI_ADHOC_MASTER_STATE) == true) {
 		/* parsing HT_CAP_IE */
@@ -785,7 +791,7 @@ static int rtw_wx_set_freq(struct net_device *dev,
 			     struct iw_request_info *info,
 			     union iwreq_data *wrqu, char *extra)
 {
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_notice_, ("+rtw_wx_set_freq\n"));
+	pr_notice("%s+%s\n", DRIVER_PREFIX, __func__);
 
 	return 0;
 }
@@ -850,7 +856,8 @@ static int rtw_wx_set_mode(struct net_device *dev, struct iw_request_info *a,
 		break;
 	default:
 		ret = -EINVAL;
-		RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_err_, ("\n Mode: %s is not supported \n", iw_operation_mode[wrqu->mode]));
+		pr_err("%s Mode: %s is not supported\n", DRIVER_PREFIX,
+		       iw_operation_mode[wrqu->mode]);
 		goto exit;
 	}
 
@@ -884,7 +891,7 @@ static int rtw_wx_get_mode(struct net_device *dev, struct iw_request_info *a,
 	struct adapter *padapter = rtw_netdev_priv(dev);
 	struct	mlme_priv *pmlmepriv = &(padapter->mlmepriv);
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, (" rtw_wx_get_mode\n"));
+	pr_info("%s %s\n", DRIVER_PREFIX, __func__);
 
 	if (check_fwstate(pmlmepriv, WIFI_STATION_STATE) == true) {
 		wrqu->mode = IW_MODE_INFRA;
@@ -999,7 +1006,7 @@ static int rtw_wx_get_range(struct net_device *dev,
 	u16 val;
 	int i;
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_wx_get_range. cmd_code =%x\n", info->cmd));
+	pr_info("%s %s. cmd_code =%x\n", DRIVER_PREFIX, __func__, info->cmd);
 
 	wrqu->data.length = sizeof(*range);
 	memset(range, 0, sizeof(*range));
@@ -1178,7 +1185,7 @@ static int rtw_wx_get_wap(struct net_device *dev,
 
 	eth_zero_addr(wrqu->ap_addr.sa_data);
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_wx_get_wap\n"));
+	pr_info("%s %s\n", DRIVER_PREFIX, __func__);
 
 	if  (((check_fwstate(pmlmepriv, _FW_LINKED)) == true) ||
 			((check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE)) == true) ||
@@ -1232,7 +1239,7 @@ static int rtw_wx_set_scan(struct net_device *dev, struct iw_request_info *a,
 	struct adapter *padapter = rtw_netdev_priv(dev);
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct ndis_802_11_ssid ssid[RTW_SSID_SCAN_AMOUNT];
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_wx_set_scan\n"));
+	pr_info("%s %s\n", DRIVER_PREFIX, __func__);
 
 	#ifdef DBG_IOCTL
 	DBG_871X("DBG_IOCTL %s:%d\n", __func__, __LINE__);
@@ -1393,8 +1400,8 @@ static int rtw_wx_get_scan(struct net_device *dev, struct iw_request_info *a,
 	u32 ret = 0;
 	signed int wait_status;
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_wx_get_scan\n"));
-	RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_info_, (" Start of Query SIOCGIWSCAN .\n"));
+	pr_info("%s %s\n", DRIVER_PREFIX, __func__);
+	pr_info("%s Start of Query SIOCGIWSCAN .\n", DRIVER_PREFIX);
 
 	#ifdef DBG_IOCTL
 	DBG_871X("DBG_IOCTL %s:%d\n", __func__, __LINE__);
@@ -1477,8 +1484,8 @@ static int rtw_wx_set_essid(struct net_device *dev,
 	DBG_871X("DBG_IOCTL %s:%d\n", __func__, __LINE__);
 	#endif
 
-	RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_info_,
-		 ("+rtw_wx_set_essid: fw_state = 0x%08x\n", get_fwstate(pmlmepriv)));
+	pr_info("%s+%s: fw_state = 0x%08x\n", DRIVER_PREFIX, __func__,
+		get_fwstate(pmlmepriv));
 
 	rtw_ps_deny(padapter, PS_DENY_JOIN);
 	if (_FAIL == rtw_pwr_wakeup(padapter)) {
@@ -1513,15 +1520,15 @@ static int rtw_wx_set_essid(struct net_device *dev,
 		memcpy(ndis_ssid.Ssid, extra, len);
 		src_ssid = ndis_ssid.Ssid;
 
-		RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_info_, ("rtw_wx_set_essid: ssid =[%s]\n", src_ssid));
+		pr_info("%s %s: ssid =[%s]\n", DRIVER_PREFIX, __func__, src_ssid);
 		spin_lock_bh(&queue->lock);
 		phead = get_list_head(queue);
 		pmlmepriv->pscanned = get_next(phead);
 
 		while (1) {
 			if (phead == pmlmepriv->pscanned) {
-			        RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_warning_,
-					 ("rtw_wx_set_essid: scan_q is empty, set ssid to check if scanning again!\n"));
+				pr_warn("%s %s: scan_q is empty, set ssid to check if scanning again!\n",
+					DRIVER_PREFIX, __func__);
 
 				break;
 			}
@@ -1532,14 +1539,13 @@ static int rtw_wx_set_essid(struct net_device *dev,
 
 			dst_ssid = pnetwork->network.Ssid.Ssid;
 
-			RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_info_,
-				 ("rtw_wx_set_essid: dst_ssid =%s\n",
-				  pnetwork->network.Ssid.Ssid));
+			pr_info("%s %s: dst_ssid =%s\n", DRIVER_PREFIX, __func__,
+				pnetwork->network.Ssid.Ssid);
 
 			if ((!memcmp(dst_ssid, src_ssid, ndis_ssid.SsidLength)) &&
 				(pnetwork->network.Ssid.SsidLength == ndis_ssid.SsidLength)) {
-				RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_info_,
-					 ("rtw_wx_set_essid: find match, set infra mode\n"));
+				pr_info("%s %s: find match, set infra mode\n",
+					DRIVER_PREFIX, __func__);
 
 				if (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE) == true) {
 					if (pnetwork->network.InfrastructureMode != pmlmepriv->cur_network.network.InfrastructureMode)
@@ -1556,8 +1562,7 @@ static int rtw_wx_set_essid(struct net_device *dev,
 			}
 		}
 		spin_unlock_bh(&queue->lock);
-		RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_info_,
-			 ("set ssid: set_802_11_auth. mode =%d\n", authmode));
+		pr_info("%s set ssid: set_802_11_auth. mode =%d\n", DRIVER_PREFIX, authmode);
 		rtw_set_802_11_authentication_mode(padapter, authmode);
 		/* set_802_11_encryption_mode(padapter, padapter->securitypriv.ndisencryptstatus); */
 		if (rtw_set_802_11_ssid(padapter, &ndis_ssid) == false) {
@@ -1588,7 +1593,7 @@ static int rtw_wx_get_essid(struct net_device *dev,
 	struct	mlme_priv *pmlmepriv = &(padapter->mlmepriv);
 	struct wlan_bssid_ex  *pcur_bss = &pmlmepriv->cur_network.network;
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_wx_get_essid\n"));
+	pr_info("%s %s\n", DRIVER_PREFIX, __func__);
 
 	if ((check_fwstate(pmlmepriv, _FW_LINKED) == true) ||
 	      (check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE) == true)) {
@@ -1620,8 +1625,9 @@ static int rtw_wx_set_rate(struct net_device *dev,
 	u32 ratevalue = 0;
 	u8 mpdatarate[NumRates] = {11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0, 0xff};
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, (" rtw_wx_set_rate\n"));
-	RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_info_, ("target_rate = %d, fixed = %d\n", target_rate, fixed));
+	pr_info("%s %s\n", DRIVER_PREFIX, __func__);
+	pr_info("%s target_rate = %d, fixed = %d\n", DRIVER_PREFIX,
+		target_rate, fixed);
 
 	if (target_rate == -1) {
 		ratevalue = 11;
@@ -1682,11 +1688,11 @@ static int rtw_wx_set_rate(struct net_device *dev,
 			datarates[i] = 0xff;
 		}
 
-		RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_info_, ("datarate_inx =%d\n", datarates[i]));
+		pr_info("%s datarate_inx =%d\n", DRIVER_PREFIX, datarates[i]);
 	}
 
 	if (rtw_setdatarate_cmd(padapter, datarates) != _SUCCESS) {
-		RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_err_, ("rtw_wx_set_rate Fail!!!\n"));
+		pr_err("%s %s Fail!!!\n", DRIVER_PREFIX, __func__);
 		ret = -1;
 	}
 	return ret;
@@ -3180,7 +3186,8 @@ static int wpa_set_param(struct net_device *dev, u8 name, u32 value)
 			break;
 		}
 
-		RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_info_, ("wpa_set_param:padapter->securitypriv.ndisauthtype =%d\n", padapter->securitypriv.ndisauthtype));
+		pr_info("%s %s:padapter->securitypriv.ndisauthtype =%d\n",
+			DRIVER_PREFIX, __func__, padapter->securitypriv.ndisauthtype);
 
 		break;
 
-- 
2.20.1

