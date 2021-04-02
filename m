Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03238352946
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 12:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235119AbhDBKCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 06:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234963AbhDBKCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 06:02:13 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37061C061793
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 03:02:12 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id y6so4969748eds.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 03:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vp2w3T91zkz5jCj2vxqK/S9xAXRsletGbavl4+f/hGk=;
        b=CNmVjXW4CH/zbHtkhsLtJysG/VdaeKbJzq2+pZC3RZDUFJUH4DSO+x+t1E4hb9BRm5
         9wsYf7uled2FBu2w57fviyjl0qywKkhsdUmHPvNlgH68g3PRv5lfH/zUi59s4kXHAhqy
         cjQ3eQQKTFNN/3hlebZU8dTaGv8Upskj8PiHgNxJXJDCvbT1m7AEsOxaHOm4I4JDsH9H
         DM4uCPJHXSkR0wQjtcYKNOgDs23J0BQLRDmw/jlEruMKAcCFyMxpVP6rvZk5HKHPlQWE
         1NJV3iJnDVv6dnYWZvsGdSWGTRHiJ7caALYTy49GWVtGqW/m0i47mxCb99pHt0V/uuER
         rOmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vp2w3T91zkz5jCj2vxqK/S9xAXRsletGbavl4+f/hGk=;
        b=iduNmWKB8vcekB+11+OHghcPpd/+smj1yqIdOA+7hy0OAZdpjZoMEoYyDvOMAszfJO
         tendh5Z8jAvHZ/vf+ZW61VVvTkX8iAAAuNYKRbv9gU91uT7jHEJ9fkOwVn1AhWvezZ8O
         ZsE7cZrW80v4I9+EZLXZuF4RDY1FEvhC73Zjls3g7enwpyQ1LfHgS/4R2SXvxHIdfXEQ
         52deT5XPlVZPBo/lvEijG0gG+6Axeom6F0WrQPh4OPaSyuiIaIvUZTCEIO4q1e8xZf3g
         Uony7Q/DAtDrmLRDF4Rx8iS4eMF0KgwS/nu6O04aHTkxtaxMOC1EZEhNS8/HM6FlY56X
         3/LQ==
X-Gm-Message-State: AOAM530//rlK6/drgVDoxNrHrxem05H+/CMn3iohOTp4z5mKi158IOWR
        /5U9RqPO9f2d5J0qsNXlBb8v81OKyQQ=
X-Google-Smtp-Source: ABdhPJyDwPWYJ0mqqbdTn3cfcn2OZ1rxTLOKohDj9CmP0b5xeYBYwr466xjSWuH90Kbd+QZOuyNliA==
X-Received: by 2002:aa7:c850:: with SMTP id g16mr14459159edt.324.1617357730958;
        Fri, 02 Apr 2021 03:02:10 -0700 (PDT)
Received: from agape ([5.171.72.128])
        by smtp.gmail.com with ESMTPSA id i10sm3960908ejv.106.2021.04.02.03.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 03:02:10 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 14/16] staging: rtl8723bs: remove all RT_TRACE logs in core/rtw_wlan_util.c
Date:   Fri,  2 Apr 2021 12:01:34 +0200
Message-Id: <34bf6cdc7bdf5c64d47cb3525897970644de7052.1617356821.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617356821.git.fabioaiuto83@gmail.com>
References: <cover.1617356821.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove all RT_TRACE logs

fix patch-related checkpatch issues

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 .../staging/rtl8723bs/core/rtw_wlan_util.c    | 26 +++++--------------
 1 file changed, 6 insertions(+), 20 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index 760b0ea4e9bd..de5108f68cbd 100644
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
@@ -1382,25 +1374,19 @@ int rtw_check_bcn_info(struct adapter *Adapter, u8 *pframe, u32 packet_len)
 	if (encryp_protocol == ENCRYP_PROTOCOL_WPA || encryp_protocol == ENCRYP_PROTOCOL_WPA2) {
 		pbuf = rtw_get_wpa_ie(&bssid->IEs[12], &wpa_ielen, bssid->IELength-12);
 		if (pbuf && (wpa_ielen > 0)) {
-			if (_SUCCESS == rtw_parse_wpa_ie(pbuf, wpa_ielen+2, &group_cipher, &pairwise_cipher, &is_8021x)) {
-				RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_,
-						("%s pnetwork->pairwise_cipher: %d, group_cipher is %d, is_8021x is %d\n", __func__,
-						 pairwise_cipher, group_cipher, is_8021x));
-			}
+			if (rtw_parse_wpa_ie(pbuf, wpa_ielen + 2, &group_cipher,
+					     &pairwise_cipher, &is_8021x) == _SUCCESS)
+				;
 		} else {
 			pbuf = rtw_get_wpa2_ie(&bssid->IEs[12], &wpa_ielen, bssid->IELength-12);
 
 			if (pbuf && (wpa_ielen > 0)) {
-				if (_SUCCESS == rtw_parse_wpa2_ie(pbuf, wpa_ielen+2, &group_cipher, &pairwise_cipher, &is_8021x)) {
-					RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_,
-							("%s pnetwork->pairwise_cipher: %d, pnetwork->group_cipher is %d, is_802x is %d\n",
-							 __func__, pairwise_cipher, group_cipher, is_8021x));
-				}
+				if (rtw_parse_wpa2_ie(pbuf, wpa_ielen + 2, &group_cipher,
+						      &pairwise_cipher, &is_8021x) == _SUCCESS)
+					;
 			}
 		}
 
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_,
-				("%s cur_network->group_cipher is %d: %d\n", __func__, cur_network->BcnInfo.group_cipher, group_cipher));
 		if (pairwise_cipher != cur_network->BcnInfo.pairwise_cipher || group_cipher != cur_network->BcnInfo.group_cipher) {
 			DBG_871X("%s pairwise_cipher(%x:%x) or group_cipher(%x:%x) is not match\n", __func__,
 					pairwise_cipher, cur_network->BcnInfo.pairwise_cipher,
-- 
2.20.1

