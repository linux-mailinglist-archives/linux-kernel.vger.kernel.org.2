Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44455410812
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 20:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240582AbhIRSU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 14:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240239AbhIRSUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 14:20:48 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1ED5C061574
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 11:19:24 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id h17so43084392edj.6
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 11:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UmdvyLEdteIkPC5QKKxfnddWF+96+b6HOaR6hgtQ+98=;
        b=IjAOonNcxGUtuI1FvVBWz2NywLVRBrbOWHDoCdkoByXq2GP8VMK5Ziu3bdz5fFqprm
         Yx8DUNODVLVl6u9z3D1RaV+b9PdUMR0+WRS9R8qMJGDqYoZZfqFtlqUKCegoHgiKynoo
         XScrW9/nXM1ADOI6J4qZx7s8mn4XQ8NP1+j9o1AGINhwfJJIBnIyP24rJObRp/qjd3Of
         roUUArauJWaltiWJaJCw+OIRKofdiwofPcLbFy8aTJdQ7YOHTIKzhbiFY/Re++vIH3In
         rK7lD83sx4ZAfh5HcNL5aGY5B6yLdGHkcRyIoEq+4m1twkQlr/KVfpxK8cPPbRpS+Sf/
         S2Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UmdvyLEdteIkPC5QKKxfnddWF+96+b6HOaR6hgtQ+98=;
        b=YrrZlTJkRkfkx/Qf+TSZcbvevv/aaOxfkGp93wMUju9TVG6qaEflRSBGUYMc42C48j
         AxjDVuAiQPo0kE2mVwXlGPeaR7C3RmYaTCiE7AhKqavFq1bau0+M/FScU4eNp+OuNpB1
         8muzRGUrZB4N79LfDSjfXNTNniWOR6bEvL08sxpufgLGTTDgNf5mz++A0g03FOs/Ft6x
         4eALJDinA1upaN3g43GwHHOlYowkBxupLLDwvvCK+WS2d0W7AOFrFKKBLK2oA5Dv3Vx0
         NcY22TzNKB6Ju3rV5U2OUf/aBeeemqbI+8zbvEyRvJFjxYy1JhtdHbvthcZ6tDSmiTHO
         JWmQ==
X-Gm-Message-State: AOAM533gMqtdHEy2tTswPnLBrib9I3K3g497f7i3h2dvbjDBm0HCTSlX
        gjjXOt90Fh/eKBWaviPoEo0=
X-Google-Smtp-Source: ABdhPJwYa8zWwOZxps/DyLr7Mv8Fs+A8bgd2KgyGDYX5xOYAQWhUlzINikOIJixIXEaWUj6fBbx12g==
X-Received: by 2002:a17:906:8981:: with SMTP id gg1mr19515105ejc.95.1631989163462;
        Sat, 18 Sep 2021 11:19:23 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::cde])
        by smtp.gmail.com with ESMTPSA id t19sm3903673ejb.115.2021.09.18.11.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 11:19:23 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v3 05/14] staging: r8188eu: remove unnecessary if statement
Date:   Sat, 18 Sep 2021 20:18:55 +0200
Message-Id: <20210918181904.12000-6-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210918181904.12000-1-straube.linux@gmail.com>
References: <20210918181904.12000-1-straube.linux@gmail.com>
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

