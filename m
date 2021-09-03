Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D24553FFD3C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 11:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348905AbhICJf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 05:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348874AbhICJfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 05:35:16 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 476A0C061757
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 02:34:16 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id g18so7294149wrc.11
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 02:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u8mntTNaiLWjY70DY1DSoMIjwedthxyJ8a+lz8Q75Aw=;
        b=E93pGRgevUTJ8BopWVKHQLqfluJChQEDqKtWpgvCdSBKAXUkvAAJ1pDWt3FrivsUAl
         lz0XI7CJfMlzkiv7c6XAe7g/EiP6yXCbhB9nyxTrOxX3oXwMzqo96SwL7w1j/LhLHAkn
         JNFyyRMwxs6OBhwzauhm4t4LFohLPR7+l2J41YUxFmYjHjpDRGj/bu3ilbOHaqOZiLTA
         w4qrWlNZC/ThiiWXwetQUw1pl+S7fDWrU9mfmpHLLHBUWCQklZ6kXcp63W8n65ahCy9W
         L2zldXhX1Ce9DExZ5zolazRl/jR9r+BUqouxUfR0oC68qPc7DvRHbUU9QRz5inDjSy/Y
         nkSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u8mntTNaiLWjY70DY1DSoMIjwedthxyJ8a+lz8Q75Aw=;
        b=oyHMwqlgwK24CejB3XzGJmNoqGzGRMScbtsHZCT1tgT8n6ECQRI8jsAoJRKb7LxtYN
         cB6WgVNksUebNBNTKCxU07fZzh9QQR6Zv5pNzvitEcj+zRqK6KobL8woSY7tUuNwUYG8
         oPZ1PBLOLG73r3ivzmOb9c5/eB9/jn7jcwaJQGai3Fn9ihjHSFBmJePs9fAi7T7wuLHG
         wf/pq28NKP2HiT8pE74/DtIg5POxIXiZOb6/QH8o9Mnn6xI2CIr1uy1IwsL6KBjHJf38
         g/jJWTiMM7RuQ+vkGzgjPQ770U9zmDsVn1yJ4PVIv4W527FCF9XNLCaG6olcQJqTOQQm
         OqTg==
X-Gm-Message-State: AOAM5328lMIlxN6Rt+9TyUY37C0rcXwsd2cAW8T8WUbSBtIzZpVASLRv
        tQ00H50Pe74r0KsZH4koafo=
X-Google-Smtp-Source: ABdhPJwJSBYG573SRljTTzhmSBZXyru+7CMW3qF19k6lQr642pBHX+l5XraG2LZPpZNvi1zyl8lXUg==
X-Received: by 2002:adf:b7cd:: with SMTP id t13mr3008755wre.63.1630661654939;
        Fri, 03 Sep 2021 02:34:14 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::16fa])
        by smtp.gmail.com with ESMTPSA id x11sm3853060wmk.21.2021.09.03.02.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 02:34:14 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 5/6] staging: r8188eu: remove IS_HARDWARE_TYPE_8188* macros
Date:   Fri,  3 Sep 2021 11:33:53 +0200
Message-Id: <20210903093354.12645-6-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210903093354.12645-1-straube.linux@gmail.com>
References: <20210903093354.12645-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IS_HARDWARE_TYPE_8188* macros are not needed because the driver
is for RTL8188EU chips, remove them.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/rtl8188e_mp.c  | 20 +++++++++-----------
 drivers/staging/r8188eu/include/hal_intf.h | 11 -----------
 2 files changed, 9 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_mp.c b/drivers/staging/r8188eu/hal/rtl8188e_mp.c
index ee0c96890cf3..eb9e32dfcbe7 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_mp.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_mp.c
@@ -506,12 +506,11 @@ void Hal_SetSingleToneTx(struct adapter *pAdapter, u8 bStart)
 	if (bStart) {
 		/*  Start Single Tone. */
 		/*  <20120326, Kordan> To amplify the power of tone for Xtal calibration. (asked by Edlu) */
-		if (IS_HARDWARE_TYPE_8188E(pAdapter)) {
-			reg58 = PHY_QueryRFReg(pAdapter, RF_PATH_A, LNA_Low_Gain_3, bRFRegOffsetMask);
-			reg58 &= 0xFFFFFFF0;
-			reg58 += 2;
-			PHY_SetRFReg(pAdapter, RF_PATH_A, LNA_Low_Gain_3, bRFRegOffsetMask, reg58);
-		}
+		reg58 = PHY_QueryRFReg(pAdapter, RF_PATH_A, LNA_Low_Gain_3, bRFRegOffsetMask);
+		reg58 &= 0xFFFFFFF0;
+		reg58 += 2;
+		PHY_SetRFReg(pAdapter, RF_PATH_A, LNA_Low_Gain_3, bRFRegOffsetMask, reg58);
+
 		PHY_SetBBReg(pAdapter, rFPGA0_RFMOD, bCCKEn, 0x0);
 		PHY_SetBBReg(pAdapter, rFPGA0_RFMOD, bOFDMEn, 0x0);
 
@@ -528,11 +527,10 @@ void Hal_SetSingleToneTx(struct adapter *pAdapter, u8 bStart)
 		/*  Stop Single Tone. */
 		/*  <20120326, Kordan> To amplify the power of tone for Xtal calibration. (asked by Edlu) */
 		/*  <20120326, Kordan> Only in single tone mode. (asked by Edlu) */
-		if (IS_HARDWARE_TYPE_8188E(pAdapter)) {
-			reg58 = PHY_QueryRFReg(pAdapter, RF_PATH_A, LNA_Low_Gain_3, bRFRegOffsetMask);
-			reg58 &= 0xFFFFFFF0;
-			PHY_SetRFReg(pAdapter, RF_PATH_A, LNA_Low_Gain_3, bRFRegOffsetMask, reg58);
-		}
+		reg58 = PHY_QueryRFReg(pAdapter, RF_PATH_A, LNA_Low_Gain_3, bRFRegOffsetMask);
+		reg58 &= 0xFFFFFFF0;
+		PHY_SetRFReg(pAdapter, RF_PATH_A, LNA_Low_Gain_3, bRFRegOffsetMask, reg58);
+
 		write_bbreg(pAdapter, rFPGA0_RFMOD, bCCKEn, 0x1);
 		write_bbreg(pAdapter, rFPGA0_RFMOD, bOFDMEn, 0x1);
 
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index bbdbbf9697b1..117a98e5444e 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -283,17 +283,6 @@ enum hardware_type {
 	HARDWARE_TYPE_MAX,
 };
 
-/*  RTL8188E Series */
-#define IS_HARDWARE_TYPE_8188EE(_Adapter)			\
-(((struct adapter *)_Adapter)->HardwareType == HARDWARE_TYPE_RTL8188EE)
-#define IS_HARDWARE_TYPE_8188EU(_Adapter)			\
-(((struct adapter *)_Adapter)->HardwareType == HARDWARE_TYPE_RTL8188EU)
-#define IS_HARDWARE_TYPE_8188ES(_Adapter)			\
-(((struct adapter *)_Adapter)->HardwareType == HARDWARE_TYPE_RTL8188ES)
-#define	IS_HARDWARE_TYPE_8188E(_Adapter)	\
-(IS_HARDWARE_TYPE_8188EE(_Adapter) || IS_HARDWARE_TYPE_8188EU(_Adapter) || \
- IS_HARDWARE_TYPE_8188ES(_Adapter))
-
 #define GET_EEPROM_EFUSE_PRIV(adapter) (&adapter->eeprompriv)
 
 #define is_boot_from_eeprom(adapter) (adapter->eeprompriv.EepromOrEfuse)
-- 
2.33.0

