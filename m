Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92B8E356DDC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 15:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352686AbhDGNvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 09:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347666AbhDGNue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 09:50:34 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258E5C0613DA
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 06:50:20 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id y20-20020a1c4b140000b029011f294095d3so1186840wma.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 06:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4+cDHoJ+jrWHAkqxsythjW2eEWwKS5Q9yUuIeMD/mmE=;
        b=Df79wapfcAeNq2OtQkHzj7Ppc7SOaqB1UyprEjCmOgXtKOSmRGdqUYbeHOBcBf/kHZ
         6r/7rWcubWU8SKqO44fNrGsmGFgPGhr+3DeKYal67MXmB6RRMHvuTV0BfnX1JkhI6uOj
         77xp4a6Hr2JPUu+2jFmWVFG9OP9QPFcwmRV0KC94w99gBFZ8O48lLwwOy64I4qgtjBgM
         hixn7IxFck/hqFVjPo6UVL0Z2TfL3wzBU2hDkld7mNlHAsXIBBoVrkp6sZTAKr+YZ/u9
         TQALhJtcekkjaIiamFhXPpu7z1PPUf4e/ewwLjbESOB4IVqAY4X9wd+B1OvummRTSrZ5
         Rl8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4+cDHoJ+jrWHAkqxsythjW2eEWwKS5Q9yUuIeMD/mmE=;
        b=sc2ukiyqyAMIKFZyC6ZaMXUEx9CcArmxUPBplBsS0IYtGibPciASgFq3szgzDRv5sJ
         0ygMiAaK9cPwOPLK5AZqjAq4+AGb39qILRey3PoafUor0Q9Q4j2JktMnHTdh+RUy6WG/
         vddaO1sTc3+5FYcKX+4HmABRCbfpsBxUbnuq8DkRtRq82p9FHkbZ6958Pdii5QaMY+HF
         dDwpHq9wBG8LgSosOIfsl3z+tGiugbkyZ0GDd4NoHhSpOC49nhHc6f/cgRMrPn26G2zE
         BN2J3irHbaBYz75G/M8oWvzDxW6mJcHwHV56oQw17hXyynHoAM5UDx+6uLxl9TFI1jzD
         BXVw==
X-Gm-Message-State: AOAM5334AzbaKGa6N75iTT9gcZeb7wy00JHBnffkeFcQEEaPK4Uvs38v
        6qBXR32dpynAyIHrbdY2SGHAqvo1SiEMNQ==
X-Google-Smtp-Source: ABdhPJx4v/FE0ar33x5CT2rr014fopMWjHoExtj9VT1MXOnyauEXHPKcL3T3harfB/QWkbd+Y02R6g==
X-Received: by 2002:a1c:7515:: with SMTP id o21mr3193920wmc.90.1617803418882;
        Wed, 07 Apr 2021 06:50:18 -0700 (PDT)
Received: from agape ([5.171.81.68])
        by smtp.gmail.com with ESMTPSA id a11sm1270882wrv.21.2021.04.07.06.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 06:50:18 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 14/19] staging: rtl8723bs: add spaces around operators
Date:   Wed,  7 Apr 2021 15:49:38 +0200
Message-Id: <28885311d4351d4df4508a50765a9b92a2b8da77.1617802415.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617802415.git.fabioaiuto83@gmail.com>
References: <cover.1617802415.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix the following post-commit checkpatch issues:

CHECK: spaces preferred around that '|' (ctx:VxV)
187: FILE: drivers/staging/rtl8723bs/core/rtw_mlme.c:1659:
+			if (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY|_FW_UNDER_LINKING) == true)
--
CHECK: spaces preferred around that '|' (ctx:VxV)
373: FILE: drivers/staging/rtl8723bs/core/rtw_mlme_ext.c:3023:
+					== (sta_bssrate[j]|IEEE80211_BASIC_RATE_MASK))
--
CHECK: spaces preferred around that '-' (ctx:VxV)
456: FILE: drivers/staging/rtl8723bs/core/rtw_mlme_ext.c:4098:
+		if (len > (NDIS_802_11_LENGTH_RATES_EX-i))
--
CHECK: spaces preferred around that '+' (ctx:VxV)
770: FILE: drivers/staging/rtl8723bs/core/rtw_security.c:1590:
+		if (pframe[hdrlen+8+plen-8+i] != message[hdrlen+8+plen-8+i])
--
CHECK: spaces preferred around that '+' (ctx:VxV)
770: FILE: drivers/staging/rtl8723bs/core/rtw_security.c:1590:
+		if (pframe[hdrlen+8+plen-8+i] != message[hdrlen+8+plen-8+i])
--
CHECK: spaces preferred around that '-' (ctx:VxV)
770: FILE: drivers/staging/rtl8723bs/core/rtw_security.c:1590:
+		if (pframe[hdrlen+8+plen-8+i] != message[hdrlen+8+plen-8+i])
--
CHECK: spaces preferred around that '+' (ctx:VxV)
770: FILE: drivers/staging/rtl8723bs/core/rtw_security.c:1590:
+		if (pframe[hdrlen+8+plen-8+i] != message[hdrlen+8+plen-8+i])
--
CHECK: spaces preferred around that '+' (ctx:VxV)
770: FILE: drivers/staging/rtl8723bs/core/rtw_security.c:1590:
+		if (pframe[hdrlen+8+plen-8+i] != message[hdrlen+8+plen-8+i])
--
CHECK: spaces preferred around that '+' (ctx:VxV)
770: FILE: drivers/staging/rtl8723bs/core/rtw_security.c:1590:
+		if (pframe[hdrlen+8+plen-8+i] != message[hdrlen+8+plen-8+i])
--
CHECK: spaces preferred around that '-' (ctx:VxV)
770: FILE: drivers/staging/rtl8723bs/core/rtw_security.c:1590:
+		if (pframe[hdrlen+8+plen-8+i] != message[hdrlen+8+plen-8+i])
--
CHECK: spaces preferred around that '+' (ctx:VxV)
770: FILE: drivers/staging/rtl8723bs/core/rtw_security.c:1590:
+		if (pframe[hdrlen+8+plen-8+i] != message[hdrlen+8+plen-8+i])
--
CHECK: spaces preferred around that '-' (ctx:VxV)
1001: FILE: drivers/staging/rtl8723bs/core/rtw_wlan_util.c:1849:
+	if (i > (NUM_STA-1))
--
CHECK: spaces preferred around that '&' (ctx:VxV)
1647: FILE: drivers/staging/rtl8723bs/os_dep/ioctl_linux.c:211:
+		if (mcs_rate&0x8000) /* MCS15 */

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c      | 2 +-
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c  | 4 ++--
 drivers/staging/rtl8723bs/core/rtw_security.c  | 2 +-
 drivers/staging/rtl8723bs/core/rtw_wlan_util.c | 2 +-
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 585048c2520b..a7e40aaae2d9 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -1656,7 +1656,7 @@ static void rtw_auto_scan_handler(struct adapter *padapter)
 		&& jiffies_to_msecs(jiffies - pmlmepriv->scan_start_time) > pmlmepriv->auto_scan_int_ms) {
 
 		if (!padapter->registrypriv.wifi_spec) {
-			if (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY|_FW_UNDER_LINKING) == true)
+			if (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY | _FW_UNDER_LINKING) == true)
 				goto exit;
 
 			if (pmlmepriv->LinkDetectInfo.bBusyTraffic)
diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 93eb12130066..1ed43423f2de 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -3019,8 +3019,8 @@ void issue_assocreq(struct adapter *padapter)
 		/*  Check if the AP's supported rates are also supported by STA. */
 		for (j = 0; j < sta_bssrate_len; j++) {
 			 /*  Avoid the proprietary data rate (22Mbps) of Handlink WSG-4000 AP */
-			if ((pmlmeinfo->network.SupportedRates[i]|IEEE80211_BASIC_RATE_MASK)
-					== (sta_bssrate[j]|IEEE80211_BASIC_RATE_MASK))
+			if ((pmlmeinfo->network.SupportedRates[i] | IEEE80211_BASIC_RATE_MASK)
+					== (sta_bssrate[j] | IEEE80211_BASIC_RATE_MASK))
 				break;
 		}
 
diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c b/drivers/staging/rtl8723bs/core/rtw_security.c
index 302479d9236b..bb15b5af744c 100644
--- a/drivers/staging/rtl8723bs/core/rtw_security.c
+++ b/drivers/staging/rtl8723bs/core/rtw_security.c
@@ -1587,7 +1587,7 @@ static signed int aes_decipher(u8 *key, uint	hdrlen,
 
 	/* compare the mic */
 	for (i = 0; i < 8; i++) {
-		if (pframe[hdrlen+8+plen-8+i] != message[hdrlen+8+plen-8+i])
+		if (pframe[hdrlen + 8 + plen - 8 + i] != message[hdrlen + 8 + plen - 8 + i])
 			res = _FAIL;
 	}
 	return res;
diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index 7a73186de69d..8c516ed370f4 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -1846,7 +1846,7 @@ void rtw_alloc_macid(struct adapter *padapter, struct sta_info *psta)
 	}
 	spin_unlock_bh(&pdvobj->lock);
 
-	if (i > (NUM_STA-1))
+	if (i > (NUM_STA - 1))
 		psta->mac_id = NUM_STA;
 	else
 		psta->mac_id = i;
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index 21e85409edd1..40adecbb66d6 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -208,7 +208,7 @@ static char *translate_scan(struct adapter *padapter,
 	if (vht_cap) {
 		max_rate = vht_data_rate;
 	} else if (ht_cap) {
-		if (mcs_rate&0x8000) /* MCS15 */
+		if (mcs_rate & 0x8000) /* MCS15 */
 			max_rate = (bw_40MHz) ? ((short_GI)?300:270):((short_GI)?144:130);
 		else /* default MCS7 */
 			max_rate = (bw_40MHz) ? ((short_GI)?150:135):((short_GI)?72:65);
-- 
2.20.1

