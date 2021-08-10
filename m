Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF5D23DAC2B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 21:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232579AbhG2TwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 15:52:21 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:38105 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232506AbhG2TwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 15:52:20 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1627588337; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=JKh0cgq+ornwjxuL1vNNDj11jNROJTaOW33NhvyQw+Y=; b=oUr5ckmktktskv/dqHCML2PjT5bkcY5odwVD1iCWfG+/SdsaLXzew8Lq31ClbH2GfNpMX4/t
 VesfutVjSoyj/AMUB0CV4rp/9pOM2jnv9Ew1KYXKn/lM2mcBMVcTEEP7Mm54eRulur2R7Feo
 8QAP8643yokxBtwrQ9RsKvsM9lk=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 610306ddb653fbdaddaabd95 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 29 Jul 2021 19:51:57
 GMT
Sender: akhilpo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AD522C43143; Thu, 29 Jul 2021 19:51:56 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from hyd-lnxbld559.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akhilpo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B7132C433D3;
        Thu, 29 Jul 2021 19:51:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B7132C433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=akhilpo@codeaurora.org
From:   Akhil P Oommen <akhilpo@codeaurora.org>
To:     freedreno <freedreno@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@gmail.com>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Jonathan Marek <jonathan@marek.ca>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>, Eric Anholt <eric@anholt.net>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Sean Paul <sean@poorly.run>,
        Sharat Masetty <smasetty@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/3] drm/msm/a6xx: Add support for Adreno 7c Gen 3 gpu
Date:   Fri, 30 Jul 2021 01:21:25 +0530
Message-Id: <20210730011945.v4.3.I610377db0934b6b7deda532ec2bf786a02c38c01@changeid>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1627588286-30520-1-git-send-email-akhilpo@codeaurora.org>
References: <1627588286-30520-1-git-send-email-akhilpo@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for the gpu found in the Snapdragon 7c Gen 3
compute platform. This gpu is similar to the exisiting a660 gpu with
minor delta in the programing sequence. As the Adreno GPUs are moving
away from a numeric chipid based naming scheme to a string, it was
decided to use 0x06030500 as the chip id of this gpu to communicate
to the userspace driver.

Signed-off-by: Akhil P Oommen <akhilpo@codeaurora.org>
---

Changes in v4:
- Move out adreno_cmp_rev() to patch-2/3 to fix compilation

Changes in v2:
- Introduce adreno_is_a660_family() (Rob)
- Remove revn for 7c3 (Rob)
- Remove CPR register programing since they are not required for 7c3

 drivers/gpu/drm/msm/adreno/a6xx_gmu.c      |  8 ++++++--
 drivers/gpu/drm/msm/adreno/a6xx_gmu.h      |  1 +
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c      | 32 ++++++++++++++++++++----------
 drivers/gpu/drm/msm/adreno/a6xx_hfi.c      | 32 ++++++++++++++++++++++++++++++
 drivers/gpu/drm/msm/adreno/adreno_device.c | 11 ++++++++++
 drivers/gpu/drm/msm/adreno/adreno_gpu.h    | 14 ++++++++++++-
 6 files changed, 84 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index b349692..70ba3bf 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -519,7 +519,7 @@ static void a6xx_gmu_rpmh_init(struct a6xx_gmu *gmu)
 	if (!pdcptr)
 		goto err;
 
-	if (adreno_is_a650(adreno_gpu) || adreno_is_a660(adreno_gpu))
+	if (adreno_is_a650(adreno_gpu) || adreno_is_a660_family(adreno_gpu))
 		pdc_in_aop = true;
 	else if (adreno_is_a618(adreno_gpu) || adreno_is_a640(adreno_gpu))
 		pdc_address_offset = 0x30090;
@@ -933,6 +933,7 @@ int a6xx_gmu_resume(struct a6xx_gpu *a6xx_gpu)
 
 	/* Use a known rate to bring up the GMU */
 	clk_set_rate(gmu->core_clk, 200000000);
+	clk_set_rate(gmu->hub_clk, 150000000);
 	ret = clk_bulk_prepare_enable(gmu->nr_clocks, gmu->clocks);
 	if (ret) {
 		pm_runtime_put(gmu->gxpd);
@@ -1393,6 +1394,9 @@ static int a6xx_gmu_clocks_probe(struct a6xx_gmu *gmu)
 	gmu->core_clk = msm_clk_bulk_get_clock(gmu->clocks,
 		gmu->nr_clocks, "gmu");
 
+	gmu->hub_clk = msm_clk_bulk_get_clock(gmu->clocks,
+		gmu->nr_clocks, "hub");
+
 	return 0;
 }
 
@@ -1504,7 +1508,7 @@ int a6xx_gmu_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node)
 	 * are otherwise unused by a660.
 	 */
 	gmu->dummy.size = SZ_4K;
-	if (adreno_is_a660(adreno_gpu)) {
+	if (adreno_is_a660_family(adreno_gpu)) {
 		ret = a6xx_gmu_memory_alloc(gmu, &gmu->debug, SZ_4K * 7, 0x60400000);
 		if (ret)
 			goto err_memory;
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
index 71dfa600..3c74f64 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
@@ -66,6 +66,7 @@ struct a6xx_gmu {
 	int nr_clocks;
 	struct clk_bulk_data *clocks;
 	struct clk *core_clk;
+	struct clk *hub_clk;
 
 	/* current performance index set externally */
 	int current_perf_index;
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 0da1a66..1881e09 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -652,7 +652,7 @@ static void a6xx_set_cp_protect(struct msm_gpu *gpu)
 		regs = a650_protect;
 		count = ARRAY_SIZE(a650_protect);
 		count_max = 48;
-	} else if (adreno_is_a660(adreno_gpu)) {
+	} else if (adreno_is_a660_family(adreno_gpu)) {
 		regs = a660_protect;
 		count = ARRAY_SIZE(a660_protect);
 		count_max = 48;
@@ -694,6 +694,13 @@ static void a6xx_set_ubwc_config(struct msm_gpu *gpu)
 		uavflagprd_inv = 2;
 	}
 
+	if (adreno_is_7c3(adreno_gpu)) {
+		lower_bit = 1;
+		amsbc = 1;
+		rgb565_predicator = 1;
+		uavflagprd_inv = 2;
+	}
+
 	gpu_write(gpu, REG_A6XX_RB_NC_MODE_CNTL,
 		rgb565_predicator << 11 | amsbc << 4 | lower_bit << 1);
 	gpu_write(gpu, REG_A6XX_TPL1_NC_MODE_CNTL, lower_bit << 1);
@@ -787,7 +794,7 @@ static bool a6xx_ucode_check_version(struct a6xx_gpu *a6xx_gpu,
 		DRM_DEV_ERROR(&gpu->pdev->dev,
 			"a650 SQE ucode is too old. Have version %x need at least %x\n",
 			buf[0] & 0xfff, 0x095);
-	} else if (adreno_is_a660(adreno_gpu)) {
+	} else if (adreno_is_a660_family(adreno_gpu)) {
 		ret = true;
 	} else {
 		DRM_DEV_ERROR(&gpu->pdev->dev,
@@ -941,7 +948,7 @@ static int a6xx_hw_init(struct msm_gpu *gpu)
 		gpu_write(gpu, REG_A6XX_CP_ROQ_THRESHOLDS_2, 0x010000c0);
 	gpu_write(gpu, REG_A6XX_CP_ROQ_THRESHOLDS_1, 0x8040362c);
 
-	if (adreno_is_a660(adreno_gpu))
+	if (adreno_is_a660_family(adreno_gpu))
 		gpu_write(gpu, REG_A6XX_CP_LPAC_PROG_FIFO_SIZE, 0x00000020);
 
 	/* Setting the mem pool size */
@@ -950,10 +957,10 @@ static int a6xx_hw_init(struct msm_gpu *gpu)
 	/* Setting the primFifo thresholds default values,
 	 * and vccCacheSkipDis=1 bit (0x200) for A640 and newer
 	*/
-	if (adreno_is_a650(adreno_gpu) || adreno_is_a660(adreno_gpu))
-		gpu_write(gpu, REG_A6XX_PC_DBG_ECO_CNTL, 0x00300200);
-	else if (adreno_is_a640(adreno_gpu))
+	if (adreno_is_a640(adreno_gpu) || adreno_is_7c3(adreno_gpu))
 		gpu_write(gpu, REG_A6XX_PC_DBG_ECO_CNTL, 0x00200200);
+	else if (adreno_is_a650(adreno_gpu) || adreno_is_a660(adreno_gpu))
+		gpu_write(gpu, REG_A6XX_PC_DBG_ECO_CNTL, 0x00300200);
 	else
 		gpu_write(gpu, REG_A6XX_PC_DBG_ECO_CNTL, 0x00180000);
 
@@ -990,13 +997,15 @@ static int a6xx_hw_init(struct msm_gpu *gpu)
 	/* Protect registers from the CP */
 	a6xx_set_cp_protect(gpu);
 
-	if (adreno_is_a660(adreno_gpu)) {
+	if (adreno_is_a660_family(adreno_gpu)) {
 		gpu_write(gpu, REG_A6XX_CP_CHICKEN_DBG, 0x1);
 		gpu_write(gpu, REG_A6XX_RBBM_GBIF_CLIENT_QOS_CNTL, 0x0);
-		/* Set dualQ + disable afull for A660 GPU but not for A635 */
-		gpu_write(gpu, REG_A6XX_UCHE_CMDQ_CONFIG, 0x66906);
 	}
 
+	/* Set dualQ + disable afull for A660 GPU */
+	if (adreno_is_a660(adreno_gpu))
+		gpu_write(gpu, REG_A6XX_UCHE_CMDQ_CONFIG, 0x66906);
+
 	/* Enable expanded apriv for targets that support it */
 	if (gpu->hw_apriv) {
 		gpu_write(gpu, REG_A6XX_CP_APRIV_CNTL,
@@ -1434,7 +1443,7 @@ static void a6xx_llc_activate(struct a6xx_gpu *a6xx_gpu)
 	/* On A660, the SCID programming for UCHE traffic is done in
 	 * A6XX_GBIF_SCACHE_CNTL0[14:10]
 	 */
-	if (adreno_is_a660(adreno_gpu))
+	if (adreno_is_a660_family(adreno_gpu))
 		gpu_rmw(gpu, REG_A6XX_GBIF_SCACHE_CNTL0, (0x1f << 10) |
 			(1 << 8), (gpu_scid << 10) | (1 << 8));
 }
@@ -1779,7 +1788,8 @@ struct msm_gpu *a6xx_gpu_init(struct drm_device *dev)
 	 */
 	info = adreno_info(config->rev);
 
-	if (info && (info->revn == 650 || info->revn == 660))
+	if (info && (info->revn == 650 || info->revn == 660 ||
+			adreno_cmp_rev(ADRENO_REV(6, 3, 5, ANY_ID), info->rev)))
 		adreno_gpu->base.hw_apriv = true;
 
 	a6xx_llc_slices_init(pdev, a6xx_gpu);
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
index 9194337..1451c2b 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
@@ -382,6 +382,36 @@ static void a660_build_bw_table(struct a6xx_hfi_msg_bw_table *msg)
 	msg->cnoc_cmds_data[1][0] =  0x60000001;
 }
 
+static void adreno_7c3_build_bw_table(struct a6xx_hfi_msg_bw_table *msg)
+{
+	/*
+	 * Send a single "off" entry just to get things running
+	 * TODO: bus scaling
+	 */
+	msg->bw_level_num = 1;
+
+	msg->ddr_cmds_num = 3;
+	msg->ddr_wait_bitmask = 0x07;
+
+	msg->ddr_cmds_addrs[0] = 0x50004;
+	msg->ddr_cmds_addrs[1] = 0x50000;
+	msg->ddr_cmds_addrs[2] = 0x50088;
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
+	msg->cnoc_cmds_addrs[0] = 0x5006c;
+	msg->cnoc_cmds_data[0][0] =  0x40000000;
+	msg->cnoc_cmds_data[1][0] =  0x60000001;
+}
 static void a6xx_build_bw_table(struct a6xx_hfi_msg_bw_table *msg)
 {
 	/* Send a single "off" entry since the 630 GMU doesn't do bus scaling */
@@ -432,6 +462,8 @@ static int a6xx_hfi_send_bw_table(struct a6xx_gmu *gmu)
 		a640_build_bw_table(&msg);
 	else if (adreno_is_a650(adreno_gpu))
 		a650_build_bw_table(&msg);
+	else if (adreno_is_7c3(adreno_gpu))
+		adreno_7c3_build_bw_table(&msg);
 	else if (adreno_is_a660(adreno_gpu))
 		a660_build_bw_table(&msg);
 	else
diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index 7e6fafe..7b9d605 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -298,6 +298,17 @@ static const struct adreno_info gpulist[] = {
 		.init = a6xx_gpu_init,
 		.zapfw = "a660_zap.mdt",
 		.hwcg = a660_hwcg,
+	}, {
+		.rev = ADRENO_REV(6, 3, 5, ANY_ID),
+		.name = "Adreno 7c Gen 3",
+		.fw = {
+			[ADRENO_FW_SQE] = "a660_sqe.fw",
+			[ADRENO_FW_GMU] = "a660_gmu.bin",
+		},
+		.gmem = SZ_512K,
+		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
+		.init = a6xx_gpu_init,
+		.hwcg = a660_hwcg,
 	},
 };
 
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
index a368a16..1393f21 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
@@ -251,15 +251,27 @@ static inline int adreno_is_a650(struct adreno_gpu *gpu)
        return gpu->revn == 650;
 }
 
+static inline int adreno_is_7c3(struct adreno_gpu *gpu)
+{
+	/* The order of args is important here to handle ANY_ID correctly */
+       return adreno_cmp_rev(ADRENO_REV(6, 3, 5, ANY_ID), gpu->rev);
+}
+
 static inline int adreno_is_a660(struct adreno_gpu *gpu)
 {
        return gpu->revn == 660;
 }
 
+static inline int adreno_is_a660_family(struct adreno_gpu *gpu)
+{
+       return adreno_is_a660(gpu) || adreno_is_7c3(gpu);
+}
+
 /* check for a650, a660, or any derivatives */
 static inline int adreno_is_a650_family(struct adreno_gpu *gpu)
 {
-       return gpu->revn == 650 || gpu->revn == 620 || gpu->revn == 660;
+       return gpu->revn == 650 || gpu->revn == 620 ||
+	       adreno_is_a660_family(gpu);
 }
 
 int adreno_get_param(struct msm_gpu *gpu, uint32_t param, uint64_t *value);
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

