Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B100370137
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 21:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbhD3Tb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 15:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbhD3Tbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 15:31:55 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396B5C06138B
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 12:31:07 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id s20so21317476plr.13
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 12:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XCEZUZsej6PYGYdfrUSAPElJP+cMh+qBBhd7LIg8wdA=;
        b=KoB3ejoz2F2gX3PDhdj/9gZXL01KuXoWg+k+QDyqJvO3zdZBamHkKjdfpDYEjKvt67
         +L4tRNbFUd8f5kLuSaQoJ6Y225lSdr/EGRvlVZ567+pRV8SCOghVvu2vv/vtXah3AVZM
         O9suig51wjCyf/OdskvmTGYMBq01LKFlippMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XCEZUZsej6PYGYdfrUSAPElJP+cMh+qBBhd7LIg8wdA=;
        b=Ljajck22plh6zKcgEZVWbHru36bjiaaxNfcOq+tHDbN2T4u91dP25YaI6RVPT/oXH9
         883rux4L/FpF+r8iSxTS0be9rhkAydwElm7Lo+kJqUm7lnrVjCDUjsMyvuP6iaf1S+I3
         IOmHoOyfQ/P3MwkcaYWMdwQZ+MFdLCrYdpMQRT8HtewF/7jMQTNSl5G3r8XsP1mIa5CL
         qnEZ8Tfj7GR5/Rvk0DLkmRhGRwtxJj85O3KjdlbtEHg+5jFC96I7WLo7mYAg2OOlQWP7
         wF9Fkg4aX6iWOqCv1N9yPg8KmDRpDdF96mfx/SBBXYz970GU+Be7uYI8d/0kuSvEEFvY
         bb8A==
X-Gm-Message-State: AOAM533C2G9GXgQC37OXgsYn/vm3nvKY76FfCaIIJhlvMiGZweGD9odx
        mR8TCF+YHq46CxdYmFWcYH+9tg==
X-Google-Smtp-Source: ABdhPJzfRGR6XuD7lIQKGyXCXKEG4HC9T/S8Nnlka/0tDSwrbt4yC2zH6wZ/u2spHOidfnmVgIGaeQ==
X-Received: by 2002:a17:90a:a78c:: with SMTP id f12mr16598779pjq.219.1619811066715;
        Fri, 30 Apr 2021 12:31:06 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:dacb:8fee:a41f:12ac])
        by smtp.gmail.com with ESMTPSA id t6sm3143500pjl.57.2021.04.30.12.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 12:31:06 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Rob Clark <robdclark@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Kuogee Hsieh <khsieh@codeaurora.org>, aravindh@codeaurora.org,
        Sean Paul <sean@poorly.run>
Subject: [PATCH 0/6] drm/msm: Trim down drm debugging logs
Date:   Fri, 30 Apr 2021 12:30:58 -0700
Message-Id: <20210430193104.1770538-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.31.1.527.g47e6f16901-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series attempts to trim down the drm logging in the msm
driver to make it useable with DRM_UT_DRIVER, DRM_UT_KMS, and DRM_UT_DP
levels enabled. Right now the log is really spammy and prints multiple
lines for what feels like every frame. I moved those prints off to
other DRM_UT_* levels that felt appropriate. Please review.

Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Abhinav Kumar <abhinavk@codeaurora.org>
Cc: Kuogee Hsieh <khsieh@codeaurora.org>
Cc: aravindh@codeaurora.org
Cc: Sean Paul <sean@poorly.run>

Stephen Boyd (6):
  drm/msm: Move vblank debug prints to drm_dbg_vbl()
  drm/msm: Use VERB() for extra verbose logging
  drm/msm/dp: Drop malformed debug print
  drm/msm: Move FB debug prints to drm_dbg_state()
  drm/msm/disp: Use plane debug print helper
  drm/msm/disp: Move various debug logs to atomic bucket

 drivers/gpu/drm/msm/adreno/adreno_gpu.c       |  2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_core_irq.c  | 16 ++++----
 drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c | 22 +++++------
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c      | 38 +++++++++----------
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c   | 10 ++---
 .../drm/msm/disp/dpu1/dpu_encoder_phys_vid.c  |  2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c   |  6 +--
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c     | 19 ++++------
 drivers/gpu/drm/msm/disp/dpu1/dpu_vbif.c      | 14 +++----
 drivers/gpu/drm/msm/dp/dp_panel.c             |  1 -
 drivers/gpu/drm/msm/msm_drv.c                 |  4 +-
 drivers/gpu/drm/msm/msm_fb.c                  |  8 ++--
 12 files changed, 67 insertions(+), 75 deletions(-)


base-commit: 9f4ad9e425a1d3b6a34617b8ea226d56a119a717
-- 
https://chromeos.dev

