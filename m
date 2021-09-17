Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 828794101BC
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 01:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344930AbhIQXcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 19:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344925AbhIQXce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 19:32:34 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6561C061768
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 16:31:11 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id f62-20020a1c1f41000000b0030b42643f72so2899632wmf.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 16:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HgLgc9yM59ExKmqslgazl+TqXbR0Gqq2UFS62UlS1Jk=;
        b=d62PWkI9K/5/hywl4FPcytG0YRk1SOUxpf1SHaJOnqErIIjakaEhHW+j6xukTMY0CQ
         FN/JC9sWd8JkhE2sxxHWI7L/mH0ZdyQm6I5TdobM/cZ0Tkxi1qHb7kHO0npCCgSzLq2n
         SLtEd2Alfht2o0OC0/+utqdV45MhSwNOjnPzsrxS0FuKjaFYa2KkPP9+dzE3ZjTI/RKl
         CHovOO40M1maTFjeYE/R+hsGy/RaqgnInUQOZqJMGQPHQaqs44dboGuFZoPLhemNV3gj
         hMW9pcuQNc/VeLs+9AKsh6aN1CXFoNppIcRsl2yrKCZpTvt1cDmIu7n6zR5KT7vFruxM
         1zuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HgLgc9yM59ExKmqslgazl+TqXbR0Gqq2UFS62UlS1Jk=;
        b=f6D/0GbFeM0mxOlbo3L9ynCqWG48DrBWndb+BJfa13/EltOmgi2Dgcs7vEomgkO67n
         MxNqA1kj+7D7HM4l6qG7taADppBIkyh3pPETQRnB7hY10nXRME+rnF2G4EvyB+WoCXTM
         MK5Qv9MZT3+5QQD99Q+pct7Jq9sKzlijWv5DDXaolJp9TYcDdFkrWkPsB8mQCKjt4TYF
         N3dbv5LbzsMChK2s+t2D4poVjCiyzi3IkvJum+sgaMtPf90OfWL0lOC+TMEU2wXeLi9V
         TeXFIRJojyRqbwcXx3Awg4SPrwpJ2eLNu4khhkEdVhUQKgJQtjDJh4OI/m9Oy/tNmnUi
         rfWQ==
X-Gm-Message-State: AOAM533EzwZ62kww8tbB/Fr5BYw8Rqamu0YWlQ4YmeKHWqN/kZEGtEr0
        KZuqJ15XmMbf96ru4cfJu2o=
X-Google-Smtp-Source: ABdhPJyCku0WeZ+ol2xKP3C8zHw7ndewR1OYJyps+jz9OuTWsiBcHypv2QBhAWBVr0PiceVR//jbWw==
X-Received: by 2002:a1c:f607:: with SMTP id w7mr13129105wmc.65.1631921470581;
        Fri, 17 Sep 2021 16:31:10 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::ae40])
        by smtp.gmail.com with ESMTPSA id w9sm7523148wmc.19.2021.09.17.16.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 16:31:10 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 08/12] staging: r8188eu: remove macro ODM_BIT
Date:   Sat, 18 Sep 2021 01:30:44 +0200
Message-Id: <20210917233048.31677-9-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210917233048.31677-1-straube.linux@gmail.com>
References: <20210917233048.31677-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace and remove the macro ODM_BIT to make the code cleaner.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/odm.c               | 4 ++--
 drivers/staging/r8188eu/include/odm_interface.h | 6 ------
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
index 1e2deb6cdb58..cb27edf657d9 100644
--- a/drivers/staging/r8188eu/hal/odm.c
+++ b/drivers/staging/r8188eu/hal/odm.c
@@ -465,7 +465,7 @@ void ODM_Write_DIG(struct odm_dm_struct *pDM_Odm, u8 CurrentIGI)
 	struct rtw_dig *pDM_DigTable = &pDM_Odm->DM_DigTable;
 
 	if (pDM_DigTable->CurIGValue != CurrentIGI) {
-		ODM_SetBBReg(pDM_Odm, ODM_REG_IGI_A_11N, ODM_BIT(IGI, pDM_Odm), CurrentIGI);
+		ODM_SetBBReg(pDM_Odm, ODM_REG_IGI_A_11N, ODM_BIT_IGI_11N, CurrentIGI);
 		pDM_DigTable->CurIGValue = CurrentIGI;
 	}
 }
@@ -521,7 +521,7 @@ void odm_DIGInit(struct odm_dm_struct *pDM_Odm)
 {
 	struct rtw_dig *pDM_DigTable = &pDM_Odm->DM_DigTable;
 
-	pDM_DigTable->CurIGValue = (u8)ODM_GetBBReg(pDM_Odm, ODM_REG_IGI_A_11N, ODM_BIT(IGI, pDM_Odm));
+	pDM_DigTable->CurIGValue = (u8)ODM_GetBBReg(pDM_Odm, ODM_REG_IGI_A_11N, ODM_BIT_IGI_11N);
 	pDM_DigTable->RssiLowThresh	= DM_DIG_THRESH_LOW;
 	pDM_DigTable->RssiHighThresh	= DM_DIG_THRESH_HIGH;
 	pDM_DigTable->FALowThresh	= DM_false_ALARM_THRESH_LOW;
diff --git a/drivers/staging/r8188eu/include/odm_interface.h b/drivers/staging/r8188eu/include/odm_interface.h
index a5a7b72815f3..3af58e853828 100644
--- a/drivers/staging/r8188eu/include/odm_interface.h
+++ b/drivers/staging/r8188eu/include/odm_interface.h
@@ -4,12 +4,6 @@
 #ifndef	__ODM_INTERFACE_H__
 #define __ODM_INTERFACE_H__
 
-#define _bit_11N(_name)			ODM_BIT_##_name##_11N
-
-#define _cat(_name, _func)	(_func##_11N(_name))
-
-#define ODM_BIT(_name, _pDM_Odm) _cat(_name, _bit)
-
 enum odm_h2c_cmd {
 	ODM_H2C_RSSI_REPORT = 0,
 	ODM_H2C_PSD_RESULT= 1,
-- 
2.33.0

