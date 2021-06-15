Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E98233A72DD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 02:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbhFOASR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 20:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbhFOASP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 20:18:15 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F072C061767
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 17:15:56 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id w4so14003231qvr.11
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 17:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tQ4yu15NFliDq5fletspYb7hL43WSGznvzUCmpiPuoY=;
        b=hGBKF2Q6HynLpz8nReZHqyP60awe6oSE15fflewkLPK13mF06erHfmxvVuJzVjiyQy
         3GpVEdxj+VDGSt7Dv+jVlSE8gF+18ggAmRymMx0gOW3zjoQa3rrwuIzSA1oeTvGm+oVl
         tifHj82xuJxfgpojmE/bwxfM9J/zY8ch1j/53OzGQEPAeLrUe2ZlCREs4zU5ZQRw4XJq
         lX6akWR8uREH1OxBUZZSu1iLU9oe1IAfs3kiDGzPHf6+R4IvrBxq9u7klThzPGHU+yDc
         TFaUjeIGTbLqVsV7zEeAHRLENK7f9u5Qt4XrnJBWT+ci3JQe/rK+VzU3zq+QSdaViVDz
         vmMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tQ4yu15NFliDq5fletspYb7hL43WSGznvzUCmpiPuoY=;
        b=agJVRrPqg7u8p0Q0ned1KQx96MAPHRtRVZSg2N7ksHnsiQAyyG0FtR8fsgP12u+ZwC
         2z0b4mhHxhv0df2hZPd5DTRggQIpL5seg+xMwg3ukoETkZHRegxvTMUj4jJvF64cFAeR
         cbviiH9BnThfE+YNMRIF2vLDwFLrPKDd2BAnnIt0CiZxG5QQJ3NRU5wt/4lMcWegAh99
         9Va0XWemQPFk91Ux0o0frP6PXYwZORu18TBj+Bak3ZrUyKnIDJ71xm+njRW0KMgyEdNX
         845af6pjUTz+mLt6dPj08zNIvEo9ibexaOPmwoyftTsPmq6c7FTXd5a3Qi1uAdwei8MK
         nbvg==
X-Gm-Message-State: AOAM532TAiCeaKG5rwoDO4hOvyOTtvwaLJZ5cr7D7zA6XZrnVq3J1aHm
        4g59S+qME5ATXbkJPD42YqV0+Q==
X-Google-Smtp-Source: ABdhPJyMTNpb64JqbTuOx04O5xCrRc7zdQqVlVyoaAV8EguFLaRxhc0Cec4Lmzu2qxyb8EBG9d7lYQ==
X-Received: by 2002:a05:6214:6b1:: with SMTP id s17mr495183qvz.60.1623716155400;
        Mon, 14 Jun 2021 17:15:55 -0700 (PDT)
Received: from localhost.localdomain (5.d.e.a.c.b.a.1.5.0.9.4.d.7.7.d.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:d77d:4905:1abc:aed5])
        by smtp.gmail.com with ESMTPSA id m199sm11244248qke.71.2021.06.14.17.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 17:15:55 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH 11/28] staging: rtl8188eu: remove all DBG_88E calls from os_dep/ioctl_linux.c
Date:   Tue, 15 Jun 2021 01:14:50 +0100
Message-Id: <20210615001507.1171-12-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210615001507.1171-1-phil@philpotter.co.uk>
References: <20210615001507.1171-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove all DBG_88E calls from os_dep/ioctl_linux.c as this macro is
unnecessary, and many of these calls are dubious in terms of necessity.
Removing all calls will ultimately allow the removal of the macro
itself.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 .../staging/rtl8188eu/os_dep/ioctl_linux.c    | 144 +-----------------
 1 file changed, 7 insertions(+), 137 deletions(-)

diff --git a/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c b/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
index 70c028e06aee..12f845c17aa5 100644
--- a/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
@@ -325,26 +325,20 @@ static int wpa_set_auth_algs(struct net_device *dev, u32 value)
 	int ret = 0;
 
 	if ((value & AUTH_ALG_SHARED_KEY) && (value & AUTH_ALG_OPEN_SYSTEM)) {
-		DBG_88E("%s, AUTH_ALG_SHARED_KEY and  AUTH_ALG_OPEN_SYSTEM [value:0x%x]\n", __func__, value);
 		padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption1Enabled;
 		padapter->securitypriv.ndisauthtype = Ndis802_11AuthModeAutoSwitch;
 		padapter->securitypriv.dot11AuthAlgrthm = dot11AuthAlgrthm_Auto;
 	} else if (value & AUTH_ALG_SHARED_KEY) {
-		DBG_88E("%s, AUTH_ALG_SHARED_KEY  [value:0x%x]\n", __func__, value);
 		padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption1Enabled;
 
 		padapter->securitypriv.ndisauthtype = Ndis802_11AuthModeShared;
 		padapter->securitypriv.dot11AuthAlgrthm = dot11AuthAlgrthm_Shared;
 	} else if (value & AUTH_ALG_OPEN_SYSTEM) {
-		DBG_88E("%s, AUTH_ALG_OPEN_SYSTEM\n", __func__);
 		if (padapter->securitypriv.ndisauthtype < Ndis802_11AuthModeWPAPSK) {
 			padapter->securitypriv.ndisauthtype = Ndis802_11AuthModeOpen;
 			padapter->securitypriv.dot11AuthAlgrthm = dot11AuthAlgrthm_Open;
 		}
-	} else if (value & AUTH_ALG_LEAP) {
-		DBG_88E("%s, AUTH_ALG_LEAP\n", __func__);
 	} else {
-		DBG_88E("%s, error!\n", __func__);
 		ret = -EINVAL;
 	}
 	return ret;
@@ -379,7 +373,6 @@ static int wpa_set_encryption(struct net_device *dev, struct ieee_param *param,
 
 	if (strcmp(param->u.crypt.alg, "WEP") == 0) {
 		RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_err_, ("%s, crypt.alg = WEP\n", __func__));
-		DBG_88E("%s, crypt.alg = WEP\n", __func__);
 
 		padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption1Enabled;
 		padapter->securitypriv.dot11PrivacyAlgrthm = _WEP40_;
@@ -389,7 +382,6 @@ static int wpa_set_encryption(struct net_device *dev, struct ieee_param *param,
 		wep_key_len = param->u.crypt.key_len;
 
 		RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_info_, ("(1)wep_key_idx =%d\n", wep_key_idx));
-		DBG_88E("(1)wep_key_idx =%d\n", wep_key_idx);
 
 		if (wep_key_idx > WEP_KEYS)
 			return -EINVAL;
@@ -419,11 +411,9 @@ static int wpa_set_encryption(struct net_device *dev, struct ieee_param *param,
 		pwep->KeyIndex |= 0x80000000;
 		memcpy(pwep->KeyMaterial,  param->u.crypt.key, pwep->KeyLength);
 		if (param->u.crypt.set_tx) {
-			DBG_88E("wep, set_tx = 1\n");
 			if (rtw_set_802_11_add_wep(padapter, pwep) == (u8)_FAIL)
 				ret = -EOPNOTSUPP;
 		} else {
-			DBG_88E("wep, set_tx = 0\n");
 			if (wep_key_idx >= WEP_KEYS) {
 				ret = -EOPNOTSUPP;
 				goto exit;
@@ -460,15 +450,12 @@ static int wpa_set_encryption(struct net_device *dev, struct ieee_param *param,
 						padapter->securitypriv.busetkipkey = false;
 					}
 
-					DBG_88E(" ~~~~set sta key:unicastkey\n");
-
 					rtw_setstakey_cmd(padapter, (unsigned char *)psta, true);
 				} else { /* group key */
 					memcpy(padapter->securitypriv.dot118021XGrpKey[param->u.crypt.idx].skey, param->u.crypt.key, min_t(u16, param->u.crypt.key_len, 16));
 					memcpy(padapter->securitypriv.dot118021XGrptxmickey[param->u.crypt.idx].skey, &param->u.crypt.key[16], 8);
 					memcpy(padapter->securitypriv.dot118021XGrprxmickey[param->u.crypt.idx].skey, &param->u.crypt.key[24], 8);
 					padapter->securitypriv.binstallGrpkey = true;
-					DBG_88E(" ~~~~set sta key:groupkey\n");
 
 					padapter->securitypriv.dot118021XGrpKeyid = param->u.crypt.idx;
 
@@ -517,15 +504,6 @@ static int rtw_set_wpa_ie(struct adapter *padapter, char *pie, unsigned short ie
 			goto exit;
 		}
 
-		/* dump */
-		{
-			int i;
-
-			DBG_88E("\n wpa_ie(length:%d):\n", ielen);
-			for (i = 0; i < ielen; i += 8)
-				DBG_88E("0x%.2x 0x%.2x 0x%.2x 0x%.2x 0x%.2x 0x%.2x 0x%.2x 0x%.2x\n", buf[i], buf[i + 1], buf[i + 2], buf[i + 3], buf[i + 4], buf[i + 5], buf[i + 6], buf[i + 7]);
-		}
-
 		if (ielen < RSN_HEADER_LEN) {
 			RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_err_, ("Ie len too short %d\n", ielen));
 			ret  = -1;
@@ -598,8 +576,6 @@ static int rtw_set_wpa_ie(struct adapter *padapter, char *pie, unsigned short ie
 			while (cnt < ielen) {
 				eid = buf[cnt];
 				if ((eid == WLAN_EID_VENDOR_SPECIFIC) && (!memcmp(&buf[cnt + 2], wps_oui, 4))) {
-					DBG_88E("SET WPS_IE\n");
-
 					padapter->securitypriv.wps_ie_len = min(buf[cnt + 1] + 2, MAX_WPA_IE_LEN << 2);
 
 					memcpy(padapter->securitypriv.wps_ie, &buf[cnt], padapter->securitypriv.wps_ie_len);
@@ -709,19 +685,15 @@ static int rtw_wx_set_mode(struct net_device *dev, struct iw_request_info *a,
 	switch (wrqu->mode) {
 	case IW_MODE_AUTO:
 		networkType = Ndis802_11AutoUnknown;
-		DBG_88E("set_mode = IW_MODE_AUTO\n");
 		break;
 	case IW_MODE_ADHOC:
 		networkType = Ndis802_11IBSS;
-		DBG_88E("set_mode = IW_MODE_ADHOC\n");
 		break;
 	case IW_MODE_MASTER:
 		networkType = Ndis802_11APMode;
-		DBG_88E("set_mode = IW_MODE_MASTER\n");
 		break;
 	case IW_MODE_INFRA:
 		networkType = Ndis802_11Infrastructure;
-		DBG_88E("set_mode = IW_MODE_INFRA\n");
 		break;
 	default:
 		ret = -EINVAL;
@@ -772,7 +744,6 @@ static int rtw_wx_set_pmkid(struct net_device *dev,
 
 	memcpy(strIssueBssid, pPMK->bssid.sa_data, ETH_ALEN);
 	if (pPMK->cmd == IW_PMKSA_ADD) {
-		DBG_88E("[%s] IW_PMKSA_ADD!\n", __func__);
 		if (!memcmp(strIssueBssid, strZeroMacAddress, ETH_ALEN))
 			return ret;
 		ret = true;
@@ -782,7 +753,6 @@ static int rtw_wx_set_pmkid(struct net_device *dev,
 		for (j = 0; j < NUM_PMKID_CACHE; j++) {
 			if (!memcmp(psecuritypriv->PMKIDList[j].bssid, strIssueBssid, ETH_ALEN)) {
 				/*  BSSID is matched, the same AP => rewrite with new PMKID. */
-				DBG_88E("[%s] BSSID exists in the PMKList.\n", __func__);
 				memcpy(psecuritypriv->PMKIDList[j].PMKID, pPMK->pmkid, IW_PMKID_LEN);
 				psecuritypriv->PMKIDList[j].used = true;
 				psecuritypriv->PMKIDIndex = j + 1;
@@ -793,9 +763,6 @@ static int rtw_wx_set_pmkid(struct net_device *dev,
 
 		if (!blInserted) {
 			/*  Find a new entry */
-			DBG_88E("[%s] Use the new entry index = %d for this PMKID.\n",
-				__func__, psecuritypriv->PMKIDIndex);
-
 			memcpy(psecuritypriv->PMKIDList[psecuritypriv->PMKIDIndex].bssid, strIssueBssid, ETH_ALEN);
 			memcpy(psecuritypriv->PMKIDList[psecuritypriv->PMKIDIndex].PMKID, pPMK->pmkid, IW_PMKID_LEN);
 
@@ -805,7 +772,6 @@ static int rtw_wx_set_pmkid(struct net_device *dev,
 				psecuritypriv->PMKIDIndex = 0;
 		}
 	} else if (pPMK->cmd == IW_PMKSA_REMOVE) {
-		DBG_88E("[%s] IW_PMKSA_REMOVE!\n", __func__);
 		ret = true;
 		for (j = 0; j < NUM_PMKID_CACHE; j++) {
 			if (!memcmp(psecuritypriv->PMKIDList[j].bssid, strIssueBssid, ETH_ALEN)) {
@@ -816,7 +782,6 @@ static int rtw_wx_set_pmkid(struct net_device *dev,
 			}
 		}
 	} else if (pPMK->cmd == IW_PMKSA_FLUSH) {
-		DBG_88E("[%s] IW_PMKSA_FLUSH!\n", __func__);
 		memset(&psecuritypriv->PMKIDList[0], 0x00, sizeof(struct rt_pmkid_list) * NUM_PMKID_CACHE);
 		psecuritypriv->PMKIDIndex = 0;
 		ret = true;
@@ -1020,12 +985,8 @@ static int rtw_wx_set_mlme(struct net_device *dev,
 	if (!mlme)
 		return -1;
 
-	DBG_88E("%s\n", __func__);
-
 	reason = mlme->reason_code;
 
-	DBG_88E("%s, cmd =%d, reason =%d\n", __func__, mlme->cmd, reason);
-
 	switch (mlme->cmd) {
 	case IW_MLME_DEAUTH:
 		if (!rtw_set_802_11_disassociate(padapter))
@@ -1058,7 +1019,6 @@ static int rtw_wx_set_scan(struct net_device *dev, struct iw_request_info *a,
 	}
 
 	if (padapter->bDriverStopped) {
-		DBG_88E("bDriverStopped =%d\n", padapter->bDriverStopped);
 		ret = -1;
 		goto exit;
 	}
@@ -1102,15 +1062,11 @@ static int rtw_wx_set_scan(struct net_device *dev, struct iw_request_info *a,
 			memcpy(ssid[0].ssid, req->essid, len);
 			ssid[0].ssid_length = len;
 
-			DBG_88E("IW_SCAN_THIS_ESSID, ssid =%s, len =%d\n", req->essid, req->essid_len);
-
 			spin_lock_bh(&pmlmepriv->lock);
 
 			_status = rtw_sitesurvey_cmd(padapter, ssid, 1, NULL, 0);
 
 			spin_unlock_bh(&pmlmepriv->lock);
-		} else if (req->scan_type == IW_SCAN_TYPE_PASSIVE) {
-			DBG_88E("%s, req->scan_type == IW_SCAN_TYPE_PASSIVE\n", __func__);
 		}
 	} else {
 		if (wrqu->data.length >= WEXT_CSCAN_HEADER_SIZE &&
@@ -1275,13 +1231,9 @@ static int rtw_wx_set_essid(struct net_device *dev,
 	}
 
 	authmode = padapter->securitypriv.ndisauthtype;
-	DBG_88E("=>%s\n", __func__);
 	if (wrqu->essid.flags && wrqu->essid.length) {
 		len = min_t(uint, wrqu->essid.length, IW_ESSID_MAX_SIZE);
 
-		if (wrqu->essid.length != 33)
-			DBG_88E("ssid =%s, len =%d\n", extra, wrqu->essid.length);
-
 		memset(&ndis_ssid, 0, sizeof(struct ndis_802_11_ssid));
 		ndis_ssid.ssid_length = len;
 		memcpy(ndis_ssid.ssid, extra, len);
@@ -1330,8 +1282,6 @@ static int rtw_wx_set_essid(struct net_device *dev,
 	}
 
 exit:
-	DBG_88E("<=%s, ret %d\n", __func__, ret);
-
 	return ret;
 }
 
@@ -1472,8 +1422,6 @@ static int rtw_wx_set_rts(struct net_device *dev,
 		padapter->registrypriv.rts_thresh = wrqu->rts.value;
 	}
 
-	DBG_88E("%s, rts_thresh =%d\n", __func__, padapter->registrypriv.rts_thresh);
-
 	return 0;
 }
 
@@ -1483,8 +1431,6 @@ static int rtw_wx_get_rts(struct net_device *dev,
 {
 	struct adapter *padapter = netdev_priv(dev);
 
-	DBG_88E("%s, rts_thresh =%d\n", __func__, padapter->registrypriv.rts_thresh);
-
 	wrqu->rts.value = padapter->registrypriv.rts_thresh;
 	wrqu->rts.fixed = 0;	/* no auto select */
 	/* wrqu->rts.disabled = (wrqu->rts.value == DEFAULT_RTS_THRESHOLD); */
@@ -1508,8 +1454,6 @@ static int rtw_wx_set_frag(struct net_device *dev,
 		padapter->xmitpriv.frag_len = wrqu->frag.value & ~0x1;
 	}
 
-	DBG_88E("%s, frag_len =%d\n", __func__, padapter->xmitpriv.frag_len);
-
 	return 0;
 }
 
@@ -1519,8 +1463,6 @@ static int rtw_wx_get_frag(struct net_device *dev,
 {
 	struct adapter *padapter = netdev_priv(dev);
 
-	DBG_88E("%s, frag_len =%d\n", __func__, padapter->xmitpriv.frag_len);
-
 	wrqu->frag.value = padapter->xmitpriv.frag_len;
 	wrqu->frag.fixed = 0;	/* no auto select */
 
@@ -1551,14 +1493,11 @@ static int rtw_wx_set_enc(struct net_device *dev,
 	struct adapter *padapter = netdev_priv(dev);
 	struct pwrctrl_priv *pwrpriv = &padapter->pwrctrlpriv;
 
-	DBG_88E("+%s, flags = 0x%x\n", __func__, erq->flags);
-
 	memset(&wep, 0, sizeof(struct ndis_802_11_wep));
 
 	key = erq->flags & IW_ENCODE_INDEX;
 
 	if (erq->flags & IW_ENCODE_DISABLED) {
-		DBG_88E("EncryptionDisabled\n");
 		padapter->securitypriv.ndisencryptstatus = Ndis802_11EncryptionDisabled;
 		padapter->securitypriv.dot11PrivacyAlgrthm = _NO_PRIVACY_;
 		padapter->securitypriv.dot118021XGrpPrivacy = _NO_PRIVACY_;
@@ -1577,12 +1516,10 @@ static int rtw_wx_set_enc(struct net_device *dev,
 	} else {
 		keyindex_provided = 0;
 		key = padapter->securitypriv.dot11PrivacyKeyIndex;
-		DBG_88E("%s, key =%d\n", __func__, key);
 	}
 
 	/* set authentication mode */
 	if (erq->flags & IW_ENCODE_OPEN) {
-		DBG_88E("%s():IW_ENCODE_OPEN\n", __func__);
 		padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption1Enabled;/* Ndis802_11EncryptionDisabled; */
 		padapter->securitypriv.dot11AuthAlgrthm = dot11AuthAlgrthm_Open;
 		padapter->securitypriv.dot11PrivacyAlgrthm = _NO_PRIVACY_;
@@ -1590,7 +1527,6 @@ static int rtw_wx_set_enc(struct net_device *dev,
 		authmode = Ndis802_11AuthModeOpen;
 		padapter->securitypriv.ndisauthtype = authmode;
 	} else if (erq->flags & IW_ENCODE_RESTRICTED) {
-		DBG_88E("%s():IW_ENCODE_RESTRICTED\n", __func__);
 		padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption1Enabled;
 		padapter->securitypriv.dot11AuthAlgrthm = dot11AuthAlgrthm_Shared;
 		padapter->securitypriv.dot11PrivacyAlgrthm = _WEP40_;
@@ -1598,8 +1534,6 @@ static int rtw_wx_set_enc(struct net_device *dev,
 		authmode = Ndis802_11AuthModeShared;
 		padapter->securitypriv.ndisauthtype = authmode;
 	} else {
-		DBG_88E("%s():erq->flags = 0x%x\n", __func__, erq->flags);
-
 		padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption1Enabled;/* Ndis802_11EncryptionDisabled; */
 		padapter->securitypriv.dot11AuthAlgrthm = dot11AuthAlgrthm_Open;
 		padapter->securitypriv.dot11PrivacyAlgrthm = _NO_PRIVACY_;
@@ -1620,8 +1554,6 @@ static int rtw_wx_set_enc(struct net_device *dev,
 			/*  set key_id only, no given KeyMaterial(erq->length == 0). */
 			padapter->securitypriv.dot11PrivacyKeyIndex = key;
 
-			DBG_88E("(keyindex_provided == 1), keyid =%d, key_len =%d\n", key, padapter->securitypriv.dot11DefKeylen[key]);
-
 			switch (padapter->securitypriv.dot11DefKeylen[key]) {
 			case 5:
 				padapter->securitypriv.dot11PrivacyAlgrthm = _WEP40_;
@@ -1799,7 +1731,6 @@ static int rtw_wx_set_auth(struct net_device *dev,
 		if (check_fwstate(&padapter->mlmepriv, _FW_LINKED)) {
 			LeaveAllPowerSaveMode(padapter);
 			rtw_disassoc_cmd(padapter, 500, false);
-			DBG_88E("%s...call rtw_indicate_disconnect\n ", __func__);
 			rtw_indicate_disconnect(padapter);
 			rtw_free_assoc_resources(padapter);
 		}
@@ -2010,7 +1941,6 @@ static int wpa_supplicant_ioctl(struct net_device *dev, struct iw_point *p)
 		break;
 
 	default:
-		DBG_88E("Unknown WPA supplicant request: %d\n", param->cmd);
 		ret = -EOPNOTSUPP;
 		break;
 	}
@@ -2066,8 +1996,6 @@ static int set_group_key(struct adapter *padapter, u8 *key, u8 alg, int keyid)
 	struct cmd_priv	*pcmdpriv = &padapter->cmdpriv;
 	int res = _SUCCESS;
 
-	DBG_88E("%s\n", __func__);
-
 	pcmd = kzalloc(sizeof(struct	cmd_obj), GFP_KERNEL);
 	if (!pcmd) {
 		res = _FAIL;
@@ -2146,7 +2074,6 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,
 	struct security_priv *psecuritypriv = &padapter->securitypriv;
 	struct sta_priv *pstapriv = &padapter->stapriv;
 
-	DBG_88E("%s\n", __func__);
 	param->u.crypt.err = 0;
 	param->u.crypt.alg[IEEE_CRYPT_ALG_NAME_LEN - 1] = '\0';
 	if (param_len !=  sizeof(struct ieee_param) + param->u.crypt.key_len) {
@@ -2160,23 +2087,17 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,
 		}
 	} else {
 		psta = rtw_get_stainfo(pstapriv, param->sta_addr);
-		if (!psta) {
-			DBG_88E("%s(), sta has already been removed or never been added\n", __func__);
+		if (!psta)
 			goto exit;
-		}
 	}
 
-	if (strcmp(param->u.crypt.alg, "none") == 0 && (!psta)) {
+	if (strcmp(param->u.crypt.alg, "none") == 0 && (!psta))
 		/* todo:clear default encryption keys */
-
-		DBG_88E("clear default encryption keys, keyid =%d\n", param->u.crypt.idx);
 		goto exit;
-	}
+
 	if (strcmp(param->u.crypt.alg, "WEP") == 0 && (!psta)) {
-		DBG_88E("r871x_set_encryption, crypt.alg = WEP\n");
 		wep_key_idx = param->u.crypt.idx;
 		wep_key_len = param->u.crypt.key_len;
-		DBG_88E("r871x_set_encryption, wep_key_idx=%d, len=%d\n", wep_key_idx, wep_key_len);
 		if ((wep_key_idx >= WEP_KEYS) || (wep_key_len <= 0)) {
 			ret = -EINVAL;
 			goto exit;
@@ -2186,10 +2107,8 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,
 			wep_key_len = wep_key_len <= 5 ? 5 : 13;
 			wep_total_len = wep_key_len + offsetof(struct ndis_802_11_wep, KeyMaterial);
 			pwep = (struct ndis_802_11_wep *)rtw_malloc(wep_total_len);
-			if (!pwep) {
-				DBG_88E(" r871x_set_encryption: pwep allocate fail !!!\n");
+			if (!pwep)
 				goto exit;
-			}
 
 			memset(pwep, 0, wep_total_len);
 
@@ -2202,8 +2121,6 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,
 		memcpy(pwep->KeyMaterial,  param->u.crypt.key, pwep->KeyLength);
 
 		if (param->u.crypt.set_tx) {
-			DBG_88E("wep, set_tx = 1\n");
-
 			psecuritypriv->ndisencryptstatus = Ndis802_11Encryption1Enabled;
 			psecuritypriv->dot11PrivacyAlgrthm = _WEP40_;
 			psecuritypriv->dot118021XGrpPrivacy = _WEP40_;
@@ -2221,8 +2138,6 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,
 
 			set_wep_key(padapter, pwep->KeyMaterial, pwep->KeyLength, wep_key_idx);
 		} else {
-			DBG_88E("wep, set_tx = 0\n");
-
 			/* don't update "psecuritypriv->dot11PrivacyAlgrthm" and */
 			/* psecuritypriv->dot11PrivacyKeyIndex = keyid", but can rtw_set_key to cam */
 
@@ -2239,8 +2154,6 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,
 	if (!psta && check_fwstate(pmlmepriv, WIFI_AP_STATE)) { /*  group key */
 		if (param->u.crypt.set_tx == 1) {
 			if (strcmp(param->u.crypt.alg, "WEP") == 0) {
-				DBG_88E("%s, set group_key, WEP\n", __func__);
-
 				memcpy(psecuritypriv->dot118021XGrpKey[param->u.crypt.idx].skey,
 				       param->u.crypt.key, min_t(u16, param->u.crypt.key_len, 16));
 
@@ -2248,7 +2161,6 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,
 				if (param->u.crypt.key_len == 13)
 					psecuritypriv->dot118021XGrpPrivacy = _WEP104_;
 			} else if (strcmp(param->u.crypt.alg, "TKIP") == 0) {
-				DBG_88E("%s, set group_key, TKIP\n", __func__);
 				psecuritypriv->dot118021XGrpPrivacy = _TKIP_;
 				memcpy(psecuritypriv->dot118021XGrpKey[param->u.crypt.idx].skey,
 				       param->u.crypt.key, min_t(u16, param->u.crypt.key_len, 16));
@@ -2258,12 +2170,10 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,
 
 				psecuritypriv->busetkipkey = true;
 			} else if (strcmp(param->u.crypt.alg, "CCMP") == 0) {
-				DBG_88E("%s, set group_key, CCMP\n", __func__);
 				psecuritypriv->dot118021XGrpPrivacy = _AES_;
 				memcpy(psecuritypriv->dot118021XGrpKey[param->u.crypt.idx].skey,
 				       param->u.crypt.key, min_t(u16, param->u.crypt.key_len, 16));
 			} else {
-				DBG_88E("%s, set group_key, none\n", __func__);
 				psecuritypriv->dot118021XGrpPrivacy = _NO_PRIVACY_;
 			}
 			psecuritypriv->dot118021XGrpKeyid = param->u.crypt.idx;
@@ -2285,14 +2195,10 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,
 				memcpy(psta->dot118021x_UncstKey.skey,  param->u.crypt.key, min_t(u16, param->u.crypt.key_len, 16));
 
 				if (strcmp(param->u.crypt.alg, "WEP") == 0) {
-					DBG_88E("%s, set pairwise key, WEP\n", __func__);
-
 					psta->dot118021XPrivacy = _WEP40_;
 					if (param->u.crypt.key_len == 13)
 						psta->dot118021XPrivacy = _WEP104_;
 				} else if (strcmp(param->u.crypt.alg, "TKIP") == 0) {
-					DBG_88E("%s, set pairwise key, TKIP\n", __func__);
-
 					psta->dot118021XPrivacy = _TKIP_;
 
 					/* set mic key */
@@ -2301,12 +2207,8 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,
 
 					psecuritypriv->busetkipkey = true;
 				} else if (strcmp(param->u.crypt.alg, "CCMP") == 0) {
-					DBG_88E("%s, set pairwise key, CCMP\n", __func__);
-
 					psta->dot118021XPrivacy = _AES_;
 				} else {
-					DBG_88E("%s, set pairwise key, none\n", __func__);
-
 					psta->dot118021XPrivacy = _NO_PRIVACY_;
 				}
 
@@ -2372,8 +2274,6 @@ static int rtw_set_beacon(struct net_device *dev, struct ieee_param *param, int
 	struct sta_priv *pstapriv = &padapter->stapriv;
 	unsigned char *pbuf = param->u.bcn_ie.buf;
 
-	DBG_88E("%s, len =%d\n", __func__, len);
-
 	if (!check_fwstate(pmlmepriv, WIFI_AP_STATE))
 		return -EINVAL;
 
@@ -2394,8 +2294,6 @@ static int rtw_hostapd_sta_flush(struct net_device *dev)
 {
 	struct adapter *padapter = netdev_priv(dev);
 
-	DBG_88E("%s\n", __func__);
-
 	flush_all_cam_entry(padapter);	/* clear CAM */
 
 	return rtw_sta_flush(padapter);
@@ -2409,8 +2307,6 @@ static int rtw_add_sta(struct net_device *dev, struct ieee_param *param)
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct sta_priv *pstapriv = &padapter->stapriv;
 
-	DBG_88E("%s(aid =%d) =%pM\n", __func__, param->u.add_sta.aid, (param->sta_addr));
-
 	if (!check_fwstate(pmlmepriv, (_FW_LINKED | WIFI_AP_STATE)))
 		return -EINVAL;
 
@@ -2463,8 +2359,6 @@ static int rtw_del_sta(struct net_device *dev, struct ieee_param *param)
 	struct sta_priv *pstapriv = &padapter->stapriv;
 	int updated = 0;
 
-	DBG_88E("%s =%pM\n", __func__, (param->sta_addr));
-
 	if (!check_fwstate(pmlmepriv, _FW_LINKED | WIFI_AP_STATE))
 		return -EINVAL;
 
@@ -2482,8 +2376,6 @@ static int rtw_del_sta(struct net_device *dev, struct ieee_param *param)
 		spin_unlock_bh(&pstapriv->asoc_list_lock);
 		associated_clients_update(padapter, updated);
 		psta = NULL;
-	} else {
-		DBG_88E("%s(), sta has already been removed or never been added\n", __func__);
 	}
 
 	return 0;
@@ -2499,8 +2391,6 @@ static int rtw_ioctl_get_sta_data(struct net_device *dev, struct ieee_param *par
 	struct ieee_param_ex *param_ex = (struct ieee_param_ex *)param;
 	struct sta_data *psta_data = (struct sta_data *)param_ex->data;
 
-	DBG_88E("rtw_ioctl_get_sta_info, sta_addr: %pM\n", (param_ex->sta_addr));
-
 	if (!check_fwstate(pmlmepriv, _FW_LINKED | WIFI_AP_STATE))
 		return -EINVAL;
 
@@ -2553,8 +2443,6 @@ static int rtw_get_sta_wpaie(struct net_device *dev, struct ieee_param *param)
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct sta_priv *pstapriv = &padapter->stapriv;
 
-	DBG_88E("%s, sta_addr: %pM\n", __func__, (param->sta_addr));
-
 	if (!check_fwstate(pmlmepriv, _FW_LINKED | WIFI_AP_STATE))
 		return -EINVAL;
 
@@ -2572,8 +2460,6 @@ static int rtw_get_sta_wpaie(struct net_device *dev, struct ieee_param *param)
 			copy_len = min_t(int, wpa_ie_len + 2, sizeof(psta->wpa_ie));
 			param->u.wpa_ie.len = copy_len;
 			memcpy(param->u.wpa_ie.reserved, psta->wpa_ie, copy_len);
-		} else {
-			DBG_88E("sta's wpa_ie is NONE\n");
 		}
 	} else {
 		ret = -1;
@@ -2590,8 +2476,6 @@ static int rtw_set_wps_beacon(struct net_device *dev, struct ieee_param *param,
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
 	int ie_len;
 
-	DBG_88E("%s, len =%d\n", __func__, len);
-
 	if (!check_fwstate(pmlmepriv, WIFI_AP_STATE))
 		return -EINVAL;
 
@@ -2603,10 +2487,8 @@ static int rtw_set_wps_beacon(struct net_device *dev, struct ieee_param *param,
 	if (ie_len > 0) {
 		pmlmepriv->wps_beacon_ie = rtw_malloc(ie_len);
 		pmlmepriv->wps_beacon_ie_len = ie_len;
-		if (!pmlmepriv->wps_beacon_ie) {
-			DBG_88E("%s()-%d: rtw_malloc() ERROR!\n", __func__, __LINE__);
+		if (!pmlmepriv->wps_beacon_ie)
 			return -EINVAL;
-		}
 
 		memcpy(pmlmepriv->wps_beacon_ie, param->u.bcn_ie.buf, ie_len);
 
@@ -2624,8 +2506,6 @@ static int rtw_set_wps_probe_resp(struct net_device *dev, struct ieee_param *par
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	int ie_len;
 
-	DBG_88E("%s, len =%d\n", __func__, len);
-
 	if (!check_fwstate(pmlmepriv, WIFI_AP_STATE))
 		return -EINVAL;
 
@@ -2637,10 +2517,8 @@ static int rtw_set_wps_probe_resp(struct net_device *dev, struct ieee_param *par
 	if (ie_len > 0) {
 		pmlmepriv->wps_probe_resp_ie = rtw_malloc(ie_len);
 		pmlmepriv->wps_probe_resp_ie_len = ie_len;
-		if (!pmlmepriv->wps_probe_resp_ie) {
-			DBG_88E("%s()-%d: rtw_malloc() ERROR!\n", __func__, __LINE__);
+		if (!pmlmepriv->wps_probe_resp_ie)
 			return -EINVAL;
-		}
 		memcpy(pmlmepriv->wps_probe_resp_ie, param->u.bcn_ie.buf, ie_len);
 	}
 
@@ -2653,8 +2531,6 @@ static int rtw_set_wps_assoc_resp(struct net_device *dev, struct ieee_param *par
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	int ie_len;
 
-	DBG_88E("%s, len =%d\n", __func__, len);
-
 	if (!check_fwstate(pmlmepriv, WIFI_AP_STATE))
 		return -EINVAL;
 
@@ -2666,10 +2542,8 @@ static int rtw_set_wps_assoc_resp(struct net_device *dev, struct ieee_param *par
 	if (ie_len > 0) {
 		pmlmepriv->wps_assoc_resp_ie = rtw_malloc(ie_len);
 		pmlmepriv->wps_assoc_resp_ie_len = ie_len;
-		if (!pmlmepriv->wps_assoc_resp_ie) {
-			DBG_88E("%s()-%d: rtw_malloc() ERROR!\n", __func__, __LINE__);
+		if (!pmlmepriv->wps_assoc_resp_ie)
 			return -EINVAL;
-		}
 
 		memcpy(pmlmepriv->wps_assoc_resp_ie, param->u.bcn_ie.buf, ie_len);
 	}
@@ -2689,14 +2563,11 @@ static int rtw_set_hidden_ssid(struct net_device *dev, struct ieee_param *param,
 	if (!check_fwstate(pmlmepriv, WIFI_AP_STATE))
 		return -EINVAL;
 
-	if (param->u.wpa_param.name != 0) /* dummy test... */
-		DBG_88E("%s name(%u) != 0\n", __func__, param->u.wpa_param.name);
 	value = param->u.wpa_param.value;
 
 	/* use the same definition of hostapd's ignore_broadcast_ssid */
 	if (value != 1 && value != 2)
 		value = 0;
-	DBG_88E("%s value(%u)\n", __func__, value);
 	pmlmeinfo->hidden_ssid_mode = value;
 	return 0;
 }
@@ -2807,7 +2678,6 @@ static int rtw_hostapd_ioctl(struct net_device *dev, struct iw_point *p)
 		ret = rtw_ioctl_acl_remove_sta(dev, param, p->length);
 		break;
 	default:
-		DBG_88E("Unknown hostapd request: %d\n", param->cmd);
 		ret = -EOPNOTSUPP;
 		break;
 	}
-- 
2.30.2

