Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C89BC3DD14E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 09:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbhHBHjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 03:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232173AbhHBHju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 03:39:50 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389D2C06175F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 00:39:41 -0700 (PDT)
Received: from ipservice-092-217-072-009.092.217.pools.vodafone-ip.de ([92.217.72.9] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mASXp-0000dM-OY; Mon, 02 Aug 2021 09:39:31 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH] staging: r8188eu: remove RT_TRACE and DBG_88E prints from ioctl_linux.c
Date:   Mon,  2 Aug 2021 09:39:17 +0200
Message-Id: <20210802073917.8647-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should use the standard mechanism for debug prints. Remove the
prints that use driver-specific macros.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/os_dep/ioctl_linux.c | 744 +------------------
 1 file changed, 33 insertions(+), 711 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index 8ba2b81e32b8..5bee453c12bc 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -355,8 +355,6 @@ static char *translate_scan(struct adapter *padapter,
 			goto exit;
 		}
 		rtw_get_sec_ie(pnetwork->network.IEs, pnetwork->network.IELength, rsn_ie, &rsn_len, wpa_ie, &wpa_len);
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_wx_get_scan: ssid =%s\n", pnetwork->network.Ssid.Ssid));
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_wx_get_scan: wpa_len =%d rsn_len =%d\n", wpa_len, rsn_len));
 
 		if (wpa_len > 0) {
 			p = buf;
@@ -443,28 +441,23 @@ static int wpa_set_auth_algs(struct net_device *dev, u32 value)
 	int ret = 0;
 
 	if ((value & AUTH_ALG_SHARED_KEY) && (value & AUTH_ALG_OPEN_SYSTEM)) {
-		DBG_88E("wpa_set_auth_algs, AUTH_ALG_SHARED_KEY and  AUTH_ALG_OPEN_SYSTEM [value:0x%x]\n", value);
 		padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption1Enabled;
 		padapter->securitypriv.ndisauthtype = Ndis802_11AuthModeAutoSwitch;
 		padapter->securitypriv.dot11AuthAlgrthm = dot11AuthAlgrthm_Auto;
 	} else if (value & AUTH_ALG_SHARED_KEY) {
-		DBG_88E("wpa_set_auth_algs, AUTH_ALG_SHARED_KEY  [value:0x%x]\n", value);
 		padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption1Enabled;
 
 		padapter->securitypriv.ndisauthtype = Ndis802_11AuthModeShared;
 		padapter->securitypriv.dot11AuthAlgrthm = dot11AuthAlgrthm_Shared;
 	} else if (value & AUTH_ALG_OPEN_SYSTEM) {
-		DBG_88E("wpa_set_auth_algs, AUTH_ALG_OPEN_SYSTEM\n");
 		if (padapter->securitypriv.ndisauthtype < Ndis802_11AuthModeWPAPSK) {
 			padapter->securitypriv.ndisauthtype = Ndis802_11AuthModeOpen;
 			padapter->securitypriv.dot11AuthAlgrthm = dot11AuthAlgrthm_Open;
 		}
-	} else if (value & AUTH_ALG_LEAP) {
-		DBG_88E("wpa_set_auth_algs, AUTH_ALG_LEAP\n");
-	} else {
-		DBG_88E("wpa_set_auth_algs, error!\n");
+	} else if (!(value & AUTH_ALG_LEAP)) {
 		ret = -EINVAL;
 	}
+
 	return ret;
 }
 
@@ -501,9 +494,6 @@ static int wpa_set_encryption(struct net_device *dev, struct ieee_param *param,
 	}
 
 	if (strcmp(param->u.crypt.alg, "WEP") == 0) {
-		RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_err_, ("wpa_set_encryption, crypt.alg = WEP\n"));
-		DBG_88E("wpa_set_encryption, crypt.alg = WEP\n");
-
 		padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption1Enabled;
 		padapter->securitypriv.dot11PrivacyAlgrthm = _WEP40_;
 		padapter->securitypriv.dot118021XGrpPrivacy = _WEP40_;
@@ -511,22 +501,16 @@ static int wpa_set_encryption(struct net_device *dev, struct ieee_param *param,
 		wep_key_idx = param->u.crypt.idx;
 		wep_key_len = param->u.crypt.key_len;
 
-		RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_info_, ("(1)wep_key_idx =%d\n", wep_key_idx));
-		DBG_88E("(1)wep_key_idx =%d\n", wep_key_idx);
-
 		if (wep_key_idx > WEP_KEYS)
 			return -EINVAL;
 
-		RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_info_, ("(2)wep_key_idx =%d\n", wep_key_idx));
-
 		if (wep_key_len > 0) {
 			wep_key_len = wep_key_len <= 5 ? 5 : 13;
 			wep_total_len = wep_key_len + FIELD_OFFSET(struct ndis_802_11_wep, KeyMaterial);
 			pwep = (struct ndis_802_11_wep *)rtw_malloc(wep_total_len);
-			if (!pwep) {
-				RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_err_, (" wpa_set_encryption: pwep allocate fail !!!\n"));
+			if (!pwep)
 				goto exit;
-			}
+
 			memset(pwep, 0, wep_total_len);
 			pwep->KeyLength = wep_key_len;
 			pwep->Length = wep_total_len;
@@ -542,11 +526,9 @@ static int wpa_set_encryption(struct net_device *dev, struct ieee_param *param,
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
@@ -583,15 +565,12 @@ static int wpa_set_encryption(struct net_device *dev, struct ieee_param *param,
 						padapter->securitypriv.busetkipkey = false;
 					}
 
-					DBG_88E(" ~~~~set sta key:unicastkey\n");
-
 					rtw_setstakey_cmd(padapter, (unsigned char *)psta, true);
 				} else { /* group key */
 					memcpy(padapter->securitypriv.dot118021XGrpKey[param->u.crypt.idx].skey,  param->u.crypt.key, (param->u.crypt.key_len > 16 ? 16 : param->u.crypt.key_len));
 					memcpy(padapter->securitypriv.dot118021XGrptxmickey[param->u.crypt.idx].skey, &(param->u.crypt.key[16]), 8);
 					memcpy(padapter->securitypriv.dot118021XGrprxmickey[param->u.crypt.idx].skey, &(param->u.crypt.key[24]), 8);
 					padapter->securitypriv.binstallGrpkey = true;
-					DBG_88E(" ~~~~set sta key:groupkey\n");
 
 					padapter->securitypriv.dot118021XGrpKeyid = param->u.crypt.idx;
 
@@ -650,16 +629,7 @@ static int rtw_set_wpa_ie(struct adapter *padapter, char *pie, unsigned short ie
 
 		memcpy(buf, pie, ielen);
 
-		/* dump */
-		{
-			int i;
-			DBG_88E("\n wpa_ie(length:%d):\n", ielen);
-			for (i = 0; i < ielen; i += 8)
-				DBG_88E("0x%.2x 0x%.2x 0x%.2x 0x%.2x 0x%.2x 0x%.2x 0x%.2x 0x%.2x\n", buf[i], buf[i+1], buf[i+2], buf[i+3], buf[i+4], buf[i+5], buf[i+6], buf[i+7]);
-		}
-
 		if (ielen < RSN_HEADER_LEN) {
-			RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_err_, ("Ie len too short %d\n", ielen));
 			ret  = -1;
 			goto exit;
 		}
@@ -730,8 +700,6 @@ static int rtw_set_wpa_ie(struct adapter *padapter, char *pie, unsigned short ie
 			while (cnt < ielen) {
 				eid = buf[cnt];
 				if ((eid == _VENDOR_SPECIFIC_IE_) && (!memcmp(&buf[cnt+2], wps_oui, 4))) {
-					DBG_88E("SET WPS_IE\n");
-
 					padapter->securitypriv.wps_ie_len = ((buf[cnt+1]+2) < (MAX_WPA_IE_LEN<<2)) ? (buf[cnt+1]+2) : (MAX_WPA_IE_LEN<<2);
 
 					memcpy(padapter->securitypriv.wps_ie, &buf[cnt], padapter->securitypriv.wps_ie_len);
@@ -750,9 +718,6 @@ static int rtw_set_wpa_ie(struct adapter *padapter, char *pie, unsigned short ie
 		}
 	}
 
-	RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_info_,
-		 ("rtw_set_wpa_ie: pairwise_cipher = 0x%08x padapter->securitypriv.ndisencryptstatus =%d padapter->securitypriv.ndisauthtype =%d\n",
-		 pairwise_cipher, padapter->securitypriv.ndisencryptstatus, padapter->securitypriv.ndisauthtype));
 exit:
 	kfree(buf);
 	return ret;
@@ -772,10 +737,6 @@ static int rtw_wx_get_name(struct net_device *dev,
 	struct wlan_bssid_ex  *pcur_bss = &pmlmepriv->cur_network.network;
 	NDIS_802_11_RATES_EX *prates = NULL;
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("cmd_code =%x\n", info->cmd));
-
-
-
 	if (check_fwstate(pmlmepriv, _FW_LINKED|WIFI_ADHOC_MASTER_STATE) == true) {
 		/* parsing HT_CAP_IE */
 		p = rtw_get_ie(&pcur_bss->IEs[12], _HT_CAPABILITY_IE_, &ht_ielen, pcur_bss->IELength-12);
@@ -820,12 +781,6 @@ static int rtw_wx_set_freq(struct net_device *dev,
 			     struct iw_request_info *info,
 			     union iwreq_data *wrqu, char *extra)
 {
-
-
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_notice_, ("+rtw_wx_set_freq\n"));
-
-
-
 	return 0;
 }
 
@@ -873,23 +828,18 @@ static int rtw_wx_set_mode(struct net_device *dev, struct iw_request_info *a,
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
-		RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_err_, ("\n Mode: %s is not supported\n", iw_operation_mode[wrqu->mode]));
 		goto exit;
 	}
 	if (rtw_set_802_11_infrastructure_mode(padapter, networkType) == false) {
@@ -908,10 +858,6 @@ static int rtw_wx_get_mode(struct net_device *dev, struct iw_request_info *a,
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	struct	mlme_priv	*pmlmepriv = &(padapter->mlmepriv);
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, (" rtw_wx_get_mode\n"));
-
-
-
 	if (check_fwstate(pmlmepriv, WIFI_STATION_STATE))
 		wrqu->mode = IW_MODE_INFRA;
 	else if  ((check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE)) ||
@@ -941,7 +887,6 @@ static int rtw_wx_set_pmkid(struct net_device *dev,
 
 	memcpy(strIssueBssid, pPMK->bssid.sa_data, ETH_ALEN);
 	if (pPMK->cmd == IW_PMKSA_ADD) {
-		DBG_88E("[rtw_wx_set_pmkid] IW_PMKSA_ADD!\n");
 		if (!memcmp(strIssueBssid, strZeroMacAddress, ETH_ALEN))
 			return ret;
 		else
@@ -952,7 +897,6 @@ static int rtw_wx_set_pmkid(struct net_device *dev,
 		for (j = 0; j < NUM_PMKID_CACHE; j++) {
 			if (!memcmp(psecuritypriv->PMKIDList[j].Bssid, strIssueBssid, ETH_ALEN)) {
 				/*  BSSID is matched, the same AP => rewrite with new PMKID. */
-				DBG_88E("[rtw_wx_set_pmkid] BSSID exists in the PMKList.\n");
 				memcpy(psecuritypriv->PMKIDList[j].PMKID, pPMK->pmkid, IW_PMKID_LEN);
 				psecuritypriv->PMKIDList[j].bUsed = true;
 				psecuritypriv->PMKIDIndex = j+1;
@@ -963,9 +907,6 @@ static int rtw_wx_set_pmkid(struct net_device *dev,
 
 		if (!blInserted) {
 			/*  Find a new entry */
-			DBG_88E("[rtw_wx_set_pmkid] Use the new entry index = %d for this PMKID.\n",
-				psecuritypriv->PMKIDIndex);
-
 			memcpy(psecuritypriv->PMKIDList[psecuritypriv->PMKIDIndex].Bssid, strIssueBssid, ETH_ALEN);
 			memcpy(psecuritypriv->PMKIDList[psecuritypriv->PMKIDIndex].PMKID, pPMK->pmkid, IW_PMKID_LEN);
 
@@ -975,7 +916,6 @@ static int rtw_wx_set_pmkid(struct net_device *dev,
 				psecuritypriv->PMKIDIndex = 0;
 		}
 	} else if (pPMK->cmd == IW_PMKSA_REMOVE) {
-		DBG_88E("[rtw_wx_set_pmkid] IW_PMKSA_REMOVE!\n");
 		ret = true;
 		for (j = 0; j < NUM_PMKID_CACHE; j++) {
 			if (!memcmp(psecuritypriv->PMKIDList[j].Bssid, strIssueBssid, ETH_ALEN)) {
@@ -986,7 +926,6 @@ static int rtw_wx_set_pmkid(struct net_device *dev,
 			}
 	       }
 	} else if (pPMK->cmd == IW_PMKSA_FLUSH) {
-		DBG_88E("[rtw_wx_set_pmkid] IW_PMKSA_FLUSH!\n");
 		memset(&psecuritypriv->PMKIDList[0], 0x00, sizeof(struct rt_pmkid_list) * NUM_PMKID_CACHE);
 		psecuritypriv->PMKIDIndex = 0;
 		ret = true;
@@ -1016,9 +955,6 @@ static int rtw_wx_get_range(struct net_device *dev,
 	int i;
 
 
-
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_wx_get_range. cmd_code =%x\n", info->cmd));
-
 	wrqu->data.length = sizeof(*range);
 	memset(range, 0, sizeof(*range));
 
@@ -1192,10 +1128,6 @@ static int rtw_wx_get_wap(struct net_device *dev,
 
 	memset(wrqu->ap_addr.sa_data, 0, ETH_ALEN);
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_wx_get_wap\n"));
-
-
-
 	if (((check_fwstate(pmlmepriv, _FW_LINKED)) == true) ||
 	    ((check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE)) == true) ||
 	    ((check_fwstate(pmlmepriv, WIFI_AP_STATE)) == true))
@@ -1220,12 +1152,8 @@ static int rtw_wx_set_mlme(struct net_device *dev,
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
@@ -1252,7 +1180,6 @@ static int rtw_wx_set_scan(struct net_device *dev, struct iw_request_info *a,
 #ifdef CONFIG_88EU_P2P
 	struct wifidirect_info *pwdinfo = &(padapter->wdinfo);
 #endif /* CONFIG_88EU_P2P */
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_wx_set_scan\n"));
 
 	if (padapter->registrypriv.mp_mode == 1) {
 		if (check_fwstate(pmlmepriv, WIFI_MP_STATE)) {
@@ -1266,7 +1193,6 @@ static int rtw_wx_set_scan(struct net_device *dev, struct iw_request_info *a,
 	}
 
 	if (padapter->bDriverStopped) {
-		DBG_88E("bDriverStopped =%d\n", padapter->bDriverStopped);
 		ret = -1;
 		goto exit;
 	}
@@ -1318,15 +1244,11 @@ static int rtw_wx_set_scan(struct net_device *dev, struct iw_request_info *a,
 			memcpy(ssid[0].Ssid, req->essid, len);
 			ssid[0].SsidLength = len;
 
-			DBG_88E("IW_SCAN_THIS_ESSID, ssid =%s, len =%d\n", req->essid, req->essid_len);
-
 			spin_lock_bh(&pmlmepriv->lock);
 
 			_status = rtw_sitesurvey_cmd(padapter, ssid, 1, NULL, 0);
 
 			spin_unlock_bh(&pmlmepriv->lock);
-		} else if (req->scan_type == IW_SCAN_TYPE_PASSIVE) {
-			DBG_88E("rtw_wx_set_scan, req->scan_type == IW_SCAN_TYPE_PASSIVE\n");
 		}
 	} else {
 		if (wrqu->data.length >= WEXT_CSCAN_HEADER_SIZE &&
@@ -1404,10 +1326,6 @@ static int rtw_wx_get_scan(struct net_device *dev, struct iw_request_info *a,
 #ifdef CONFIG_88EU_P2P
 	struct	wifidirect_info *pwdinfo = &padapter->wdinfo;
 #endif /* CONFIG_88EU_P2P */
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_wx_get_scan\n"));
-	RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_info_, (" Start of Query SIOCGIWSCAN .\n"));
-
-
 
 	if (padapter->pwrctrlpriv.brfoffbyhw && padapter->bDriverStopped) {
 		ret = -EINVAL;
@@ -1488,9 +1406,6 @@ static int rtw_wx_set_essid(struct net_device *dev,
 	uint ret = 0, len;
 
 
-
-	RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_info_,
-		 ("+rtw_wx_set_essid: fw_state = 0x%08x\n", get_fwstate(pmlmepriv)));
 	if (_FAIL == rtw_pwr_wakeup(padapter)) {
 		ret = -1;
 		goto exit;
@@ -1512,19 +1427,14 @@ static int rtw_wx_set_essid(struct net_device *dev,
 	}
 
 	authmode = padapter->securitypriv.ndisauthtype;
-	DBG_88E("=>%s\n", __func__);
 	if (wrqu->essid.flags && wrqu->essid.length) {
 		len = (wrqu->essid.length < IW_ESSID_MAX_SIZE) ? wrqu->essid.length : IW_ESSID_MAX_SIZE;
 
-		if (wrqu->essid.length != 33)
-			DBG_88E("ssid =%s, len =%d\n", extra, wrqu->essid.length);
-
 		memset(&ndis_ssid, 0, sizeof(struct ndis_802_11_ssid));
 		ndis_ssid.SsidLength = len;
 		memcpy(ndis_ssid.Ssid, extra, len);
 		src_ssid = ndis_ssid.Ssid;
 
-		RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_info_, ("rtw_wx_set_essid: ssid =[%s]\n", src_ssid));
 		spin_lock_bh(&queue->lock);
 	       phead = get_list_head(queue);
 	      pmlmepriv->pscanned = phead->next;
@@ -1536,14 +1446,8 @@ static int rtw_wx_set_essid(struct net_device *dev,
 
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
@@ -1560,8 +1464,6 @@ static int rtw_wx_set_essid(struct net_device *dev,
 			}
 		}
 		spin_unlock_bh(&queue->lock);
-		RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_info_,
-			 ("set ssid: set_802_11_auth. mode =%d\n", authmode));
 		rtw_set_802_11_authentication_mode(padapter, authmode);
 		if (rtw_set_802_11_ssid(padapter, &ndis_ssid) == false) {
 			ret = -1;
@@ -1570,11 +1472,6 @@ static int rtw_wx_set_essid(struct net_device *dev,
 	}
 
 exit:
-
-	DBG_88E("<=%s, ret %d\n", __func__, ret);
-
-
-
 	return ret;
 }
 
@@ -1587,10 +1484,6 @@ static int rtw_wx_get_essid(struct net_device *dev,
 	struct	mlme_priv	*pmlmepriv = &(padapter->mlmepriv);
 	struct wlan_bssid_ex  *pcur_bss = &pmlmepriv->cur_network.network;
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_wx_get_essid\n"));
-
-
-
 	if ((check_fwstate(pmlmepriv, _FW_LINKED)) ||
 	    (check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE))) {
 		len = pcur_bss->Ssid.SsidLength;
@@ -1618,9 +1511,6 @@ static int rtw_wx_set_rate(struct net_device *dev,
 	u32	ratevalue = 0;
 	 u8 mpdatarate[NumRates] = {11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0, 0xff};
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, (" rtw_wx_set_rate\n"));
-	RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_info_, ("target_rate = %d, fixed = %d\n", target_rate, fixed));
-
 	if (target_rate == -1) {
 		ratevalue = 11;
 		goto set_rate;
@@ -1679,14 +1569,10 @@ static int rtw_wx_set_rate(struct net_device *dev,
 		} else {
 			datarates[i] = 0xff;
 		}
-
-		RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_info_, ("datarate_inx =%d\n", datarates[i]));
 	}
 
-	if (rtw_setdatarate_cmd(padapter, datarates) != _SUCCESS) {
-		RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_err_, ("rtw_wx_set_rate Fail!!!\n"));
+	if (rtw_setdatarate_cmd(padapter, datarates) != _SUCCESS)
 		ret = -1;
-	}
 
 	return ret;
 }
@@ -1726,10 +1612,6 @@ static int rtw_wx_set_rts(struct net_device *dev,
 		padapter->registrypriv.rts_thresh = wrqu->rts.value;
 	}
 
-	DBG_88E("%s, rts_thresh =%d\n", __func__, padapter->registrypriv.rts_thresh);
-
-
-
 	return 0;
 }
 
@@ -1739,16 +1621,10 @@ static int rtw_wx_get_rts(struct net_device *dev,
 {
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 
-
-
-	DBG_88E("%s, rts_thresh =%d\n", __func__, padapter->registrypriv.rts_thresh);
-
 	wrqu->rts.value = padapter->registrypriv.rts_thresh;
 	wrqu->rts.fixed = 0;	/* no auto select */
 	/* wrqu->rts.disabled = (wrqu->rts.value == DEFAULT_RTS_THRESHOLD); */
 
-
-
 	return 0;
 }
 
@@ -1770,10 +1646,6 @@ static int rtw_wx_set_frag(struct net_device *dev,
 		padapter->xmitpriv.frag_len = wrqu->frag.value & ~0x1;
 	}
 
-	DBG_88E("%s, frag_len =%d\n", __func__, padapter->xmitpriv.frag_len);
-
-
-
 	return 0;
 }
 
@@ -1783,15 +1655,9 @@ static int rtw_wx_get_frag(struct net_device *dev,
 {
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 
-
-
-	DBG_88E("%s, frag_len =%d\n", __func__, padapter->xmitpriv.frag_len);
-
 	wrqu->frag.value = padapter->xmitpriv.frag_len;
 	wrqu->frag.fixed = 0;	/* no auto select */
 
-
-
 	return 0;
 }
 
@@ -1818,7 +1684,6 @@ static int rtw_wx_set_enc(struct net_device *dev,
 	struct iw_point *erq = &(wrqu->encoding);
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	struct pwrctrl_priv *pwrpriv = &padapter->pwrctrlpriv;
-	DBG_88E("+rtw_wx_set_enc, flags = 0x%x\n", erq->flags);
 
 	memset(&wep, 0, sizeof(struct ndis_802_11_wep));
 
@@ -1827,7 +1692,6 @@ static int rtw_wx_set_enc(struct net_device *dev,
 
 
 	if (erq->flags & IW_ENCODE_DISABLED) {
-		DBG_88E("EncryptionDisabled\n");
 		padapter->securitypriv.ndisencryptstatus = Ndis802_11EncryptionDisabled;
 		padapter->securitypriv.dot11PrivacyAlgrthm = _NO_PRIVACY_;
 		padapter->securitypriv.dot118021XGrpPrivacy = _NO_PRIVACY_;
@@ -1846,12 +1710,10 @@ static int rtw_wx_set_enc(struct net_device *dev,
 	} else {
 		keyindex_provided = 0;
 		key = padapter->securitypriv.dot11PrivacyKeyIndex;
-		DBG_88E("rtw_wx_set_enc, key =%d\n", key);
 	}
 
 	/* set authentication mode */
 	if (erq->flags & IW_ENCODE_OPEN) {
-		DBG_88E("rtw_wx_set_enc():IW_ENCODE_OPEN\n");
 		padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption1Enabled;/* Ndis802_11EncryptionDisabled; */
 		padapter->securitypriv.dot11AuthAlgrthm = dot11AuthAlgrthm_Open;
 		padapter->securitypriv.dot11PrivacyAlgrthm = _NO_PRIVACY_;
@@ -1859,7 +1721,6 @@ static int rtw_wx_set_enc(struct net_device *dev,
 		authmode = Ndis802_11AuthModeOpen;
 		padapter->securitypriv.ndisauthtype = authmode;
 	} else if (erq->flags & IW_ENCODE_RESTRICTED) {
-		DBG_88E("rtw_wx_set_enc():IW_ENCODE_RESTRICTED\n");
 		padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption1Enabled;
 		padapter->securitypriv.dot11AuthAlgrthm = dot11AuthAlgrthm_Shared;
 		padapter->securitypriv.dot11PrivacyAlgrthm = _WEP40_;
@@ -1867,8 +1728,6 @@ static int rtw_wx_set_enc(struct net_device *dev,
 		authmode = Ndis802_11AuthModeShared;
 		padapter->securitypriv.ndisauthtype = authmode;
 	} else {
-		DBG_88E("rtw_wx_set_enc():erq->flags = 0x%x\n", erq->flags);
-
 		padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption1Enabled;/* Ndis802_11EncryptionDisabled; */
 		padapter->securitypriv.dot11AuthAlgrthm = dot11AuthAlgrthm_Open; /* open system */
 		padapter->securitypriv.dot11PrivacyAlgrthm = _NO_PRIVACY_;
@@ -1889,8 +1748,6 @@ static int rtw_wx_set_enc(struct net_device *dev,
 			/*  set key_id only, no given KeyMaterial(erq->length == 0). */
 			padapter->securitypriv.dot11PrivacyKeyIndex = key;
 
-			DBG_88E("(keyindex_provided == 1), keyid =%d, key_len =%d\n", key, padapter->securitypriv.dot11DefKeylen[key]);
-
 			switch (padapter->securitypriv.dot11DefKeylen[key]) {
 			case 5:
 				padapter->securitypriv.dot11PrivacyAlgrthm = _WEP40_;
@@ -2078,7 +1935,6 @@ static int rtw_wx_set_auth(struct net_device *dev,
 		if (check_fwstate(&padapter->mlmepriv, _FW_LINKED)) {
 			LeaveAllPowerSaveMode(padapter);
 			rtw_disassoc_cmd(padapter, 500, false);
-			DBG_88E("%s...call rtw_indicate_disconnect\n ", __func__);
 			rtw_indicate_disconnect(padapter);
 			rtw_free_assoc_resources(padapter, 1);
 		}
@@ -2221,10 +2077,8 @@ static int rtw_wx_read32(struct net_device *dev,
 		sprintf(extra, "0x%08X", data32);
 		break;
 	default:
-		DBG_88E(KERN_INFO "%s: usage> read [bytes],[address(hex)]\n", __func__);
 		return -EINVAL;
 	}
-	DBG_88E(KERN_INFO "%s: addr = 0x%08X data =%s\n", __func__, addr, extra);
 
 	kfree(ptmp);
 	return 0;
@@ -2248,18 +2102,14 @@ static int rtw_wx_write32(struct net_device *dev,
 	switch (bytes) {
 	case 1:
 		rtw_write8(padapter, addr, (u8)data32);
-		DBG_88E(KERN_INFO "%s: addr = 0x%08X data = 0x%02X\n", __func__, addr, (u8)data32);
 		break;
 	case 2:
 		rtw_write16(padapter, addr, (u16)data32);
-		DBG_88E(KERN_INFO "%s: addr = 0x%08X data = 0x%04X\n", __func__, addr, (u16)data32);
 		break;
 	case 4:
 		rtw_write32(padapter, addr, data32);
-		DBG_88E(KERN_INFO "%s: addr = 0x%08X data = 0x%08X\n", __func__, addr, data32);
 		break;
 	default:
-		DBG_88E(KERN_INFO "%s: usage> write [bytes],[address(hex)],[data(hex)]\n", __func__);
 		return -EINVAL;
 	}
 
@@ -2321,9 +2171,7 @@ static int rtw_wx_set_channel_plan(struct net_device *dev,
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	u8 channel_plan_req = (u8) (*((int *)wrqu));
 
-	if (_SUCCESS == rtw_set_chplan_cmd(padapter, channel_plan_req, 1))
-		DBG_88E("%s set channel_plan = 0x%02X\n", __func__, pmlmepriv->ChannelPlan);
-	else
+	if (rtw_set_chplan_cmd(padapter, channel_plan_req, 1) != _SUCCESS)
 		return -EPERM;
 
 	return 0;
@@ -2368,12 +2216,7 @@ static void rtw_dbg_mode_hdl(struct adapter *padapter, u32 id, u8 *pdata, u32 le
 	u8 offset;
 	u32 value;
 
-	DBG_88E("%s\n", __func__);
-
 	switch (id) {
-	case GEN_MP_IOCTL_SUBCODE(MP_START):
-		DBG_88E("871x_driver is only for normal mode, can't enter mp mode\n");
-		break;
 	case GEN_MP_IOCTL_SUBCODE(READ_REG):
 		RegRWStruct = (struct mp_rw_reg *)pdata;
 		switch (RegRWStruct->width) {
@@ -2432,7 +2275,6 @@ static void rtw_dbg_mode_hdl(struct adapter *padapter, u32 id, u8 *pdata, u32 le
 
 		break;
 	case GEN_MP_IOCTL_SUBCODE(TRIGGER_GPIO):
-		DBG_88E("==> trigger gpio 0\n");
 		rtw_hal_set_hwreg(padapter, HW_VAR_TRIGGER_GPIO_0, NULL);
 		break;
 	case GEN_MP_IOCTL_SUBCODE(GET_WIFI_STATUS):
@@ -2476,12 +2318,8 @@ static int rtw_mp_ioctl_hdl(struct net_device *dev, struct iw_request_info *info
 	}
 
 	poidparam = (struct mp_ioctl_param *)pparmbuf;
-	RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_info_,
-		 ("rtw_mp_ioctl_hdl: subcode [%d], len[%d], buffer_len[%d]\r\n",
-		  poidparam->subcode, poidparam->len, len));
 
 	if (poidparam->subcode >= MAX_MP_IOCTL_SUBCODE) {
-		RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_err_, ("no matching drvext subcodes\r\n"));
 		ret = -EINVAL;
 		goto _rtw_mp_ioctl_hdl_exit;
 	}
@@ -2490,9 +2328,6 @@ static int rtw_mp_ioctl_hdl(struct net_device *dev, struct iw_request_info *info
 		phandler = mp_ioctl_hdl + poidparam->subcode;
 
 		if ((phandler->paramsize != 0) && (poidparam->len < phandler->paramsize)) {
-			RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_err_,
-				 ("no matching drvext param size %d vs %d\r\n",
-				  poidparam->len, phandler->paramsize));
 			ret = -EINVAL;
 			goto _rtw_mp_ioctl_hdl_exit;
 		}
@@ -2519,8 +2354,6 @@ static int rtw_mp_ioctl_hdl(struct net_device *dev, struct iw_request_info *info
 
 			status = phandler->handler(&oid_par);
 		} else {
-			DBG_88E("rtw_mp_ioctl_hdl(): err!, subcode =%d, oid =%d, handler =%p\n",
-				poidparam->subcode, phandler->oid, phandler->handler);
 			ret = -EFAULT;
 			goto _rtw_mp_ioctl_hdl_exit;
 		}
@@ -2560,8 +2393,6 @@ static int rtw_get_ap_info(struct net_device *dev,
 	struct __queue *queue = &(pmlmepriv->scanned_queue);
 	struct iw_point *pdata = &wrqu->data;
 
-	DBG_88E("+rtw_get_aplist_info\n");
-
 	if (padapter->bDriverStopped || !pdata) {
 		ret = -EINVAL;
 		goto exit;
@@ -2593,14 +2424,12 @@ static int rtw_get_ap_info(struct net_device *dev,
 		pnetwork = container_of(plist, struct wlan_network, list);
 
 		if (hwaddr_aton_i(data, bssid)) {
-			DBG_88E("Invalid BSSID '%s'.\n", (u8 *)data);
 			spin_unlock_bh(&pmlmepriv->scanned_queue.lock);
 			return -EINVAL;
 		}
 
 		if (!memcmp(bssid, pnetwork->network.MacAddress, ETH_ALEN)) {
 			/* BSSID match, then check if supporting wpa/wpa2 */
-			DBG_88E("BSSID:%pM\n", (bssid));
 
 			pbuf = rtw_get_wpa_ie(&pnetwork->network.IEs[12], &wpa_ielen, pnetwork->network.IELength-12);
 			if (pbuf && (wpa_ielen > 0)) {
@@ -2650,9 +2479,6 @@ static int rtw_set_pid(struct net_device *dev,
 	if (selector < 3 && selector >= 0) {
 		padapter->pid[selector] = *(pdata+1);
 		ui_pid[selector] = *(pdata+1);
-		DBG_88E("%s set pid[%d] =%d\n", __func__, selector, padapter->pid[selector]);
-	} else {
-		DBG_88E("%s selector %d error\n", __func__, selector);
 	}
 exit:
 	return ret;
@@ -2681,8 +2507,6 @@ static int rtw_wps_start(struct net_device *dev,
 	if (u32wps_start == 0)
 		u32wps_start = *extra;
 
-	DBG_88E("[%s] wps_start = %d\n", __func__, u32wps_start);
-
 	if (u32wps_start == 1) /*  WPS Start */
 		rtw_led_control(padapter, LED_CTL_START_WPS);
 	else if (u32wps_start == 2) /*  WPS Stop because of wps success */
@@ -2753,7 +2577,6 @@ static int rtw_p2p_set_go_nego_ssid(struct net_device *dev,
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	struct wifidirect_info *pwdinfo = &(padapter->wdinfo);
 
-	DBG_88E("[%s] ssid = %s, len = %zu\n", __func__, extra, strlen(extra));
 	memcpy(pwdinfo->nego_ssid, extra, strlen(extra));
 	pwdinfo->nego_ssidlen = strlen(extra);
 
@@ -2781,7 +2604,7 @@ static int rtw_p2p_set_intent(struct net_device *dev,
 		pwdinfo->intent = intent;
 	else
 		ret = -1;
-	DBG_88E("[%s] intent = %d\n", __func__, intent);
+
 	return ret;
 }
 
@@ -2810,8 +2633,6 @@ static int rtw_p2p_set_listen_ch(struct net_device *dev,
 		ret = -1;
 	}
 
-	DBG_88E("[%s] listen_ch = %d\n", __func__, pwdinfo->listen_channel);
-
 	return ret;
 }
 
@@ -2841,8 +2662,6 @@ static int rtw_p2p_set_op_ch(struct net_device *dev,
 	else
 		ret = -1;
 
-	DBG_88E("[%s] op_ch = %d\n", __func__, pwdinfo->operating_channel);
-
 	return ret;
 }
 
@@ -2864,8 +2683,6 @@ static int rtw_p2p_profilefound(struct net_device *dev,
 	/*	YY => SSID Length */
 	/*	SSID => SSID for persistence group */
 
-	DBG_88E("[%s] In value = %s, len = %d\n", __func__, extra, wrqu->data.length - 1);
-
 	/*	The upper application should pass the SSID to driver by using this rtw_p2p_profilefound function. */
 		if (!rtw_p2p_chk_state(pwdinfo, P2P_STATE_NONE)) {
 			if (extra[0] == '0') {
@@ -2901,7 +2718,6 @@ static int rtw_p2p_setDN(struct net_device *dev,
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	struct wifidirect_info *pwdinfo = &(padapter->wdinfo);
 
-	DBG_88E("[%s] %s %d\n", __func__, extra, wrqu->data.length - 1);
 	memset(pwdinfo->device_name, 0x00, WPS_MAX_DEVICE_NAME_LEN);
 	memcpy(pwdinfo->device_name, extra, wrqu->data.length - 1);
 	pwdinfo->device_name_len = wrqu->data.length - 1;
@@ -2917,11 +2733,6 @@ static int rtw_p2p_get_status(struct net_device *dev,
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	struct wifidirect_info *pwdinfo = &(padapter->wdinfo);
 
-	if (padapter->bShowGetP2PState)
-		DBG_88E("[%s] Role = %d, Status = %d, peer addr = %.2X:%.2X:%.2X:%.2X:%.2X:%.2X\n", __func__, rtw_p2p_role(pwdinfo), rtw_p2p_state(pwdinfo),
-			pwdinfo->p2p_peer_interface_addr[0], pwdinfo->p2p_peer_interface_addr[1], pwdinfo->p2p_peer_interface_addr[2],
-			pwdinfo->p2p_peer_interface_addr[3], pwdinfo->p2p_peer_interface_addr[4], pwdinfo->p2p_peer_interface_addr[5]);
-
 	/*	Commented by Albert 2010/10/12 */
 	/*	Because of the output size limitation, I had removed the "Role" information. */
 	/*	About the "Role" information, we will use the new private IOCTL to get the "Role" information. */
@@ -2957,10 +2768,6 @@ static int rtw_p2p_get_role(struct net_device *dev,
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	struct wifidirect_info *pwdinfo = &(padapter->wdinfo);
 
-	DBG_88E("[%s] Role = %d, Status = %d, peer addr = %.2X:%.2X:%.2X:%.2X:%.2X:%.2X\n", __func__, rtw_p2p_role(pwdinfo), rtw_p2p_state(pwdinfo),
-			pwdinfo->p2p_peer_interface_addr[0], pwdinfo->p2p_peer_interface_addr[1], pwdinfo->p2p_peer_interface_addr[2],
-			pwdinfo->p2p_peer_interface_addr[3], pwdinfo->p2p_peer_interface_addr[4], pwdinfo->p2p_peer_interface_addr[5]);
-
 	sprintf(extra, "\n\nRole =%.2d\n", rtw_p2p_role(pwdinfo));
 	wrqu->data.length = strlen(extra);
 	return ret;
@@ -2974,9 +2781,6 @@ static int rtw_p2p_get_peer_ifaddr(struct net_device *dev,
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	struct wifidirect_info *pwdinfo = &(padapter->wdinfo);
 
-	DBG_88E("[%s] Role = %d, Status = %d, peer addr = %pM\n", __func__,
-		rtw_p2p_role(pwdinfo), rtw_p2p_state(pwdinfo),
-		pwdinfo->p2p_peer_interface_addr);
 	sprintf(extra, "\nMAC %pM",
 		pwdinfo->p2p_peer_interface_addr);
 	wrqu->data.length = strlen(extra);
@@ -2992,9 +2796,6 @@ static int rtw_p2p_get_peer_devaddr(struct net_device *dev,
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	struct wifidirect_info *pwdinfo = &(padapter->wdinfo);
 
-	DBG_88E("[%s] Role = %d, Status = %d, peer addr = %pM\n", __func__,
-		rtw_p2p_role(pwdinfo), rtw_p2p_state(pwdinfo),
-		pwdinfo->rx_prov_disc_info.peerDevAddr);
 	sprintf(extra, "\n%pM",
 		pwdinfo->rx_prov_disc_info.peerDevAddr);
 	wrqu->data.length = strlen(extra);
@@ -3010,9 +2811,6 @@ static int rtw_p2p_get_peer_devaddr_by_invitation(struct net_device *dev,
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	struct wifidirect_info *pwdinfo = &(padapter->wdinfo);
 
-	DBG_88E("[%s] Role = %d, Status = %d, peer addr = %pM\n",
-		__func__, rtw_p2p_role(pwdinfo), rtw_p2p_state(pwdinfo),
-		pwdinfo->p2p_peer_device_addr);
 	sprintf(extra, "\nMAC %pM",
 		pwdinfo->p2p_peer_device_addr);
 	wrqu->data.length = strlen(extra);
@@ -3046,8 +2844,6 @@ static int rtw_p2p_get_op_ch(struct net_device *dev,
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	struct wifidirect_info *pwdinfo = &(padapter->wdinfo);
 
-	DBG_88E("[%s] Op_ch = %02x\n", __func__, pwdinfo->operating_channel);
-
 	sprintf(extra, "\n\nOp_ch =%.2d\n", pwdinfo->operating_channel);
 	wrqu->data.length = strlen(extra);
 	return ret;
@@ -3077,7 +2873,6 @@ static int rtw_p2p_get_wps_configmethod(struct net_device *dev,
 	/*	After knowing its WPS config method, the application can decide the config method for provisioning discovery. */
 	/*	Format: iwpriv wlanx p2p_get_wpsCM 00:E0:4C:00:00:05 */
 
-	DBG_88E("[%s] data = %s\n", __func__, (char *)extra);
 	if (copy_from_user(peerMACStr, wrqu->data.pointer + 6, 17))
 		return -EFAULT;
 
@@ -3146,7 +2941,6 @@ static int rtw_p2p_get_go_device_address(struct net_device *dev,
 	/*	The input data is the GO's interface address which the application wants to know its device address. */
 	/*	Format: iwpriv wlanx p2p_get2 go_devadd = 00:E0:4C:00:00:05 */
 
-	DBG_88E("[%s] data = %s\n", __func__, (char *)extra);
 	if (copy_from_user(peerMACStr, wrqu->data.pointer + 10, 17))
 		return -EFAULT;
 
@@ -3227,7 +3021,6 @@ static int rtw_p2p_get_device_type(struct net_device *dev,
 	/*	Such user interface could know the device type. */
 	/*	Format: iwpriv wlanx p2p_get2 dev_type = 00:E0:4C:00:00:05 */
 
-	DBG_88E("[%s] data = %s\n", __func__, (char *)extra);
 	if (copy_from_user(peerMACStr, wrqu->data.pointer + 9, 17))
 		return -EFAULT;
 
@@ -3303,7 +3096,6 @@ static int rtw_p2p_get_device_name(struct net_device *dev,
 	/*	Such user interface could show peer device's device name instead of ssid. */
 	/*	Format: iwpriv wlanx p2p_get2 devN = 00:E0:4C:00:00:05 */
 
-	DBG_88E("[%s] data = %s\n", __func__, (char *)extra);
 	if (copy_from_user(peerMACStr, wrqu->data.pointer + 5, 17))
 		return -EFAULT;
 
@@ -3371,7 +3163,6 @@ static int rtw_p2p_get_invitation_procedure(struct net_device *dev,
 	/*	The application wants to know P2P initiation procedure is supported or not. */
 	/*	Format: iwpriv wlanx p2p_get2 InvProc = 00:E0:4C:00:00:05 */
 
-	DBG_88E("[%s] data = %s\n", __func__, (char *)extra);
 	if (copy_from_user(peerMACStr, wrqu->data.pointer + 8, 17))
 		return -EFAULT;
 
@@ -3444,12 +3235,8 @@ static int rtw_p2p_connect(struct net_device *dev,
 	/*	Format: 00:E0:4C:00:00:05 */
 	/*	Format: 00:E0:4C:00:00:05 */
 
-	DBG_88E("[%s] data = %s\n", __func__, extra);
-
-	if (pwdinfo->p2p_state == P2P_STATE_NONE) {
-		DBG_88E("[%s] WiFi Direct is disable!\n", __func__);
+	if (pwdinfo->p2p_state == P2P_STATE_NONE)
 		return ret;
-	}
 
 	if (pwdinfo->ui_got_wps_info == P2P_NO_WPSINFO)
 		return -1;
@@ -3491,13 +3278,12 @@ static int rtw_p2p_connect(struct net_device *dev,
 		rtw_p2p_set_pre_state(pwdinfo, rtw_p2p_state(pwdinfo));
 		rtw_p2p_set_state(pwdinfo, P2P_STATE_GONEGO_ING);
 
-		DBG_88E("[%s] Start PreTx Procedure!\n", __func__);
 		_set_timer(&pwdinfo->pre_tx_scan_timer, P2P_TX_PRESCAN_TIMEOUT);
 		_set_timer(&pwdinfo->restore_p2p_state_timer, P2P_GO_NEGO_TIMEOUT);
 	} else {
-		DBG_88E("[%s] Not Found in Scanning Queue~\n", __func__);
 		ret = -1;
 	}
+
 	return ret;
 }
 
@@ -3525,15 +3311,10 @@ static int rtw_p2p_invite_req(struct net_device *dev,
 	/*	Command line sample: iwpriv wlan0 p2p_set invite ="00:11:22:33:44:55 00:E0:4C:00:00:05 DIRECT-xy" */
 	/*	Format: 00:11:22:33:44:55 00:E0:4C:00:00:05 DIRECT-xy */
 
-	DBG_88E("[%s] data = %s\n", __func__, extra);
-
-	if (wrqu->data.length <=  37) {
-		DBG_88E("[%s] Wrong format!\n", __func__);
+	if (wrqu->data.length <=  37)
 		return ret;
-	}
 
 	if (rtw_p2p_chk_state(pwdinfo, P2P_STATE_NONE)) {
-		DBG_88E("[%s] WiFi Direct is disable!\n", __func__);
 		return ret;
 	} else {
 		/*	Reset the content of struct tx_invite_req_info */
@@ -3604,9 +3385,8 @@ static int rtw_p2p_invite_req(struct net_device *dev,
 		_set_timer(&pwdinfo->pre_tx_scan_timer, P2P_TX_PRESCAN_TIMEOUT);
 
 		_set_timer(&pwdinfo->restore_p2p_state_timer, P2P_INVITE_TIMEOUT);
-	} else {
-		DBG_88E("[%s] NOT Found in the Scanning Queue!\n", __func__);
 	}
+
 	return ret;
 }
 
@@ -3622,10 +3402,7 @@ static int rtw_p2p_set_persistent(struct net_device *dev,
 	/*	0: disable persistent group functionality */
 	/*	1: enable persistent group founctionality */
 
-	DBG_88E("[%s] data = %s\n", __func__, extra);
-
 	if (rtw_p2p_chk_state(pwdinfo, P2P_STATE_NONE)) {
-		DBG_88E("[%s] WiFi Direct is disable!\n", __func__);
 		return ret;
 	} else {
 		if (extra[0] == '0')	/*	Disable the persistent group function. */
@@ -3665,10 +3442,7 @@ static int rtw_p2p_prov_disc(struct net_device *dev,
 	/*	Format: 00:E0:4C:00:00:05_pbc */
 	/*	Format: 00:E0:4C:00:00:05_label */
 
-	DBG_88E("[%s] data = %s\n", __func__, extra);
-
 	if (pwdinfo->p2p_state == P2P_STATE_NONE) {
-		DBG_88E("[%s] WiFi Direct is disable!\n", __func__);
 		return ret;
 	} else {
 		/*	Reset the content of struct tx_provdisc_req_info excluded the wps_config_method_request. */
@@ -3692,7 +3466,6 @@ static int rtw_p2p_prov_disc(struct net_device *dev,
 	} else if (!memcmp(&extra[18], "label", 5)) {
 		pwdinfo->tx_prov_disc_info.wps_config_method_request = WPS_CM_LABEL;
 	} else {
-		DBG_88E("[%s] Unknown WPS config methodn", __func__);
 		return ret;
 	}
 
@@ -3742,7 +3515,6 @@ static int rtw_p2p_prov_disc(struct net_device *dev,
 	spin_unlock_bh(&pmlmepriv->scanned_queue.lock);
 
 	if (uintPeerChannel) {
-		DBG_88E("[%s] peer channel: %d!\n", __func__, uintPeerChannel);
 		memcpy(pwdinfo->tx_prov_disc_info.peerIFAddr, pnetwork->network.MacAddress, ETH_ALEN);
 		memcpy(pwdinfo->tx_prov_disc_info.peerDevAddr, peerMAC, ETH_ALEN);
 		pwdinfo->tx_prov_disc_info.peer_channel_num[0] = (u16) uintPeerChannel;
@@ -3762,9 +3534,8 @@ static int rtw_p2p_prov_disc(struct net_device *dev,
 		_set_timer(&pwdinfo->pre_tx_scan_timer, P2P_TX_PRESCAN_TIMEOUT);
 
 		_set_timer(&pwdinfo->restore_p2p_state_timer, P2P_PROVISION_TIMEOUT);
-	} else {
-		DBG_88E("[%s] NOT Found in the Scanning Queue!\n", __func__);
 	}
+
 	return ret;
 }
 
@@ -3779,7 +3550,6 @@ static int rtw_p2p_got_wpsinfo(struct net_device *dev,
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	struct wifidirect_info *pwdinfo = &(padapter->wdinfo);
 
-	DBG_88E("[%s] data = %s\n", __func__, extra);
 	/*	Added by Albert 20110328 */
 	/*	if the input data is P2P_NO_WPSINFO -> reset the wpsinfo */
 	/*	if the input data is P2P_GOT_WPSINFO_PEER_DISPLAY_PIN -> the utility just input the PIN code got from the peer P2P device. */
@@ -3808,7 +3578,6 @@ static int rtw_p2p_set(struct net_device *dev,
 	int ret = 0;
 
 #ifdef CONFIG_88EU_P2P
-	DBG_88E("[%s] extra = %s\n", __func__, extra);
 	if (!memcmp(extra, "enable =", 7)) {
 		rtw_wext_p2p_enable(dev, info, wrqu, &extra[7]);
 	} else if (!memcmp(extra, "setDN =", 6)) {
@@ -3868,8 +3637,6 @@ static int rtw_p2p_get(struct net_device *dev,
 #ifdef CONFIG_88EU_P2P
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 
-	if (padapter->bShowGetP2PState)
-		DBG_88E("[%s] extra = %s\n", __func__, (char *)wrqu->data.pointer);
 	if (!memcmp(wrqu->data.pointer, "status", 6)) {
 		rtw_p2p_get_status(dev, info, wrqu, extra);
 	} else if (!memcmp(wrqu->data.pointer, "role", 4)) {
@@ -3900,7 +3667,6 @@ static int rtw_p2p_get2(struct net_device *dev,
 	int ret = 0;
 
 #ifdef CONFIG_88EU_P2P
-	DBG_88E("[%s] extra = %s\n", __func__, (char *)wrqu->data.pointer);
 	if (!memcmp(extra, "wpsCM =", 6)) {
 		wrqu->data.length -= 6;
 		rtw_p2p_get_wps_configmethod(dev, info, wrqu,  &extra[6]);
@@ -3929,7 +3695,6 @@ static int rtw_cta_test_start(struct net_device *dev,
 {
 	int ret = 0;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
-	DBG_88E("%s %s\n", __func__, extra);
 	if (!strcmp(extra, "1"))
 		padapter->in_cta_test = 1;
 	else
@@ -3939,12 +3704,10 @@ static int rtw_cta_test_start(struct net_device *dev,
 		u32 v = rtw_read32(padapter, REG_RCR);
 		v &= ~(RCR_CBSSID_DATA | RCR_CBSSID_BCN);/*  RCR_ADF */
 		rtw_write32(padapter, REG_RCR, v);
-		DBG_88E("enable RCR_ADF\n");
 	} else {
 		u32 v = rtw_read32(padapter, REG_RCR);
 		v |= RCR_CBSSID_DATA | RCR_CBSSID_BCN;/*  RCR_ADF */
 		rtw_write32(padapter, REG_RCR, v);
-		DBG_88E("disable RCR_ADF\n");
 	}
 	return ret;
 }
@@ -3975,7 +3738,6 @@ static int rtw_rereg_nd_name(struct net_device *dev,
 	if (0 == strcmp(rereg_priv->old_ifname, new_ifname))
 		return ret;
 
-	DBG_88E("%s new_ifname:%s\n", __func__, new_ifname);
 	ret = rtw_change_ifname(padapter, new_ifname);
 	if (0 != ret)
 		goto exit;
@@ -3990,7 +3752,6 @@ static int rtw_rereg_nd_name(struct net_device *dev,
 	rereg_priv->old_ifname[IFNAMSIZ-1] = 0;
 
 	if (!memcmp(new_ifname, "disable%d", 9)) {
-		DBG_88E("%s disable\n", __func__);
 		/*  free network queue for Android's timming issue */
 		rtw_free_network_queue(padapter, true);
 
@@ -4096,48 +3857,24 @@ static int rtw_dbg_port(struct net_device *dev,
 	extra_arg = *(pdata+1);
 
 	switch (major_cmd) {
-	case 0x70:/* read_reg */
-		switch (minor_cmd) {
-		case 1:
-			DBG_88E("rtw_read8(0x%x) = 0x%02x\n", arg, rtw_read8(padapter, arg));
-			break;
-		case 2:
-			DBG_88E("rtw_read16(0x%x) = 0x%04x\n", arg, rtw_read16(padapter, arg));
-			break;
-		case 4:
-			DBG_88E("rtw_read32(0x%x) = 0x%08x\n", arg, rtw_read32(padapter, arg));
-			break;
-		}
-		break;
 	case 0x71:/* write_reg */
 		switch (minor_cmd) {
 		case 1:
 			rtw_write8(padapter, arg, extra_arg);
-			DBG_88E("rtw_write8(0x%x) = 0x%02x\n", arg, rtw_read8(padapter, arg));
 			break;
 		case 2:
 			rtw_write16(padapter, arg, extra_arg);
-			DBG_88E("rtw_write16(0x%x) = 0x%04x\n", arg, rtw_read16(padapter, arg));
 			break;
 		case 4:
 			rtw_write32(padapter, arg, extra_arg);
-			DBG_88E("rtw_write32(0x%x) = 0x%08x\n", arg, rtw_read32(padapter, arg));
 			break;
 		}
 		break;
-	case 0x72:/* read_bb */
-		DBG_88E("read_bbreg(0x%x) = 0x%x\n", arg, rtw_hal_read_bbreg(padapter, arg, 0xffffffff));
-		break;
 	case 0x73:/* write_bb */
 		rtw_hal_write_bbreg(padapter, arg, 0xffffffff, extra_arg);
-		DBG_88E("write_bbreg(0x%x) = 0x%x\n", arg, rtw_hal_read_bbreg(padapter, arg, 0xffffffff));
-		break;
-	case 0x74:/* read_rf */
-		DBG_88E("read RF_reg path(0x%02x), offset(0x%x), value(0x%08x)\n", minor_cmd, arg, rtw_hal_read_rfreg(padapter, minor_cmd, arg, 0xffffffff));
 		break;
 	case 0x75:/* write_rf */
 		rtw_hal_write_rfreg(padapter, minor_cmd, arg, 0xffffffff, extra_arg);
-		DBG_88E("write RF_reg path(0x%02x), offset(0x%x), value(0x%08x)\n", minor_cmd, arg, rtw_hal_read_rfreg(padapter, minor_cmd, arg, 0xffffffff));
 		break;
 
 	case 0x76:
@@ -4203,7 +3940,6 @@ static int rtw_dbg_port(struct net_device *dev,
 			u16 start_value = 0;
 			u32 write_num = extra_arg;
 			int i;
-			u8 final;
 			struct xmit_frame	*xmit_frame;
 
 			xmit_frame = rtw_IOL_accquire_xmit_frame(padapter);
@@ -4216,12 +3952,6 @@ static int rtw_dbg_port(struct net_device *dev,
 				rtw_IOL_append_WB_cmd(xmit_frame, reg, i+start_value, 0xFF);
 			if (_SUCCESS != rtw_IOL_exec_cmds_sync(padapter, xmit_frame, 5000, 0))
 				ret = -EPERM;
-
-			final = rtw_read8(padapter, reg);
-			if (start_value+write_num-1 == final)
-				DBG_88E("continuous IOL_CMD_WB_REG to 0x%x %u times Success, start:%u, final:%u\n", reg, write_num, start_value, final);
-			else
-				DBG_88E("continuous IOL_CMD_WB_REG to 0x%x %u times Fail, start:%u, final:%u\n", reg, write_num, start_value, final);
 		}
 			break;
 
@@ -4232,7 +3962,6 @@ static int rtw_dbg_port(struct net_device *dev,
 			u32 write_num = extra_arg;
 
 			int i;
-			u16 final;
 			struct xmit_frame	*xmit_frame;
 
 			xmit_frame = rtw_IOL_accquire_xmit_frame(padapter);
@@ -4245,12 +3974,6 @@ static int rtw_dbg_port(struct net_device *dev,
 				rtw_IOL_append_WW_cmd(xmit_frame, reg, i+start_value, 0xFFFF);
 			if (_SUCCESS != rtw_IOL_exec_cmds_sync(padapter, xmit_frame, 5000, 0))
 				ret = -EPERM;
-
-			final = rtw_read16(padapter, reg);
-			if (start_value+write_num-1 == final)
-				DBG_88E("continuous IOL_CMD_WW_REG to 0x%x %u times Success, start:%u, final:%u\n", reg, write_num, start_value, final);
-			else
-				DBG_88E("continuous IOL_CMD_WW_REG to 0x%x %u times Fail, start:%u, final:%u\n", reg, write_num, start_value, final);
 		}
 			break;
 		case 0x08: /* continuous write dword test */
@@ -4260,7 +3983,6 @@ static int rtw_dbg_port(struct net_device *dev,
 			u32 write_num = extra_arg;
 
 			int i;
-			u32 final;
 			struct xmit_frame	*xmit_frame;
 
 			xmit_frame = rtw_IOL_accquire_xmit_frame(padapter);
@@ -4273,14 +3995,6 @@ static int rtw_dbg_port(struct net_device *dev,
 				rtw_IOL_append_WD_cmd(xmit_frame, reg, i+start_value, 0xFFFFFFFF);
 			if (_SUCCESS != rtw_IOL_exec_cmds_sync(padapter, xmit_frame, 5000, 0))
 				ret = -EPERM;
-
-			final = rtw_read32(padapter, reg);
-			if (start_value+write_num-1 == final)
-				DBG_88E("continuous IOL_CMD_WD_REG to 0x%x %u times Success, start:%u, final:%u\n",
-					reg, write_num, start_value, final);
-			else
-				DBG_88E("continuous IOL_CMD_WD_REG to 0x%x %u times Fail, start:%u, final:%u\n",
-					reg, write_num, start_value, final);
 		}
 			break;
 		}
@@ -4295,8 +4009,6 @@ static int rtw_dbg_port(struct net_device *dev,
 			u8 sign = minor_cmd;
 			u16 write_value = 0;
 
-			DBG_88E("%s set RESP_TXAGC to %s %u\n", __func__, sign ? "minus" : "plus", value);
-
 			if (sign)
 				value = value | 0x10;
 
@@ -4310,150 +4022,25 @@ static int rtw_dbg_port(struct net_device *dev,
 		break;
 	case 0x7F:
 		switch (minor_cmd) {
-		case 0x0:
-			DBG_88E("fwstate = 0x%x\n", get_fwstate(pmlmepriv));
-			break;
-		case 0x01:
-			DBG_88E("auth_alg = 0x%x, enc_alg = 0x%x, auth_type = 0x%x, enc_type = 0x%x\n",
-				psecuritypriv->dot11AuthAlgrthm, psecuritypriv->dot11PrivacyAlgrthm,
-				psecuritypriv->ndisauthtype, psecuritypriv->ndisencryptstatus);
-			break;
-		case 0x02:
-			DBG_88E("pmlmeinfo->state = 0x%x\n", pmlmeinfo->state);
-			break;
-		case 0x03:
-			DBG_88E("qos_option =%d\n", pmlmepriv->qospriv.qos_option);
-			DBG_88E("ht_option =%d\n", pmlmepriv->htpriv.ht_option);
-			break;
-		case 0x04:
-			DBG_88E("cur_ch =%d\n", pmlmeext->cur_channel);
-			DBG_88E("cur_bw =%d\n", pmlmeext->cur_bwmode);
-			DBG_88E("cur_ch_off =%d\n", pmlmeext->cur_ch_offset);
-			break;
-		case 0x05:
-			psta = rtw_get_stainfo(pstapriv, cur_network->network.MacAddress);
-			if (psta) {
-				int i;
-				struct recv_reorder_ctrl *preorder_ctrl;
-
-				DBG_88E("SSID =%s\n", cur_network->network.Ssid.Ssid);
-				DBG_88E("sta's macaddr: %pM\n", psta->hwaddr);
-				DBG_88E("cur_channel =%d, cur_bwmode =%d, cur_ch_offset =%d\n", pmlmeext->cur_channel, pmlmeext->cur_bwmode, pmlmeext->cur_ch_offset);
-				DBG_88E("rtsen =%d, cts2slef =%d\n", psta->rtsen, psta->cts2self);
-				DBG_88E("state = 0x%x, aid =%d, macid =%d, raid =%d\n", psta->state, psta->aid, psta->mac_id, psta->raid);
-				DBG_88E("qos_en =%d, ht_en =%d, init_rate =%d\n", psta->qos_option, psta->htpriv.ht_option, psta->init_rate);
-				DBG_88E("bwmode =%d, ch_offset =%d, sgi =%d\n", psta->htpriv.bwmode, psta->htpriv.ch_offset, psta->htpriv.sgi);
-				DBG_88E("ampdu_enable = %d\n", psta->htpriv.ampdu_enable);
-				DBG_88E("agg_enable_bitmap =%x, candidate_tid_bitmap =%x\n", psta->htpriv.agg_enable_bitmap, psta->htpriv.candidate_tid_bitmap);
-				for (i = 0; i < 16; i++) {
-					preorder_ctrl = &psta->recvreorder_ctrl[i];
-					if (preorder_ctrl->enable)
-						DBG_88E("tid =%d, indicate_seq =%d\n", i, preorder_ctrl->indicate_seq);
-				}
-			} else {
-				DBG_88E("can't get sta's macaddr, cur_network's macaddr:%pM\n", (cur_network->network.MacAddress));
-			}
-			break;
 		case 0x06:
 			{
 				u32	ODMFlag;
 				rtw_hal_get_hwreg(padapter, HW_VAR_DM_FLAG, (u8 *)(&ODMFlag));
-				DBG_88E("(B)DMFlag = 0x%x, arg = 0x%x\n", ODMFlag, arg);
 				ODMFlag = (u32)(0x0f&arg);
-				DBG_88E("(A)DMFlag = 0x%x\n", ODMFlag);
 				rtw_hal_set_hwreg(padapter, HW_VAR_DM_FLAG, (u8 *)(&ODMFlag));
 			}
 			break;
-		case 0x07:
-			DBG_88E("bSurpriseRemoved =%d, bDriverStopped =%d\n",
-				padapter->bSurpriseRemoved, padapter->bDriverStopped);
-			break;
-		case 0x08:
-			{
-				struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
-				struct recv_priv  *precvpriv = &padapter->recvpriv;
-
-				DBG_88E("free_xmitbuf_cnt =%d, free_xmitframe_cnt =%d, free_xmit_extbuf_cnt =%d\n",
-					pxmitpriv->free_xmitbuf_cnt, pxmitpriv->free_xmitframe_cnt, pxmitpriv->free_xmit_extbuf_cnt);
-				DBG_88E("rx_urb_pending_cn =%d\n", precvpriv->rx_pending_cnt);
-			}
-			break;
-		case 0x09:
-			{
-				int i, j;
-				struct list_head *plist, *phead;
-				struct recv_reorder_ctrl *preorder_ctrl;
-
-#ifdef CONFIG_88EU_AP_MODE
-				DBG_88E("sta_dz_bitmap = 0x%x, tim_bitmap = 0x%x\n", pstapriv->sta_dz_bitmap, pstapriv->tim_bitmap);
-#endif
-				spin_lock_bh(&pstapriv->sta_hash_lock);
-
-				for (i = 0; i < NUM_STA; i++) {
-					phead = &(pstapriv->sta_hash[i]);
-					plist = phead->next;
-
-					while (phead != plist) {
-						psta = container_of(plist, struct sta_info, hash_list);
-
-						plist = plist->next;
-
-						if (extra_arg == psta->aid) {
-							DBG_88E("sta's macaddr:%pM\n", (psta->hwaddr));
-							DBG_88E("rtsen =%d, cts2slef =%d\n", psta->rtsen, psta->cts2self);
-							DBG_88E("state = 0x%x, aid =%d, macid =%d, raid =%d\n", psta->state, psta->aid, psta->mac_id, psta->raid);
-							DBG_88E("qos_en =%d, ht_en =%d, init_rate =%d\n", psta->qos_option, psta->htpriv.ht_option, psta->init_rate);
-							DBG_88E("bwmode =%d, ch_offset =%d, sgi =%d\n", psta->htpriv.bwmode, psta->htpriv.ch_offset, psta->htpriv.sgi);
-							DBG_88E("ampdu_enable = %d\n", psta->htpriv.ampdu_enable);
-							DBG_88E("agg_enable_bitmap =%x, candidate_tid_bitmap =%x\n", psta->htpriv.agg_enable_bitmap, psta->htpriv.candidate_tid_bitmap);
-
-#ifdef CONFIG_88EU_AP_MODE
-							DBG_88E("capability = 0x%x\n", psta->capability);
-							DBG_88E("flags = 0x%x\n", psta->flags);
-							DBG_88E("wpa_psk = 0x%x\n", psta->wpa_psk);
-							DBG_88E("wpa2_group_cipher = 0x%x\n", psta->wpa2_group_cipher);
-							DBG_88E("wpa2_pairwise_cipher = 0x%x\n", psta->wpa2_pairwise_cipher);
-							DBG_88E("qos_info = 0x%x\n", psta->qos_info);
-#endif
-							DBG_88E("dot118021XPrivacy = 0x%x\n", psta->dot118021XPrivacy);
-
-							for (j = 0; j < 16; j++) {
-								preorder_ctrl = &psta->recvreorder_ctrl[j];
-								if (preorder_ctrl->enable)
-									DBG_88E("tid =%d, indicate_seq =%d\n", j, preorder_ctrl->indicate_seq);
-							}
-						}
-					}
-				}
-				spin_unlock_bh(&pstapriv->sta_hash_lock);
-			}
-			break;
 		case 0x0c:/* dump rx/tx packet */
-			if (arg == 0) {
-				DBG_88E("dump rx packet (%d)\n", extra_arg);
+			if (arg == 0)
 				rtw_hal_set_def_var(padapter, HAL_DEF_DBG_DUMP_RXPKT, &(extra_arg));
-			} else if (arg == 1) {
-				DBG_88E("dump tx packet (%d)\n", extra_arg);
+			else if (arg == 1)
 				rtw_hal_set_def_var(padapter, HAL_DEF_DBG_DUMP_TXPKT, &(extra_arg));
-			}
 			break;
 		case 0x0f:
-			if (extra_arg == 0) {
-				DBG_88E("###### silent reset test.......#####\n");
+			if (extra_arg == 0)
 				rtw_hal_sreset_reset(padapter);
-			}
-			break;
-		case 0x15:
-			{
-				struct pwrctrl_priv *pwrpriv = &padapter->pwrctrlpriv;
-				DBG_88E("==>silent resete cnts:%d\n", pwrpriv->ips_enter_cnts);
-			}
-			break;
-		case 0x10:/*  driver version display */
-			DBG_88E("rtw driver version =%s\n", DRIVERVERSION);
 			break;
 		case 0x11:
-			DBG_88E("turn %s Rx RSSI display function\n", (extra_arg == 1) ? "on" : "off");
 			padapter->bRxRSSIDisplay = extra_arg;
 			break;
 		case 0x12: /* set rx_stbc */
@@ -4467,9 +4054,6 @@ static int rtw_dbg_port(struct net_device *dev,
 			     extra_arg == 2 ||
 			     extra_arg == 3)) {
 				pregpriv->rx_stbc = extra_arg;
-				DBG_88E("set rx_stbc =%d\n", pregpriv->rx_stbc);
-			} else {
-				DBG_88E("get rx_stbc =%d\n", pregpriv->rx_stbc);
 			}
 		}
 			break;
@@ -4479,32 +4063,20 @@ static int rtw_dbg_port(struct net_device *dev,
 			/*  0: disable, 0x1:enable (but wifi_spec should be 0), 0x2: force enable (don't care wifi_spec) */
 			if (pregpriv && extra_arg >= 0 && extra_arg < 3) {
 				pregpriv->ampdu_enable = extra_arg;
-				DBG_88E("set ampdu_enable =%d\n", pregpriv->ampdu_enable);
-			} else {
-				DBG_88E("get ampdu_enable =%d\n", pregpriv->ampdu_enable);
 			}
 		}
 			break;
-		case 0x14: /* get wifi_spec */
-		{
-			struct registry_priv	*pregpriv = &padapter->registrypriv;
-			DBG_88E("get wifi_spec =%d\n", pregpriv->wifi_spec);
-		}
-			break;
 		case 0x23:
-			DBG_88E("turn %s the bNotifyChannelChange Variable\n", (extra_arg == 1) ? "on" : "off");
 			padapter->bNotifyChannelChange = extra_arg;
 			break;
 		case 0x24:
 #ifdef CONFIG_88EU_P2P
-			DBG_88E("turn %s the bShowGetP2PState Variable\n", (extra_arg == 1) ? "on" : "off");
 			padapter->bShowGetP2PState = extra_arg;
 #endif /*  CONFIG_88EU_P2P */
 			break;
 		case 0xaa:
 			if (extra_arg > 0x13)
 				extra_arg = 0xFF;
-			DBG_88E("chang data rate to :0x%02x\n", extra_arg);
 			padapter->fix_rate = extra_arg;
 			break;
 		case 0xdd:/* registers dump, 0 for mac reg, 1 for bb reg, 2 for rf reg */
@@ -4521,14 +4093,6 @@ static int rtw_dbg_port(struct net_device *dev,
 
 				if (0xf == extra_arg) {
 					rtw_hal_get_def_var(padapter, HAL_DEF_DBG_DM_FUNC, &odm_flag);
-					DBG_88E(" === DMFlag(0x%08x) ===\n", odm_flag);
-					DBG_88E("extra_arg = 0  - disable all dynamic func\n");
-					DBG_88E("extra_arg = 1  - disable DIG- BIT(0)\n");
-					DBG_88E("extra_arg = 2  - disable High power - BIT(1)\n");
-					DBG_88E("extra_arg = 3  - disable tx power tracking - BIT(2)\n");
-					DBG_88E("extra_arg = 4  - disable BT coexistence - BIT(3)\n");
-					DBG_88E("extra_arg = 5  - disable antenna diversity - BIT(4)\n");
-					DBG_88E("extra_arg = 6  - enable all dynamic func\n");
 				} else {
 					/*	extra_arg = 0  - disable all dynamic func
 						extra_arg = 1  - disable DIG
@@ -4537,51 +4101,17 @@ static int rtw_dbg_port(struct net_device *dev,
 					*/
 					rtw_hal_set_def_var(padapter, HAL_DEF_DBG_DM_FUNC, &(extra_arg));
 					rtw_hal_get_def_var(padapter, HAL_DEF_DBG_DM_FUNC, &odm_flag);
-					DBG_88E(" === DMFlag(0x%08x) ===\n", odm_flag);
 				}
 			}
 			break;
 
 		case 0xfd:
 			rtw_write8(padapter, 0xc50, arg);
-			DBG_88E("wr(0xc50) = 0x%x\n", rtw_read8(padapter, 0xc50));
 			rtw_write8(padapter, 0xc58, arg);
-			DBG_88E("wr(0xc58) = 0x%x\n", rtw_read8(padapter, 0xc58));
-			break;
-		case 0xfe:
-			DBG_88E("rd(0xc50) = 0x%x\n", rtw_read8(padapter, 0xc50));
-			DBG_88E("rd(0xc58) = 0x%x\n", rtw_read8(padapter, 0xc58));
-			break;
-		case 0xff:
-			DBG_88E("dbg(0x210) = 0x%x\n", rtw_read32(padapter, 0x210));
-			DBG_88E("dbg(0x608) = 0x%x\n", rtw_read32(padapter, 0x608));
-			DBG_88E("dbg(0x280) = 0x%x\n", rtw_read32(padapter, 0x280));
-			DBG_88E("dbg(0x284) = 0x%x\n", rtw_read32(padapter, 0x284));
-			DBG_88E("dbg(0x288) = 0x%x\n", rtw_read32(padapter, 0x288));
-
-			DBG_88E("dbg(0x664) = 0x%x\n", rtw_read32(padapter, 0x664));
-
-			DBG_88E("\n");
-
-			DBG_88E("dbg(0x430) = 0x%x\n", rtw_read32(padapter, 0x430));
-			DBG_88E("dbg(0x438) = 0x%x\n", rtw_read32(padapter, 0x438));
-
-			DBG_88E("dbg(0x440) = 0x%x\n", rtw_read32(padapter, 0x440));
-
-			DBG_88E("dbg(0x458) = 0x%x\n", rtw_read32(padapter, 0x458));
-
-			DBG_88E("dbg(0x484) = 0x%x\n", rtw_read32(padapter, 0x484));
-			DBG_88E("dbg(0x488) = 0x%x\n", rtw_read32(padapter, 0x488));
-
-			DBG_88E("dbg(0x444) = 0x%x\n", rtw_read32(padapter, 0x444));
-			DBG_88E("dbg(0x448) = 0x%x\n", rtw_read32(padapter, 0x448));
-			DBG_88E("dbg(0x44c) = 0x%x\n", rtw_read32(padapter, 0x44c));
-			DBG_88E("dbg(0x450) = 0x%x\n", rtw_read32(padapter, 0x450));
 			break;
 		}
 		break;
 	default:
-		DBG_88E("error dbg cmd!\n");
 		break;
 	}
 	return ret;
@@ -4605,8 +4135,6 @@ static int wpa_set_param(struct net_device *dev, u8 name, u32 value)
 			padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption3Enabled;
 			break;
 		}
-		RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_info_,
-			 ("wpa_set_param:padapter->securitypriv.ndisauthtype =%d\n", padapter->securitypriv.ndisauthtype));
 		break;
 	case IEEE_PARAM_TKIP_COUNTERMEASURES:
 		break;
@@ -4705,7 +4233,6 @@ static int wpa_supplicant_ioctl(struct net_device *dev, struct iw_point *p)
 		break;
 
 	default:
-		DBG_88E("Unknown WPA supplicant request: %d\n", param->cmd);
 		ret = -EOPNOTSUPP;
 		break;
 	}
@@ -4764,8 +4291,6 @@ static int set_group_key(struct adapter *padapter, u8 *key, u8 alg, int keyid)
 	struct cmd_priv	*pcmdpriv = &(padapter->cmdpriv);
 	int res = _SUCCESS;
 
-	DBG_88E("%s\n", __func__);
-
 	pcmd = (struct cmd_obj *)rtw_zmalloc(sizeof(struct	cmd_obj));
 	if (!pcmd) {
 		res = _FAIL;
@@ -4846,7 +4371,6 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,
 	struct security_priv *psecuritypriv = &(padapter->securitypriv);
 	struct sta_priv *pstapriv = &padapter->stapriv;
 
-	DBG_88E("%s\n", __func__);
 	param->u.crypt.err = 0;
 	param->u.crypt.alg[IEEE_CRYPT_ALG_NAME_LEN - 1] = '\0';
 	if (param_len !=  sizeof(struct ieee_param) + param->u.crypt.key_len) {
@@ -4863,22 +4387,17 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,
 	} else {
 		psta = rtw_get_stainfo(pstapriv, param->sta_addr);
 		if (!psta) {
-			DBG_88E("rtw_set_encryption(), sta has already been removed or never been added\n");
 			goto exit;
 		}
 	}
 
 	if (strcmp(param->u.crypt.alg, "none") == 0 && !psta) {
 		/* todo:clear default encryption keys */
-
-		DBG_88E("clear default encryption keys, keyid =%d\n", param->u.crypt.idx);
 		goto exit;
 	}
 	if (strcmp(param->u.crypt.alg, "WEP") == 0 && !psta) {
-		DBG_88E("r871x_set_encryption, crypt.alg = WEP\n");
 		wep_key_idx = param->u.crypt.idx;
 		wep_key_len = param->u.crypt.key_len;
-		DBG_88E("r871x_set_encryption, wep_key_idx=%d, len=%d\n", wep_key_idx, wep_key_len);
 		if ((wep_key_idx >= WEP_KEYS) || (wep_key_len <= 0)) {
 			ret = -EINVAL;
 			goto exit;
@@ -4888,10 +4407,8 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,
 			wep_key_len = wep_key_len <= 5 ? 5 : 13;
 			wep_total_len = wep_key_len + FIELD_OFFSET(struct ndis_802_11_wep, KeyMaterial);
 			pwep = (struct ndis_802_11_wep *)rtw_malloc(wep_total_len);
-			if (!pwep) {
-				DBG_88E(" r871x_set_encryption: pwep allocate fail !!!\n");
+			if (!pwep)
 				goto exit;
-			}
 
 			memset(pwep, 0, wep_total_len);
 
@@ -4904,8 +4421,6 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,
 		memcpy(pwep->KeyMaterial,  param->u.crypt.key, pwep->KeyLength);
 
 		if (param->u.crypt.set_tx) {
-			DBG_88E("wep, set_tx = 1\n");
-
 			psecuritypriv->ndisencryptstatus = Ndis802_11Encryption1Enabled;
 			psecuritypriv->dot11PrivacyAlgrthm = _WEP40_;
 			psecuritypriv->dot118021XGrpPrivacy = _WEP40_;
@@ -4923,8 +4438,6 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,
 
 			set_wep_key(padapter, pwep->KeyMaterial, pwep->KeyLength, wep_key_idx);
 		} else {
-			DBG_88E("wep, set_tx = 0\n");
-
 			/* don't update "psecuritypriv->dot11PrivacyAlgrthm" and */
 			/* psecuritypriv->dot11PrivacyKeyIndex = keyid", but can rtw_set_key to cam */
 
@@ -4941,8 +4454,6 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,
 	if (!psta && check_fwstate(pmlmepriv, WIFI_AP_STATE)) { /*  group key */
 		if (param->u.crypt.set_tx == 1) {
 			if (strcmp(param->u.crypt.alg, "WEP") == 0) {
-				DBG_88E("%s, set group_key, WEP\n", __func__);
-
 				memcpy(psecuritypriv->dot118021XGrpKey[param->u.crypt.idx].skey,
 					    param->u.crypt.key, (param->u.crypt.key_len > 16 ? 16 : param->u.crypt.key_len));
 
@@ -4950,7 +4461,6 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,
 				if (param->u.crypt.key_len == 13)
 						psecuritypriv->dot118021XGrpPrivacy = _WEP104_;
 			} else if (strcmp(param->u.crypt.alg, "TKIP") == 0) {
-				DBG_88E("%s, set group_key, TKIP\n", __func__);
 				psecuritypriv->dot118021XGrpPrivacy = _TKIP_;
 				memcpy(psecuritypriv->dot118021XGrpKey[param->u.crypt.idx].skey,
 					    param->u.crypt.key, (param->u.crypt.key_len > 16 ? 16 : param->u.crypt.key_len));
@@ -4960,12 +4470,10 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,
 
 				psecuritypriv->busetkipkey = true;
 			} else if (strcmp(param->u.crypt.alg, "CCMP") == 0) {
-				DBG_88E("%s, set group_key, CCMP\n", __func__);
 				psecuritypriv->dot118021XGrpPrivacy = _AES_;
 				memcpy(psecuritypriv->dot118021XGrpKey[param->u.crypt.idx].skey,
 					    param->u.crypt.key, (param->u.crypt.key_len > 16 ? 16 : param->u.crypt.key_len));
 			} else {
-				DBG_88E("%s, set group_key, none\n", __func__);
 				psecuritypriv->dot118021XGrpPrivacy = _NO_PRIVACY_;
 			}
 			psecuritypriv->dot118021XGrpKeyid = param->u.crypt.idx;
@@ -4987,14 +4495,10 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,
 				memcpy(psta->dot118021x_UncstKey.skey,  param->u.crypt.key, (param->u.crypt.key_len > 16 ? 16 : param->u.crypt.key_len));
 
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
@@ -5003,12 +4507,8 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,
 
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
 
@@ -5074,8 +4574,6 @@ static int rtw_set_beacon(struct net_device *dev, struct ieee_param *param, int
 	struct sta_priv *pstapriv = &padapter->stapriv;
 	unsigned char *pbuf = param->u.bcn_ie.buf;
 
-	DBG_88E("%s, len =%d\n", __func__, len);
-
 	if (check_fwstate(pmlmepriv, WIFI_AP_STATE) != true)
 		return -EINVAL;
 
@@ -5097,8 +4595,6 @@ static int rtw_hostapd_sta_flush(struct net_device *dev)
 	int ret = 0;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 
-	DBG_88E("%s\n", __func__);
-
 	flush_all_cam_entry(padapter);	/* clear CAM */
 
 	ret = rtw_sta_flush(padapter);
@@ -5114,8 +4610,6 @@ static int rtw_add_sta(struct net_device *dev, struct ieee_param *param)
 	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
 	struct sta_priv *pstapriv = &padapter->stapriv;
 
-	DBG_88E("rtw_add_sta(aid =%d) =%pM\n", param->u.add_sta.aid, (param->sta_addr));
-
 	if (!check_fwstate(pmlmepriv, (_FW_LINKED|WIFI_AP_STATE)))
 		return -EINVAL;
 
@@ -5170,8 +4664,6 @@ static int rtw_del_sta(struct net_device *dev, struct ieee_param *param)
 	struct sta_priv *pstapriv = &padapter->stapriv;
 	int updated = 0;
 
-	DBG_88E("rtw_del_sta =%pM\n", (param->sta_addr));
-
 	if (check_fwstate(pmlmepriv, (_FW_LINKED|WIFI_AP_STATE)) != true)
 		return -EINVAL;
 
@@ -5191,8 +4683,6 @@ static int rtw_del_sta(struct net_device *dev, struct ieee_param *param)
 		spin_unlock_bh(&pstapriv->asoc_list_lock);
 		associated_clients_update(padapter, updated);
 		psta = NULL;
-	} else {
-		DBG_88E("rtw_del_sta(), sta has already been removed or never been added\n");
 	}
 
 	return ret;
@@ -5208,8 +4698,6 @@ static int rtw_ioctl_get_sta_data(struct net_device *dev, struct ieee_param *par
 	struct ieee_param_ex *param_ex = (struct ieee_param_ex *)param;
 	struct sta_data *psta_data = (struct sta_data *)param_ex->data;
 
-	DBG_88E("rtw_ioctl_get_sta_info, sta_addr: %pM\n", (param_ex->sta_addr));
-
 	if (check_fwstate(pmlmepriv, (_FW_LINKED|WIFI_AP_STATE)) != true)
 		return -EINVAL;
 
@@ -5263,8 +4751,6 @@ static int rtw_get_sta_wpaie(struct net_device *dev, struct ieee_param *param)
 	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
 	struct sta_priv *pstapriv = &padapter->stapriv;
 
-	DBG_88E("rtw_get_sta_wpaie, sta_addr: %pM\n", (param->sta_addr));
-
 	if (check_fwstate(pmlmepriv, (_FW_LINKED|WIFI_AP_STATE)) != true)
 		return -EINVAL;
 
@@ -5283,8 +4769,6 @@ static int rtw_get_sta_wpaie(struct net_device *dev, struct ieee_param *param)
 			copy_len = ((wpa_ie_len+2) > sizeof(psta->wpa_ie)) ? (sizeof(psta->wpa_ie)) : (wpa_ie_len+2);
 			param->u.wpa_ie.len = copy_len;
 			memcpy(param->u.wpa_ie.reserved, psta->wpa_ie, copy_len);
-		} else {
-			DBG_88E("sta's wpa_ie is NONE\n");
 		}
 	} else {
 		ret = -1;
@@ -5302,8 +4786,6 @@ static int rtw_set_wps_beacon(struct net_device *dev, struct ieee_param *param,
 	struct mlme_ext_priv	*pmlmeext = &(padapter->mlmeextpriv);
 	int ie_len;
 
-	DBG_88E("%s, len =%d\n", __func__, len);
-
 	if (check_fwstate(pmlmepriv, WIFI_AP_STATE) != true)
 		return -EINVAL;
 
@@ -5317,10 +4799,8 @@ static int rtw_set_wps_beacon(struct net_device *dev, struct ieee_param *param,
 	if (ie_len > 0) {
 		pmlmepriv->wps_beacon_ie = rtw_malloc(ie_len);
 		pmlmepriv->wps_beacon_ie_len = ie_len;
-		if (!pmlmepriv->wps_beacon_ie) {
-			DBG_88E("%s()-%d: rtw_malloc() ERROR!\n", __func__, __LINE__);
+		if (!pmlmepriv->wps_beacon_ie)
 			return -EINVAL;
-		}
 
 		memcpy(pmlmepriv->wps_beacon_ie, param->u.bcn_ie.buf, ie_len);
 
@@ -5339,8 +4819,6 @@ static int rtw_set_wps_probe_resp(struct net_device *dev, struct ieee_param *par
 	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
 	int ie_len;
 
-	DBG_88E("%s, len =%d\n", __func__, len);
-
 	if (check_fwstate(pmlmepriv, WIFI_AP_STATE) != true)
 		return -EINVAL;
 
@@ -5354,10 +4832,9 @@ static int rtw_set_wps_probe_resp(struct net_device *dev, struct ieee_param *par
 	if (ie_len > 0) {
 		pmlmepriv->wps_probe_resp_ie = rtw_malloc(ie_len);
 		pmlmepriv->wps_probe_resp_ie_len = ie_len;
-		if (!pmlmepriv->wps_probe_resp_ie) {
-			DBG_88E("%s()-%d: rtw_malloc() ERROR!\n", __func__, __LINE__);
+		if (!pmlmepriv->wps_probe_resp_ie)
 			return -EINVAL;
-		}
+
 		memcpy(pmlmepriv->wps_probe_resp_ie, param->u.bcn_ie.buf, ie_len);
 	}
 
@@ -5371,8 +4848,6 @@ static int rtw_set_wps_assoc_resp(struct net_device *dev, struct ieee_param *par
 	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
 	int ie_len;
 
-	DBG_88E("%s, len =%d\n", __func__, len);
-
 	if (check_fwstate(pmlmepriv, WIFI_AP_STATE) != true)
 		return -EINVAL;
 
@@ -5386,10 +4861,8 @@ static int rtw_set_wps_assoc_resp(struct net_device *dev, struct ieee_param *par
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
@@ -5410,14 +4883,11 @@ static int rtw_set_hidden_ssid(struct net_device *dev, struct ieee_param *param,
 	if (check_fwstate(pmlmepriv, WIFI_AP_STATE) != true)
 		return -EINVAL;
 
-	if (param->u.wpa_param.name != 0) /* dummy test... */
-		DBG_88E("%s name(%u) != 0\n", __func__, param->u.wpa_param.name);
 	value = param->u.wpa_param.value;
 
 	/* use the same definition of hostapd's ignore_broadcast_ssid */
 	if (value != 1 && value != 2)
 		value = 0;
-	DBG_88E("%s value(%u)\n", __func__, value);
 	pmlmeinfo->hidden_ssid_mode = value;
 	return ret;
 }
@@ -5633,8 +5103,6 @@ static int rtw_pm_set(struct net_device *dev,
 	unsigned	mode = 0;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 
-	DBG_88E("[%s] extra = %s\n", __func__, extra);
-
 	if (!memcmp(extra, "lps =", 4)) {
 		sscanf(extra+4, "%u", &mode);
 		ret = rtw_pm_set_lps(padapter, mode);
@@ -5696,7 +5164,6 @@ static int rtw_mp_efuse_get(struct net_device *dev,
 	rtw_pm_set_ips(padapter, IPS_NONE);
 
 	pch = extra;
-	DBG_88E("%s: in =%s\n", __func__, extra);
 
 	i = 0;
 	/* mac 16 "00e04c871200" rmap, 00, 2 */
@@ -5728,7 +5195,6 @@ static int rtw_mp_efuse_get(struct net_device *dev,
 	} else if (strcmp(tmp[0], "realmap") == 0) {
 		mapLen = EFUSE_MAP_SIZE;
 		if (rtw_efuse_map_read(padapter, 0, mapLen, pEfuseHal->fakeEfuseInitMap) == _FAIL) {
-			DBG_88E("%s: read realmap Fail!!\n", __func__);
 			err = -EFAULT;
 			goto exit;
 		}
@@ -5745,32 +5211,26 @@ static int rtw_mp_efuse_get(struct net_device *dev,
 		}
 	} else if (strcmp(tmp[0], "rmap") == 0) {
 		if (!tmp[1] || !tmp[2]) {
-			DBG_88E("%s: rmap Fail!! Parameters error!\n", __func__);
 			err = -EINVAL;
 			goto exit;
 		}
 
 		/*  rmap addr cnts */
 		addr = simple_strtoul(tmp[1], &ptmp, 16);
-		DBG_88E("%s: addr =%x\n", __func__, addr);
 
 		cnts = simple_strtoul(tmp[2], &ptmp, 10);
 		if (cnts == 0) {
-			DBG_88E("%s: rmap Fail!! cnts error!\n", __func__);
 			err = -EINVAL;
 			goto exit;
 		}
-		DBG_88E("%s: cnts =%d\n", __func__, cnts);
 
 		EFUSE_GetEfuseDefinition(padapter, EFUSE_WIFI, TYPE_AVAILABLE_EFUSE_BYTES_TOTAL, (void *)&max_available_size, false);
 		if ((addr + cnts) > max_available_size) {
-			DBG_88E("%s: addr(0x%X)+cnts(%d) parameter error!\n", __func__, addr, cnts);
 			err = -EINVAL;
 			goto exit;
 		}
 
 		if (rtw_efuse_map_read(padapter, addr, cnts, data) == _FAIL) {
-			DBG_88E("%s: rtw_efuse_map_read error!\n", __func__);
 			err = -EFAULT;
 			goto exit;
 		}
@@ -5782,7 +5242,6 @@ static int rtw_mp_efuse_get(struct net_device *dev,
 		addr = 0;
 		mapLen = EFUSE_MAX_SIZE;
 		if (rtw_efuse_access(padapter, false, addr, mapLen, rawdata) == _FAIL) {
-			DBG_88E("%s: rtw_efuse_access Fail!!\n", __func__);
 			err = -EFAULT;
 			goto exit;
 		}
@@ -5803,13 +5262,11 @@ static int rtw_mp_efuse_get(struct net_device *dev,
 
 		EFUSE_GetEfuseDefinition(padapter, EFUSE_WIFI, TYPE_AVAILABLE_EFUSE_BYTES_TOTAL, (void *)&max_available_size, false);
 		if ((addr + cnts) > max_available_size) {
-			DBG_88E("%s: addr(0x%02x)+cnts(%d) parameter error!\n", __func__, addr, cnts);
 			err = -EFAULT;
 			goto exit;
 		}
 
 		if (rtw_efuse_map_read(padapter, addr, cnts, data) == _FAIL) {
-			DBG_88E("%s: rtw_efuse_map_read error!\n", __func__);
 			err = -EFAULT;
 			goto exit;
 		}
@@ -5825,12 +5282,10 @@ static int rtw_mp_efuse_get(struct net_device *dev,
 
 		EFUSE_GetEfuseDefinition(padapter, EFUSE_WIFI, TYPE_AVAILABLE_EFUSE_BYTES_TOTAL, (void *)&max_available_size, false);
 		if ((addr + cnts) > max_available_size) {
-			DBG_88E("%s: addr(0x%02x)+cnts(%d) parameter error!\n", __func__, addr, cnts);
 			err = -EFAULT;
 			goto exit;
 		}
 		if (rtw_efuse_map_read(padapter, addr, cnts, data) == _FAIL) {
-			DBG_88E("%s: rtw_efuse_access error!!\n", __func__);
 			err = -EFAULT;
 			goto exit;
 		}
@@ -5848,7 +5303,6 @@ static int rtw_mp_efuse_get(struct net_device *dev,
 	} else if (strcmp(tmp[0], "btfmap") == 0) {
 		mapLen = EFUSE_BT_MAX_MAP_LEN;
 		if (rtw_BT_efuse_map_read(padapter, 0, mapLen, pEfuseHal->BTEfuseInitMap) == _FAIL) {
-			DBG_88E("%s: rtw_BT_efuse_map_read Fail!!\n", __func__);
 			err = -EFAULT;
 			goto exit;
 		}
@@ -5867,7 +5321,6 @@ static int rtw_mp_efuse_get(struct net_device *dev,
 	} else if (strcmp(tmp[0], "btbmap") == 0) {
 		mapLen = EFUSE_BT_MAX_MAP_LEN;
 		if (rtw_BT_efuse_map_read(padapter, 0, mapLen, pEfuseHal->BTEfuseInitMap) == _FAIL) {
-			DBG_88E("%s: rtw_BT_efuse_map_read Fail!!\n", __func__);
 			err = -EFAULT;
 			goto exit;
 		}
@@ -5890,25 +5343,20 @@ static int rtw_mp_efuse_get(struct net_device *dev,
 
 		/*  rmap addr cnts */
 		addr = simple_strtoul(tmp[1], &ptmp, 16);
-		DBG_88E("%s: addr = 0x%X\n", __func__, addr);
 
 		cnts = simple_strtoul(tmp[2], &ptmp, 10);
 		if (cnts == 0) {
-			DBG_88E("%s: btrmap Fail!! cnts error!\n", __func__);
 			err = -EINVAL;
 			goto exit;
 		}
-		DBG_88E("%s: cnts =%d\n", __func__, cnts);
 
 		EFUSE_GetEfuseDefinition(padapter, EFUSE_BT, TYPE_AVAILABLE_EFUSE_BYTES_TOTAL, (void *)&max_available_size, false);
 		if ((addr + cnts) > max_available_size) {
-			DBG_88E("%s: addr(0x%X)+cnts(%d) parameter error!\n", __func__, addr, cnts);
 			err = -EFAULT;
 			goto exit;
 		}
 
 		if (rtw_BT_efuse_map_read(padapter, addr, cnts, data) == _FAIL) {
-			DBG_88E("%s: rtw_BT_efuse_map_read error!!\n", __func__);
 			err = -EFAULT;
 			goto exit;
 		}
@@ -6017,7 +5465,6 @@ static int rtw_mp_efuse_set(struct net_device *dev,
 	rtw_pm_set_ips(padapter, IPS_NONE);
 
 	pch = extra;
-	DBG_88E("%s: in =%s\n", __func__, extra);
 
 	i = 0;
 	while ((token = strsep(&pch, ",")) != NULL) {
@@ -6049,22 +5496,16 @@ static int rtw_mp_efuse_set(struct net_device *dev,
 			goto exit;
 		}
 
-		DBG_88E("%s: addr = 0x%X\n", __func__, addr);
-		DBG_88E("%s: cnts =%d\n", __func__, cnts);
-		DBG_88E("%s: map data =%s\n", __func__, tmp[2]);
-
 		for (jj = 0, kk = 0; jj < cnts; jj++, kk += 2)
 			setdata[jj] = key_2char2num(tmp[2][kk], tmp[2][kk + 1]);
 		/* Change to check TYPE_EFUSE_MAP_LEN, because 8188E raw 256, logic map over 256. */
 		EFUSE_GetEfuseDefinition(padapter, EFUSE_WIFI, TYPE_EFUSE_MAP_LEN, (void *)&max_available_size, false);
 		if ((addr+cnts) > max_available_size) {
-			DBG_88E("%s: addr(0x%X)+cnts(%d) parameter error!\n", __func__, addr, cnts);
 			err = -EFAULT;
 			goto exit;
 		}
 
 		if (rtw_efuse_map_write(padapter, addr, cnts, setdata) == _FAIL) {
-			DBG_88E("%s: rtw_efuse_map_write error!!\n", __func__);
 			err = -EFAULT;
 			goto exit;
 		}
@@ -6088,15 +5529,10 @@ static int rtw_mp_efuse_set(struct net_device *dev,
 			goto exit;
 		}
 
-		DBG_88E("%s: addr = 0x%X\n", __func__, addr);
-		DBG_88E("%s: cnts =%d\n", __func__, cnts);
-		DBG_88E("%s: raw data =%s\n", __func__, tmp[2]);
-
 		for (jj = 0, kk = 0; jj < cnts; jj++, kk += 2)
 			setrawdata[jj] = key_2char2num(tmp[2][kk], tmp[2][kk + 1]);
 
 		if (rtw_efuse_access(padapter, true, addr, cnts, setrawdata) == _FAIL) {
-			DBG_88E("%s: rtw_efuse_access error!!\n", __func__);
 			err = -EFAULT;
 			goto exit;
 		}
@@ -6119,27 +5555,20 @@ static int rtw_mp_efuse_set(struct net_device *dev,
 			goto exit;
 		}
 		if (cnts > 6) {
-			DBG_88E("%s: error data for mac addr =\"%s\"\n", __func__, tmp[1]);
 			err = -EFAULT;
 			goto exit;
 		}
 
-		DBG_88E("%s: addr = 0x%X\n", __func__, addr);
-		DBG_88E("%s: cnts =%d\n", __func__, cnts);
-		DBG_88E("%s: MAC address =%s\n", __func__, tmp[1]);
-
 		for (jj = 0, kk = 0; jj < cnts; jj++, kk += 2)
 			setdata[jj] = key_2char2num(tmp[1][kk], tmp[1][kk + 1]);
 		/* Change to check TYPE_EFUSE_MAP_LEN, because 8188E raw 256, logic map over 256. */
 		EFUSE_GetEfuseDefinition(padapter, EFUSE_WIFI, TYPE_EFUSE_MAP_LEN, (void *)&max_available_size, false);
 		if ((addr+cnts) > max_available_size) {
-			DBG_88E("%s: addr(0x%X)+cnts(%d) parameter error!\n", __func__, addr, cnts);
 			err = -EFAULT;
 			goto exit;
 		}
 
 		if (rtw_efuse_map_write(padapter, addr, cnts, setdata) == _FAIL) {
-			DBG_88E("%s: rtw_efuse_map_write error!!\n", __func__);
 			err = -EFAULT;
 			goto exit;
 		}
@@ -6162,22 +5591,16 @@ static int rtw_mp_efuse_set(struct net_device *dev,
 			goto exit;
 		}
 
-		DBG_88E("%s: addr = 0x%X\n", __func__, addr);
-		DBG_88E("%s: cnts =%d\n", __func__, cnts);
-		DBG_88E("%s: VID/PID =%s\n", __func__, tmp[1]);
-
 		for (jj = 0, kk = 0; jj < cnts; jj++, kk += 2)
 			setdata[jj] = key_2char2num(tmp[1][kk], tmp[1][kk + 1]);
 
 		EFUSE_GetEfuseDefinition(padapter, EFUSE_WIFI, TYPE_AVAILABLE_EFUSE_BYTES_TOTAL, (void *)&max_available_size, false);
 		if ((addr+cnts) > max_available_size) {
-			DBG_88E("%s: addr(0x%X)+cnts(%d) parameter error!\n", __func__, addr, cnts);
 			err = -EFAULT;
 			goto exit;
 		}
 
 		if (rtw_efuse_map_write(padapter, addr, cnts, setdata) == _FAIL) {
-			DBG_88E("%s: rtw_efuse_map_write error!!\n", __func__);
 			err = -EFAULT;
 			goto exit;
 		}
@@ -6201,22 +5624,16 @@ static int rtw_mp_efuse_set(struct net_device *dev,
 			goto exit;
 		}
 
-		DBG_88E("%s: addr = 0x%X\n", __func__, addr);
-		DBG_88E("%s: cnts =%d\n", __func__, cnts);
-		DBG_88E("%s: BT data =%s\n", __func__, tmp[2]);
-
 		for (jj = 0, kk = 0; jj < cnts; jj++, kk += 2)
 			setdata[jj] = key_2char2num(tmp[2][kk], tmp[2][kk + 1]);
 
 		EFUSE_GetEfuseDefinition(padapter, EFUSE_BT, TYPE_AVAILABLE_EFUSE_BYTES_TOTAL, (void *)&max_available_size, false);
 		if ((addr+cnts) > max_available_size) {
-			DBG_88E("%s: addr(0x%X)+cnts(%d) parameter error!\n", __func__, addr, cnts);
 			err = -EFAULT;
 			goto exit;
 		}
 
 		if (rtw_BT_efuse_map_write(padapter, addr, cnts, setdata) == _FAIL) {
-			DBG_88E("%s: rtw_BT_efuse_map_write error!!\n", __func__);
 			err = -EFAULT;
 			goto exit;
 		}
@@ -6240,26 +5657,14 @@ static int rtw_mp_efuse_set(struct net_device *dev,
 			goto exit;
 		}
 
-		DBG_88E("%s: addr = 0x%X\n", __func__, addr);
-		DBG_88E("%s: cnts =%d\n", __func__, cnts);
-		DBG_88E("%s: BT tmp data =%s\n", __func__, tmp[2]);
-
 		for (jj = 0, kk = 0; jj < cnts; jj++, kk += 2)
 			pEfuseHal->fakeBTEfuseModifiedMap[addr+jj] = key_2char2num(tmp[2][kk], tmp[2][kk + 1]);
 	} else if (strcmp(tmp[0], "btdumpfake") == 0) {
-		if (rtw_BT_efuse_map_read(padapter, 0, EFUSE_BT_MAX_MAP_LEN, pEfuseHal->fakeBTEfuseModifiedMap) == _SUCCESS) {
-			DBG_88E("%s: BT read all map success\n", __func__);
-		} else {
-			DBG_88E("%s: BT read all map Fail!\n", __func__);
+		if (rtw_BT_efuse_map_read(padapter, 0, EFUSE_BT_MAX_MAP_LEN, pEfuseHal->fakeBTEfuseModifiedMap) != _SUCCESS)
 			err = -EFAULT;
-		}
 	} else if (strcmp(tmp[0], "wldumpfake") == 0) {
-		if (rtw_efuse_map_read(padapter, 0, EFUSE_BT_MAX_MAP_LEN,  pEfuseHal->fakeEfuseModifiedMap) == _SUCCESS) {
-			DBG_88E("%s: BT read all map success\n", __func__);
-		} else {
-			DBG_88E("%s: BT read all map  Fail\n", __func__);
+		if (rtw_efuse_map_read(padapter, 0, EFUSE_BT_MAX_MAP_LEN,  pEfuseHal->fakeEfuseModifiedMap) != _SUCCESS)
 			err = -EFAULT;
-		}
 	} else if (strcmp(tmp[0], "btfk2map") == 0) {
 		memcpy(pEfuseHal->BTEfuseModifiedMap, pEfuseHal->fakeBTEfuseModifiedMap, EFUSE_BT_MAX_MAP_LEN);
 
@@ -6270,7 +5675,6 @@ static int rtw_mp_efuse_set(struct net_device *dev,
 		}
 
 		if (rtw_BT_efuse_map_write(padapter, 0x00, EFUSE_BT_MAX_MAP_LEN, pEfuseHal->fakeBTEfuseModifiedMap) == _FAIL) {
-			DBG_88E("%s: rtw_BT_efuse_map_write error!\n", __func__);
 			err = -EFAULT;
 			goto exit;
 		}
@@ -6282,7 +5686,6 @@ static int rtw_mp_efuse_set(struct net_device *dev,
 		}
 
 		if (rtw_efuse_map_write(padapter, 0x00, EFUSE_MAX_MAP_LEN, pEfuseHal->fakeEfuseModifiedMap) == _FAIL) {
-			DBG_88E("%s: rtw_efuse_map_write error!\n", __func__);
 			err = -EFAULT;
 			goto exit;
 		}
@@ -6306,10 +5709,6 @@ static int rtw_mp_efuse_set(struct net_device *dev,
 			goto exit;
 		}
 
-		DBG_88E("%s: addr = 0x%X\n", __func__, addr);
-		DBG_88E("%s: cnts =%d\n", __func__, cnts);
-		DBG_88E("%s: map tmp data =%s\n", __func__, tmp[2]);
-
 		for (jj = 0, kk = 0; jj < cnts; jj++, kk += 2)
 			pEfuseHal->fakeEfuseModifiedMap[addr+jj] = key_2char2num(tmp[2][kk], tmp[2][kk + 1]);
 	}
@@ -6472,7 +5871,6 @@ static int rtw_mp_read_reg(struct net_device *dev,
 			j++;
 		}
 		pch = tmp;
-		DBG_88E("pch =%s", pch);
 
 		while (*pch != '\0') {
 			pnext = strpbrk(pch, " ");
@@ -6505,7 +5903,6 @@ static int rtw_mp_read_reg(struct net_device *dev,
 			j++;
 		}
 		pch = tmp;
-		DBG_88E("pch =%s", pch);
 
 		while (*pch != '\0') {
 			pnext = strpbrk(pch, " ");
@@ -6614,7 +6011,6 @@ static int rtw_mp_read_rf(struct net_device *dev,
 		j++;
 	}
 	pch = tmp;
-	DBG_88E("pch =%s", pch);
 
 	while (*pch != '\0') {
 		pnext = strpbrk(pch, " ");
@@ -6871,8 +6267,6 @@ static int rtw_mp_ctx(struct net_device *dev,
 	if (copy_from_user(extra, wrqu->pointer, wrqu->length))
 			return -EFAULT;
 
-	DBG_88E("%s: in =%s\n", __func__, extra);
-
 	countPkTx = strncmp(extra, "count =", 5); /*  strncmp true is 0 */
 	cotuTx = strncmp(extra, "background", 20);
 	CarrSprTx = strncmp(extra, "background, cs", 20);
@@ -6891,10 +6285,8 @@ static int rtw_mp_ctx(struct net_device *dev,
 	} else {
 		bStartTest = 1;
 		if (pmp_priv->mode != MP_ON) {
-			if (pmp_priv->tx.stop != 1) {
-				DBG_88E("%s: MP_MODE != ON %d\n", __func__, pmp_priv->mode);
+			if (pmp_priv->tx.stop != 1)
 				return  -EFAULT;
-			}
 		}
 	}
 
@@ -6992,7 +6384,6 @@ static int rtw_mp_arx(struct net_device *dev,
 		kfree(input);
 		return -EFAULT;
 	}
-	DBG_88E("%s: %s\n", __func__, input);
 
 	bStartRx = (strncmp(input, "start", 5) == 0) ? 1 : 0; /*  strncmp true is 0 */
 	bStopRx = (strncmp(input, "stop", 5) == 0) ? 1 : 0; /*  strncmp true is 0 */
@@ -7144,16 +6535,13 @@ static int rtw_mp_thermal(struct net_device *dev,
 
 	 if (bwrite == 0) {
 			EFUSE_GetEfuseDefinition(padapter, EFUSE_WIFI, TYPE_AVAILABLE_EFUSE_BYTES_TOTAL, (void *)&max_available_size, false);
-			if (2 > max_available_size) {
-				DBG_88E("no available efuse!\n");
+			if (2 > max_available_size)
 				return -EFAULT;
-			}
-			if (rtw_efuse_map_write(padapter, addr, cnt, &val) == _FAIL) {
-				DBG_88E("rtw_efuse_map_write error\n");
+
+			if (rtw_efuse_map_write(padapter, addr, cnt, &val) == _FAIL)
 				return -EFAULT;
-			} else {
-				 sprintf(extra, " efuse write ok :%d", val);
-			}
+			else
+				sprintf(extra, " efuse write ok :%d", val);
 	 } else {
 			 sprintf(extra, "%d", val);
 	 }
@@ -7190,30 +6578,12 @@ static int rtw_mp_dump(struct net_device *dev,
 {
 	u32 value;
 	u8 rf_type, path_nums = 0;
-	u32 i, j = 1, path;
+	u32 i, path;
 	struct adapter *padapter = rtw_netdev_priv(dev);
 
 	if (strncmp(extra, "all", 4) == 0) {
-		DBG_88E("\n ======= MAC REG =======\n");
-		for (i = 0x0; i < 0x300; i += 4) {
-			if (j%4 == 1)
-				DBG_88E("0x%02x", i);
-			DBG_88E(" 0x%08x ", rtw_read32(padapter, i));
-			if ((j++)%4 == 0)
-				DBG_88E("\n");
-		}
-		for (i = 0x400; i < 0x1000; i += 4) {
-			if (j%4 == 1)
-				DBG_88E("0x%02x", i);
-			DBG_88E(" 0x%08x ", rtw_read32(padapter, i));
-			if ((j++)%4 == 0)
-				DBG_88E("\n");
-		}
-
-		j = 1;
 		rtw_hal_get_hwreg(padapter, HW_VAR_RF_TYPE, (u8 *)(&rf_type));
 
-		DBG_88E("\n ======= RF REG =======\n");
 		if ((RF_1T2R == rf_type) || (RF_1T1R == rf_type))
 			path_nums = 1;
 		else
@@ -7222,11 +6592,6 @@ static int rtw_mp_dump(struct net_device *dev,
 		for (path = 0; path < path_nums; path++) {
 			for (i = 0; i < 0x34; i++) {
 				value = rtw_hal_read_rfreg(padapter, path, i, 0xffffffff);
-				if (j%4 == 1)
-					DBG_88E("0x%02x ", i);
-				DBG_88E(" 0x%08x ", value);
-				if ((j++)%4 == 0)
-					DBG_88E("\n");
 			}
 		}
 	}
@@ -7247,8 +6612,6 @@ static int rtw_mp_phypara(struct net_device *dev,
 		return -EFAULT;
 	}
 
-	DBG_88E("%s:iwpriv in =%s\n", __func__, input);
-
 	sscanf(input, "xcap =%d", &valxcap);
 
 	kfree(input);
@@ -7267,18 +6630,15 @@ static int rtw_mp_SetRFPath(struct net_device *dev,
 		return -ENOMEM;
 	if (copy_from_user(input, wrqu->data.pointer, wrqu->data.length))
 			return -EFAULT;
-	DBG_88E("%s:iwpriv in =%s\n", __func__, input);
 
 	bMain = strncmp(input, "1", 2); /*  strncmp true is 0 */
 	bTurnoff = strncmp(input, "0", 3); /*  strncmp true is 0 */
 
-	if (bMain == 0) {
+	if (bMain == 0)
 		MP_PHY_SetRFPathSwitch(padapter, true);
-		DBG_88E("%s:PHY_SetRFPathSwitch = true\n", __func__);
-	} else if (bTurnoff == 0) {
+	else if (bTurnoff == 0)
 		MP_PHY_SetRFPathSwitch(padapter, false);
-		DBG_88E("%s:PHY_SetRFPathSwitch = false\n", __func__);
-	}
+
 	kfree(input);
 	return 0;
 }
@@ -7297,13 +6657,10 @@ static int rtw_mp_QueryDrv(struct net_device *dev,
 
 	if (copy_from_user(input, wrqu->data.pointer, wrqu->data.length))
 			return -EFAULT;
-	DBG_88E("%s:iwpriv in =%s\n", __func__, input);
 
 	qAutoLoad = strncmp(input, "autoload", 8); /*  strncmp true is 0 */
 
 	if (qAutoLoad == 0) {
-		DBG_88E("%s:qAutoLoad\n", __func__);
-
 		if (pEEPROM->bautoload_fail_flag)
 			sprintf(extra, "fail");
 		else
@@ -7332,27 +6689,21 @@ static int rtw_mp_set(struct net_device *dev,
 
 	switch (subcmd) {
 	case MP_START:
-		DBG_88E("set case mp_start\n");
 		rtw_mp_start(dev, info, wrqu, extra);
 		 break;
 	case MP_STOP:
-		DBG_88E("set case mp_stop\n");
 		rtw_mp_stop(dev, info, wrqu, extra);
 		 break;
 	case MP_BANDWIDTH:
-		DBG_88E("set case mp_bandwidth\n");
 		rtw_mp_bandwidth(dev, info, wrqu, extra);
 		break;
 	case MP_RESET_STATS:
-		DBG_88E("set case MP_RESET_STATS\n");
 		rtw_mp_reset_stats(dev, info, wrqu, extra);
 		break;
 	case MP_SetRFPathSwh:
-		DBG_88E("set MP_SetRFPathSwitch\n");
 		rtw_mp_SetRFPath(dev, info, wdata, extra);
 		break;
 	case CTA_TEST:
-		DBG_88E("set CTA_TEST\n");
 		rtw_cta_test_start(dev, info, wdata, extra);
 		break;
 	}
@@ -7383,74 +6734,57 @@ static int rtw_mp_get(struct net_device *dev,
 		rtw_mp_write_rf(dev, info, wrqu, extra);
 		 break;
 	case MP_PHYPARA:
-		DBG_88E("mp_get  MP_PHYPARA\n");
 		rtw_mp_phypara(dev, info, wrqu, extra);
 		break;
 	case MP_CHANNEL:
-		DBG_88E("set case mp_channel\n");
 		rtw_mp_channel(dev, info, wrqu, extra);
 		break;
 	case READ_REG:
-		DBG_88E("mp_get  READ_REG\n");
 		rtw_mp_read_reg(dev, info, wrqu, extra);
 		 break;
 	case READ_RF:
-		DBG_88E("mp_get  READ_RF\n");
 		rtw_mp_read_rf(dev, info, wrqu, extra);
 		break;
 	case MP_RATE:
-		DBG_88E("set case mp_rate\n");
 		rtw_mp_rate(dev, info, wrqu, extra);
 		break;
 	case MP_TXPOWER:
-		DBG_88E("set case MP_TXPOWER\n");
 		rtw_mp_txpower(dev, info, wrqu, extra);
 		break;
 	case MP_ANT_TX:
-		DBG_88E("set case MP_ANT_TX\n");
 		rtw_mp_ant_tx(dev, info, wrqu, extra);
 		break;
 	case MP_ANT_RX:
-		DBG_88E("set case MP_ANT_RX\n");
 		rtw_mp_ant_rx(dev, info, wrqu, extra);
 		break;
 	case MP_QUERY:
 		rtw_mp_trx_query(dev, info, wrqu, extra);
 		break;
 	case MP_CTX:
-		DBG_88E("set case MP_CTX\n");
 		rtw_mp_ctx(dev, info, wrqu, extra);
 		break;
 	case MP_ARX:
-		DBG_88E("set case MP_ARX\n");
 		rtw_mp_arx(dev, info, wrqu, extra);
 		break;
 	case EFUSE_GET:
-		DBG_88E("efuse get EFUSE_GET\n");
 		rtw_mp_efuse_get(dev, info, wdata, extra);
 		 break;
 	case MP_DUMP:
-		DBG_88E("set case MP_DUMP\n");
 		rtw_mp_dump(dev, info, wrqu, extra);
 		 break;
 	case MP_PSD:
-		DBG_88E("set case MP_PSD\n");
 		rtw_mp_psd(dev, info, wrqu, extra);
 		break;
 	case MP_THER:
-		DBG_88E("set case MP_THER\n");
 		rtw_mp_thermal(dev, info, wrqu, extra);
 		break;
 	case MP_QueryDrvStats:
-		DBG_88E("mp_get MP_QueryDrvStats\n");
 		rtw_mp_QueryDrv (dev, info, wdata, extra);
 		break;
 	case MP_PWRTRK:
-		DBG_88E("set case MP_PWRTRK\n");
 		rtw_mp_pwrtrk(dev, info, wrqu, extra);
 		break;
 	case EFUSE_SET:
-		DBG_88E("set case efuse set\n");
 		rtw_mp_efuse_set(dev, info, wdata, extra);
 		break;
 	}
@@ -7483,27 +6817,21 @@ static int rtw_test(
 	char *ptmp;
 	u8 *delim = ",";
 
-	DBG_88E("+%s\n", __func__);
 	len = wrqu->data.length;
 
 	pbuf = (u8 *)rtw_zmalloc(len);
-	if (!pbuf) {
-		DBG_88E("%s: no memory!\n", __func__);
+	if (!pbuf)
 		return -ENOMEM;
-	}
 
 	if (copy_from_user(pbuf, wrqu->data.pointer, len)) {
 		kfree(pbuf);
-		DBG_88E("%s: copy from user fail!\n", __func__);
 		return -EFAULT;
 	}
-	DBG_88E("%s: string =\"%s\"\n", __func__, pbuf);
 
 	ptmp = (char *)pbuf;
 	pch = strsep(&ptmp, delim);
 	if (!pch || strlen(pch) == 0) {
 		kfree(pbuf);
-		DBG_88E("%s: parameter error(level 1)!\n", __func__);
 		return -EFAULT;
 	}
 	kfree(pbuf);
@@ -7844,14 +7172,12 @@ static int rtw_ioctl_wext_private(struct net_device *dev, union iwreq_data *wrq_
 
 	sscanf(ptr, "%16s", cmdname);
 	cmdlen = strlen(cmdname);
-	DBG_88E("%s: cmd =%s\n", __func__, cmdname);
 
 	/*  skip command string */
 	if (cmdlen > 0)
 		cmdlen += 1; /*  skip one space */
 	ptr += cmdlen;
 	len -= cmdlen;
-	DBG_88E("%s: parameters =%s\n", __func__, ptr);
 
 	priv = rtw_private_handler;
 	priv_args = rtw_private_args;
@@ -7955,15 +7281,12 @@ static int rtw_ioctl_wext_private(struct net_device *dev, union iwreq_data *wrq_
 			buffer_len = wdata.data.length;
 			break;
 		default:
-			DBG_88E("%s: Not yet implemented...\n", __func__);
 			err = -1;
 			goto exit;
 		}
 
 		if ((priv_args[k].set_args & IW_PRIV_SIZE_FIXED) &&
 		    (wdata.data.length != (priv_args[k].set_args & IW_PRIV_SIZE_MASK))) {
-			DBG_88E("%s: The command %s needs exactly %d argument(s)...\n",
-				__func__, cmdname, priv_args[k].set_args & IW_PRIV_SIZE_MASK);
 			err = -EINVAL;
 			goto exit;
 		}
@@ -8081,7 +7404,6 @@ static int rtw_ioctl_wext_private(struct net_device *dev, union iwreq_data *wrq_
 			memcpy(output, extra, n);
 			break;
 		default:
-			DBG_88E("%s: Not yet implemented...\n", __func__);
 			err = -1;
 			goto exit;
 		}
-- 
2.20.1

