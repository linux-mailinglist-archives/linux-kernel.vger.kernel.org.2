Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7194234474E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 15:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbhCVOdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 10:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbhCVOcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 10:32:32 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 657CEC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 07:32:31 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id ce10so21628922ejb.6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 07:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YLMtNnT3e6GvAIhoidxNIb4VuJXw+DLUdbOqSYM6/t4=;
        b=CdJjWq4UHDY/vooDiXd3hFEy31e3/ROZp3MoFcNi03Eyf5GJ0nWXjqytWJc528i1CM
         p4jtdaiCg/w0yRuoqDhlvjf/nA1Imtxx99FGj2l2lTJXsVbhcxA0wzthMhX5F6jbTyNU
         wz+PQ05nDXfnP3i1nM9eqM6AuLRn3xQwd0giLDq+FGkTEvvJZye12sYHXvfMT8YEtGVe
         8WhKmr6lH0I/8p+88JLoxzEEddHcq32sZbjToHVHcJpfm4gYdK35FTiXBgq/IjlE5HQg
         0kQTla/kYMIa0WkfRKW2kCGekaP/QNXB5Nt9+VZukPH0wYkxZujDLzXDmTwovCqwtBL8
         V60A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YLMtNnT3e6GvAIhoidxNIb4VuJXw+DLUdbOqSYM6/t4=;
        b=Hj7NaD8EGIrGxDCAOQVsVa4f3QhXUkYHHS+3e5uktKIQrYrCAhf27H9ci8L5t8f+0q
         zCR+wjkpcyAnqndy5Qh/o92FFAv0KzZzKFeQKwkfj5yfLNReBwLsZ3YUn54R6b8UEE9T
         ZmxIkV0+JflTwDE9/zWCFKv1CyrhTUipFdod0A1NjmYP+N8kR9mC/JEBfm7V8g14Prfo
         LpZzB3wa7w2TW+WMGOdLVZU8iseG18pNU0vWQdZiqNBT3nYK4ubxvB51iQYb2IjrwHUS
         CL+wDAEEf2JpO4HldelJ+Ty6OdgN2NKtmPAMcF5Xdu+mEmHFfA/vkmAqy805+lKOxUoi
         ZWqw==
X-Gm-Message-State: AOAM533MquXBdbiGsqBBhB0w7/Y/6s+Gv1FfEAo7yLCga6CMxL8oRmA3
        A0GLUwksYI0Hyg8aj/hJ43E=
X-Google-Smtp-Source: ABdhPJyG7iox4/GiXK1ZM8ksBlVtJuSVh1flw51HprQRcyqEwjZUN1sZ/2NucObxgHvhX4lMuwb0DQ==
X-Received: by 2002:a17:907:9152:: with SMTP id l18mr39979ejs.376.1616423550188;
        Mon, 22 Mar 2021 07:32:30 -0700 (PDT)
Received: from agape ([151.57.176.11])
        by smtp.gmail.com with ESMTPSA id k12sm11564768edr.60.2021.03.22.07.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 07:32:29 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, apw@canonical.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 08/11] staging: rtl8723bs: move function prototypes out of hal/odm.c
Date:   Mon, 22 Mar 2021 15:31:46 +0100
Message-Id: <efbd319bc6199fbb06d6c4996ae2d9b81d2f6922.1616422773.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1616422773.git.fabioaiuto83@gmail.com>
References: <cover.1616422773.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix the following checkpatch issues:

WARNING: externs should be avoided in .c files
285: FILE: drivers/staging/rtl8723bs/hal/odm.c:285:
+void odm_CommonInfoSelfInit(struct dm_odm_t *pDM_Odm);
--
WARNING: externs should be avoided in .c files
287: FILE: drivers/staging/rtl8723bs/hal/odm.c:287:
+void odm_CommonInfoSelfUpdate(struct dm_odm_t *pDM_Odm);
--
WARNING: externs should be avoided in .c files
289: FILE: drivers/staging/rtl8723bs/hal/odm.c:289:
+void odm_CmnInfoInit_Debug(struct dm_odm_t *pDM_Odm);
--
WARNING: externs should be avoided in .c files
291: FILE: drivers/staging/rtl8723bs/hal/odm.c:291:
+void odm_BasicDbgMessage(struct dm_odm_t *pDM_Odm);
--
WARNING: externs should be avoided in .c files
305: FILE: drivers/staging/rtl8723bs/hal/odm.c:305:
+void odm_RefreshRateAdaptiveMaskCE(struct dm_odm_t *pDM_Odm);
--
WARNING: externs should be avoided in .c files
309: FILE: drivers/staging/rtl8723bs/hal/odm.c:309:
+void odm_RSSIMonitorInit(struct dm_odm_t *pDM_Odm);
--
WARNING: externs should be avoided in .c files
311: FILE: drivers/staging/rtl8723bs/hal/odm.c:311:
+void odm_RSSIMonitorCheckCE(struct dm_odm_t *pDM_Odm);
--
WARNING: externs should be avoided in .c files
313: FILE: drivers/staging/rtl8723bs/hal/odm.c:313:
+void odm_RSSIMonitorCheck(struct dm_odm_t *pDM_Odm);
--
WARNING: externs should be avoided in .c files
315: FILE: drivers/staging/rtl8723bs/hal/odm.c:315:
+void odm_SwAntDetectInit(struct dm_odm_t *pDM_Odm);
--
WARNING: externs should be avoided in .c files
317: FILE: drivers/staging/rtl8723bs/hal/odm.c:317:
+void odm_SwAntDivChkAntSwitchCallback(void *FunctionContext);
--
WARNING: externs should be avoided in .c files
321: FILE: drivers/staging/rtl8723bs/hal/odm.c:321:
+void odm_GlobalAdapterCheck(void);
--
WARNING: externs should be avoided in .c files
323: FILE: drivers/staging/rtl8723bs/hal/odm.c:323:
+void odm_RefreshRateAdaptiveMask(struct dm_odm_t *pDM_Odm);
--
WARNING: externs should be avoided in .c files
325: FILE: drivers/staging/rtl8723bs/hal/odm.c:325:
+void ODM_TXPowerTrackingCheck(struct dm_odm_t *pDM_Odm);
--
WARNING: externs should be avoided in .c files
327: FILE: drivers/staging/rtl8723bs/hal/odm.c:327:
+void odm_RateAdaptiveMaskInit(struct dm_odm_t *pDM_Odm);
--
WARNING: externs should be avoided in .c files
330: FILE: drivers/staging/rtl8723bs/hal/odm.c:330:
+void odm_TXPowerTrackingInit(struct dm_odm_t *pDM_Odm);
--
WARNING: externs should be avoided in .c files
338: FILE: drivers/staging/rtl8723bs/hal/odm.c:338:
+void odm_InitHybridAntDiv(struct dm_odm_t *pDM_Odm);
--
WARNING: externs should be avoided in .c files
340: FILE: drivers/staging/rtl8723bs/hal/odm.c:340:
+bool odm_StaDefAntSel(
--
WARNING: externs should be avoided in .c files
349: FILE: drivers/staging/rtl8723bs/hal/odm.c:349:
+void odm_SetRxIdleAnt(struct dm_odm_t *pDM_Odm, u8 Ant, bool bDualPath);
--
WARNING: externs should be avoided in .c files
353: FILE: drivers/staging/rtl8723bs/hal/odm.c:353:
+void odm_HwAntDiv(struct dm_odm_t *pDM_Odm);

moved function prototypes in hal/odm.h

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/odm.c | 68 -----------------------------
 drivers/staging/rtl8723bs/hal/odm.h | 62 ++++++++++++++++++++++++++
 2 files changed, 62 insertions(+), 68 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/odm.c b/drivers/staging/rtl8723bs/hal/odm.c
index 49d552105a65..1ede10f0b9da 100644
--- a/drivers/staging/rtl8723bs/hal/odm.c
+++ b/drivers/staging/rtl8723bs/hal/odm.c
@@ -279,80 +279,12 @@ u32 TxScalingTable_Jaguar[TXSCALE_TABLE_SIZE] = {
 	0x3FE  /*  36, +6.0dB */
 };
 
-/*  Local Function predefine. */
-
-/* START------------COMMON INFO RELATED--------------- */
-void odm_CommonInfoSelfInit(struct dm_odm_t *pDM_Odm);
-
-void odm_CommonInfoSelfUpdate(struct dm_odm_t *pDM_Odm);
-
-void odm_CmnInfoInit_Debug(struct dm_odm_t *pDM_Odm);
-
-void odm_BasicDbgMessage(struct dm_odm_t *pDM_Odm);
-
-/* END------------COMMON INFO RELATED--------------- */
-
-/* START---------------DIG--------------------------- */
-
-/* Remove by Yuchen */
-
-/* END---------------DIG--------------------------- */
-
-/* START-------BB POWER SAVE----------------------- */
-/* Remove BB power Saving by YuChen */
-/* END---------BB POWER SAVE----------------------- */
-
-void odm_RefreshRateAdaptiveMaskCE(struct dm_odm_t *pDM_Odm);
-
-/* Remove by YuChen */
-
-void odm_RSSIMonitorInit(struct dm_odm_t *pDM_Odm);
-
-void odm_RSSIMonitorCheckCE(struct dm_odm_t *pDM_Odm);
-
-void odm_RSSIMonitorCheck(struct dm_odm_t *pDM_Odm);
-
-void odm_SwAntDetectInit(struct dm_odm_t *pDM_Odm);
-
-void odm_SwAntDivChkAntSwitchCallback(void *FunctionContext);
-
-
-
-void odm_GlobalAdapterCheck(void);
-
-void odm_RefreshRateAdaptiveMask(struct dm_odm_t *pDM_Odm);
-
-void ODM_TXPowerTrackingCheck(struct dm_odm_t *pDM_Odm);
-
-void odm_RateAdaptiveMaskInit(struct dm_odm_t *pDM_Odm);
-
-
-void odm_TXPowerTrackingInit(struct dm_odm_t *pDM_Odm);
-
 /* Remove Edca by Yu Chen */
 
 
 #define RxDefaultAnt1		0x65a9
 #define RxDefaultAnt2		0x569a
 
-void odm_InitHybridAntDiv(struct dm_odm_t *pDM_Odm);
-
-bool odm_StaDefAntSel(
-	struct dm_odm_t *pDM_Odm,
-	u32 OFDM_Ant1_Cnt,
-	u32 OFDM_Ant2_Cnt,
-	u32 CCK_Ant1_Cnt,
-	u32 CCK_Ant2_Cnt,
-	u8 *pDefAnt
-);
-
-void odm_SetRxIdleAnt(struct dm_odm_t *pDM_Odm, u8 Ant, bool bDualPath);
-
-
-
-void odm_HwAntDiv(struct dm_odm_t *pDM_Odm);
-
-
 /*  */
 /* 3 Export Interface */
 /*  */
diff --git a/drivers/staging/rtl8723bs/hal/odm.h b/drivers/staging/rtl8723bs/hal/odm.h
index 3c8d76e42c99..42fb01aa15cd 100644
--- a/drivers/staging/rtl8723bs/hal/odm.h
+++ b/drivers/staging/rtl8723bs/hal/odm.h
@@ -1429,4 +1429,66 @@ void ODM_AntselStatistics_88C(
 
 void ODM_DynamicARFBSelect(struct dm_odm_t *pDM_Odm, u8 rate, bool Collision_State);
 
+/*  Local Function predefine. */
+
+/* START------------COMMON INFO RELATED--------------- */
+void odm_CommonInfoSelfInit(struct dm_odm_t *pDM_Odm);
+
+void odm_CommonInfoSelfUpdate(struct dm_odm_t *pDM_Odm);
+
+void odm_CmnInfoInit_Debug(struct dm_odm_t *pDM_Odm);
+
+void odm_BasicDbgMessage(struct dm_odm_t *pDM_Odm);
+
+/* END------------COMMON INFO RELATED--------------- */
+
+/* START---------------DIG--------------------------- */
+
+/* Remove by Yuchen */
+
+/* END---------------DIG--------------------------- */
+
+/* START-------BB POWER SAVE----------------------- */
+/* Remove BB power Saving by YuChen */
+/* END---------BB POWER SAVE----------------------- */
+
+void odm_RefreshRateAdaptiveMaskCE(struct dm_odm_t *pDM_Odm);
+
+/* Remove by YuChen */
+
+void odm_RSSIMonitorInit(struct dm_odm_t *pDM_Odm);
+
+void odm_RSSIMonitorCheckCE(struct dm_odm_t *pDM_Odm);
+
+void odm_RSSIMonitorCheck(struct dm_odm_t *pDM_Odm);
+
+void odm_SwAntDetectInit(struct dm_odm_t *pDM_Odm);
+
+void odm_SwAntDivChkAntSwitchCallback(void *FunctionContext);
+
+void odm_GlobalAdapterCheck(void);
+
+void odm_RefreshRateAdaptiveMask(struct dm_odm_t *pDM_Odm);
+
+void ODM_TXPowerTrackingCheck(struct dm_odm_t *pDM_Odm);
+
+void odm_RateAdaptiveMaskInit(struct dm_odm_t *pDM_Odm);
+
+void odm_TXPowerTrackingInit(struct dm_odm_t *pDM_Odm);
+
+void odm_InitHybridAntDiv(struct dm_odm_t *pDM_Odm);
+
+bool odm_StaDefAntSel(
+	struct dm_odm_t *pDM_Odm,
+	u32 OFDM_Ant1_Cnt,
+	u32 OFDM_Ant2_Cnt,
+	u32 CCK_Ant1_Cnt,
+	u32 CCK_Ant2_Cnt,
+	u8 *pDefAnt
+);
+
+void odm_SetRxIdleAnt(struct dm_odm_t *pDM_Odm, u8 Ant, bool bDualPath);
+
+void odm_HwAntDiv(struct dm_odm_t *pDM_Odm);
+
 #endif
-- 
2.20.1

