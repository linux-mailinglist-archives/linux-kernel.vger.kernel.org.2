Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA2E943084C
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 13:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245452AbhJQLTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 07:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241729AbhJQLTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 07:19:33 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53550C061765
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 04:17:22 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id r7so35586124wrc.10
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 04:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5OV9zhqnOuhJ534TRu2O1fH+ldY6khbL3peOBGv1il4=;
        b=gYOUEUMuCHyXCzkkwkCZTjqXPUEJU37Ifx+W1TcM02TMw08D1NOd324gZvpi7j2Zyb
         7eWL55aBXZbaAJks6ou/dASMpDSSNUXqkkt56RaoVl3fR81PjqiS9gdAjJ7VktFcJGSx
         m4yjZluqYBo/u41azP+dh0CastyFJRpcwjQFgbVkfFuI0zXmONXQM5kPcnYLX2g9g1A4
         ZVlPjBATxPvYALUnwk3fkPX9ksn/Cl7+oZ50b+TsC3VUYlYu69O0bpO4Urk7WV5E36IZ
         znJ+wp6K94OvHcLCPvv7z+stekXQ/jFFCqS6yQSSlI9KWtebswH3l49Vv2Orub4mijDP
         zZ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5OV9zhqnOuhJ534TRu2O1fH+ldY6khbL3peOBGv1il4=;
        b=GtmAVLieIlRpexeFctWrJwXpvX2iO0en5mVzddLpYbmkFsXi3E5NgjOvb6GSTy1tyZ
         GBZ7RG+M9Mz+u1r13RbxwxWKDDi4Rnq91ZmCsHMAEcxAtNF56W1mR96j/wMBduI876/l
         0gtVgDh//X+rKUxVCesExjtIhoUUb/cd65zw6/w1O0eIwc7XT7c7VxS7BTioXfv9L7F4
         nOSV0EzIp9mFkWALM1YwZ47oiDWofqinlLy9ZxHuA/lo4rgBjoT2MHjU0MPL3nCgz3rn
         d5G2GjCdHKf+rGgf6A8oW3lUHRQ8mU6KREauFEG1CREx9Fp+BfLineD2DoRDtSb0lVK3
         vwDw==
X-Gm-Message-State: AOAM532bpCHgN4Nxasp9yLCwVznn1yqkJhf7EaUZ8dv3CtVkDTvTn9iE
        ub4p1BPA9ZJmB/jhj5V7E3w=
X-Google-Smtp-Source: ABdhPJz2qpq4AZcZaTZPiRYTkCPPZ28td0I5xfFWNlf7VmKmSeoGHPYEllftlFHp1kHVkvSYbG4NXg==
X-Received: by 2002:adf:8b45:: with SMTP id v5mr28129728wra.211.1634469440963;
        Sun, 17 Oct 2021 04:17:20 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::d7f0])
        by smtp.gmail.com with ESMTPSA id p12sm6661551wrr.67.2021.10.17.04.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Oct 2021 04:17:20 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH] staging: r8188eu: remove unused constants and variables
Date:   Sun, 17 Oct 2021 13:17:05 +0200
Message-Id: <20211017111705.18989-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove some unused constants and variables that are left over from
previous cleanup patches.

Suggested-by: Martin Kaiser <martin@kaiser.cx>
Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/odm.c          |  8 --------
 drivers/staging/r8188eu/hal/odm_HWConfig.c |  3 ---
 drivers/staging/r8188eu/include/odm.h      | 17 -----------------
 3 files changed, 28 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
index 0987ff3e382a..fc425d359b15 100644
--- a/drivers/staging/r8188eu/hal/odm.c
+++ b/drivers/staging/r8188eu/hal/odm.c
@@ -979,14 +979,6 @@ void ODM_TXPowerTrackingCheck(struct odm_dm_struct *pDM_Odm)
 	}
 }
 
-/* antenna mapping info */
-/*  1: right-side antenna */
-/*  2/0: left-side antenna */
-/* PDM_SWAT_Table->CCK_Ant1_Cnt /OFDM_Ant1_Cnt:  for right-side antenna:   Ant:1    RxDefaultAnt1 */
-/* PDM_SWAT_Table->CCK_Ant2_Cnt /OFDM_Ant2_Cnt:  for left-side antenna:     Ant:0    RxDefaultAnt2 */
-/*  We select left antenna as default antenna in initial process, modify it as needed */
-/*  */
-
 void odm_InitHybridAntDiv(struct odm_dm_struct *pDM_Odm)
 {
 	if (!(pDM_Odm->SupportAbility & ODM_BB_ANT_DIV))
diff --git a/drivers/staging/r8188eu/hal/odm_HWConfig.c b/drivers/staging/r8188eu/hal/odm_HWConfig.c
index 3d639b2720b2..af28af6f66d7 100644
--- a/drivers/staging/r8188eu/hal/odm_HWConfig.c
+++ b/drivers/staging/r8188eu/hal/odm_HWConfig.c
@@ -58,7 +58,6 @@ static void odm_RxPhyStatus92CSeries_Parsing(struct odm_dm_struct *dm_odm,
 			struct odm_per_pkt_info *pPktinfo,
 			struct adapter *adapt)
 {
-	struct sw_ant_switch *pDM_SWAT_Table = &dm_odm->DM_SWAT_Table;
 	u8 i, Max_spatial_stream;
 	s8 rx_pwr[4], rx_pwr_all = 0;
 	u8 EVM, PWDB_ALL = 0, PWDB_ALL_BT;
@@ -224,8 +223,6 @@ static void odm_RxPhyStatus92CSeries_Parsing(struct odm_dm_struct *dm_odm,
 			pPhyInfo->SignalStrength = (u8)(odm_SignalScaleMapping(dm_odm, total_rssi /= rf_rx_num));
 	}
 
-	/* For 92C/92D HW (Hybrid) Antenna Diversity */
-	pDM_SWAT_Table->antsel = pPhyStaRpt->ant_sel;
 	/* For 88E HW Antenna Diversity */
 	dm_odm->DM_FatTable.antsel_rx_keep_0 = pPhyStaRpt->ant_sel;
 	dm_odm->DM_FatTable.antsel_rx_keep_1 = pPhyStaRpt->ant_sel_b;
diff --git a/drivers/staging/r8188eu/include/odm.h b/drivers/staging/r8188eu/include/odm.h
index 841603b341bd..f1ea9fa89a26 100644
--- a/drivers/staging/r8188eu/include/odm.h
+++ b/drivers/staging/r8188eu/include/odm.h
@@ -111,12 +111,6 @@ struct rx_hpc {
 
 #define ODM_ASSOCIATE_ENTRY_NUM	32 /*  Max size of AsocEntry[]. */
 
-/*  This indicates two different steps. */
-/*  Using SWAW_STEP_PEAK, driver needs to switch antenna and listen to
- *  the signal on the air. */
-
-#define SWAW_STEP_PEAK		0
-
 struct sw_ant_switch {
 	u8	try_flag;
 	s32	PreRSSI;
@@ -131,8 +125,6 @@ struct sw_ant_switch {
 	/*  Before link Antenna Switch check */
 	u8	SWAS_NoLink_State;
 	u32	SWAS_NoLink_BK_Reg860;
-	bool	ANTA_ON;	/* To indicate Ant A is or not */
-	bool	ANTB_ON;	/* To indicate Ant B is on or not */
 
 	s32	RSSI_sum_A;
 	s32	RSSI_sum_B;
@@ -146,16 +138,8 @@ struct sw_ant_switch {
 	u64	RXByteCnt_B;
 	u8	TrafficLoad;
 	struct timer_list SwAntennaSwitchTimer;
-	/* Hybrid Antenna Diversity */
-	u32	CCK_Ant1_Cnt[ODM_ASSOCIATE_ENTRY_NUM];
-	u32	CCK_Ant2_Cnt[ODM_ASSOCIATE_ENTRY_NUM];
-	u32	OFDM_Ant1_Cnt[ODM_ASSOCIATE_ENTRY_NUM];
-	u32	OFDM_Ant2_Cnt[ODM_ASSOCIATE_ENTRY_NUM];
-	u32	RSSI_Ant1_Sum[ODM_ASSOCIATE_ENTRY_NUM];
-	u32	RSSI_Ant2_Sum[ODM_ASSOCIATE_ENTRY_NUM];
 	u8	TxAnt[ODM_ASSOCIATE_ENTRY_NUM];
 	u8	TargetSTA;
-	u8	antsel;
 	u8	RxIdleAnt;
 };
 
@@ -574,7 +558,6 @@ enum ant_div_type {
 	CGCS_RX_HW_ANTDIV		= 0x02,
 	FIXED_HW_ANTDIV			= 0x03,
 	CG_TRX_SMART_ANTDIV		= 0x04,
-	CGCS_RX_SW_ANTDIV		= 0x05,
 };
 
 /* Copy from SD4 defined structure. We use to support PHY DM integration. */
-- 
2.33.0

