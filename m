Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A35C4105D7
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 11:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245418AbhIRJ7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 05:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244913AbhIRJ71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 05:59:27 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E02C0613C1
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 02:58:03 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id g16so19240430wrb.3
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 02:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GN0wJ5LnNY6MYcGXoZ0yQC1yHdhXckp/WdDFfQjh9kk=;
        b=HDzUjA8/t9XwZlA0ZRewydSInyoCIRHunEnd9TC4sXobyukeYHELIppaqRFr20Is7P
         /6rtpN+RkCySxtnfFgZhyC/EG5uGHmkZjtlkGWJjMExu5h/BaqaOyBbANTCQJbCKB3kw
         lIwZHJpq4Q+d99PeGLL9xFc86jbeICoG9P8UpVnqoAd8D8s9XBgBVMYquInuoOEQ7qNw
         GjKfeT24zzVDYAIx95hI6apaC9i1f45Ln7zjwqoNdmae6WoMjxjBEy0Fzs6/LRMAOZMr
         ZD6tAQ+ddAicIpDKRfraKPv7mTihc1TszjNIRnTNdB+7p89VmbsvhvssdWzK+Rfr0ohR
         KnNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GN0wJ5LnNY6MYcGXoZ0yQC1yHdhXckp/WdDFfQjh9kk=;
        b=5TfCKobKM3Qz3Wf3ARiyK1MDi0PBf3WiJoTP0kKhOLqb4tOVzFeWLrzMKJkjPnmBkK
         TCcBAPfDeVJPilM2ZtqhGwYAPCsmg5YkoW6rfkNxIfHhXrNK+Wfn2KsxgUZTUtbqB6KM
         8RSEmJ7ropgbAEI2mfhEK0YM6iMZUIlnqt2ZWSe5mkmGPFENT3OBOlO9j2BT8Co2E4lE
         nXvx+bjG9N9/mVLFGtIedAHEeG7qYsB9Dr/8qXjctIEldZfMEwloOSpnA/Ks6UPekCd7
         WTmomGnTJbGi4WaIur3Qk2d6Zsqu+a5T2fgXGGFbHveeUwTbKTrSU1uLCDMSGXNj5MWg
         dO+A==
X-Gm-Message-State: AOAM530XRyLdke4up2PoAIFHQ/9s9BO6ojfzTzoPC9TwRRJImqeksRUz
        k+aJBtZSSM6Aw3gGFd4UD6k=
X-Google-Smtp-Source: ABdhPJwx0McoFN5Vjc/Fxh6Jfqyy5O/iD1mjHQ3dQhngP/mFr5R3CzGVfXSMMgwKmr+3V+RE/fBsrg==
X-Received: by 2002:adf:d216:: with SMTP id j22mr16542547wrh.191.1631959082580;
        Sat, 18 Sep 2021 02:58:02 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::ae40])
        by smtp.gmail.com with ESMTPSA id o26sm13013287wmc.17.2021.09.18.02.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 02:58:02 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 8/8] staging: r8188eu: remove EFUSE_Read1Byte()
Date:   Sat, 18 Sep 2021 11:57:27 +0200
Message-Id: <20210918095727.13591-9-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210918095727.13591-1-straube.linux@gmail.com>
References: <20210918095727.13591-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function EFUSE_Read1Byte() is not used, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_efuse.c    | 58 ---------------------
 drivers/staging/r8188eu/include/rtw_efuse.h |  1 -
 2 files changed, 59 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_efuse.c b/drivers/staging/r8188eu/core/rtw_efuse.c
index 0c4ea1e45842..801887f497cf 100644
--- a/drivers/staging/r8188eu/core/rtw_efuse.c
+++ b/drivers/staging/r8188eu/core/rtw_efuse.c
@@ -127,64 +127,6 @@ ReadEFuseByte(
 	*pbuf = (u8)(value32 & 0xff);
 }
 
-/*-----------------------------------------------------------------------------
- * Function:	EFUSE_Read1Byte
- *
- * Overview:	Copy from WMAC fot EFUSE read 1 byte.
- *
- * Input:       NONE
- *
- * Output:      NONE
- *
- * Return:      NONE
- *
- * Revised History:
- * When			Who		Remark
- * 09/23/2008	MHC		Copy from WMAC.
- *
- *---------------------------------------------------------------------------*/
-u8 EFUSE_Read1Byte(struct adapter *Adapter, u16 Address)
-{
-	u8 data;
-	u8 Bytetemp = {0x00};
-	u8 temp = {0x00};
-	u32 k = 0;
-	u16 contentLen = 0;
-
-	rtl8188e_EFUSE_GetEfuseDefinition(Adapter, EFUSE_WIFI, TYPE_EFUSE_REAL_CONTENT_LEN, (void *)&contentLen, false);
-
-	if (Address < contentLen) {	/* E-fuse 512Byte */
-		/* Write E-fuse Register address bit0~7 */
-		temp = Address & 0xFF;
-		rtw_write8(Adapter, EFUSE_CTRL + 1, temp);
-		Bytetemp = rtw_read8(Adapter, EFUSE_CTRL + 2);
-		/* Write E-fuse Register address bit8~9 */
-		temp = ((Address >> 8) & 0x03) | (Bytetemp & 0xFC);
-		rtw_write8(Adapter, EFUSE_CTRL + 2, temp);
-
-		/* Write 0x30[31]= 0 */
-		Bytetemp = rtw_read8(Adapter, EFUSE_CTRL + 3);
-		temp = Bytetemp & 0x7F;
-		rtw_write8(Adapter, EFUSE_CTRL + 3, temp);
-
-		/* Wait Write-ready (0x30[31]= 1) */
-		Bytetemp = rtw_read8(Adapter, EFUSE_CTRL + 3);
-		while (!(Bytetemp & 0x80)) {
-			Bytetemp = rtw_read8(Adapter, EFUSE_CTRL + 3);
-			k++;
-			if (k == 1000) {
-				k = 0;
-				break;
-			}
-		}
-		data = rtw_read8(Adapter, EFUSE_CTRL);
-		return data;
-	} else {
-		return 0xFF;
-	}
-
-} /* EFUSE_Read1Byte */
-
 /*  11/16/2008 MH Read one byte from real Efuse. */
 u8 efuse_OneByteRead(struct adapter *pAdapter, u16 addr, u8 *data, bool pseudo)
 {
diff --git a/drivers/staging/r8188eu/include/rtw_efuse.h b/drivers/staging/r8188eu/include/rtw_efuse.h
index 2dd74c9c691d..53ac906f79fd 100644
--- a/drivers/staging/r8188eu/include/rtw_efuse.h
+++ b/drivers/staging/r8188eu/include/rtw_efuse.h
@@ -118,7 +118,6 @@ u8 efuse_OneByteWrite(struct adapter *adapter, u16 addr, u8 data, bool	test);
 
 void efuse_WordEnableDataRead(u8 word_en, u8 *sourdata, u8 *targetdata);
 
-u8 EFUSE_Read1Byte(struct adapter *adapter, u16 address);
 void EFUSE_ShadowMapUpdate(struct adapter *adapter, u8 efusetype, bool test);
 void EFUSE_ShadowRead(struct adapter *adapt, u8 type, u16 offset, u32 *val);
 
-- 
2.33.0

