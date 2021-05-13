Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BAA637FC4B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 19:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbhEMRSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 13:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbhEMRSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 13:18:44 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE17C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 10:17:32 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id j11so20251200qtn.12
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 10:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OWZAMSO2hYSW16tUIYHpicH/GLn/3fYypp5Jz9VSm00=;
        b=E7HOshN2Er3I4UfF4n/peggr8eR4WuZ8uunuphLdocHtt7r90Y53jO9WRxq3gY9C/I
         +x+X7fxwvAAqTj29LFiAwy5SBCiBJOc3mS3SozXZmTwnFOzVsC/lhKfisJYQLBd6chTk
         6669Oaxluf6lTGECVNHkmGNRi2Grbppi/gx1QYZEKO8naPyTQP3mtfUzqKcrNuB579Nh
         kikc2pmDEO62s0661xX04KgvWNd0mkIQx+Uc3uyk8Es630fRKDupdOcmOoskyfaTi8Gz
         qgPVhPp8ajSz9GNhbc+9cKmItvoyvjjjGDL2M1ESWiGwkBtHL4Emv/RZKBSVu2mnjrwL
         pG2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OWZAMSO2hYSW16tUIYHpicH/GLn/3fYypp5Jz9VSm00=;
        b=HwsJJTIj9pfSs9Jjgv8G4agDaS0UpfVVAapcVOwF0DacuBoip1RpVCliOflkbn9vUz
         0DzareXRHo+3qiq1SKasQH9tVqnvLa82OqDI+iiPjz2fq22XYDttvnTCxUhX7iLqp1xs
         A87xPKFOylY1RU8xYDnrhYEVtcRQzI+IOYSGlZ3YQ0c+o59ddjpuQPV3jUcZaQ6hvDmQ
         8IsHqMTXQyzWbizCOaq0aUXzi04/xo9ZdJP4mVxGdS/60aJUX6O46Mbc6yTTWQOqJYkl
         5V4RVLX7ibpR5dD3Rc6ymBZkD+uLCrvUAOfGy8kxDGeOaaWW9hJzkCXipTsR2UV6RoF9
         wFZQ==
X-Gm-Message-State: AOAM533nypCqGREBk9NmKkrPBdtLuYTDXkx+WUxEav9t0q3HAB+OZFY7
        K9MhtMMMGc2JHKyS35/GDVeuhw==
X-Google-Smtp-Source: ABdhPJynW10U6+pZDKPiqvMqVTGTcJYK/SyVqUlxAT1mqI+w5xVRJs3FIJt+9SBtPm/CN1CmeiTfaw==
X-Received: by 2002:ac8:7307:: with SMTP id x7mr38907975qto.144.1620926251991;
        Thu, 13 May 2021 10:17:31 -0700 (PDT)
Received: from localhost.localdomain (modemcable068.184-131-66.mc.videotron.ca. [66.131.184.68])
        by smtp.gmail.com with ESMTPSA id f132sm2971117qke.104.2021.05.13.10.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 10:17:31 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     freedreno@lists.freedesktop.org
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Dave Airlie <airlied@redhat.com>,
        Sharat Masetty <smasetty@codeaurora.org>,
        Akhil P Oommen <akhilpo@codeaurora.org>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 1/8] drm/msm: remove unused icc_path/ocmem_icc_path
Date:   Thu, 13 May 2021 13:13:56 -0400
Message-Id: <20210513171431.18632-2-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210513171431.18632-1-jonathan@marek.ca>
References: <20210513171431.18632-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These aren't used by anything anymore.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 3 ---
 drivers/gpu/drm/msm/msm_gpu.h           | 9 ---------
 2 files changed, 12 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 8fd0777f2dc9..009f4c560f16 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -946,7 +946,4 @@ void adreno_gpu_cleanup(struct adreno_gpu *adreno_gpu)
 	pm_runtime_disable(&priv->gpu_pdev->dev);
 
 	msm_gpu_cleanup(&adreno_gpu->base);
-
-	icc_put(gpu->icc_path);
-	icc_put(gpu->ocmem_icc_path);
 }
diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index 18baf935e143..c302ab7ffb06 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -118,15 +118,6 @@ struct msm_gpu {
 	struct clk *ebi1_clk, *core_clk, *rbbmtimer_clk;
 	uint32_t fast_rate;
 
-	/* The gfx-mem interconnect path that's used by all GPU types. */
-	struct icc_path *icc_path;
-
-	/*
-	 * Second interconnect path for some A3xx and all A4xx GPUs to the
-	 * On Chip MEMory (OCMEM).
-	 */
-	struct icc_path *ocmem_icc_path;
-
 	/* Hang and Inactivity Detection:
 	 */
 #define DRM_MSM_INACTIVE_PERIOD   66 /* in ms (roughly four frames) */
-- 
2.26.1

