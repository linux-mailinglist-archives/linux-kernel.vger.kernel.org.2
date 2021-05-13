Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8D2A37F0A4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 02:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbhEMArX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 20:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233680AbhEMAly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 20:41:54 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C9AAC06138B
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 17:39:19 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id 197so24098473qkl.12
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 17:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=45A3QuMXm6Cyn55olGRnsIeedlfjDiFJm3+n93w3le0=;
        b=r3orxArIAv0zYElpqQVDuHhzY/qET51DSExBOf+TPazQZm5taJrECw5ePBDuTTOBEp
         MICrmqZNdgj4EAHZjO/NOD9FUrL1A3aZChcgZmdL/F+9+i/zmGKvTT7NesfxzZVlub80
         Zwb/wcRKB/jS/pM3JbOS8BJh2Gyet6UsyEz91xbC4cD5jRaeR8+UITn9FB9N9xOCp7XU
         fNRuAAJjHI2iJ/wVc4REdSZF+t4sJuBuEtNeA+9pzKso0pKAiZsRqbPwKFl7wJaMwQHe
         C3VUrzaHWn+CJV8YPIMs261qtu12trzWg8h7xh5nKRpYU/6W5fX//B/uAOrvVxAVjfQl
         ixHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=45A3QuMXm6Cyn55olGRnsIeedlfjDiFJm3+n93w3le0=;
        b=DW/b3mRBzvbgfvClhyEOTaZ8XM4dvAlq3IR1bLAMD2H+j1ChLqM4YBz1PXCZ1kKIy7
         icmwHP7wRbJwgaD4we+a0hPVnkWVCzq+IoH+Pj+/GchA2Y2vcMlnVfKw0+uXmQLpXaKF
         vLYP410MMD/hhoiapb9HnUY+vDNZHvwEx4PADHx0kzC3v0p4lyHAfI2xSFtTdb3ufCYs
         RW7Zv5k+uZQpW43rbAdgDm10XA4+W4x4sCu+AH0PLd4m35ll9v140M0TIzi0/mnGf4nY
         F34rCo2/1DWE3TyG3Ixju5ZxqQklbE6eOzIQfGy7DAFzlLP5Gu8T9gMzNGcmSCXYhW0+
         lxgg==
X-Gm-Message-State: AOAM532wz1hDTfWarEVwyh+9lKpUH1ZbhojSUdOfIUeM9TsgzwTPS4My
        nnUzBT/MwMe758ijHQpSzSf9hg==
X-Google-Smtp-Source: ABdhPJx89p2JzrSGS2YTdIUxAAZa74mJWiKGGeKzCBCG3uVa7vroeHHzKlhBRNr2qGX0hEkQ3qanzg==
X-Received: by 2002:a05:620a:1390:: with SMTP id k16mr36612135qki.99.1620866358773;
        Wed, 12 May 2021 17:39:18 -0700 (PDT)
Received: from localhost.localdomain (modemcable068.184-131-66.mc.videotron.ca. [66.131.184.68])
        by smtp.gmail.com with ESMTPSA id w16sm1204201qts.70.2021.05.12.17.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 17:39:18 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     freedreno@lists.freedesktop.org
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Eric Anholt <eric@anholt.net>,
        Akhil P Oommen <akhilpo@codeaurora.org>,
        Sharat Masetty <smasetty@codeaurora.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        kbuild test robot <lkp@intel.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/5] drm/msm/a6xx: add support for Adreno 660 GPU
Date:   Wed, 12 May 2021 20:37:47 -0400
Message-Id: <20210513003811.29578-4-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210513003811.29578-1-jonathan@marek.ca>
References: <20210513003811.29578-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add adreno_is_{a660,a650_family} helpers and convert update existing
adreno_is_a650 usage based on downstream driver's logic (changing into
adreno_is_a650_family or adding adreno_is_a660).

And add the remaining changes required for A660, again based on
the downstream driver: missing GMU allocations, additional register init,
dummy hfi BW table, entry in gpulist table.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 drivers/gpu/drm/msm/adreno/a6xx.xml.h      |  4 +++
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c      | 32 +++++++++++++++------
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c      | 24 +++++++++++-----
 drivers/gpu/drm/msm/adreno/a6xx_hfi.c      | 33 ++++++++++++++++++++++
 drivers/gpu/drm/msm/adreno/adreno_device.c | 12 ++++++++
 drivers/gpu/drm/msm/adreno/adreno_gpu.c    |  2 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.h    | 12 ++++++++
 7 files changed, 103 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx.xml.h b/drivers/gpu/drm/msm/adreno/a6xx.xml.h
index 920c5e6b8e96..631c36672560 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx.xml.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx.xml.h
@@ -2240,6 +2240,8 @@ static inline uint32_t A6XX_DBGC_CFG_DBGBUS_BYTEL_1_BYTEL15(uint32_t val)
 
 #define REG_A6XX_DBGC_CFG_DBGBUS_TRACE_BUF2			0x00000630
 
+#define REG_A6XX_CP_LPAC_PROG_FIFO_SIZE     			0x00000b34
+
 #define REG_A6XX_VSC_PERFCTR_VSC_SEL_0				0x00000cd8
 
 #define REG_A6XX_VSC_PERFCTR_VSC_SEL_1				0x00000cd9
@@ -2340,6 +2342,8 @@ static inline uint32_t A6XX_UCHE_CLIENT_PF_PERFSEL(uint32_t val)
 
 #define REG_A6XX_UCHE_PERFCTR_UCHE_SEL_11			0x00000e27
 
+#define REG_A6XX_UCHE_CMDQ_CONFIG               		0x00000e3c
+
 #define REG_A6XX_SP_ADDR_MODE_CNTL				0x0000ae01
 
 #define REG_A6XX_SP_NC_MODE_CNTL				0x0000ae02
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 3d55e153fa9c..e25c41984336 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -520,7 +520,7 @@ static void a6xx_gmu_rpmh_init(struct a6xx_gmu *gmu)
 
 	if (adreno_is_a618(adreno_gpu) || adreno_is_a640(adreno_gpu))
 		pdc_address_offset = 0x30090;
-	else if (adreno_is_a650(adreno_gpu))
+	else if (adreno_is_a650_family(adreno_gpu))
 		pdc_address_offset = 0x300a0;
 	else
 		pdc_address_offset = 0x30080;
@@ -542,7 +542,7 @@ static void a6xx_gmu_rpmh_init(struct a6xx_gmu *gmu)
 	gmu_write_rscc(gmu, REG_A6XX_RSCC_PDC_MATCH_VALUE_HI, 0x4514);
 
 	/* Load RSC sequencer uCode for sleep and wakeup */
-	if (adreno_is_a650(adreno_gpu)) {
+	if (adreno_is_a650_family(adreno_gpu)) {
 		gmu_write_rscc(gmu, REG_A6XX_RSCC_SEQ_MEM_0_DRV0, 0xeaaae5a0);
 		gmu_write_rscc(gmu, REG_A6XX_RSCC_SEQ_MEM_0_DRV0 + 1, 0xe1a1ebab);
 		gmu_write_rscc(gmu, REG_A6XX_RSCC_SEQ_MEM_0_DRV0 + 2, 0xa2e0a581);
@@ -587,7 +587,7 @@ static void a6xx_gmu_rpmh_init(struct a6xx_gmu *gmu)
 
 	pdc_write(pdcptr, REG_A6XX_PDC_GPU_TCS3_CMD0_MSGID + 4, 0x10108);
 	pdc_write(pdcptr, REG_A6XX_PDC_GPU_TCS3_CMD0_ADDR + 4, 0x30000);
-	if (adreno_is_a618(adreno_gpu) || adreno_is_a650(adreno_gpu))
+	if (adreno_is_a618(adreno_gpu) || adreno_is_a650_family(adreno_gpu))
 		pdc_write(pdcptr, REG_A6XX_PDC_GPU_TCS3_CMD0_DATA + 4, 0x2);
 	else
 		pdc_write(pdcptr, REG_A6XX_PDC_GPU_TCS3_CMD0_DATA + 4, 0x3);
@@ -687,7 +687,7 @@ static int a6xx_gmu_fw_load(struct a6xx_gmu *gmu)
 	u32 itcm_base = 0x00000000;
 	u32 dtcm_base = 0x00040000;
 
-	if (adreno_is_a650(adreno_gpu))
+	if (adreno_is_a650_family(adreno_gpu))
 		dtcm_base = 0x10004000;
 
 	if (gmu->legacy) {
@@ -740,7 +740,7 @@ static int a6xx_gmu_fw_start(struct a6xx_gmu *gmu, unsigned int state)
 	int ret;
 	u32 chipid;
 
-	if (adreno_is_a650(adreno_gpu))
+	if (adreno_is_a650(adreno_gpu) || adreno_is_a660(adreno_gpu))
 		gmu_write(gmu, REG_A6XX_GPU_GMU_CX_GMU_CX_FAL_INTF, 1);
 
 	if (state == GMU_WARM_BOOT) {
@@ -1483,12 +1483,28 @@ int a6xx_gmu_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node)
 	if (ret)
 		goto err_put_device;
 
+
+	/* A660 now requires handling "prealloc requests" in GMU firmware
+	 * For now just hardcode allocations based on the known firmware.
+	 * note: there is no indication that these correspond to "dummy" or
+	 * "debug" regions, but this "guess" allows reusing these BOs which
+	 * are otherwise unused by a660.
+	 */
+	gmu->dummy.size = SZ_4K;
+	if (adreno_is_a660(adreno_gpu)) {
+		ret = a6xx_gmu_memory_alloc(gmu, &gmu->debug, SZ_4K * 7, 0x60400000);
+		if (ret)
+			goto err_memory;
+
+		gmu->dummy.size = SZ_8K;
+	}
+
 	/* Allocate memory for the GMU dummy page */
-	ret = a6xx_gmu_memory_alloc(gmu, &gmu->dummy, SZ_4K, 0x60000000);
+	ret = a6xx_gmu_memory_alloc(gmu, &gmu->dummy, gmu->dummy.size, 0x60000000);
 	if (ret)
 		goto err_memory;
 
-	if (adreno_is_a650(adreno_gpu)) {
+	if (adreno_is_a650_family(adreno_gpu)) {
 		ret = a6xx_gmu_memory_alloc(gmu, &gmu->icache,
 			SZ_16M - SZ_16K, 0x04000);
 		if (ret)
@@ -1530,7 +1546,7 @@ int a6xx_gmu_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node)
 		goto err_memory;
 	}
 
-	if (adreno_is_a650(adreno_gpu)) {
+	if (adreno_is_a650_family(adreno_gpu)) {
 		gmu->rscc = a6xx_gmu_get_mmio(pdev, "rscc");
 		if (IS_ERR(gmu->rscc))
 			goto err_mmio;
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 01bd31b3c504..4467273e66c0 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -477,7 +477,7 @@ static void a6xx_set_ubwc_config(struct msm_gpu *gpu)
 	if (adreno_is_a640(adreno_gpu))
 		amsbc = 1;
 
-	if (adreno_is_a650(adreno_gpu)) {
+	if (adreno_is_a650(adreno_gpu) || adreno_is_a660(adreno_gpu)) {
 		/* TODO: get ddr type from bootloader and use 2 for LPDDR4 */
 		lower_bit = 3;
 		amsbc = 1;
@@ -690,7 +690,7 @@ static int a6xx_hw_init(struct msm_gpu *gpu)
 	a6xx_set_hwcg(gpu, true);
 
 	/* VBIF/GBIF start*/
-	if (adreno_is_a640(adreno_gpu) || adreno_is_a650(adreno_gpu)) {
+	if (adreno_is_a640(adreno_gpu) || adreno_is_a650_family(adreno_gpu)) {
 		gpu_write(gpu, REG_A6XX_GBIF_QSB_SIDE0, 0x00071620);
 		gpu_write(gpu, REG_A6XX_GBIF_QSB_SIDE1, 0x00071620);
 		gpu_write(gpu, REG_A6XX_GBIF_QSB_SIDE2, 0x00071620);
@@ -715,7 +715,7 @@ static int a6xx_hw_init(struct msm_gpu *gpu)
 	gpu_write(gpu, REG_A6XX_UCHE_WRITE_THRU_BASE_LO, 0xfffff000);
 	gpu_write(gpu, REG_A6XX_UCHE_WRITE_THRU_BASE_HI, 0x0001ffff);
 
-	if (!adreno_is_a650(adreno_gpu)) {
+	if (!adreno_is_a650_family(adreno_gpu)) {
 		/* Set the GMEM VA range [0x100000:0x100000 + gpu->gmem - 1] */
 		gpu_write64(gpu, REG_A6XX_UCHE_GMEM_RANGE_MIN_LO,
 			REG_A6XX_UCHE_GMEM_RANGE_MIN_HI, 0x00100000);
@@ -728,17 +728,20 @@ static int a6xx_hw_init(struct msm_gpu *gpu)
 	gpu_write(gpu, REG_A6XX_UCHE_FILTER_CNTL, 0x804);
 	gpu_write(gpu, REG_A6XX_UCHE_CACHE_WAYS, 0x4);
 
-	if (adreno_is_a640(adreno_gpu) || adreno_is_a650(adreno_gpu))
+	if (adreno_is_a640(adreno_gpu) || adreno_is_a650_family(adreno_gpu))
 		gpu_write(gpu, REG_A6XX_CP_ROQ_THRESHOLDS_2, 0x02000140);
 	else
 		gpu_write(gpu, REG_A6XX_CP_ROQ_THRESHOLDS_2, 0x010000c0);
 	gpu_write(gpu, REG_A6XX_CP_ROQ_THRESHOLDS_1, 0x8040362c);
 
+	if (adreno_is_a660(adreno_gpu))
+		gpu_write(gpu, REG_A6XX_CP_LPAC_PROG_FIFO_SIZE, 0x00000020);
+
 	/* Setting the mem pool size */
 	gpu_write(gpu, REG_A6XX_CP_MEM_POOL_SIZE, 128);
 
 	/* Setting the primFifo thresholds default values */
-	if (adreno_is_a650(adreno_gpu))
+	if (adreno_is_a650(adreno_gpu) || adreno_is_a660(adreno_gpu))
 		gpu_write(gpu, REG_A6XX_PC_DBG_ECO_CNTL, 0x00300000);
 	else if (adreno_is_a640(adreno_gpu))
 		gpu_write(gpu, REG_A6XX_PC_DBG_ECO_CNTL, 0x00200000);
@@ -763,7 +766,7 @@ static int a6xx_hw_init(struct msm_gpu *gpu)
 	gpu_write(gpu, REG_A6XX_UCHE_CLIENT_PF, 1);
 
 	/* Set weights for bicubic filtering */
-	if (adreno_is_a650(adreno_gpu)) {
+	if (adreno_is_a650_family(adreno_gpu)) {
 		gpu_write(gpu, REG_A6XX_TPL1_BICUBIC_WEIGHTS_TABLE_0, 0);
 		gpu_write(gpu, REG_A6XX_TPL1_BICUBIC_WEIGHTS_TABLE_1,
 			0x3fe05ff4);
@@ -812,6 +815,13 @@ static int a6xx_hw_init(struct msm_gpu *gpu)
 			A6XX_PROTECT_RDONLY(0x980, 0x4));
 	gpu_write(gpu, REG_A6XX_CP_PROTECT(25), A6XX_PROTECT_RW(0xa630, 0x0));
 
+	if (adreno_is_a660(adreno_gpu)) {
+		gpu_write(gpu, REG_A6XX_CP_CHICKEN_DBG, 0x1);
+		gpu_write(gpu, REG_A6XX_RBBM_GBIF_CLIENT_QOS_CNTL, 0x0);
+		/* Set dualQ + disable afull for A660 GPU but not for A635 */
+		gpu_write(gpu, REG_A6XX_UCHE_CMDQ_CONFIG, 0x66906);
+	}
+
 	/* Enable expanded apriv for targets that support it */
 	if (gpu->hw_apriv) {
 		gpu_write(gpu, REG_A6XX_CP_APRIV_CNTL,
@@ -1488,7 +1498,7 @@ struct msm_gpu *a6xx_gpu_init(struct drm_device *dev)
 	 */
 	info = adreno_info(config->rev);
 
-	if (info && info->revn == 650)
+	if (info && (info->revn == 650 || info->revn == 660))
 		adreno_gpu->base.hw_apriv = true;
 
 	a6xx_llc_slices_init(pdev, a6xx_gpu);
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
index ccd44d0418f8..919433732b43 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
@@ -351,6 +351,37 @@ static void a650_build_bw_table(struct a6xx_hfi_msg_bw_table *msg)
 	msg->cnoc_cmds_data[1][0] =  0x60000001;
 }
 
+static void a660_build_bw_table(struct a6xx_hfi_msg_bw_table *msg)
+{
+	/*
+	 * Send a single "off" entry just to get things running
+	 * TODO: bus scaling
+	 */
+	msg->bw_level_num = 1;
+
+	msg->ddr_cmds_num = 3;
+	msg->ddr_wait_bitmask = 0x01;
+
+	msg->ddr_cmds_addrs[0] = 0x50004;
+	msg->ddr_cmds_addrs[1] = 0x500a0;
+	msg->ddr_cmds_addrs[2] = 0x50000;
+
+	msg->ddr_cmds_data[0][0] =  0x40000000;
+	msg->ddr_cmds_data[0][1] =  0x40000000;
+	msg->ddr_cmds_data[0][2] =  0x40000000;
+
+	/*
+	 * These are the CX (CNOC) votes - these are used by the GMU but the
+	 * votes are known and fixed for the target
+	 */
+	msg->cnoc_cmds_num = 1;
+	msg->cnoc_wait_bitmask = 0x01;
+
+	msg->cnoc_cmds_addrs[0] = 0x50070;
+	msg->cnoc_cmds_data[0][0] =  0x40000000;
+	msg->cnoc_cmds_data[1][0] =  0x60000001;
+}
+
 static void a6xx_build_bw_table(struct a6xx_hfi_msg_bw_table *msg)
 {
 	/* Send a single "off" entry since the 630 GMU doesn't do bus scaling */
@@ -401,6 +432,8 @@ static int a6xx_hfi_send_bw_table(struct a6xx_gmu *gmu)
 		a640_build_bw_table(&msg);
 	else if (adreno_is_a650(adreno_gpu))
 		a650_build_bw_table(&msg);
+	else if (adreno_is_a660(adreno_gpu))
+		a660_build_bw_table(&msg);
 	else
 		a6xx_build_bw_table(&msg);
 
diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index b3337b93be91..e4db0683d381 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -287,6 +287,18 @@ static const struct adreno_info gpulist[] = {
 		.init = a6xx_gpu_init,
 		.zapfw = "a650_zap.mdt",
 		.hwcg = a650_hwcg,
+	}, {
+		.rev = ADRENO_REV(6, 6, 0, ANY_ID),
+		.revn = 660,
+		.name = "A660",
+		.fw = {
+			[ADRENO_FW_SQE] = "a660_sqe.fw",
+			[ADRENO_FW_GMU] = "a660_gmu.bin",
+		},
+		.gmem = SZ_1M + SZ_512K,
+		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
+		.init = a6xx_gpu_init,
+		.zapfw = "a660_zap.mdt",
 	},
 };
 
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 009f4c560f16..326ca3123746 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -239,7 +239,7 @@ int adreno_get_param(struct msm_gpu *gpu, uint32_t param, uint64_t *value)
 		*value = adreno_gpu->gmem;
 		return 0;
 	case MSM_PARAM_GMEM_BASE:
-		*value = !adreno_is_a650(adreno_gpu) ? 0x100000 : 0;
+		*value = !adreno_is_a650_family(adreno_gpu) ? 0x100000 : 0;
 		return 0;
 	case MSM_PARAM_CHIP_ID:
 		*value = adreno_gpu->rev.patchid |
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
index ccac275aa7a2..63c050919d85 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
@@ -247,6 +247,18 @@ static inline int adreno_is_a650(struct adreno_gpu *gpu)
        return gpu->revn == 650;
 }
 
+static inline int adreno_is_a660(struct adreno_gpu *gpu)
+{
+       return gpu->revn == 660;
+}
+
+/* check for a650, a660, or any derivatives */
+static inline int adreno_is_a650_family(struct adreno_gpu *gpu)
+{
+       return gpu->revn == 650 || gpu->revn == 620 ||
+              gpu->revn == 660 || gpu->revn == 635;
+}
+
 int adreno_get_param(struct msm_gpu *gpu, uint32_t param, uint64_t *value);
 const struct firmware *adreno_request_fw(struct adreno_gpu *adreno_gpu,
 		const char *fwname);
-- 
2.26.1

