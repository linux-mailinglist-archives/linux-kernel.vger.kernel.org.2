Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5733B44F4B6
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 19:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236228AbhKMS7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Nov 2021 13:59:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236084AbhKMS6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Nov 2021 13:58:52 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB340C061202
        for <linux-kernel@vger.kernel.org>; Sat, 13 Nov 2021 10:55:59 -0800 (PST)
Received: from dslb-188-096-147-224.188.096.pools.vodafone-ip.de ([188.96.147.224] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mlyBv-0002H8-UQ; Sat, 13 Nov 2021 19:55:56 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 11/15] staging: r8188eu: efuse_OneByteRead is unused
Date:   Sat, 13 Nov 2021 19:55:14 +0100
Message-Id: <20211113185518.23941-12-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211113185518.23941-1-martin@kaiser.cx>
References: <20211113185518.23941-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the efuse_OneByteRead function, which is no longer used.
Remove resulting dead code as well.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_efuse.c    | 41 ---------------------
 drivers/staging/r8188eu/include/rtw_efuse.h |  1 -
 2 files changed, 42 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_efuse.c b/drivers/staging/r8188eu/core/rtw_efuse.c
index 1a999d41483b..7829a422d225 100644
--- a/drivers/staging/r8188eu/core/rtw_efuse.c
+++ b/drivers/staging/r8188eu/core/rtw_efuse.c
@@ -29,17 +29,6 @@ u8 fakeBTEfuseModifiedMap[EFUSE_BT_MAX_MAP_LEN] = {0};
 #define REG_EFUSE_CTRL		0x0030
 #define EFUSE_CTRL			REG_EFUSE_CTRL		/*  E-Fuse Control. */
 
-static bool Efuse_Read1ByteFromFakeContent(u16 Offset, u8 *Value)
-{
-	if (Offset >= EFUSE_MAX_HW_SIZE)
-		return false;
-	if (fakeEfuseBank == 0)
-		*Value = fakeEfuseContent[Offset];
-	else
-		*Value = fakeBTEfuseContent[fakeEfuseBank - 1][Offset];
-	return true;
-}
-
 static bool
 Efuse_Write1ByteToFakeContent(u16 Offset, u8 Value)
 {
@@ -117,36 +106,6 @@ ReadEFuseByte(
 	*pbuf = (u8)(value32 & 0xff);
 }
 
-/*  11/16/2008 MH Read one byte from real Efuse. */
-u8 efuse_OneByteRead(struct adapter *pAdapter, u16 addr, u8 *data, bool pseudo)
-{
-	u8 tmpidx = 0;
-	u8 result;
-
-	if (pseudo) {
-		result = Efuse_Read1ByteFromFakeContent(addr, data);
-		return result;
-	}
-	/*  -----------------e-fuse reg ctrl --------------------------------- */
-	/* address */
-	rtw_write8(pAdapter, EFUSE_CTRL + 1, (u8)(addr & 0xff));
-	rtw_write8(pAdapter, EFUSE_CTRL + 2, ((u8)((addr >> 8) & 0x03)) |
-		   (rtw_read8(pAdapter, EFUSE_CTRL + 2) & 0xFC));
-
-	rtw_write8(pAdapter, EFUSE_CTRL + 3,  0x72);/* read cmd */
-
-	while (!(0x80 & rtw_read8(pAdapter, EFUSE_CTRL + 3)) && (tmpidx < 100))
-		tmpidx++;
-	if (tmpidx < 100) {
-		*data = rtw_read8(pAdapter, EFUSE_CTRL);
-		result = true;
-	} else {
-		*data = 0xff;
-		result = false;
-	}
-	return result;
-}
-
 /*  11/16/2008 MH Write one byte to reald Efuse. */
 u8 efuse_OneByteWrite(struct adapter *pAdapter, u16 addr, u8 data, bool pseudo)
 {
diff --git a/drivers/staging/r8188eu/include/rtw_efuse.h b/drivers/staging/r8188eu/include/rtw_efuse.h
index 825f880a71da..f21d08d1be90 100644
--- a/drivers/staging/r8188eu/include/rtw_efuse.h
+++ b/drivers/staging/r8188eu/include/rtw_efuse.h
@@ -70,7 +70,6 @@ extern u8 fakeBTEfuseModifiedMap[];
 
 u8 Efuse_CalculateWordCnts(u8 word_en);
 void ReadEFuseByte(struct adapter *adapter, u16 _offset, u8 *pbuf);
-u8 efuse_OneByteRead(struct adapter *adapter, u16 addr, u8 *data, bool test);
 u8 efuse_OneByteWrite(struct adapter *adapter, u16 addr, u8 data, bool	test);
 
 void efuse_WordEnableDataRead(u8 word_en, u8 *sourdata, u8 *targetdata);
-- 
2.20.1

