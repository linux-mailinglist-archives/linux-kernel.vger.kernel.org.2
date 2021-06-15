Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9B83A72D6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 02:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbhFOARx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 20:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbhFOARw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 20:17:52 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B1FC0617AF
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 17:15:38 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id if15so10615369qvb.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 17:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jtzdjPua4BzII2/0sQfLrcJ1nPkPWZZW4uWK3qEzi+g=;
        b=mMLyuF6Y61XaY/MyNUio/MyeNrQ4M340hQqngZ4OJXsrEwERZSRT9sfYyXmUDbnF1k
         jzRdnak8JoIswqb3W/4JNj96LRCAyD4ws0Lraii7ek2KkIK4AY9MnbIact94Op6WJzIu
         m643GGd86r2mRSOsJmIf+VnM8Do7iUFadacy5R2+tDBS2VUW/DwE3oO1zDbIKWOK6zkC
         jnHMTlFlhbIDok6AjXvbKl+Q5Mfsgj+75Yd5zfaXpL4tZU+nDp8xEwCYHw7jT8x0h7J/
         dsBM9eEbwrvZERGKgL0HviHE1leXbQWbp52EBBi4j+QWPukVTYv6Kp371HAyqAF0oQWG
         4wUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jtzdjPua4BzII2/0sQfLrcJ1nPkPWZZW4uWK3qEzi+g=;
        b=Q0+8qJmP888CEeZJ4R0CJfbbAKIMlqdMt9w5fzSgXFKfI8ZoZOa/ce6Dqy2lrTF4sB
         h4Q/mguFbcu4Ml4yl3IODkPEP2SQ+zM9QoWcN52N5Nc1ExbGVEebpr+nRZBFduvfdP72
         vQ4bPCaOFFwe912n8dj2rQ8ujdJ24f93iEZkuk9ds7nvTz4ELTgw7nuUk6xP6cGPs8Np
         VWSdw+pC2S905ukhQo+s/QJCJUQXdq41pzdrCKTcxjy5wRZ0Rg7tmWQIU1AtKkVsbllp
         HHnO19G2fH9ya9Q07OwEuUj0MP2zjZrX4KC7PzejVs3rpkiRp8y4A4LSj6lfSddYj77j
         PnCA==
X-Gm-Message-State: AOAM532YlHeXAfRTOe5Z/ZD24IX2dZyWQc4hvgklu9os9bjd17laJ7nc
        qWGJKrY5M/WQU+7WbDf8ErIPAECx/EhqoS2X
X-Google-Smtp-Source: ABdhPJyKCvk6uYSUq9rJ1qJni59qL9CsXaXUCdFlSk+P9GE3td2Yo8QL5G8HP80TrVAVOStVtozP3Q==
X-Received: by 2002:a0c:fd44:: with SMTP id j4mr2007316qvs.12.1623716137321;
        Mon, 14 Jun 2021 17:15:37 -0700 (PDT)
Received: from localhost.localdomain (5.d.e.a.c.b.a.1.5.0.9.4.d.7.7.d.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:d77d:4905:1abc:aed5])
        by smtp.gmail.com with ESMTPSA id m199sm11244248qke.71.2021.06.14.17.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 17:15:37 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH 04/28] staging: rtl8188eu: remove all DBG_88E calls from core/rtw_wlan_util.c
Date:   Tue, 15 Jun 2021 01:14:43 +0100
Message-Id: <20210615001507.1171-5-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210615001507.1171-1-phil@philpotter.co.uk>
References: <20210615001507.1171-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove all DBG_88E calls from core/rtw_wlan_util.c as this macro is
unnecessary, and many of these calls are dubious in terms of necessity.
Removing all calls will ultimately allow the removal of the macro
itself.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 .../staging/rtl8188eu/core/rtw_wlan_util.c    | 80 ++++---------------
 1 file changed, 16 insertions(+), 64 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
index c9043f49ec9e..e3c8bdc9cbc1 100644
--- a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
@@ -521,8 +521,6 @@ void WMMOnAssocRsp(struct adapter *padapter)
 			edca[XMIT_VO_QUEUE] = acParm;
 			break;
 		}
-
-		DBG_88E("WMM(%x): %x, %x\n", ACI, ACM, acParm);
 	}
 
 	if (padapter->registrypriv.acm_method == 1)
@@ -556,10 +554,8 @@ void WMMOnAssocRsp(struct adapter *padapter)
 		}
 	}
 
-	for (i = 0; i < 4; i++) {
+	for (i = 0; i < 4; i++)
 		pxmitpriv->wmm_para_seq[i] = inx[i];
-		DBG_88E("wmm_para_seq(%d): %d\n", i, pxmitpriv->wmm_para_seq[i]);
-	}
 }
 
 static void bwmode_update_check(struct adapter *padapter, struct ndis_802_11_var_ie *pIE)
@@ -708,8 +704,6 @@ void HTOnAssocRsp(struct adapter *padapter)
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
 
-	DBG_88E("%s\n", __func__);
-
 	if ((pmlmeinfo->HT_info_enable) && (pmlmeinfo->HT_caps_enable)) {
 		pmlmeinfo->HT_enable = 1;
 	} else {
@@ -803,16 +797,11 @@ int rtw_check_bcn_info(struct adapter  *Adapter, u8 *pframe, u32 packet_len)
 
 	len = packet_len - sizeof(struct ieee80211_hdr_3addr);
 
-	if (len > MAX_IE_SZ) {
-		DBG_88E("%s IE too long for survey event\n", __func__);
+	if (len > MAX_IE_SZ)
 		return _FAIL;
-	}
 
-	if (memcmp(cur_network->network.MacAddress, pbssid, 6)) {
-		DBG_88E("Oops: rtw_check_network_encrypt linked but recv other bssid bcn\n%pM %pM\n",
-			(pbssid), (cur_network->network.MacAddress));
+	if (memcmp(cur_network->network.MacAddress, pbssid, 6))
 		return true;
-	}
 
 	bssid = kzalloc(sizeof(struct wlan_bssid_ex), GFP_ATOMIC);
 	if (!bssid)
@@ -850,11 +839,6 @@ int rtw_check_bcn_info(struct adapter  *Adapter, u8 *pframe, u32 packet_len)
 	}
 	if (ht_cap_info != cur_network->BcnInfo.ht_cap_info ||
 	    ((ht_info_infos_0 & 0x03) != (cur_network->BcnInfo.ht_info_infos_0 & 0x03))) {
-		DBG_88E("%s bcn now: ht_cap_info:%x ht_info_infos_0:%x\n", __func__,
-			ht_cap_info, ht_info_infos_0);
-		DBG_88E("%s bcn link: ht_cap_info:%x ht_info_infos_0:%x\n", __func__,
-			cur_network->BcnInfo.ht_cap_info, cur_network->BcnInfo.ht_info_infos_0);
-		DBG_88E("%s bw mode change, disconnect\n", __func__);
 		/* bcn_info_update */
 		cur_network->BcnInfo.ht_cap_info = ht_cap_info;
 		cur_network->BcnInfo.ht_info_infos_0 = ht_info_infos_0;
@@ -868,18 +852,13 @@ int rtw_check_bcn_info(struct adapter  *Adapter, u8 *pframe, u32 packet_len)
 		bcn_channel = *(p + 2);
 	} else {/* In 5G, some ap do not have DSSET IE checking HT info for channel */
 		p = rtw_get_ie(bssid->ies + _FIXED_IE_LENGTH_, WLAN_EID_HT_OPERATION, &len, bssid->ie_length - _FIXED_IE_LENGTH_);
-		if (pht_info) {
+		if (pht_info)
 			bcn_channel = pht_info->primary_channel;
-		} else { /* we don't find channel IE, so don't check it */
-			DBG_88E("Oops: %s we don't find channel IE, so don't check it\n", __func__);
+		else /* we don't find channel IE, so don't check it */
 			bcn_channel = Adapter->mlmeextpriv.cur_channel;
-		}
 	}
-	if (bcn_channel != Adapter->mlmeextpriv.cur_channel) {
-		DBG_88E("%s beacon channel:%d cur channel:%d disconnect\n", __func__,
-			bcn_channel, Adapter->mlmeextpriv.cur_channel);
+	if (bcn_channel != Adapter->mlmeextpriv.cur_channel)
 		goto _mismatch;
-	}
 
 	/* checking SSID */
 	ssid_len = 0;
@@ -899,10 +878,8 @@ int rtw_check_bcn_info(struct adapter  *Adapter, u8 *pframe, u32 packet_len)
 
 	if (memcmp(bssid->ssid.ssid, cur_network->network.ssid.ssid, 32) ||
 	    bssid->ssid.ssid_length != cur_network->network.ssid.ssid_length) {
-		if (bssid->ssid.ssid[0] != '\0' && bssid->ssid.ssid_length != 0) { /* not hidden ssid */
-			DBG_88E("%s(), SSID is not match return FAIL\n", __func__);
+		if (bssid->ssid.ssid[0] != '\0' && bssid->ssid.ssid_length != 0) /* not hidden ssid */
 			goto _mismatch;
-		}
 	}
 
 	/* check encryption info */
@@ -916,10 +893,8 @@ int rtw_check_bcn_info(struct adapter  *Adapter, u8 *pframe, u32 packet_len)
 	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_,
 		 ("%s(): cur_network->network.Privacy is %d, bssid.Privacy is %d\n",
 		 __func__, cur_network->network.Privacy, bssid->Privacy));
-	if (cur_network->network.Privacy != bssid->Privacy) {
-		DBG_88E("%s(), privacy is not match return FAIL\n", __func__);
+	if (cur_network->network.Privacy != bssid->Privacy)
 		goto _mismatch;
-	}
 
 	rtw_get_sec_ie(bssid->ies, bssid->ie_length, NULL, &rsn_len, NULL, &wpa_len);
 
@@ -932,10 +907,8 @@ int rtw_check_bcn_info(struct adapter  *Adapter, u8 *pframe, u32 packet_len)
 			encryp_protocol = ENCRYP_PROTOCOL_WEP;
 	}
 
-	if (cur_network->BcnInfo.encryp_protocol != encryp_protocol) {
-		DBG_88E("%s(): encryption protocol is not match , return FAIL\n", __func__);
+	if (cur_network->BcnInfo.encryp_protocol != encryp_protocol)
 		goto _mismatch;
-	}
 
 	if (encryp_protocol == ENCRYP_PROTOCOL_WPA || encryp_protocol == ENCRYP_PROTOCOL_WPA2) {
 		pbuf = rtw_get_wpa_ie(&bssid->ies[12], &wpa_ielen,
@@ -961,17 +934,11 @@ int rtw_check_bcn_info(struct adapter  *Adapter, u8 *pframe, u32 packet_len)
 
 		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_,
 			 ("%s cur_network->group_cipher is %d: %d\n", __func__, cur_network->BcnInfo.group_cipher, group_cipher));
-		if (pairwise_cipher != cur_network->BcnInfo.pairwise_cipher || group_cipher != cur_network->BcnInfo.group_cipher) {
-			DBG_88E("%s pairwise_cipher(%x:%x) or group_cipher(%x:%x) is not match , return FAIL\n", __func__,
-				pairwise_cipher, cur_network->BcnInfo.pairwise_cipher,
-				group_cipher, cur_network->BcnInfo.group_cipher);
+		if (pairwise_cipher != cur_network->BcnInfo.pairwise_cipher || group_cipher != cur_network->BcnInfo.group_cipher)
 			goto _mismatch;
-		}
 
-		if (is_8021x != cur_network->BcnInfo.is_8021x) {
-			DBG_88E("%s authentication is not match , return FAIL\n", __func__);
+		if (is_8021x != cur_network->BcnInfo.is_8021x)
 			goto _mismatch;
-		}
 	}
 
 	kfree(bssid);
@@ -1192,38 +1159,27 @@ unsigned char check_assoc_AP(u8 *pframe, uint len)
 		case WLAN_EID_VENDOR_SPECIFIC:
 			if ((!memcmp(pIE->data, ARTHEROS_OUI1, 3)) ||
 			    (!memcmp(pIE->data, ARTHEROS_OUI2, 3))) {
-				DBG_88E("link to Artheros AP\n");
 				return HT_IOT_PEER_ATHEROS;
 			} else if ((!memcmp(pIE->data, BROADCOM_OUI1, 3)) ||
 				   (!memcmp(pIE->data, BROADCOM_OUI2, 3))) {
-				DBG_88E("link to Broadcom AP\n");
 				return HT_IOT_PEER_BROADCOM;
 			} else if (!memcmp(pIE->data, MARVELL_OUI, 3)) {
-				DBG_88E("link to Marvell AP\n");
 				return HT_IOT_PEER_MARVELL;
 			} else if (!memcmp(pIE->data, RALINK_OUI, 3)) {
-				if (!ralink_vendor_flag) {
+				if (!ralink_vendor_flag)
 					ralink_vendor_flag = 1;
-				} else {
-					DBG_88E("link to Ralink AP\n");
+				else
 					return HT_IOT_PEER_RALINK;
-				}
 			} else if (!memcmp(pIE->data, CISCO_OUI, 3)) {
-				DBG_88E("link to Cisco AP\n");
 				return HT_IOT_PEER_CISCO;
 			} else if (!memcmp(pIE->data, REALTEK_OUI, 3)) {
-				DBG_88E("link to Realtek 96B\n");
 				return HT_IOT_PEER_REALTEK;
 			} else if (!memcmp(pIE->data, AIRGOCAP_OUI, 3)) {
-				DBG_88E("link to Airgo Cap\n");
 				return HT_IOT_PEER_AIRGO;
 			} else if (!memcmp(pIE->data, EPIGRAM_OUI, 3)) {
 				epigram_vendor_flag = 1;
-				if (ralink_vendor_flag) {
-					DBG_88E("link to Tenda W311R AP\n");
+				if (ralink_vendor_flag)
 					return HT_IOT_PEER_TENDA;
-				}
-				DBG_88E("Capture EPIGRAM_OUI\n");
 			} else {
 				break;
 			}
@@ -1235,14 +1191,10 @@ unsigned char check_assoc_AP(u8 *pframe, uint len)
 		i += (pIE->Length + 2);
 	}
 
-	if (ralink_vendor_flag && !epigram_vendor_flag) {
-		DBG_88E("link to Ralink AP\n");
+	if (ralink_vendor_flag && !epigram_vendor_flag)
 		return HT_IOT_PEER_RALINK;
-	} else if (ralink_vendor_flag && epigram_vendor_flag) {
-		DBG_88E("link to Tenda W311R AP\n");
+	else if (ralink_vendor_flag && epigram_vendor_flag)
 		return HT_IOT_PEER_TENDA;
-	}
-	DBG_88E("link to new AP\n");
 	return HT_IOT_PEER_UNKNOWN;
 }
 
-- 
2.30.2

