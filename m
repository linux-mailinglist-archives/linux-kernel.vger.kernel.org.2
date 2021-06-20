Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A79F3ADFB6
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jun 2021 19:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbhFTR4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Jun 2021 13:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbhFTRzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jun 2021 13:55:43 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FBDDC061574;
        Sun, 20 Jun 2021 10:53:29 -0700 (PDT)
Received: from dslb-084-059-235-131.084.059.pools.vodafone-ip.de ([84.59.235.131] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1lv1dP-00012S-Ty; Sun, 20 Jun 2021 19:53:28 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 05/13] staging: rtl8188eu: remove efuse type
Date:   Sun, 20 Jun 2021 19:52:53 +0200
Message-Id: <20210620175301.14988-5-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210620175301.14988-1-martin@kaiser.cx>
References: <20210620175301.14988-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A number of efuse-related functions have an "efuse type" parameter.
This type is not used and can be removed.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/rtl8188eu/core/rtw_efuse.c    | 36 +++++++++----------
 .../staging/rtl8188eu/hal/rtl8188e_hal_init.c |  4 +--
 drivers/staging/rtl8188eu/include/rtw_efuse.h |  8 ++---
 3 files changed, 21 insertions(+), 27 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_efuse.c b/drivers/staging/rtl8188eu/core/rtw_efuse.c
index 21619fd67217..7d5d0fdc1aaa 100644
--- a/drivers/staging/rtl8188eu/core/rtw_efuse.c
+++ b/drivers/staging/rtl8188eu/core/rtw_efuse.c
@@ -281,7 +281,7 @@ static s32 iol_read_efuse(struct adapter *padapter, u8 txpktbuf_bndy, u16 offset
 	return status;
 }
 
-void efuse_ReadEFuse(struct adapter *Adapter, u8 efuseType, u16 _offset, u16 _size_byte, u8 *pbuf)
+void efuse_ReadEFuse(struct adapter *Adapter, u16 _offset, u16 _size_byte, u8 *pbuf)
 {
 	if (rtw_iol_applied(Adapter)) {
 		rtw_hal_power_on(Adapter);
@@ -461,7 +461,7 @@ int Efuse_PgPacketRead(struct adapter *pAdapter, u8 offset, u8 *data)
 		return true;
 }
 
-static bool hal_EfuseFixHeaderProcess(struct adapter *pAdapter, u8 efuseType, struct pgpkt *pFixPkt, u16 *pAddr)
+static bool hal_EfuseFixHeaderProcess(struct adapter *pAdapter, struct pgpkt *pFixPkt, u16 *pAddr)
 {
 	u8 originaldata[8], badworden = 0;
 	u16	efuse_addr = *pAddr;
@@ -490,7 +490,7 @@ static bool hal_EfuseFixHeaderProcess(struct adapter *pAdapter, u8 efuseType, st
 	return true;
 }
 
-static bool hal_EfusePgPacketWrite2ByteHeader(struct adapter *pAdapter, u8 efuseType, u16 *pAddr, struct pgpkt *pTargetPkt)
+static bool hal_EfusePgPacketWrite2ByteHeader(struct adapter *pAdapter, u16 *pAddr, struct pgpkt *pTargetPkt)
 {
 	bool ret = false;
 	u16 efuse_addr = *pAddr;
@@ -541,7 +541,7 @@ static bool hal_EfusePgPacketWrite2ByteHeader(struct adapter *pAdapter, u8 efuse
 				fixPkt.offset = ((pg_header_temp & 0xE0) >> 5) | ((tmp_header & 0xF0) >> 1);
 				fixPkt.word_en = tmp_header & 0x0F;
 				fixPkt.word_cnts = Efuse_CalculateWordCnts(fixPkt.word_en);
-				if (!hal_EfuseFixHeaderProcess(pAdapter, efuseType, &fixPkt, &efuse_addr))
+				if (!hal_EfuseFixHeaderProcess(pAdapter, &fixPkt, &efuse_addr))
 					return false;
 			} else {
 				ret = true;
@@ -557,7 +557,7 @@ static bool hal_EfusePgPacketWrite2ByteHeader(struct adapter *pAdapter, u8 efuse
 	return ret;
 }
 
-static bool hal_EfusePgPacketWrite1ByteHeader(struct adapter *pAdapter, u8 efuseType, u16 *pAddr, struct pgpkt *pTargetPkt)
+static bool hal_EfusePgPacketWrite1ByteHeader(struct adapter *pAdapter, u16 *pAddr, struct pgpkt *pTargetPkt)
 {
 	bool ret = false;
 	u8 pg_header = 0, tmp_header = 0;
@@ -584,7 +584,7 @@ static bool hal_EfusePgPacketWrite1ByteHeader(struct adapter *pAdapter, u8 efuse
 		fixPkt.offset = (tmp_header >> 4) & 0x0F;
 		fixPkt.word_en = tmp_header & 0x0F;
 		fixPkt.word_cnts = Efuse_CalculateWordCnts(fixPkt.word_en);
-		if (!hal_EfuseFixHeaderProcess(pAdapter, efuseType, &fixPkt, &efuse_addr))
+		if (!hal_EfuseFixHeaderProcess(pAdapter, &fixPkt, &efuse_addr))
 			return false;
 	}
 
@@ -592,7 +592,7 @@ static bool hal_EfusePgPacketWrite1ByteHeader(struct adapter *pAdapter, u8 efuse
 	return ret;
 }
 
-static bool hal_EfusePgPacketWriteData(struct adapter *pAdapter, u8 efuseType, u16 *pAddr, struct pgpkt *pTargetPkt)
+static bool hal_EfusePgPacketWriteData(struct adapter *pAdapter, u16 *pAddr, struct pgpkt *pTargetPkt)
 {
 	u16	efuse_addr = *pAddr;
 	u8 badworden;
@@ -614,16 +614,15 @@ static bool hal_EfusePgPacketWriteData(struct adapter *pAdapter, u8 efuseType, u
 static bool
 hal_EfusePgPacketWriteHeader(
 				struct adapter *pAdapter,
-				u8 efuseType,
 				u16				*pAddr,
 				struct pgpkt *pTargetPkt)
 {
 	bool ret = false;
 
 	if (pTargetPkt->offset >= EFUSE_MAX_SECTION_BASE)
-		ret = hal_EfusePgPacketWrite2ByteHeader(pAdapter, efuseType, pAddr, pTargetPkt);
+		ret = hal_EfusePgPacketWrite2ByteHeader(pAdapter, pAddr, pTargetPkt);
 	else
-		ret = hal_EfusePgPacketWrite1ByteHeader(pAdapter, efuseType, pAddr, pTargetPkt);
+		ret = hal_EfusePgPacketWrite1ByteHeader(pAdapter, pAddr, pTargetPkt);
 
 	return ret;
 }
@@ -667,7 +666,7 @@ static bool hal_EfuseCheckIfDatafollowed(struct adapter *pAdapter, u8 word_cnts,
 	return ret;
 }
 
-static bool hal_EfusePartialWriteCheck(struct adapter *pAdapter, u8 efuseType, u16 *pAddr, struct pgpkt *pTargetPkt)
+static bool hal_EfusePartialWriteCheck(struct adapter *pAdapter, u16 *pAddr, struct pgpkt *pTargetPkt)
 {
 	bool ret = false;
 	u8 i, efuse_data = 0, cur_header = 0;
@@ -754,20 +753,19 @@ bool Efuse_PgPacketWrite(struct adapter *pAdapter, u8 offset, u8 word_en, u8 *pD
 {
 	struct pgpkt	targetPkt;
 	u16			startAddr = 0;
-	u8 efuseType = EFUSE_WIFI;
 
 	if (Efuse_GetCurrentSize(pAdapter) >= EFUSE_MAP_LEN_88E)
 		return false;
 
 	hal_EfuseConstructPGPkt(offset, word_en, pData, &targetPkt);
 
-	if (!hal_EfusePartialWriteCheck(pAdapter, efuseType, &startAddr, &targetPkt))
+	if (!hal_EfusePartialWriteCheck(pAdapter, &startAddr, &targetPkt))
 		return false;
 
-	if (!hal_EfusePgPacketWriteHeader(pAdapter, efuseType, &startAddr, &targetPkt))
+	if (!hal_EfusePgPacketWriteHeader(pAdapter, &startAddr, &targetPkt))
 		return false;
 
-	if (!hal_EfusePgPacketWriteData(pAdapter, efuseType, &startAddr, &targetPkt))
+	if (!hal_EfusePgPacketWriteData(pAdapter, &startAddr, &targetPkt))
 		return false;
 
 	return true;
@@ -857,22 +855,22 @@ void efuse_WordEnableDataRead(u8 word_en, u8 *sourdata, u8 *targetdata)
 }
 
 /* Read All Efuse content */
-static void Efuse_ReadAllMap(struct adapter *pAdapter, u8 efuseType, u8 *Efuse)
+static void Efuse_ReadAllMap(struct adapter *pAdapter, u8 *Efuse)
 {
 	efuse_power_switch(pAdapter, false, true);
 
-	efuse_ReadEFuse(pAdapter, efuseType, 0, EFUSE_MAP_LEN_88E, Efuse);
+	efuse_ReadEFuse(pAdapter, 0, EFUSE_MAP_LEN_88E, Efuse);
 
 	efuse_power_switch(pAdapter, false, false);
 }
 
 /* Transfer current EFUSE content to shadow init and modify map. */
-void EFUSE_ShadowMapUpdate(struct adapter *pAdapter, u8 efuseType)
+void EFUSE_ShadowMapUpdate(struct adapter *pAdapter)
 {
 	struct eeprom_priv *pEEPROM = GET_EEPROM_EFUSE_PRIV(pAdapter);
 
 	if (pEEPROM->bautoload_fail_flag)
 		memset(pEEPROM->efuse_eeprom_data, 0xFF, EFUSE_MAP_LEN_88E);
 	else
-		Efuse_ReadAllMap(pAdapter, efuseType, pEEPROM->efuse_eeprom_data);
+		Efuse_ReadAllMap(pAdapter, pEEPROM->efuse_eeprom_data);
 }
diff --git a/drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c
index 5c76d0de6c91..22c9b20de342 100644
--- a/drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c
@@ -235,12 +235,12 @@ void Hal_InitPGData88E(struct adapter *padapter)
 	if (!pEEPROM->bautoload_fail_flag) { /*  autoload OK. */
 		if (!is_boot_from_eeprom(padapter)) {
 			/*  Read EFUSE real map to shadow. */
-			EFUSE_ShadowMapUpdate(padapter, EFUSE_WIFI);
+			EFUSE_ShadowMapUpdate(padapter);
 		}
 	} else {/* autoload fail */
 		/* update to default value 0xFF */
 		if (!is_boot_from_eeprom(padapter))
-			EFUSE_ShadowMapUpdate(padapter, EFUSE_WIFI);
+			EFUSE_ShadowMapUpdate(padapter);
 	}
 }
 
diff --git a/drivers/staging/rtl8188eu/include/rtw_efuse.h b/drivers/staging/rtl8188eu/include/rtw_efuse.h
index 74182c32c4ec..5f7d20baec6b 100644
--- a/drivers/staging/rtl8188eu/include/rtw_efuse.h
+++ b/drivers/staging/rtl8188eu/include/rtw_efuse.h
@@ -23,9 +23,6 @@
 
 #define	PGPKT_DATA_SIZE		8
 
-#define	EFUSE_WIFI				0
-#define	EFUSE_BT				1
-
 /* E-Fuse */
 #define EFUSE_MAP_SIZE      512
 #define EFUSE_MAX_SIZE      256
@@ -60,13 +57,12 @@ u8 Efuse_CalculateWordCnts(u8 word_en);
 u8 efuse_OneByteRead(struct adapter *adapter, u16 addr, u8 *data);
 u8 efuse_OneByteWrite(struct adapter *adapter, u16 addr, u8 data);
 
-void efuse_ReadEFuse(struct adapter *Adapter, u8 efuseType, u16 _offset,
-		u16 _size_byte, u8 *pbuf);
+void efuse_ReadEFuse(struct adapter *Adapter, u16 _offset, u16 _size_byte, u8 *pbuf);
 int Efuse_PgPacketRead(struct adapter *adapt, u8 offset, u8 *data);
 bool Efuse_PgPacketWrite(struct adapter *adapter, u8 offset, u8 word, u8 *data);
 void efuse_WordEnableDataRead(u8 word_en, u8 *sourdata, u8 *targetdata);
 u8 Efuse_WordEnableDataWrite(struct adapter *adapter, u16 efuse_addr,
 			     u8 word_en, u8 *data);
 
-void EFUSE_ShadowMapUpdate(struct adapter *adapter, u8 efusetype);
+void EFUSE_ShadowMapUpdate(struct adapter *adapter);
 #endif
-- 
2.20.1

