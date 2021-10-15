Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4328442FE94
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 01:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243473AbhJOXN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 19:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238995AbhJOXN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 19:13:26 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 310FBC061570
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 16:11:19 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id d21-20020a9d4f15000000b0054e677e0ac5so59628otl.11
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 16:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HUmZDgtmuXy7pQJ38Tzw5qxbkrp4xNejQK3lDNZjLFg=;
        b=vkr6f/Hnqm9g23KalLp7H/Lvpczy/LuFqXn7egw6IF25H2KapElTrVg3Oqh1ajaUZY
         ulzMIZfZog772rpAe5L1W7zbyXfyvIJ+b8YfW/EWJ/n7Ono02IFwDP58Tl7GGuhp3RNn
         a/IUG0Fj6kytSJpwHC6E9t/JWfxDXMxBV5F3XYTdPqwAWsIsIor7koJ8WK5B5Pv3jmSU
         rOOEO8VcI2OecCLlM/twc+zcaPYuWkg+Q9q13hisWtswSTJK5QRvsD7VxwS6nNUcSIgB
         pipXe5b7SwCtu69ZrAhp/LhgXR6gPTNVPqedmym1S5l34I4IvmgPInmbyuYxoH28qvkF
         O1fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HUmZDgtmuXy7pQJ38Tzw5qxbkrp4xNejQK3lDNZjLFg=;
        b=eLzKy1RES9MTDXnBa2g72AoX5sZfiPo3VbZ51XjUilXVzwgpXN9K3O1S1CSgKRXaLm
         UT38apnwWjcNL2DYsvP0GMeCjc5LU2ArxyYyvpPLRWlFeyuAKAFI8TX2Xhdoz+A8HxaN
         3FNJKH6SKip20ZeHuOV+JqIe5YYREwt0IeCwag7TGXbKe609MhyfX9UEBWh93P5ex+JL
         FN+5wc42yIWs2wgJf5eu2u/AMKyjobMTRiuN/n+n6zx4m+t8KzZ3zUpoXntK+vef0bPQ
         VcsSif/VGGtEjpIZaoq5P4JsvGQZ1D4cZfbAAjDEjrGCZ6YXn4NMT9QEmvWiz8LbM41W
         hNag==
X-Gm-Message-State: AOAM530D5MaMShh248z9QcZUu8/sS/Ki2mtkvxo3hCQ95fYtxmZT3Lzh
        fBExjv7URURf4PrKrltRaU08WA==
X-Google-Smtp-Source: ABdhPJzF/3yWadmmoHsXojqWAjiA8AD4RF0snFNDRgkCZDIdsm7bW/taSm0djFzOBF5ICbjuMjL3OA==
X-Received: by 2002:a9d:a61:: with SMTP id 88mr10612502otg.152.1634339478519;
        Fri, 15 Oct 2021 16:11:18 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id 103sm1527969otj.44.2021.10.15.16.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 16:11:18 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kuogee Hsieh <khsieh@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/msm/dp: Only create debugfs for PRIMARY minor
Date:   Fri, 15 Oct 2021 16:13:07 -0700
Message-Id: <20211015231307.1784165-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dpu_kms_debugfs_init() and hence dp_debug_get() gets invoked for each
minor being registered. But dp_debug_get() will allocate a new struct
dp_debug for each call and this will be associated as dp->debug.

As such dp_debug will create debugfs files in both the PRIMARY and the
RENDER minor's debugfs directory, but only the last reference will be
remembered.

The only use of this reference today is in the cleanup path in
dp_display_deinit_sub_modules() and the dp_debug_private object does
outlive the debugfs entries in either case, so there doesn't seem to be
any adverse effects of this, but per the code the current behavior is
unexpected, so change it to only create dp_debug for the PRIMARY minor.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 3aa67c53dbc0..06773b58bb60 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -10,6 +10,7 @@
 #include <linux/component.h>
 #include <linux/of_irq.h>
 #include <linux/delay.h>
+#include <drm/drm_file.h>
 #include <drm/drm_panel.h>
 
 #include "msm_drv.h"
@@ -1463,6 +1464,10 @@ void msm_dp_debugfs_init(struct msm_dp *dp_display, struct drm_minor *minor)
 	dp = container_of(dp_display, struct dp_display_private, dp_display);
 	dev = &dp->pdev->dev;
 
+	/* Only create one set of debugfs per DP instance */
+	if (minor->type != DRM_MINOR_PRIMARY)
+		return;
+
 	dp->debug = dp_debug_get(dev, dp->panel, dp->usbpd,
 					dp->link, dp->dp_display.connector,
 					minor);
-- 
2.29.2

