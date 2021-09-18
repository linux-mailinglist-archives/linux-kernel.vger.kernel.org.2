Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7A541056C
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 11:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244052AbhIRJ0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 05:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238227AbhIRJ0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 05:26:37 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AAB1C061574
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 02:25:11 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id d207-20020a1c1dd8000000b00307e2d1ec1aso8446616wmd.5
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 02:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QgBNqKitN7XluKj+zUsL9+WAz3JD/lKOrQccDBQ8JQI=;
        b=k4oFhRGBOGsi+RZc+KlST7xQg9k78Sn94z5QLlQjgdWwTZVTm/lomia0kCva8a7D/e
         2SSm2q8udCVNCeF9UAVm2dWn6gPKg+D6caxAkJ9mW9JhmnZLvRi1BA7erkY9fBsvzmRg
         EpJHlze7JCa7D0ICT7i84JptffwYs8jIxToD6ZFAxZPtoiSom4skU2UC7yUAJ46tMC3T
         IL1rcj/+dHZDd96OzVUHY2mwNiVvvzPVaxNFZysqvI2FGZKHvcn33mqsZnNZnNuAk/aA
         QheG3N88JJomcdU/3BsZ3lAjgZVjxkFBCweIUr2r3ObaRt1fW3SKPb89Kd4mPSRN/zPu
         xgZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QgBNqKitN7XluKj+zUsL9+WAz3JD/lKOrQccDBQ8JQI=;
        b=d/AamezxcQn9c1udENwVYd/wrOh10UmibWBEFm2U91DPx4ZoG1Lx/zc22Bwt9UyCux
         /OPc8vgB22hqjdbYN7KxspFjhi0BsOHo2rclLYMuMyCOPXlkIq0x5V8+tkBYKxyRFSuc
         C1U2vpjb0e6W8sVpgayhaccEZPDrQfSGYcKVEMMJrKFAH/0aosfJ03mxSl/eiCKfG7Qh
         rDRpVPZWufZGEGLcviw+A4XsvLshMH2qIVcJX0Wa0MZGUNvyLl6jHQEp86v+00qQ+BS4
         5kAm9otJ9e0ThdHvsP7OJAB7bvuu/0MkMYqpoYi2M0rYZOuC8wIo82QRd9sBZOWwdFcO
         Sn8g==
X-Gm-Message-State: AOAM531+gYO38qQ102HZCwpqT9W/sJE2q+1mFSfvuBk2c5T7BpWHbE3Q
        W8zAPY3jAuoNreZl9Kqfi7c=
X-Google-Smtp-Source: ABdhPJwSgp7ZxDORVnToZFFFW7CJg2/IcXMITZRs3APYAUNXqgBFrJ8vuF+WM+4RrUEufZEJlJVLYQ==
X-Received: by 2002:a7b:cc0b:: with SMTP id f11mr18095370wmh.2.1631957110215;
        Sat, 18 Sep 2021 02:25:10 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::ae40])
        by smtp.gmail.com with ESMTPSA id 5sm4233742wmb.37.2021.09.18.02.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 02:25:09 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 07/12] staging: r8188eu: remove macro ODM_REG
Date:   Sat, 18 Sep 2021 11:24:38 +0200
Message-Id: <20210918092443.8724-8-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210918092443.8724-1-straube.linux@gmail.com>
References: <20210918092443.8724-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace and remove the macro ODM_REG to make the code cleaner.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/odm.c               | 6 +++---
 drivers/staging/r8188eu/include/odm_interface.h | 2 --
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
index 48c10b78f4a5..1e2deb6cdb58 100644
--- a/drivers/staging/r8188eu/hal/odm.c
+++ b/drivers/staging/r8188eu/hal/odm.c
@@ -465,7 +465,7 @@ void ODM_Write_DIG(struct odm_dm_struct *pDM_Odm, u8 CurrentIGI)
 	struct rtw_dig *pDM_DigTable = &pDM_Odm->DM_DigTable;
 
 	if (pDM_DigTable->CurIGValue != CurrentIGI) {
-		ODM_SetBBReg(pDM_Odm, ODM_REG(IGI_A, pDM_Odm), ODM_BIT(IGI, pDM_Odm), CurrentIGI);
+		ODM_SetBBReg(pDM_Odm, ODM_REG_IGI_A_11N, ODM_BIT(IGI, pDM_Odm), CurrentIGI);
 		pDM_DigTable->CurIGValue = CurrentIGI;
 	}
 }
@@ -521,7 +521,7 @@ void odm_DIGInit(struct odm_dm_struct *pDM_Odm)
 {
 	struct rtw_dig *pDM_DigTable = &pDM_Odm->DM_DigTable;
 
-	pDM_DigTable->CurIGValue = (u8)ODM_GetBBReg(pDM_Odm, ODM_REG(IGI_A, pDM_Odm), ODM_BIT(IGI, pDM_Odm));
+	pDM_DigTable->CurIGValue = (u8)ODM_GetBBReg(pDM_Odm, ODM_REG_IGI_A_11N, ODM_BIT(IGI, pDM_Odm));
 	pDM_DigTable->RssiLowThresh	= DM_DIG_THRESH_LOW;
 	pDM_DigTable->RssiHighThresh	= DM_DIG_THRESH_HIGH;
 	pDM_DigTable->FALowThresh	= DM_false_ALARM_THRESH_LOW;
@@ -865,7 +865,7 @@ void ODM_Write_CCK_CCA_Thres(struct odm_dm_struct *pDM_Odm, u8 CurCCK_CCAThres)
 	struct rtw_dig *pDM_DigTable = &pDM_Odm->DM_DigTable;
 
 	if (pDM_DigTable->CurCCK_CCAThres != CurCCK_CCAThres)		/* modify by Guo.Mingzhi 2012-01-03 */
-		ODM_Write1Byte(pDM_Odm, ODM_REG(CCK_CCA, pDM_Odm), CurCCK_CCAThres);
+		ODM_Write1Byte(pDM_Odm, ODM_REG_CCK_CCA_11N, CurCCK_CCAThres);
 	pDM_DigTable->PreCCK_CCAThres = pDM_DigTable->CurCCK_CCAThres;
 	pDM_DigTable->CurCCK_CCAThres = CurCCK_CCAThres;
 }
diff --git a/drivers/staging/r8188eu/include/odm_interface.h b/drivers/staging/r8188eu/include/odm_interface.h
index 4f35dcd0bf49..a5a7b72815f3 100644
--- a/drivers/staging/r8188eu/include/odm_interface.h
+++ b/drivers/staging/r8188eu/include/odm_interface.h
@@ -4,12 +4,10 @@
 #ifndef	__ODM_INTERFACE_H__
 #define __ODM_INTERFACE_H__
 
-#define _reg_11N(_name)			ODM_REG_##_name##_11N
 #define _bit_11N(_name)			ODM_BIT_##_name##_11N
 
 #define _cat(_name, _func)	(_func##_11N(_name))
 
-#define ODM_REG(_name, _pDM_Odm) _cat(_name, _reg)
 #define ODM_BIT(_name, _pDM_Odm) _cat(_name, _bit)
 
 enum odm_h2c_cmd {
-- 
2.33.0

