Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31BF244F4B1
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 19:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236132AbhKMS6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Nov 2021 13:58:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236095AbhKMS6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Nov 2021 13:58:47 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495AEC061204
        for <linux-kernel@vger.kernel.org>; Sat, 13 Nov 2021 10:55:55 -0800 (PST)
Received: from dslb-188-096-147-224.188.096.pools.vodafone-ip.de ([188.96.147.224] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mlyBq-0002H8-RW; Sat, 13 Nov 2021 19:55:50 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 06/15] staging: r8188eu: rtl8188e_Efuse_PgPacketRead is now unused
Date:   Sat, 13 Nov 2021 19:55:09 +0100
Message-Id: <20211113185518.23941-7-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211113185518.23941-1-martin@kaiser.cx>
References: <20211113185518.23941-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After we removed efuse write support, rtl8188e_Efuse_PgPacketRead is no
longer needed. Remove this function and its internal helpers.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 .../staging/r8188eu/hal/rtl8188e_hal_init.c   | 114 ------------------
 drivers/staging/r8188eu/include/hal_intf.h    |   1 -
 drivers/staging/r8188eu/include/rtw_efuse.h   |  20 ---
 3 files changed, 135 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index 8205f6237520..55b750b4d6ff 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -903,120 +903,6 @@ void rtl8188e_EFUSE_GetEfuseDefinition(struct adapter *pAdapter, u8 type, void *
 	Hal_EFUSEGetEfuseDefinition88E(pAdapter, type, pOut);
 }
 
-
-static int hal_EfusePgPacketRead_8188e(struct adapter *pAdapter, u8 offset, u8 *data, bool bPseudoTest)
-{
-	u8 ReadState = PG_STATE_HEADER;
-	int	bContinual = true;
-	int	bDataEmpty = true;
-	u8 efuse_data, word_cnts = 0;
-	u16	efuse_addr = 0;
-	u8 hoffset = 0, hworden = 0;
-	u8 tmpidx = 0;
-	u8 tmpdata[8];
-	u8 max_section = 0;
-	u8 tmp_header = 0;
-
-	rtl8188e_EFUSE_GetEfuseDefinition(pAdapter, TYPE_EFUSE_MAX_SECTION, (void *)&max_section);
-
-	if (!data)
-		return false;
-	if (offset > max_section)
-		return false;
-
-	memset((void *)data, 0xff, sizeof(u8) * PGPKT_DATA_SIZE);
-	memset((void *)tmpdata, 0xff, sizeof(u8) * PGPKT_DATA_SIZE);
-
-	/*  <Roger_TODO> Efuse has been pre-programmed dummy 5Bytes at the end of Efuse by CP. */
-	/*  Skip dummy parts to prevent unexpected data read from Efuse. */
-	/*  By pass right now. 2009.02.19. */
-	while (bContinual && AVAILABLE_EFUSE_ADDR(efuse_addr)) {
-		/*   Header Read ------------- */
-		if (ReadState & PG_STATE_HEADER) {
-			if (efuse_OneByteRead(pAdapter, efuse_addr, &efuse_data, bPseudoTest) && (efuse_data != 0xFF)) {
-				if (EXT_HEADER(efuse_data)) {
-					tmp_header = efuse_data;
-					efuse_addr++;
-					efuse_OneByteRead(pAdapter, efuse_addr, &efuse_data, bPseudoTest);
-					if (!ALL_WORDS_DISABLED(efuse_data)) {
-						hoffset = ((tmp_header & 0xE0) >> 5) | ((efuse_data & 0xF0) >> 1);
-						hworden = efuse_data & 0x0F;
-					} else {
-						DBG_88E("Error, All words disabled\n");
-						efuse_addr++;
-						continue;
-					}
-				} else {
-					hoffset = (efuse_data >> 4) & 0x0F;
-					hworden =  efuse_data & 0x0F;
-				}
-				word_cnts = Efuse_CalculateWordCnts(hworden);
-				bDataEmpty = true;
-
-				if (hoffset == offset) {
-					for (tmpidx = 0; tmpidx < word_cnts * 2; tmpidx++) {
-						if (efuse_OneByteRead(pAdapter, efuse_addr + 1 + tmpidx, &efuse_data, bPseudoTest)) {
-							tmpdata[tmpidx] = efuse_data;
-							if (efuse_data != 0xff)
-								bDataEmpty = false;
-						}
-					}
-					if (!bDataEmpty) {
-						ReadState = PG_STATE_DATA;
-					} else {/* read next header */
-						efuse_addr = efuse_addr + (word_cnts * 2) + 1;
-						ReadState = PG_STATE_HEADER;
-					}
-				} else {/* read next header */
-					efuse_addr = efuse_addr + (word_cnts * 2) + 1;
-					ReadState = PG_STATE_HEADER;
-				}
-			} else {
-				bContinual = false;
-			}
-		} else if (ReadState & PG_STATE_DATA) {
-		/*   Data section Read ------------- */
-			efuse_WordEnableDataRead(hworden, tmpdata, data);
-			efuse_addr = efuse_addr + (word_cnts * 2) + 1;
-			ReadState = PG_STATE_HEADER;
-		}
-
-	}
-
-	if ((data[0] == 0xff) && (data[1] == 0xff) && (data[2] == 0xff)  && (data[3] == 0xff) &&
-	    (data[4] == 0xff) && (data[5] == 0xff) && (data[6] == 0xff)  && (data[7] == 0xff))
-		return false;
-	else
-		return true;
-}
-
-static int Hal_EfusePgPacketRead(struct adapter *pAdapter, u8 offset, u8 *data, bool bPseudoTest)
-{
-	int	ret;
-
-	ret = hal_EfusePgPacketRead_8188e(pAdapter, offset, data, bPseudoTest);
-	return ret;
-}
-
-static int Hal_EfusePgPacketRead_Pseudo(struct adapter *pAdapter, u8 offset, u8 *data, bool bPseudoTest)
-{
-	int	ret;
-
-	ret = hal_EfusePgPacketRead_8188e(pAdapter, offset, data, bPseudoTest);
-	return ret;
-}
-
-int rtl8188e_Efuse_PgPacketRead(struct adapter *pAdapter, u8 offset, u8 *data, bool bPseudoTest)
-{
-	int	ret;
-
-	if (bPseudoTest)
-		ret = Hal_EfusePgPacketRead_Pseudo(pAdapter, offset, data, bPseudoTest);
-	else
-		ret = Hal_EfusePgPacketRead(pAdapter, offset, data, bPseudoTest);
-	return ret;
-}
-
 void rtl8188e_read_chip_version(struct adapter *padapter)
 {
 	u32				value32;
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index 01e256f3e268..1f69aae7cb0e 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -123,7 +123,6 @@ void rtl8188e_free_hal_data(struct adapter *padapter);
 void rtl8188e_EfusePowerSwitch(struct adapter *pAdapter, u8 PwrState);
 void rtl8188e_ReadEFuse(struct adapter *Adapter, u16 _offset, u16 _size_byte, u8 *pbuf);
 void rtl8188e_EFUSE_GetEfuseDefinition(struct adapter *pAdapter, u8 type, void *pOut);
-int rtl8188e_Efuse_PgPacketRead(struct adapter *pAdapter, u8 offset, u8 *data, bool bPseudoTest);
 
 void hal_notch_filter_8188e(struct adapter *adapter, bool enable);
 
diff --git a/drivers/staging/r8188eu/include/rtw_efuse.h b/drivers/staging/r8188eu/include/rtw_efuse.h
index c767e985f196..7c4c84d74bc2 100644
--- a/drivers/staging/r8188eu/include/rtw_efuse.h
+++ b/drivers/staging/r8188eu/include/rtw_efuse.h
@@ -8,18 +8,6 @@
 
 #define	EFUSE_ERROE_HANDLE		1
 
-#define	PG_STATE_HEADER			0x01
-#define	PG_STATE_WORD_0		0x02
-#define	PG_STATE_WORD_1		0x04
-#define	PG_STATE_WORD_2		0x08
-#define	PG_STATE_WORD_3		0x10
-#define	PG_STATE_DATA			0x20
-
-#define	PG_SWBYTE_H			0x01
-#define	PG_SWBYTE_L			0x02
-
-#define	PGPKT_DATA_SIZE		8
-
 #define	EFUSE_WIFI				0
 #define	EFUSE_BT				1
 
@@ -55,14 +43,6 @@ enum _EFUSE_DEF_TYPE {
 /*--------------------------Define Parameters-------------------------------*/
 #define		EFUSE_MAX_WORD_UNIT			4
 
-/*------------------------------Define structure----------------------------*/
-struct pgpkt {
-	u8 offset;
-	u8 word_en;
-	u8 data[8];
-	u8 word_cnts;
-};
-
 /*------------------------------Define structure----------------------------*/
 struct efuse_hal {
 	u8 fakeEfuseBank;
-- 
2.20.1

