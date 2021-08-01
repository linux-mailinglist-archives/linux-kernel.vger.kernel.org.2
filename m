Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5514C3DCD25
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Aug 2021 21:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbhHATE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 15:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbhHATEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 15:04:52 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5097CC0613D5
        for <linux-kernel@vger.kernel.org>; Sun,  1 Aug 2021 12:04:44 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id h14so18752078wrx.10
        for <linux-kernel@vger.kernel.org>; Sun, 01 Aug 2021 12:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NpTwLnCxwPlsiO75U1mpq3quc8qCs+Kzpzmdx4C3tN0=;
        b=NXhS4qjwarQZncyb80lqrs3m1b8T1OEofnBoZdQO0ZbJmRUJiPjHIYT8/C+7qHh4gq
         dq7BHAgM1dhYU8+rSrWl+eAwAsqbe86PPBGNM59Fi8szuqMdS8piZUkMagZXCb3H0XUE
         ZIGG2if4VJZ1T2kRjm5g1EqvE4R0RG+OY0SfK4/ehvHbLmieOLkFD2hm4W8AYBFJQ99K
         d4vovd4Gfir7QRdTYVb64ZOYp6KtWlEFlzhvNTvHDUUP8gXtwbuLsy03xySArVUrZjf7
         MguJZ4cwEwmD1u84dEFJMQiNleocyag1p1rd2w4guA0Zn4CKe0Sx2kppODU31pC4W6+f
         2CgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NpTwLnCxwPlsiO75U1mpq3quc8qCs+Kzpzmdx4C3tN0=;
        b=gxIB/HJkjsK3QcAjMojRx5t+SyyjY2J4vfGo2e4lEJVM1OCTFJG6gnB1hVZ0400rLD
         nz0hOgAJEAFDgCDWJ3Q9ny3Hmutzx9Gin+ck8QhP8snmUusB05FPdQPe4jbwf1Etldeg
         TX61O/vjlo9vwLEgnRxDiYdckcTIFk2vF2GqdTUbNA0WCFDpBvga5g3k6hA0SdvATjjY
         hsPHYqiFK6TkiVyoUJsN8w1pgEpW0VZG/W7jQxMM/uKrT68zOdTX1NjL/q6Z7bLnUKh3
         o22K5E/g5XBt+cDJT9kVrxwQ8HacFg6vMbwtlGm4aqNA3rMMbmbnbVxK4vHuW+YoD6hg
         X9Tg==
X-Gm-Message-State: AOAM532tF68Y2ihojm1fULcgI397b+0aYgurdnxjCvNVEV3HK94UYgj7
        FpsXh3HLo3FIdKvoQYG0UvCA7w==
X-Google-Smtp-Source: ABdhPJyT9kp8MmXCT2ZIDmxrd9+pFRu22FkOOK1rQ7C4mUNZlR4/i7YppADxjuf1LBBOUJGOis2dWA==
X-Received: by 2002:adf:d1c7:: with SMTP id b7mr13969073wrd.108.1627844682886;
        Sun, 01 Aug 2021 12:04:42 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id c10sm8196026wmb.40.2021.08.01.12.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Aug 2021 12:04:42 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, martin@kaiser.cx
Subject: [PATCH 04/15] staging: r8188eu: remove RT_TRACE calls from core/rtw_ieee80211.c
Date:   Sun,  1 Aug 2021 20:04:26 +0100
Message-Id: <20210801190437.82017-5-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210801190437.82017-1-phil@philpotter.co.uk>
References: <20210801190437.82017-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove RT_TRACE macro calls from core/rtw_ieee80211.c, so that ultimately the
macro definition itself can eventually be removed.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/core/rtw_ieee80211.c | 67 ++------------------
 1 file changed, 6 insertions(+), 61 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_ieee80211.c b/drivers/staging/r8188eu/core/rtw_ieee80211.c
index f5ea93e2fff9..a6c7a9846e22 100644
--- a/drivers/staging/r8188eu/core/rtw_ieee80211.c
+++ b/drivers/staging/r8188eu/core/rtw_ieee80211.c
@@ -531,7 +531,6 @@ int rtw_parse_wpa_ie(u8 *wpa_ie, int wpa_ie_len, int *group_cipher, int *pairwis
 		pos += WPA_SELECTOR_LEN;
 		left -= WPA_SELECTOR_LEN;
 	} else if (left > 0) {
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("%s: ie length mismatch, %u too much", __func__, left));
 		return _FAIL;
 	}
 
@@ -541,11 +540,8 @@ int rtw_parse_wpa_ie(u8 *wpa_ie, int wpa_ie_len, int *group_cipher, int *pairwis
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
@@ -554,17 +550,14 @@ int rtw_parse_wpa_ie(u8 *wpa_ie, int wpa_ie_len, int *group_cipher, int *pairwis
 			left -= WPA_SELECTOR_LEN;
 		}
 	} else if (left == 1) {
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("%s: ie too short (for key mgmt)",   __func__));
 		return _FAIL;
 	}
 
 	if (is_8021x) {
 		if (left >= 6) {
 			pos += 2;
-			if (!memcmp(pos, SUITE_1X, 4)) {
-				RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("%s : there has 802.1x auth\n", __func__));
+			if (!memcmp(pos, SUITE_1X, 4))
 				*is_8021x = 1;
-			}
 		}
 	}
 
@@ -598,7 +591,6 @@ int rtw_parse_wpa2_ie(u8 *rsn_ie, int rsn_ie_len, int *group_cipher, int *pairwi
 		left -= RSN_SELECTOR_LEN;
 
 	} else if (left > 0) {
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("%s: ie length mismatch, %u too much", __func__, left));
 		return _FAIL;
 	}
 
@@ -608,11 +600,8 @@ int rtw_parse_wpa2_ie(u8 *rsn_ie, int rsn_ie_len, int *group_cipher, int *pairwi
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
@@ -622,18 +611,14 @@ int rtw_parse_wpa2_ie(u8 *rsn_ie, int rsn_ie_len, int *group_cipher, int *pairwi
 		}
 
 	} else if (left == 1) {
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("%s: ie too short (for key mgmt)",  __func__));
-
 		return _FAIL;
 	}
 
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
 	return ret;
@@ -655,40 +640,16 @@ int rtw_get_sec_ie(u8 *in_ie, uint in_len, u8 *rsn_ie, u16 *rsn_len, u8 *wpa_ie,
 		authmode = in_ie[cnt];
 
 		if ((authmode == _WPA_IE_ID_) && (!memcmp(&in_ie[cnt+2], &wpa_oui[0], 4))) {
-				RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_,
-					 ("\n rtw_get_wpa_ie: sec_idx =%d in_ie[cnt+1]+2 =%d\n",
-					 sec_idx, in_ie[cnt+1]+2));
-
-				if (wpa_ie) {
+				if (wpa_ie)
 					memcpy(wpa_ie, &in_ie[cnt], in_ie[cnt+1]+2);
 
-					for (i = 0; i < (in_ie[cnt+1]+2); i += 8) {
-						RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_,
-							 ("\n %2x,%2x,%2x,%2x,%2x,%2x,%2x,%2x\n",
-							 wpa_ie[i], wpa_ie[i+1], wpa_ie[i+2], wpa_ie[i+3], wpa_ie[i+4],
-							 wpa_ie[i+5], wpa_ie[i+6], wpa_ie[i+7]));
-					}
-				}
-
 				*wpa_len = in_ie[cnt+1]+2;
 				cnt += in_ie[cnt+1]+2;  /* get next */
 		} else {
 			if (authmode == _WPA2_IE_ID_) {
-				RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_,
-					 ("\n get_rsn_ie: sec_idx =%d in_ie[cnt+1]+2 =%d\n",
-					 sec_idx, in_ie[cnt+1]+2));
-
-				if (rsn_ie) {
+				if (rsn_ie)
 					memcpy(rsn_ie, &in_ie[cnt], in_ie[cnt+1]+2);
 
-					for (i = 0; i < (in_ie[cnt+1]+2); i += 8) {
-						RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_,
-							 ("\n %2x,%2x,%2x,%2x,%2x,%2x,%2x,%2x\n",
-							 rsn_ie[i], rsn_ie[i+1], rsn_ie[i+2], rsn_ie[i+3], rsn_ie[i+4],
-							 rsn_ie[i+5], rsn_ie[i+6], rsn_ie[i+7]));
-						}
-				}
-
 				*rsn_len = in_ie[cnt+1]+2;
 				cnt += in_ie[cnt+1]+2;  /* get next */
 			} else {
@@ -1403,28 +1364,20 @@ static int rtw_get_cipher_info(struct wlan_network *pnetwork)
 	pbuf = rtw_get_wpa_ie(&pnetwork->network.IEs[12], &wpa_ielen, pnetwork->network.IELength-12);
 
 	if (pbuf && (wpa_ielen > 0)) {
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_get_cipher_info: wpa_ielen: %d", wpa_ielen));
 		if (_SUCCESS == rtw_parse_wpa_ie(pbuf, wpa_ielen+2, &group_cipher, &pairwise_cipher, &is8021x)) {
 			pnetwork->BcnInfo.pairwise_cipher = pairwise_cipher;
 			pnetwork->BcnInfo.group_cipher = group_cipher;
 			pnetwork->BcnInfo.is_8021x = is8021x;
-			RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("%s: pnetwork->pairwise_cipher: %d, is_8021x is %d",
-				 __func__, pnetwork->BcnInfo.pairwise_cipher, pnetwork->BcnInfo.is_8021x));
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
@@ -1453,10 +1406,6 @@ void rtw_get_bcn_info(struct wlan_network *pnetwork)
 		pnetwork->BcnInfo.encryp_protocol = ENCRYP_PROTOCOL_OPENSYS;
 	}
 	rtw_get_sec_ie(pnetwork->network.IEs, pnetwork->network.IELength, NULL, &rsn_len, NULL, &wpa_len);
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_get_bcn_info: ssid =%s\n", pnetwork->network.Ssid.Ssid));
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_get_bcn_info: wpa_len =%d rsn_len =%d\n", wpa_len, rsn_len));
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_get_bcn_info: ssid =%s\n", pnetwork->network.Ssid.Ssid));
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_get_bcn_info: wpa_len =%d rsn_len =%d\n", wpa_len, rsn_len));
 
 	if (rsn_len > 0) {
 		pnetwork->BcnInfo.encryp_protocol = ENCRYP_PROTOCOL_WPA2;
@@ -1466,10 +1415,6 @@ void rtw_get_bcn_info(struct wlan_network *pnetwork)
 		if (bencrypt)
 			pnetwork->BcnInfo.encryp_protocol = ENCRYP_PROTOCOL_WEP;
 	}
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_get_bcn_info: pnetwork->encryp_protocol is %x\n",
-		 pnetwork->BcnInfo.encryp_protocol));
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_get_bcn_info: pnetwork->encryp_protocol is %x\n",
-		 pnetwork->BcnInfo.encryp_protocol));
 	rtw_get_cipher_info(pnetwork);
 
 	/* get bwmode and ch_offset */
-- 
2.31.1

