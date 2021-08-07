Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1573E361B
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 17:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbhHGPje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 11:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbhHGPht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 11:37:49 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227E0C0613CF
        for <linux-kernel@vger.kernel.org>; Sat,  7 Aug 2021 08:37:17 -0700 (PDT)
Received: from dslb-084-059-249-202.084.059.pools.vodafone-ip.de ([84.59.249.202] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mCONs-0003Y3-St; Sat, 07 Aug 2021 17:37:13 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 03/12] staging: r8188eu: remove RT_TRACE prints from ioctl_linux.c
Date:   Sat,  7 Aug 2021 17:36:27 +0200
Message-Id: <20210807153636.11712-4-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210807153636.11712-1-martin@kaiser.cx>
References: <20210807153636.11712-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should use the standard mechanism for debug prints. Remove the prints
that use driver-specific macros.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/os_dep/ioctl_linux.c | 78 +-------------------
 1 file changed, 3 insertions(+), 75 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index 34dce01e469c..3d26d50abd7e 100644
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
@@ -501,7 +499,6 @@ static int wpa_set_encryption(struct net_device *dev, struct ieee_param *param,
 	}
 
 	if (strcmp(param->u.crypt.alg, "WEP") == 0) {
-		RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_err_, ("wpa_set_encryption, crypt.alg = WEP\n"));
 		DBG_88E("wpa_set_encryption, crypt.alg = WEP\n");
 
 		padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption1Enabled;
@@ -511,22 +508,18 @@ static int wpa_set_encryption(struct net_device *dev, struct ieee_param *param,
 		wep_key_idx = param->u.crypt.idx;
 		wep_key_len = param->u.crypt.key_len;
 
-		RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_info_, ("(1)wep_key_idx =%d\n", wep_key_idx));
 		DBG_88E("(1)wep_key_idx =%d\n", wep_key_idx);
 
 		if (wep_key_idx > WEP_KEYS)
 			return -EINVAL;
 
-		RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_info_, ("(2)wep_key_idx =%d\n", wep_key_idx));
-
 		if (wep_key_len > 0) {
 			wep_key_len = wep_key_len <= 5 ? 5 : 13;
 			wep_total_len = wep_key_len + FIELD_OFFSET(struct ndis_802_11_wep, KeyMaterial);
 			pwep = kmalloc(wep_total_len, GFP_KERNEL);
-			if (!pwep) {
-				RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_err_, (" wpa_set_encryption: pwep allocate fail !!!\n"));
+			if (!pwep)
 				goto exit;
-			}
+
 			memset(pwep, 0, wep_total_len);
 			pwep->KeyLength = wep_key_len;
 			pwep->Length = wep_total_len;
@@ -659,7 +652,6 @@ static int rtw_set_wpa_ie(struct adapter *padapter, char *pie, unsigned short ie
 		}
 
 		if (ielen < RSN_HEADER_LEN) {
-			RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_err_, ("Ie len too short %d\n", ielen));
 			ret  = -1;
 			goto exit;
 		}
@@ -750,9 +742,6 @@ static int rtw_set_wpa_ie(struct adapter *padapter, char *pie, unsigned short ie
 		}
 	}
 
-	RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_info_,
-		 ("rtw_set_wpa_ie: pairwise_cipher = 0x%08x padapter->securitypriv.ndisencryptstatus =%d padapter->securitypriv.ndisauthtype =%d\n",
-		 pairwise_cipher, padapter->securitypriv.ndisencryptstatus, padapter->securitypriv.ndisauthtype));
 exit:
 	kfree(buf);
 	return ret;
@@ -772,10 +761,6 @@ static int rtw_wx_get_name(struct net_device *dev,
 	struct wlan_bssid_ex  *pcur_bss = &pmlmepriv->cur_network.network;
 	NDIS_802_11_RATES_EX *prates = NULL;
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("cmd_code =%x\n", info->cmd));
-
-
-
 	if (check_fwstate(pmlmepriv, _FW_LINKED|WIFI_ADHOC_MASTER_STATE) == true) {
 		/* parsing HT_CAP_IE */
 		p = rtw_get_ie(&pcur_bss->IEs[12], _HT_CAPABILITY_IE_, &ht_ielen, pcur_bss->IELength-12);
@@ -820,12 +805,6 @@ static int rtw_wx_set_freq(struct net_device *dev,
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
 
@@ -889,7 +868,6 @@ static int rtw_wx_set_mode(struct net_device *dev, struct iw_request_info *a,
 		break;
 	default:
 		ret = -EINVAL;
-		RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_err_, ("\n Mode: %s is not supported\n", iw_operation_mode[wrqu->mode]));
 		goto exit;
 	}
 	if (rtw_set_802_11_infrastructure_mode(padapter, networkType) == false) {
@@ -908,10 +886,6 @@ static int rtw_wx_get_mode(struct net_device *dev, struct iw_request_info *a,
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	struct	mlme_priv	*pmlmepriv = &(padapter->mlmepriv);
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, (" rtw_wx_get_mode\n"));
-
-
-
 	if (check_fwstate(pmlmepriv, WIFI_STATION_STATE))
 		wrqu->mode = IW_MODE_INFRA;
 	else if  ((check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE)) ||
@@ -1015,10 +989,6 @@ static int rtw_wx_get_range(struct net_device *dev,
 	u16 val;
 	int i;
 
-
-
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_wx_get_range. cmd_code =%x\n", info->cmd));
-
 	wrqu->data.length = sizeof(*range);
 	memset(range, 0, sizeof(*range));
 
@@ -1192,10 +1162,6 @@ static int rtw_wx_get_wap(struct net_device *dev,
 
 	memset(wrqu->ap_addr.sa_data, 0, ETH_ALEN);
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_wx_get_wap\n"));
-
-
-
 	if (((check_fwstate(pmlmepriv, _FW_LINKED)) == true) ||
 	    ((check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE)) == true) ||
 	    ((check_fwstate(pmlmepriv, WIFI_AP_STATE)) == true))
@@ -1252,7 +1218,6 @@ static int rtw_wx_set_scan(struct net_device *dev, struct iw_request_info *a,
 #ifdef CONFIG_88EU_P2P
 	struct wifidirect_info *pwdinfo = &(padapter->wdinfo);
 #endif /* CONFIG_88EU_P2P */
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_wx_set_scan\n"));
 
 	if (padapter->registrypriv.mp_mode == 1) {
 		if (check_fwstate(pmlmepriv, WIFI_MP_STATE)) {
@@ -1404,10 +1369,6 @@ static int rtw_wx_get_scan(struct net_device *dev, struct iw_request_info *a,
 #ifdef CONFIG_88EU_P2P
 	struct	wifidirect_info *pwdinfo = &padapter->wdinfo;
 #endif /* CONFIG_88EU_P2P */
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_wx_get_scan\n"));
-	RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_info_, (" Start of Query SIOCGIWSCAN .\n"));
-
-
 
 	if (padapter->pwrctrlpriv.brfoffbyhw && padapter->bDriverStopped) {
 		ret = -EINVAL;
@@ -1487,10 +1448,6 @@ static int rtw_wx_set_essid(struct net_device *dev,
 
 	uint ret = 0, len;
 
-
-
-	RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_info_,
-		 ("+rtw_wx_set_essid: fw_state = 0x%08x\n", get_fwstate(pmlmepriv)));
 	if (_FAIL == rtw_pwr_wakeup(padapter)) {
 		ret = -1;
 		goto exit;
@@ -1524,7 +1481,6 @@ static int rtw_wx_set_essid(struct net_device *dev,
 		memcpy(ndis_ssid.Ssid, extra, len);
 		src_ssid = ndis_ssid.Ssid;
 
-		RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_info_, ("rtw_wx_set_essid: ssid =[%s]\n", src_ssid));
 		spin_lock_bh(&queue->lock);
 	       phead = get_list_head(queue);
 	      pmlmepriv->pscanned = phead->next;
@@ -1536,14 +1492,8 @@ static int rtw_wx_set_essid(struct net_device *dev,
 
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
@@ -1560,8 +1510,6 @@ static int rtw_wx_set_essid(struct net_device *dev,
 			}
 		}
 		spin_unlock_bh(&queue->lock);
-		RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_info_,
-			 ("set ssid: set_802_11_auth. mode =%d\n", authmode));
 		rtw_set_802_11_authentication_mode(padapter, authmode);
 		if (rtw_set_802_11_ssid(padapter, &ndis_ssid) == false) {
 			ret = -1;
@@ -1587,10 +1535,6 @@ static int rtw_wx_get_essid(struct net_device *dev,
 	struct	mlme_priv	*pmlmepriv = &(padapter->mlmepriv);
 	struct wlan_bssid_ex  *pcur_bss = &pmlmepriv->cur_network.network;
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_wx_get_essid\n"));
-
-
-
 	if ((check_fwstate(pmlmepriv, _FW_LINKED)) ||
 	    (check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE))) {
 		len = pcur_bss->Ssid.SsidLength;
@@ -1618,9 +1562,6 @@ static int rtw_wx_set_rate(struct net_device *dev,
 	u32	ratevalue = 0;
 	 u8 mpdatarate[NumRates] = {11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0, 0xff};
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, (" rtw_wx_set_rate\n"));
-	RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_info_, ("target_rate = %d, fixed = %d\n", target_rate, fixed));
-
 	if (target_rate == -1) {
 		ratevalue = 11;
 		goto set_rate;
@@ -1679,14 +1620,10 @@ static int rtw_wx_set_rate(struct net_device *dev,
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
@@ -2474,12 +2411,8 @@ static int rtw_mp_ioctl_hdl(struct net_device *dev, struct iw_request_info *info
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
@@ -2488,9 +2421,6 @@ static int rtw_mp_ioctl_hdl(struct net_device *dev, struct iw_request_info *info
 		phandler = mp_ioctl_hdl + poidparam->subcode;
 
 		if ((phandler->paramsize != 0) && (poidparam->len < phandler->paramsize)) {
-			RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_err_,
-				 ("no matching drvext param size %d vs %d\r\n",
-				  poidparam->len, phandler->paramsize));
 			ret = -EINVAL;
 			goto _rtw_mp_ioctl_hdl_exit;
 		}
@@ -4603,8 +4533,6 @@ static int wpa_set_param(struct net_device *dev, u8 name, u32 value)
 			padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption3Enabled;
 			break;
 		}
-		RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_info_,
-			 ("wpa_set_param:padapter->securitypriv.ndisauthtype =%d\n", padapter->securitypriv.ndisauthtype));
 		break;
 	case IEEE_PARAM_TKIP_COUNTERMEASURES:
 		break;
-- 
2.20.1

