Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA8C4402008
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 20:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245697AbhIFS4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 14:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245110AbhIFSzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 14:55:31 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58285C0612A9
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 11:54:25 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id j13so10567205edv.13
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 11:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oalO9iKhiM11lOdOOoyjtVxK3BVvxs9JJleweDlcP/U=;
        b=V20l1VjhEdKTEoGqP/XSSDevgf3fF5D11oYOGAKcCI4c80RJ+8O1dRcQPS7TD+Zxl6
         CoRxMd6QiBdof1mBlpPM7ddDXMbLVn1Q54tD5yvhah0JHZEO8AyUwKRgcGPZICCXa1TG
         WDbQ9ckQTUBCZcWjlqUcKiayeSzQqOC0QYs/mcWvq7ydTZn4NuvbhxguJ4rYCvxYuEoX
         LdQ0o64CBniIazQzV7OYdGcKNIMRN4Y4FUfkVAVSGdHzcTZbXkkeUw+k3S4JUTn6GBk9
         ZF3aXiekfdSk952SUJPyb5glzOg/Ct+yXHi/LWv65BzpZWmrhOTIRFWP9aQ4DHFkMMtq
         emPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oalO9iKhiM11lOdOOoyjtVxK3BVvxs9JJleweDlcP/U=;
        b=tSpCb5XQGvcLDKEp9YGA3VueyHEF57SmqwtcOcB4q0dRUgvgbdX0j3ZkKU31wSSUWC
         qnvjyxmqRgxCCFboxfZp8Xq2m19VOV8ZGggcRrwwxvX8zl53ks4em5PIs6Re6dIvaax7
         Tgv9gb7/eN8qLlsHEszE9TUMaQ6tAtDdyUTOPldmGU9fraHjLvuii7QRYQhUel9+Q4ji
         u/UIYxjsgjmTOYjxwcfBTBlNmhsZjK46MSiO2qESfHS/GOrzRLiPsgYku/mvnFwu6S1j
         v/SzFen805faDtTLUUlMhedek8My+gDFvAy74LGG77IJ0p8Tj90gxUtZEYnvHHPZ1KVt
         51AA==
X-Gm-Message-State: AOAM531yfehrdU6ibIavkuM41YWm1VXSAyDuHfGnAC+88e0OS05ez4pq
        h4Rh6WZnJizc76Td0PpCdCQ=
X-Google-Smtp-Source: ABdhPJyDJRGdel551FwnZRC6X/A7qySmEvneoOzU1kEprYG+vpd6i7IF+e/oodz0Lagy3QqNQ30z7A==
X-Received: by 2002:aa7:ca14:: with SMTP id y20mr14695325eds.2.1630954464002;
        Mon, 06 Sep 2021 11:54:24 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with ESMTPSA id kk2sm4329128ejc.114.2021.09.06.11.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 11:54:23 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 29/40] staging: r8188eu: remove Efuse_PgPacketWrite from hal_ops
Date:   Mon,  6 Sep 2021 20:53:16 +0200
Message-Id: <20210906185327.10326-30-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210906185327.10326-1-straube.linux@gmail.com>
References: <20210906185327.10326-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove Efuse_PgPacketWrite from hal_ops and remove its wrapper
Efuse_PgPacketWrite(). Call rtl8188e_Efuse_PgPacketWrite() directly
instead.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_efuse.c        | 11 +----------
 drivers/staging/r8188eu/core/rtw_mp_ioctl.c     |  2 +-
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c |  9 ++++-----
 drivers/staging/r8188eu/include/hal_intf.h      |  3 +--
 drivers/staging/r8188eu/include/rtw_efuse.h     |  2 --
 5 files changed, 7 insertions(+), 20 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_efuse.c b/drivers/staging/r8188eu/core/rtw_efuse.c
index 518ed5b2e8d2..25c1e545313f 100644
--- a/drivers/staging/r8188eu/core/rtw_efuse.c
+++ b/drivers/staging/r8188eu/core/rtw_efuse.c
@@ -247,15 +247,6 @@ u8 efuse_OneByteWrite(struct adapter *pAdapter, u16 addr, u8 data, bool pseudo)
 	return result;
 }
 
-int Efuse_PgPacketWrite(struct adapter *pAdapter, u8 offset, u8 word_en, u8 *data, bool pseudo)
-{
-	int ret;
-
-	ret =  pAdapter->HalFunc.Efuse_PgPacketWrite(pAdapter, offset, word_en, data, pseudo);
-
-	return ret;
-}
-
 /*-----------------------------------------------------------------------------
  * Function:	efuse_WordEnableDataRead
  *
@@ -473,7 +464,7 @@ u8 rtw_efuse_map_write(struct adapter *padapter, u16 addr, u16 cnts, u8 *data)
 		}
 
 		if (word_en != 0xF) {
-			ret = Efuse_PgPacketWrite(padapter, offset, word_en, newdata, false);
+			ret = rtl8188e_Efuse_PgPacketWrite(padapter, offset, word_en, newdata, false);
 			DBG_88E("offset=%x\n", offset);
 			DBG_88E("word_en=%x\n", word_en);
 
diff --git a/drivers/staging/r8188eu/core/rtw_mp_ioctl.c b/drivers/staging/r8188eu/core/rtw_mp_ioctl.c
index 4c56c0da7625..65450091051f 100644
--- a/drivers/staging/r8188eu/core/rtw_mp_ioctl.c
+++ b/drivers/staging/r8188eu/core/rtw_mp_ioctl.c
@@ -981,7 +981,7 @@ int rtl8188eu_oid_rt_pro_rw_efuse_pgpkt_hdl(struct oid_par_priv *poid_par_priv)
 		rtl8188e_EfusePowerSwitch(Adapter, false, false);
 	} else {
 		rtl8188e_EfusePowerSwitch(Adapter, true, true);
-		if (Efuse_PgPacketWrite(Adapter, ppgpkt->offset, ppgpkt->word_en, ppgpkt->data, false))
+		if (rtl8188e_Efuse_PgPacketWrite(Adapter, ppgpkt->offset, ppgpkt->word_en, ppgpkt->data, false))
 			*poid_par_priv->bytes_rw = poid_par_priv->information_buf_len;
 		else
 			status = NDIS_STATUS_FAILURE;
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index 9cbb13a07f83..24009e9cc099 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -1318,7 +1318,7 @@ static bool hal_EfuseFixHeaderProcess(struct adapter *pAdapter, u8 efuseType, st
 		badworden = Efuse_WordEnableDataWrite(pAdapter, efuse_addr + 1, pFixPkt->word_en, originaldata, bPseudoTest);
 
 		if (badworden != 0xf) {	/*  write fail */
-			PgWriteSuccess = Efuse_PgPacketWrite(pAdapter, pFixPkt->offset, badworden, originaldata, bPseudoTest);
+			PgWriteSuccess = rtl8188e_Efuse_PgPacketWrite(pAdapter, pFixPkt->offset, badworden, originaldata, bPseudoTest);
 
 			if (!PgWriteSuccess)
 				return false;
@@ -1448,7 +1448,7 @@ static bool hal_EfusePgPacketWriteData(struct adapter *pAdapter, u8 efuseType, u
 		return true;
 	} else {
 		/* reorganize other pg packet */
-		PgWriteSuccess = Efuse_PgPacketWrite(pAdapter, pTargetPkt->offset, badworden, pTargetPkt->data, bPseudoTest);
+		PgWriteSuccess = rtl8188e_Efuse_PgPacketWrite(pAdapter, pTargetPkt->offset, badworden, pTargetPkt->data, bPseudoTest);
 		if (!PgWriteSuccess)
 			return false;
 		else
@@ -1574,7 +1574,7 @@ static bool hal_EfusePartialWriteCheck(struct adapter *pAdapter, u8 efuseType, u
 					u32	PgWriteSuccess = 0;
 					/*  if write fail on some words, write these bad words again */
 
-					PgWriteSuccess = Efuse_PgPacketWrite(pAdapter, pTargetPkt->offset, badworden, pTargetPkt->data, bPseudoTest);
+					PgWriteSuccess = rtl8188e_Efuse_PgPacketWrite(pAdapter, pTargetPkt->offset, badworden, pTargetPkt->data, bPseudoTest);
 
 					if (!PgWriteSuccess) {
 						bRet = false;	/*  write fail, return */
@@ -1665,7 +1665,7 @@ static int Hal_EfusePgPacketWrite(struct adapter *pAdapter, u8 offset, u8 word_e
 	return ret;
 }
 
-static int rtl8188e_Efuse_PgPacketWrite(struct adapter *pAdapter, u8 offset, u8 word_en, u8 *data, bool bPseudoTest)
+int rtl8188e_Efuse_PgPacketWrite(struct adapter *pAdapter, u8 offset, u8 word_en, u8 *data, bool bPseudoTest)
 {
 	int	ret;
 
@@ -1782,7 +1782,6 @@ void rtl8188e_set_hal_ops(struct hal_ops *pHalFunc)
 	pHalFunc->write_rfreg = &rtl8188e_PHY_SetRFReg;
 
 	/*  Efuse related function */
-	pHalFunc->Efuse_PgPacketWrite = &rtl8188e_Efuse_PgPacketWrite;
 	pHalFunc->Efuse_WordEnableDataWrite = &rtl8188e_Efuse_WordEnableDataWrite;
 
 	pHalFunc->IOL_exec_cmds_sync = &rtl8188e_IOL_exec_cmds_sync;
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index 115d2598b3b0..748c809b1adc 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -177,8 +177,6 @@ struct hal_ops {
 			       enum rf_radio_path eRFPath, u32 RegAddr,
 			       u32 BitMask, u32 Data);
 
-	int	(*Efuse_PgPacketWrite)(struct adapter *padapter, u8 offset,
-				       u8 word_en, u8 *data, bool bPseudoTest);
 	u8	(*Efuse_WordEnableDataWrite)(struct adapter *padapter,
 					     u16 efuse_addr, u8 word_en,
 					     u8 *data, bool bPseudoTest);
@@ -219,6 +217,7 @@ void rtl8188e_EFUSE_GetEfuseDefinition(struct adapter *pAdapter, u8 efuseType,
 				       u8 type, void *pOut, bool bPseudoTest);
 u16 rtl8188e_EfuseGetCurrentSize(struct adapter *pAdapter, u8 efuseType, bool bPseudoTest);
 int rtl8188e_Efuse_PgPacketRead(struct adapter *pAdapter, u8 offset, u8 *data, bool bPseudoTest);
+int rtl8188e_Efuse_PgPacketWrite(struct adapter *pAdapter, u8 offset, u8 word_en, u8 *data, bool bPseudoTest);
 
 void	rtw_hal_free_data(struct adapter *padapter);
 uint rtw_hal_init(struct adapter *padapter);
diff --git a/drivers/staging/r8188eu/include/rtw_efuse.h b/drivers/staging/r8188eu/include/rtw_efuse.h
index d19ef73be39e..b10798354a6b 100644
--- a/drivers/staging/r8188eu/include/rtw_efuse.h
+++ b/drivers/staging/r8188eu/include/rtw_efuse.h
@@ -116,8 +116,6 @@ void ReadEFuseByte(struct adapter *adapter, u16 _offset, u8 *pbuf, bool test);
 u8 efuse_OneByteRead(struct adapter *adapter, u16 addr, u8 *data, bool test);
 u8 efuse_OneByteWrite(struct adapter *adapter, u16 addr, u8 data, bool	test);
 
-int Efuse_PgPacketWrite(struct adapter *adapter, u8 offset, u8 word, u8 *data,
-			bool test);
 void efuse_WordEnableDataRead(u8 word_en, u8 *sourdata, u8 *targetdata);
 u8 Efuse_WordEnableDataWrite(struct adapter *adapter, u16 efuse_addr,
 			     u8 word_en, u8 *data, bool test);
-- 
2.33.0

