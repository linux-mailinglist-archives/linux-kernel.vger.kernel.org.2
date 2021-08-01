Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46FAC3DCD22
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Aug 2021 21:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbhHATEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 15:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbhHATEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 15:04:51 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 871D0C061796
        for <linux-kernel@vger.kernel.org>; Sun,  1 Aug 2021 12:04:43 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id f14-20020a05600c154eb02902519e4abe10so12393403wmg.4
        for <linux-kernel@vger.kernel.org>; Sun, 01 Aug 2021 12:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PaYR6V7BwVCAhT+WCl9MYXQBWVeOSpDreN1dn4JER14=;
        b=LUv3hr2jRSjc3dan/dMo2kIKTj1A6atAJXA/h7g66jVqAMcrW1Ig7obQCSzshdcx5f
         0CsqOt9iAhhbqMfHejEo4BH4lXFJ5jo6HcmN/qdsaNRxJSZFAi4x06Ttiah73TWFlt+Y
         muAxoqVlh5YhpGRzeCEU0FzJlGgRSVOXmthwah3xKMPgVKstfkdXG9VeukZfabT2LpA0
         SBoaHmpl27G5EzmnHerYB48bJl6B9m+HuRt/wAnPejLEqLFETlt30hSg8iUh/WFUJ5e5
         9HJaRPoaRdNols/DEeRZ41hdZU90n3Mhg0bAwYzdUDEYG1e5VPbWj9JiPmnMVEXxEOwz
         r3Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PaYR6V7BwVCAhT+WCl9MYXQBWVeOSpDreN1dn4JER14=;
        b=sQerckWtnmncfr1YxGPV0Hhi+4XJ3I0RuhhuWPxpE7bapI3mA8a5TLaE/UeUxEvvm+
         e3n16ok7/VkYUfBuVEw4KxzDgDeMl1M100+CDok0V5MvD/2YjF0dDJf2Oj1tMGvgYpol
         U1q9/CdKLzsBlHHmJ1/pDnFjXTDDYCQPtmTOjT6DgNoiAX6aKJmbAeXlOyc6/uMRPQ9O
         LmyhdgLQvHIGVr6B6NPgXOYo0+Ck2XPuIfKrS9tA2lweoyF369x2M8p0ldlZlZoBa2fr
         qZ4p+K/Oq9IFBVj+FFu4/3hyPDtIoNR+W7GZAmfqeXH4NPR3HaiplGN8LS2VSpEc+Uva
         TSgA==
X-Gm-Message-State: AOAM533bLgSUsYngPAGe3CBJ/hwbpH/WgcjCXawyyyNAWAR+ztFX/Adb
        rgmS6bRREFH9K5IRu+lONMRpqg==
X-Google-Smtp-Source: ABdhPJyStRD13ZlBc5TXh2q1SZPuUXMMLmnLbHJnGMqtVJgWyStPqekKCLLKTuT1k18vNlsaOw8a9w==
X-Received: by 2002:a1c:cc12:: with SMTP id h18mr13808522wmb.12.1627844682173;
        Sun, 01 Aug 2021 12:04:42 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id c10sm8196026wmb.40.2021.08.01.12.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Aug 2021 12:04:41 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, martin@kaiser.cx
Subject: [PATCH 03/15] staging: r8188eu: remove RT_TRACE calls from core/rtw_wlan_util.c
Date:   Sun,  1 Aug 2021 20:04:25 +0100
Message-Id: <20210801190437.82017-4-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210801190437.82017-1-phil@philpotter.co.uk>
References: <20210801190437.82017-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove RT_TRACE macro calls from core/rtw_wlan_util.c, so that ultimately the
macro definition itself can eventually be removed.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/core/rtw_wlan_util.c | 25 +++-----------------
 1 file changed, 3 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_wlan_util.c b/drivers/staging/r8188eu/core/rtw_wlan_util.c
index 15edccef9f1d..212e64183e9c 100644
--- a/drivers/staging/r8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/r8188eu/core/rtw_wlan_util.c
@@ -1001,11 +1001,6 @@ int rtw_check_bcn_info(struct adapter  *Adapter, u8 *pframe, u32 packet_len)
 		bssid->Ssid.Ssid[0] = '\0';
 	}
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("%s bssid.Ssid.Ssid:%s bssid.Ssid.SsidLength:%d "
-				"cur_network->network.Ssid.Ssid:%s len:%d\n", __func__, bssid->Ssid.Ssid,
-				bssid->Ssid.SsidLength, cur_network->network.Ssid.Ssid,
-				cur_network->network.Ssid.SsidLength));
-
 	if (memcmp(bssid->Ssid.Ssid, cur_network->network.Ssid.Ssid, 32) ||
 	    bssid->Ssid.SsidLength != cur_network->network.Ssid.SsidLength) {
 		if (bssid->Ssid.Ssid[0] != '\0' && bssid->Ssid.SsidLength != 0) { /* not hidden ssid */
@@ -1022,9 +1017,6 @@ int rtw_check_bcn_info(struct adapter  *Adapter, u8 *pframe, u32 packet_len)
 	else
 		bssid->Privacy = 0;
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_,
-		 ("%s(): cur_network->network.Privacy is %d, bssid.Privacy is %d\n",
-		 __func__, cur_network->network.Privacy, bssid->Privacy));
 	if (cur_network->network.Privacy != bssid->Privacy) {
 		DBG_88E("%s(), privacy is not match return FAIL\n", __func__);
 		goto _mismatch;
@@ -1049,25 +1041,14 @@ int rtw_check_bcn_info(struct adapter  *Adapter, u8 *pframe, u32 packet_len)
 	if (encryp_protocol == ENCRYP_PROTOCOL_WPA || encryp_protocol == ENCRYP_PROTOCOL_WPA2) {
 		pbuf = rtw_get_wpa_ie(&bssid->IEs[12], &wpa_ielen, bssid->IELength-12);
 		if (pbuf && (wpa_ielen > 0)) {
-			if (_SUCCESS == rtw_parse_wpa_ie(pbuf, wpa_ielen+2, &group_cipher, &pairwise_cipher, &is_8021x)) {
-				RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_,
-					 ("%s pnetwork->pairwise_cipher: %d, group_cipher is %d, is_8021x is %d\n", __func__,
-					 pairwise_cipher, group_cipher, is_8021x));
-			}
+			rtw_parse_wpa_ie(pbuf, wpa_ielen+2, &group_cipher, &pairwise_cipher, &is_8021x);
 		} else {
 			pbuf = rtw_get_wpa2_ie(&bssid->IEs[12], &wpa_ielen, bssid->IELength-12);
 
-			if (pbuf && (wpa_ielen > 0)) {
-				if (_SUCCESS == rtw_parse_wpa2_ie(pbuf, wpa_ielen+2, &group_cipher, &pairwise_cipher, &is_8021x)) {
-					RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_,
-						 ("%s pnetwork->pairwise_cipher: %d, pnetwork->group_cipher is %d, is_802x is %d\n",
-						  __func__, pairwise_cipher, group_cipher, is_8021x));
-				}
-			}
+			if (pbuf && (wpa_ielen > 0))
+				rtw_parse_wpa2_ie(pbuf, wpa_ielen+2, &group_cipher, &pairwise_cipher, &is_8021x);
 		}
 
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_,
-			 ("%s cur_network->group_cipher is %d: %d\n", __func__, cur_network->BcnInfo.group_cipher, group_cipher));
 		if (pairwise_cipher != cur_network->BcnInfo.pairwise_cipher || group_cipher != cur_network->BcnInfo.group_cipher) {
 			DBG_88E("%s pairwise_cipher(%x:%x) or group_cipher(%x:%x) is not match , return FAIL\n", __func__,
 				pairwise_cipher, cur_network->BcnInfo.pairwise_cipher,
-- 
2.31.1

