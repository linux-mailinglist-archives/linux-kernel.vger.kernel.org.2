Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3D883D4B24
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jul 2021 05:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbhGYClU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jul 2021 22:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbhGYClT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jul 2021 22:41:19 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B05C06175F
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 20:21:49 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id i39-20020a9d17270000b02904cf73f54f4bso4522513ota.2
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 20:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gsTOc+rL6lEAEpQSXvea66h2ZWJwfuK8xvAPUmJAZQI=;
        b=gnvBYzhUm3ydgVsFyglm2kP+QZCot55q8iUAD6sPh1zLPLsTe5RrT09O0uoMvoaCwn
         Rj84VKCzuUEIOhVWi4c0WFyeXr586GKnbosCCKQ+tJeIf+edJy1ocX3uZsLBTJ5lNVw7
         aAYH6D4f/izOD1eXU1hUUwQlhA8SbO3lBdbiAB63jvbTtuA2nPAOJeRR2bjSEUwv/Jwt
         qxMBpmPRlIKjXrl1CQvK7km3kdqDsqCPpV/6Egm02Mzb4fo5vyAZhkP82E8TxE3uotLq
         HDpdWCBbgJVbmLdk1RoMMhKpj7yrSUvDToMAJ8FZrUQLvfPLzQMKAL5JlRVLWoY0ygIE
         k9DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gsTOc+rL6lEAEpQSXvea66h2ZWJwfuK8xvAPUmJAZQI=;
        b=JC9dvfbLwzZXlAywUgRAhS06q/4PHCLYj0A6e1an8oFhOrQ75s6dQnJzmit0nFZlre
         hJ0KYLyGc08bXhUYBCZZT5dqvZjHmrasM6Hbqn0eTQVo6M1+EGxMzlamh+pJx5hvy7WE
         sGx81H/rDPNJvdsrQKyn7Wfqdkw7h4YwB7nPQLEbCYJ6gBqJd1Y5DjZkHJtL5B77OyM2
         OclMxwyMawstO4zsyw1W0UjVMgFNQlg4CReT3YeyFNuucNZZnMj+KFShC97VbkiqFRwm
         bGumvS6pSpgyiVeXS0zPsvSqtnoHgrnnyLf3LPxm8jtd/nsTau5XqUoIpupSfWD1bIPn
         0XYA==
X-Gm-Message-State: AOAM530Gu0tkgYoYRIoG/mAZhKZLv7xKDXpp0RUO45EXDuh0+O5H8qrE
        evyG8PlBCv2m4OgTTVIbC9e6QA==
X-Google-Smtp-Source: ABdhPJyf6p654Mek1ReOJlfg/V8CNaHDfEO820VLd2UQ6EH5SIlguppVKmBbPmT4H6S7ltrx0+VhYQ==
X-Received: by 2002:a9d:600a:: with SMTP id h10mr7593133otj.144.1627183308943;
        Sat, 24 Jul 2021 20:21:48 -0700 (PDT)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id r16sm5567139otu.26.2021.07.24.20.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jul 2021 20:21:48 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm: msm: Add 680 gpu to the adreno gpu list
Date:   Sat, 24 Jul 2021 20:20:02 -0700
Message-Id: <20210725032002.3961691-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a Adreno 680 entry to the gpulist.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c      |  5 +++--
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c      | 12 +++++++-----
 drivers/gpu/drm/msm/adreno/a6xx_hfi.c      |  2 +-
 drivers/gpu/drm/msm/adreno/adreno_device.c | 13 +++++++++++++
 drivers/gpu/drm/msm/adreno/adreno_gpu.h    |  5 +++++
 5 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index b349692219b7..1c0d75e1189f 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -521,7 +521,8 @@ static void a6xx_gmu_rpmh_init(struct a6xx_gmu *gmu)
 
 	if (adreno_is_a650(adreno_gpu) || adreno_is_a660(adreno_gpu))
 		pdc_in_aop = true;
-	else if (adreno_is_a618(adreno_gpu) || adreno_is_a640(adreno_gpu))
+	else if (adreno_is_a618(adreno_gpu) || adreno_is_a640(adreno_gpu) ||
+		 adreno_is_a680(adreno_gpu))
 		pdc_address_offset = 0x30090;
 	else
 		pdc_address_offset = 0x30080;
@@ -1522,7 +1523,7 @@ int a6xx_gmu_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node)
 			SZ_16M - SZ_16K, 0x04000);
 		if (ret)
 			goto err_memory;
-	} else if (adreno_is_a640(adreno_gpu)) {
+	} else if (adreno_is_a640(adreno_gpu) || adreno_is_a680(adreno_gpu)) {
 		ret = a6xx_gmu_memory_alloc(gmu, &gmu->icache,
 			SZ_256K - SZ_16K, 0x04000);
 		if (ret)
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 9c5e4618aa0a..5cdafc6c8bb0 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -683,7 +683,7 @@ static void a6xx_set_ubwc_config(struct msm_gpu *gpu)
 	if (adreno_is_a618(adreno_gpu))
 		return;
 
-	if (adreno_is_a640(adreno_gpu))
+	if (adreno_is_a640(adreno_gpu) || adreno_is_a680(adreno_gpu))
 		amsbc = 1;
 
 	if (adreno_is_a650(adreno_gpu) || adreno_is_a660(adreno_gpu)) {
@@ -757,7 +757,7 @@ static bool a6xx_ucode_check_version(struct a6xx_gpu *a6xx_gpu,
 	 * a660 targets have all the critical security fixes from the start
 	 */
 	if (adreno_is_a618(adreno_gpu) || adreno_is_a630(adreno_gpu) ||
-		adreno_is_a640(adreno_gpu)) {
+	    adreno_is_a640(adreno_gpu) || adreno_is_a680(adreno_gpu)) {
 		/*
 		 * If the lowest nibble is 0xa that is an indication that this
 		 * microcode has been patched. The actual version is in dword
@@ -897,7 +897,8 @@ static int a6xx_hw_init(struct msm_gpu *gpu)
 	a6xx_set_hwcg(gpu, true);
 
 	/* VBIF/GBIF start*/
-	if (adreno_is_a640(adreno_gpu) || adreno_is_a650_family(adreno_gpu)) {
+	if (adreno_is_a640(adreno_gpu) || adreno_is_a650_family(adreno_gpu) ||
+	    adreno_is_a680(adreno_gpu)) {
 		gpu_write(gpu, REG_A6XX_GBIF_QSB_SIDE0, 0x00071620);
 		gpu_write(gpu, REG_A6XX_GBIF_QSB_SIDE1, 0x00071620);
 		gpu_write(gpu, REG_A6XX_GBIF_QSB_SIDE2, 0x00071620);
@@ -935,7 +936,8 @@ static int a6xx_hw_init(struct msm_gpu *gpu)
 	gpu_write(gpu, REG_A6XX_UCHE_FILTER_CNTL, 0x804);
 	gpu_write(gpu, REG_A6XX_UCHE_CACHE_WAYS, 0x4);
 
-	if (adreno_is_a640(adreno_gpu) || adreno_is_a650_family(adreno_gpu))
+	if (adreno_is_a640(adreno_gpu) || adreno_is_a650_family(adreno_gpu) ||
+	    adreno_is_a680(adreno_gpu))
 		gpu_write(gpu, REG_A6XX_CP_ROQ_THRESHOLDS_2, 0x02000140);
 	else
 		gpu_write(gpu, REG_A6XX_CP_ROQ_THRESHOLDS_2, 0x010000c0);
@@ -952,7 +954,7 @@ static int a6xx_hw_init(struct msm_gpu *gpu)
 	*/
 	if (adreno_is_a650(adreno_gpu) || adreno_is_a660(adreno_gpu))
 		gpu_write(gpu, REG_A6XX_PC_DBG_ECO_CNTL, 0x00300200);
-	else if (adreno_is_a640(adreno_gpu))
+	else if (adreno_is_a640(adreno_gpu) || adreno_is_a680(adreno_gpu))
 		gpu_write(gpu, REG_A6XX_PC_DBG_ECO_CNTL, 0x00200200);
 	else
 		gpu_write(gpu, REG_A6XX_PC_DBG_ECO_CNTL, 0x00180000);
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
index 919433732b43..df8af237cf6a 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
@@ -428,7 +428,7 @@ static int a6xx_hfi_send_bw_table(struct a6xx_gmu *gmu)
 
 	if (adreno_is_a618(adreno_gpu))
 		a618_build_bw_table(&msg);
-	else if (adreno_is_a640(adreno_gpu))
+	else if (adreno_is_a640(adreno_gpu) || adreno_is_a680(adreno_gpu))
 		a640_build_bw_table(&msg);
 	else if (adreno_is_a650(adreno_gpu))
 		a650_build_bw_table(&msg);
diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index 6dad8015c9a1..799e4a35ca44 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -300,6 +300,19 @@ static const struct adreno_info gpulist[] = {
 		.init = a6xx_gpu_init,
 		.zapfw = "a660_zap.mdt",
 		.hwcg = a660_hwcg,
+	}, {
+		.rev = ADRENO_REV(6, 8, 0, ANY_ID),
+		.revn = 680,
+		.name = "A680",
+		.fw = {
+			[ADRENO_FW_SQE] = "a630_sqe.fw",
+			[ADRENO_FW_GMU] = "a640_gmu.bin",
+		},
+		.gmem = SZ_2M,
+		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
+		.init = a6xx_gpu_init,
+		.zapfw = "a640_zap.mdt",
+		.hwcg = a640_hwcg,
 	},
 };
 
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
index 8dbe0d157520..a7e843e81b1e 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
@@ -258,6 +258,11 @@ static inline int adreno_is_a650_family(struct adreno_gpu *gpu)
        return gpu->revn == 650 || gpu->revn == 620 || gpu->revn == 660;
 }
 
+static inline int adreno_is_a680(struct adreno_gpu *gpu)
+{
+       return gpu->revn == 680;
+}
+
 int adreno_get_param(struct msm_gpu *gpu, uint32_t param, uint64_t *value);
 const struct firmware *adreno_request_fw(struct adreno_gpu *adreno_gpu,
 		const char *fwname);
-- 
2.29.2

