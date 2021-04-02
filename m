Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28EAE352E6D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 19:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236289AbhDBRcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 13:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236059AbhDBRbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 13:31:07 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98496C061797
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 10:31:05 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id w203-20020a1c49d40000b029010c706d0642so5409925wma.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 10:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PRAycMPkk3BeYju0V4ytoFfLBPPMJZ5EAZwyvpPYyTM=;
        b=CBmnH1dsX8VvGAQcBwyxqG6O1rRjomMIPuxH2kaeJkAuHbdpp2HS2rmnmdNphuMe8R
         ilKkHXEdL8nm2JYru72dizCAGkZl6RqHalOgEFoPxngW6I1KKv1NKwK8+/16jkkRU9gv
         DLhcj6dG05083MixSkv7UVmwXkobP88Q9syaHW093eh59QglR3H8YwFXqP9vInDNpkKM
         dh2OnOLq8CVcZ/wwM/ttroxMQiAehb+0uA+1k6zTY40J1hmxZObePqiE/DXHIzWdGge5
         RAExcbVhZ74waEVfh2hG470/uUVOedrPjK1bXTLhDe4mZO0xQeFO52gHlUoPtzSvIlr1
         JTCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PRAycMPkk3BeYju0V4ytoFfLBPPMJZ5EAZwyvpPYyTM=;
        b=Uaba7xhMYA+FJrs7ZLu30Mb50n6UIY5oev/HPDWx7nc1yMxOMFDlnd2BVxLOYh8w0W
         TN5PP022ZYA07OF+92UiOvX1irH+55nszP95PfrHEJtsVzd4Vlng3ve+/OYVCt+/SE6A
         9x0mEHCBW3XbIFlbwFW0yaJRf3DwMe/NJbpqkr+sf6lL0effPA78o+x972CrDEXri2bk
         WjeKqAX2ej+aJMjBS4W0d3NZb6iDRIF3iVxNp4W9ToqOqnnwEjsQJLX/LMJJBVvM93Q3
         KNt8FSGElK+jHKgIGJ4GLZYrLkuMjGeFzgYC2+AwLhn9yqu+wwUKEwxBSMHrMXFp35fR
         WI6g==
X-Gm-Message-State: AOAM530flf8tB5txCOCf9V5jetHj0ZQKehdEvJE3CWZb0avwCP78C3oG
        zLGh2Y66+IkmjrjdisK9It0=
X-Google-Smtp-Source: ABdhPJy/0BJ5n2EC0Z050VO68T3P48DDPFa+mdCFHQC2l5WhawlTWmeaLYIYu97tCrw1KhH5gVk8og==
X-Received: by 2002:a1c:7905:: with SMTP id l5mr13949305wme.181.1617384664379;
        Fri, 02 Apr 2021 10:31:04 -0700 (PDT)
Received: from agape ([5.171.81.4])
        by smtp.gmail.com with ESMTPSA id 1sm35074162wmj.0.2021.04.02.10.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 10:31:04 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH v2 29/30] staging: rtl8723bs: remove RT_TRACE logs in core/rtw_ieee80211.c
Date:   Fri,  2 Apr 2021 19:30:11 +0200
Message-Id: <7cf7a92877b586ef9e5a6eec1b388a438519c1f9.1617384172.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617384172.git.fabioaiuto83@gmail.com>
References: <cover.1617384172.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove all RT_TRACE logs

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 .../staging/rtl8723bs/core/rtw_ieee80211.c    | 90 ++++---------------
 1 file changed, 15 insertions(+), 75 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
index e931afc3ba22..eb2058f2d139 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -488,11 +488,8 @@ int rtw_parse_wpa_ie(u8 *wpa_ie, int wpa_ie_len, int *group_cipher, int *pairwis
 		pos += WPA_SELECTOR_LEN;
 		left -= WPA_SELECTOR_LEN;
 
-	} else if (left > 0) {
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("%s: ie length mismatch, %u too much", __func__, left));
-
+	} else if (left > 0)
 		return _FAIL;
-	}
 
 	/* pairwise_cipher */
 	if (left >= 2) {
@@ -501,11 +498,8 @@ int rtw_parse_wpa_ie(u8 *wpa_ie, int wpa_ie_len, int *group_cipher, int *pairwis
 		pos += 2;
 		left -= 2;
 
-		if (count == 0 || left < count * WPA_SELECTOR_LEN) {
-			RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("%s: ie count botch (pairwise), "
-						"count %u left %u", __func__, count, left));
+		if (count == 0 || left < count * WPA_SELECTOR_LEN)
 			return _FAIL;
-		}
 
 		for (i = 0; i < count; i++) {
 			*pairwise_cipher |= rtw_get_wpa_cipher_suite(pos);
@@ -514,16 +508,13 @@ int rtw_parse_wpa_ie(u8 *wpa_ie, int wpa_ie_len, int *group_cipher, int *pairwis
 			left -= WPA_SELECTOR_LEN;
 		}
 
-	} else if (left == 1) {
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("%s: ie too short (for key mgmt)",   __func__));
+	} else if (left == 1)
 		return _FAIL;
-	}
 
 	if (is_8021x) {
 		if (left >= 6) {
 			pos += 2;
 			if (!memcmp(pos, SUITE_1X, 4)) {
-				RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("%s : there has 802.1x auth\n", __func__));
 				*is_8021x = 1;
 			}
 		}
@@ -559,10 +550,8 @@ int rtw_parse_wpa2_ie(u8 *rsn_ie, int rsn_ie_len, int *group_cipher, int *pairwi
 		pos += RSN_SELECTOR_LEN;
 		left -= RSN_SELECTOR_LEN;
 
-	} else if (left > 0) {
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("%s: ie length mismatch, %u too much", __func__, left));
+	} else if (left > 0)
 		return _FAIL;
-	}
 
 	/* pairwise_cipher */
 	if (left >= 2) {
@@ -571,11 +560,8 @@ int rtw_parse_wpa2_ie(u8 *rsn_ie, int rsn_ie_len, int *group_cipher, int *pairwi
 		pos += 2;
 		left -= 2;
 
-		if (count == 0 || left < count * RSN_SELECTOR_LEN) {
-			RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("%s: ie count botch (pairwise), "
-						 "count %u left %u", __func__, count, left));
+		if (count == 0 || left < count * RSN_SELECTOR_LEN)
 			return _FAIL;
-		}
 
 		for (i = 0; i < count; i++) {
 			*pairwise_cipher |= rtw_get_wpa2_cipher_suite(pos);
@@ -584,19 +570,14 @@ int rtw_parse_wpa2_ie(u8 *rsn_ie, int rsn_ie_len, int *group_cipher, int *pairwi
 			left -= RSN_SELECTOR_LEN;
 		}
 
-	} else if (left == 1) {
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("%s: ie too short (for key mgmt)",  __func__));
-
+	} else if (left == 1)
 		return _FAIL;
-	}
 
 	if (is_8021x) {
 		if (left >= 6) {
 			pos += 2;
-			if (!memcmp(pos, SUITE_1X, 4)) {
-				RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("%s (): there has 802.1x auth\n", __func__));
+			if (!memcmp(pos, SUITE_1X, 4))
 				*is_8021x = 1;
-			}
 		}
 	}
 
@@ -607,7 +588,7 @@ int rtw_parse_wpa2_ie(u8 *rsn_ie, int rsn_ie_len, int *group_cipher, int *pairwi
 int rtw_get_wapi_ie(u8 *in_ie, uint in_len, u8 *wapi_ie, u16 *wapi_len)
 {
 	int len = 0;
-	u8 authmode, i;
+	u8 authmode;
 	uint	cnt;
 	u8 wapi_oui1[4] = {0x0, 0x14, 0x72, 0x01};
 	u8 wapi_oui2[4] = {0x0, 0x14, 0x72, 0x02};
@@ -626,16 +607,9 @@ int rtw_get_wapi_ie(u8 *in_ie, uint in_len, u8 *wapi_ie, u16 *wapi_len)
 		/* if (authmode == WLAN_EID_BSS_AC_ACCESS_DELAY) */
 		if (authmode == WLAN_EID_BSS_AC_ACCESS_DELAY && (!memcmp(&in_ie[cnt+6], wapi_oui1, 4) ||
 					!memcmp(&in_ie[cnt+6], wapi_oui2, 4))) {
-			if (wapi_ie) {
+			if (wapi_ie)
 				memcpy(wapi_ie, &in_ie[cnt], in_ie[cnt+1]+2);
 
-				for (i = 0; i < (in_ie[cnt+1]+2); i = i+8) {
-					RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("\n %2x,%2x,%2x,%2x,%2x,%2x,%2x,%2x\n",
-								wapi_ie[i], wapi_ie[i+1], wapi_ie[i+2], wapi_ie[i+3], wapi_ie[i+4],
-								wapi_ie[i+5], wapi_ie[i+6], wapi_ie[i+7]));
-				}
-			}
-
 			if (wapi_len)
 				*wapi_len = in_ie[cnt+1]+2;
 
@@ -654,7 +628,7 @@ int rtw_get_wapi_ie(u8 *in_ie, uint in_len, u8 *wapi_ie, u16 *wapi_len)
 
 void rtw_get_sec_ie(u8 *in_ie, uint in_len, u8 *rsn_ie, u16 *rsn_len, u8 *wpa_ie, u16 *wpa_len)
 {
-	u8 authmode, sec_idx, i;
+	u8 authmode, sec_idx;
 	u8 wpa_oui[4] = {0x0, 0x50, 0xf2, 0x01};
 	uint	cnt;
 
@@ -668,33 +642,15 @@ void rtw_get_sec_ie(u8 *in_ie, uint in_len, u8 *rsn_ie, u16 *rsn_len, u8 *wpa_ie
 		authmode = in_ie[cnt];
 
 		if ((authmode == WLAN_EID_VENDOR_SPECIFIC) && (!memcmp(&in_ie[cnt+2], &wpa_oui[0], 4))) {
-				RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("\n rtw_get_wpa_ie: sec_idx =%d in_ie[cnt+1]+2 =%d\n", sec_idx, in_ie[cnt+1]+2));
-
-				if (wpa_ie) {
+			if (wpa_ie)
 				memcpy(wpa_ie, &in_ie[cnt], in_ie[cnt+1]+2);
 
-				for (i = 0; i < (in_ie[cnt+1]+2); i = i+8) {
-						RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("\n %2x,%2x,%2x,%2x,%2x,%2x,%2x,%2x\n",
-									wpa_ie[i], wpa_ie[i+1], wpa_ie[i+2], wpa_ie[i+3], wpa_ie[i+4],
-									wpa_ie[i+5], wpa_ie[i+6], wpa_ie[i+7]));
-					}
-				}
-
-				*wpa_len = in_ie[cnt+1]+2;
-				cnt += in_ie[cnt+1]+2;  /* get next */
+			*wpa_len = in_ie[cnt+1]+2;
+			cnt += in_ie[cnt+1]+2;  /* get next */
 		} else {
 			if (authmode == WLAN_EID_RSN) {
-				RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("\n get_rsn_ie: sec_idx =%d in_ie[cnt+1]+2 =%d\n", sec_idx, in_ie[cnt+1]+2));
-
-				if (rsn_ie) {
-				memcpy(rsn_ie, &in_ie[cnt], in_ie[cnt+1]+2);
-
-				for (i = 0; i < (in_ie[cnt+1]+2); i = i+8) {
-						RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("\n %2x,%2x,%2x,%2x,%2x,%2x,%2x,%2x\n",
-									rsn_ie[i], rsn_ie[i+1], rsn_ie[i+2], rsn_ie[i+3], rsn_ie[i+4],
-									rsn_ie[i+5], rsn_ie[i+6], rsn_ie[i+7]));
-					}
-				}
+				if (rsn_ie)
+					memcpy(rsn_ie, &in_ie[cnt], in_ie[cnt + 1] + 2);
 
 				*rsn_len = in_ie[cnt+1]+2;
 				cnt += in_ie[cnt+1]+2;  /* get next */
@@ -1138,28 +1094,20 @@ static int rtw_get_cipher_info(struct wlan_network *pnetwork)
 	pbuf = rtw_get_wpa_ie(&pnetwork->network.IEs[12], &wpa_ielen, pnetwork->network.IELength-12);
 
 	if (pbuf && (wpa_ielen > 0)) {
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_get_cipher_info: wpa_ielen: %d", wpa_ielen));
 		if (_SUCCESS == rtw_parse_wpa_ie(pbuf, wpa_ielen+2, &group_cipher, &pairwise_cipher, &is8021x)) {
 			pnetwork->BcnInfo.pairwise_cipher = pairwise_cipher;
 			pnetwork->BcnInfo.group_cipher = group_cipher;
 			pnetwork->BcnInfo.is_8021x = is8021x;
-			RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("%s: pnetwork->pairwise_cipher: %d, is_8021x is %d",
-						__func__, pnetwork->BcnInfo.pairwise_cipher, pnetwork->BcnInfo.is_8021x));
 			ret = _SUCCESS;
 		}
 	} else {
 		pbuf = rtw_get_wpa2_ie(&pnetwork->network.IEs[12], &wpa_ielen, pnetwork->network.IELength-12);
 
 		if (pbuf && (wpa_ielen > 0)) {
-			RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("get RSN IE\n"));
 			if (_SUCCESS == rtw_parse_wpa2_ie(pbuf, wpa_ielen+2, &group_cipher, &pairwise_cipher, &is8021x)) {
-				RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("get RSN IE  OK!!!\n"));
 				pnetwork->BcnInfo.pairwise_cipher = pairwise_cipher;
 				pnetwork->BcnInfo.group_cipher = group_cipher;
 				pnetwork->BcnInfo.is_8021x = is8021x;
-				RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("%s: pnetwork->pairwise_cipher: %d,"
-							"pnetwork->group_cipher is %d, is_8021x is %d",	__func__, pnetwork->BcnInfo.pairwise_cipher,
-							pnetwork->BcnInfo.group_cipher, pnetwork->BcnInfo.is_8021x));
 				ret = _SUCCESS;
 			}
 		}
@@ -1189,10 +1137,6 @@ void rtw_get_bcn_info(struct wlan_network *pnetwork)
 		pnetwork->BcnInfo.encryp_protocol = ENCRYP_PROTOCOL_OPENSYS;
 	}
 	rtw_get_sec_ie(pnetwork->network.IEs, pnetwork->network.IELength, NULL, &rsn_len, NULL, &wpa_len);
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_get_bcn_info: ssid =%s\n", pnetwork->network.Ssid.Ssid));
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_get_bcn_info: wpa_len =%d rsn_len =%d\n", wpa_len, rsn_len));
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_get_bcn_info: ssid =%s\n", pnetwork->network.Ssid.Ssid));
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_get_bcn_info: wpa_len =%d rsn_len =%d\n", wpa_len, rsn_len));
 
 	if (rsn_len > 0) {
 		pnetwork->BcnInfo.encryp_protocol = ENCRYP_PROTOCOL_WPA2;
@@ -1202,10 +1146,6 @@ void rtw_get_bcn_info(struct wlan_network *pnetwork)
 		if (bencrypt)
 			pnetwork->BcnInfo.encryp_protocol = ENCRYP_PROTOCOL_WEP;
 	}
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_get_bcn_info: pnetwork->encryp_protocol is %x\n",
-				pnetwork->BcnInfo.encryp_protocol));
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_get_bcn_info: pnetwork->encryp_protocol is %x\n",
-				pnetwork->BcnInfo.encryp_protocol));
 	rtw_get_cipher_info(pnetwork);
 
 	/* get bwmode and ch_offset */
-- 
2.20.1

