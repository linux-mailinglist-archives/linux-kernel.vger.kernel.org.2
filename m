Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 307D6410568
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 11:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238625AbhIRJ0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 05:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238297AbhIRJ0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 05:26:32 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04AF2C061766
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 02:25:09 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id d6so19083123wrc.11
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 02:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nh/WmLCbKtUynZDayAfXG6y9ApWz2vlF+iZiOm05hgM=;
        b=CKyLlR3xnAsEYgY2ruOz6sIhAWHvSbBYThR7IVsFmVWmmVsqreCR8sXb5bkEoUGhul
         T6yiyekoREyVkEWuuTm8n2I1q0B/rDCvhCV5tRosr5SL/7x3O0oNGoNYdmU49VBDR4Bv
         ZQpHXqZxkVhlzfZVe9DYheWE3FcPgNSVEz212SytXjQoKWmKgV1kXjrIId87pD84h9Tq
         iPO2I6ovaC3Zn3GvDcGpFALM2/zomWrhFiBUKXTFGnddgh0CDtfznpEs7UG1WVytMbQm
         L/mvopUqjXJSFbtYCYJbZhtuxQBkoP3/vIpXAwlFGPD2ix1WM6F5xxNUiRexmh39LRBR
         dZAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nh/WmLCbKtUynZDayAfXG6y9ApWz2vlF+iZiOm05hgM=;
        b=iTN7uUz8jU6RLl6w0xh+EdynoM8poClehAJ/fx0BhJ01bL4sSDTUZXbgVWJpobZeAk
         T6wxI9YvVsiWRx8vYdUpUB4B+Er4wXt1LLPDPIIBpfjShYJF6J0OsRvXFW91umMVKBrc
         RmavdOlDrgj1QIsB37Lk+4VJwTw1lHLfyTfjzeLJMYVAwOTXFZE1+hcxLMDOortXIVSi
         vqtWyIo6O7Jpj2hQS66d3/x7bG+z19eyy+Cy7a3j+dbBsdjsmkuPE4E+GBy+LiA519fF
         PDoAemMBxDFws9FBKvBfROIYP/2S76fiouRreyLy2QGMxS8nDOtXhZ4e+M6ImItA+zdh
         VuOA==
X-Gm-Message-State: AOAM532HwP1FJhIihtndEvGnMVQZ+VcdqyWiV8000ExxwfITsZA+Qmd1
        vGkMWA8ARL2zXZQ11au0odM=
X-Google-Smtp-Source: ABdhPJyW2d+o7ZXFv0NI4CzuoTCcMXgUcbx1SicCll5kGJ23KhZ1TP5kJeBt0loUw71pDHlaNOBoSA==
X-Received: by 2002:adf:e8c7:: with SMTP id k7mr17084379wrn.47.1631957107689;
        Sat, 18 Sep 2021 02:25:07 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::ae40])
        by smtp.gmail.com with ESMTPSA id 5sm4233742wmb.37.2021.09.18.02.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 02:25:07 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 04/12] staging: r8188eu: remove dead code from ODM_Write_DIG()
Date:   Sat, 18 Sep 2021 11:24:35 +0200
Message-Id: <20210918092443.8724-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210918092443.8724-1-straube.linux@gmail.com>
References: <20210918092443.8724-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In this driver SupportPlatform is ODM_CE, so code in the
"else if (pDM_Odm->SupportPlatform & (ODM_AP | ODM_ADSL))" is never
executed. Remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/odm.c | 34 -------------------------------
 1 file changed, 34 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
index d23e9296a10e..5f98c797c59a 100644
--- a/drivers/staging/r8188eu/hal/odm.c
+++ b/drivers/staging/r8188eu/hal/odm.c
@@ -460,21 +460,6 @@ void odm_CommonInfoSelfUpdate(struct odm_dm_struct *pDM_Odm)
 		pDM_Odm->bOneEntryOnly = false;
 }
 
-static int getIGIForDiff(int value_IGI)
-{
-	#define ONERCCA_LOW_TH		0x30
-	#define ONERCCA_LOW_DIFF	8
-
-	if (value_IGI < ONERCCA_LOW_TH) {
-		if ((ONERCCA_LOW_TH - value_IGI) < ONERCCA_LOW_DIFF)
-			return ONERCCA_LOW_TH;
-		else
-			return value_IGI + ONERCCA_LOW_DIFF;
-	} else {
-		return value_IGI;
-	}
-}
-
 void ODM_Write_DIG(struct odm_dm_struct *pDM_Odm, u8 CurrentIGI)
 {
 	struct rtw_dig *pDM_DigTable = &pDM_Odm->DM_DigTable;
@@ -484,26 +469,7 @@ void ODM_Write_DIG(struct odm_dm_struct *pDM_Odm, u8 CurrentIGI)
 			ODM_SetBBReg(pDM_Odm, ODM_REG(IGI_A, pDM_Odm), ODM_BIT(IGI, pDM_Odm), CurrentIGI);
 			if (pDM_Odm->SupportICType != ODM_RTL8188E)
 				ODM_SetBBReg(pDM_Odm, ODM_REG(IGI_B, pDM_Odm), ODM_BIT(IGI, pDM_Odm), CurrentIGI);
-		} else if (pDM_Odm->SupportPlatform & (ODM_AP | ODM_ADSL)) {
-			switch (*pDM_Odm->pOnePathCCA) {
-			case ODM_CCA_2R:
-				ODM_SetBBReg(pDM_Odm, ODM_REG(IGI_A, pDM_Odm), ODM_BIT(IGI, pDM_Odm), CurrentIGI);
-				if (pDM_Odm->SupportICType != ODM_RTL8188E)
-					ODM_SetBBReg(pDM_Odm, ODM_REG(IGI_B, pDM_Odm), ODM_BIT(IGI, pDM_Odm), CurrentIGI);
-				break;
-			case ODM_CCA_1R_A:
-				ODM_SetBBReg(pDM_Odm, ODM_REG(IGI_A, pDM_Odm), ODM_BIT(IGI, pDM_Odm), CurrentIGI);
-				if (pDM_Odm->SupportICType != ODM_RTL8188E)
-					ODM_SetBBReg(pDM_Odm, ODM_REG(IGI_B, pDM_Odm), ODM_BIT(IGI, pDM_Odm), getIGIForDiff(CurrentIGI));
-				break;
-			case ODM_CCA_1R_B:
-				ODM_SetBBReg(pDM_Odm, ODM_REG(IGI_A, pDM_Odm), ODM_BIT(IGI, pDM_Odm), getIGIForDiff(CurrentIGI));
-				if (pDM_Odm->SupportICType != ODM_RTL8188E)
-					ODM_SetBBReg(pDM_Odm, ODM_REG(IGI_B, pDM_Odm), ODM_BIT(IGI, pDM_Odm), CurrentIGI);
-				break;
-			}
 		}
-		/* pDM_DigTable->PreIGValue = pDM_DigTable->CurIGValue; */
 		pDM_DigTable->CurIGValue = CurrentIGI;
 	}
 /*  Add by Neil Chen to enable edcca to MP Platform */
-- 
2.33.0

