Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 096A64106DC
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 15:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234037AbhIRNmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 09:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbhIRNmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 09:42:07 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F56C061574
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 06:40:43 -0700 (PDT)
Received: from dslb-178-004-203-016.178.004.pools.vodafone-ip.de ([178.4.203.16] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mRaa2-0001lQ-0u; Sat, 18 Sep 2021 15:40:34 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH] staging: r8188eu: do not write past the end of an array
Date:   Sat, 18 Sep 2021 15:40:24 +0200
Message-Id: <20210918134024.23837-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit f7b687d6b67e ("staging: r8188eu: remove NumTotalRFPath from struct
hal_data_8188e") removed a for loop around a block of code that is executed
only once when i == 0. However, without the for loop, i will never be set
to 0 before the code block is executed. i remains at 2, which is the final
value after the previous loop. This results in a write past the end of the
powerlevel and MCSBase arrays.

[   28.480809] Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: rtl8188e_PHY_RF6052SetOFDMTxPower+0x124/0x128 [r8188eu]
[   28.493752] ---[ end Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: rtl8188e_PHY_RF6052SetOFDMTxPower+0x124/0x128 [r8188eu] ]---

Fix this by replacing i with 0 in the code block that used to be the body of
the loop. While at it, remove the powerlevel array that was just holding a
temporary value.

Tested with Edimax EW-7811Un V2 on an ARM32 embedded system.

Fixes: f7b687d6b67e ("staging: r8188eu: remove NumTotalRFPath from struct hal_data_8188e")
Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/rtl8188e_rf6052.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c b/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c
index 2f16c0966973..b334864feffd 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c
@@ -227,7 +227,7 @@ static void getpowerbase88e(struct adapter *Adapter, u8 *pPowerLevelOFDM,
 {
 	struct hal_data_8188e *pHalData = GET_HAL_DATA(Adapter);
 	u32 powerBase0, powerBase1;
-	u8 i, powerlevel[2];
+	u8 i;
 
 	for (i = 0; i < 2; i++) {
 		powerBase0 = pPowerLevelOFDM[i];
@@ -238,12 +238,11 @@ static void getpowerbase88e(struct adapter *Adapter, u8 *pPowerLevelOFDM,
 
 	/* Check HT20 to HT40 diff */
 	if (pHalData->CurrentChannelBW == HT_CHANNEL_WIDTH_20)
-		powerlevel[i] = pPowerLevelBW20[i];
+		powerBase1 = pPowerLevelBW20[0];
 	else
-		powerlevel[i] = pPowerLevelBW40[i];
-	powerBase1 = powerlevel[i];
+		powerBase1 = pPowerLevelBW40[0];
 	powerBase1 = (powerBase1 << 24) | (powerBase1 << 16) | (powerBase1 << 8) | powerBase1;
-	*(MCSBase + i) = powerBase1;
+	*MCSBase = powerBase1;
 }
 
 static void get_rx_power_val_by_reg(struct adapter *Adapter, u8 Channel,
-- 
2.20.1

