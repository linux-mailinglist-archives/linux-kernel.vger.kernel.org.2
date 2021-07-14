Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 548343C86B9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 17:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239638AbhGNPOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 11:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239576AbhGNPON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 11:14:13 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C24C061765
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 08:11:20 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id k4so3637369wrc.8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 08:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ErRRPMiU/cdiVnjTQlqsH1Ke5jCRomBxj7f+q6KInH4=;
        b=bSy2dpobP4j4QKKMr+BDY29iFAw/o0PpSigCGHh/3Ng4zsfJESMlB1IOvpnvTZx6Mv
         WNgLUGNAHWBJhnGsdVTiaKjRtTSAfBhYXQkyyfkh4DuXVLzoStBBm+iyEcnwsZudWAUk
         QhTXFs7CSV+3sT3e4IMJWiRAXb6qIStFVGco58FKrUoKCNpGXZ8Xuv4tUC+3AcnEFa3J
         C6n4uGuqrAYhCVqfvkO4+TD8VVqCPexFavsQbgRZ8CY7w2usD0KIIHxO+fEZx4QkvYom
         0e0ECnDkB4E+GQHA0fQBtdVgXUwrnR+K8BTPveO25wHGX9jyCn/tCppvHVqjXLMQStsF
         ZCTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ErRRPMiU/cdiVnjTQlqsH1Ke5jCRomBxj7f+q6KInH4=;
        b=eHBea89ZpMJFDvve+elQ7or816ycn1wye8Q9zfTRzunnMWgdTsW6Eh7ILfp4GFclWl
         lJFKhuM8ltJdSVzcuVNu7buLk20muSxVpHfhjBthOSZOGlGUFV5ZgYz73kmEvrnlA7Py
         1zvEelFC3HSPmTosOOY0r50CYcZViZS83kE2x6BVdD1YShcGkCFA1prkkePH1GBCV1UO
         YmsdvCZAI7itLnd5qhHEqjqIVb0eeiLL37mh2esLFBroJUMsh+XfGPQKUNF4GT5KiHrL
         NgGLR5NrcmvtpwdemFbFamK1lFr8D30eCGeYePiYKpEF2h1XVANU13ms2NSmLBdEyW+N
         N7TQ==
X-Gm-Message-State: AOAM532dZPNtXrHP8XXp4lsxMdYKIreanjDUAG9tEKPCsMckQoiYMprT
        LD06sGcbXBkwsrpV/dWDoobws0NKVQ4=
X-Google-Smtp-Source: ABdhPJyOPCsHw9ijPxGfdOilB58mqPIkyyQqdVx5MLIs8CSeI1FGu67zQkmS5nMhQq4IPT/WwnF0rA==
X-Received: by 2002:a5d:6482:: with SMTP id o2mr13293491wri.367.1626275478568;
        Wed, 14 Jul 2021 08:11:18 -0700 (PDT)
Received: from agape ([5.171.72.142])
        by smtp.gmail.com with ESMTPSA id p12sm1618575wma.19.2021.07.14.08.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 08:11:18 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] staging: rtl8723bs: convert IsSupportedHT to snake_case
Date:   Wed, 14 Jul 2021 17:11:13 +0200
Message-Id: <d3e115f3a553db07a52cc51b71d04de9c383f697.1626275102.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1626275102.git.fabioaiuto83@gmail.com>
References: <cover.1626275102.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

convert IsSupportedHT to snake case is_supported_ht.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ioctl_set.c    | 2 +-
 drivers/staging/rtl8723bs/core/rtw_wlan_util.c    | 2 +-
 drivers/staging/rtl8723bs/include/ieee80211.h     | 2 +-
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c b/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
index bd5056507f53..fcbbdbe5448b 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
@@ -554,7 +554,7 @@ u16 rtw_get_cur_max_rate(struct adapter *adapter)
 
 	short_GI = query_ra_short_GI(psta);
 
-	if (IsSupportedHT(psta->wireless_mode)) {
+	if (is_supported_ht(psta->wireless_mode)) {
 		rtw_hal_get_hwreg(adapter, HW_VAR_RF_TYPE, (u8 *)(&rf_type));
 
 		max_rate = rtw_mcs_rate(rf_type,
diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index c06b74f6569a..56c5cb318fdf 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -55,7 +55,7 @@ u8 networktype_to_raid_ex(struct adapter *adapter, struct sta_info *psta)
 
 	if (cur_rf_type == RF_1T1R) {
 		rf_type = RF_1T1R;
-	} else if (IsSupportedHT(psta->wireless_mode)) {
+	} else if (is_supported_ht(psta->wireless_mode)) {
 		if (psta->ra_mask & 0xfff00000)
 			rf_type = RF_2T2R;
 	}
diff --git a/drivers/staging/rtl8723bs/include/ieee80211.h b/drivers/staging/rtl8723bs/include/ieee80211.h
index 378c21595e05..8eb0557a077a 100644
--- a/drivers/staging/rtl8723bs/include/ieee80211.h
+++ b/drivers/staging/rtl8723bs/include/ieee80211.h
@@ -167,7 +167,7 @@ enum network_type {
 
 #define IsSupportedTxCCK(NetType) (((NetType) & (WIRELESS_11B)) ? true : false)
 #define IsSupportedTxOFDM(NetType) (((NetType) & (WIRELESS_11G) ? true : false)
-#define IsSupportedHT(NetType) (((NetType) & (WIRELESS_11_24N)) ? true : false)
+#define is_supported_ht(NetType) (((NetType) & (WIRELESS_11_24N)) ? true : false)
 
 struct ieee_param {
 	u32 cmd;
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index d198d10ec272..368e575c24af 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -2106,7 +2106,7 @@ static u8 rtw_get_chan_type(struct adapter *adapter)
 
 	switch (mlme_ext->cur_bwmode) {
 	case CHANNEL_WIDTH_20:
-		if (IsSupportedHT(adapter->registrypriv.wireless_mode))
+		if (is_supported_ht(adapter->registrypriv.wireless_mode))
 			return NL80211_CHAN_HT20;
 		else
 			return NL80211_CHAN_NO_HT;
-- 
2.20.1

