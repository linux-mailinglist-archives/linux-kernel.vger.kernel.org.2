Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF2E134FD2F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 11:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234969AbhCaJlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 05:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234847AbhCaJkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 05:40:42 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26CEAC061574
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 02:40:42 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id jy13so29119027ejc.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 02:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bUXrcYwIpWtkwZFUmJ2qOI2urMf6a+x1VFUa5JHWo7k=;
        b=c+wY+yMU8EsFcWnGWOUwlre30XnqhDycgf62Xtzl6JqSMa74Hf+4zoLjRnGxn5x2Kb
         J/9wyBZLgznV/P+rhSBiLiMtYh/0eey0UQkIFw2hm0kgJ484j493uKhRuL9U5ZHHvbLP
         UYR9oLYCBB7r7IvnFa8UUwClPfLWBN30tZfdEbUU38P1OUpZ8HTIZteCn1phVdEgouKG
         AKloWGbrsAsDx3b5Pe9Triigr6BEX7zZ6zH5rz1psryl0d906j85+E9gxpNpUl5PxKwE
         ZdO15EIKa9gLqiKPv1HHRN50sXZ+jwfIbZBsPw57edngfrJXa3YqZmB8FLCMkGOg+drM
         Xhzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bUXrcYwIpWtkwZFUmJ2qOI2urMf6a+x1VFUa5JHWo7k=;
        b=mPm1r6NaYcCzfgGx/m2TSrcouHQDLE81AQTS89pxTIsj7k0XdkVGB6BpDwuBPkmaJl
         ALUw33JD31K8xg1s0ve1bRFguI0rgISyM92oo0XePDQSFdicxYBt2AT0ovZrMP7u2xsN
         yB8PoZRcG/pibSiz+J0BKzMb6YYSsH/HGZMTKW+C5I0s0q9KmQkydPRynubE4t8bnczC
         2egHkM9j7JXLcrGuPcRTnOrHVhumlAtx7bBb3H24+PFywZ4/VsdVxn3WeT1z7quRTAiK
         2vdLSt2ZHPmnT/Aa6QYfmowJGvStzBxBvervyIi+Xvivtqs2XL+9amTTzOsjK0/9j9pq
         yfKw==
X-Gm-Message-State: AOAM533ktmBKm2j8/HSPtoBIlWkTMmq4cgI1tIjRpjS2V7MxyGxyEIRj
        aepxX/Ze3naw3HXNEzipaNs=
X-Google-Smtp-Source: ABdhPJyOy3tMITi8VP/vyVAh/Jr6Oi4uZNCJdTrM1Z6mhXgoOcW7rnHMn3ACpymyuws37Sr73Bv9fQ==
X-Received: by 2002:a17:906:130c:: with SMTP id w12mr2528799ejb.253.1617183640912;
        Wed, 31 Mar 2021 02:40:40 -0700 (PDT)
Received: from agape ([5.171.73.44])
        by smtp.gmail.com with ESMTPSA id s20sm1110327edu.93.2021.03.31.02.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 02:40:40 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 15/40] staging: rtl8723bs: replace RT_TRACE with public printk wrappers in core/rtw_ieee80211.c
Date:   Wed, 31 Mar 2021 11:39:43 +0200
Message-Id: <f47ab96ce6c828c58bfca8ffb895a33f6071e4d4.1617183374.git.fabioaiuto83@gmail.com>
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
 .../staging/rtl8723bs/core/rtw_ieee80211.c    | 116 +++++++++++-------
 1 file changed, 74 insertions(+), 42 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
index e931afc3ba22..a7589f919c35 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -489,7 +489,8 @@ int rtw_parse_wpa_ie(u8 *wpa_ie, int wpa_ie_len, int *group_cipher, int *pairwis
 		left -= WPA_SELECTOR_LEN;
 
 	} else if (left > 0) {
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("%s: ie length mismatch, %u too much", __func__, left));
+		pr_err("%s %s: ie length mismatch, %u too much",
+		       DRIVER_PREFIX, __func__, left);
 
 		return _FAIL;
 	}
@@ -502,8 +503,9 @@ int rtw_parse_wpa_ie(u8 *wpa_ie, int wpa_ie_len, int *group_cipher, int *pairwis
 		left -= 2;
 
 		if (count == 0 || left < count * WPA_SELECTOR_LEN) {
-			RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("%s: ie count botch (pairwise), "
-						"count %u left %u", __func__, count, left));
+			pr_err("%s %s: ie count botch (pairwise), "
+			       "count %u left %u", DRIVER_PREFIX,
+			       __func__, count, left);
 			return _FAIL;
 		}
 
@@ -515,7 +517,7 @@ int rtw_parse_wpa_ie(u8 *wpa_ie, int wpa_ie_len, int *group_cipher, int *pairwis
 		}
 
 	} else if (left == 1) {
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("%s: ie too short (for key mgmt)",   __func__));
+		pr_err("%s %s: ie too short (for key mgmt)", DRIVER_PREFIX, __func__);
 		return _FAIL;
 	}
 
@@ -523,7 +525,8 @@ int rtw_parse_wpa_ie(u8 *wpa_ie, int wpa_ie_len, int *group_cipher, int *pairwis
 		if (left >= 6) {
 			pos += 2;
 			if (!memcmp(pos, SUITE_1X, 4)) {
-				RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("%s : there has 802.1x auth\n", __func__));
+				pr_info("%s %s : there has 802.1x auth\n",
+					DRIVER_PREFIX, __func__);
 				*is_8021x = 1;
 			}
 		}
@@ -560,7 +563,8 @@ int rtw_parse_wpa2_ie(u8 *rsn_ie, int rsn_ie_len, int *group_cipher, int *pairwi
 		left -= RSN_SELECTOR_LEN;
 
 	} else if (left > 0) {
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("%s: ie length mismatch, %u too much", __func__, left));
+		pr_err("%s %s: ie length mismatch, %u too much",
+		       DRIVER_PREFIX, __func__, left);
 		return _FAIL;
 	}
 
@@ -572,8 +576,9 @@ int rtw_parse_wpa2_ie(u8 *rsn_ie, int rsn_ie_len, int *group_cipher, int *pairwi
 		left -= 2;
 
 		if (count == 0 || left < count * RSN_SELECTOR_LEN) {
-			RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("%s: ie count botch (pairwise), "
-						 "count %u left %u", __func__, count, left));
+			pr_err("%s %s: ie count botch (pairwise), "
+			       "count %u left %u",
+			       DRIVER_PREFIX, __func__, count, left);
 			return _FAIL;
 		}
 
@@ -585,7 +590,8 @@ int rtw_parse_wpa2_ie(u8 *rsn_ie, int rsn_ie_len, int *group_cipher, int *pairwi
 		}
 
 	} else if (left == 1) {
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("%s: ie too short (for key mgmt)",  __func__));
+		pr_err("%s %s: ie too short (for key mgmt)",
+		       DRIVER_PREFIX, __func__);
 
 		return _FAIL;
 	}
@@ -594,7 +600,8 @@ int rtw_parse_wpa2_ie(u8 *rsn_ie, int rsn_ie_len, int *group_cipher, int *pairwi
 		if (left >= 6) {
 			pos += 2;
 			if (!memcmp(pos, SUITE_1X, 4)) {
-				RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("%s (): there has 802.1x auth\n", __func__));
+				pr_info("%s %s: there has 802.1x auth\n",
+					DRIVER_PREFIX, __func__);
 				*is_8021x = 1;
 			}
 		}
@@ -630,9 +637,16 @@ int rtw_get_wapi_ie(u8 *in_ie, uint in_len, u8 *wapi_ie, u16 *wapi_len)
 				memcpy(wapi_ie, &in_ie[cnt], in_ie[cnt+1]+2);
 
 				for (i = 0; i < (in_ie[cnt+1]+2); i = i+8) {
-					RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("\n %2x,%2x,%2x,%2x,%2x,%2x,%2x,%2x\n",
-								wapi_ie[i], wapi_ie[i+1], wapi_ie[i+2], wapi_ie[i+3], wapi_ie[i+4],
-								wapi_ie[i+5], wapi_ie[i+6], wapi_ie[i+7]));
+					pr_info("%s %2x,%2x,%2x,%2x,%2x,%2x,%2x,%2x\n",
+						DRIVER_PREFIX,
+						wapi_ie[i],
+						wapi_ie[i+1],
+						wapi_ie[i+2],
+						wapi_ie[i+3],
+						wapi_ie[i+4],
+						wapi_ie[i+5],
+						wapi_ie[i+6],
+						wapi_ie[i+7]);
 				}
 			}
 
@@ -668,31 +682,47 @@ void rtw_get_sec_ie(u8 *in_ie, uint in_len, u8 *rsn_ie, u16 *rsn_len, u8 *wpa_ie
 		authmode = in_ie[cnt];
 
 		if ((authmode == WLAN_EID_VENDOR_SPECIFIC) && (!memcmp(&in_ie[cnt+2], &wpa_oui[0], 4))) {
-				RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("\n rtw_get_wpa_ie: sec_idx =%d in_ie[cnt+1]+2 =%d\n", sec_idx, in_ie[cnt+1]+2));
+			pr_info("%s %s: sec_idx =%d in_ie[cnt+1]+2 =%d\n",
+				DRIVER_PREFIX, __func__, sec_idx, in_ie[cnt+1]+2);
 
-				if (wpa_ie) {
+			if (wpa_ie) {
 				memcpy(wpa_ie, &in_ie[cnt], in_ie[cnt+1]+2);
 
 				for (i = 0; i < (in_ie[cnt+1]+2); i = i+8) {
-						RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("\n %2x,%2x,%2x,%2x,%2x,%2x,%2x,%2x\n",
-									wpa_ie[i], wpa_ie[i+1], wpa_ie[i+2], wpa_ie[i+3], wpa_ie[i+4],
-									wpa_ie[i+5], wpa_ie[i+6], wpa_ie[i+7]));
-					}
+					pr_info("%s %2x,%2x,%2x,%2x,%2x,%2x,%2x,%2x\n",
+						DRIVER_PREFIX,
+						wpa_ie[i],
+						wpa_ie[i+1],
+						wpa_ie[i+2],
+						wpa_ie[i+3],
+						wpa_ie[i+4],
+						wpa_ie[i+5],
+						wpa_ie[i+6],
+						wpa_ie[i+7]);
 				}
+			}
 
-				*wpa_len = in_ie[cnt+1]+2;
-				cnt += in_ie[cnt+1]+2;  /* get next */
+			*wpa_len = in_ie[cnt+1]+2;
+			cnt += in_ie[cnt+1]+2;  /* get next */
 		} else {
 			if (authmode == WLAN_EID_RSN) {
-				RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("\n get_rsn_ie: sec_idx =%d in_ie[cnt+1]+2 =%d\n", sec_idx, in_ie[cnt+1]+2));
+				pr_info("%s %s: sec_idx =%d in_ie[cnt+1]+2 =%d\n",
+					DRIVER_PREFIX, __func__, sec_idx, in_ie[cnt+1]+2);
 
 				if (rsn_ie) {
 				memcpy(rsn_ie, &in_ie[cnt], in_ie[cnt+1]+2);
 
-				for (i = 0; i < (in_ie[cnt+1]+2); i = i+8) {
-						RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("\n %2x,%2x,%2x,%2x,%2x,%2x,%2x,%2x\n",
-									rsn_ie[i], rsn_ie[i+1], rsn_ie[i+2], rsn_ie[i+3], rsn_ie[i+4],
-									rsn_ie[i+5], rsn_ie[i+6], rsn_ie[i+7]));
+					for (i = 0; i < (in_ie[cnt+1]+2); i = i+8) {
+						pr_info("%s %2x,%2x,%2x,%2x,%2x,%2x,%2x,%2x\n",
+							DRIVER_PREFIX,
+							rsn_ie[i],
+							rsn_ie[i+1],
+							rsn_ie[i+2],
+							rsn_ie[i+3],
+							rsn_ie[i+4],
+							rsn_ie[i+5],
+							rsn_ie[i+6],
+							rsn_ie[i+7]);
 					}
 				}
 
@@ -1138,28 +1168,30 @@ static int rtw_get_cipher_info(struct wlan_network *pnetwork)
 	pbuf = rtw_get_wpa_ie(&pnetwork->network.IEs[12], &wpa_ielen, pnetwork->network.IELength-12);
 
 	if (pbuf && (wpa_ielen > 0)) {
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_get_cipher_info: wpa_ielen: %d", wpa_ielen));
+		pr_info("%s %s: wpa_ielen: %d", DRIVER_PREFIX, __func__, wpa_ielen);
 		if (_SUCCESS == rtw_parse_wpa_ie(pbuf, wpa_ielen+2, &group_cipher, &pairwise_cipher, &is8021x)) {
 			pnetwork->BcnInfo.pairwise_cipher = pairwise_cipher;
 			pnetwork->BcnInfo.group_cipher = group_cipher;
 			pnetwork->BcnInfo.is_8021x = is8021x;
-			RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("%s: pnetwork->pairwise_cipher: %d, is_8021x is %d",
-						__func__, pnetwork->BcnInfo.pairwise_cipher, pnetwork->BcnInfo.is_8021x));
+			pr_info("%s %s: pnetwork->pairwise_cipher: %d, is_8021x is %d",
+				DRIVER_PREFIX, __func__, pnetwork->BcnInfo.pairwise_cipher,
+				pnetwork->BcnInfo.is_8021x);
 			ret = _SUCCESS;
 		}
 	} else {
 		pbuf = rtw_get_wpa2_ie(&pnetwork->network.IEs[12], &wpa_ielen, pnetwork->network.IELength-12);
 
 		if (pbuf && (wpa_ielen > 0)) {
-			RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("get RSN IE\n"));
+			pr_info("%s get RSN IE\n", DRIVER_PREFIX);
 			if (_SUCCESS == rtw_parse_wpa2_ie(pbuf, wpa_ielen+2, &group_cipher, &pairwise_cipher, &is8021x)) {
-				RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("get RSN IE  OK!!!\n"));
+				pr_info("%s get RSN IE  OK!!!\n", DRIVER_PREFIX);
 				pnetwork->BcnInfo.pairwise_cipher = pairwise_cipher;
 				pnetwork->BcnInfo.group_cipher = group_cipher;
 				pnetwork->BcnInfo.is_8021x = is8021x;
-				RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("%s: pnetwork->pairwise_cipher: %d,"
-							"pnetwork->group_cipher is %d, is_8021x is %d",	__func__, pnetwork->BcnInfo.pairwise_cipher,
-							pnetwork->BcnInfo.group_cipher, pnetwork->BcnInfo.is_8021x));
+				pr_info("%s %s: pnetwork->pairwise_cipher: %d,"
+					"pnetwork->group_cipher is %d, is_8021x is %d",
+					DRIVER_PREFIX, __func__, pnetwork->BcnInfo.pairwise_cipher,
+					pnetwork->BcnInfo.group_cipher, pnetwork->BcnInfo.is_8021x);
 				ret = _SUCCESS;
 			}
 		}
@@ -1189,10 +1221,10 @@ void rtw_get_bcn_info(struct wlan_network *pnetwork)
 		pnetwork->BcnInfo.encryp_protocol = ENCRYP_PROTOCOL_OPENSYS;
 	}
 	rtw_get_sec_ie(pnetwork->network.IEs, pnetwork->network.IELength, NULL, &rsn_len, NULL, &wpa_len);
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_get_bcn_info: ssid =%s\n", pnetwork->network.Ssid.Ssid));
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_get_bcn_info: wpa_len =%d rsn_len =%d\n", wpa_len, rsn_len));
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_get_bcn_info: ssid =%s\n", pnetwork->network.Ssid.Ssid));
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_get_bcn_info: wpa_len =%d rsn_len =%d\n", wpa_len, rsn_len));
+	pr_info("%s %s: ssid =%s\n", DRIVER_PREFIX, __func__, pnetwork->network.Ssid.Ssid);
+	pr_info("%s %s: wpa_len =%d rsn_len =%d\n", DRIVER_PREFIX, __func__, wpa_len, rsn_len);
+	pr_info("%s %s: ssid =%s\n", DRIVER_PREFIX, __func__, pnetwork->network.Ssid.Ssid);
+	pr_info("%s %s: wpa_len =%d rsn_len =%d\n", DRIVER_PREFIX, __func__, wpa_len, rsn_len);
 
 	if (rsn_len > 0) {
 		pnetwork->BcnInfo.encryp_protocol = ENCRYP_PROTOCOL_WPA2;
@@ -1202,10 +1234,10 @@ void rtw_get_bcn_info(struct wlan_network *pnetwork)
 		if (bencrypt)
 			pnetwork->BcnInfo.encryp_protocol = ENCRYP_PROTOCOL_WEP;
 	}
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_get_bcn_info: pnetwork->encryp_protocol is %x\n",
-				pnetwork->BcnInfo.encryp_protocol));
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_get_bcn_info: pnetwork->encryp_protocol is %x\n",
-				pnetwork->BcnInfo.encryp_protocol));
+	pr_info("%s %s: pnetwork->encryp_protocol is %x\n",
+		DRIVER_PREFIX, __func__, pnetwork->BcnInfo.encryp_protocol);
+	pr_info("%s %s: pnetwork->encryp_protocol is %x\n",
+		DRIVER_PREFIX, __func__, pnetwork->BcnInfo.encryp_protocol);
 	rtw_get_cipher_info(pnetwork);
 
 	/* get bwmode and ch_offset */
-- 
2.20.1

