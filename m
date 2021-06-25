Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA673B39F0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 02:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232887AbhFYAK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 20:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbhFYAKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 20:10:22 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAFC8C061756
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 17:08:02 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id bm25so17549601qkb.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 17:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GYyzKD2BeIuu5Y00qslAc8hMyj/k7bojUxu81SjCYFI=;
        b=caTZJeZsbkuOj+liywLm6oqwkQcR8PBXMtUMipr+rm/11/62um5wLcGwaxf/G4PLds
         eyMPcL3IRsxQPABzi2MbTu9bSByurgF2JPXimce+zUB89v/alOsVY8TihnFpoXt33BYU
         b5ygDP+dZ21K7DBWB+VRP0xfIh0r9HqRWQzdXfq2SbqtuAHJ9nOR2vx0JRSE+qdFf3ug
         iTNF30YZdgtJ0v94iFfuXx/zss+2sFhyBIMr+Xho3eV9JZMwCGrcUal4Z4XqDDLwAzsI
         XA3ijNoOEKc0ggQ7pKLuHGxHfbME1ZuYIC74LR9h+6se6zVOQiYlKyI/T753CAh/3EQ3
         z4Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GYyzKD2BeIuu5Y00qslAc8hMyj/k7bojUxu81SjCYFI=;
        b=eZVDkiQArOKjYXyN0PNVbsG/CbEQ2ZGEYIXHZYeH+P2wVGEbk73VHD8JY8eE+jajLO
         +bZBRxnOCpWjtWgzTFGuuoroIy3eywdlD9KQF9MXYrTvo9kqq02l52Dm5mRTMRBJrpIz
         22pxsGmprPetmY3TUajo01BvQPSEPUICK0f/Lz0QF2XHVCQByvLTkEmiTI9S0QHkW8b1
         Sjuo2mwyZ2VYzga/GPucTHUBSlzACMgOUxkQzUe7fD9uFbE0uMoWH2LL41QsW4WG2sDX
         Wjwbm2RTVm67ExGrVmYDXGHfVUhT2lUp0pB7yPuXSBtX+KJc4AJw9Nj74Qfxy6uv0YS2
         s8qw==
X-Gm-Message-State: AOAM532VM5zGet69UJz/BMtYtD5fAy4GI3hW4c3Co/C7akM9azF07qyn
        TEYPAEHvd6sIQqGDIZcYKHZtFw==
X-Google-Smtp-Source: ABdhPJyigQe/xdy5wzL3VPmKf8UvOERM60fR8Jmv3TRjFMzAYQf6Uq/oSG+Zi6EVcdAQb0qGt/a3wA==
X-Received: by 2002:a05:620a:29d3:: with SMTP id s19mr8465452qkp.434.1624579681956;
        Thu, 24 Jun 2021 17:08:01 -0700 (PDT)
Received: from kerneldevvm.. (5.6.a.8.a.a.b.f.c.9.4.c.a.9.a.a.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:aa9a:c49c:fbaa:8a65])
        by smtp.gmail.com with ESMTPSA id m187sm3629014qkd.131.2021.06.24.17.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 17:08:01 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH 01/23] staging: rtl8188eu: remove all RT_TRACE calls from os_dep/ioctl_linux.c
Date:   Fri, 25 Jun 2021 01:07:34 +0100
Message-Id: <20210625000756.6313-2-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210625000756.6313-1-phil@philpotter.co.uk>
References: <20210625000756.6313-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove all RT_TRACE calls from os_dep/ioctl_linux.c as this macro is
unnecessary, and these calls are dubious in terms of necessity.
Removing all calls will ultimately allow the removal of the macro
itself.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 .../staging/rtl8188eu/os_dep/ioctl_linux.c    | 51 +------------------
 1 file changed, 1 insertion(+), 50 deletions(-)

diff --git a/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c b/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
index 7ab7706cf29c..c1e2f9829367 100644
--- a/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
@@ -239,8 +239,6 @@ static char *translate_scan(struct adapter *padapter,
 			return start;
 
 		rtw_get_sec_ie(pnetwork->network.ies, pnetwork->network.ie_length, rsn_ie, &rsn_len, wpa_ie, &wpa_len);
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_wx_get_scan: ssid =%s\n", pnetwork->network.ssid.ssid));
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_wx_get_scan: wpa_len =%d rsn_len =%d\n", wpa_len, rsn_len));
 
 		if (wpa_len > 0) {
 			p = buf;
@@ -370,8 +368,6 @@ static int wpa_set_encryption(struct net_device *dev, struct ieee_param *param,
 	}
 
 	if (strcmp(param->u.crypt.alg, "WEP") == 0) {
-		RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_err_, ("%s, crypt.alg = WEP\n", __func__));
-
 		padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption1Enabled;
 		padapter->securitypriv.dot11PrivacyAlgrthm = _WEP40_;
 		padapter->securitypriv.dot118021XGrpPrivacy = _WEP40_;
@@ -379,21 +375,15 @@ static int wpa_set_encryption(struct net_device *dev, struct ieee_param *param,
 		wep_key_idx = param->u.crypt.idx;
 		wep_key_len = param->u.crypt.key_len;
 
-		RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_info_, ("(1)wep_key_idx =%d\n", wep_key_idx));
-
 		if (wep_key_idx > WEP_KEYS)
 			return -EINVAL;
 
-		RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_info_, ("(2)wep_key_idx =%d\n", wep_key_idx));
-
 		if (wep_key_len > 0) {
 			wep_key_len = wep_key_len <= 5 ? 5 : 13;
 			wep_total_len = wep_key_len + offsetof(struct ndis_802_11_wep, KeyMaterial);
 			pwep = (struct ndis_802_11_wep *)rtw_malloc(wep_total_len);
-			if (!pwep) {
-				RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_err_, ("%s: pwep allocate fail !!!\n", __func__));
+			if (!pwep)
 				goto exit;
-			}
 			memset(pwep, 0, wep_total_len);
 			pwep->KeyLength = wep_key_len;
 			pwep->Length = wep_total_len;
@@ -503,7 +493,6 @@ static int rtw_set_wpa_ie(struct adapter *padapter, char *pie, unsigned short ie
 		}
 
 		if (ielen < RSN_HEADER_LEN) {
-			RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_err_, ("Ie len too short %d\n", ielen));
 			ret  = -1;
 			goto exit;
 		}
@@ -586,10 +575,6 @@ static int rtw_set_wpa_ie(struct adapter *padapter, char *pie, unsigned short ie
 			}
 		}
 	}
-
-	RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_info_,
-		 ("%s: pairwise_cipher = 0x%08x padapter->securitypriv.ndisencryptstatus =%d padapter->securitypriv.ndisauthtype =%d\n",
-		  __func__, pairwise_cipher, padapter->securitypriv.ndisencryptstatus, padapter->securitypriv.ndisauthtype));
 exit:
 	kfree(buf);
 	return ret;
@@ -609,8 +594,6 @@ static int rtw_wx_get_name(struct net_device *dev,
 	struct wlan_bssid_ex  *pcur_bss = &pmlmepriv->cur_network.network;
 	NDIS_802_11_RATES_EX *prates = NULL;
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("cmd_code =%x\n", info->cmd));
-
 	if (check_fwstate(pmlmepriv, _FW_LINKED | WIFI_ADHOC_MASTER_STATE)) {
 		/* parsing HT_CAP_IE */
 		p = rtw_get_ie(&pcur_bss->ies[12], WLAN_EID_HT_CAPABILITY, &ht_ielen, pcur_bss->ie_length - 12);
@@ -695,7 +678,6 @@ static int rtw_wx_set_mode(struct net_device *dev, struct iw_request_info *a,
 		break;
 	default:
 		ret = -EINVAL;
-		RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_err_, ("\n Mode: %s is not supported\n", iw_operation_mode[wrqu->mode]));
 		goto exit;
 	}
 	if (!rtw_set_802_11_infrastructure_mode(padapter, networkType)) {
@@ -713,8 +695,6 @@ static int rtw_wx_get_mode(struct net_device *dev, struct iw_request_info *a,
 	struct adapter *padapter = netdev_priv(dev);
 	struct	mlme_priv	*pmlmepriv = &padapter->mlmepriv;
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("%s\n", __func__));
-
 	if (check_fwstate(pmlmepriv, WIFI_STATION_STATE))
 		wrqu->mode = IW_MODE_INFRA;
 	else if  ((check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE)) ||
@@ -808,8 +788,6 @@ static int rtw_wx_get_range(struct net_device *dev,
 	u16 val;
 	int i;
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("%s. cmd_code =%x\n", __func__, info->cmd));
-
 	wrqu->data.length = sizeof(*range);
 	memset(range, 0, sizeof(*range));
 
@@ -960,8 +938,6 @@ static int rtw_wx_get_wap(struct net_device *dev,
 
 	eth_zero_addr(wrqu->ap_addr.sa_data);
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("%s\n", __func__));
-
 	if (check_fwstate(pmlmepriv, _FW_LINKED) ||
 	    check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE) ||
 	    check_fwstate(pmlmepriv, WIFI_AP_STATE))
@@ -1006,8 +982,6 @@ static int rtw_wx_set_scan(struct net_device *dev, struct iw_request_info *a,
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct ndis_802_11_ssid ssid[RTW_SSID_SCAN_AMOUNT];
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("%s\n", __func__));
-
 	if (!rtw_pwr_wakeup(padapter)) {
 		ret = -1;
 		goto exit;
@@ -1139,9 +1113,6 @@ static int rtw_wx_get_scan(struct net_device *dev, struct iw_request_info *a,
 	u32 wait_for_surveydone;
 	int wait_status;
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("%s\n", __func__));
-	RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_info_, (" Start of Query SIOCGIWSCAN .\n"));
-
 	if (padapter->pwrctrlpriv.brfoffbyhw && padapter->bDriverStopped) {
 		ret = -EINVAL;
 		goto exit;
@@ -1203,8 +1174,6 @@ static int rtw_wx_set_essid(struct net_device *dev,
 
 	uint ret = 0, len;
 
-	RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_info_,
-		 ("+%s: fw_state = 0x%08x\n", __func__, get_fwstate(pmlmepriv)));
 	if (!rtw_pwr_wakeup(padapter)) {
 		ret = -1;
 		goto exit;
@@ -1234,7 +1203,6 @@ static int rtw_wx_set_essid(struct net_device *dev,
 		memcpy(ndis_ssid.ssid, extra, len);
 		src_ssid = ndis_ssid.ssid;
 
-		RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_info_, ("%s: ssid =[%s]\n", __func__, src_ssid));
 		spin_lock_bh(&queue->lock);
 		phead = get_list_head(queue);
 		list_for_each(pmlmepriv->pscanned, phead) {
@@ -1243,14 +1211,8 @@ static int rtw_wx_set_essid(struct net_device *dev,
 
 			dst_ssid = pnetwork->network.ssid.ssid;
 
-			RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_info_,
-				 ("%s: dst_ssid =%s\n", __func__,
-				  pnetwork->network.ssid.ssid));
-
 			if ((!memcmp(dst_ssid, src_ssid, ndis_ssid.ssid_length)) &&
 			    (pnetwork->network.ssid.ssid_length == ndis_ssid.ssid_length)) {
-				RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_info_,
-					 ("%s: find match, set infra mode\n", __func__));
 
 				if (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE)) {
 					if (pnetwork->network.InfrastructureMode != pmlmepriv->cur_network.network.InfrastructureMode)
@@ -1267,8 +1229,6 @@ static int rtw_wx_set_essid(struct net_device *dev,
 			}
 		}
 		spin_unlock_bh(&queue->lock);
-		RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_info_,
-			 ("set ssid: set_802_11_auth. mode =%d\n", authmode));
 		rtw_set_802_11_authentication_mode(padapter, authmode);
 		if (!rtw_set_802_11_ssid(padapter, &ndis_ssid)) {
 			ret = -1;
@@ -1289,8 +1249,6 @@ static int rtw_wx_get_essid(struct net_device *dev,
 	struct	mlme_priv	*pmlmepriv = &padapter->mlmepriv;
 	struct wlan_bssid_ex  *pcur_bss = &pmlmepriv->cur_network.network;
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("%s\n", __func__));
-
 	if ((check_fwstate(pmlmepriv, _FW_LINKED)) ||
 	    (check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE))) {
 		len = pcur_bss->ssid.ssid_length;
@@ -1316,9 +1274,6 @@ static int rtw_wx_set_rate(struct net_device *dev,
 	u32	ratevalue = 0;
 	u8 mpdatarate[NumRates] = {11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0, 0xff};
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("%s\n", __func__));
-	RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_info_, ("target_rate = %d, fixed = %d\n", target_rate, fixed));
-
 	if (target_rate == -1) {
 		ratevalue = 11;
 		goto set_rate;
@@ -1377,8 +1332,6 @@ static int rtw_wx_set_rate(struct net_device *dev,
 		} else {
 			datarates[i] = 0xff;
 		}
-
-		RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_info_, ("datarate_inx =%d\n", datarates[i]));
 	}
 
 	return 0;
@@ -1846,8 +1799,6 @@ static int wpa_set_param(struct net_device *dev, u8 name, u32 value)
 			padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption3Enabled;
 			break;
 		}
-		RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_info_,
-			 ("%s:padapter->securitypriv.ndisauthtype =%d\n", __func__, padapter->securitypriv.ndisauthtype));
 		break;
 	case IEEE_PARAM_TKIP_COUNTERMEASURES:
 		break;
-- 
2.31.1

