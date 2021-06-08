Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4B739FDAB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 19:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233536AbhFHRb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 13:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233437AbhFHRby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 13:31:54 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8EAAC061789
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jun 2021 10:30:01 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id u13so11220822qvt.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 10:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cw/T67Raxlwp2J/xqRY1bIakrTpt8tOc7nmYdzBT6xs=;
        b=1T31TM63QiG2dKOFLdxurQr/m4Jmu5IwlHOD35wSveX6hm7+yCwgqyYw4UCKmYnBra
         XsSY4CZA+kc/UHkyzOTr4jFaB1xQRBcUJFpppcq85vuGfL8yN42svxL6IvzlEO0DYMC9
         qudTb9KNNaXpopN/T/MiY7NCPyZC1M/5+jR2RWEqHoKfT+H3+L/jsjTbIo69Ic194UPm
         motbyKq9g//QQaFnXILWb6bl8i9EJukaHvgaGkdWK5bs3/OrGnsRkqOiLJALl/7A7iNE
         hIReNAt5rWTFND601Yn8TT2tEHWuM56boRjYz/SFlXwCzFWK9E+Qpn9meiyYgs0n9QOx
         nYcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cw/T67Raxlwp2J/xqRY1bIakrTpt8tOc7nmYdzBT6xs=;
        b=ql9MvfG9y27eOuXKOCmlvyoxqrOig9fw3LeDGIgifm3H0mTOoYMROa6Z6rt5yT2yYE
         tYHnXwE6lFJxGITqH/a4Lc2JWsaDWRRw4pN8OvDTQJFqzcwK7f0XAnSEZA75O22B7a4L
         h00QQVME4SuZMleVChJ/usXmn843AhCyYwjnGrf6SiNkXkwnFUePN145EioKVLpzTrv6
         7aA07GnEksd/XtpbjV9aeemyCrog0eb6cGHPI/gXNNURrJRpWlLaVYPDNrPiBcnYN9RR
         5Q/e0r4aJ7E7EaiLzW9PHWaGoVKJcys6WqhVCtMnHDiiaD3dSgVAOZE54gZoMSj8OSGn
         NFMQ==
X-Gm-Message-State: AOAM532NEDSbGoo8e4ioTOrvurUwOqBcjIcp2UKPPNxOokJ0BJqnUc6Y
        YtMutfb2FI+yE/HkzRaupxesgg==
X-Google-Smtp-Source: ABdhPJy3w3HKrVCLTroG4bo1kOv1Rypz99JMObgdkPPBnC36pyGLQe2FP3KEN4BIeSxcP+h24xA/HA==
X-Received: by 2002:a0c:f650:: with SMTP id s16mr1269451qvm.0.1623173400924;
        Tue, 08 Jun 2021 10:30:00 -0700 (PDT)
Received: from localhost.localdomain (modemcable068.184-131-66.mc.videotron.ca. [66.131.184.68])
        by smtp.gmail.com with ESMTPSA id d10sm9482983qke.47.2021.06.08.10.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 10:30:00 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     freedreno@lists.freedesktop.org
Cc:     Akhil P Oommen <akhilpo@codeaurora.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Dave Airlie <airlied@redhat.com>,
        Sharat Masetty <smasetty@codeaurora.org>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 1/5] drm/msm: remove unused icc_path/ocmem_icc_path
Date:   Tue,  8 Jun 2021 13:27:44 -0400
Message-Id: <20210608172808.11803-2-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210608172808.11803-1-jonathan@marek.ca>
References: <20210608172808.11803-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These aren't used by anything anymore.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
Reviewed-by: Akhil P Oommen <akhilpo@codeaurora.org>
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

