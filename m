Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3EB4473B0
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Nov 2021 17:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235726AbhKGQTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 11:19:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234805AbhKGQTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 11:19:51 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D409FC061570
        for <linux-kernel@vger.kernel.org>; Sun,  7 Nov 2021 08:17:08 -0800 (PST)
Received: from dslb-178-004-202-058.178.004.pools.vodafone-ip.de ([178.4.202.58] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mjkqw-0002GA-7A; Sun, 07 Nov 2021 17:17:06 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 2/2] staging: r8188eu: remove efuse write functions
Date:   Sun,  7 Nov 2021 17:16:24 +0100
Message-Id: <20211107161624.9452-3-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211107161624.9452-1-martin@kaiser.cx>
References: <20211107161624.9452-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The r8188eu driver in its current state does not need write access
to the efuses. Only read access is required to get the chip id, the
mac address and other settings.

This patch removes a lot of unused code for writing the efuses.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 .../staging/r8188eu/hal/rtl8188e_hal_init.c   | 463 ------------------
 drivers/staging/r8188eu/include/hal_intf.h    |   1 -
 2 files changed, 464 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index 7f732f3ee53c..84f3cfd571c6 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -651,28 +651,6 @@ enum{
 		LDOE25_SHIFT						= 28,
 	};
 
-static bool
-hal_EfusePgPacketWrite2ByteHeader(
-		struct adapter *pAdapter,
-		u8 efuseType,
-		u16				*pAddr,
-		struct pgpkt *pTargetPkt,
-		bool bPseudoTest);
-static bool
-hal_EfusePgPacketWrite1ByteHeader(
-		struct adapter *pAdapter,
-		u8 efuseType,
-		u16				*pAddr,
-		struct pgpkt *pTargetPkt,
-		bool bPseudoTest);
-static bool
-hal_EfusePgPacketWriteData(
-		struct adapter *pAdapter,
-		u8 efuseType,
-		u16				*pAddr,
-		struct pgpkt *pTargetPkt,
-		bool bPseudoTest);
-
 void rtl8188e_EfusePowerSwitch(struct adapter *pAdapter, u8 PwrState)
 {
 	u16	tmpV16;
@@ -1006,77 +984,6 @@ void rtl8188e_EFUSE_GetEfuseDefinition(struct adapter *pAdapter, u8 efuseType, u
 		Hal_EFUSEGetEfuseDefinition88E(pAdapter, efuseType, type, pOut);
 }
 
-static u8 Hal_EfuseWordEnableDataWrite(struct adapter *pAdapter, u16 efuse_addr, u8 word_en, u8 *data, bool bPseudoTest)
-{
-	u16	tmpaddr = 0;
-	u16	start_addr = efuse_addr;
-	u8 badworden = 0x0F;
-	u8 tmpdata[8];
-
-	memset((void *)tmpdata, 0xff, PGPKT_DATA_SIZE);
-
-	if (!(word_en & BIT(0))) {
-		tmpaddr = start_addr;
-		efuse_OneByteWrite(pAdapter, start_addr++, data[0], bPseudoTest);
-		efuse_OneByteWrite(pAdapter, start_addr++, data[1], bPseudoTest);
-
-		efuse_OneByteRead(pAdapter, tmpaddr, &tmpdata[0], bPseudoTest);
-		efuse_OneByteRead(pAdapter, tmpaddr + 1, &tmpdata[1], bPseudoTest);
-		if ((data[0] != tmpdata[0]) || (data[1] != tmpdata[1]))
-			badworden &= (~BIT(0));
-	}
-	if (!(word_en & BIT(1))) {
-		tmpaddr = start_addr;
-		efuse_OneByteWrite(pAdapter, start_addr++, data[2], bPseudoTest);
-		efuse_OneByteWrite(pAdapter, start_addr++, data[3], bPseudoTest);
-
-		efuse_OneByteRead(pAdapter, tmpaddr, &tmpdata[2], bPseudoTest);
-		efuse_OneByteRead(pAdapter, tmpaddr + 1, &tmpdata[3], bPseudoTest);
-		if ((data[2] != tmpdata[2]) || (data[3] != tmpdata[3]))
-			badworden &= (~BIT(1));
-	}
-	if (!(word_en & BIT(2))) {
-		tmpaddr = start_addr;
-		efuse_OneByteWrite(pAdapter, start_addr++, data[4], bPseudoTest);
-		efuse_OneByteWrite(pAdapter, start_addr++, data[5], bPseudoTest);
-
-		efuse_OneByteRead(pAdapter, tmpaddr, &tmpdata[4], bPseudoTest);
-		efuse_OneByteRead(pAdapter, tmpaddr + 1, &tmpdata[5], bPseudoTest);
-		if ((data[4] != tmpdata[4]) || (data[5] != tmpdata[5]))
-			badworden &= (~BIT(2));
-	}
-	if (!(word_en & BIT(3))) {
-		tmpaddr = start_addr;
-		efuse_OneByteWrite(pAdapter, start_addr++, data[6], bPseudoTest);
-		efuse_OneByteWrite(pAdapter, start_addr++, data[7], bPseudoTest);
-
-		efuse_OneByteRead(pAdapter, tmpaddr, &tmpdata[6], bPseudoTest);
-		efuse_OneByteRead(pAdapter, tmpaddr + 1, &tmpdata[7], bPseudoTest);
-		if ((data[6] != tmpdata[6]) || (data[7] != tmpdata[7]))
-			badworden &= (~BIT(3));
-	}
-	return badworden;
-}
-
-static u8 Hal_EfuseWordEnableDataWrite_Pseudo(struct adapter *pAdapter, u16 efuse_addr, u8 word_en, u8 *data, bool bPseudoTest)
-{
-	u8 ret;
-
-	ret = Hal_EfuseWordEnableDataWrite(pAdapter, efuse_addr, word_en, data, bPseudoTest);
-	return ret;
-}
-
-static u8 rtl8188e_Efuse_WordEnableDataWrite(struct adapter *pAdapter, u16 efuse_addr, u8 word_en, u8 *data, bool bPseudoTest)
-{
-	u8 ret = 0;
-
-	if (bPseudoTest)
-		ret = Hal_EfuseWordEnableDataWrite_Pseudo(pAdapter, efuse_addr, word_en, data, bPseudoTest);
-	else
-		ret = Hal_EfuseWordEnableDataWrite(pAdapter, efuse_addr, word_en, data, bPseudoTest);
-	return ret;
-}
-
 static u16 hal_EfuseGetCurrentSize_8188e(struct adapter *pAdapter, bool bPseudoTest)
 {
 	int	bContinual = true;
@@ -1253,376 +1160,6 @@ int rtl8188e_Efuse_PgPacketRead(struct adapter *pAdapter, u8 offset, u8 *data, b
 	return ret;
 }
 
-static bool hal_EfuseFixHeaderProcess(struct adapter *pAdapter, u8 efuseType, struct pgpkt *pFixPkt, u16 *pAddr, bool bPseudoTest)
-{
-	u8 originaldata[8], badworden = 0;
-	u16	efuse_addr = *pAddr;
-	u32	PgWriteSuccess = 0;
-
-	memset((void *)originaldata, 0xff, 8);
-
-	if (rtl8188e_Efuse_PgPacketRead(pAdapter, pFixPkt->offset, originaldata, bPseudoTest)) {
-		/* check if data exist */
-		badworden = rtl8188e_Efuse_WordEnableDataWrite(pAdapter, efuse_addr + 1, pFixPkt->word_en, originaldata, bPseudoTest);
-
-		if (badworden != 0xf) {	/*  write fail */
-			PgWriteSuccess = rtl8188e_Efuse_PgPacketWrite(pAdapter, pFixPkt->offset, badworden, originaldata, bPseudoTest);
-
-			if (!PgWriteSuccess)
-				return false;
-			else
-				efuse_addr = rtl8188e_EfuseGetCurrentSize(pAdapter, efuseType, bPseudoTest);
-		} else {
-			efuse_addr = efuse_addr + (pFixPkt->word_cnts * 2) + 1;
-		}
-	} else {
-		efuse_addr = efuse_addr + (pFixPkt->word_cnts * 2) + 1;
-	}
-	*pAddr = efuse_addr;
-	return true;
-}
-
-static bool hal_EfusePgPacketWrite2ByteHeader(struct adapter *pAdapter, u8 efuseType, u16 *pAddr, struct pgpkt *pTargetPkt, bool bPseudoTest)
-{
-	bool bRet = false;
-	u16	efuse_addr = *pAddr, efuse_max_available_len = 0;
-	u8 pg_header = 0, tmp_header = 0, pg_header_temp = 0;
-	u8 repeatcnt = 0;
-
-	rtl8188e_EFUSE_GetEfuseDefinition(pAdapter, efuseType, TYPE_AVAILABLE_EFUSE_BYTES_BANK, (void *)&efuse_max_available_len, bPseudoTest);
-
-	while (efuse_addr < efuse_max_available_len) {
-		pg_header = ((pTargetPkt->offset & 0x07) << 5) | 0x0F;
-		efuse_OneByteWrite(pAdapter, efuse_addr, pg_header, bPseudoTest);
-		efuse_OneByteRead(pAdapter, efuse_addr, &tmp_header, bPseudoTest);
-
-		while (tmp_header == 0xFF) {
-			if (repeatcnt++ > EFUSE_REPEAT_THRESHOLD_)
-				return false;
-
-			efuse_OneByteWrite(pAdapter, efuse_addr, pg_header, bPseudoTest);
-			efuse_OneByteRead(pAdapter, efuse_addr, &tmp_header, bPseudoTest);
-		}
-
-		/* to write ext_header */
-		if (tmp_header == pg_header) {
-			efuse_addr++;
-			pg_header_temp = pg_header;
-			pg_header = ((pTargetPkt->offset & 0x78) << 1) | pTargetPkt->word_en;
-
-			efuse_OneByteWrite(pAdapter, efuse_addr, pg_header, bPseudoTest);
-			efuse_OneByteRead(pAdapter, efuse_addr, &tmp_header, bPseudoTest);
-
-			while (tmp_header == 0xFF) {
-				if (repeatcnt++ > EFUSE_REPEAT_THRESHOLD_)
-					return false;
-
-				efuse_OneByteWrite(pAdapter, efuse_addr, pg_header, bPseudoTest);
-				efuse_OneByteRead(pAdapter, efuse_addr, &tmp_header, bPseudoTest);
-			}
-
-			if ((tmp_header & 0x0F) == 0x0F) {	/* word_en PG fail */
-				if (repeatcnt++ > EFUSE_REPEAT_THRESHOLD_) {
-					return false;
-				} else {
-					efuse_addr++;
-					continue;
-				}
-			} else if (pg_header != tmp_header) {	/* offset PG fail */
-				struct pgpkt	fixPkt;
-				fixPkt.offset = ((pg_header_temp & 0xE0) >> 5) | ((tmp_header & 0xF0) >> 1);
-				fixPkt.word_en = tmp_header & 0x0F;
-				fixPkt.word_cnts = Efuse_CalculateWordCnts(fixPkt.word_en);
-				if (!hal_EfuseFixHeaderProcess(pAdapter, efuseType, &fixPkt, &efuse_addr, bPseudoTest))
-					return false;
-			} else {
-				bRet = true;
-				break;
-			}
-		} else if ((tmp_header & 0x1F) == 0x0F) {		/* wrong extended header */
-			efuse_addr += 2;
-			continue;
-		}
-	}
-
-	*pAddr = efuse_addr;
-	return bRet;
-}
-
-static bool hal_EfusePgPacketWrite1ByteHeader(struct adapter *pAdapter, u8 efuseType, u16 *pAddr, struct pgpkt *pTargetPkt, bool bPseudoTest)
-{
-	bool bRet = false;
-	u8 pg_header = 0, tmp_header = 0;
-	u16	efuse_addr = *pAddr;
-	u8 repeatcnt = 0;
-
-	pg_header = ((pTargetPkt->offset << 4) & 0xf0) | pTargetPkt->word_en;
-
-	efuse_OneByteWrite(pAdapter, efuse_addr, pg_header, bPseudoTest);
-	efuse_OneByteRead(pAdapter, efuse_addr, &tmp_header, bPseudoTest);
-
-	while (tmp_header == 0xFF) {
-		if (repeatcnt++ > EFUSE_REPEAT_THRESHOLD_)
-			return false;
-		efuse_OneByteWrite(pAdapter, efuse_addr, pg_header, bPseudoTest);
-		efuse_OneByteRead(pAdapter, efuse_addr, &tmp_header, bPseudoTest);
-	}
-
-	if (pg_header == tmp_header) {
-		bRet = true;
-	} else {
-		struct pgpkt	fixPkt;
-		fixPkt.offset = (tmp_header >> 4) & 0x0F;
-		fixPkt.word_en = tmp_header & 0x0F;
-		fixPkt.word_cnts = Efuse_CalculateWordCnts(fixPkt.word_en);
-		if (!hal_EfuseFixHeaderProcess(pAdapter, efuseType, &fixPkt, &efuse_addr, bPseudoTest))
-			return false;
-	}
-
-	*pAddr = efuse_addr;
-	return bRet;
-}
-
-static bool hal_EfusePgPacketWriteData(struct adapter *pAdapter, u8 efuseType, u16 *pAddr, struct pgpkt *pTargetPkt, bool bPseudoTest)
-{
-	u16	efuse_addr = *pAddr;
-	u8 badworden;
-	u32	PgWriteSuccess = 0;
-
-	badworden = rtl8188e_Efuse_WordEnableDataWrite(pAdapter, efuse_addr + 1, pTargetPkt->word_en, pTargetPkt->data, bPseudoTest);
-	if (badworden == 0x0F) {
-		/*  write ok */
-		return true;
-	} else {
-		/* reorganize other pg packet */
-		PgWriteSuccess = rtl8188e_Efuse_PgPacketWrite(pAdapter, pTargetPkt->offset, badworden, pTargetPkt->data, bPseudoTest);
-		if (!PgWriteSuccess)
-			return false;
-		else
-			return true;
-	}
-}
-
-static bool
-hal_EfusePgPacketWriteHeader(
-				struct adapter *pAdapter,
-				u8 efuseType,
-				u16				*pAddr,
-				struct pgpkt *pTargetPkt,
-				bool bPseudoTest)
-{
-	bool bRet = false;
-
-	if (pTargetPkt->offset >= EFUSE_MAX_SECTION_BASE)
-		bRet = hal_EfusePgPacketWrite2ByteHeader(pAdapter, efuseType, pAddr, pTargetPkt, bPseudoTest);
-	else
-		bRet = hal_EfusePgPacketWrite1ByteHeader(pAdapter, efuseType, pAddr, pTargetPkt, bPseudoTest);
-
-	return bRet;
-}
-
-static bool wordEnMatched(struct pgpkt *pTargetPkt, struct pgpkt *pCurPkt,
-			  u8 *pWden)
-{
-	u8 match_word_en = 0x0F;	/*  default all words are disabled */
-
-	/*  check if the same words are enabled both target and current PG packet */
-	if (((pTargetPkt->word_en & BIT(0)) == 0) &&
-	    ((pCurPkt->word_en & BIT(0)) == 0))
-		match_word_en &= ~BIT(0);				/*  enable word 0 */
-	if (((pTargetPkt->word_en & BIT(1)) == 0) &&
-	    ((pCurPkt->word_en & BIT(1)) == 0))
-		match_word_en &= ~BIT(1);				/*  enable word 1 */
-	if (((pTargetPkt->word_en & BIT(2)) == 0) &&
-	    ((pCurPkt->word_en & BIT(2)) == 0))
-		match_word_en &= ~BIT(2);				/*  enable word 2 */
-	if (((pTargetPkt->word_en & BIT(3)) == 0) &&
-	    ((pCurPkt->word_en & BIT(3)) == 0))
-		match_word_en &= ~BIT(3);				/*  enable word 3 */
-
-	*pWden = match_word_en;
-
-	if (match_word_en != 0xf)
-		return true;
-	else
-		return false;
-}
-
-static bool hal_EfuseCheckIfDatafollowed(struct adapter *pAdapter, u8 word_cnts, u16 startAddr, bool bPseudoTest)
-{
-	bool bRet = false;
-	u8 i, efuse_data;
-
-	for (i = 0; i < (word_cnts * 2); i++) {
-		if (efuse_OneByteRead(pAdapter, (startAddr + i), &efuse_data, bPseudoTest) && (efuse_data != 0xFF))
-			bRet = true;
-	}
-	return bRet;
-}
-
-static bool hal_EfusePartialWriteCheck(struct adapter *pAdapter, u8 efuseType, u16 *pAddr, struct pgpkt *pTargetPkt, bool bPseudoTest)
-{
-	bool bRet = false;
-	u8 i, efuse_data = 0, cur_header = 0;
-	u8 matched_wden = 0, badworden = 0;
-	u16	startAddr = 0, efuse_max_available_len = 0, efuse_max = 0;
-	struct pgpkt curPkt;
-
-	rtl8188e_EFUSE_GetEfuseDefinition(pAdapter, efuseType, TYPE_AVAILABLE_EFUSE_BYTES_BANK, (void *)&efuse_max_available_len, bPseudoTest);
-	rtl8188e_EFUSE_GetEfuseDefinition(pAdapter, efuseType, TYPE_EFUSE_REAL_CONTENT_LEN, (void *)&efuse_max, bPseudoTest);
-
-	if (efuseType == EFUSE_WIFI) {
-		if (bPseudoTest) {
-			startAddr = (u16)(fakeEfuseUsedBytes % EFUSE_REAL_CONTENT_LEN);
-		} else {
-			GetHwReg8188EU(pAdapter, HW_VAR_EFUSE_BYTES, (u8 *)&startAddr);
-			startAddr %= EFUSE_REAL_CONTENT_LEN;
-		}
-	} else {
-		if (bPseudoTest)
-			startAddr = (u16)(fakeBTEfuseUsedBytes % EFUSE_REAL_CONTENT_LEN);
-		else
-			startAddr = (u16)(BTEfuseUsedBytes % EFUSE_REAL_CONTENT_LEN);
-	}
-
-	while (1) {
-		if (startAddr >= efuse_max_available_len) {
-			bRet = false;
-			break;
-		}
-
-		if (efuse_OneByteRead(pAdapter, startAddr, &efuse_data, bPseudoTest) && (efuse_data != 0xFF)) {
-			if (EXT_HEADER(efuse_data)) {
-				cur_header = efuse_data;
-				startAddr++;
-				efuse_OneByteRead(pAdapter, startAddr, &efuse_data, bPseudoTest);
-				if (ALL_WORDS_DISABLED(efuse_data)) {
-					bRet = false;
-					break;
-				} else {
-					curPkt.offset = ((cur_header & 0xE0) >> 5) | ((efuse_data & 0xF0) >> 1);
-					curPkt.word_en = efuse_data & 0x0F;
-				}
-			} else {
-				cur_header  =  efuse_data;
-				curPkt.offset = (cur_header >> 4) & 0x0F;
-				curPkt.word_en = cur_header & 0x0F;
-			}
-
-			curPkt.word_cnts = Efuse_CalculateWordCnts(curPkt.word_en);
-			/*  if same header is found but no data followed */
-			/*  write some part of data followed by the header. */
-			if ((curPkt.offset == pTargetPkt->offset) &&
-			    (!hal_EfuseCheckIfDatafollowed(pAdapter, curPkt.word_cnts, startAddr + 1, bPseudoTest)) &&
-			    wordEnMatched(pTargetPkt, &curPkt, &matched_wden)) {
-				/*  Here to write partial data */
-				badworden = rtl8188e_Efuse_WordEnableDataWrite(pAdapter, startAddr + 1, matched_wden, pTargetPkt->data, bPseudoTest);
-				if (badworden != 0x0F) {
-					u32	PgWriteSuccess = 0;
-					/*  if write fail on some words, write these bad words again */
-
-					PgWriteSuccess = rtl8188e_Efuse_PgPacketWrite(pAdapter, pTargetPkt->offset, badworden, pTargetPkt->data, bPseudoTest);
-
-					if (!PgWriteSuccess) {
-						bRet = false;	/*  write fail, return */
-						break;
-					}
-				}
-				/*  partial write ok, update the target packet for later use */
-				for (i = 0; i < 4; i++) {
-					if ((matched_wden & (0x1 << i)) == 0)	/*  this word has been written */
-						pTargetPkt->word_en |= (0x1 << i);	/*  disable the word */
-				}
-				pTargetPkt->word_cnts = Efuse_CalculateWordCnts(pTargetPkt->word_en);
-			}
-			/*  read from next header */
-			startAddr = startAddr + (curPkt.word_cnts * 2) + 1;
-		} else {
-			/*  not used header, 0xff */
-			*pAddr = startAddr;
-			bRet = true;
-			break;
-		}
-	}
-	return bRet;
-}
-
-static bool
-hal_EfusePgCheckAvailableAddr(
-		struct adapter *pAdapter,
-		u8 efuseType,
-		bool bPseudoTest
-	)
-{
-	u16	efuse_max_available_len = 0;
-
-	/* Change to check TYPE_EFUSE_MAP_LEN , because 8188E raw 256, logic map over 256. */
-	rtl8188e_EFUSE_GetEfuseDefinition(pAdapter, EFUSE_WIFI, TYPE_EFUSE_MAP_LEN, (void *)&efuse_max_available_len, false);
-
-	if (rtl8188e_EfuseGetCurrentSize(pAdapter, efuseType, bPseudoTest) >= efuse_max_available_len)
-		return false;
-	return true;
-}
-
-static void hal_EfuseConstructPGPkt(u8 offset, u8 word_en, u8 *pData, struct pgpkt *pTargetPkt)
-{
-	memset((void *)pTargetPkt->data, 0xFF, sizeof(u8) * 8);
-	pTargetPkt->offset = offset;
-	pTargetPkt->word_en = word_en;
-	efuse_WordEnableDataRead(word_en, pData, pTargetPkt->data);
-	pTargetPkt->word_cnts = Efuse_CalculateWordCnts(pTargetPkt->word_en);
-}
-
-static bool hal_EfusePgPacketWrite_8188e(struct adapter *pAdapter, u8 offset, u8 word_en, u8 *pData, bool bPseudoTest)
-{
-	struct pgpkt	targetPkt;
-	u16			startAddr = 0;
-	u8 efuseType = EFUSE_WIFI;
-
-	if (!hal_EfusePgCheckAvailableAddr(pAdapter, efuseType, bPseudoTest))
-		return false;
-
-	hal_EfuseConstructPGPkt(offset, word_en, pData, &targetPkt);
-
-	if (!hal_EfusePartialWriteCheck(pAdapter, efuseType, &startAddr, &targetPkt, bPseudoTest))
-		return false;
-
-	if (!hal_EfusePgPacketWriteHeader(pAdapter, efuseType, &startAddr, &targetPkt, bPseudoTest))
-		return false;
-
-	if (!hal_EfusePgPacketWriteData(pAdapter, efuseType, &startAddr, &targetPkt, bPseudoTest))
-		return false;
-
-	return true;
-}
-
-static int Hal_EfusePgPacketWrite_Pseudo(struct adapter *pAdapter, u8 offset, u8 word_en, u8 *data, bool bPseudoTest)
-{
-	int ret;
-
-	ret = hal_EfusePgPacketWrite_8188e(pAdapter, offset, word_en, data, bPseudoTest);
-	return ret;
-}
-
-static int Hal_EfusePgPacketWrite(struct adapter *pAdapter, u8 offset, u8 word_en, u8 *data, bool bPseudoTest)
-{
-	int	ret = 0;
-	ret = hal_EfusePgPacketWrite_8188e(pAdapter, offset, word_en, data, bPseudoTest);
-
-	return ret;
-}
-
-int rtl8188e_Efuse_PgPacketWrite(struct adapter *pAdapter, u8 offset, u8 word_en, u8 *data, bool bPseudoTest)
-{
-	int	ret;
-
-	if (bPseudoTest)
-		ret = Hal_EfusePgPacketWrite_Pseudo(pAdapter, offset, word_en, data, bPseudoTest);
-	else
-		ret = Hal_EfusePgPacketWrite(pAdapter, offset, word_en, data, bPseudoTest);
-	return ret;
-}
-
 void rtl8188e_read_chip_version(struct adapter *padapter)
 {
 	u32				value32;
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index 8d9c31bd3f3c..e27300678114 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -128,7 +128,6 @@ void rtl8188e_EFUSE_GetEfuseDefinition(struct adapter *pAdapter, u8 efuseType,
 				       u8 type, void *pOut, bool bPseudoTest);
 u16 rtl8188e_EfuseGetCurrentSize(struct adapter *pAdapter, u8 efuseType, bool bPseudoTest);
 int rtl8188e_Efuse_PgPacketRead(struct adapter *pAdapter, u8 offset, u8 *data, bool bPseudoTest);
-int rtl8188e_Efuse_PgPacketWrite(struct adapter *pAdapter, u8 offset, u8 word_en, u8 *data, bool bPseudoTest);
 
 void hal_notch_filter_8188e(struct adapter *adapter, bool enable);
 
-- 
2.20.1

