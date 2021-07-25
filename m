Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1E73D4E82
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jul 2021 18:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbhGYPUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jul 2021 11:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbhGYPTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jul 2021 11:19:09 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A56BC061757;
        Sun, 25 Jul 2021 08:59:40 -0700 (PDT)
Received: from dslb-188-096-139-014.188.096.pools.vodafone-ip.de ([188.96.139.14] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1m7gXS-0000SM-52; Sun, 25 Jul 2021 17:59:38 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 17/18] staging: rtl8188eu: simplify phy_lc_calibrate
Date:   Sun, 25 Jul 2021 17:59:01 +0200
Message-Id: <20210725155902.32433-17-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210725155902.32433-1-martin@kaiser.cx>
References: <20210725155902.32433-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

phy_lc_calibrate's is2t parameter is always false.
Remove some code that would be called only for is2t == true.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/rtl8188eu/hal/phy.c | 20 +++-----------------
 1 file changed, 3 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/phy.c b/drivers/staging/rtl8188eu/hal/phy.c
index faa94dc7190c..6c6404eb2f1e 100644
--- a/drivers/staging/rtl8188eu/hal/phy.c
+++ b/drivers/staging/rtl8188eu/hal/phy.c
@@ -952,10 +952,10 @@ static void phy_iq_calibrate(struct adapter *adapt, s32 result[][8],
 	}
 }
 
-static void phy_lc_calibrate(struct adapter *adapt, bool is2t)
+static void phy_lc_calibrate(struct adapter *adapt)
 {
 	u8 tmpreg;
-	u32 rf_a_mode = 0, rf_b_mode = 0, lc_cal;
+	u32 rf_a_mode = 0, lc_cal;
 
 	/* Check continuous TX and Packet TX */
 	tmpreg = usb_read8(adapt, 0xd03);
@@ -971,20 +971,10 @@ static void phy_lc_calibrate(struct adapter *adapt, bool is2t)
 		rf_a_mode = rtw_hal_read_rfreg(adapt, RF_PATH_A, RF_AC,
 					       bMask12Bits);
 
-		/* Path-B */
-		if (is2t)
-			rf_b_mode = rtw_hal_read_rfreg(adapt, RF_PATH_B, RF_AC,
-						       bMask12Bits);
-
 		/* 2. Set RF mode = standby mode */
 		/* Path-A */
 		phy_set_rf_reg(adapt, RF_PATH_A, RF_AC, bMask12Bits,
 			       (rf_a_mode & 0x8FFFF) | 0x10000);
-
-		/* Path-B */
-		if (is2t)
-			phy_set_rf_reg(adapt, RF_PATH_B, RF_AC, bMask12Bits,
-				       (rf_b_mode & 0x8FFFF) | 0x10000);
 	}
 
 	/* 3. Read RF reg18 */
@@ -1003,10 +993,6 @@ static void phy_lc_calibrate(struct adapter *adapt, bool is2t)
 		usb_write8(adapt, 0xd03, tmpreg);
 		phy_set_rf_reg(adapt, RF_PATH_A, RF_AC, bMask12Bits, rf_a_mode);
 
-		/* Path-B */
-		if (is2t)
-			phy_set_rf_reg(adapt, RF_PATH_B, RF_AC, bMask12Bits,
-				       rf_b_mode);
 	} else {
 		/* Deal with Packet TX case */
 		usb_write8(adapt, REG_TXPAUSE, 0x00);
@@ -1130,7 +1116,7 @@ void rtl88eu_phy_lc_calibrate(struct adapter *adapt)
 
 	dm_odm->RFCalibrateInfo.bLCKInProgress = true;
 
-	phy_lc_calibrate(adapt, false);
+	phy_lc_calibrate(adapt);
 
 	dm_odm->RFCalibrateInfo.bLCKInProgress = false;
 }
-- 
2.20.1

