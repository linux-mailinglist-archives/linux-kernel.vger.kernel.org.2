Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 351FA3F9761
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 11:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244877AbhH0Jm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 05:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244863AbhH0Jmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 05:42:45 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E9BC0613D9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 02:41:57 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id j17-20020a05600c1c1100b002e754875260so3896018wms.4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 02:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f12Hn60JdHwjTyKJk0H367v8of78nOQuO/KvQJNA+J0=;
        b=Cse1IlwDVJ2WkoZnxD1i7i+T5vs0wFP2IJ8pa8iEPDK607uCsOUlosNZwJRBCPTt4S
         ncvh/CEqAK72qrWvL5ljaPWiaspyX9JuxBFWOgg7XJF8OlVkiWYoRAU6XIEbsD4w/hyw
         LgNgwNweSlXwV4jTWMZP+pPI9mGw6wWIJjRh984Nus1b5MJDW6jE8Pb3/YphTsZZF53D
         +ZNkik6s3VDKuUiMgoieTvIdIxwPMUWZ1C6LVnhRmS7PBTBRsbFA7EhafSJMjXqQkmnW
         C0tkupzzbaVbKUB1utku3VwBbgxdnFZUWTWPTKiwxngfYNGs7+Knxu9Cn4tRsM6K0CjF
         4gxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f12Hn60JdHwjTyKJk0H367v8of78nOQuO/KvQJNA+J0=;
        b=SbQL5+sNkE1SejfsCyEEvCUcAgC+8c5FeZq+n6MzgZlrvYh5nkLANvmHN60lmlpd4E
         +7O0nyVQgdjS7wBSriYaVfg+lPc4ehDvdGc6qq94seUWhxtJ8R+0R4TYxZLBuwI4zAlR
         eIiVlDQAP0B2WDalGOblOxiY9eCASGzk25U8u4d/IXC1UrZ7J+J1qBoZM/TkWmYYhGNG
         ysrI2M/hIPFmUgmBlf5n3icGfQR54EKa29ctbHLnpvQ9IcWEvDQIMlrBGJWDoMtmjn07
         8q5f1SrlKfExnT27NliNQrgyBDRMp5NOTF/8wdnCH801Vudn2WH+Ce4orjPkLuFOw0od
         6SYg==
X-Gm-Message-State: AOAM530Cl3u61bez8M1pT1Fam4cKpBgMmNBETycB7Vsg03XJvY1jKFtT
        UV2J86RLBGk+F8IuwY1nOrI=
X-Google-Smtp-Source: ABdhPJyZgRNI4z9Q61Wr/CAafa3C3gbRp2tOloT2kVdbJG+9i/fwZ0OAym+YGrnf2Dc3SMCgQ5vW1w==
X-Received: by 2002:a7b:c927:: with SMTP id h7mr7921759wml.154.1630057315723;
        Fri, 27 Aug 2021 02:41:55 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::884b])
        by smtp.gmail.com with ESMTPSA id b15sm6500034wru.1.2021.08.27.02.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 02:41:55 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 4/4] staging: r8188eu: rename fields of struct rtl_ps
Date:   Fri, 27 Aug 2021 11:41:44 +0200
Message-Id: <20210827094144.13290-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210827094144.13290-1-straube.linux@gmail.com>
References: <20210827094144.13290-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename fields of struct rtl_ps to avoid camel case.

PreCCAState -> pre_cca_state
CurCCAState -> cur_cca_state

PreRFState -> pre_rf_state
CurRFState -> cur_rf_state

Rssi_val_min -> rssi_val_min

Reg874 -> reg_874
RegC70 -> reg_c70
Reg85C -> reg_85c
RegA74 -> reg_a74

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/odm.c     | 64 +++++++++++++--------------
 drivers/staging/r8188eu/include/odm.h | 15 ++++---
 2 files changed, 41 insertions(+), 38 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
index c1449fab3a95..ed94f64d878d 100644
--- a/drivers/staging/r8188eu/hal/odm.c
+++ b/drivers/staging/r8188eu/hal/odm.c
@@ -921,11 +921,11 @@ void odm_DynamicBBPowerSavingInit(struct odm_dm_struct *pDM_Odm)
 {
 	struct rtl_ps *pDM_PSTable = &pDM_Odm->DM_PSTable;
 
-	pDM_PSTable->PreCCAState = CCA_MAX;
-	pDM_PSTable->CurCCAState = CCA_MAX;
-	pDM_PSTable->PreRFState = RF_MAX;
-	pDM_PSTable->CurRFState = RF_MAX;
-	pDM_PSTable->Rssi_val_min = 0;
+	pDM_PSTable->pre_cca_state = CCA_MAX;
+	pDM_PSTable->cur_cca_state = CCA_MAX;
+	pDM_PSTable->pre_rf_state = RF_MAX;
+	pDM_PSTable->cur_rf_state = RF_MAX;
+	pDM_PSTable->rssi_val_min = 0;
 	pDM_PSTable->initialize = 0;
 }
 
@@ -954,23 +954,23 @@ void odm_1R_CCA(struct odm_dm_struct *pDM_Odm)
 	struct rtl_ps *pDM_PSTable = &pDM_Odm->DM_PSTable;
 
 	if (pDM_Odm->RSSI_Min != 0xFF) {
-		if (pDM_PSTable->PreCCAState == CCA_2R) {
+		if (pDM_PSTable->pre_cca_state == CCA_2R) {
 			if (pDM_Odm->RSSI_Min >= 35)
-				pDM_PSTable->CurCCAState = CCA_1R;
+				pDM_PSTable->cur_cca_state = CCA_1R;
 			else
-				pDM_PSTable->CurCCAState = CCA_2R;
+				pDM_PSTable->cur_cca_state = CCA_2R;
 		} else {
 			if (pDM_Odm->RSSI_Min <= 30)
-				pDM_PSTable->CurCCAState = CCA_2R;
+				pDM_PSTable->cur_cca_state = CCA_2R;
 			else
-				pDM_PSTable->CurCCAState = CCA_1R;
+				pDM_PSTable->cur_cca_state = CCA_1R;
 		}
 	} else {
-		pDM_PSTable->CurCCAState = CCA_MAX;
+		pDM_PSTable->cur_cca_state = CCA_MAX;
 	}
 
-	if (pDM_PSTable->PreCCAState != pDM_PSTable->CurCCAState) {
-		if (pDM_PSTable->CurCCAState == CCA_1R) {
+	if (pDM_PSTable->pre_cca_state != pDM_PSTable->cur_cca_state) {
+		if (pDM_PSTable->cur_cca_state == CCA_1R) {
 			if (pDM_Odm->RFType == ODM_2T2R)
 				ODM_SetBBReg(pDM_Odm, 0xc04, bMaskByte0, 0x13);
 			else
@@ -978,7 +978,7 @@ void odm_1R_CCA(struct odm_dm_struct *pDM_Odm)
 		} else {
 			ODM_SetBBReg(pDM_Odm, 0xc04, bMaskByte0, 0x33);
 		}
-		pDM_PSTable->PreCCAState = pDM_PSTable->CurCCAState;
+		pDM_PSTable->pre_cca_state = pDM_PSTable->cur_cca_state;
 	}
 }
 
@@ -993,35 +993,35 @@ void ODM_RF_Saving(struct odm_dm_struct *pDM_Odm, u8 bForceInNormal)
 		Rssi_Low_bound = 45;
 	}
 	if (pDM_PSTable->initialize == 0) {
-		pDM_PSTable->Reg874 = (ODM_GetBBReg(pDM_Odm, 0x874, bMaskDWord) & 0x1CC000) >> 14;
-		pDM_PSTable->RegC70 = (ODM_GetBBReg(pDM_Odm, 0xc70, bMaskDWord) & BIT(3)) >> 3;
-		pDM_PSTable->Reg85C = (ODM_GetBBReg(pDM_Odm, 0x85c, bMaskDWord) & 0xFF000000) >> 24;
-		pDM_PSTable->RegA74 = (ODM_GetBBReg(pDM_Odm, 0xa74, bMaskDWord) & 0xF000) >> 12;
+		pDM_PSTable->reg_874 = (ODM_GetBBReg(pDM_Odm, 0x874, bMaskDWord) & 0x1CC000) >> 14;
+		pDM_PSTable->reg_c70 = (ODM_GetBBReg(pDM_Odm, 0xc70, bMaskDWord) & BIT(3)) >> 3;
+		pDM_PSTable->reg_85c = (ODM_GetBBReg(pDM_Odm, 0x85c, bMaskDWord) & 0xFF000000) >> 24;
+		pDM_PSTable->reg_a74 = (ODM_GetBBReg(pDM_Odm, 0xa74, bMaskDWord) & 0xF000) >> 12;
 		pDM_PSTable->initialize = 1;
 	}
 
 	if (!bForceInNormal) {
 		if (pDM_Odm->RSSI_Min != 0xFF) {
-			if (pDM_PSTable->PreRFState == RF_Normal) {
+			if (pDM_PSTable->pre_rf_state == RF_Normal) {
 				if (pDM_Odm->RSSI_Min >= Rssi_Up_bound)
-					pDM_PSTable->CurRFState = RF_Save;
+					pDM_PSTable->cur_rf_state = RF_Save;
 				else
-					pDM_PSTable->CurRFState = RF_Normal;
+					pDM_PSTable->cur_rf_state = RF_Normal;
 			} else {
 				if (pDM_Odm->RSSI_Min <= Rssi_Low_bound)
-					pDM_PSTable->CurRFState = RF_Normal;
+					pDM_PSTable->cur_rf_state = RF_Normal;
 				else
-					pDM_PSTable->CurRFState = RF_Save;
+					pDM_PSTable->cur_rf_state = RF_Save;
 			}
 		} else {
-			pDM_PSTable->CurRFState = RF_MAX;
+			pDM_PSTable->cur_rf_state = RF_MAX;
 		}
 	} else {
-		pDM_PSTable->CurRFState = RF_Normal;
+		pDM_PSTable->cur_rf_state = RF_Normal;
 	}
 
-	if (pDM_PSTable->PreRFState != pDM_PSTable->CurRFState) {
-		if (pDM_PSTable->CurRFState == RF_Save) {
+	if (pDM_PSTable->pre_rf_state != pDM_PSTable->cur_rf_state) {
+		if (pDM_PSTable->cur_rf_state == RF_Save) {
 			/*  <tynli_note> 8723 RSSI report will be wrong. Set 0x874[5]=1 when enter BB power saving mode. */
 			/*  Suggested by SD3 Yu-Nan. 2011.01.20. */
 			if (pDM_Odm->SupportICType == ODM_RTL8723A)
@@ -1034,16 +1034,16 @@ void ODM_RF_Saving(struct odm_dm_struct *pDM_Odm, u8 bForceInNormal)
 			ODM_SetBBReg(pDM_Odm, 0x818, BIT(28), 0x0); /* Reg818[28]=1'b0 */
 			ODM_SetBBReg(pDM_Odm, 0x818, BIT(28), 0x1); /* Reg818[28]=1'b1 */
 		} else {
-			ODM_SetBBReg(pDM_Odm, 0x874, 0x1CC000, pDM_PSTable->Reg874);
-			ODM_SetBBReg(pDM_Odm, 0xc70, BIT(3), pDM_PSTable->RegC70);
-			ODM_SetBBReg(pDM_Odm, 0x85c, 0xFF000000, pDM_PSTable->Reg85C);
-			ODM_SetBBReg(pDM_Odm, 0xa74, 0xF000, pDM_PSTable->RegA74);
+			ODM_SetBBReg(pDM_Odm, 0x874, 0x1CC000, pDM_PSTable->reg_874);
+			ODM_SetBBReg(pDM_Odm, 0xc70, BIT(3), pDM_PSTable->reg_c70);
+			ODM_SetBBReg(pDM_Odm, 0x85c, 0xFF000000, pDM_PSTable->reg_85c);
+			ODM_SetBBReg(pDM_Odm, 0xa74, 0xF000, pDM_PSTable->reg_a74);
 			ODM_SetBBReg(pDM_Odm, 0x818, BIT(28), 0x0);
 
 			if (pDM_Odm->SupportICType == ODM_RTL8723A)
 				ODM_SetBBReg(pDM_Odm, 0x874, BIT(5), 0x0); /* Reg874[5]=1b'0 */
 		}
-		pDM_PSTable->PreRFState = pDM_PSTable->CurRFState;
+		pDM_PSTable->pre_rf_state = pDM_PSTable->cur_rf_state;
 	}
 }
 
diff --git a/drivers/staging/r8188eu/include/odm.h b/drivers/staging/r8188eu/include/odm.h
index ee051e053ac6..d9041ee576bb 100644
--- a/drivers/staging/r8188eu/include/odm.h
+++ b/drivers/staging/r8188eu/include/odm.h
@@ -123,16 +123,19 @@ struct rtw_dig {
 };
 
 struct rtl_ps {
-	u8		PreCCAState;
-	u8		CurCCAState;
+	u8		pre_cca_state;
+	u8		cur_cca_state;
 
-	u8		PreRFState;
-	u8		CurRFState;
+	u8		pre_rf_state;
+	u8		cur_rf_state;
 
-	int		    Rssi_val_min;
+	int		rssi_val_min;
 
 	u8		initialize;
-	u32		Reg874,RegC70,Reg85C,RegA74;
+	u32		reg_874;
+	u32		reg_c70;
+	u32		reg_85c;
+	u32		reg_a74;
 
 };
 
-- 
2.32.0

