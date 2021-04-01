Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2313511F3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 11:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234260AbhDAJWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 05:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233831AbhDAJWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 05:22:03 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B45C0613E6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 02:22:02 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id l4so1810891ejc.10
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 02:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=86zxo1/sJcJoxWGFjz59uwTVDAmuhUQqlfWdFxETMkQ=;
        b=L8qlgVgPbLK+0m+yYXoJcPuRDDQ+1isEOe4rEWsb7kXgUo7Aotx9St7gb/nCGiLl31
         mfkHzpzbycAO3bpejysaIkNIKiY6FUfLE3y+VeGqzZcVwnUW+LiRgUueufqBPsLpXZSi
         ZAuM+kqUk9vC1ICwxlXwYrU94xYofeaooEMFaWSwQsne4KbAuYn/PNQcFjFJOYothgbV
         558Q5uPKeqviQItrxLitYbLBXFGArZhkOx80ZX8F9joLoc2Yk2cQQZr+klSq13giFepU
         DvS36mR/mqf7tyxhNGYMcFou3lBnSTXn5vYhzF+FRakiR7JZKC4yuFsDcYGpLnuZ792K
         +AlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=86zxo1/sJcJoxWGFjz59uwTVDAmuhUQqlfWdFxETMkQ=;
        b=p3Hs/nqNKtnqWb95iSewAsFf7YY21JiKAwExHExh5hGzcaBfBTOmAbbfam2g2WjPo9
         SW6OgGaW91BoGUUByRrda0lVf90S73SM5Ex7V5lpn4IxwUmseOM3uXeDf0nBlMLoeEap
         f4tm6jd8BXrVFAGfyo2U3FTye/W5cw4fER6hPBbzgjNdBGQ8TGLKLKpY8PGchgqZ2GT2
         fXCOA7+Zif2l6jH/NES9rfoOZff3JahIz0t9BgeGY4oUfQXSEitx4BhvzXEJXgc4S0QB
         Ta9tLip8MN43WIjhA60IVBDY2jE9XdGq7V37s+3cLvJluEdSLWEfpyPMktSA8FEkrvJE
         E24g==
X-Gm-Message-State: AOAM5337/FhnGE7dB/+DKdKOpIkYe+7aV92A7WxP1psN61f2hrTahzwN
        gYx51wcnPpJ5h+oR1IBSY5A=
X-Google-Smtp-Source: ABdhPJw8AkJTroHwMLB3p6Q/tTgpuU2WXIV3N6kgiTY80VNzqUkLLEztoWN/1co1q9zSs1DXSE3gcw==
X-Received: by 2002:a17:906:2b46:: with SMTP id b6mr7954558ejg.521.1617268921558;
        Thu, 01 Apr 2021 02:22:01 -0700 (PDT)
Received: from agape ([5.171.80.247])
        by smtp.gmail.com with ESMTPSA id a9sm3078631eds.33.2021.04.01.02.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 02:22:01 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, dan.carpenter@oracle.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 23/49] staging: rtl8723bs: remove RT_TRACE logs in core/rtw_ieee80211.c
Date:   Thu,  1 Apr 2021 11:20:53 +0200
Message-Id: <e14b2c73776b02c8c2e8089d27296762775a99a9.1617268327.git.fabioaiuto83@gmail.com>
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
 .../staging/rtl8723bs/core/rtw_ieee80211.c    | 41 -------------------
 1 file changed, 41 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
index e931afc3ba22..3cf2c4db14f6 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -489,8 +489,6 @@ int rtw_parse_wpa_ie(u8 *wpa_ie, int wpa_ie_len, int *group_cipher, int *pairwis
 		left -= WPA_SELECTOR_LEN;
 
 	} else if (left > 0) {
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("%s: ie length mismatch, %u too much", __func__, left));
-
 		return _FAIL;
 	}
 
@@ -502,8 +500,6 @@ int rtw_parse_wpa_ie(u8 *wpa_ie, int wpa_ie_len, int *group_cipher, int *pairwis
 		left -= 2;
 
 		if (count == 0 || left < count * WPA_SELECTOR_LEN) {
-			RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("%s: ie count botch (pairwise), "
-						"count %u left %u", __func__, count, left));
 			return _FAIL;
 		}
 
@@ -515,7 +511,6 @@ int rtw_parse_wpa_ie(u8 *wpa_ie, int wpa_ie_len, int *group_cipher, int *pairwis
 		}
 
 	} else if (left == 1) {
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("%s: ie too short (for key mgmt)",   __func__));
 		return _FAIL;
 	}
 
@@ -523,7 +518,6 @@ int rtw_parse_wpa_ie(u8 *wpa_ie, int wpa_ie_len, int *group_cipher, int *pairwis
 		if (left >= 6) {
 			pos += 2;
 			if (!memcmp(pos, SUITE_1X, 4)) {
-				RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("%s : there has 802.1x auth\n", __func__));
 				*is_8021x = 1;
 			}
 		}
@@ -560,7 +554,6 @@ int rtw_parse_wpa2_ie(u8 *rsn_ie, int rsn_ie_len, int *group_cipher, int *pairwi
 		left -= RSN_SELECTOR_LEN;
 
 	} else if (left > 0) {
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("%s: ie length mismatch, %u too much", __func__, left));
 		return _FAIL;
 	}
 
@@ -572,8 +565,6 @@ int rtw_parse_wpa2_ie(u8 *rsn_ie, int rsn_ie_len, int *group_cipher, int *pairwi
 		left -= 2;
 
 		if (count == 0 || left < count * RSN_SELECTOR_LEN) {
-			RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("%s: ie count botch (pairwise), "
-						 "count %u left %u", __func__, count, left));
 			return _FAIL;
 		}
 
@@ -585,8 +576,6 @@ int rtw_parse_wpa2_ie(u8 *rsn_ie, int rsn_ie_len, int *group_cipher, int *pairwi
 		}
 
 	} else if (left == 1) {
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("%s: ie too short (for key mgmt)",  __func__));
-
 		return _FAIL;
 	}
 
@@ -594,7 +583,6 @@ int rtw_parse_wpa2_ie(u8 *rsn_ie, int rsn_ie_len, int *group_cipher, int *pairwi
 		if (left >= 6) {
 			pos += 2;
 			if (!memcmp(pos, SUITE_1X, 4)) {
-				RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("%s (): there has 802.1x auth\n", __func__));
 				*is_8021x = 1;
 			}
 		}
@@ -630,9 +618,6 @@ int rtw_get_wapi_ie(u8 *in_ie, uint in_len, u8 *wapi_ie, u16 *wapi_len)
 				memcpy(wapi_ie, &in_ie[cnt], in_ie[cnt+1]+2);
 
 				for (i = 0; i < (in_ie[cnt+1]+2); i = i+8) {
-					RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("\n %2x,%2x,%2x,%2x,%2x,%2x,%2x,%2x\n",
-								wapi_ie[i], wapi_ie[i+1], wapi_ie[i+2], wapi_ie[i+3], wapi_ie[i+4],
-								wapi_ie[i+5], wapi_ie[i+6], wapi_ie[i+7]));
 				}
 			}
 
@@ -668,15 +653,10 @@ void rtw_get_sec_ie(u8 *in_ie, uint in_len, u8 *rsn_ie, u16 *rsn_len, u8 *wpa_ie
 		authmode = in_ie[cnt];
 
 		if ((authmode == WLAN_EID_VENDOR_SPECIFIC) && (!memcmp(&in_ie[cnt+2], &wpa_oui[0], 4))) {
-				RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("\n rtw_get_wpa_ie: sec_idx =%d in_ie[cnt+1]+2 =%d\n", sec_idx, in_ie[cnt+1]+2));
-
 				if (wpa_ie) {
 				memcpy(wpa_ie, &in_ie[cnt], in_ie[cnt+1]+2);
 
 				for (i = 0; i < (in_ie[cnt+1]+2); i = i+8) {
-						RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("\n %2x,%2x,%2x,%2x,%2x,%2x,%2x,%2x\n",
-									wpa_ie[i], wpa_ie[i+1], wpa_ie[i+2], wpa_ie[i+3], wpa_ie[i+4],
-									wpa_ie[i+5], wpa_ie[i+6], wpa_ie[i+7]));
 					}
 				}
 
@@ -684,15 +664,10 @@ void rtw_get_sec_ie(u8 *in_ie, uint in_len, u8 *rsn_ie, u16 *rsn_len, u8 *wpa_ie
 				cnt += in_ie[cnt+1]+2;  /* get next */
 		} else {
 			if (authmode == WLAN_EID_RSN) {
-				RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("\n get_rsn_ie: sec_idx =%d in_ie[cnt+1]+2 =%d\n", sec_idx, in_ie[cnt+1]+2));
-
 				if (rsn_ie) {
 				memcpy(rsn_ie, &in_ie[cnt], in_ie[cnt+1]+2);
 
 				for (i = 0; i < (in_ie[cnt+1]+2); i = i+8) {
-						RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("\n %2x,%2x,%2x,%2x,%2x,%2x,%2x,%2x\n",
-									rsn_ie[i], rsn_ie[i+1], rsn_ie[i+2], rsn_ie[i+3], rsn_ie[i+4],
-									rsn_ie[i+5], rsn_ie[i+6], rsn_ie[i+7]));
 					}
 				}
 
@@ -1138,28 +1113,20 @@ static int rtw_get_cipher_info(struct wlan_network *pnetwork)
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
@@ -1189,10 +1156,6 @@ void rtw_get_bcn_info(struct wlan_network *pnetwork)
 		pnetwork->BcnInfo.encryp_protocol = ENCRYP_PROTOCOL_OPENSYS;
 	}
 	rtw_get_sec_ie(pnetwork->network.IEs, pnetwork->network.IELength, NULL, &rsn_len, NULL, &wpa_len);
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_get_bcn_info: ssid =%s\n", pnetwork->network.Ssid.Ssid));
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_get_bcn_info: wpa_len =%d rsn_len =%d\n", wpa_len, rsn_len));
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_get_bcn_info: ssid =%s\n", pnetwork->network.Ssid.Ssid));
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_get_bcn_info: wpa_len =%d rsn_len =%d\n", wpa_len, rsn_len));
 
 	if (rsn_len > 0) {
 		pnetwork->BcnInfo.encryp_protocol = ENCRYP_PROTOCOL_WPA2;
@@ -1202,10 +1165,6 @@ void rtw_get_bcn_info(struct wlan_network *pnetwork)
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

