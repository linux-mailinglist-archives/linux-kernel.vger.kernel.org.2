Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCFFB44F4B0
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 19:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236052AbhKMS6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Nov 2021 13:58:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236079AbhKMS6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Nov 2021 13:58:47 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A794C061200
        for <linux-kernel@vger.kernel.org>; Sat, 13 Nov 2021 10:55:54 -0800 (PST)
Received: from dslb-188-096-147-224.188.096.pools.vodafone-ip.de ([188.96.147.224] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mlyBp-0002H8-Og; Sat, 13 Nov 2021 19:55:49 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 05/15] staging: r8188eu: rtl8188e_EfuseGetCurrentSize is now unused
Date:   Sat, 13 Nov 2021 19:55:08 +0100
Message-Id: <20211113185518.23941-6-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211113185518.23941-1-martin@kaiser.cx>
References: <20211113185518.23941-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After we removed efuse write support, rtl8188e_EfuseGetCurrentSize is no
longer needed. Remove this function and its internal helpers.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 .../staging/r8188eu/hal/rtl8188e_hal_init.c   | 62 -------------------
 drivers/staging/r8188eu/include/hal_intf.h    |  1 -
 2 files changed, 63 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index d658f3f5df32..8205f6237520 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -903,68 +903,6 @@ void rtl8188e_EFUSE_GetEfuseDefinition(struct adapter *pAdapter, u8 type, void *
 	Hal_EFUSEGetEfuseDefinition88E(pAdapter, type, pOut);
 }
 
-static u16 hal_EfuseGetCurrentSize_8188e(struct adapter *pAdapter, bool bPseudoTest)
-{
-	int	bContinual = true;
-	u16	efuse_addr = 0;
-	u8 hworden = 0;
-	u8 efuse_data, word_cnts = 0;
-
-	if (bPseudoTest)
-		efuse_addr = (u16)(fakeEfuseUsedBytes);
-	else
-		GetHwReg8188EU(pAdapter, HW_VAR_EFUSE_BYTES, (u8 *)&efuse_addr);
-
-	while (bContinual &&
-	       efuse_OneByteRead(pAdapter, efuse_addr, &efuse_data, bPseudoTest) &&
-	       AVAILABLE_EFUSE_ADDR(efuse_addr)) {
-		if (efuse_data != 0xFF) {
-			if ((efuse_data & 0x1F) == 0x0F) {		/* extended header */
-				efuse_addr++;
-				efuse_OneByteRead(pAdapter, efuse_addr, &efuse_data, bPseudoTest);
-				if ((efuse_data & 0x0F) == 0x0F) {
-					efuse_addr++;
-					continue;
-				} else {
-					hworden = efuse_data & 0x0F;
-				}
-			} else {
-				hworden =  efuse_data & 0x0F;
-			}
-			word_cnts = Efuse_CalculateWordCnts(hworden);
-			/* read next header */
-			efuse_addr = efuse_addr + (word_cnts * 2) + 1;
-		} else {
-			bContinual = false;
-		}
-	}
-
-	if (bPseudoTest)
-		fakeEfuseUsedBytes = efuse_addr;
-	else
-		SetHwReg8188EU(pAdapter, HW_VAR_EFUSE_BYTES, (u8 *)&efuse_addr);
-
-	return efuse_addr;
-}
-
-static u16 Hal_EfuseGetCurrentSize_Pseudo(struct adapter *pAdapter, bool bPseudoTest)
-{
-	u16	ret = 0;
-
-	ret = hal_EfuseGetCurrentSize_8188e(pAdapter, bPseudoTest);
-	return ret;
-}
-
-u16 rtl8188e_EfuseGetCurrentSize(struct adapter *pAdapter, u8 efuseType, bool bPseudoTest)
-{
-	u16	ret = 0;
-
-	if (bPseudoTest)
-		ret = Hal_EfuseGetCurrentSize_Pseudo(pAdapter, bPseudoTest);
-	else
-		ret = hal_EfuseGetCurrentSize_8188e(pAdapter, bPseudoTest);
-	return ret;
-}
 
 static int hal_EfusePgPacketRead_8188e(struct adapter *pAdapter, u8 offset, u8 *data, bool bPseudoTest)
 {
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index de9744d065da..01e256f3e268 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -123,7 +123,6 @@ void rtl8188e_free_hal_data(struct adapter *padapter);
 void rtl8188e_EfusePowerSwitch(struct adapter *pAdapter, u8 PwrState);
 void rtl8188e_ReadEFuse(struct adapter *Adapter, u16 _offset, u16 _size_byte, u8 *pbuf);
 void rtl8188e_EFUSE_GetEfuseDefinition(struct adapter *pAdapter, u8 type, void *pOut);
-u16 rtl8188e_EfuseGetCurrentSize(struct adapter *pAdapter, u8 efuseType, bool bPseudoTest);
 int rtl8188e_Efuse_PgPacketRead(struct adapter *pAdapter, u8 offset, u8 *data, bool bPseudoTest);
 
 void hal_notch_filter_8188e(struct adapter *adapter, bool enable);
-- 
2.20.1

