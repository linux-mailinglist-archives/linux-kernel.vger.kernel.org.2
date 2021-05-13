Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18E2837F09B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 02:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233345AbhEMAq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 20:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238352AbhEMAlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 20:41:05 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F40C0613ED
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 17:39:03 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id o27so24116125qkj.9
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 17:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OWZAMSO2hYSW16tUIYHpicH/GLn/3fYypp5Jz9VSm00=;
        b=U4o7cwX2QQVVTuDryXGCKWLw0coEb16npVBu/jFofLo4GTjmsF8dA6MYmsiPfPhL6k
         7aMlrAqXx/H6Pa4kuBluRMbfC247VwlqE0yooUKjYvApRKrTskwNrJBHYywJUAG2X7ZA
         VQXOMtLtIOPk3tDvIg5SVdRe9RAwpOkkNNNFBVO9EHxnkLiovJXusp6fgipw2FGdIazc
         cjmJd/iLu+KsJIxKRLXf4zI1sOEvxLypncNuNAUbrYar2eBfztYVQSj/RZ2iqy5QXSXb
         2xhLZY6lyGwAnZZBDNeBnBzMFx55muQBXIO7309s7AB4U2TuElmMFmNEZQZL0Ogeze8S
         WZTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OWZAMSO2hYSW16tUIYHpicH/GLn/3fYypp5Jz9VSm00=;
        b=BSazOJpi3HeYDbVriKDT4s6c/3Y4uTVOrTe2QuC8hY+x0FAmxjoS9TwkJb/aZFAM7X
         cuL2fM1MtAFhENnI6soIqlRxcOWL6jo0uB93B4nQ/UGUsVwz28bflu+994FZMoClx/Sv
         04zKXgu2C3L25C+O+tSH67y3LAgnlbwU5Ct264xFya/fAO6Qa6HLrcnGYVHA7UiK+Bud
         sHUfbf7ujBeOtIG2eykw47AEM4d9AiqYUd2q43oylZ6z+zCQdWlQz3G6Le6KtMgyz78G
         tUN5mHYdS/dCynUAbENwPTDZLl0dI6+YwMWk0H4qdvvEEZ4ynad/NArb1QFxZIqqHb7v
         v+qQ==
X-Gm-Message-State: AOAM530wGIt8Tpo2Ui5I0bysjpED6oM2CMywp9nS/bPnHhfX1aX7l4VP
        joxzQ5OK4VDeE1r1MVY8eWhMIA==
X-Google-Smtp-Source: ABdhPJyDGD9edTt/pecm2J2HYiTGtCLsMV1PL5FrxPOMfc9PT5J5phKcxKXCTRi/AnZO7jbXTmddog==
X-Received: by 2002:a37:4017:: with SMTP id n23mr34108146qka.338.1620866343100;
        Wed, 12 May 2021 17:39:03 -0700 (PDT)
Received: from localhost.localdomain (modemcable068.184-131-66.mc.videotron.ca. [66.131.184.68])
        by smtp.gmail.com with ESMTPSA id w16sm1204201qts.70.2021.05.12.17.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 17:39:02 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     freedreno@lists.freedesktop.org
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sharat Masetty <smasetty@codeaurora.org>,
        Akhil P Oommen <akhilpo@codeaurora.org>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/5] drm/msm: remove unused icc_path/ocmem_icc_path
Date:   Wed, 12 May 2021 20:37:45 -0400
Message-Id: <20210513003811.29578-2-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210513003811.29578-1-jonathan@marek.ca>
References: <20210513003811.29578-1-jonathan@marek.ca>
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

