Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D865F410813
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 20:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240715AbhIRSVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 14:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240283AbhIRSUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 14:20:50 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51FBFC061574
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 11:19:26 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id t6so43013489edi.9
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 11:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QgBNqKitN7XluKj+zUsL9+WAz3JD/lKOrQccDBQ8JQI=;
        b=FiY2hI8fj3XBfbJxhU32CjAAvAWk7dqluucrM3ExnrwdoVRIsn4TVAJblxrd9pLF4n
         /b7xcevhny/gNZ9xOnDXzhhS5aSx7KqaNbArjbwKDnJZeDutXnRG1uXnfsFNiVBmkiHO
         OLED89b59bG8bQAJdF2AUMEb8tKEl9YuV34vNWKfSeYlguQADIjloD+1eGqYOHqx35vh
         nb8oV5qmquRe3eMHjRCa54idcStF4UQtJisXhyfO23EYzq9Pc+3kC3M478PHEEE07s7b
         3t6ri6f1014OfAZ7NJwY69bhX+RrnpGvGz/TOs43idfIN7Ag1yoX5SrFUDnllHvkMucq
         L6PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QgBNqKitN7XluKj+zUsL9+WAz3JD/lKOrQccDBQ8JQI=;
        b=pIyCqbzu/w/73zTp+EdrK5FwELDSMljeSIzqWyjSXh8OipgN8AZO1nMiP2o7b0PTER
         9S8mMLXpoUyHzduu3KmZNMoQTNfvaSB2W1qrzM1anWpW0ciD2IwKEBJKpgEM6XW4hukl
         aZkOmRkMoJQx0DFUXCHIXw7CJ3ObSYtzWn5XSsarIzEvtP0ZHZrkE33i+B8XuzV9oPwd
         r4i2Go7VgVHoSEvyJK6SuTw+by3c1L7IO5Cn28W2/sWDLuQwLqg+/ETJ1sbDFIhkfhzr
         PAvS1gn3DVMSbAn3Xbw7A/Wslj0Ub2ssKeVnPcsym+SmAWGY/u6iduHPF1u1J95Na7W4
         2tcQ==
X-Gm-Message-State: AOAM53176/TsGkRnVppJEYwmLKx03KwJj+BNXGK8N46Ot0UuSeGJTzDA
        dh0p4Q7+uhPSaAnmoHTZ08E=
X-Google-Smtp-Source: ABdhPJyilrkJpFWhjhoYBgPmX0pLns4stdHI9+hic5iT49+79idGh4/BsUhhO74d1y0wUZaqyDHw3g==
X-Received: by 2002:a17:906:8608:: with SMTP id o8mr19325097ejx.470.1631989164942;
        Sat, 18 Sep 2021 11:19:24 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::cde])
        by smtp.gmail.com with ESMTPSA id t19sm3903673ejb.115.2021.09.18.11.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 11:19:24 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v3 07/14] staging: r8188eu: remove macro ODM_REG
Date:   Sat, 18 Sep 2021 20:18:57 +0200
Message-Id: <20210918181904.12000-8-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210918181904.12000-1-straube.linux@gmail.com>
References: <20210918181904.12000-1-straube.linux@gmail.com>
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

