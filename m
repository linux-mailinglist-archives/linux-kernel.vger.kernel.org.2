Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52BD235F35C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 14:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350806AbhDNMTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 08:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350795AbhDNMTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 08:19:17 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 815C6C061756
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 05:18:55 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id q123-20020a1c43810000b029012c7d852459so2490209wma.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 05:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yleqO3vgs33T3vT8iiE9n46sBc+jL4hZQfhzC5+O7hA=;
        b=HmLLp8wrpXNBD8+cQPrrn+xqhMlwY4nn4KYB9+56Maie+F+/fJO1ryeaQpjTrH5OPs
         J3bHnJ8nD357AHzMhH7q7mGjqWu+Z6AGxURulIBzETdTlQNCTMa1ZVzZAG3dpMP6eC3m
         8W8IH2PoU/K/vMyKYxLBZd81PjOE7JoVxi2VUIHkdOwS3Y20SMaDnkR2ur2CyryXGJcM
         NGSgKO+4gvpD3EvDQf75rhIR9AWjn6MaF7zuURwAh/HlW4Te045Jeo8VeCByFYYvk7tx
         GY6UfGQMkWmclMabkFsa3/LdZJWQD6uKlHzR7rcESrEfu3ehsk1pwNpu8+jVSWHiN8tb
         b9MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yleqO3vgs33T3vT8iiE9n46sBc+jL4hZQfhzC5+O7hA=;
        b=s+lolVzkAg5/fjTp/0BXL0EMu0AG39pLcIel3SGLS31cx1f93Ei8Xw7ssJVoPAUEhY
         Wd+uFoSkAYeZreONO86TZrlXC8kAx70KJV9L7iho2smUHje/hKfhv/qiySKeQ3AOut9o
         qS1pS20RahO6NBLZRuOut1BTHvumefcPr/5GtGcIXfXOJPiI9P55Ko2Jdcss1S4pK5mB
         872ri5Hg2IZJq1ZezPRtU+t9i4H+nW9357seS6ILpkPgqSeKO1UDsVxCz9wDhYMLk3Dh
         PhOMUxUvYTHJw5gt0VF4I4duDKiRZjsPytYTLGQhdPybp/YS0SD0lGtoGnwxqLztfbvc
         H5kQ==
X-Gm-Message-State: AOAM532IS6n5NLhA/Z5pb3Ga+3zz9DbXx7aCPQfKN4nql+hLyGgbHHZw
        qzrqrUsA84VrI+Qn63IP8l89OSRX/DsnEA==
X-Google-Smtp-Source: ABdhPJw1c3oP5cUG7gslxu8FYFkGGQLcXcptZulH5ZpKpzJLB7QzxmFRhU6bjSFfC6VSuzyWLOM0kA==
X-Received: by 2002:a05:600c:1912:: with SMTP id j18mr2795361wmq.137.1618402733908;
        Wed, 14 Apr 2021 05:18:53 -0700 (PDT)
Received: from agape ([5.171.26.216])
        by smtp.gmail.com with ESMTPSA id j6sm4922266wmq.16.2021.04.14.05.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 05:18:53 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     julia.lawall@inria.fr, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] staging: rtl8723bs: replace DBG_871X_SEL_NL with netdev_dbg()
Date:   Wed, 14 Apr 2021 14:18:48 +0200
Message-Id: <9d4597097d75a1900c65e4a15077eb0c8bce1c9b.1618401896.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1618401896.git.fabioaiuto83@gmail.com>
References: <cover.1618401896.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

replace DGB_871X_SEL_NL macro with netdev_dbg().

DBG_871X_SEL_NL macro expands to a raw prink call or a
seq_printf if selected stream _is not_ a local
debug symbol set to null.
This second scenario never occurs so replace
all macro usages with netdev_dbg().

This is done with the following coccinelle script:

@@
expression sel;
expression list args;
identifier padapter;
identifier func;
@@

func(..., struct adapter *padapter, ...) {
	<...
-	DBG_871X_SEL_NL(sel, args);
+	netdev_dbg(padapter->pnetdev, args);
	...>
}

fix by hand one coccinelle output newline issue

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_debug.c | 16 +++----
 drivers/staging/rtl8723bs/core/rtw_odm.c   | 50 +++++++++++-----------
 drivers/staging/rtl8723bs/hal/hal_com.c    | 31 ++++++--------
 3 files changed, 47 insertions(+), 50 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_debug.c b/drivers/staging/rtl8723bs/core/rtw_debug.c
index 324c7e5248f8..79fd968bb147 100644
--- a/drivers/staging/rtl8723bs/core/rtw_debug.c
+++ b/drivers/staging/rtl8723bs/core/rtw_debug.c
@@ -20,7 +20,7 @@ void sd_f0_reg_dump(void *sel, struct adapter *adapter)
 
 	for (i = 0x0; i <= 0xff; i++) {
 		if (i%16 == 0)
-			DBG_871X_SEL_NL(sel, "0x%02x ", i);
+			netdev_dbg(adapter->pnetdev, "0x%02x ", i);
 
 		DBG_871X_SEL(sel, "%02x ", rtw_sd_f0_read8(adapter, i));
 
@@ -35,11 +35,11 @@ void mac_reg_dump(void *sel, struct adapter *adapter)
 {
 	int i, j = 1;
 
-	DBG_871X_SEL_NL(sel, "======= MAC REG =======\n");
+	netdev_dbg(adapter->pnetdev, "======= MAC REG =======\n");
 
 	for (i = 0x0; i < 0x800; i += 4) {
 		if (j%4 == 1)
-			DBG_871X_SEL_NL(sel, "0x%03x", i);
+			netdev_dbg(adapter->pnetdev, "0x%03x", i);
 		DBG_871X_SEL(sel, " 0x%08x ", rtw_read32(adapter, i));
 		if ((j++)%4 == 0)
 			DBG_871X_SEL(sel, "\n");
@@ -50,10 +50,10 @@ void bb_reg_dump(void *sel, struct adapter *adapter)
 {
 	int i, j = 1;
 
-	DBG_871X_SEL_NL(sel, "======= BB REG =======\n");
+	netdev_dbg(adapter->pnetdev, "======= BB REG =======\n");
 	for (i = 0x800; i < 0x1000 ; i += 4) {
 		if (j%4 == 1)
-			DBG_871X_SEL_NL(sel, "0x%03x", i);
+			netdev_dbg(adapter->pnetdev, "0x%03x", i);
 		DBG_871X_SEL(sel, " 0x%08x ", rtw_read32(adapter, i));
 		if ((j++)%4 == 0)
 			DBG_871X_SEL(sel, "\n");
@@ -73,14 +73,14 @@ void rf_reg_dump(void *sel, struct adapter *adapter)
 	else
 		path_nums = 2;
 
-	DBG_871X_SEL_NL(sel, "======= RF REG =======\n");
+	netdev_dbg(adapter->pnetdev, "======= RF REG =======\n");
 
 	for (path = 0; path < path_nums; path++) {
-		DBG_871X_SEL_NL(sel, "RF_Path(%x)\n", path);
+		netdev_dbg(adapter->pnetdev, "RF_Path(%x)\n", path);
 		for (i = 0; i < 0x100; i++) {
 			value = rtw_hal_read_rfreg(adapter, path, i, 0xffffffff);
 			if (j%4 == 1)
-				DBG_871X_SEL_NL(sel, "0x%02x ", i);
+				netdev_dbg(adapter->pnetdev, "0x%02x ", i);
 			DBG_871X_SEL(sel, " 0x%08x ", value);
 			if ((j++)%4 == 0)
 				DBG_871X_SEL(sel, "\n");
diff --git a/drivers/staging/rtl8723bs/core/rtw_odm.c b/drivers/staging/rtl8723bs/core/rtw_odm.c
index 53f7cc0444ba..f4a0ef428564 100644
--- a/drivers/staging/rtl8723bs/core/rtw_odm.c
+++ b/drivers/staging/rtl8723bs/core/rtw_odm.c
@@ -96,12 +96,13 @@ void rtw_odm_dbg_comp_msg(void *sel, struct adapter *adapter)
 	int i;
 
 	rtw_hal_get_def_var(adapter, HW_DEF_ODM_DBG_FLAG, &dbg_comp);
-	DBG_871X_SEL_NL(sel, "odm.DebugComponents = 0x%016llx\n", dbg_comp);
+	netdev_dbg(adapter->pnetdev, "odm.DebugComponents = 0x%016llx\n",
+		   dbg_comp);
 	for (i = 0; i < RTW_ODM_COMP_MAX; i++) {
 		if (odm_comp_str[i])
-			DBG_871X_SEL_NL(sel, "%cBIT%-2d %s\n",
-					(BIT0 << i) & dbg_comp ? '+' : ' ',
-					i, odm_comp_str[i]);
+			netdev_dbg(adapter->pnetdev, "%cBIT%-2d %s\n",
+				   (BIT0 << i) & dbg_comp ? '+' : ' ', i,
+				   odm_comp_str[i]);
 	}
 }
 
@@ -116,11 +117,11 @@ void rtw_odm_dbg_level_msg(void *sel, struct adapter *adapter)
 	int i;
 
 	rtw_hal_get_def_var(adapter, HW_DEF_ODM_DBG_LEVEL, &dbg_level);
-	DBG_871X_SEL_NL(sel, "odm.DebugLevel = %u\n", dbg_level);
+	netdev_dbg(adapter->pnetdev, "odm.DebugLevel = %u\n", dbg_level);
 	for (i = 0; i < RTW_ODM_DBG_LEVEL_NUM; i++) {
 		if (odm_dbg_level_str[i])
-			DBG_871X_SEL_NL(sel, "%u %s\n",
-					i, odm_dbg_level_str[i]);
+			netdev_dbg(adapter->pnetdev, "%u %s\n", i,
+				   odm_dbg_level_str[i]);
 	}
 }
 
@@ -135,12 +136,12 @@ void rtw_odm_ability_msg(void *sel, struct adapter *adapter)
 	int i;
 
 	rtw_hal_get_hwreg(adapter, HW_VAR_DM_FLAG, (u8 *)&ability);
-	DBG_871X_SEL_NL(sel, "odm.SupportAbility = 0x%08x\n", ability);
+	netdev_dbg(adapter->pnetdev, "odm.SupportAbility = 0x%08x\n", ability);
 	for (i = 0; i < RTW_ODM_ABILITY_MAX; i++) {
 		if (odm_ability_str[i])
-			DBG_871X_SEL_NL(sel, "%cBIT%-2d %s\n",
-					(BIT0 << i) & ability ? '+' : ' ', i,
-					odm_ability_str[i]);
+			netdev_dbg(adapter->pnetdev, "%cBIT%-2d %s\n",
+				   (BIT0 << i) & ability ? '+' : ' ', i,
+				   odm_ability_str[i]);
 	}
 }
 
@@ -154,17 +155,17 @@ void rtw_odm_adaptivity_parm_msg(void *sel, struct adapter *adapter)
 	struct hal_com_data *pHalData = GET_HAL_DATA(adapter);
 	struct dm_odm_t *odm = &pHalData->odmpriv;
 
-	DBG_871X_SEL_NL(sel, "%10s %16s %8s %10s %11s %14s\n",
-			"TH_L2H_ini", "TH_EDCCA_HL_diff", "IGI_Base",
-			"ForceEDCCA", "AdapEn_RSSI", "IGI_LowerBound");
-	DBG_871X_SEL_NL(sel, "0x%-8x %-16d 0x%-6x %-10d %-11u %-14u\n",
-			(u8)odm->TH_L2H_ini,
-			odm->TH_EDCCA_HL_diff,
-			odm->IGI_Base,
-			odm->ForceEDCCA,
-			odm->AdapEn_RSSI,
-			odm->IGI_LowerBound
-	);
+	netdev_dbg(adapter->pnetdev, "%10s %16s %8s %10s %11s %14s\n",
+		   "TH_L2H_ini", "TH_EDCCA_HL_diff", "IGI_Base", "ForceEDCCA",
+		   "AdapEn_RSSI", "IGI_LowerBound");
+	netdev_dbg(adapter->pnetdev,
+		   "0x%-8x %-16d 0x%-6x %-10d %-11u %-14u\n",
+		   (u8)odm->TH_L2H_ini,
+		   odm->TH_EDCCA_HL_diff,
+		   odm->IGI_Base,
+		   odm->ForceEDCCA,
+		   odm->AdapEn_RSSI,
+		   odm->IGI_LowerBound);
 }
 
 void rtw_odm_adaptivity_parm_set(struct adapter *adapter, s8 TH_L2H_ini,
@@ -188,6 +189,7 @@ void rtw_odm_get_perpkt_rssi(void *sel, struct adapter *adapter)
 	struct hal_com_data *hal_data = GET_HAL_DATA(adapter);
 	struct dm_odm_t *odm = &hal_data->odmpriv;
 
-	DBG_871X_SEL_NL(sel, "RxRate = %s, RSSI_A = %d(%%), RSSI_B = %d(%%)\n",
-			HDATA_RATE(odm->RxRate), odm->RSSI_A, odm->RSSI_B);
+	netdev_dbg(adapter->pnetdev,
+		   "RxRate = %s, RSSI_A = %d(%%), RSSI_B = %d(%%)\n",
+		   HDATA_RATE(odm->RxRate), odm->RSSI_A, odm->RSSI_B);
 }
diff --git a/drivers/staging/rtl8723bs/hal/hal_com.c b/drivers/staging/rtl8723bs/hal/hal_com.c
index 4cceb3a969a8..2e2d40469a83 100644
--- a/drivers/staging/rtl8723bs/hal/hal_com.c
+++ b/drivers/staging/rtl8723bs/hal/hal_com.c
@@ -1522,12 +1522,10 @@ void rtw_get_raw_rssi_info(void *sel, struct adapter *padapter)
 	struct hal_com_data *pHalData = GET_HAL_DATA(padapter);
 	struct rx_raw_rssi *psample_pkt_rssi = &padapter->recvpriv.raw_rssi_info;
 
-	DBG_871X_SEL_NL(
-		sel,
-		"RxRate = %s, PWDBALL = %d(%%), rx_pwr_all = %d(dBm)\n",
-		HDATA_RATE(psample_pkt_rssi->data_rate),
-		psample_pkt_rssi->pwdball, psample_pkt_rssi->pwr_all
-	);
+	netdev_dbg(padapter->pnetdev,
+		   "RxRate = %s, PWDBALL = %d(%%), rx_pwr_all = %d(dBm)\n",
+		   HDATA_RATE(psample_pkt_rssi->data_rate),
+		   psample_pkt_rssi->pwdball, psample_pkt_rssi->pwr_all);
 
 	isCCKrate = psample_pkt_rssi->data_rate <= DESC_RATE11M;
 
@@ -1535,20 +1533,17 @@ void rtw_get_raw_rssi_info(void *sel, struct adapter *padapter)
 		psample_pkt_rssi->mimo_signal_strength[0] = psample_pkt_rssi->pwdball;
 
 	for (rf_path = 0; rf_path < pHalData->NumTotalRFPath; rf_path++) {
-		DBG_871X_SEL_NL(
-			sel,
-			"RF_PATH_%d =>signal_strength:%d(%%), signal_quality:%d(%%)\n",
-			rf_path, psample_pkt_rssi->mimo_signal_strength[rf_path],
-			psample_pkt_rssi->mimo_signal_quality[rf_path]
-		);
+		netdev_dbg(padapter->pnetdev,
+			   "RF_PATH_%d =>signal_strength:%d(%%), signal_quality:%d(%%)\n",
+			   rf_path,
+			   psample_pkt_rssi->mimo_signal_strength[rf_path],
+			   psample_pkt_rssi->mimo_signal_quality[rf_path]);
 
 		if (!isCCKrate) {
-			DBG_871X_SEL_NL(
-				sel,
-				"\trx_ofdm_pwr:%d(dBm), rx_ofdm_snr:%d(dB)\n",
-				psample_pkt_rssi->ofdm_pwr[rf_path],
-				psample_pkt_rssi->ofdm_snr[rf_path]
-			);
+			netdev_dbg(padapter->pnetdev,
+				   "\trx_ofdm_pwr:%d(dBm), rx_ofdm_snr:%d(dB)\n",
+				   psample_pkt_rssi->ofdm_pwr[rf_path],
+				   psample_pkt_rssi->ofdm_snr[rf_path]);
 		}
 	}
 }
-- 
2.20.1

