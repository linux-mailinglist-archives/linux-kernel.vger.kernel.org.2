Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 554323EDF1A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 23:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233399AbhHPVMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 17:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbhHPVMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 17:12:17 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 791D7C061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 14:11:45 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id x10so19161667wrt.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 14:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P5BTxLWmi77IqBvwqj60cxZryJsnyaI8B0KIYFSttVo=;
        b=Ixfh+GZMEDQ55Ioy4QYh/BjbkzYxAtWZq4MakXprnAzNc/61F8y8lN8X9PsnIWmTLD
         2mYsepJ3YpCruskbFSEruzYwnRZzk/qD4/1mI1w9M1GEJJrflpQhg5NnRUMOaAKcaWyM
         itMzQcdNXzkptgJ95uSv9sHbYapFgOLuMLycyHsvFbOLqXrROq5SKgUDBOLoNXswGfHq
         aLF+jazG3yq7HFCGovCpgUrNYgm8D3u7YWZb2wqMEXgX/6+x+aM4gGBUo5eWJ42idcvF
         uv333xjc3744Mm49XwNaMi9W+XO08YjT6IuFOIvEBshdYQGEI/WfNu/xJu/aJwTkFcml
         Y6qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P5BTxLWmi77IqBvwqj60cxZryJsnyaI8B0KIYFSttVo=;
        b=UP6FqHJetZ6zJ12txeNU/OPR722ZeXOUuK+HDsYE10RtMxAY8TbVPbk/qgH8mij+JS
         m3cPBDfpiuSCOpXiibDbIwz2hX/vpdgbv9cOrp1byoZyZ4F1qxjMt73XpKpgF6I+AMev
         kkvYvXa4e1l1XMzyzhh93NAyAasPerJ5QIrPn3sZ+SdjXkk3UVwxEnfz5NN5QA9uhGWu
         AMamcMNlDRkWrSyKhOXb43gYKypAgywhZwAAP9dHOVYefIGwjaxqFkGKtaa68kZh9mou
         2k5ZOZXPdBw++dbR3/UOJkJCPODWyj6YMTavWjdbpG/RRHtgp8dg1YhWFa7YL3KYFEF7
         +3OQ==
X-Gm-Message-State: AOAM533/ALHMm5eGpSY7hF0D8xBBXPW+YdGwy3cHD/2ltCab4FM7qugX
        TIyZzhA9htUtv0hi16hfDBU=
X-Google-Smtp-Source: ABdhPJx4gc9YaNiKatHZ2uJZhVen0quS1qWVxIAljwk8kuuNYgOCtelWbyNg8oGjG14iRiE07Sd4vg==
X-Received: by 2002:a5d:456a:: with SMTP id a10mr45631wrc.339.1629148303832;
        Mon, 16 Aug 2021 14:11:43 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::4058])
        by smtp.gmail.com with ESMTPSA id a133sm310901wme.5.2021.08.16.14.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 14:11:43 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: r8188eu: clean up spacing style issues in os_dep dir
Date:   Mon, 16 Aug 2021 23:10:53 +0200
Message-Id: <20210816211053.31728-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up spacing style issues reported by checkpatch in the os_dep
directory.

CHECK: spaces preferred around that ...
CHECK: No space is necessary after a cast
WARNING: space prohibited before semicolon
WARNING: space prohibited between function name and open parenthesis '('
ERROR: spaces required around that '=' (ctx:VxV)

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/os_dep/ioctl_linux.c  | 202 +++++++++---------
 drivers/staging/r8188eu/os_dep/mlme_linux.c   |   4 +-
 drivers/staging/r8188eu/os_dep/os_intfs.c     |   8 +-
 .../staging/r8188eu/os_dep/osdep_service.c    |  16 +-
 drivers/staging/r8188eu/os_dep/recv_linux.c   |   2 +-
 drivers/staging/r8188eu/os_dep/rtw_android.c  |   2 +-
 drivers/staging/r8188eu/os_dep/usb_intf.c     |   2 +-
 drivers/staging/r8188eu/os_dep/xmit_linux.c   |   8 +-
 8 files changed, 122 insertions(+), 122 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index d40aaab48821..8478c0f5f285 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -181,18 +181,18 @@ static char *translate_scan(struct adapter *padapter,
 	start = iwe_stream_add_point(info, start, stop, &iwe, pnetwork->network.Ssid.Ssid);
 
 	/* parsing HT_CAP_IE */
-	p = rtw_get_ie(&pnetwork->network.IEs[12], _HT_CAPABILITY_IE_, &ht_ielen, pnetwork->network.IELength-12);
+	p = rtw_get_ie(&pnetwork->network.IEs[12], _HT_CAPABILITY_IE_, &ht_ielen, pnetwork->network.IELength - 12);
 
 	if (p && ht_ielen > 0) {
 		struct ieee80211_ht_cap *pht_capie;
 
 		ht_cap = true;
-		pht_capie = (struct ieee80211_ht_cap *)(p+2);
+		pht_capie = (struct ieee80211_ht_cap *)(p + 2);
 		memcpy(&mcs_rate, pht_capie->mcs.rx_mask, 2);
 		bw_40MHz = (le16_to_cpu(pht_capie->cap_info) &
 			    IEEE80211_HT_CAP_SUP_WIDTH_20_40) ? 1 : 0;
 		short_GI = (le16_to_cpu(pht_capie->cap_info) &
-			    (IEEE80211_HT_CAP_SGI_20|IEEE80211_HT_CAP_SGI_40)) ? 1 : 0;
+			    (IEEE80211_HT_CAP_SGI_20 | IEEE80211_HT_CAP_SGI_40)) ? 1 : 0;
 	}
 
 	/* Add the protocol name */
@@ -265,7 +265,7 @@ static char *translate_scan(struct adapter *padapter,
 	p = custom;
 	p += snprintf(p, MAX_CUSTOM_LEN - (p - custom), " Rates (Mb/s): ");
 	while (pnetwork->network.SupportedRates[i] != 0) {
-		rate = pnetwork->network.SupportedRates[i]&0x7F;
+		rate = pnetwork->network.SupportedRates[i] & 0x7F;
 		if (rate > max_rate)
 			max_rate = rate;
 		p += snprintf(p, MAX_CUSTOM_LEN - (p - custom),
@@ -274,14 +274,14 @@ static char *translate_scan(struct adapter *padapter,
 	}
 
 	if (ht_cap) {
-		if (mcs_rate&0x8000)/* MCS15 */
+		if (mcs_rate & 0x8000)/* MCS15 */
 			max_rate = (bw_40MHz) ? ((short_GI) ? 300 : 270) : ((short_GI) ? 144 : 130);
-		else if (mcs_rate&0x0080)/* MCS7 */
+		else if (mcs_rate & 0x0080)/* MCS7 */
 			;
 		else/* default MCS7 */
 			max_rate = (bw_40MHz) ? ((short_GI) ? 150 : 135) : ((short_GI) ? 72 : 65);
 
-		max_rate = max_rate*2;/* Mbps/2; */
+		max_rate = max_rate * 2;/* Mbps/2; */
 	}
 
 	iwe.cmd = SIOCGIWRATE;
@@ -366,7 +366,7 @@ static char *translate_scan(struct adapter *padapter,
 				iwe.u.data.length = (u16)wps_ielen;
 				start = iwe_stream_add_point(info, start, stop, &iwe, wpsie_ptr);
 			}
-			cnt += ie_ptr[cnt+1]+2; /* goto next */
+			cnt += ie_ptr[cnt + 1] + 2; /* goto next */
 		}
 	}
 
@@ -438,7 +438,7 @@ static int wpa_set_encryption(struct net_device *dev, struct ieee_param *param,
 	param->u.crypt.err = 0;
 	param->u.crypt.alg[IEEE_CRYPT_ALG_NAME_LEN - 1] = '\0';
 
-	if (param_len < (u32) ((u8 *)param->u.crypt.key - (u8 *)param) + param->u.crypt.key_len) {
+	if (param_len < (u32)((u8 *)param->u.crypt.key - (u8 *)param) + param->u.crypt.key_len) {
 		ret =  -EINVAL;
 		goto exit;
 	}
@@ -605,7 +605,7 @@ static int rtw_set_wpa_ie(struct adapter *padapter, char *pie, unsigned short ie
 			int i;
 			DBG_88E("\n wpa_ie(length:%d):\n", ielen);
 			for (i = 0; i < ielen; i += 8)
-				DBG_88E("0x%.2x 0x%.2x 0x%.2x 0x%.2x 0x%.2x 0x%.2x 0x%.2x 0x%.2x\n", buf[i], buf[i+1], buf[i+2], buf[i+3], buf[i+4], buf[i+5], buf[i+6], buf[i+7]);
+				DBG_88E("0x%.2x 0x%.2x 0x%.2x 0x%.2x 0x%.2x 0x%.2x 0x%.2x 0x%.2x\n", buf[i], buf[i + 1], buf[i + 2], buf[i + 3], buf[i + 4], buf[i + 5], buf[i + 6], buf[i + 7]);
 		}
 
 		if (ielen < RSN_HEADER_LEN) {
@@ -678,10 +678,10 @@ static int rtw_set_wpa_ie(struct adapter *padapter, char *pie, unsigned short ie
 
 			while (cnt < ielen) {
 				eid = buf[cnt];
-				if ((eid == _VENDOR_SPECIFIC_IE_) && (!memcmp(&buf[cnt+2], wps_oui, 4))) {
+				if ((eid == _VENDOR_SPECIFIC_IE_) && (!memcmp(&buf[cnt + 2], wps_oui, 4))) {
 					DBG_88E("SET WPS_IE\n");
 
-					padapter->securitypriv.wps_ie_len = ((buf[cnt+1]+2) < (MAX_WPA_IE_LEN<<2)) ? (buf[cnt+1]+2) : (MAX_WPA_IE_LEN<<2);
+					padapter->securitypriv.wps_ie_len = ((buf[cnt + 1] + 2) < (MAX_WPA_IE_LEN << 2)) ? (buf[cnt + 1] + 2) : (MAX_WPA_IE_LEN << 2);
 
 					memcpy(padapter->securitypriv.wps_ie, &buf[cnt], padapter->securitypriv.wps_ie_len);
 
@@ -690,10 +690,10 @@ static int rtw_set_wpa_ie(struct adapter *padapter, char *pie, unsigned short ie
 					if (rtw_p2p_chk_state(pwdinfo, P2P_STATE_GONEGO_OK))
 						rtw_p2p_set_state(pwdinfo, P2P_STATE_PROVISIONING_ING);
 #endif /* CONFIG_88EU_P2P */
-					cnt += buf[cnt+1]+2;
+					cnt += buf[cnt + 1] + 2;
 					break;
 				} else {
-					cnt += buf[cnt+1]+2; /* goto next */
+					cnt += buf[cnt + 1] + 2; /* goto next */
 				}
 			}
 		}
@@ -718,9 +718,9 @@ static int rtw_wx_get_name(struct net_device *dev,
 	struct wlan_bssid_ex  *pcur_bss = &pmlmepriv->cur_network.network;
 	NDIS_802_11_RATES_EX *prates = NULL;
 
-	if (check_fwstate(pmlmepriv, _FW_LINKED|WIFI_ADHOC_MASTER_STATE) == true) {
+	if (check_fwstate(pmlmepriv, _FW_LINKED | WIFI_ADHOC_MASTER_STATE) == true) {
 		/* parsing HT_CAP_IE */
-		p = rtw_get_ie(&pcur_bss->IEs[12], _HT_CAPABILITY_IE_, &ht_ielen, pcur_bss->IELength-12);
+		p = rtw_get_ie(&pcur_bss->IEs[12], _HT_CAPABILITY_IE_, &ht_ielen, pcur_bss->IELength - 12);
 		if (p && ht_ielen > 0)
 			ht_cap = true;
 
@@ -879,7 +879,7 @@ static int rtw_wx_set_pmkid(struct net_device *dev,
 				DBG_88E("[rtw_wx_set_pmkid] BSSID exists in the PMKList.\n");
 				memcpy(psecuritypriv->PMKIDList[j].PMKID, pPMK->pmkid, IW_PMKID_LEN);
 				psecuritypriv->PMKIDList[j].bUsed = true;
-				psecuritypriv->PMKIDIndex = j+1;
+				psecuritypriv->PMKIDIndex = j + 1;
 				blInserted = true;
 				break;
 			}
@@ -1204,7 +1204,7 @@ static int rtw_wx_set_scan(struct net_device *dev, struct iw_request_info *a,
 		goto exit;
 	}
 
-	if (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY|_FW_UNDER_LINKING)) {
+	if (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY | _FW_UNDER_LINKING)) {
 		indicate_wx_scan_complete_event(padapter);
 		goto exit;
 	}
@@ -1222,7 +1222,7 @@ static int rtw_wx_set_scan(struct net_device *dev, struct iw_request_info *a,
 	}
 #endif /* CONFIG_88EU_P2P */
 
-	memset(ssid, 0, sizeof(struct ndis_802_11_ssid)*RTW_SSID_SCAN_AMOUNT);
+	memset(ssid, 0, sizeof(struct ndis_802_11_ssid) * RTW_SSID_SCAN_AMOUNT);
 
 	if (wrqu->data.length == sizeof(struct iw_scan_req)) {
 		struct iw_scan_req *req = (struct iw_scan_req *)extra;
@@ -1247,7 +1247,7 @@ static int rtw_wx_set_scan(struct net_device *dev, struct iw_request_info *a,
 		if (wrqu->data.length >= WEXT_CSCAN_HEADER_SIZE &&
 		    !memcmp(extra, WEXT_CSCAN_HEADER, WEXT_CSCAN_HEADER_SIZE)) {
 			int len = wrqu->data.length - WEXT_CSCAN_HEADER_SIZE;
-			char *pos = extra+WEXT_CSCAN_HEADER_SIZE;
+			char *pos = extra + WEXT_CSCAN_HEADER_SIZE;
 			char section;
 			char sec_len;
 			int ssid_index = 0;
@@ -1370,7 +1370,7 @@ static int rtw_wx_get_scan(struct net_device *dev, struct iw_request_info *a,
 
 	spin_unlock_bh(&pmlmepriv->scanned_queue.lock);
 
-	wrqu->data.length = ev-extra;
+	wrqu->data.length = ev - extra;
 	wrqu->data.flags = 0;
 
 exit:
@@ -1515,7 +1515,7 @@ static int rtw_wx_set_rate(struct net_device *dev,
 		ratevalue = 11;
 		goto set_rate;
 	}
-	target_rate = target_rate/100000;
+	target_rate = target_rate / 100000;
 
 	switch (target_rate) {
 	case 10:
@@ -2033,7 +2033,7 @@ static int rtw_wx_set_enc_ext(struct net_device *dev,
 	    (pext->ext_flags & IW_ENCODE_EXT_GROUP_KEY))
 		param->u.crypt.set_tx = 0;
 
-	param->u.crypt.idx = (pencoding->flags&0x00FF) - 1;
+	param->u.crypt.idx = (pencoding->flags & 0x00FF) - 1;
 
 	if (pext->ext_flags & IW_ENCODE_EXT_RX_SEQ_VALID)
 		memcpy(param->u.crypt.seq, pext->rx_seq, 8);
@@ -2203,7 +2203,7 @@ static int rtw_wx_set_channel_plan(struct net_device *dev,
 {
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-	u8 channel_plan_req = (u8) (*((int *)wrqu));
+	u8 channel_plan_req = (u8)(*((int *)wrqu));
 
 	if (_SUCCESS == rtw_set_chplan_cmd(padapter, channel_plan_req, 1))
 		DBG_88E("%s set channel_plan = 0x%02X\n", __func__, pmlmepriv->ChannelPlan);
@@ -2444,7 +2444,7 @@ static int rtw_get_ap_info(struct net_device *dev,
 		goto exit;
 	}
 
-	while ((check_fwstate(pmlmepriv, (_FW_UNDER_SURVEY|_FW_UNDER_LINKING)))) {
+	while ((check_fwstate(pmlmepriv, (_FW_UNDER_SURVEY | _FW_UNDER_LINKING)))) {
 		msleep(30);
 		cnt++;
 		if (cnt > 100)
@@ -2479,13 +2479,13 @@ static int rtw_get_ap_info(struct net_device *dev,
 			/* BSSID match, then check if supporting wpa/wpa2 */
 			DBG_88E("BSSID:%pM\n", (bssid));
 
-			pbuf = rtw_get_wpa_ie(&pnetwork->network.IEs[12], &wpa_ielen, pnetwork->network.IELength-12);
+			pbuf = rtw_get_wpa_ie(&pnetwork->network.IEs[12], &wpa_ielen, pnetwork->network.IELength - 12);
 			if (pbuf && (wpa_ielen > 0)) {
 				pdata->flags = 1;
 				break;
 			}
 
-			pbuf = rtw_get_wpa2_ie(&pnetwork->network.IEs[12], &wpa_ielen, pnetwork->network.IELength-12);
+			pbuf = rtw_get_wpa2_ie(&pnetwork->network.IEs[12], &wpa_ielen, pnetwork->network.IELength - 12);
 			if (pbuf && (wpa_ielen > 0)) {
 				pdata->flags = 2;
 				break;
@@ -2498,7 +2498,7 @@ static int rtw_get_ap_info(struct net_device *dev,
 	spin_unlock_bh(&pmlmepriv->scanned_queue.lock);
 
 	if (pdata->length >= 34) {
-		if (copy_to_user(pdata->pointer+32, (u8 *)&pdata->flags, 1)) {
+		if (copy_to_user(pdata->pointer + 32, (u8 *)&pdata->flags, 1)) {
 			ret = -EINVAL;
 			goto exit;
 		}
@@ -2525,8 +2525,8 @@ static int rtw_set_pid(struct net_device *dev,
 
 	selector = *pdata;
 	if (selector < 3 && selector >= 0) {
-		padapter->pid[selector] = *(pdata+1);
-		ui_pid[selector] = *(pdata+1);
+		padapter->pid[selector] = *(pdata + 1);
+		ui_pid[selector] = *(pdata + 1);
 		DBG_88E("%s set pid[%d] =%d\n", __func__, selector, padapter->pid[selector]);
 	} else {
 		DBG_88E("%s selector %d error\n", __func__, selector);
@@ -2978,7 +2978,7 @@ static int rtw_p2p_get_wps_configmethod(struct net_device *dev,
 			/*  The mac address is matched. */
 			wpsie = rtw_get_wps_ie(&pnetwork->network.IEs[12], pnetwork->network.IELength - 12, NULL, &wpsie_len);
 			if (wpsie) {
-				rtw_get_wps_attr_content(wpsie, wpsie_len, WPS_ATTR_CONF_METHOD, (u8 *) &be_tmp, &attr_contentlen);
+				rtw_get_wps_attr_content(wpsie, wpsie_len, WPS_ATTR_CONF_METHOD, (u8 *)&be_tmp, &attr_contentlen);
 				if (attr_contentlen) {
 					attr_content = be16_to_cpu(be_tmp);
 					sprintf(attr_content_str, "\n\nM =%.4d", attr_content);
@@ -3062,7 +3062,7 @@ static int rtw_p2p_get_go_device_address(struct net_device *dev,
 					}
 
 					/* Get the next P2P IE */
-					p2pie = rtw_get_p2p_ie(p2pie+p2pielen, pnetwork->network.IELength - 12 - (p2pie - &pnetwork->network.IEs[12] + p2pielen), NULL, &p2pielen);
+					p2pie = rtw_get_p2p_ie(p2pie + p2pielen, pnetwork->network.IELength - 12 - (p2pie - &pnetwork->network.IEs[12] + p2pielen), NULL, &p2pielen);
 				}
 			}
 	     }
@@ -3279,7 +3279,7 @@ static int rtw_p2p_get_invitation_procedure(struct net_device *dev,
 					}
 
 					/* Get the next P2P IE */
-					p2pie = rtw_get_p2p_ie(p2pie+p2pielen, pnetwork->network.IELength - 12 - (p2pie - &pnetwork->network.IEs[12] + p2pielen), NULL, &p2pielen);
+					p2pie = rtw_get_p2p_ie(p2pie + p2pielen, pnetwork->network.IELength - 12 - (p2pie - &pnetwork->network.IEs[12] + p2pielen), NULL, &p2pielen);
 				}
 			}
 		}
@@ -3471,7 +3471,7 @@ static int rtw_p2p_invite_req(struct net_device *dev,
 
 		/*	Store the GO's ssid */
 		pinvite_req_info->ssidlen = wrqu->data.length - 36;
-		memcpy(pinvite_req_info->go_ssid, &extra[36], (u32) pinvite_req_info->ssidlen);
+		memcpy(pinvite_req_info->go_ssid, &extra[36], (u32)pinvite_req_info->ssidlen);
 		pinvite_req_info->benable = true;
 		pinvite_req_info->peer_ch = uintPeerChannel;
 
@@ -3611,7 +3611,7 @@ static int rtw_p2p_prov_disc(struct net_device *dev,
 				}
 
 				/* Get the next P2P IE */
-				p2pie = rtw_get_p2p_ie(p2pie+p2pielen, pnetwork->network.IELength - 12 - (p2pie - &pnetwork->network.IEs[12] + p2pielen), NULL, &p2pielen);
+				p2pie = rtw_get_p2p_ie(p2pie + p2pielen, pnetwork->network.IELength - 12 - (p2pie - &pnetwork->network.IEs[12] + p2pielen), NULL, &p2pielen);
 			}
 		}
 
@@ -3624,7 +3624,7 @@ static int rtw_p2p_prov_disc(struct net_device *dev,
 		DBG_88E("[%s] peer channel: %d!\n", __func__, uintPeerChannel);
 		memcpy(pwdinfo->tx_prov_disc_info.peerIFAddr, pnetwork->network.MacAddress, ETH_ALEN);
 		memcpy(pwdinfo->tx_prov_disc_info.peerDevAddr, peerMAC, ETH_ALEN);
-		pwdinfo->tx_prov_disc_info.peer_channel_num[0] = (u16) uintPeerChannel;
+		pwdinfo->tx_prov_disc_info.peer_channel_num[0] = (u16)uintPeerChannel;
 		pwdinfo->tx_prov_disc_info.benable = true;
 		rtw_p2p_set_pre_state(pwdinfo, rtw_p2p_state(pwdinfo));
 		rtw_p2p_set_state(pwdinfo, P2P_STATE_TX_PROVISION_DIS_REQ);
@@ -3842,7 +3842,7 @@ static int rtw_rereg_nd_name(struct net_device *dev,
 		reg_ifname = padapter->registrypriv.if2name;
 
 		strncpy(rereg_priv->old_ifname, reg_ifname, IFNAMSIZ);
-		rereg_priv->old_ifname[IFNAMSIZ-1] = 0;
+		rereg_priv->old_ifname[IFNAMSIZ - 1] = 0;
 	}
 
 	if (wrqu->data.length > IFNAMSIZ)
@@ -3866,7 +3866,7 @@ static int rtw_rereg_nd_name(struct net_device *dev,
 	}
 
 	strncpy(rereg_priv->old_ifname, new_ifname, IFNAMSIZ);
-	rereg_priv->old_ifname[IFNAMSIZ-1] = 0;
+	rereg_priv->old_ifname[IFNAMSIZ - 1] = 0;
 
 	if (!memcmp(new_ifname, "disable%d", 9)) {
 		DBG_88E("%s disable\n", __func__);
@@ -3892,17 +3892,17 @@ static void mac_reg_dump(struct adapter *padapter)
 	int i, j = 1;
 	pr_info("\n ======= MAC REG =======\n");
 	for (i = 0x0; i < 0x300; i += 4) {
-		if (j%4 == 1)
+		if (j % 4 == 1)
 			pr_info("0x%02x", i);
 		pr_info(" 0x%08x ", rtw_read32(padapter, i));
-		if ((j++)%4 == 0)
+		if ((j++) % 4 == 0)
 			pr_info("\n");
 	}
 	for (i = 0x400; i < 0x800; i += 4) {
-		if (j%4 == 1)
+		if (j % 4 == 1)
 			pr_info("0x%02x", i);
 		pr_info(" 0x%08x ", rtw_read32(padapter, i));
-		if ((j++)%4 == 0)
+		if ((j++) % 4 == 0)
 			pr_info("\n");
 	}
 }
@@ -3912,11 +3912,11 @@ static void bb_reg_dump(struct adapter *padapter)
 	int i, j = 1;
 	pr_info("\n ======= BB REG =======\n");
 	for (i = 0x800; i < 0x1000; i += 4) {
-		if (j%4 == 1)
+		if (j % 4 == 1)
 			pr_info("0x%02x", i);
 
 		pr_info(" 0x%08x ", rtw_read32(padapter, i));
-		if ((j++)%4 == 0)
+		if ((j++) % 4 == 0)
 			pr_info("\n");
 	}
 }
@@ -3938,10 +3938,10 @@ static void rf_reg_dump(struct adapter *padapter)
 		pr_info("\nRF_Path(%x)\n", path);
 		for (i = 0; i < 0x100; i++) {
 			value = rtw_hal_read_rfreg(padapter, path, i, 0xffffffff);
-			if (j%4 == 1)
+			if (j % 4 == 1)
 				pr_info("0x%02x ", i);
 			pr_info(" 0x%08x ", value);
-			if ((j++)%4 == 0)
+			if ((j++) % 4 == 0)
 				pr_info("\n");
 		}
 	}
@@ -3972,7 +3972,7 @@ static int rtw_dbg_port(struct net_device *dev,
 	major_cmd = (u8)(val32 >> 24);
 	minor_cmd = (u8)((val32 >> 16) & 0x00ff);
 
-	extra_arg = *(pdata+1);
+	extra_arg = *(pdata + 1);
 
 	switch (major_cmd) {
 	case 0x70:/* read_reg */
@@ -4071,7 +4071,7 @@ static int rtw_dbg_port(struct net_device *dev,
 				rtw_IOL_append_WB_cmd(xmit_frame, reg, 0x08, 0xff);
 				rtw_IOL_append_DELAY_MS_cmd(xmit_frame, blink_delay_ms);
 			}
-			if (_SUCCESS != rtw_IOL_exec_cmds_sync(padapter, xmit_frame, (blink_delay_ms*blink_num*2)+200, 0))
+			if (_SUCCESS != rtw_IOL_exec_cmds_sync(padapter, xmit_frame, (blink_delay_ms * blink_num * 2) + 200, 0))
 				ret = -EPERM;
 		}
 			break;
@@ -4092,12 +4092,12 @@ static int rtw_dbg_port(struct net_device *dev,
 			}
 
 			for (i = 0; i < write_num; i++)
-				rtw_IOL_append_WB_cmd(xmit_frame, reg, i+start_value, 0xFF);
+				rtw_IOL_append_WB_cmd(xmit_frame, reg, i + start_value, 0xFF);
 			if (_SUCCESS != rtw_IOL_exec_cmds_sync(padapter, xmit_frame, 5000, 0))
 				ret = -EPERM;
 
 			final = rtw_read8(padapter, reg);
-			if (start_value+write_num-1 == final)
+			if (start_value + write_num - 1 == final)
 				DBG_88E("continuous IOL_CMD_WB_REG to 0x%x %u times Success, start:%u, final:%u\n", reg, write_num, start_value, final);
 			else
 				DBG_88E("continuous IOL_CMD_WB_REG to 0x%x %u times Fail, start:%u, final:%u\n", reg, write_num, start_value, final);
@@ -4121,12 +4121,12 @@ static int rtw_dbg_port(struct net_device *dev,
 			}
 
 			for (i = 0; i < write_num; i++)
-				rtw_IOL_append_WW_cmd(xmit_frame, reg, i+start_value, 0xFFFF);
+				rtw_IOL_append_WW_cmd(xmit_frame, reg, i + start_value, 0xFFFF);
 			if (_SUCCESS != rtw_IOL_exec_cmds_sync(padapter, xmit_frame, 5000, 0))
 				ret = -EPERM;
 
 			final = rtw_read16(padapter, reg);
-			if (start_value+write_num-1 == final)
+			if (start_value + write_num - 1 == final)
 				DBG_88E("continuous IOL_CMD_WW_REG to 0x%x %u times Success, start:%u, final:%u\n", reg, write_num, start_value, final);
 			else
 				DBG_88E("continuous IOL_CMD_WW_REG to 0x%x %u times Fail, start:%u, final:%u\n", reg, write_num, start_value, final);
@@ -4149,12 +4149,12 @@ static int rtw_dbg_port(struct net_device *dev,
 			}
 
 			for (i = 0; i < write_num; i++)
-				rtw_IOL_append_WD_cmd(xmit_frame, reg, i+start_value, 0xFFFFFFFF);
+				rtw_IOL_append_WD_cmd(xmit_frame, reg, i + start_value, 0xFFFFFFFF);
 			if (_SUCCESS != rtw_IOL_exec_cmds_sync(padapter, xmit_frame, 5000, 0))
 				ret = -EPERM;
 
 			final = rtw_read32(padapter, reg);
-			if (start_value+write_num-1 == final)
+			if (start_value + write_num - 1 == final)
 				DBG_88E("continuous IOL_CMD_WD_REG to 0x%x %u times Success, start:%u, final:%u\n",
 					reg, write_num, start_value, final);
 			else
@@ -4238,7 +4238,7 @@ static int rtw_dbg_port(struct net_device *dev,
 				u32	ODMFlag;
 				rtw_hal_get_hwreg(padapter, HW_VAR_DM_FLAG, (u8 *)(&ODMFlag));
 				DBG_88E("(B)DMFlag = 0x%x, arg = 0x%x\n", ODMFlag, arg);
-				ODMFlag = (u32)(0x0f&arg);
+				ODMFlag = (u32)(0x0f & arg);
 				DBG_88E("(A)DMFlag = 0x%x\n", ODMFlag);
 				rtw_hal_set_hwreg(padapter, HW_VAR_DM_FLAG, (u8 *)(&ODMFlag));
 			}
@@ -4541,10 +4541,10 @@ static int rtw_pm_set(struct net_device *dev,
 	DBG_88E("[%s] extra = %s\n", __func__, extra);
 
 	if (!memcmp(extra, "lps =", 4)) {
-		sscanf(extra+4, "%u", &mode);
+		sscanf(extra + 4, "%u", &mode);
 		ret = rtw_pm_set_lps(padapter, mode);
 	} else if (!memcmp(extra, "ips =", 4)) {
-		sscanf(extra+4, "%u", &mode);
+		sscanf(extra + 4, "%u", &mode);
 		ret = rtw_pm_set_ips(padapter, mode);
 	} else {
 		ret = -EINVAL;
@@ -4624,10 +4624,10 @@ static int rtw_mp_efuse_get(struct net_device *dev,
 		for (i = 0; i < EFUSE_MAP_SIZE; i += 16) {
 			sprintf(extra + strlen(extra), "0x%02x\t", i);
 			for (j = 0; j < 8; j++)
-				sprintf(extra + strlen(extra), "%02X ", PROMContent[i+j]);
+				sprintf(extra + strlen(extra), "%02X ", PROMContent[i + j]);
 			sprintf(extra + strlen(extra), "\t");
 			for (; j < 16; j++)
-				sprintf(extra + strlen(extra), "%02X ", PROMContent[i+j]);
+				sprintf(extra + strlen(extra), "%02X ", PROMContent[i + j]);
 			sprintf(extra + strlen(extra), "\n");
 		}
 	} else if (strcmp(tmp[0], "realmap") == 0) {
@@ -4642,10 +4642,10 @@ static int rtw_mp_efuse_get(struct net_device *dev,
 		for (i = 0; i < EFUSE_MAP_SIZE; i += 16) {
 			sprintf(extra + strlen(extra), "0x%02x\t", i);
 			for (j = 0; j < 8; j++)
-				sprintf(extra + strlen(extra), "%02X ", pEfuseHal->fakeEfuseInitMap[i+j]);
+				sprintf(extra + strlen(extra), "%02X ", pEfuseHal->fakeEfuseInitMap[i + j]);
 			sprintf(extra + strlen(extra), "\t");
 			for (; j < 16; j++)
-				sprintf(extra + strlen(extra), "%02X ", pEfuseHal->fakeEfuseInitMap[i+j]);
+				sprintf(extra + strlen(extra), "%02X ", pEfuseHal->fakeEfuseInitMap[i + j]);
 			sprintf(extra + strlen(extra), "\n");
 		}
 	} else if (strcmp(tmp[0], "rmap") == 0) {
@@ -4722,7 +4722,7 @@ static int rtw_mp_efuse_get(struct net_device *dev,
 		*extra = 0;
 		for (i = 0; i < cnts; i++) {
 			sprintf(extra + strlen(extra), "%02X", data[i]);
-			if (i != (cnts-1))
+			if (i != (cnts - 1))
 				sprintf(extra + strlen(extra), ":");
 		}
 	} else if (strcmp(tmp[0], "vidpid") == 0) {
@@ -4743,13 +4743,13 @@ static int rtw_mp_efuse_get(struct net_device *dev,
 		*extra = 0;
 		for (i = 0; i < cnts; i++) {
 			sprintf(extra + strlen(extra), "0x%02X", data[i]);
-			if (i != (cnts-1))
+			if (i != (cnts - 1))
 				sprintf(extra + strlen(extra), ",");
 		}
 	} else if (strcmp(tmp[0], "ableraw") == 0) {
 		efuse_GetCurrentSize(padapter, &raw_cursize);
 		raw_maxsize = efuse_GetMaxSize(padapter);
-		sprintf(extra, "[available raw size] = %d bytes", raw_maxsize-raw_cursize);
+		sprintf(extra, "[available raw size] = %d bytes", raw_maxsize - raw_cursize);
 	} else if (strcmp(tmp[0], "btfmap") == 0) {
 		mapLen = EFUSE_BT_MAX_MAP_LEN;
 		if (rtw_BT_efuse_map_read(padapter, 0, mapLen, pEfuseHal->BTEfuseInitMap) == _FAIL) {
@@ -4763,10 +4763,10 @@ static int rtw_mp_efuse_get(struct net_device *dev,
 			/*  set 512 because the iwpriv's extra size have limit 0x7FF */
 			sprintf(extra + strlen(extra), "0x%03x\t", i);
 			for (j = 0; j < 8; j++)
-				sprintf(extra + strlen(extra), "%02X ", pEfuseHal->BTEfuseInitMap[i+j]);
+				sprintf(extra + strlen(extra), "%02X ", pEfuseHal->BTEfuseInitMap[i + j]);
 			sprintf(extra + strlen(extra), "\t");
 			for (; j < 16; j++)
-				sprintf(extra + strlen(extra), "%02X ", pEfuseHal->BTEfuseInitMap[i+j]);
+				sprintf(extra + strlen(extra), "%02X ", pEfuseHal->BTEfuseInitMap[i + j]);
 			sprintf(extra + strlen(extra), "\n");
 		}
 	} else if (strcmp(tmp[0], "btbmap") == 0) {
@@ -4781,10 +4781,10 @@ static int rtw_mp_efuse_get(struct net_device *dev,
 		for (i = 512; i < 1024; i += 16) {
 			sprintf(extra + strlen(extra), "0x%03x\t", i);
 			for (j = 0; j < 8; j++)
-				sprintf(extra + strlen(extra), "%02X ", pEfuseHal->BTEfuseInitMap[i+j]);
+				sprintf(extra + strlen(extra), "%02X ", pEfuseHal->BTEfuseInitMap[i + j]);
 			sprintf(extra + strlen(extra), "\t");
 			for (; j < 16; j++)
-				sprintf(extra + strlen(extra), "%02X ", pEfuseHal->BTEfuseInitMap[i+j]);
+				sprintf(extra + strlen(extra), "%02X ", pEfuseHal->BTEfuseInitMap[i + j]);
 			sprintf(extra + strlen(extra), "\n");
 		}
 	} else if (strcmp(tmp[0], "btrmap") == 0) {
@@ -4826,10 +4826,10 @@ static int rtw_mp_efuse_get(struct net_device *dev,
 		for (i = 0; i < 512; i += 16) {
 			sprintf(extra + strlen(extra), "0x%03x\t", i);
 			for (j = 0; j < 8; j++)
-				sprintf(extra + strlen(extra), "%02X ", pEfuseHal->fakeBTEfuseModifiedMap[i+j]);
+				sprintf(extra + strlen(extra), "%02X ", pEfuseHal->fakeBTEfuseModifiedMap[i + j]);
 			sprintf(extra + strlen(extra), "\t");
 			for (; j < 16; j++)
-				sprintf(extra + strlen(extra), "%02X ", pEfuseHal->fakeBTEfuseModifiedMap[i+j]);
+				sprintf(extra + strlen(extra), "%02X ", pEfuseHal->fakeBTEfuseModifiedMap[i + j]);
 			sprintf(extra + strlen(extra), "\n");
 		}
 	} else if (strcmp(tmp[0], "btbfake") == 0) {
@@ -4837,10 +4837,10 @@ static int rtw_mp_efuse_get(struct net_device *dev,
 		for (i = 512; i < 1024; i += 16) {
 			sprintf(extra + strlen(extra), "0x%03x\t", i);
 			for (j = 0; j < 8; j++)
-				sprintf(extra + strlen(extra), "%02X ", pEfuseHal->fakeBTEfuseModifiedMap[i+j]);
+				sprintf(extra + strlen(extra), "%02X ", pEfuseHal->fakeBTEfuseModifiedMap[i + j]);
 			sprintf(extra + strlen(extra), "\t");
 			for (; j < 16; j++)
-				sprintf(extra + strlen(extra), "%02X ", pEfuseHal->fakeBTEfuseModifiedMap[i+j]);
+				sprintf(extra + strlen(extra), "%02X ", pEfuseHal->fakeBTEfuseModifiedMap[i + j]);
 			sprintf(extra + strlen(extra), "\n");
 		}
 	} else if (strcmp(tmp[0], "wlrfkmap") == 0) {
@@ -4848,10 +4848,10 @@ static int rtw_mp_efuse_get(struct net_device *dev,
 		for (i = 0; i < EFUSE_MAP_SIZE; i += 16) {
 			sprintf(extra + strlen(extra), "0x%02x\t", i);
 			for (j = 0; j < 8; j++)
-				sprintf(extra + strlen(extra), "%02X ", pEfuseHal->fakeEfuseModifiedMap[i+j]);
+				sprintf(extra + strlen(extra), "%02X ", pEfuseHal->fakeEfuseModifiedMap[i + j]);
 			sprintf(extra + strlen(extra), "\t");
 			for (; j < 16; j++)
-				sprintf(extra + strlen(extra), " %02X", pEfuseHal->fakeEfuseModifiedMap[i+j]);
+				sprintf(extra + strlen(extra), " %02X", pEfuseHal->fakeEfuseModifiedMap[i + j]);
 			sprintf(extra + strlen(extra), "\n");
 		}
 	} else {
@@ -4944,7 +4944,7 @@ static int rtw_mp_efuse_set(struct net_device *dev,
 		addr &= 0xFFF;
 
 		cnts = strlen(tmp[2]);
-		if (cnts%2) {
+		if (cnts % 2) {
 			err = -EINVAL;
 			goto exit;
 		}
@@ -4962,7 +4962,7 @@ static int rtw_mp_efuse_set(struct net_device *dev,
 			setdata[jj] = key_2char2num(tmp[2][kk], tmp[2][kk + 1]);
 		/* Change to check TYPE_EFUSE_MAP_LEN, because 8188E raw 256, logic map over 256. */
 		EFUSE_GetEfuseDefinition(padapter, EFUSE_WIFI, TYPE_EFUSE_MAP_LEN, (void *)&max_available_size, false);
-		if ((addr+cnts) > max_available_size) {
+		if ((addr + cnts) > max_available_size) {
 			DBG_88E("%s: addr(0x%X)+cnts(%d) parameter error!\n", __func__, addr, cnts);
 			err = -EFAULT;
 			goto exit;
@@ -4983,7 +4983,7 @@ static int rtw_mp_efuse_set(struct net_device *dev,
 		addr &= 0xFFF;
 
 		cnts = strlen(tmp[2]);
-		if (cnts%2) {
+		if (cnts % 2) {
 			err = -EINVAL;
 			goto exit;
 		}
@@ -5014,7 +5014,7 @@ static int rtw_mp_efuse_set(struct net_device *dev,
 		/* mac, 00e04c871200 */
 		addr = EEPROM_MAC_ADDR_88EU;
 		cnts = strlen(tmp[1]);
-		if (cnts%2) {
+		if (cnts % 2) {
 			err = -EINVAL;
 			goto exit;
 		}
@@ -5037,7 +5037,7 @@ static int rtw_mp_efuse_set(struct net_device *dev,
 			setdata[jj] = key_2char2num(tmp[1][kk], tmp[1][kk + 1]);
 		/* Change to check TYPE_EFUSE_MAP_LEN, because 8188E raw 256, logic map over 256. */
 		EFUSE_GetEfuseDefinition(padapter, EFUSE_WIFI, TYPE_EFUSE_MAP_LEN, (void *)&max_available_size, false);
-		if ((addr+cnts) > max_available_size) {
+		if ((addr + cnts) > max_available_size) {
 			DBG_88E("%s: addr(0x%X)+cnts(%d) parameter error!\n", __func__, addr, cnts);
 			err = -EFAULT;
 			goto exit;
@@ -5057,7 +5057,7 @@ static int rtw_mp_efuse_set(struct net_device *dev,
 		/*  pidvid, da0b7881 */
 		addr = EEPROM_VID_88EE;
 		cnts = strlen(tmp[1]);
-		if (cnts%2) {
+		if (cnts % 2) {
 			err = -EINVAL;
 			goto exit;
 		}
@@ -5075,7 +5075,7 @@ static int rtw_mp_efuse_set(struct net_device *dev,
 			setdata[jj] = key_2char2num(tmp[1][kk], tmp[1][kk + 1]);
 
 		EFUSE_GetEfuseDefinition(padapter, EFUSE_WIFI, TYPE_AVAILABLE_EFUSE_BYTES_TOTAL, (void *)&max_available_size, false);
-		if ((addr+cnts) > max_available_size) {
+		if ((addr + cnts) > max_available_size) {
 			DBG_88E("%s: addr(0x%X)+cnts(%d) parameter error!\n", __func__, addr, cnts);
 			err = -EFAULT;
 			goto exit;
@@ -5096,7 +5096,7 @@ static int rtw_mp_efuse_set(struct net_device *dev,
 		addr &= 0xFFF;
 
 		cnts = strlen(tmp[2]);
-		if (cnts%2) {
+		if (cnts % 2) {
 			err = -EINVAL;
 			goto exit;
 		}
@@ -5114,7 +5114,7 @@ static int rtw_mp_efuse_set(struct net_device *dev,
 			setdata[jj] = key_2char2num(tmp[2][kk], tmp[2][kk + 1]);
 
 		EFUSE_GetEfuseDefinition(padapter, EFUSE_BT, TYPE_AVAILABLE_EFUSE_BYTES_TOTAL, (void *)&max_available_size, false);
-		if ((addr+cnts) > max_available_size) {
+		if ((addr + cnts) > max_available_size) {
 			DBG_88E("%s: addr(0x%X)+cnts(%d) parameter error!\n", __func__, addr, cnts);
 			err = -EFAULT;
 			goto exit;
@@ -5135,7 +5135,7 @@ static int rtw_mp_efuse_set(struct net_device *dev,
 		addr &= 0xFFF;
 
 		cnts = strlen(tmp[2]);
-		if (cnts%2) {
+		if (cnts % 2) {
 			err = -EINVAL;
 			goto exit;
 		}
@@ -5150,7 +5150,7 @@ static int rtw_mp_efuse_set(struct net_device *dev,
 		DBG_88E("%s: BT tmp data =%s\n", __func__, tmp[2]);
 
 		for (jj = 0, kk = 0; jj < cnts; jj++, kk += 2)
-			pEfuseHal->fakeBTEfuseModifiedMap[addr+jj] = key_2char2num(tmp[2][kk], tmp[2][kk + 1]);
+			pEfuseHal->fakeBTEfuseModifiedMap[addr + jj] = key_2char2num(tmp[2][kk], tmp[2][kk + 1]);
 	} else if (strcmp(tmp[0], "btdumpfake") == 0) {
 		if (rtw_BT_efuse_map_read(padapter, 0, EFUSE_BT_MAX_MAP_LEN, pEfuseHal->fakeBTEfuseModifiedMap) == _SUCCESS) {
 			DBG_88E("%s: BT read all map success\n", __func__);
@@ -5201,7 +5201,7 @@ static int rtw_mp_efuse_set(struct net_device *dev,
 		addr &= 0xFFF;
 
 		cnts = strlen(tmp[2]);
-		if (cnts%2) {
+		if (cnts % 2) {
 			err = -EINVAL;
 			goto exit;
 		}
@@ -5216,7 +5216,7 @@ static int rtw_mp_efuse_set(struct net_device *dev,
 		DBG_88E("%s: map tmp data =%s\n", __func__, tmp[2]);
 
 		for (jj = 0, kk = 0; jj < cnts; jj++, kk += 2)
-			pEfuseHal->fakeEfuseModifiedMap[addr+jj] = key_2char2num(tmp[2][kk], tmp[2][kk + 1]);
+			pEfuseHal->fakeEfuseModifiedMap[addr + jj] = key_2char2num(tmp[2][kk], tmp[2][kk + 1]);
 	}
 
 exit:
@@ -5368,7 +5368,7 @@ static int rtw_mp_read_reg(struct net_device *dev,
 		/*  2 bytes */
 		sprintf(data, "%04x\n", rtw_read16(padapter, addr));
 		for (i = 0; i <= strlen(data); i++) {
-			if (i%2 == 0) {
+			if (i % 2 == 0) {
 				tmp[j] = ' ';
 				j++;
 			}
@@ -5400,7 +5400,7 @@ static int rtw_mp_read_reg(struct net_device *dev,
 		sprintf(data, "%08x", rtw_read32(padapter, addr));
 		/* add read data format blank */
 		for (i = 0; i <= strlen(data); i++) {
-			if (i%2 == 0) {
+			if (i % 2 == 0) {
 				tmp[j] = ' ';
 				j++;
 			}
@@ -5511,7 +5511,7 @@ static int rtw_mp_read_rf(struct net_device *dev,
 	sprintf(data, "%08x", read_rfreg(padapter, path, addr));
 	/* add read data format blank */
 	for (i = 0; i <= strlen(data); i++) {
-		if (i%2 == 0) {
+		if (i % 2 == 0) {
 			tmp[j] = ' ';
 			j++;
 		}
@@ -5601,7 +5601,7 @@ static int rtw_mp_rate(struct net_device *dev,
 	if (rate <= 0x7f)
 		rate = wifirate2_ratetbl_inx((u8)rate);
 	else
-		rate = (rate-0x80+MPT_RATE_MCS0);
+		rate = (rate - 0x80 + MPT_RATE_MCS0);
 
 	if (rate >= MPT_RATE_LAST)
 		return -EINVAL;
@@ -5934,9 +5934,9 @@ static int rtw_mp_arx(struct net_device *dev,
 		OFDM_FA = read_bbreg(padapter, 0xda4, 0x0000FFFF);
 		OFDM_FA = read_bbreg(padapter, 0xda4, 0xFFFF0000);
 		OFDM_FA = read_bbreg(padapter, 0xda8, 0x0000FFFF);
-		CCK_FA = (rtw_read8(padapter, 0xa5b)<<8) | (rtw_read8(padapter, 0xa5c));
+		CCK_FA = (rtw_read8(padapter, 0xa5b) << 8) | (rtw_read8(padapter, 0xa5c));
 
-		sprintf(extra, "Phy Received packet OK:%d CRC error:%d FA Counter: %d", cckok+ofdmok+htok, cckcrc+ofdmcrc+htcrc, OFDM_FA+CCK_FA);
+		sprintf(extra, "Phy Received packet OK:%d CRC error:%d FA Counter: %d", cckok + ofdmok + htok, cckcrc + ofdmcrc + htcrc, OFDM_FA + CCK_FA);
 	}
 	wrqu->length = strlen(extra) + 1;
 	kfree(input);
@@ -5959,7 +5959,7 @@ static int rtw_mp_trx_query(struct net_device *dev,
 
 	sprintf(extra, "Tx OK:%d, Tx Fail:%d, Rx OK:%d, CRC error:%d ", txok, txfail, rxok, rxfail);
 
-	wrqu->length = strlen(extra)+1;
+	wrqu->length = strlen(extra) + 1;
 
 	return 0;
 }
@@ -6101,17 +6101,17 @@ static int rtw_mp_dump(struct net_device *dev,
 	if (strncmp(extra, "all", 4) == 0) {
 		DBG_88E("\n ======= MAC REG =======\n");
 		for (i = 0x0; i < 0x300; i += 4) {
-			if (j%4 == 1)
+			if (j % 4 == 1)
 				DBG_88E("0x%02x", i);
 			DBG_88E(" 0x%08x ", rtw_read32(padapter, i));
-			if ((j++)%4 == 0)
+			if ((j++) % 4 == 0)
 				DBG_88E("\n");
 		}
 		for (i = 0x400; i < 0x1000; i += 4) {
-			if (j%4 == 1)
+			if (j % 4 == 1)
 				DBG_88E("0x%02x", i);
 			DBG_88E(" 0x%08x ", rtw_read32(padapter, i));
-			if ((j++)%4 == 0)
+			if ((j++) % 4 == 0)
 				DBG_88E("\n");
 		}
 
@@ -6127,10 +6127,10 @@ static int rtw_mp_dump(struct net_device *dev,
 		for (path = 0; path < path_nums; path++) {
 			for (i = 0; i < 0x34; i++) {
 				value = rtw_hal_read_rfreg(padapter, path, i, 0xffffffff);
-				if (j%4 == 1)
+				if (j % 4 == 1)
 					DBG_88E("0x%02x ", i);
 				DBG_88E(" 0x%08x ", value);
-				if ((j++)%4 == 0)
+				if ((j++) % 4 == 0)
 					DBG_88E("\n");
 			}
 		}
@@ -6348,7 +6348,7 @@ static int rtw_mp_get(struct net_device *dev,
 		break;
 	case MP_QueryDrvStats:
 		DBG_88E("mp_get MP_QueryDrvStats\n");
-		rtw_mp_QueryDrv (dev, info, wdata, extra);
+		rtw_mp_QueryDrv(dev, info, wdata, extra);
 		break;
 	case MP_PWRTRK:
 		DBG_88E("set case MP_PWRTRK\n");
diff --git a/drivers/staging/r8188eu/os_dep/mlme_linux.c b/drivers/staging/r8188eu/os_dep/mlme_linux.c
index be9166f2b524..e3ee9dc7ab90 100644
--- a/drivers/staging/r8188eu/os_dep/mlme_linux.c
+++ b/drivers/staging/r8188eu/os_dep/mlme_linux.c
@@ -119,13 +119,13 @@ void rtw_report_sec_ie(struct adapter *adapter, u8 authmode, u8 *sec_ie)
 			return;
 		p = buff;
 		p += sprintf(p, "ASSOCINFO(ReqIEs =");
-		len = sec_ie[1]+2;
+		len = sec_ie[1] + 2;
 		len =  (len < IW_CUSTOM_MAX) ? len : IW_CUSTOM_MAX;
 		for (i = 0; i < len; i++)
 			p += sprintf(p, "%02x", sec_ie[i]);
 		p += sprintf(p, ")");
 		memset(&wrqu, 0, sizeof(wrqu));
-		wrqu.data.length = p-buff;
+		wrqu.data.length = p - buff;
 		wrqu.data.length = (wrqu.data.length < IW_CUSTOM_MAX) ?
 				   wrqu.data.length : IW_CUSTOM_MAX;
 		wireless_send_event(adapter->pnetdev, IWEVCUSTOM, &wrqu, buff);
diff --git a/drivers/staging/r8188eu/os_dep/os_intfs.c b/drivers/staging/r8188eu/os_dep/os_intfs.c
index f4bf4732578a..9d7d2b94493b 100644
--- a/drivers/staging/r8188eu/os_dep/os_intfs.c
+++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
@@ -516,7 +516,7 @@ static uint loadparam(struct adapter *padapter,  struct  net_device *pnetdev)
 
 	registry_par->channel = (u8)rtw_channel;
 	registry_par->wireless_mode = (u8)rtw_wireless_mode;
-	registry_par->vrtl_carrier_sense = (u8)rtw_vrtl_carrier_sense ;
+	registry_par->vrtl_carrier_sense = (u8)rtw_vrtl_carrier_sense;
 	registry_par->vcs_type = (u8)rtw_vcs_type;
 	registry_par->rts_thresh = (u16)rtw_rts_thresh;
 	registry_par->frag_thresh = (u16)rtw_frag_thresh;
@@ -658,11 +658,11 @@ u16 rtw_recv_select_queue(struct sk_buff *skb)
 	u32 priority;
 	u8 *pdata = skb->data;
 
-	memcpy(&eth_type, pdata+(ETH_ALEN<<1), 2);
+	memcpy(&eth_type, pdata + (ETH_ALEN << 1), 2);
 
 	switch (eth_type) {
 	case htons(ETH_P_IP):
-		piphdr = (struct iphdr *)(pdata+ETH_HLEN);
+		piphdr = (struct iphdr *)(pdata + ETH_HLEN);
 		dscp = piphdr->tos & 0xfc;
 		priority = dscp >> 5;
 		break;
@@ -716,7 +716,7 @@ struct net_device *rtw_init_netdev(struct adapter *old_padapter)
 	padapter->pnetdev = pnetdev;
 	DBG_88E("register rtw_netdev_ops to netdev_ops\n");
 	pnetdev->netdev_ops = &rtw_netdev_ops;
-	pnetdev->watchdog_timeo = HZ*3; /* 3 second timeout */
+	pnetdev->watchdog_timeo = HZ * 3; /* 3 second timeout */
 	pnetdev->wireless_handlers = (struct iw_handler_def *)&rtw_handlers_def;
 
 	/* step 2. */
diff --git a/drivers/staging/r8188eu/os_dep/osdep_service.c b/drivers/staging/r8188eu/os_dep/osdep_service.c
index c8a15959cff3..6218a9052ee9 100644
--- a/drivers/staging/r8188eu/os_dep/osdep_service.c
+++ b/drivers/staging/r8188eu/os_dep/osdep_service.c
@@ -61,7 +61,7 @@ void *rtw_malloc2d(int h, int w, int size)
 		return NULL;
 
 	for (j = 0; j < h; j++)
-		a[j] = ((char *)(a+h)) + j*w*size;
+		a[j] = ((char *)(a + h)) + j * w * size;
 
 	return a;
 }
@@ -112,15 +112,15 @@ inline u32 rtw_ms_to_systime(u32 ms)
 /*  the input parameter start use the same unit as jiffies */
 inline s32 rtw_get_passing_time_ms(u32 start)
 {
-	return rtw_systime_to_ms(jiffies-start);
+	return rtw_systime_to_ms(jiffies - start);
 }
 
 void rtw_usleep_os(int us)
 {
-	if (1 < (us/1000))
+	if (1 < (us / 1000))
 		msleep(1);
 	else
-		msleep((us/1000) + 1);
+		msleep((us / 1000) + 1);
 }
 
 #define RTW_SUSPEND_LOCK_NAME "rtw_wifi"
@@ -282,7 +282,7 @@ void rtw_buf_update(u8 **buf, u32 *buf_len, u8 *src, u32 src_len)
  */
 inline bool rtw_cbuf_full(struct rtw_cbuf *cbuf)
 {
-	return (cbuf->write == cbuf->read-1) ? true : false;
+	return (cbuf->write == cbuf->read - 1) ? true : false;
 }
 
 /**
@@ -312,7 +312,7 @@ bool rtw_cbuf_push(struct rtw_cbuf *cbuf, void *buf)
 	if (0)
 		DBG_88E("%s on %u\n", __func__, cbuf->write);
 	cbuf->bufs[cbuf->write] = buf;
-	cbuf->write = (cbuf->write+1)%cbuf->size;
+	cbuf->write = (cbuf->write + 1) % cbuf->size;
 
 	return _SUCCESS;
 }
@@ -333,7 +333,7 @@ void *rtw_cbuf_pop(struct rtw_cbuf *cbuf)
 	if (0)
 		DBG_88E("%s on %u\n", __func__, cbuf->read);
 	buf = cbuf->bufs[cbuf->read];
-	cbuf->read = (cbuf->read+1)%cbuf->size;
+	cbuf->read = (cbuf->read + 1) % cbuf->size;
 
 	return buf;
 }
@@ -348,7 +348,7 @@ struct rtw_cbuf *rtw_cbuf_alloc(u32 size)
 {
 	struct rtw_cbuf *cbuf;
 
-	cbuf = kmalloc(sizeof(*cbuf) + sizeof(void *)*size, GFP_KERNEL);
+	cbuf = kmalloc(sizeof(*cbuf) + sizeof(void *) * size, GFP_KERNEL);
 
 	if (cbuf) {
 		cbuf->write = 0;
diff --git a/drivers/staging/r8188eu/os_dep/recv_linux.c b/drivers/staging/r8188eu/os_dep/recv_linux.c
index 1fb01f135741..b4c5333bfff0 100644
--- a/drivers/staging/r8188eu/os_dep/recv_linux.c
+++ b/drivers/staging/r8188eu/os_dep/recv_linux.c
@@ -78,7 +78,7 @@ void rtw_handle_tkip_mic_err(struct adapter *padapter, u8 bgroup)
 	} else {
 		cur_time = jiffies;
 
-		if (cur_time - psecuritypriv->last_mic_err_time < 60*HZ) {
+		if (cur_time - psecuritypriv->last_mic_err_time < 60 * HZ) {
 			psecuritypriv->btkip_countermeasure = true;
 			psecuritypriv->last_mic_err_time = 0;
 			psecuritypriv->btkip_countermeasure_time = cur_time;
diff --git a/drivers/staging/r8188eu/os_dep/rtw_android.c b/drivers/staging/r8188eu/os_dep/rtw_android.c
index bdd381606ba6..6b0b36b956a7 100644
--- a/drivers/staging/r8188eu/os_dep/rtw_android.c
+++ b/drivers/staging/r8188eu/os_dep/rtw_android.c
@@ -62,7 +62,7 @@ static int g_wifi_on = true;
 int rtw_android_cmdstr_to_num(char *cmdstr)
 {
 	int cmd_num;
-	for (cmd_num=0; cmd_num < ANDROID_WIFI_CMD_MAX; cmd_num++)
+	for (cmd_num = 0; cmd_num < ANDROID_WIFI_CMD_MAX; cmd_num++)
 		if (!strncasecmp(cmdstr, android_wifi_cmd_str[cmd_num],
 		    strlen(android_wifi_cmd_str[cmd_num])))
 			break;
diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
index 3e5f4b5eb0fc..0f28ed77ef65 100644
--- a/drivers/staging/r8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
@@ -312,7 +312,7 @@ static void process_spec_devid(const struct usb_device_id *pdid)
 		flags = specific_device_id_tbl[i].flags;
 
 		if ((pdid->idVendor == vid) && (pdid->idProduct == pid) &&
-		    (flags&SPEC_DEV_ID_DISABLE_HT)) {
+		    (flags & SPEC_DEV_ID_DISABLE_HT)) {
 			rtw_ht_enable = 0;
 			rtw_cbw40_enable = 0;
 			rtw_ampdu_enable = 0;
diff --git a/drivers/staging/r8188eu/os_dep/xmit_linux.c b/drivers/staging/r8188eu/os_dep/xmit_linux.c
index 4f1ce346b3a5..30a5da986967 100644
--- a/drivers/staging/r8188eu/os_dep/xmit_linux.c
+++ b/drivers/staging/r8188eu/os_dep/xmit_linux.c
@@ -41,7 +41,7 @@ void _rtw_open_pktfile(struct sk_buff *pktptr, struct pkt_file *pfile)
 
 }
 
-uint _rtw_pktfile_read (struct pkt_file *pfile, u8 *rmem, uint rlen)
+uint _rtw_pktfile_read(struct pkt_file *pfile, u8 *rmem, uint rlen)
 {
 	uint	len = 0;
 
@@ -49,7 +49,7 @@ uint _rtw_pktfile_read (struct pkt_file *pfile, u8 *rmem, uint rlen)
 	len = (rlen > len) ? len : rlen;
 
 	if (rmem)
-		skb_copy_bits(pfile->pkt, pfile->buf_len-pfile->pkt_len, rmem, len);
+		skb_copy_bits(pfile->pkt, pfile->buf_len - pfile->pkt_len, rmem, len);
 
 	pfile->cur_addr += len;
 	pfile->pkt_len -= len;
@@ -104,7 +104,7 @@ void rtw_os_xmit_resource_free(struct adapter *padapter,
 	kfree(pxmitbuf->pallocated_buf);
 }
 
-#define WMM_XMIT_THRESHOLD	(NR_XMITFRAME*2/5)
+#define WMM_XMIT_THRESHOLD	(NR_XMITFRAME * 2 / 5)
 
 void rtw_os_pkt_complete(struct adapter *padapter, struct sk_buff *pkt)
 {
@@ -230,7 +230,7 @@ int rtw_xmit_entry(struct sk_buff *pkt, struct  net_device *pnetdev)
 	if (!rtw_mc2u_disable && check_fwstate(pmlmepriv, WIFI_AP_STATE) &&
 	    (IP_MCAST_MAC(pkt->data) || ICMPV6_MCAST_MAC(pkt->data)) &&
 	    (padapter->registrypriv.wifi_spec == 0)) {
-		if (pxmitpriv->free_xmitframe_cnt > (NR_XMITFRAME/4)) {
+		if (pxmitpriv->free_xmitframe_cnt > (NR_XMITFRAME / 4)) {
 			res = rtw_mlcst2unicst(padapter, pkt);
 			if (res)
 				goto exit;
-- 
2.32.0

