Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3176241056D
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 11:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241035AbhIRJ0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 05:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238290AbhIRJ0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 05:26:37 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6518DC0613C1
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 02:25:12 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id b21-20020a1c8015000000b003049690d882so11718704wmd.5
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 02:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HgLgc9yM59ExKmqslgazl+TqXbR0Gqq2UFS62UlS1Jk=;
        b=N1b1uO2vD0KXMhrTTq0mVRySSqyWwUi58Tyi93v1L8d2x+azLPZRvC86UOB16p50Ge
         buRZHWC0IG5WK1bYPyAaOPiVvq5G4J6NI18jEIQHhhcd5uwjfcEDt6bxmAOuaQ2Agtsb
         HYpCbzYFvsAOYMEclCIKVUl2EVs1wyprchLJMndx8kOJiqcqecQiQwmVpl9fii5w6bCq
         5Lt7pjnhOdq5lAhACdusOQZ29uthUUQJR14e6PVC/OAIR4s11cpjfGmFeTILZspDfcYj
         8XVFX5dxTS9gMBnIkiRkUOnjaNwUMl57S9ZLjMR6BeJnphfg5YpNHgEirG4WpiVcu6CJ
         z0xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HgLgc9yM59ExKmqslgazl+TqXbR0Gqq2UFS62UlS1Jk=;
        b=Rbe6M7ADxFGs8I6Qk5dSPqtdKuLVmm1lQDBvNJ0dpJNDV90a8iYlTs0pt4YoILNTOP
         yWMrTrTwSeJcxjSz6GwwEx8uVOBvzKbegdlfzQoupYPR6fAYikZKSf6VffWuHhYhh9DF
         NX5VhNLN/Zi2CQVxKyuc7xASAuulB7p6yJgmocWaOFbzU27I1D+IsePvDbCYdgwBJi4P
         OimxAJOBJMHWvhJIuQ2DTQJnmn0kBwa2isEFGcAnQhj0hBPgdlDBoUbtT8kmmKq3H67L
         /JDz5PbZbh7iGAVvAk1EU+A1I3yTWUeu1mgQS6pWOdioLg3PgjwYfPsQgl8x7fyOLxRv
         5wnQ==
X-Gm-Message-State: AOAM53279Zceegz2qwD4bWnlDjsD6Zz0n8+wi2l1SNY637tHGyY9aRBi
        JU7Zo1wc40hEP+Ycu27KmOQ=
X-Google-Smtp-Source: ABdhPJzjH+qUW5r4KVi2JWZnD/kEwHd7oQKPn8a+6Crd44UpFQerl7qx3luCYoc7sFCMNgfokV/nEQ==
X-Received: by 2002:a1c:7304:: with SMTP id d4mr9177832wmb.125.1631957111036;
        Sat, 18 Sep 2021 02:25:11 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::ae40])
        by smtp.gmail.com with ESMTPSA id 5sm4233742wmb.37.2021.09.18.02.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 02:25:10 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 08/12] staging: r8188eu: remove macro ODM_BIT
Date:   Sat, 18 Sep 2021 11:24:39 +0200
Message-Id: <20210918092443.8724-9-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210918092443.8724-1-straube.linux@gmail.com>
References: <20210918092443.8724-1-straube.linux@gmail.com>
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

