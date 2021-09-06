Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F05A402009
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 20:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343738AbhIFS4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 14:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245114AbhIFSzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 14:55:31 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1066CC06179A
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 11:54:26 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id e21so15018645ejz.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 11:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GTL2Te0GA3sqj8xGGoR0eNa7aAZ7h2sRppnQiOL2FNY=;
        b=o9qLP8epNOwSPkjvkeLfvjiVKlO1JmRoxMxTiHheJynXSX1Vq7/ws+u7wDwSlrUcoy
         FpaqfCv88INkFKWMefHyBBfcVYf6324V1Toz+A6qiQTn2TnVWT+XRasykbbzNzFqmWO7
         6eN5dBHtiJ+RITxI7KDizw7/D5ICV7Yzuk5H9iwN3KTc6HDcXnx9ZuSXB2M06N01rgeM
         +Dpcef7LntbQtHmLBxVP3e8zneMzGBzBBxtsIhJN+vJ1fWFgHqvqNnmywByufOzMCq4J
         FxZn64nirZU8JROQZZqhAldeIS/FR/7YQHFfNQrW5+Ig/rWMHoZmoMs9Qois7Catc5ei
         9TsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GTL2Te0GA3sqj8xGGoR0eNa7aAZ7h2sRppnQiOL2FNY=;
        b=bg0M4QWizwH/3HlX/YsfJAdf4Cz9ZNFI7WAoNdNpmrvQzcyvdwaOjSGO8ej5F1TINl
         82lIeARqdvwR2+lBqWAb1e5KNDs/bmmk4j3j1h11oBUJo7O3L9ausygdW/5vz4H7qdq+
         D+VZJnzj/ViFAFLmOmceAaByHNHaskPlOeTb405WwFQU5ivGgqKNkiv5NoxUvSG6Z4Vc
         INccfxpGBTP0vCsjYsYlSccBEHQQJSlY0XLNb6V9tCSKqvwOsIg/yHd9wOFVCGl7aeYN
         eB48P3KKZyH7tr5IlRw7dG8NGiwoG3nfR+T2qsZ6qR+sqF2I7sr9sgGlruVipkFkAO94
         UERw==
X-Gm-Message-State: AOAM530rbT+3OgxxBD0ye1bkVC3DufloB6xJwUqYiPtZaz41zmyu8NQn
        ySOvTA+hTAE0bdfmVm8DYHo=
X-Google-Smtp-Source: ABdhPJzUs285L2N3vbvoVLYa86TtD+K4gIXq9komE5xuzpJzDjVvw2lm35RdXpB9fbnEO9Q3T9F5cg==
X-Received: by 2002:a17:906:a08d:: with SMTP id q13mr14800698ejy.465.1630954464709;
        Mon, 06 Sep 2021 11:54:24 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with ESMTPSA id kk2sm4329128ejc.114.2021.09.06.11.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 11:54:24 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 30/40] staging: r8188eu: remove Efuse_WordEnableDataWrite from hal_ops
Date:   Mon,  6 Sep 2021 20:53:17 +0200
Message-Id: <20210906185327.10326-31-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210906185327.10326-1-straube.linux@gmail.com>
References: <20210906185327.10326-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove Efuse_WordEnableDataWrite from hal_ops and remove its wrapper
Efuse_WordEnableDataWrite(). Call rtl8188e_Efuse_WordEnableDataWrite()
directly instead.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_efuse.c        | 9 ---------
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 9 +++------
 drivers/staging/r8188eu/include/hal_intf.h      | 4 ----
 drivers/staging/r8188eu/include/rtw_efuse.h     | 2 --
 4 files changed, 3 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_efuse.c b/drivers/staging/r8188eu/core/rtw_efuse.c
index 25c1e545313f..47c4d8bf5daf 100644
--- a/drivers/staging/r8188eu/core/rtw_efuse.c
+++ b/drivers/staging/r8188eu/core/rtw_efuse.c
@@ -284,15 +284,6 @@ void efuse_WordEnableDataRead(u8 word_en, u8 *sourdata, u8 *targetdata)
 	}
 }
 
-u8 Efuse_WordEnableDataWrite(struct adapter *pAdapter, u16 efuse_addr, u8 word_en, u8 *data, bool pseudo)
-{
-	u8 ret = 0;
-
-	ret =  pAdapter->HalFunc.Efuse_WordEnableDataWrite(pAdapter, efuse_addr, word_en, data, pseudo);
-
-	return ret;
-}
-
 static u8 efuse_read8(struct adapter *padapter, u16 address, u8 *value)
 {
 	return efuse_OneByteRead(padapter, address, value, false);
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index 24009e9cc099..eb30a6fcd8d0 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -1315,7 +1315,7 @@ static bool hal_EfuseFixHeaderProcess(struct adapter *pAdapter, u8 efuseType, st
 
 	if (rtl8188e_Efuse_PgPacketRead(pAdapter, pFixPkt->offset, originaldata, bPseudoTest)) {
 		/* check if data exist */
-		badworden = Efuse_WordEnableDataWrite(pAdapter, efuse_addr + 1, pFixPkt->word_en, originaldata, bPseudoTest);
+		badworden = rtl8188e_Efuse_WordEnableDataWrite(pAdapter, efuse_addr + 1, pFixPkt->word_en, originaldata, bPseudoTest);
 
 		if (badworden != 0xf) {	/*  write fail */
 			PgWriteSuccess = rtl8188e_Efuse_PgPacketWrite(pAdapter, pFixPkt->offset, badworden, originaldata, bPseudoTest);
@@ -1442,7 +1442,7 @@ static bool hal_EfusePgPacketWriteData(struct adapter *pAdapter, u8 efuseType, u
 	u32	PgWriteSuccess = 0;
 
 	badworden = 0x0f;
-	badworden = Efuse_WordEnableDataWrite(pAdapter, efuse_addr + 1, pTargetPkt->word_en, pTargetPkt->data, bPseudoTest);
+	badworden = rtl8188e_Efuse_WordEnableDataWrite(pAdapter, efuse_addr + 1, pTargetPkt->word_en, pTargetPkt->data, bPseudoTest);
 	if (badworden == 0x0F) {
 		/*  write ok */
 		return true;
@@ -1569,7 +1569,7 @@ static bool hal_EfusePartialWriteCheck(struct adapter *pAdapter, u8 efuseType, u
 			    (!hal_EfuseCheckIfDatafollowed(pAdapter, curPkt.word_cnts, startAddr + 1, bPseudoTest)) &&
 			    wordEnMatched(pTargetPkt, &curPkt, &matched_wden)) {
 				/*  Here to write partial data */
-				badworden = Efuse_WordEnableDataWrite(pAdapter, startAddr + 1, matched_wden, pTargetPkt->data, bPseudoTest);
+				badworden = rtl8188e_Efuse_WordEnableDataWrite(pAdapter, startAddr + 1, matched_wden, pTargetPkt->data, bPseudoTest);
 				if (badworden != 0x0F) {
 					u32	PgWriteSuccess = 0;
 					/*  if write fail on some words, write these bad words again */
@@ -1781,9 +1781,6 @@ void rtl8188e_set_hal_ops(struct hal_ops *pHalFunc)
 	pHalFunc->read_rfreg = &rtl8188e_PHY_QueryRFReg;
 	pHalFunc->write_rfreg = &rtl8188e_PHY_SetRFReg;
 
-	/*  Efuse related function */
-	pHalFunc->Efuse_WordEnableDataWrite = &rtl8188e_Efuse_WordEnableDataWrite;
-
 	pHalFunc->IOL_exec_cmds_sync = &rtl8188e_IOL_exec_cmds_sync;
 
 	pHalFunc->hal_notch_filter = &hal_notch_filter_8188e;
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index 748c809b1adc..4b937bd2c63c 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -177,10 +177,6 @@ struct hal_ops {
 			       enum rf_radio_path eRFPath, u32 RegAddr,
 			       u32 BitMask, u32 Data);
 
-	u8	(*Efuse_WordEnableDataWrite)(struct adapter *padapter,
-					     u16 efuse_addr, u8 word_en,
-					     u8 *data, bool bPseudoTest);
-
 	int (*IOL_exec_cmds_sync)(struct adapter *padapter,
 				  struct xmit_frame *frame, u32 max_wait,
 				  u32 bndy_cnt);
diff --git a/drivers/staging/r8188eu/include/rtw_efuse.h b/drivers/staging/r8188eu/include/rtw_efuse.h
index b10798354a6b..2dd74c9c691d 100644
--- a/drivers/staging/r8188eu/include/rtw_efuse.h
+++ b/drivers/staging/r8188eu/include/rtw_efuse.h
@@ -117,8 +117,6 @@ u8 efuse_OneByteRead(struct adapter *adapter, u16 addr, u8 *data, bool test);
 u8 efuse_OneByteWrite(struct adapter *adapter, u16 addr, u8 data, bool	test);
 
 void efuse_WordEnableDataRead(u8 word_en, u8 *sourdata, u8 *targetdata);
-u8 Efuse_WordEnableDataWrite(struct adapter *adapter, u16 efuse_addr,
-			     u8 word_en, u8 *data, bool test);
 
 u8 EFUSE_Read1Byte(struct adapter *adapter, u16 address);
 void EFUSE_ShadowMapUpdate(struct adapter *adapter, u8 efusetype, bool test);
-- 
2.33.0

