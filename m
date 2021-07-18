Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19DA73CCA1F
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jul 2021 19:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbhGRRky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jul 2021 13:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbhGRRkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jul 2021 13:40:33 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02362C061762;
        Sun, 18 Jul 2021 10:37:34 -0700 (PDT)
Received: from dslb-178-004-206-019.178.004.pools.vodafone-ip.de ([178.4.206.19] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1m5AjK-0006oR-Te; Sun, 18 Jul 2021 19:37:30 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 06/10] staging: rtl8188eu: remove efuse write support
Date:   Sun, 18 Jul 2021 19:36:06 +0200
Message-Id: <20210718173610.894-6-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210718173610.894-1-martin@kaiser.cx>
References: <20210718173610.894-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver does not need write access to the rtl1888eu chip's efuses.
Remove the code to set the voltages for writing the efuses.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/rtl8188eu/core/rtw_efuse.c | 32 ++--------------------
 1 file changed, 3 insertions(+), 29 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_efuse.c b/drivers/staging/rtl8188eu/core/rtw_efuse.c
index 80673a73c119..0b821df58b77 100644
--- a/drivers/staging/rtl8188eu/core/rtw_efuse.c
+++ b/drivers/staging/rtl8188eu/core/rtw_efuse.c
@@ -16,18 +16,8 @@
 #define REG_EFUSE_CTRL		0x0030
 #define EFUSE_CTRL			REG_EFUSE_CTRL		/*  E-Fuse Control. */
 
-enum{
-		VOLTAGE_V25						= 0x03,
-		LDOE25_SHIFT						= 28,
-	};
-
-/*
- * When we want to enable write operation, we should change to pwr on state.
- * When we stop write, we should switch to 500k mode and disable LDO 2.5V.
- */
-static void efuse_power_switch(struct adapter *pAdapter, u8 write, u8 pwrstate)
+static void efuse_power_switch(struct adapter *pAdapter, u8 pwrstate)
 {
-	u8 tempval;
 	u16 tmpv16;
 
 	if (pwrstate) {
@@ -52,22 +42,8 @@ static void efuse_power_switch(struct adapter *pAdapter, u8 write, u8 pwrstate)
 			tmpv16 |= (LOADER_CLK_EN | ANA8M);
 			usb_write16(pAdapter, REG_SYS_CLKR, tmpv16);
 		}
-
-		if (write) {
-			/*  Enable LDO 2.5V before read/write action */
-			tempval = usb_read8(pAdapter, EFUSE_TEST + 3);
-			tempval &= 0x0F;
-			tempval |= (VOLTAGE_V25 << 4);
-			usb_write8(pAdapter, EFUSE_TEST + 3, (tempval | 0x80));
-		}
 	} else {
 		usb_write8(pAdapter, REG_EFUSE_ACCESS, EFUSE_ACCESS_OFF);
-
-		if (write) {
-			/*  Disable LDO 2.5V after read/write action */
-			tempval = usb_read8(pAdapter, EFUSE_TEST + 3);
-			usb_write8(pAdapter, EFUSE_TEST + 3, (tempval & 0x7F));
-		}
 	}
 }
 
@@ -857,11 +833,9 @@ void efuse_WordEnableDataRead(u8 word_en, u8 *sourdata, u8 *targetdata)
 /* Read All Efuse content */
 static void Efuse_ReadAllMap(struct adapter *pAdapter, u8 *Efuse)
 {
-	efuse_power_switch(pAdapter, false, true);
-
+	efuse_power_switch(pAdapter, true);
 	efuse_ReadEFuse(pAdapter, 0, EFUSE_MAP_LEN_88E, Efuse);
-
-	efuse_power_switch(pAdapter, false, false);
+	efuse_power_switch(pAdapter, false);
 }
 
 /* Transfer current EFUSE content to shadow init and modify map. */
-- 
2.20.1

