Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B00354337C3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 15:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235956AbhJSNyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 09:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235788AbhJSNx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 09:53:57 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD74AC06161C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 06:51:44 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id t2so47996770wrb.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 06:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M/DmGSjL5YYc0m+ILoDVmj5IL0+TiD4NKKwKxMYwOv4=;
        b=Wq24puAM6Qpi0KzblwlS7MNqLTAT7a5s+ryG0njuP55JeeuXUYhRdUeoBvp6fTBjf4
         4YwaLj+aeSy4A5o+EXykaCEC/iwfs51HUlAINLQa7Jdry7OrGWqEbIeORxpYkurBB0jC
         UqFNrmMEsTTQkw9O8rl0emYISXCIlgWTeipVaHGXf5pMiLk6rEckTohm+25GEIW0bC8o
         wfL6jlJ5Yk7xED6FADafeo2tU1k5nvbo1dyzIkqTF+c9VXFtGoO8lKxEAu85PKttaVQ3
         jfMT/M2AbXadcbp4v71UW8snHiV9hiFfsYcyR+mZrS3Zd9Q2oiLgLCFppGw4R+6JNfqj
         a2WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M/DmGSjL5YYc0m+ILoDVmj5IL0+TiD4NKKwKxMYwOv4=;
        b=cpeDHPNzwNS6zdiJPX9+ZCCM515r75eAaLemlhJ3QOY+c8/FTDfho6eySOOUaMzaRf
         P28HwZfoZa358PtrvBIuHbxhJzNJcNbI7Wpf+Dh1S4BqLbINJ7S4UG0jVJU9GoBWLVkw
         w72Ojw9AJ/6t4LH3JvGM7LG4mJObAQjT/TSwXojWvh0wV8jK/mrgjc8BBbwsYBmHPukY
         mLhsTs38xrdoUeLTPvsNRlgG4aS8wd9r97yIhkxkbBM9qIOnM0e6dJGm1+ZbbQKeT7KW
         YMBOb00ko1KwZxaYREOka0KpYd0t2hWQGGws6USxwRy5SRJybG6YA2C4XMjYYIVnVB/L
         lc1A==
X-Gm-Message-State: AOAM530mmgewYMoUZvd7VYItnBrYKkk3QhDEyJ7/xRgrXXNjDnjJ+k75
        v9Iq1Ewed8qQ/Wqnu+Wy0PQ=
X-Google-Smtp-Source: ABdhPJyKSIvZ19t44O8h/XJeYPqLDiuqraqiPRauNQKJnMpE3IX+Ld8Bi9F13E+z5MUNijCtzjmKeg==
X-Received: by 2002:adf:a15c:: with SMTP id r28mr43618707wrr.287.1634651503410;
        Tue, 19 Oct 2021 06:51:43 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::3de4])
        by smtp.gmail.com with ESMTPSA id i203sm2280699wma.48.2021.10.19.06.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 06:51:43 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/7] staging: r8188eu: remove duplicate structure
Date:   Tue, 19 Oct 2021 15:51:31 +0200
Message-Id: <20211019135137.9893-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211019135137.9893-1-straube.linux@gmail.com>
References: <20211019135137.9893-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The structures odm_phy_status_info and phy_info are redundant.
Keep phy_info and remove odm_phy_status_info.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/odm_HWConfig.c     | 12 ++++++------
 drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c  |  2 +-
 drivers/staging/r8188eu/include/odm.h          | 17 -----------------
 drivers/staging/r8188eu/include/odm_HWConfig.h |  2 +-
 4 files changed, 8 insertions(+), 25 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm_HWConfig.c b/drivers/staging/r8188eu/hal/odm_HWConfig.c
index af28af6f66d7..d83ef15c2cb6 100644
--- a/drivers/staging/r8188eu/hal/odm_HWConfig.c
+++ b/drivers/staging/r8188eu/hal/odm_HWConfig.c
@@ -53,7 +53,7 @@ static u8 odm_evm_db_to_percentage(s8 value)
 }
 
 static void odm_RxPhyStatus92CSeries_Parsing(struct odm_dm_struct *dm_odm,
-			struct odm_phy_status_info *pPhyInfo,
+			struct phy_info *pPhyInfo,
 			u8 *pPhyStatus,
 			struct odm_per_pkt_info *pPktinfo,
 			struct adapter *adapt)
@@ -137,7 +137,7 @@ static void odm_RxPhyStatus92CSeries_Parsing(struct odm_dm_struct *dm_odm,
 
 		pPhyInfo->RxPWDBAll = PWDB_ALL;
 		pPhyInfo->BTRxRSSIPercentage = PWDB_ALL;
-		pPhyInfo->RecvSignalPower = rx_pwr_all;
+		pPhyInfo->recvpower = rx_pwr_all;
 		/*  (3) Get Signal Quality (EVM) */
 		if (pPktinfo->bPacketMatchBSSID) {
 			u8 SQ, SQ_rpt;
@@ -193,7 +193,7 @@ static void odm_RxPhyStatus92CSeries_Parsing(struct odm_dm_struct *dm_odm,
 		pPhyInfo->RxPWDBAll = PWDB_ALL;
 		pPhyInfo->BTRxRSSIPercentage = PWDB_ALL_BT;
 		pPhyInfo->RxPower = rx_pwr_all;
-		pPhyInfo->RecvSignalPower = rx_pwr_all;
+		pPhyInfo->recvpower = rx_pwr_all;
 
 		/*  (3)EVM of HT rate */
 		if (pPktinfo->Rate >= DESC92C_RATEMCS8 && pPktinfo->Rate <= DESC92C_RATEMCS15)
@@ -230,7 +230,7 @@ static void odm_RxPhyStatus92CSeries_Parsing(struct odm_dm_struct *dm_odm,
 }
 
 static void odm_Process_RSSIForDM(struct odm_dm_struct *dm_odm,
-				  struct odm_phy_status_info *pPhyInfo,
+				  struct phy_info *pPhyInfo,
 				  struct odm_per_pkt_info *pPktinfo)
 {
 	s32 UndecoratedSmoothedPWDB, UndecoratedSmoothedCCK;
@@ -366,7 +366,7 @@ static void odm_Process_RSSIForDM(struct odm_dm_struct *dm_odm,
 
 /*  Endianness before calling this API */
 static void ODM_PhyStatusQuery_92CSeries(struct odm_dm_struct *dm_odm,
-					 struct odm_phy_status_info *pPhyInfo,
+					 struct phy_info *pPhyInfo,
 					 u8 *pPhyStatus,
 					 struct odm_per_pkt_info *pPktinfo,
 					 struct adapter *adapt)
@@ -378,7 +378,7 @@ static void ODM_PhyStatusQuery_92CSeries(struct odm_dm_struct *dm_odm,
 }
 
 void ODM_PhyStatusQuery(struct odm_dm_struct *dm_odm,
-			struct odm_phy_status_info *pPhyInfo,
+			struct phy_info *pPhyInfo,
 			u8 *pPhyStatus, struct odm_per_pkt_info *pPktinfo,
 			struct adapter *adapt)
 {
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c b/drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c
index 244286789b6d..053d9549873d 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c
@@ -127,7 +127,7 @@ void update_recvframe_phyinfo_88e(struct recv_frame *precvframe, struct phy_stat
 	struct adapter *padapter = precvframe->adapter;
 	struct rx_pkt_attrib *pattrib = &precvframe->attrib;
 	struct hal_data_8188e *pHalData = GET_HAL_DATA(padapter);
-	struct odm_phy_status_info *pPHYInfo  = (struct odm_phy_status_info *)(&pattrib->phy_info);
+	struct phy_info *pPHYInfo  = &pattrib->phy_info;
 	u8 *wlanhdr;
 	struct odm_per_pkt_info	pkt_info;
 	u8 *sa = NULL;
diff --git a/drivers/staging/r8188eu/include/odm.h b/drivers/staging/r8188eu/include/odm.h
index 3c08d33f0dd0..6aac90fcf3cc 100644
--- a/drivers/staging/r8188eu/include/odm.h
+++ b/drivers/staging/r8188eu/include/odm.h
@@ -168,23 +168,6 @@ struct odm_rate_adapt {
 
 #define	DM_Type_ByDriver	1
 
-/*  Declare for common info */
-
-struct odm_phy_status_info {
-	u8	RxPWDBAll;
-	u8	SignalQuality;	 /*  in 0-100 index. */
-	u8	RxMIMOSignalQuality[MAX_PATH_NUM_92CS]; /* EVM */
-	u8	RxMIMOSignalStrength[MAX_PATH_NUM_92CS];/*  in 0~100 index */
-	s8	RxPower; /*  in dBm Translate from PWdB */
-	s8	RecvSignalPower;/*  Real power in dBm for this packet, no
-				 * beautification and aggregation. Keep this raw
-				 * info to be used for the other procedures. */
-	u8	BTRxRSSIPercentage;
-	u8	SignalStrength; /*  in 0-100 index. */
-	u8	RxPwr[MAX_PATH_NUM_92CS];/* per-path's pwdb */
-	u8	RxSNR[MAX_PATH_NUM_92CS];/* per-path's SNR */
-};
-
 struct odm_phy_dbg_info {
 	/* ODM Write,debug info */
 	s8	RxSNRdB[MAX_PATH_NUM_92CS];
diff --git a/drivers/staging/r8188eu/include/odm_HWConfig.h b/drivers/staging/r8188eu/include/odm_HWConfig.h
index e2edcb7dbad6..3ed265e00ac1 100644
--- a/drivers/staging/r8188eu/include/odm_HWConfig.h
+++ b/drivers/staging/r8188eu/include/odm_HWConfig.h
@@ -90,7 +90,7 @@ struct phy_status_rpt {
 };
 
 void ODM_PhyStatusQuery(struct odm_dm_struct *pDM_Odm,
-			struct odm_phy_status_info *pPhyInfo,
+			struct phy_info *pPhyInfo,
 			u8 *pPhyStatus,
 			struct odm_per_pkt_info *pPktinfo,
 			struct adapter *adapt);
-- 
2.33.1

