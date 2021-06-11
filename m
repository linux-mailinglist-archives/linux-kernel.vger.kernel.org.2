Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0303A38B0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 02:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbhFKA2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 20:28:25 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:41683 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbhFKA2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 20:28:24 -0400
Received: by mail-wr1-f41.google.com with SMTP id o3so4120153wri.8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 17:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xGuPSUB9sCPvLS2yL88leKFZzO4c9wu8DLnphDQRpqw=;
        b=cFMupHMKnruXkRVbF+vCCVuajn1IDPRjYMGeZ0gRC/R8wagg0h7fVZB/cDHW+fD3Wb
         ln+y2tEtMsCTdOuuBuLSphorMpcMFakUqEbzw/iICgzDEwMY53kRWGQwm4WBGvRnVjHp
         lLAyOQxo6x70MG9S5zJPbqbuXPRmSRzatKFUVgC1iYfwIfP3mA38GEVyHQEC6kxIRYI3
         EZ+iqgB4IzIQFC3l8pEXWA7XTsOpoVKTjfzKkjGUgTiBI1i4b/uOQQD+ZJ9DjuHr0Jtv
         IvdOcprAmniWXM6OyNszp+xW20svhw/O5Phc5YFQXp23Ik6rj64If4CpQIGY6G1XioYm
         0r7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xGuPSUB9sCPvLS2yL88leKFZzO4c9wu8DLnphDQRpqw=;
        b=CdzDvGnK/sRJRVuxRe/vkR5UNXIYy6RY+key/BciyQu+NYQ8wx4sF/X55B4k4BBsxN
         W4KYTlCa0uLTYPnVWGEvE742cRdpFMikWJF44Tg/ne/TyDLr+LwGGqVxCFkMiqAkpwmQ
         fy9ThVXoU7415330FRHj0ZhT1NuYWig9awFZX2ZKQH2TiNEVu1Iab+jw17qBD27j3AoI
         yMmJLNhuKnRSozzW8d17gJ+HaDIqnlUSV69MIHCRkyHizzkXisTDNRAcvn9nuj7utbQr
         0qMyg/nNbZ4S8sVoo8kyHgAyGgEaX+su6F8913NqMzFN0PIdt0444Y7QsjkniZejSUSl
         XvEw==
X-Gm-Message-State: AOAM5304JdlFG3igBEYISlO8WLZ/DY+Pj1Vw3BnIa480/sqDRkiUJiKk
        aGPQPHbaomPscaMzgbQBre26HQ==
X-Google-Smtp-Source: ABdhPJwJeHUbhPpwXPJs8XovzHcTqzE9JFPHXej9JoYnitj9PqpW23zGDIOnfWajBH8YJmzEc5ue8g==
X-Received: by 2002:adf:d1cd:: with SMTP id b13mr897643wrd.317.1623371113380;
        Thu, 10 Jun 2021 17:25:13 -0700 (PDT)
Received: from localhost.localdomain (2.0.5.1.1.6.3.8.5.c.c.3.f.b.d.3.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16:0:3dbf:3cc5:8361:1502])
        by smtp.gmail.com with ESMTPSA id c2sm11386189wmf.24.2021.06.10.17.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 17:25:12 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, straube.linux@gmail.com,
        kaixuxia@tencent.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, liushixin2@huawei.com,
        unixbhaskar@gmail.com, gustavoars@kernel.org, martin@kaiser.cx,
        bkkarthik@pesu.pes.edu, dan.carpenter@oracle.com
Subject: [PATCH 5/6] staging: rtl8188eu: remove DebugComponents/DebugLevel from odm_dm_struct
Date:   Fri, 11 Jun 2021 01:25:03 +0100
Message-Id: <20210611002504.166405-6-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210611002504.166405-5-phil@philpotter.co.uk>
References: <20210611002504.166405-1-phil@philpotter.co.uk>
 <20210611002504.166405-2-phil@philpotter.co.uk>
 <20210611002504.166405-3-phil@philpotter.co.uk>
 <20210611002504.166405-4-phil@philpotter.co.uk>
 <20210611002504.166405-5-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove DebugComponents and DebugLevel fields from the struct odm_dm_struct
definition in include/odm.h, and remove the function ODM_InitDebugSetting
from hal/odm.c along with all lines where it is called. This function
just sets these two fields. Lastly, remove a few unused variable declarations.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/rtl8188eu/hal/odm.c         | 9 ---------
 drivers/staging/rtl8188eu/hal/phy.c         | 2 --
 drivers/staging/rtl8188eu/hal/rtl8188e_dm.c | 2 --
 drivers/staging/rtl8188eu/hal/usb_halinit.c | 5 -----
 drivers/staging/rtl8188eu/include/odm.h     | 2 --
 5 files changed, 20 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/odm.c b/drivers/staging/rtl8188eu/hal/odm.c
index 53959d310b47..9febdc91b66a 100644
--- a/drivers/staging/rtl8188eu/hal/odm.c
+++ b/drivers/staging/rtl8188eu/hal/odm.c
@@ -149,13 +149,6 @@ u8 CCKSwingTable_Ch14[CCK_TABLE_SIZE][8] = {
 #define		RxDefaultAnt1		0x65a9
 #define	RxDefaultAnt2		0x569a
 
-void ODM_InitDebugSetting(struct odm_dm_struct *pDM_Odm)
-{
-	pDM_Odm->DebugLevel = ODM_DBG_TRACE;
-
-	pDM_Odm->DebugComponents = 0;
-}
-
 /* 3 Export Interface */
 
 /*  2011/09/21 MH Add to describe different team necessary resource allocate?? */
@@ -216,8 +209,6 @@ void odm_CommonInfoSelfInit(struct odm_dm_struct *pDM_Odm)
 
 	pDM_Odm->bCckHighPower = (bool)phy_query_bb_reg(adapter, 0x824, BIT(9));
 	pDM_Odm->RFPathRxEnable = (u8)phy_query_bb_reg(adapter, 0xc04, 0x0F);
-
-	ODM_InitDebugSetting(pDM_Odm);
 }
 
 void odm_CommonInfoSelfUpdate(struct odm_dm_struct *pDM_Odm)
diff --git a/drivers/staging/rtl8188eu/hal/phy.c b/drivers/staging/rtl8188eu/hal/phy.c
index 34079275e57c..5d9ad09ced70 100644
--- a/drivers/staging/rtl8188eu/hal/phy.c
+++ b/drivers/staging/rtl8188eu/hal/phy.c
@@ -546,7 +546,6 @@ static u8 phy_path_a_rx_iqk(struct adapter *adapt, bool configPathB)
 {
 	u32 reg_eac, reg_e94, reg_e9c, reg_ea4, u4tmp;
 	u8 result = 0x00;
-	struct odm_dm_struct *dm_odm = &adapt->HalData->odmpriv;
 
 	/* 1 Get TXIMR setting */
 	/* modify RXIQK mode table */
@@ -645,7 +644,6 @@ static u8 phy_path_b_iqk(struct adapter *adapt)
 {
 	u32 regeac, regeb4, regebc, regec4, regecc;
 	u8 result = 0x00;
-	struct odm_dm_struct *dm_odm = &adapt->HalData->odmpriv;
 
 	/* One shot, path B LOK & IQK */
 	phy_set_bb_reg(adapt, rIQK_AGC_Cont, bMaskDWord, 0x00000002);
diff --git a/drivers/staging/rtl8188eu/hal/rtl8188e_dm.c b/drivers/staging/rtl8188eu/hal/rtl8188e_dm.c
index 391c59490718..10e88f976163 100644
--- a/drivers/staging/rtl8188eu/hal/rtl8188e_dm.c
+++ b/drivers/staging/rtl8188eu/hal/rtl8188e_dm.c
@@ -165,11 +165,9 @@ void rtw_hal_dm_watchdog(struct adapter *Adapter)
 void rtw_hal_dm_init(struct adapter *Adapter)
 {
 	struct dm_priv *pdmpriv = &Adapter->HalData->dmpriv;
-	struct odm_dm_struct *podmpriv = &Adapter->HalData->odmpriv;
 
 	memset(pdmpriv, 0, sizeof(struct dm_priv));
 	Init_ODM_ComInfo_88E(Adapter);
-	ODM_InitDebugSetting(podmpriv);
 }
 
 /*  Add new function to reset the state of antenna diversity before link. */
diff --git a/drivers/staging/rtl8188eu/hal/usb_halinit.c b/drivers/staging/rtl8188eu/hal/usb_halinit.c
index 80cdcf6f7879..3e7f184ed39a 100644
--- a/drivers/staging/rtl8188eu/hal/usb_halinit.c
+++ b/drivers/staging/rtl8188eu/hal/usb_halinit.c
@@ -1851,11 +1851,6 @@ u8 rtw_hal_get_def_var(struct adapter *Adapter, enum hal_def_variable eVariable,
 		}
 		break;
 	case HW_DEF_ODM_DBG_FLAG:
-		{
-			struct odm_dm_struct *dm_ocm = &haldata->odmpriv;
-
-			pr_info("dm_ocm->DebugComponents = 0x%llx\n", dm_ocm->DebugComponents);
-		}
 		break;
 	case HAL_DEF_DBG_DUMP_RXPKT:
 		*((u8 *)pValue) = haldata->bDumpRxPkt;
diff --git a/drivers/staging/rtl8188eu/include/odm.h b/drivers/staging/rtl8188eu/include/odm.h
index d814ce492424..98402cfb1168 100644
--- a/drivers/staging/rtl8188eu/include/odm.h
+++ b/drivers/staging/rtl8188eu/include/odm.h
@@ -691,8 +691,6 @@ struct odm_dm_struct {
 	bool	odm_ready;
 
 	struct rtl8192cd_priv *fake_priv;
-	u64	DebugComponents;
-	u32	DebugLevel;
 
 /*  ODM HANDLE, DRIVER NEEDS NOT TO HOOK------ */
 	bool	bCckHighPower;
-- 
2.30.2

