Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5276335AE2D
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 16:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235094AbhDJOWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 10:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234944AbhDJOVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 10:21:22 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40758C061344
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 07:21:07 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id n2so13020198ejy.7
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 07:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=70up8zMFHK98mBqYLU707HfdW2OG0jaycv4htN1s4V0=;
        b=UxoIFR1bhd8vbmQC86UCMEjaVHHbGAuG3zr4mCh3EfoQ0v0Wf9Q+pZV91UBqBHlrPT
         gSs4NNbuIR4UQZV9RoFLtlBvuoEDXZor+542UHpQ0B6ziCfDxQOyjHOIJAqQqcU1Z+sj
         bi2ZUUvePoY4dwv/cufJ7awY+nQDdpFmQpbEXJBaV7viPMxzKX+j+teu01H8VqLgJ5PI
         tOMNP9eRWE1LYeZ7OqoyLGrDJp4rAipDVABS5Bx7ppjWEbSUnWAnDkUEhGDfcGZMTEO8
         gSP3DSPE2tH3cVsKYSEARJbhaiFoesH8x2sUcIzugNuF7CyDDPMPbtG0uHtNlNU59+uo
         CTNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=70up8zMFHK98mBqYLU707HfdW2OG0jaycv4htN1s4V0=;
        b=rTRR4eyJrSAJleT2rC7j+1af3AS5P7z1wY6Oh+Mj0HTjAz/Tfw17V5OhsmM7JVIMtx
         nyf5Hxazs56tfyhs0gtB4HEm0wmiAM+WUYEYG5mC/E8yzVfMNCr4qpazic89VdcSklpD
         IHESzs3TJ05R8flDszguLePJg9kXta6GuARAefYGOeovGCXlFZ72vpgZkkY4H13oGaQ6
         /uICyxSOUHNhGKSHU64yNzpj9WJLPIiWzI7Af81iJaNDBSkkn/C3aFY/D1cPQaEyJnry
         cZ9brk70iUORvkaS5hHqMCLWqR23VNu6Mn5RzWJDMBBZgFaElfFFJW5BI0R0/nHMA4TW
         /l4A==
X-Gm-Message-State: AOAM531ObYzCcdN11x6KCinB0bHA1tEfwQeBSqiq7mkNY0iHyPMMRcca
        QTnir55P1zLhXdGEdwGMImdGPv3YOA3rwg==
X-Google-Smtp-Source: ABdhPJwd71jUymegSb9eC64dLSXqPTqTphaSVXSAJqPjQhwMfTFzxqvGxWWrMOjTdaD9pZ3iiw78Kg==
X-Received: by 2002:a17:906:4015:: with SMTP id v21mr20929790ejj.433.1618064465775;
        Sat, 10 Apr 2021 07:21:05 -0700 (PDT)
Received: from agape ([5.171.81.28])
        by smtp.gmail.com with ESMTPSA id gb22sm2686324ejc.78.2021.04.10.07.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Apr 2021 07:21:05 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 16/25] staging: rtl8723bs: put spaces around operators
Date:   Sat, 10 Apr 2021 16:20:29 +0200
Message-Id: <65b7cf4b1ae3cea25a316f3c9f56c697ee7be8af.1618064274.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1618064274.git.fabioaiuto83@gmail.com>
References: <cover.1618064274.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix following post-commit hook checkpatch issues:

CHECK: spaces preferred around that '+' (ctx:VxV)
87: FILE: drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c:746:
+	if ((_offset+_size_byte) > EFUSE_MAX_MAP_LEN)
--
CHECK: spaces preferred around that '+' (ctx:VxV)
105: FILE: drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c:847:
+	if ((_offset+_size_byte) > EFUSE_BT_MAP_LEN)
--
CHECK: spaces preferred around that '-' (ctx:VxV)
133: FILE: drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c:906:
+		if ((eFuse_Addr-1) < total)
--
CHECK: spaces preferred around that '|' (ctx:VxV)
392: FILE: drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c:2485:
+	if (check_fwstate(pmlmepriv, (_FW_LINKED|WIFI_AP_STATE)) != true)

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c | 6 +++---
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index 44cb4c5be501..00115a0c70be 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -743,7 +743,7 @@ static void hal_ReadEFuse_WiFi(
 	/*  */
 	/*  Do NOT excess total size of EFuse table. Added by Roger, 2008.11.10. */
 	/*  */
-	if ((_offset+_size_byte) > EFUSE_MAX_MAP_LEN)
+	if ((_offset + _size_byte) > EFUSE_MAX_MAP_LEN)
 		return;
 
 	efuseTbl = rtw_malloc(EFUSE_MAX_MAP_LEN);
@@ -844,7 +844,7 @@ static void hal_ReadEFuse_BT(
 	/*  */
 	/*  Do NOT excess total size of EFuse table. Added by Roger, 2008.11.10. */
 	/*  */
-	if ((_offset+_size_byte) > EFUSE_BT_MAP_LEN)
+	if ((_offset + _size_byte) > EFUSE_BT_MAP_LEN)
 		return;
 
 	efuseTbl = rtw_malloc(EFUSE_BT_MAP_LEN);
@@ -903,7 +903,7 @@ static void hal_ReadEFuse_BT(
 			}
 		}
 
-		if ((eFuse_Addr-1) < total)
+		if ((eFuse_Addr - 1) < total)
 			break;
 
 	}
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 601a16074ee3..54c65c125c8c 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -2482,7 +2482,7 @@ static int cfg80211_rtw_del_station(struct wiphy *wiphy, struct net_device *ndev
 	struct sta_priv *pstapriv = &padapter->stapriv;
 	const u8 *mac = params->mac;
 
-	if (check_fwstate(pmlmepriv, (_FW_LINKED|WIFI_AP_STATE)) != true)
+	if (check_fwstate(pmlmepriv, (_FW_LINKED | WIFI_AP_STATE)) != true)
 		return -EINVAL;
 
 	if (!mac) {
-- 
2.20.1

