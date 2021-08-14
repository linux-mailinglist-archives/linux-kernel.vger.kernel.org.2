Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C43533EC133
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 09:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237374AbhHNHlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 03:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236519AbhHNHlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 03:41:03 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EBCDC06175F
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 00:40:35 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id x12so16282926wrr.11
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 00:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ssbrzr2nx0rE0JNE1VJsrKipba9hb+pFtUvZYUXY/LU=;
        b=DtNuDkOrsCOjybj26b0uPRs5N4qE1y5gum8Xm7eQgZXsNGjQO/6j7rI5axD9jcxqLL
         yyRkjeenp6feIqil8jhspnZB1+1tl+WYkm1utHzd+qgwrzMXK9MHxH7vD44FXYWUaADu
         ormpol1hnmmRUjOc+kaIR2p1NMDIqVsgX5Z9loLEvjCLPxT8p8hlHkgayOYJkbyo8OoV
         9XeKaOCpr79C8vhuE1nHjIbKfQFbvViLYiFTURNyjiEGoSQ34YVqa/CXOBTA9cybmlYh
         jqBiY1Jk0oQWmWF6PSGKjw8uP5KY2MC08W1WpGYnUpaNfamysLh0SsRQv8BvJYAtZY0i
         seow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ssbrzr2nx0rE0JNE1VJsrKipba9hb+pFtUvZYUXY/LU=;
        b=MzbwLrcYaLrnUPH7Lu45u+uDx7D0srFmX2U/qFAzVdk53Ag18fdA7KI8U2p5f1plpj
         VJIQVemgqJeckKmN7atWEPO+uST2vXVySvc2vGPtSAzCsCT7nK7gRxq/wFKDBgTl7r6j
         tE4qyZEwmlMIalKKMQISi9OeJ0wR7BZzS3gZSxwAYS83a4vqqormxt19lKGEDQ/leKWX
         iDsNw9XtoZV4WSb6NW03UygnTi975GWQW8AhKMsYkJS2A9QRrsLOPeITDRH5c+Nm8AlZ
         tTd82YXZ/iuL/LaHdBqWwrdd/ofwJVajnULRn4sdHmcmdpK12PscIARQYPrq6fSW34tl
         Lp3Q==
X-Gm-Message-State: AOAM531xZFcKsBFxOpsIniOUAIbcdKXocYdk4pLDaT5bfFCtHW6OecH/
        LJ15m1BPiySFqL97ArPRuUo=
X-Google-Smtp-Source: ABdhPJxVOEE1AU4br+nyhnQEp/0WNXHPiWetLqZKce7RrxrL8Lq5eBB8yIkdTlz4pHHEqtfz5tH7Jg==
X-Received: by 2002:adf:df08:: with SMTP id y8mr7261054wrl.124.1628926833841;
        Sat, 14 Aug 2021 00:40:33 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::4058])
        by smtp.gmail.com with ESMTPSA id l21sm3258750wmh.31.2021.08.14.00.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Aug 2021 00:40:33 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: r8188eu: remove ODM_GetRightChnlPlaceforIQK()
Date:   Sat, 14 Aug 2021 09:39:20 +0200
Message-Id: <20210814073920.3551-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function ODM_GetRightChnlPlaceforIQK() returns always zero for
channels <= 14. The driver is for chips that do not support 5 GHz,
so remove the function and replace the usage of its return value
with zero.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/HalPhyRf_8188e.c | 29 ++------------------
 1 file changed, 3 insertions(+), 26 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
index 643a4d348b2e..c92a76aebc11 100644
--- a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
+++ b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
@@ -1004,27 +1004,6 @@ static void phy_IQCalibrate_8188E(struct adapter *adapt, s32 result[][8], u8 t,
 	}
 }
 
-#define ODM_TARGET_CHNL_NUM_2G_5G	59
-static u8 ODM_GetRightChnlPlaceforIQK(u8 chnl)
-{
-	u8	channel_all[ODM_TARGET_CHNL_NUM_2G_5G] = {
-		1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14,
-		36, 38, 40, 42, 44, 46, 48, 50, 52, 54, 56, 58, 60, 62, 64,
-		100, 102, 104, 106, 108, 110, 112, 114, 116, 118, 120, 122,
-		124, 126, 128, 130, 132, 134, 136, 138, 140, 149, 151, 153,
-		155, 157, 159, 161, 163, 165
-	};
-	u8	place = chnl;
-
-	if (chnl > 14) {
-		for (place = 14; place < sizeof(channel_all); place++) {
-			if (channel_all[place] == chnl)
-				return place-13;
-		}
-	}
-	return 0;
-}
-
 static void phy_LCCalibrate_8188E(struct adapter *adapt, bool is2t)
 {
 	u8 tmpreg;
@@ -1088,7 +1067,7 @@ void PHY_IQCalibrate_8188E(struct adapter *adapt, bool recovery)
 	struct odm_dm_struct *dm_odm = &pHalData->odmpriv;
 	struct mpt_context *pMptCtx = &adapt->mppriv.MptCtx;
 	s32 result[4][8];	/* last is final result */
-	u8 i, final_candidate, Indexforchannel;
+	u8 i, final_candidate;
 	bool pathaok, pathbok;
 	s32 RegE94, RegE9C, RegEA4, RegEB4, RegEBC, RegEC4;
 	bool is12simular, is13simular, is23simular;
@@ -1200,14 +1179,12 @@ void PHY_IQCalibrate_8188E(struct adapter *adapt, bool recovery)
 			pathb_fill_iqk(adapt, pathbok, result, final_candidate, (RegEC4 == 0));
 	}
 
-	Indexforchannel = ODM_GetRightChnlPlaceforIQK(pHalData->CurrentChannel);
-
 /* To Fix BSOD when final_candidate is 0xff */
 /* by sherry 20120321 */
 	if (final_candidate < 4) {
 		for (i = 0; i < IQK_Matrix_REG_NUM; i++)
-			dm_odm->RFCalibrateInfo.IQKMatrixRegSetting[Indexforchannel].Value[0][i] = result[final_candidate][i];
-		dm_odm->RFCalibrateInfo.IQKMatrixRegSetting[Indexforchannel].bIQKDone = true;
+			dm_odm->RFCalibrateInfo.IQKMatrixRegSetting[0].Value[0][i] = result[final_candidate][i];
+		dm_odm->RFCalibrateInfo.IQKMatrixRegSetting[0].bIQKDone = true;
 	}
 
 	_PHY_SaveADDARegisters(adapt, IQK_BB_REG_92C, dm_odm->RFCalibrateInfo.IQK_BB_backup_recover, 9);
-- 
2.32.0

