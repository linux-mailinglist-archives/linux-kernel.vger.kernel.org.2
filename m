Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43CDC39FDBC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 19:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233281AbhFHRdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 13:33:05 -0400
Received: from mail-qk1-f170.google.com ([209.85.222.170]:33664 "EHLO
        mail-qk1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233673AbhFHRdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 13:33:03 -0400
Received: by mail-qk1-f170.google.com with SMTP id k4so21026344qkd.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 10:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4A/Pcyw+QD8Ug/Nt2Xmd1/EAfukVYO4RIkYOrmyswQM=;
        b=G1CaD5y6gwymINmHtsKEhWsaqJxxFVGj6787Wi/WaUi0ibM0X5gQeT7WW6yY0pEqS/
         3StBiA+9Fs6AXgzwfa2bIyqtGJyEuBOHjnXzkH2/WxlBTj6rbZe5ZIlhpuzOtnBAb9Hq
         4eGjLJiUi7c554WRkGjh/BGMvOUdNTc1IoeLLxHl7f6wbMkW1CHteyEy2tsjqsEpfZHY
         o8CSRZut2bTqhw8QmfqUq5t2xEH+RKRosHMzemv8JJBUqm37s1A8j62TPn/CfHjCfydp
         gzVypgdBjcGn7zKoB1akl6XvmI8kG3c7gzJWTb152tPbyu/BimAhaYfXB6I9OGVJTYyc
         evJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4A/Pcyw+QD8Ug/Nt2Xmd1/EAfukVYO4RIkYOrmyswQM=;
        b=QHNaAPPihswBPuvo9TOGSKO2VvwbXxraclZauCAmKJxU59s5OA7uHqv1+EZrHGeoN7
         1hXHyuxLKyYW6MQkB9r2qDjZGX4j+Ag9vQSMxNkDyaoN38Pmsre3/wXeKTt4l0SmT7eP
         7b53Yqx64rPnMzNmFkIyuFD7h9GukC3O6PkPXUmUPOiKiuBKaethisxS5i26RzEutGq+
         TSwNZdNpXnOdjSpAg98FXFePKwu2ACivmrp1no3HajjRFEKxDDzj+Mzdgk7fSo0A+nyj
         ZuRMAuQ8REx9lO4cmvE0w4p5I9vjbqLYIkd2OpcIsfpCPLojlr8w4CNzDpvvb3dYurqd
         PScg==
X-Gm-Message-State: AOAM531bcjhyMOXGHR66Zhvx28sH3ysZ4p+ScPAznD0g0XHmDOF1TYpd
        9FFiS4Sr3x27wNGs6+UUJXATjA==
X-Google-Smtp-Source: ABdhPJzTo4VczO5D3fNE/OOCfEaOjp6b6rtTfwnhjqlgt3NXWkN04Lg7T/UGxCTR954ZwROyXIX2Cg==
X-Received: by 2002:a37:71c5:: with SMTP id m188mr7310523qkc.97.1623173410212;
        Tue, 08 Jun 2021 10:30:10 -0700 (PDT)
Received: from localhost.localdomain (modemcable068.184-131-66.mc.videotron.ca. [66.131.184.68])
        by smtp.gmail.com with ESMTPSA id d10sm9482983qke.47.2021.06.08.10.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 10:30:09 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     freedreno@lists.freedesktop.org
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Akhil P Oommen <akhilpo@codeaurora.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Eric Anholt <eric@anholt.net>,
        Sharat Masetty <smasetty@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 4/5] drm/msm/a6xx: add missing PC_DBG_ECO_CNTL bit for a640/a650
Date:   Tue,  8 Jun 2021 13:27:47 -0400
Message-Id: <20210608172808.11803-5-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210608172808.11803-1-jonathan@marek.ca>
References: <20210608172808.11803-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

See downstream's "disable_tseskip" flag.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 853be7651623..bbbf90d86828 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -844,13 +844,15 @@ static int a6xx_hw_init(struct msm_gpu *gpu)
 	/* Setting the mem pool size */
 	gpu_write(gpu, REG_A6XX_CP_MEM_POOL_SIZE, 128);
 
-	/* Setting the primFifo thresholds default values */
+	/* Setting the primFifo thresholds default values,
+	 * and vccCacheSkipDis=1 bit (0x200) for A640 and newer
+	*/
 	if (adreno_is_a650(adreno_gpu))
-		gpu_write(gpu, REG_A6XX_PC_DBG_ECO_CNTL, 0x00300000);
+		gpu_write(gpu, REG_A6XX_PC_DBG_ECO_CNTL, 0x00300200);
 	else if (adreno_is_a640(adreno_gpu))
-		gpu_write(gpu, REG_A6XX_PC_DBG_ECO_CNTL, 0x00200000);
+		gpu_write(gpu, REG_A6XX_PC_DBG_ECO_CNTL, 0x00200200);
 	else
-		gpu_write(gpu, REG_A6XX_PC_DBG_ECO_CNTL, (0x300 << 11));
+		gpu_write(gpu, REG_A6XX_PC_DBG_ECO_CNTL, 0x00180000);
 
 	/* Set the AHB default slave response to "ERROR" */
 	gpu_write(gpu, REG_A6XX_CP_AHB_CNTL, 0x1);
-- 
2.26.1

