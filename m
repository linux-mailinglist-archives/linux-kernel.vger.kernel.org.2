Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C665A41056A
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 11:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243470AbhIRJ0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 05:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238302AbhIRJ0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 05:26:34 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1792C061767
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 02:25:09 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id f62-20020a1c1f41000000b0030b42643f72so3466214wmf.3
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 02:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UmdvyLEdteIkPC5QKKxfnddWF+96+b6HOaR6hgtQ+98=;
        b=PAfVUWwAfKFC9k/MPdqzkVbFlRIkB9zgNuBixDd+OJBB+Debflp+CHG5YSQEUgVIrB
         7AYGKZxvUMoC59aJlBL47rFBEf7b+up/K7iGQ7ZGym6ZyAkeAdeBQviBIaWzxroBdJKZ
         AdxP0b1tkhcYhNz1wvlW1BGW7R09KlxuDCeDA5+4qoVdfHjAnitKHc747AHTD6UOgcSV
         4sKvs6TzmLLVDug0nf+LdbTnvUVtB/VSi1K8uBP93zxrGXrAgT4c3lQsslXw27MZGO5v
         dhSaOrkYi5o+NsqHmtoqvJNjdzCgsV6qV3S3VuXnM8Mr1uXmm32jVjROga9ilR7wPTtd
         1ksA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UmdvyLEdteIkPC5QKKxfnddWF+96+b6HOaR6hgtQ+98=;
        b=4c752naLLpaUJWuUSrP/Ic8D69CxONOARmICIOk1heBdeRrDq9h+EHnIz53ZsFGcK7
         hLgPyyuaiT83ZpBok5dO6MCVI5d9Zkyinvy8fs1yeQ42oY7d4pslioBYQlPkXsXn4WfB
         mk5Q2toEVlbMlvPo6NRdRioUBCuWU8C8nOpSPeNDCWjllBaBiEPopK2F00xSAiFzOEGI
         b/hvYxkloISM1XJ642G3hbk4/buLSyUQlgFeafIMlpV2KDYBv/7Gui5ORXb7a035IS0n
         dLTGBkFh7jAD+EejpUt5Z4yC6hrUtUoxRvw2Og2qxqW8bpZwpe9XnHZbmBE0L4IHjoCF
         mxgw==
X-Gm-Message-State: AOAM533AoWKUH2VLejUHnVkt4WDhMQ1jW+V/GW6CNUSQDQDjz2s+tNEW
        82nx3Wn1E85WKUdc/1MJ/Kc=
X-Google-Smtp-Source: ABdhPJydQyImRLwnzFLTBg+z+D1NBzDNoONwu3O0DeXLm4MKo+POprnIhGJdw8XpXBlu8Q32zYtvwQ==
X-Received: by 2002:a05:600c:4f8e:: with SMTP id n14mr4654195wmq.63.1631957108541;
        Sat, 18 Sep 2021 02:25:08 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::ae40])
        by smtp.gmail.com with ESMTPSA id 5sm4233742wmb.37.2021.09.18.02.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 02:25:08 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 05/12] staging: r8188eu: remove unnecessary if statement
Date:   Sat, 18 Sep 2021 11:24:36 +0200
Message-Id: <20210918092443.8724-6-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210918092443.8724-1-straube.linux@gmail.com>
References: <20210918092443.8724-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SupportPlatform is ODM_CE in this driver. Remove an unnecessary
if statement that checks the SupportPlatform value.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/odm.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
index 5f98c797c59a..cac4f8ff7b63 100644
--- a/drivers/staging/r8188eu/hal/odm.c
+++ b/drivers/staging/r8188eu/hal/odm.c
@@ -465,11 +465,10 @@ void ODM_Write_DIG(struct odm_dm_struct *pDM_Odm, u8 CurrentIGI)
 	struct rtw_dig *pDM_DigTable = &pDM_Odm->DM_DigTable;
 
 	if (pDM_DigTable->CurIGValue != CurrentIGI) {
-		if (pDM_Odm->SupportPlatform & (ODM_CE | ODM_MP)) {
-			ODM_SetBBReg(pDM_Odm, ODM_REG(IGI_A, pDM_Odm), ODM_BIT(IGI, pDM_Odm), CurrentIGI);
-			if (pDM_Odm->SupportICType != ODM_RTL8188E)
-				ODM_SetBBReg(pDM_Odm, ODM_REG(IGI_B, pDM_Odm), ODM_BIT(IGI, pDM_Odm), CurrentIGI);
-		}
+		ODM_SetBBReg(pDM_Odm, ODM_REG(IGI_A, pDM_Odm), ODM_BIT(IGI, pDM_Odm), CurrentIGI);
+		if (pDM_Odm->SupportICType != ODM_RTL8188E)
+			ODM_SetBBReg(pDM_Odm, ODM_REG(IGI_B, pDM_Odm), ODM_BIT(IGI, pDM_Odm), CurrentIGI);
+
 		pDM_DigTable->CurIGValue = CurrentIGI;
 	}
 /*  Add by Neil Chen to enable edcca to MP Platform */
-- 
2.33.0

