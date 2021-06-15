Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6B453A7D7A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 13:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbhFOLr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 07:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbhFOLrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 07:47:52 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78FE9C061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 04:45:47 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id g20so22164186ejt.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 04:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xVyB/BCtMWM6sV5DnGN0ei1zZX2/J6V90BxhlQfOPp0=;
        b=YGb6ZXAGvNsxAhwA47M8Sx1EBVlefl5Ixk/EUxrd+ohToRPlokhGx6cWVK0bj+qcEA
         /mAGJ+VtBOmSUvgXoyA/ZWhZiUl/MCWsnElAf9BKiChV0TP1zE0VtSbO/Lgnzda0DWJc
         L6HmTWgzF6M1r1MFncGxgJyp6DqRkfIkyosjgx7WcS4pJZ9y7q7eNXkiOnlRkVDihRrQ
         1BXx4ikCrR7n69X6FCn+ZiIBXVKzMrybzkjv8+GkWipAzXyCPk7eptWcA1wfjLSHQqVG
         OgZp4DkbcYcils5/jG6Q0+4hwhfIXNJP3lAOQtNEX9HJ93RmPZkcGowjj0ccRzaCrWro
         aIkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xVyB/BCtMWM6sV5DnGN0ei1zZX2/J6V90BxhlQfOPp0=;
        b=G/H5dvd6DRNlkVdYX5pjfaUTiH949E3uUPzUbWSoKwGCaJiMcJp187v7wHZuUmH113
         PNjg2XsPPGCdbMM1lyMzUqZNGz6N6cuwug8u3zGfonT7HKFAtOWSJq72GSnX3/dswag5
         crFulZbkX51LP4o0Q9kD5pQmtFW7InO/Ay7n8++ioa1NrLWFlpvmm2Fm/2ERv3tpkegh
         hUpdq+/QuPJHyOPsMKAAqGRmVR3y+d3riAZxvTG0Yg2tc9ZMVm/W+uwgjDsMBhoRTZ28
         JDDDGRHJ0O1ZGVabNGT1rxEmql8vG1fvEi3m6DVaqNteAlVTbzkbygVeefp2zeFDe8um
         1RYQ==
X-Gm-Message-State: AOAM530437BvHoep5ZNtUeWyUqCGShKeF27WE7gK97xlonhyfJcmafw5
        /aLGcnz/pRfew1FmcxfYblLhGrQicMciTA==
X-Google-Smtp-Source: ABdhPJyWZrqlS+U4bHvK3en1kBopC3hGlgssliN5wx1kFjwN3VsHqCObyx5Lnt+MO7tuCllJEVen0Q==
X-Received: by 2002:a17:906:85d5:: with SMTP id i21mr19940871ejy.360.1623757546017;
        Tue, 15 Jun 2021 04:45:46 -0700 (PDT)
Received: from agape ([5.171.72.142])
        by smtp.gmail.com with ESMTPSA id m12sm9702524ejc.65.2021.06.15.04.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 04:45:45 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] staging: rtl8723bs: remove unneeded DISABLE_BB_RF macro
Date:   Tue, 15 Jun 2021 13:45:34 +0200
Message-Id: <1a56a6b2f9f846197e8e25769ad86ad23e530047.1623756906.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1623756906.git.fabioaiuto83@gmail.com>
References: <cover.1623756906.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unneeded DISABLE_BB_RF macro.

This is just a symbolic constant used to disable
by hand-edit some core hardware capabilities which
we want to be always enabled. So just remove it.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c  |  7 -------
 drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c | 16 ----------------
 drivers/staging/rtl8723bs/hal/sdio_halinit.c    |  9 ---------
 drivers/staging/rtl8723bs/include/autoconf.h    | 15 +++------------
 drivers/staging/rtl8723bs/include/hal_phy.h     | 16 +++++-----------
 5 files changed, 8 insertions(+), 55 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c b/drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c
index 8b42b19cc089..1b0f47b58110 100644
--- a/drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c
+++ b/drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c
@@ -1656,9 +1656,6 @@ void PHY_IQCalibrate_8723B(
 	if (bSingleTone || bCarrierSuppression)
 		return;
 
-#if DISABLE_BB_RF
-	return;
-#endif
 	if (pDM_Odm->RFCalibrateInfo.bIQKInProgress)
 		return;
 
@@ -1845,10 +1842,6 @@ void PHY_LCCalibrate_8723B(struct dm_odm_t *pDM_Odm)
 	bool		bSingleTone = false, bCarrierSuppression = false;
 	u32 		timeout = 2000, timecount = 0;
 
-#if DISABLE_BB_RF
-	return;
-#endif
-
 	if (!(pDM_Odm->SupportAbility & ODM_RF_CALIBRATION))
 		return;
 
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c b/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
index 011b42e1b991..3a2e3d0e88e8 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
@@ -53,10 +53,6 @@ u32 PHY_QueryBBReg_8723B(struct adapter *Adapter, u32 RegAddr, u32 BitMask)
 {
 	u32 OriginalValue, BitShift;
 
-#if (DISABLE_BB_RF == 1)
-	return 0;
-#endif
-
 	OriginalValue = rtw_read32(Adapter, RegAddr);
 	BitShift = phy_CalculateBitShift(BitMask);
 
@@ -88,10 +84,6 @@ void PHY_SetBBReg_8723B(
 	/* u16 BBWaitCounter	= 0; */
 	u32 OriginalValue, BitShift;
 
-#if (DISABLE_BB_RF == 1)
-	return;
-#endif
-
 	if (BitMask != bMaskDWord) { /* if not "double word" write */
 		OriginalValue = rtw_read32(Adapter, RegAddr);
 		BitShift = phy_CalculateBitShift(BitMask);
@@ -252,10 +244,6 @@ u32 PHY_QueryRFReg_8723B(
 {
 	u32 Original_Value, BitShift;
 
-#if (DISABLE_BB_RF == 1)
-	return 0;
-#endif
-
 	Original_Value = phy_RFSerialRead_8723B(Adapter, eRFPath, RegAddr);
 	BitShift =  phy_CalculateBitShift(BitMask);
 
@@ -285,10 +273,6 @@ void PHY_SetRFReg_8723B(
 {
 	u32 Original_Value, BitShift;
 
-#if (DISABLE_BB_RF == 1)
-	return;
-#endif
-
 	/*  RF data is 12 bits only */
 	if (BitMask != bRFRegOffsetMask) {
 		Original_Value = phy_RFSerialRead_8723B(Adapter, eRFPath, RegAddr);
diff --git a/drivers/staging/rtl8723bs/hal/sdio_halinit.c b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
index a63f2f6bf7c1..38acde4be94d 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_halinit.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
@@ -560,11 +560,6 @@ static void _InitRFType(struct adapter *padapter)
 {
 	struct hal_com_data *pHalData = GET_HAL_DATA(padapter);
 
-#if	DISABLE_BB_RF
-	pHalData->rf_chip	= RF_PSEUDO_11N;
-	return;
-#endif
-
 	pHalData->rf_chip	= RF_6052;
 
 	pHalData->rf_type = RF_1T1R;
@@ -1035,11 +1030,7 @@ static void _ReadRFType(struct adapter *Adapter)
 {
 	struct hal_com_data *pHalData = GET_HAL_DATA(Adapter);
 
-#if DISABLE_BB_RF
-	pHalData->rf_chip = RF_PSEUDO_11N;
-#else
 	pHalData->rf_chip = RF_6052;
-#endif
 }
 
 
diff --git a/drivers/staging/rtl8723bs/include/autoconf.h b/drivers/staging/rtl8723bs/include/autoconf.h
index eab934229789..d1a97fea8065 100644
--- a/drivers/staging/rtl8723bs/include/autoconf.h
+++ b/drivers/staging/rtl8723bs/include/autoconf.h
@@ -12,16 +12,7 @@
  * Auto Config Section
  */
 #define LPS_RPWM_WAIT_MS 300
-#ifndef DISABLE_BB_RF
-#define DISABLE_BB_RF	0
-#endif
 
-#if DISABLE_BB_RF
-	#define HAL_MAC_ENABLE	0
-	#define HAL_BB_ENABLE		0
-	#define HAL_RF_ENABLE		0
-#else
-	#define HAL_MAC_ENABLE	1
-	#define HAL_BB_ENABLE		1
-	#define HAL_RF_ENABLE		1
-#endif
+#define HAL_MAC_ENABLE	1
+#define HAL_BB_ENABLE	1
+#define HAL_RF_ENABLE	1
diff --git a/drivers/staging/rtl8723bs/include/hal_phy.h b/drivers/staging/rtl8723bs/include/hal_phy.h
index 521eb1c2efad..e9944ffed100 100644
--- a/drivers/staging/rtl8723bs/include/hal_phy.h
+++ b/drivers/staging/rtl8723bs/include/hal_phy.h
@@ -8,17 +8,11 @@
 #define __HAL_PHY_H__
 
 
-#if DISABLE_BB_RF
-#define	HAL_FW_ENABLE				0
-#define	HAL_MAC_ENABLE			0
-#define	HAL_BB_ENABLE				0
-#define	HAL_RF_ENABLE				0
-#else /*  FPGA_PHY and ASIC */
-#define		HAL_FW_ENABLE				1
-#define	HAL_MAC_ENABLE			1
-#define	HAL_BB_ENABLE				1
-#define	HAL_RF_ENABLE				1
-#endif
+/*  FPGA_PHY and ASIC */
+#define	HAL_FW_ENABLE	1
+#define	HAL_MAC_ENABLE	1
+#define	HAL_BB_ENABLE	1
+#define	HAL_RF_ENABLE	1
 
 /*  */
 /*  Antenna detection method, i.e., using single tone detection or RSSI reported from each antenna detected. */
-- 
2.20.1

