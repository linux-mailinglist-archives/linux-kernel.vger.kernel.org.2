Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2727401FB8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 20:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244674AbhIFS2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 14:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244431AbhIFS03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 14:26:29 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE666C0613D9
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 11:25:24 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id u19so10544207edb.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 11:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KoSKHjHFNrQC4xQhIPmo38LhBsUh9xEeHFh1znFlwIk=;
        b=JX8chuHsLow8QO3XRNl7/J205vY+FlWBIDKxEurX/IpfUR+gJzY+3GlsOM45p7pnwZ
         4xt8cMcsgcxhPj980yIK2W3IsrCiEA+2zisQH/cKyzGBHtaGc1LgRWCudvO4fYlCJ+AR
         AMxerqT4DcwrW1sm1sONKRphVPHXffaSZVXfreV4DMCns1z2J8/fqAr1QjZB+H5G/tbf
         NFbGOrt2lfcJD0vg9dOcwKz5/nYXHrIdQw8hR0WelBeVxOz3u2ZsSoj22Nv7IaQaCUc9
         d/vcz5YU61BBmkOcwTJiscqOOdxTw61dD4KUtJXYOX+hOkcEl8RWM1e0spDHMQ5AmZcV
         8DXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KoSKHjHFNrQC4xQhIPmo38LhBsUh9xEeHFh1znFlwIk=;
        b=lmz+SKeX/twPXYFsW3KrZ3jqIy2wNIKjBPDloqK1m+ZlscD8mEzRzvBK0nRG+Ku6Ml
         O/VZebnNzw/9b12kQlF62pTiJrOww7r59h0uDJiG/6udYh+m50GVIxlPeruFXvyYuLvo
         1qOaS01LpYxRixuHGZ19YNiN+aupppVs1XnPkXARNbkRqlYLAQHRE36R85xUFMn8bFX2
         gsifIKEbCBmKdnYO7Qaz3ByXqTLWfE02A1b/69WBhwfA+xc/tYv3KVTwFr29GtthWV2a
         wVw1aRjxsCeNvdHxlCbUiJDf/TbGbBgaHkUWacaZPALq4ThjNE8Wm021w8XWYnxL7xqW
         x8yg==
X-Gm-Message-State: AOAM531PLDsb3CTt76b50Z5GBzg1ewKpHcl4fslDyVK/ObmHDe6j79Dx
        plszOvm59O0ewExXnawDS9U=
X-Google-Smtp-Source: ABdhPJyknu0kiU5DeiZ0qYqYliEN7EDmpUZH2zB4rpBCen7aoVlUySw2DWI3jOThadQvH90qGgt9hA==
X-Received: by 2002:aa7:db82:: with SMTP id u2mr14501429edt.299.1630952723381;
        Mon, 06 Sep 2021 11:25:23 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with ESMTPSA id s25sm4284492ejq.17.2021.09.06.11.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 11:25:23 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 30/40] staging: r8188eu: remove Efuse_WordEnableDataWrite from hal_ops
Date:   Mon,  6 Sep 2021 20:24:28 +0200
Message-Id: <20210906182438.5417-31-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210906182438.5417-1-straube.linux@gmail.com>
References: <20210906182438.5417-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove Efuse_WordEnableDataWrite hal_ops and remove its wrapper
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

