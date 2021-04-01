Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C034735121D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 11:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234469AbhDAJXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 05:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233804AbhDAJWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 05:22:31 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A658C061788
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 02:22:31 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id bx7so1133765edb.12
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 02:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cGIVVIBArIi4j7JmW7U7K5Fscs/LZCEj+5lcumGvgHc=;
        b=Yh7psgUhB7ideH8qixVTDXs9HQyEiIfp/ri9pHfBxhrr+NNL54YOER6EcF9moAJSKw
         WR/45KBvfIQTtmO9omX+tFBgTKj2cWHgUqvV6vEh7b4rJ0TwHph7wjd4lo9GR4FVOHMZ
         RsnrsuwIE3Zf2HcOM+BiO6NQ9MMt3GhY3abVFkJ3BOPFFk8JyrIN1J/PYbQ2hGQZ6yNe
         7tQjW/c9z27WH/fk0yYAPszDD3v1E8b+JNvIlmippDFNsBh8HVmE2cac/i3N5RvgTNln
         33Dz5cABUw9GkndQ9nWBjt/hAVLS+BDXJMPz3d7P8MIHCCU030LrEcXDvI9yD8BIONNw
         HAHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cGIVVIBArIi4j7JmW7U7K5Fscs/LZCEj+5lcumGvgHc=;
        b=KSEyHBrSJORW1sP8NVxKGbgp21jTHR4IJdkDqbcoYwQ2ATiDb1OCui+YHNf8gVA3Jo
         UP+BUx09vtmB9M/wsxuN6Uz2cMc6I1gr9AJNhxGAqvJKtpVLXTrPAZ9Y935meZJ2Xn6X
         wpb0L5/dXlqXoXOQPs6Tl6jY7T5bzC5s9/SKI1Rw5Ku/rq9Yz+8lmpeSxBEC7nO3YkmY
         fYpfcmgREYSCCaYqAoXRPKDHPqiTI8BGFrlI/rs1aaxDJjcMROZ2ggpE7a/qPynfRzQd
         EEomd1UtRpn7bnQ03OQQZ+fn6VmITrgG7wugLMEPUBDyBiBtFKscCcQPTfSRpEy7fVkb
         g/8Q==
X-Gm-Message-State: AOAM533eTN7iiU+5n/jNVHEtw9RPpUtns50Spb0Eyzt+hOpIWPivJ39j
        B3k6xuWKnyUr/6o0EUCrQWU9IttPLHu6ig==
X-Google-Smtp-Source: ABdhPJx9iD5yGv2zeO0wOne8fuuA3aSLVa0aqg1qoeAl9Od3uYfHRTG9fr0oeN9sKIrKE9MW0r2lxQ==
X-Received: by 2002:a50:fa04:: with SMTP id b4mr8934142edq.293.1617268950202;
        Thu, 01 Apr 2021 02:22:30 -0700 (PDT)
Received: from agape ([5.171.80.247])
        by smtp.gmail.com with ESMTPSA id bx24sm2531540ejc.88.2021.04.01.02.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 02:22:29 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, dan.carpenter@oracle.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 41/49] staging: rtl8723bs: remove RT_TRACE logs in os_dep/ioctl_linux.c
Date:   Thu,  1 Apr 2021 11:21:11 +0200
Message-Id: <c9ca7af2e371a09df886163d3d01a337654ffc3c.1617268327.git.fabioaiuto83@gmail.com>
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
 .../staging/rtl8723bs/os_dep/ioctl_linux.c    | 51 -------------------
 1 file changed, 51 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index aee4932162a9..3dbe136a9e03 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -232,8 +232,6 @@ static char *translate_scan(struct adapter *padapter,
 		u16 wpa_len = 0, rsn_len = 0;
 		u8 *p;
 		rtw_get_sec_ie(pnetwork->network.IEs, pnetwork->network.IELength, rsn_ie, &rsn_len, wpa_ie, &wpa_len);
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_wx_get_scan: ssid =%s\n", pnetwork->network.Ssid.Ssid));
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_wx_get_scan: wpa_len =%d rsn_len =%d\n", wpa_len, rsn_len));
 
 		buf = kzalloc(MAX_WPA_IE_LEN*2, GFP_ATOMIC);
 		if (!buf)
@@ -423,7 +421,6 @@ static int wpa_set_encryption(struct net_device *dev, struct ieee_param *param,
 	}
 
 	if (strcmp(param->u.crypt.alg, "WEP") == 0) {
-		RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_err_, ("wpa_set_encryption, crypt.alg = WEP\n"));
 		DBG_871X("wpa_set_encryption, crypt.alg = WEP\n");
 
 		padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption1Enabled;
@@ -433,20 +430,16 @@ static int wpa_set_encryption(struct net_device *dev, struct ieee_param *param,
 		wep_key_idx = param->u.crypt.idx;
 		wep_key_len = param->u.crypt.key_len;
 
-		RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_info_, ("(1)wep_key_idx =%d\n", wep_key_idx));
 		DBG_871X("(1)wep_key_idx =%d\n", wep_key_idx);
 
 		if (wep_key_idx > WEP_KEYS)
 			return -EINVAL;
 
-		RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_info_, ("(2)wep_key_idx =%d\n", wep_key_idx));
-
 		if (wep_key_len > 0) {
 			wep_key_len = wep_key_len <= 5 ? 5 : 13;
 			wep_total_len = wep_key_len + FIELD_OFFSET(struct ndis_802_11_wep, KeyMaterial);
 			pwep = kzalloc(wep_total_len, GFP_KERNEL);
 			if (pwep == NULL) {
-				RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_err_, (" wpa_set_encryption: pwep allocate fail !!!\n"));
 				goto exit;
 			}
 
@@ -612,7 +605,6 @@ static int rtw_set_wpa_ie(struct adapter *padapter, char *pie, unsigned short ie
 		}
 
 		if (ielen < RSN_HEADER_LEN) {
-			RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_err_, ("Ie len too short %d\n", ielen));
 			ret  = -1;
 			goto exit;
 		}
@@ -715,10 +707,6 @@ static int rtw_set_wpa_ie(struct adapter *padapter, char *pie, unsigned short ie
                 /*  check_fwstate(&padapter->mlmepriv, WIFI_UNDER_WPS) == true) */
                 rtw_hal_set_hwreg(padapter, HW_VAR_OFF_RCR_AM, null_addr);
 
-	RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_info_,
-		 ("rtw_set_wpa_ie: pairwise_cipher = 0x%08x padapter->securitypriv.ndisencryptstatus =%d padapter->securitypriv.ndisauthtype =%d\n",
-		  pairwise_cipher, padapter->securitypriv.ndisencryptstatus, padapter->securitypriv.ndisauthtype));
-
 exit:
 
 	kfree(buf);
@@ -738,8 +726,6 @@ static int rtw_wx_get_name(struct net_device *dev,
 	struct wlan_bssid_ex  *pcur_bss = &pmlmepriv->cur_network.network;
 	NDIS_802_11_RATES_EX *prates = NULL;
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("cmd_code =%x\n", info->cmd));
-
 	if (check_fwstate(pmlmepriv, _FW_LINKED|WIFI_ADHOC_MASTER_STATE) == true) {
 		/* parsing HT_CAP_IE */
 		p = rtw_get_ie(&pcur_bss->IEs[12], WLAN_EID_HT_CAPABILITY, &ht_ielen, pcur_bss->IELength-12);
@@ -785,8 +771,6 @@ static int rtw_wx_set_freq(struct net_device *dev,
 			     struct iw_request_info *info,
 			     union iwreq_data *wrqu, char *extra)
 {
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_notice_, ("+rtw_wx_set_freq\n"));
-
 	return 0;
 }
 
@@ -850,7 +834,6 @@ static int rtw_wx_set_mode(struct net_device *dev, struct iw_request_info *a,
 		break;
 	default:
 		ret = -EINVAL;
-		RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_err_, ("\n Mode: %s is not supported \n", iw_operation_mode[wrqu->mode]));
 		goto exit;
 	}
 
@@ -884,8 +867,6 @@ static int rtw_wx_get_mode(struct net_device *dev, struct iw_request_info *a,
 	struct adapter *padapter = rtw_netdev_priv(dev);
 	struct	mlme_priv *pmlmepriv = &(padapter->mlmepriv);
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, (" rtw_wx_get_mode\n"));
-
 	if (check_fwstate(pmlmepriv, WIFI_STATION_STATE) == true) {
 		wrqu->mode = IW_MODE_INFRA;
 	} else if  ((check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE) == true) ||
@@ -999,8 +980,6 @@ static int rtw_wx_get_range(struct net_device *dev,
 	u16 val;
 	int i;
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_wx_get_range. cmd_code =%x\n", info->cmd));
-
 	wrqu->data.length = sizeof(*range);
 	memset(range, 0, sizeof(*range));
 
@@ -1178,8 +1157,6 @@ static int rtw_wx_get_wap(struct net_device *dev,
 
 	eth_zero_addr(wrqu->ap_addr.sa_data);
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_wx_get_wap\n"));
-
 	if  (((check_fwstate(pmlmepriv, _FW_LINKED)) == true) ||
 			((check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE)) == true) ||
 			((check_fwstate(pmlmepriv, WIFI_AP_STATE)) == true)) {
@@ -1232,7 +1209,6 @@ static int rtw_wx_set_scan(struct net_device *dev, struct iw_request_info *a,
 	struct adapter *padapter = rtw_netdev_priv(dev);
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct ndis_802_11_ssid ssid[RTW_SSID_SCAN_AMOUNT];
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_wx_set_scan\n"));
 
 	#ifdef DBG_IOCTL
 	DBG_871X("DBG_IOCTL %s:%d\n", __func__, __LINE__);
@@ -1393,9 +1369,6 @@ static int rtw_wx_get_scan(struct net_device *dev, struct iw_request_info *a,
 	u32 ret = 0;
 	signed int wait_status;
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_wx_get_scan\n"));
-	RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_info_, (" Start of Query SIOCGIWSCAN .\n"));
-
 	#ifdef DBG_IOCTL
 	DBG_871X("DBG_IOCTL %s:%d\n", __func__, __LINE__);
 	#endif
@@ -1477,9 +1450,6 @@ static int rtw_wx_set_essid(struct net_device *dev,
 	DBG_871X("DBG_IOCTL %s:%d\n", __func__, __LINE__);
 	#endif
 
-	RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_info_,
-		 ("+rtw_wx_set_essid: fw_state = 0x%08x\n", get_fwstate(pmlmepriv)));
-
 	rtw_ps_deny(padapter, PS_DENY_JOIN);
 	if (_FAIL == rtw_pwr_wakeup(padapter)) {
 		ret = -1;
@@ -1513,16 +1483,12 @@ static int rtw_wx_set_essid(struct net_device *dev,
 		memcpy(ndis_ssid.Ssid, extra, len);
 		src_ssid = ndis_ssid.Ssid;
 
-		RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_info_, ("rtw_wx_set_essid: ssid =[%s]\n", src_ssid));
 		spin_lock_bh(&queue->lock);
 		phead = get_list_head(queue);
 		pmlmepriv->pscanned = get_next(phead);
 
 		while (1) {
 			if (phead == pmlmepriv->pscanned) {
-			        RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_warning_,
-					 ("rtw_wx_set_essid: scan_q is empty, set ssid to check if scanning again!\n"));
-
 				break;
 			}
 
@@ -1532,14 +1498,8 @@ static int rtw_wx_set_essid(struct net_device *dev,
 
 			dst_ssid = pnetwork->network.Ssid.Ssid;
 
-			RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_info_,
-				 ("rtw_wx_set_essid: dst_ssid =%s\n",
-				  pnetwork->network.Ssid.Ssid));
-
 			if ((!memcmp(dst_ssid, src_ssid, ndis_ssid.SsidLength)) &&
 				(pnetwork->network.Ssid.SsidLength == ndis_ssid.SsidLength)) {
-				RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_info_,
-					 ("rtw_wx_set_essid: find match, set infra mode\n"));
 
 				if (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE) == true) {
 					if (pnetwork->network.InfrastructureMode != pmlmepriv->cur_network.network.InfrastructureMode)
@@ -1556,8 +1516,6 @@ static int rtw_wx_set_essid(struct net_device *dev,
 			}
 		}
 		spin_unlock_bh(&queue->lock);
-		RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_info_,
-			 ("set ssid: set_802_11_auth. mode =%d\n", authmode));
 		rtw_set_802_11_authentication_mode(padapter, authmode);
 		/* set_802_11_encryption_mode(padapter, padapter->securitypriv.ndisencryptstatus); */
 		if (rtw_set_802_11_ssid(padapter, &ndis_ssid) == false) {
@@ -1588,8 +1546,6 @@ static int rtw_wx_get_essid(struct net_device *dev,
 	struct	mlme_priv *pmlmepriv = &(padapter->mlmepriv);
 	struct wlan_bssid_ex  *pcur_bss = &pmlmepriv->cur_network.network;
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_wx_get_essid\n"));
-
 	if ((check_fwstate(pmlmepriv, _FW_LINKED) == true) ||
 	      (check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE) == true)) {
 		len = pcur_bss->Ssid.SsidLength;
@@ -1620,9 +1576,6 @@ static int rtw_wx_set_rate(struct net_device *dev,
 	u32 ratevalue = 0;
 	u8 mpdatarate[NumRates] = {11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0, 0xff};
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, (" rtw_wx_set_rate\n"));
-	RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_info_, ("target_rate = %d, fixed = %d\n", target_rate, fixed));
-
 	if (target_rate == -1) {
 		ratevalue = 11;
 		goto set_rate;
@@ -1682,11 +1635,9 @@ static int rtw_wx_set_rate(struct net_device *dev,
 			datarates[i] = 0xff;
 		}
 
-		RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_info_, ("datarate_inx =%d\n", datarates[i]));
 	}
 
 	if (rtw_setdatarate_cmd(padapter, datarates) != _SUCCESS) {
-		RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_err_, ("rtw_wx_set_rate Fail!!!\n"));
 		ret = -1;
 	}
 	return ret;
@@ -3180,8 +3131,6 @@ static int wpa_set_param(struct net_device *dev, u8 name, u32 value)
 			break;
 		}
 
-		RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_info_, ("wpa_set_param:padapter->securitypriv.ndisauthtype =%d\n", padapter->securitypriv.ndisauthtype));
-
 		break;
 
 	case IEEE_PARAM_TKIP_COUNTERMEASURES:
-- 
2.20.1

