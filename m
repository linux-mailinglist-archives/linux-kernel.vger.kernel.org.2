Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5483DA7A5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 17:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237449AbhG2Pbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 11:31:45 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:61742 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237794AbhG2Pbm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 11:31:42 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1627572699; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=4H3jYkElAs1QyW2ncrox+PElUWZ1CeNfk5nXkU3IPbw=; b=POGBhXTdeA2f9vjp7pFuGOpOwuAVRq1WiKJ8QNjERZvegwzqVyTplZt7qjl64SRYC1mKn64C
 EykDEQ6hEte5dpthfGmBE7uxxBMLlemqxHBMu9RJMQXixct57b9IsjiTRFMltWokA2nr77vn
 oLeUI/Y+0Z3rqO96PwptItU/t1w=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 6102c9b738fa9bfe9c2a5d90 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 29 Jul 2021 15:31:03
 GMT
Sender: akhilpo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2BE2DC43144; Thu, 29 Jul 2021 15:31:03 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from hyd-lnxbld559.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akhilpo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D8AD6C4338A;
        Thu, 29 Jul 2021 15:30:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D8AD6C4338A
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=akhilpo@codeaurora.org
From:   Akhil P Oommen <akhilpo@codeaurora.org>
To:     freedreno <freedreno@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@gmail.com>
Cc:     Jordan Crouse <jordan@cosmicpenguin.net>,
        Douglas Anderson <dianders@chromium.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Matthias Kaehlcke <mka@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Sean Paul <sean@poorly.run>,
        Sharat Masetty <smasetty@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH] drm/msm: Introduce Adreno Features
Date:   Thu, 29 Jul 2021 21:00:40 +0530
Message-Id: <20210729205906.RFC.1.I5645753650f32d9b469d6183a5fd8e5e65a7b7a4@changeid>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a feature flag in gpulist to easily identify the capabilities
of each gpu revision. This will help to avoid a lot of adreno_is_axxx()
check when we add new features. In the current patch, HW APRIV feature
is converted to a feature flag.

Signed-off-by: Akhil P Oommen <akhilpo@codeaurora.org>
---
This patch is rebased on top of the below series:
https://patchwork.freedesktop.org/series/93192/

 drivers/gpu/drm/msm/adreno/a6xx_gpu.c      | 12 ------------
 drivers/gpu/drm/msm/adreno/adreno_device.c |  3 +++
 drivers/gpu/drm/msm/adreno/adreno_gpu.c    |  3 +++
 drivers/gpu/drm/msm/adreno/adreno_gpu.h    |  9 +++++++++
 4 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 1881e09..b28305b 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -1765,7 +1765,6 @@ struct msm_gpu *a6xx_gpu_init(struct drm_device *dev)
 	struct msm_drm_private *priv = dev->dev_private;
 	struct platform_device *pdev = priv->gpu_pdev;
 	struct adreno_platform_config *config = pdev->dev.platform_data;
-	const struct adreno_info *info;
 	struct device_node *node;
 	struct a6xx_gpu *a6xx_gpu;
 	struct adreno_gpu *adreno_gpu;
@@ -1781,17 +1780,6 @@ struct msm_gpu *a6xx_gpu_init(struct drm_device *dev)
 
 	adreno_gpu->registers = NULL;
 
-	/*
-	 * We need to know the platform type before calling into adreno_gpu_init
-	 * so that the hw_apriv flag can be correctly set. Snoop into the info
-	 * and grab the revision number
-	 */
-	info = adreno_info(config->rev);
-
-	if (info && (info->revn == 650 || info->revn == 660 ||
-			adreno_cmp_rev(ADRENO_REV(6, 3, 5, ANY_ID), info->rev)))
-		adreno_gpu->base.hw_apriv = true;
-
 	a6xx_llc_slices_init(pdev, a6xx_gpu);
 
 	ret = a6xx_set_supported_hw(&pdev->dev, config->rev);
diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index 7b9d605..44321ec 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -276,6 +276,7 @@ static const struct adreno_info gpulist[] = {
 		.rev = ADRENO_REV(6, 5, 0, ANY_ID),
 		.revn = 650,
 		.name = "A650",
+		.features = ADRENO_APRIV,
 		.fw = {
 			[ADRENO_FW_SQE] = "a650_sqe.fw",
 			[ADRENO_FW_GMU] = "a650_gmu.bin",
@@ -289,6 +290,7 @@ static const struct adreno_info gpulist[] = {
 		.rev = ADRENO_REV(6, 6, 0, ANY_ID),
 		.revn = 660,
 		.name = "A660",
+		.features = ADRENO_APRIV,
 		.fw = {
 			[ADRENO_FW_SQE] = "a660_sqe.fw",
 			[ADRENO_FW_GMU] = "a660_gmu.bin",
@@ -301,6 +303,7 @@ static const struct adreno_info gpulist[] = {
 	}, {
 		.rev = ADRENO_REV(6, 3, 5, ANY_ID),
 		.name = "Adreno 7c Gen 3",
+		.features = ADRENO_APRIV,
 		.fw = {
 			[ADRENO_FW_SQE] = "a660_sqe.fw",
 			[ADRENO_FW_GMU] = "a660_gmu.bin",
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 9f5a302..e8acadf5 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -945,6 +945,9 @@ int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 	pm_runtime_use_autosuspend(dev);
 	pm_runtime_enable(dev);
 
+	if (ADRENO_FEAT(adreno_gpu, ADRENO_APRIV))
+		adreno_gpu->base.hw_apriv = true;
+
 	return msm_gpu_init(drm, pdev, &adreno_gpu->base, &funcs->base,
 			adreno_gpu->info->name, &adreno_gpu_config);
 }
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
index 50b4d53..61797c3 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
@@ -35,6 +35,11 @@ enum adreno_quirks {
 	ADRENO_QUIRK_LMLOADKILL_DISABLE = 3,
 };
 
+enum adreno_features {
+	/* ADRENO has HW APRIV feature */
+	ADRENO_APRIV,
+};
+
 struct adreno_rev {
 	uint8_t  core;
 	uint8_t  major;
@@ -63,6 +68,7 @@ struct adreno_info {
 	struct adreno_rev rev;
 	uint32_t revn;
 	const char *name;
+	u32 features;
 	const char *fw[ADRENO_FW_MAX];
 	uint32_t gmem;
 	enum adreno_quirks quirks;
@@ -388,6 +394,9 @@ static inline uint32_t get_wptr(struct msm_ringbuffer *ring)
 	return (ring->cur - ring->start) % (MSM_GPU_RINGBUFFER_SZ >> 2);
 }
 
+#define ADRENO_FEAT(adreno_gpu, feature) \
+	(adreno_gpu->info->features & (1 << feature))
+
 /*
  * Given a register and a count, return a value to program into
  * REG_CP_PROTECT_REG(n) - this will block both reads and writes for _len
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

