Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4963A943B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 09:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232040AbhFPHlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 03:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231750AbhFPHlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 03:41:45 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF9AC061760
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 00:39:38 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id y207so519782vsy.12
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 00:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0D0RyfEI/YYH+umZt/l1fT0zvlmNHGepMtTDRyFPZvY=;
        b=HRl8G71CBordXP8uYrjJENk7BT/KpAU9LUG4TAuefWIbyZrWvZBP5pvs35+2R13zIO
         19qddd/qBBH+Gcgmf4V1fRy3QrXhiK0xViMo4IJ7dPKYpX4j4mA0IPYCnxCeUHSSIray
         t6T2XMQraqQXGeD/70nqNrpk/eKX2Cm3Tx2NHWc55eBc+0FCwtCShjuYENs3ymI76xJF
         mwBikMPTDP8nlybMlTIWxJYVvJ+CeaS0IG5zEiI0vsPa8SodNHbwJqUCcsBVVf9bMyHA
         Mj51Kphp9gaCsJkHxQGtleznzb9hk690POpK9KPc6X5V4YrA/QKTp2NJgmb9dKcU9afN
         TBcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0D0RyfEI/YYH+umZt/l1fT0zvlmNHGepMtTDRyFPZvY=;
        b=k2WRi/J53kkFLgNf+p1pnAyxM94XYhswX7BEF9eN2SCGgntwQgCL/FUZ76ualn0xAL
         tBx/wkf0YIBaLU8kSnewHixQ3zgtgmAhqK/LfATapvneY1vjnaMaWZlhoACzcb6hB9xG
         eIjvn6zSjC56f+xFXAY6hkIN99zuq25cslf/ui62wsEkS8PkF3rIdXdS8F6OxdtjIFb3
         9y+LqEyMmoqHlbx9WKzhNyIZmtPcjYx4P0Wwmaiw64Xg904ensjvCU+rUQ8blj3Uc4cd
         9ouPhKMSZF25q5pyhH151XimBji9eR/sEVvsrXRmX19kOQZOQ0TZi695cQFazqedWM12
         2/lg==
X-Gm-Message-State: AOAM530Wao7gTNdJkr9NBMb1d3xmt4o799uM30xIQAgAK11qE4oy0/IE
        +Owekvc0DpFmb4fSGnuh7AA5mFqKLAP4h2Vm
X-Google-Smtp-Source: ABdhPJzJ5Cd6sbTpu5QSQkfElWOwoct0rWUHQI44xvs3wEnrdGLBks9SN/VekHxlU+cZ3TjQZ5l0YQ==
X-Received: by 2002:aa7:8c02:0:b029:2e9:c513:1e10 with SMTP id c2-20020aa78c020000b02902e9c5131e10mr8376728pfd.2.1623829166727;
        Wed, 16 Jun 2021 00:39:26 -0700 (PDT)
Received: from localhost.localdomain ([115.99.8.69])
        by smtp.gmail.com with ESMTPSA id z18sm1323065pfn.37.2021.06.16.00.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 00:39:26 -0700 (PDT)
From:   Shreyas Krishnakumar <shreyaskumar1035@gmail.com>
To:     gregkh@linuxfoundation.org, hdegoede@redhat.com,
        Larry.Finger@lwfinger.net
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: rtw_efuse: Fix coding style
Date:   Wed, 16 Jun 2021 13:09:21 +0530
Message-Id: <20210616073921.156814-1-shreyaskumar1035@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary braces around single statement blocks as warned by
checkpatch.pl

Signed-off-by: Shreyas Krishnakumar <shreyaskumar1035@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_efuse.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_efuse.c b/drivers/staging/rtl8723bs/core/rtw_efuse.c
index 81457467461c..430e2d81924c 100644
--- a/drivers/staging/rtl8723bs/core/rtw_efuse.c
+++ b/drivers/staging/rtl8723bs/core/rtw_efuse.c
@@ -249,9 +249,8 @@ bool		bPseudoTest)
 	u8 bResult;
 	u8 readbyte;
 
-	if (bPseudoTest) {
+	if (bPseudoTest)
 		return Efuse_Read1ByteFromFakeContent(padapter, addr, data);
-	}
 
 	/*  <20130121, Kordan> For SMIC EFUSE specificatoin. */
 	/* 0x34[11]: SW force PGMEN input of efuse to high. (for the bank selected by 0x34[9:8]) */
@@ -291,9 +290,8 @@ u8 efuse_OneByteWrite(struct adapter *padapter, u16 addr, u8 data, bool bPseudoT
 	u8 bResult = false;
 	u32 efuseValue = 0;
 
-	if (bPseudoTest) {
+	if (bPseudoTest)
 		return Efuse_Write1ByteToFakeContent(padapter, addr, data);
-	}
 
 
 	/*  -----------------e-fuse reg ctrl --------------------------------- */
@@ -319,11 +317,10 @@ u8 efuse_OneByteWrite(struct adapter *padapter, u16 addr, u8 data, bool bPseudoT
 		tmpidx++;
 	}
 
-	if (tmpidx < 100) {
+	if (tmpidx < 100)
 		bResult = true;
-	} else {
+	else
 		bResult = false;
-	}
 
 	/*  disable Efuse program enable */
 	PHY_SetMacReg(padapter, EFUSE_TEST, BIT(11), 0);
-- 
2.31.1

