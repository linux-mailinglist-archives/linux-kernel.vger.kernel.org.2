Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 928C63EDA5C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 17:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237068AbhHPQAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 12:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236809AbhHPP76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 11:59:58 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC3AAC061796
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 08:59:26 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id q10so24391268wro.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 08:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NCyXZDm9BtCq7g8yBiXSer3Ar8JH5dqIiqlwUSUG0nk=;
        b=ZLtS/EbOTJwjhzFNCOICt0zETjjNsSCFxHJXxT0PzLA0HCIaivGrhuE7RHKEY6G6me
         rWdkqs+Y/4XO9Bk48jdWTPoPjGbTIc9OV5EaakSqbTMvMKv6QeoqiRQ0vHlyrytiYcyB
         cdZ/mLcwt1ixJw7WI3VYLFYfcGuzhXyILjwtQdezyacxP2WWj5OriHPFL0dZEM7YPdSs
         2QqrtPeAkFpuHuKW7MDW0DgWahqSmcaMlmOcpkNv9H2gkYqS/iPL6oNMPKs31EHuhuzC
         FXOd67N+y8850ngpYr759UPkveA1RipMVYgJQSHnuQ6jpP0SuAbtmjhlOw4vXYWQyEs/
         GolQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NCyXZDm9BtCq7g8yBiXSer3Ar8JH5dqIiqlwUSUG0nk=;
        b=C0PFbFgPL+ImQ1odejYQkIg8MW84ZkhkNg5P3DnuzNMD57AvI4tSpw+3UOhhjTheRu
         YcG1JlSuifaCym3B4JMd7HTqBM/I1bJ1fSat0XzyR6273g85giT7mopoF0/vTWPphWHy
         7IDW1CMboDafwKAVieqYf4OSZQvj5s6ZoijlxvcaRMwUAOfbUVMnN69N4MS/y29cUOlE
         mZcdr725zX1a99m6+vYovQbX60IeNXnltl2MPck+KZ1eWdLVEFjNK63IsjgWzITfV/VE
         QWa4/a/kOeln7CNc1xvZHTTG04jwE45ucATjVdZKadYhNQ5nPBxtiKkkmHw6NXVYTwoW
         mIXQ==
X-Gm-Message-State: AOAM532J7OWkB0SVyCNP61d2hJCrrFVxfyyFNYn6idSAnj/Pnq54mn0K
        9VY3Tn11j/dg8BMLRan4nvE=
X-Google-Smtp-Source: ABdhPJz06Z8l31/NgfPi/FupMlSUBSWKWgppiRH32s9IVc7H2pBYZdPZGs/QwOnigakmoIXj5J5tZA==
X-Received: by 2002:a5d:6909:: with SMTP id t9mr18677517wru.44.1629129565410;
        Mon, 16 Aug 2021 08:59:25 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::4058])
        by smtp.gmail.com with ESMTPSA id a77sm11589597wmd.31.2021.08.16.08.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 08:59:25 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 05/23] staging: r8188eu: clean up spacing style issues in core/rtw_efuse.c
Date:   Mon, 16 Aug 2021 17:58:00 +0200
Message-Id: <20210816155818.24005-6-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210816155818.24005-1-straube.linux@gmail.com>
References: <20210816155818.24005-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up spacing style issues in core/rtw_efuse.c reported by checkpatch.

CHECK: spaces preferred around that ...
WARNING: space prohibited before semicolon

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_efuse.c | 96 ++++++++++++------------
 1 file changed, 48 insertions(+), 48 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_efuse.c b/drivers/staging/r8188eu/core/rtw_efuse.c
index 6e790f529d61..decccf7622f0 100644
--- a/drivers/staging/r8188eu/core/rtw_efuse.c
+++ b/drivers/staging/r8188eu/core/rtw_efuse.c
@@ -46,7 +46,7 @@ Efuse_Read1ByteFromFakeContent(
 	if (fakeEfuseBank == 0)
 		*Value = fakeEfuseContent[Offset];
 	else
-		*Value = fakeBTEfuseContent[fakeEfuseBank-1][Offset];
+		*Value = fakeBTEfuseContent[fakeEfuseBank - 1][Offset];
 	return true;
 }
 
@@ -61,7 +61,7 @@ Efuse_Write1ByteToFakeContent(
 	if (fakeEfuseBank == 0) {
 		fakeEfuseContent[Offset] = Value;
 	} else {
-		fakeBTEfuseContent[fakeEfuseBank-1][Offset] = Value;
+		fakeBTEfuseContent[fakeEfuseBank - 1][Offset] = Value;
 	}
 	return true;
 }
@@ -166,13 +166,13 @@ ReadEFuseByte(
 	}
 
 	/* Write Address */
-	rtw_write8(Adapter, EFUSE_CTRL+1, (_offset & 0xff));
-	readbyte = rtw_read8(Adapter, EFUSE_CTRL+2);
-	rtw_write8(Adapter, EFUSE_CTRL+2, ((_offset >> 8) & 0x03) | (readbyte & 0xfc));
+	rtw_write8(Adapter, EFUSE_CTRL + 1, (_offset & 0xff));
+	readbyte = rtw_read8(Adapter, EFUSE_CTRL + 2);
+	rtw_write8(Adapter, EFUSE_CTRL + 2, ((_offset >> 8) & 0x03) | (readbyte & 0xfc));
 
 	/* Write bit 32 0 */
-	readbyte = rtw_read8(Adapter, EFUSE_CTRL+3);
-	rtw_write8(Adapter, EFUSE_CTRL+3, (readbyte & 0x7f));
+	readbyte = rtw_read8(Adapter, EFUSE_CTRL + 3);
+	rtw_write8(Adapter, EFUSE_CTRL + 3, (readbyte & 0x7f));
 
 	/* Check bit 32 read-ready */
 	retry = 0;
@@ -250,21 +250,21 @@ u8 EFUSE_Read1Byte(struct adapter *Adapter, u16 Address)
 	if (Address < contentLen) {	/* E-fuse 512Byte */
 		/* Write E-fuse Register address bit0~7 */
 		temp = Address & 0xFF;
-		rtw_write8(Adapter, EFUSE_CTRL+1, temp);
-		Bytetemp = rtw_read8(Adapter, EFUSE_CTRL+2);
+		rtw_write8(Adapter, EFUSE_CTRL + 1, temp);
+		Bytetemp = rtw_read8(Adapter, EFUSE_CTRL + 2);
 		/* Write E-fuse Register address bit8~9 */
 		temp = ((Address >> 8) & 0x03) | (Bytetemp & 0xFC);
-		rtw_write8(Adapter, EFUSE_CTRL+2, temp);
+		rtw_write8(Adapter, EFUSE_CTRL + 2, temp);
 
 		/* Write 0x30[31]= 0 */
-		Bytetemp = rtw_read8(Adapter, EFUSE_CTRL+3);
+		Bytetemp = rtw_read8(Adapter, EFUSE_CTRL + 3);
 		temp = Bytetemp & 0x7F;
-		rtw_write8(Adapter, EFUSE_CTRL+3, temp);
+		rtw_write8(Adapter, EFUSE_CTRL + 3, temp);
 
 		/* Wait Write-ready (0x30[31]= 1) */
-		Bytetemp = rtw_read8(Adapter, EFUSE_CTRL+3);
+		Bytetemp = rtw_read8(Adapter, EFUSE_CTRL + 3);
 		while (!(Bytetemp & 0x80)) {
-			Bytetemp = rtw_read8(Adapter, EFUSE_CTRL+3);
+			Bytetemp = rtw_read8(Adapter, EFUSE_CTRL + 3);
 			k++;
 			if (k == 1000) {
 				k = 0;
@@ -291,13 +291,13 @@ u8 efuse_OneByteRead(struct adapter *pAdapter, u16 addr, u8 *data, bool pseudo)
 	}
 	/*  -----------------e-fuse reg ctrl --------------------------------- */
 	/* address */
-	rtw_write8(pAdapter, EFUSE_CTRL+1, (u8)(addr & 0xff));
-	rtw_write8(pAdapter, EFUSE_CTRL+2, ((u8)((addr>>8) & 0x03)) |
-		   (rtw_read8(pAdapter, EFUSE_CTRL+2) & 0xFC));
+	rtw_write8(pAdapter, EFUSE_CTRL + 1, (u8)(addr & 0xff));
+	rtw_write8(pAdapter, EFUSE_CTRL + 2, ((u8)((addr >> 8) & 0x03)) |
+		   (rtw_read8(pAdapter, EFUSE_CTRL + 2) & 0xFC));
 
-	rtw_write8(pAdapter, EFUSE_CTRL+3,  0x72);/* read cmd */
+	rtw_write8(pAdapter, EFUSE_CTRL + 3,  0x72);/* read cmd */
 
-	while (!(0x80 & rtw_read8(pAdapter, EFUSE_CTRL+3)) && (tmpidx < 100))
+	while (!(0x80 & rtw_read8(pAdapter, EFUSE_CTRL + 3)) && (tmpidx < 100))
 		tmpidx++;
 	if (tmpidx < 100) {
 		*data = rtw_read8(pAdapter, EFUSE_CTRL);
@@ -322,15 +322,15 @@ u8 efuse_OneByteWrite(struct adapter *pAdapter, u16 addr, u8 data, bool pseudo)
 
 	/*  -----------------e-fuse reg ctrl --------------------------------- */
 	/* address */
-	rtw_write8(pAdapter, EFUSE_CTRL+1, (u8)(addr&0xff));
-	rtw_write8(pAdapter, EFUSE_CTRL+2,
-		   (rtw_read8(pAdapter, EFUSE_CTRL+2) & 0xFC) |
-		   (u8)((addr>>8) & 0x03));
+	rtw_write8(pAdapter, EFUSE_CTRL + 1, (u8)(addr & 0xff));
+	rtw_write8(pAdapter, EFUSE_CTRL + 2,
+		   (rtw_read8(pAdapter, EFUSE_CTRL + 2) & 0xFC) |
+		   (u8)((addr >> 8) & 0x03));
 	rtw_write8(pAdapter, EFUSE_CTRL, data);/* data */
 
-	rtw_write8(pAdapter, EFUSE_CTRL+3, 0xF2);/* write cmd */
+	rtw_write8(pAdapter, EFUSE_CTRL + 3, 0xF2);/* write cmd */
 
-	while ((0x80 &  rtw_read8(pAdapter, EFUSE_CTRL+3)) && (tmpidx < 100))
+	while ((0x80 &  rtw_read8(pAdapter, EFUSE_CTRL + 3)) && (tmpidx < 100))
 		tmpidx++;
 
 	if (tmpidx < 100)
@@ -387,19 +387,19 @@ static int Efuse_PgPacketWrite_BT(struct adapter *pAdapter, u8 offset, u8 word_e
  *---------------------------------------------------------------------------*/
 void efuse_WordEnableDataRead(u8 word_en, u8 *sourdata, u8 *targetdata)
 {
-	if (!(word_en&BIT(0))) {
+	if (!(word_en & BIT(0))) {
 		targetdata[0] = sourdata[0];
 		targetdata[1] = sourdata[1];
 	}
-	if (!(word_en&BIT(1))) {
+	if (!(word_en & BIT(1))) {
 		targetdata[2] = sourdata[2];
 		targetdata[3] = sourdata[3];
 	}
-	if (!(word_en&BIT(2))) {
+	if (!(word_en & BIT(2))) {
 		targetdata[4] = sourdata[4];
 		targetdata[5] = sourdata[5];
 	}
-	if (!(word_en&BIT(3))) {
+	if (!(word_en & BIT(3))) {
 		targetdata[6] = sourdata[6];
 		targetdata[7] = sourdata[7];
 	}
@@ -431,7 +431,7 @@ u8 rtw_efuse_access(struct adapter *padapter, u8 write, u16 start_addr, u16 cnts
 {
 	int i = 0;
 	u16 real_content_len = 0, max_available_size = 0;
-	u8 res = _FAIL ;
+	u8 res = _FAIL;
 	u8 (*rw8)(struct adapter *, u16, u8*);
 
 	EFUSE_GetEfuseDefinition(padapter, EFUSE_WIFI, TYPE_EFUSE_REAL_CONTENT_LEN, (void *)&real_content_len, false);
@@ -551,9 +551,9 @@ u8 rtw_efuse_map_write(struct adapter *padapter, u16 addr, u16 cnts, u8 *data)
 
 	if (i & 0x1) {
 		/*  odd start */
-		if (data[idx] != map[addr+idx]) {
+		if (data[idx] != map[addr + idx]) {
 			word_en &= ~BIT(i >> 1);
-			newdata[i-1] = map[addr+idx-1];
+			newdata[i - 1] = map[addr + idx - 1];
 			newdata[i] = data[idx];
 		}
 		i++;
@@ -564,19 +564,19 @@ u8 rtw_efuse_map_write(struct adapter *padapter, u16 addr, u16 cnts, u8 *data)
 			if (cnts == idx)
 				break;
 			if ((cnts - idx) == 1) {
-				if (data[idx] != map[addr+idx]) {
+				if (data[idx] != map[addr + idx]) {
 					word_en &= ~BIT(i >> 1);
 					newdata[i] = data[idx];
-					newdata[i+1] = map[addr+idx+1];
+					newdata[i + 1] = map[addr + idx + 1];
 				}
 				idx++;
 				break;
 			} else {
-				if ((data[idx] != map[addr+idx]) ||
-				    (data[idx+1] != map[addr+idx+1])) {
+				if ((data[idx] != map[addr + idx]) ||
+				    (data[idx + 1] != map[addr + idx + 1])) {
 					word_en &= ~BIT(i >> 1);
 					newdata[i] = data[idx];
-					newdata[i+1] = data[idx + 1];
+					newdata[i + 1] = data[idx + 1];
 				}
 				idx += 2;
 			}
@@ -643,9 +643,9 @@ u8 rtw_BT_efuse_map_write(struct adapter *padapter, u16 addr, u16 cnts, u8 *data
 
 	if (i & 0x1) {
 		/*  odd start */
-		if (data[idx] != map[addr+idx]) {
+		if (data[idx] != map[addr + idx]) {
 			word_en &= ~BIT(i >> 1);
-			newdata[i-1] = map[addr+idx-1];
+			newdata[i - 1] = map[addr + idx - 1];
 			newdata[i] = data[idx];
 		}
 		i++;
@@ -656,19 +656,19 @@ u8 rtw_BT_efuse_map_write(struct adapter *padapter, u16 addr, u16 cnts, u8 *data
 			if (cnts == idx)
 				break;
 			if ((cnts - idx) == 1) {
-				if (data[idx] != map[addr+idx]) {
+				if (data[idx] != map[addr + idx]) {
 					word_en &= ~BIT(i >> 1);
 					newdata[i] = data[idx];
-					newdata[i+1] = map[addr+idx+1];
+					newdata[i + 1] = map[addr + idx + 1];
 				}
 				idx++;
 				break;
 			} else {
-				if ((data[idx] != map[addr+idx]) ||
-				    (data[idx+1] != map[addr+idx+1])) {
+				if ((data[idx] != map[addr + idx]) ||
+				    (data[idx + 1] != map[addr + idx + 1])) {
 					word_en &= ~BIT(i >> 1);
 					newdata[i] = data[idx];
-					newdata[i+1] = data[idx + 1];
+					newdata[i + 1] = data[idx + 1];
 				}
 				idx += 2;
 			}
@@ -747,7 +747,7 @@ efuse_ShadowRead2Byte(
 	struct eeprom_priv *pEEPROM = GET_EEPROM_EFUSE_PRIV(pAdapter);
 
 	*Value = pEEPROM->efuse_eeprom_data[Offset];
-	*Value |= pEEPROM->efuse_eeprom_data[Offset+1]<<8;
+	*Value |= pEEPROM->efuse_eeprom_data[Offset + 1] << 8;
 
 }	/*  EFUSE_ShadowRead2Byte */
 
@@ -761,9 +761,9 @@ efuse_ShadowRead4Byte(
 	struct eeprom_priv *pEEPROM = GET_EEPROM_EFUSE_PRIV(pAdapter);
 
 	*Value = pEEPROM->efuse_eeprom_data[Offset];
-	*Value |= pEEPROM->efuse_eeprom_data[Offset+1]<<8;
-	*Value |= pEEPROM->efuse_eeprom_data[Offset+2]<<16;
-	*Value |= pEEPROM->efuse_eeprom_data[Offset+3]<<24;
+	*Value |= pEEPROM->efuse_eeprom_data[Offset + 1] << 8;
+	*Value |= pEEPROM->efuse_eeprom_data[Offset + 2] << 16;
+	*Value |= pEEPROM->efuse_eeprom_data[Offset + 3] << 24;
 
 }	/*  efuse_ShadowRead4Byte */
 
-- 
2.32.0

