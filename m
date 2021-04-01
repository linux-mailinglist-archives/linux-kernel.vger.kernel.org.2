Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5063511EF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 11:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234189AbhDAJWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 05:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233817AbhDAJV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 05:21:59 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C57C06178C
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 02:21:58 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id w18so1200706edc.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 02:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vl98NO3efhmL4Uf72VouuywLqEyvjsnyXcNhAsGyR7s=;
        b=GYVh6f6V3bijuMIY5kTwOYKHF2wzdSECMlH2LmE/73aYA9y2lx6lMtWVapSHSt1riK
         7BFVJzfD1Fvb6AENNCVMHgjosw0mdoZCp7JS4dQ+qnCUgPKewU841WjRDa4WFhIj6302
         biFF/cg/JnqE9afm+QWTh5QnISW4v9OdSg9R8kI/fivsn1Z6IsND0zPc0Bkn0QzZnC00
         IJEnPkUPMCCltxMZYZkOjlQRpRqWWM5D7bt+dxGCWQ1k4U6ShP1Z4NsXh6uekOMilMGI
         XBAk7dv6sxLMT1gYBVisNUueZVyLdv0u6aRYjvumYvQPOuz4j44H8fz6JNvHtx7LZTdh
         +H3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vl98NO3efhmL4Uf72VouuywLqEyvjsnyXcNhAsGyR7s=;
        b=U7fd5JuadI/qCEDaFfUsFhYtAGpzNDW1VLzEVPbWtrWhWVteChiTeKp2L7QSDcCTzn
         XCUfMn8PvN6gmgMk+u58iT5xb8aAJjb5TKm72Qub2EHHbuKswncD06x35hjQglR20+bG
         nQbQhKZ3c2Wq72sp3NJODnmXoXvGat+53avBEYNYpukSL1c7lglEGukmrUKJiSrWX8cs
         S4BJSHbAVuvSQUkQbrKKuo716DzlZ3uS8OZh1gLU34DF1qKWCI0iY/WdGSR0GWOTXB80
         Z/Sp5TuldJSjf561/U/ZBEPJ2cv7AsJ6+Bbs7ZLTcTSKDHqXcRydrUDHPLl09DZSHVT+
         uL5g==
X-Gm-Message-State: AOAM532F9+t/Ev2ZLDYm0hp6Jcss8A/KaeCBYHjUT+2knY562VYvHg5P
        qBqVsQjg5q9I/Qnfg1HHZ1s=
X-Google-Smtp-Source: ABdhPJyelFzQPu5wDDWL8LOkPL0Vr5cBWB/6jbC0ETwdCf9j3+KabSlyRgkX8dZML5IArHYOlDU6cg==
X-Received: by 2002:a50:fd15:: with SMTP id i21mr8580686eds.384.1617268917641;
        Thu, 01 Apr 2021 02:21:57 -0700 (PDT)
Received: from agape ([5.171.80.247])
        by smtp.gmail.com with ESMTPSA id jj15sm2502595ejc.99.2021.04.01.02.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 02:21:57 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, dan.carpenter@oracle.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 21/49] staging: rtl8723bs: remove all RT_TRACE logs in core/rtw_wlan_util.c
Date:   Thu,  1 Apr 2021 11:20:51 +0200
Message-Id: <ec315eef2dc9582020d8b5f91af695c1ee2bb599.1617268327.git.fabioaiuto83@gmail.com>
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
 drivers/staging/rtl8723bs/core/rtw_wlan_util.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index 760b0ea4e9bd..8bf3ddec3f58 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -1334,11 +1334,6 @@ int rtw_check_bcn_info(struct adapter *Adapter, u8 *pframe, u32 packet_len)
 	memcpy(bssid->Ssid.Ssid, (p + 2), ssid_len);
 	bssid->Ssid.SsidLength = ssid_len;
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("%s bssid.Ssid.Ssid:%s bssid.Ssid.SsidLength:%d "
-				"cur_network->network.Ssid.Ssid:%s len:%d\n", __func__, bssid->Ssid.Ssid,
-				bssid->Ssid.SsidLength, cur_network->network.Ssid.Ssid,
-				cur_network->network.Ssid.SsidLength));
-
 	if (memcmp(bssid->Ssid.Ssid, cur_network->network.Ssid.Ssid, 32) ||
 			bssid->Ssid.SsidLength != cur_network->network.Ssid.SsidLength) {
 		if (bssid->Ssid.Ssid[0] != '\0' && bssid->Ssid.SsidLength != 0) { /* not hidden ssid */
@@ -1355,9 +1350,6 @@ int rtw_check_bcn_info(struct adapter *Adapter, u8 *pframe, u32 packet_len)
 	else
 		bssid->Privacy = 0;
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_,
-			("%s(): cur_network->network.Privacy is %d, bssid.Privacy is %d\n",
-			 __func__, cur_network->network.Privacy, bssid->Privacy));
 	if (cur_network->network.Privacy != bssid->Privacy) {
 		DBG_871X("%s(), privacy is not match\n", __func__);
 		goto _mismatch;
@@ -1383,24 +1375,16 @@ int rtw_check_bcn_info(struct adapter *Adapter, u8 *pframe, u32 packet_len)
 		pbuf = rtw_get_wpa_ie(&bssid->IEs[12], &wpa_ielen, bssid->IELength-12);
 		if (pbuf && (wpa_ielen > 0)) {
 			if (_SUCCESS == rtw_parse_wpa_ie(pbuf, wpa_ielen+2, &group_cipher, &pairwise_cipher, &is_8021x)) {
-				RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_,
-						("%s pnetwork->pairwise_cipher: %d, group_cipher is %d, is_8021x is %d\n", __func__,
-						 pairwise_cipher, group_cipher, is_8021x));
 			}
 		} else {
 			pbuf = rtw_get_wpa2_ie(&bssid->IEs[12], &wpa_ielen, bssid->IELength-12);
 
 			if (pbuf && (wpa_ielen > 0)) {
 				if (_SUCCESS == rtw_parse_wpa2_ie(pbuf, wpa_ielen+2, &group_cipher, &pairwise_cipher, &is_8021x)) {
-					RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_,
-							("%s pnetwork->pairwise_cipher: %d, pnetwork->group_cipher is %d, is_802x is %d\n",
-							 __func__, pairwise_cipher, group_cipher, is_8021x));
 				}
 			}
 		}
 
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_,
-				("%s cur_network->group_cipher is %d: %d\n", __func__, cur_network->BcnInfo.group_cipher, group_cipher));
 		if (pairwise_cipher != cur_network->BcnInfo.pairwise_cipher || group_cipher != cur_network->BcnInfo.group_cipher) {
 			DBG_871X("%s pairwise_cipher(%x:%x) or group_cipher(%x:%x) is not match\n", __func__,
 					pairwise_cipher, cur_network->BcnInfo.pairwise_cipher,
-- 
2.20.1

