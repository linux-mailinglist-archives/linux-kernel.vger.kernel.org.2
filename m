Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF2736F681
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 09:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbhD3HpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 03:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbhD3Ho5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 03:44:57 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F93CC06138D
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 00:44:09 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id gx5so11746114ejb.11
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 00:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1TVYammkl8ZNcJo8mdkE77hHWM+9bJ8+VczMb0ee9es=;
        b=bzKRCVMLK88LizVU5lmNEwDltR5jk1qPMd66xSrjkxc6YfpZe88Nx0ff0pz6GVlBE/
         FskFuoSINl/LHvCXGEhx13abfhPMR2Q70ejsU7rxepiOT/W4E/zvMjDcp0OUlH0q/woB
         oFaqONEReJMEJIS5G36E/YFVUq9YX0yOW4/XUfW/cAmT+2zZwVCRKln+dZYOjAOOrrUE
         0dhf3qCesdOgRDobwH8i5RVKFCGBzDP0EogCeU6POFON91JL9mAX5mAUb0KEGgx0xPaZ
         Z0wvoEVF0mlnjmu6eedZiUvFzWPEGsvQU39zNYcBVkkckeJP/fvRwljsGeYRCe88Xme5
         K0fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1TVYammkl8ZNcJo8mdkE77hHWM+9bJ8+VczMb0ee9es=;
        b=rflORiqpdFTpRReroh0GTy3mau3hVlrsIPkviRisNzLqj3V3mGMYkrvhS1BuXYockU
         /SQ6SRlqQ/+AR1wOLUkjUG3gIkGN1gGGSLSoV3pAsZgNzQ3BTtO6HSlG2FIQR12E/rm/
         K4hQvBlO8gka9UjhwG2VCvstPbZBxyk9C9Kh6sW2ZXsvswpJzh603GUbmwPKizjKvGzQ
         Le+kV24nygKs0DTcfR7GNMxHgrhSxaZ2v6iggTMrLQwxe8jSJZNJAaELtJz1SE0pZLUF
         eHxi5IaLlp7pcQvEAVRs4AL1cKe2TRruP3iiwKS4Ait1qD5stq8ScxsQ5L4e2cXP9V1q
         z4Aw==
X-Gm-Message-State: AOAM533t8VqMAjBfeVrGviRP1z+H4UG+8cb3GjRgdZ1Mx2nJz+euL+zb
        IWBO/OygpAqvvM7/n+H29Dh/uTs289/+vg==
X-Google-Smtp-Source: ABdhPJz/5GHQL0uW+g9McryCz3fXBQz+3IvAXcmDd5OMNhWH3qUZ0jlZP4S4/dr+kj5RoKaUHeviuA==
X-Received: by 2002:a17:907:9691:: with SMTP id hd17mr2805861ejc.67.1619768647754;
        Fri, 30 Apr 2021 00:44:07 -0700 (PDT)
Received: from agape ([5.171.81.86])
        by smtp.gmail.com with ESMTPSA id e11sm644334edq.76.2021.04.30.00.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 00:44:07 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 02/43] staging: rlt8723bs: remove if-else blocks left empty by ODM_RT_TRACE deletion
Date:   Fri, 30 Apr 2021 09:43:20 +0200
Message-Id: <646608de41fb1ef915834a33453b0a99907d46b0.1619768150.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619768150.git.fabioaiuto83@gmail.com>
References: <cover.1619768150.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove if-else blocks left empty by ODM_RT_TRACE deletion.
remove unused variables to suppress compiler warnings.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/HalPhyRf.c       | 13 -------------
 drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c |  9 +--------
 drivers/staging/rtl8723bs/hal/odm_PathDiv.c    |  8 --------
 3 files changed, 1 insertion(+), 29 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/HalPhyRf.c b/drivers/staging/rtl8723bs/hal/HalPhyRf.c
index 2e10817bf3dd..b8e385fdda89 100644
--- a/drivers/staging/rtl8723bs/hal/HalPhyRf.c
+++ b/drivers/staging/rtl8723bs/hal/HalPhyRf.c
@@ -118,9 +118,6 @@ void ODM_TXPowerTrackingCallback_ThermalMeter(struct adapter *Adapter)
 
 	/* 4 3. Initialize ThermalValues of RFCalibrateInfo */
 
-	if (pDM_Odm->RFCalibrateInfo.bReloadtxpowerindex)
-		{}
-
 	/* 4 4. Calculate average thermal meter */
 
 	pDM_Odm->RFCalibrateInfo.ThermalValue_AVG[pDM_Odm->RFCalibrateInfo.ThermalValue_AVG_index] = ThermalValue;
@@ -273,16 +270,6 @@ void ODM_TXPowerTrackingCallback_ThermalMeter(struct adapter *Adapter)
 		/*  to increase TX power. Otherwise, EVM will be bad. */
 		/*  */
 		/*  2012/04/25 MH Add for tx power tracking to set tx power in tx agc for 88E. */
-		if (ThermalValue > pDM_Odm->RFCalibrateInfo.ThermalValue) {
-			if (c.RfPathCount > 1)
-				{}
-
-		} else if (ThermalValue < pDM_Odm->RFCalibrateInfo.ThermalValue) { /*  Low temperature */
-
-			if (c.RfPathCount > 1)
-				{}
-
-		}
 
 		if (ThermalValue > pHalData->EEPROMThermalMeter) {
 			for (p = ODM_RF_PATH_A; p < c.RfPathCount; p++)
diff --git a/drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c b/drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c
index 471418f3f724..858aafc24931 100644
--- a/drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c
+++ b/drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c
@@ -689,8 +689,7 @@ static u8 phy_PathA_RxIQK8723B(
 		(tmp < 0xf)
 	)
 		result |= 0x02;
-	else							/* if Tx not OK, ignore Rx */
-		{}
+
 	return result;
 }
 
@@ -988,8 +987,6 @@ static u8 phy_PathB_RxIQK8723B(struct adapter *padapter, bool configPathB)
 		(tmp < 0xf)
 	)
 		result |= 0x02;
-	else
-		{}
 
 	return result;
 }
@@ -1500,7 +1497,6 @@ static void phy_IQCalibrate_8723B(
 				result[t][2] = (PHY_QueryBBReg(pDM_Odm->Adapter, rRx_Power_Before_IQK_A_2, bMaskDWord)&0x3FF0000)>>16;
 				result[t][3] = (PHY_QueryBBReg(pDM_Odm->Adapter, rRx_Power_After_IQK_A_2, bMaskDWord)&0x3FF0000)>>16;
 			break;
-		} else {
 		}
 	}
 
@@ -1533,13 +1529,10 @@ static void phy_IQCalibrate_8723B(
 				result[t][6] = (PHY_QueryBBReg(pDM_Odm->Adapter, rRx_Power_Before_IQK_A_2, bMaskDWord)&0x3FF0000)>>16;
 				result[t][7] = (PHY_QueryBBReg(pDM_Odm->Adapter, rRx_Power_After_IQK_A_2, bMaskDWord)&0x3FF0000)>>16;
 				break;
-			} else {
 			}
 		}
 
 /* Allen end */
-		if (0x00 == PathBOK) {
-		}
 	}
 
 	/* Back to BB mode, load original value */
diff --git a/drivers/staging/rtl8723bs/hal/odm_PathDiv.c b/drivers/staging/rtl8723bs/hal/odm_PathDiv.c
index cfcbc3741803..bedce2c10b22 100644
--- a/drivers/staging/rtl8723bs/hal/odm_PathDiv.c
+++ b/drivers/staging/rtl8723bs/hal/odm_PathDiv.c
@@ -9,16 +9,8 @@
 
 void odm_PathDiversityInit(void *pDM_VOID)
 {
-	struct dm_odm_t *pDM_Odm = (struct dm_odm_t *)pDM_VOID;
-
-	if (!(pDM_Odm->SupportAbility & ODM_BB_PATH_DIV))
-		{}
 }
 
 void odm_PathDiversity(void *pDM_VOID)
 {
-	struct dm_odm_t *pDM_Odm = (struct dm_odm_t *)pDM_VOID;
-
-	if (!(pDM_Odm->SupportAbility & ODM_BB_PATH_DIV))
-		{}
 }
-- 
2.20.1

