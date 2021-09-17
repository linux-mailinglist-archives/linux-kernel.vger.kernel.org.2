Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 483454101BA
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 01:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344993AbhIQXcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 19:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343621AbhIQXcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 19:32:31 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562F8C061766
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 16:31:08 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 196-20020a1c04cd000000b002fa489ffe1fso11110534wme.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 16:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nh/WmLCbKtUynZDayAfXG6y9ApWz2vlF+iZiOm05hgM=;
        b=bxQG6KfnTvdmoVTlN+kbBu04D0d2U9T3rPG64svVwmt+kdStWkhVMJ1N+fy9geJdbU
         Jo9Ucnn1dCuL6oiWioK022koYfJG5WrMbURp+vDvqmi57ZZRbv+gGsabGQ6Oe36X3fkf
         ZNGoKm0J2QlcZnuSVp/SkG4yDiSSaFWsFVRcUI+AH/c+HGZogB2vI0zo4PiR9KEa+sZc
         FkBh+I1qtbxr9YchGmbd/4Mqs3PZ4Q23au93LH/7NRtxv/5Jau2KvDIBoQ6fmNi6cHEB
         j3aMI+of21PbbMXm3CarqoEdqORd/kDZ6IahxJbXKJRRN4I2QuLJnw8WL3oQvGgBnxsZ
         bXWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nh/WmLCbKtUynZDayAfXG6y9ApWz2vlF+iZiOm05hgM=;
        b=3Y7zOtEYZPWwMxevoTSvIGLtSShxQRXArGxia2tyHCpqJqmEnHyqb+VRTYtTn2YcUe
         rZQi2+cHwMp7/Gye1qg/ZyXTpQz7t7Z6i7ajwLuyBq9t3NXIFvYM/c0fq46lmFuH26E7
         c0DVM9hEkh2ktodydJIMTip91nW1LlxbmtR3FGguz7WJyEZI8Nrg/nUjjwJUrCgJE+ak
         k5kTM0m6/UebdtJo5BdCYLe1fNRsd4O8gzBUHplYJm4MwNXdc3eV/BD24CIFS/DHpbZ/
         qmDMvxDUCUKgRlEK2y5Q+VfXvechbsYNGDnDrOaHhptBn4wq7h3DqGJXDFgHGvqbIy0R
         kYBw==
X-Gm-Message-State: AOAM533btUrfCKvajXC5Ic7EkC29Ub1ksfrCDF8yQN9980NgyiEI/dSF
        3xf4NR3JRI74T1iOT6ctlmQ=
X-Google-Smtp-Source: ABdhPJw3DN2hlGMzCxa4fRaqx0jH7UojSO2RD8CUjnBPy6U8RahU6I0X3R3OO8ybAR2V3Csk4EqBXw==
X-Received: by 2002:a1c:7f89:: with SMTP id a131mr17116622wmd.31.1631921467059;
        Fri, 17 Sep 2021 16:31:07 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::ae40])
        by smtp.gmail.com with ESMTPSA id w9sm7523148wmc.19.2021.09.17.16.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 16:31:06 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 04/12] staging: r8188eu: remove dead code from ODM_Write_DIG()
Date:   Sat, 18 Sep 2021 01:30:40 +0200
Message-Id: <20210917233048.31677-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210917233048.31677-1-straube.linux@gmail.com>
References: <20210917233048.31677-1-straube.linux@gmail.com>
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

