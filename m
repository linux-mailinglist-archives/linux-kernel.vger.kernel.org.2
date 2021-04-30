Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85BC9370147
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 21:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbhD3TcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 15:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbhD3TcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 15:32:02 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87589C061343
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 12:31:12 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id d10so11705497pgf.12
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 12:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zoyc92td/lrE+1cEtuWT2gS23XHAVp7Jh+/xM6e703E=;
        b=I7NSjPjcc21r8BP/rzm9f+bbrdMrSfdOl1GG7A81BEWaP0eiPpYbOjNGk04Ui5rJTG
         /eJftYzh6EbB1TLCDCYovgIRxImMDyaBvtXHbZGYrTi7TpyW3dhW15ajxXC6WM4+kmQI
         BD+z0XK9QOaHRLs6w0I3P6ck8mPCG4Qp1zfWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zoyc92td/lrE+1cEtuWT2gS23XHAVp7Jh+/xM6e703E=;
        b=iy4PkAh6lhDWKmMuOd2AubnDnUKVgNQUH3BEaUbW5wNA4y/diixNA/cGsxNFXQ8kKF
         nF92xNN22xmAmbyIoFmJArjHD8Wlsn1T0rOikSswIodxqCHpNf3BecWBQJVnMn9nBNTK
         ebZhjxCHml5VuSNrjr55GdMHaPxIFo5+KhosUs+e8zLkulAvUKEq2il9553eAx+i9DIv
         OPT6d3GCJLThCQZArjZZS/72HPEP+M0g9UM2ys4652a98RDRSIA4TXrIp3yhWrZl2L7x
         W4t6ixm5fs1K7H52mAvQUdFCB9t2jnPjV6/KnMQ331XA/AykGZSPZX32OUwD5k5grigj
         v81A==
X-Gm-Message-State: AOAM531ycUjZ8pNJRZlhTGUn8JECvkwj6HJCzu90E7WqsIDbuVug68EH
        tJ6LJyiUmrr++XWHpQJZW6brww==
X-Google-Smtp-Source: ABdhPJw36DyEYB6yLssWTFLdRf6MVS2ZLnjGsTHpD+bVS+765gw4Cq3zqa8hvb03GUCQ6sTh+x1KJA==
X-Received: by 2002:a05:6a00:b82:b029:27f:dffe:214c with SMTP id g2-20020a056a000b82b029027fdffe214cmr6546945pfj.57.1619811072112;
        Fri, 30 Apr 2021 12:31:12 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:dacb:8fee:a41f:12ac])
        by smtp.gmail.com with ESMTPSA id t6sm3143500pjl.57.2021.04.30.12.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 12:31:11 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Rob Clark <robdclark@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Kuogee Hsieh <khsieh@codeaurora.org>, aravindh@codeaurora.org,
        Sean Paul <sean@poorly.run>
Subject: [PATCH 5/6] drm/msm/disp: Use plane debug print helper
Date:   Fri, 30 Apr 2021 12:31:03 -0700
Message-Id: <20210430193104.1770538-6-swboyd@chromium.org>
X-Mailer: git-send-email 2.31.1.527.g47e6f16901-goog
In-Reply-To: <20210430193104.1770538-1-swboyd@chromium.org>
References: <20210430193104.1770538-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the DPU_DEBUG_PLANE() helper to print the plane number instead of
open coding it.

Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Abhinav Kumar <abhinavk@codeaurora.org>
Cc: Kuogee Hsieh <khsieh@codeaurora.org>
Cc: aravindh@codeaurora.org
Cc: Sean Paul <sean@poorly.run>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
index f898a8f67b7f..3f5626832c9e 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
@@ -283,8 +283,8 @@ static int _dpu_plane_calc_fill_level(struct drm_plane *plane,
 		}
 	}
 
-	DPU_DEBUG("plane%u: pnum:%d fmt: %4.4s w:%u fl:%u\n",
-			plane->base.id, pdpu->pipe - SSPP_VIG0,
+	DPU_DEBUG_PLANE(pdpu, "pnum:%d fmt: %4.4s w:%u fl:%u\n",
+			pdpu->pipe - SSPP_VIG0,
 			(char *)&fmt->base.pixel_format,
 			src_width, total_fl);
 
@@ -353,8 +353,7 @@ static void _dpu_plane_set_qos_lut(struct drm_plane *plane,
 			(fmt) ? fmt->base.pixel_format : 0,
 			pdpu->is_rt_pipe, total_fl, qos_lut, lut_usage);
 
-	DPU_DEBUG("plane%u: pnum:%d fmt: %4.4s rt:%d fl:%u lut:0x%llx\n",
-			plane->base.id,
+	DPU_DEBUG_PLANE(pdpu, "pnum:%d fmt: %4.4s rt:%d fl:%u lut:0x%llx\n",
 			pdpu->pipe - SSPP_VIG0,
 			fmt ? (char *)&fmt->base.pixel_format : NULL,
 			pdpu->is_rt_pipe, total_fl, qos_lut);
@@ -406,8 +405,7 @@ static void _dpu_plane_set_danger_lut(struct drm_plane *plane,
 			pdpu->pipe_qos_cfg.danger_lut,
 			pdpu->pipe_qos_cfg.safe_lut);
 
-	DPU_DEBUG("plane%u: pnum:%d fmt: %4.4s mode:%d luts[0x%x, 0x%x]\n",
-		plane->base.id,
+	DPU_DEBUG_PLANE(pdpu, "pnum:%d fmt: %4.4s mode:%d luts[0x%x, 0x%x]\n",
 		pdpu->pipe - SSPP_VIG0,
 		fmt ? (char *)&fmt->base.pixel_format : NULL,
 		fmt ? fmt->fetch_mode : -1,
@@ -450,8 +448,7 @@ static void _dpu_plane_set_qos_ctrl(struct drm_plane *plane,
 		pdpu->pipe_qos_cfg.danger_safe_en = false;
 	}
 
-	DPU_DEBUG("plane%u: pnum:%d ds:%d vb:%d pri[0x%x, 0x%x] is_rt:%d\n",
-		plane->base.id,
+	DPU_DEBUG_PLANE(pdpu, "pnum:%d ds:%d vb:%d pri[0x%x, 0x%x] is_rt:%d\n",
 		pdpu->pipe - SSPP_VIG0,
 		pdpu->pipe_qos_cfg.danger_safe_en,
 		pdpu->pipe_qos_cfg.vblank_en,
@@ -506,8 +503,8 @@ static void _dpu_plane_set_qos_remap(struct drm_plane *plane)
 	qos_params.num = pdpu->pipe_hw->idx - SSPP_VIG0;
 	qos_params.is_rt = pdpu->is_rt_pipe;
 
-	DPU_DEBUG("plane%d pipe:%d vbif:%d xin:%d rt:%d, clk_ctrl:%d\n",
-			plane->base.id, qos_params.num,
+	DPU_DEBUG_PLANE(pdpu, "pipe:%d vbif:%d xin:%d rt:%d, clk_ctrl:%d\n",
+			qos_params.num,
 			qos_params.vbif_idx,
 			qos_params.xin_id, qos_params.is_rt,
 			qos_params.clk_ctrl);
-- 
https://chromeos.dev

