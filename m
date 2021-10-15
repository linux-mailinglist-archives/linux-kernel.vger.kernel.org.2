Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA99842FE9B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 01:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238905AbhJOXRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 19:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbhJOXRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 19:17:22 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F68C061570
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 16:15:15 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id e63so15181155oif.8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 16:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uXYWsPfuH0QgJqlDjcLAxj0Du9PAVf3q0Y+T8Yx4Cuw=;
        b=MuDTWdz5HqEUzUdrw4R7qtYDW+TxRgUrPAvZpiCSF263TvWJxafk3AlTAvaD5Z6IXn
         nPKlQEYt+90K0Hvy9Nlst82T4VDubkB3ox4/4ztd7yr/g2pIVNncZz7GYQ/kaZjdM5xv
         KAXumhrO6aDacfHZqUMTclvHhutTjHccyHsbFqbFCgXMdVy2sSUCJrfxs3yMakX0Pz8X
         nlLxTFJw+kYr2WI0QIQ+xf7V8CilsmRwXwO2YR18bC5xosgthynFasKu4jSkk1NL5gA1
         FIFOq6HQkk5l/G3YegzRM9tAMV2XKP+Poy817imiQqJT0YMaD+Y2u4PNDv9Eci2wkT0q
         u3pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uXYWsPfuH0QgJqlDjcLAxj0Du9PAVf3q0Y+T8Yx4Cuw=;
        b=62BthsWrRA8xPucavxpz+nhMaxRtXCfO61m9VYBJsCA6WQbp5s0A6Em0y6nK0w7uoq
         QnGVtQFGjIaP9aFnuDBKjAi3qDRwAxtu4V0PtFoj348YkmV+2ASPEKFxRzqT4oJaw3SS
         1TqDLDFe187YHwIIrqqfXkotAPaNZBG/hTF2PPf5IlOuuvl2CRRh4KlZZU+R1Y8FmRkP
         /D6ioduiuN66RB2anv0cxbhG59u+5SdWQ3WNM0gus9V1aCPp9Bz9RyUtLzxBSW6uzX7B
         yR6j/y9rdJZuPO8Cagvch3KpKNrpCwc7RuKv8Ys0xEIA7c6Fp4WlJl2PQh5bvClHhgBp
         tVyw==
X-Gm-Message-State: AOAM531/m8Y9geGxtOH/QnznykkNSND8TGrd49p5dXFlDWgfI5iEEyuC
        GZLJGJPS2m/pwMgrHT4QOOF5Mw==
X-Google-Smtp-Source: ABdhPJybatynBim0Q4iy4WA6q9z9IPCf+URhtUCNqWaZ+GGrTzTWhQCFjcWK4Zj3+6lRr1iUnMAsDw==
X-Received: by 2002:a54:4618:: with SMTP id p24mr10397616oip.134.1634339714369;
        Fri, 15 Oct 2021 16:15:14 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id 2sm1495462oil.37.2021.10.15.16.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 16:15:13 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/msm/dp: Move debugfs files into subdirectory
Date:   Fri, 15 Oct 2021 16:17:02 -0700
Message-Id: <20211015231702.1784254-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the cleanup path of the MSM DP driver the DP driver's debugfs files
are destroyed by invoking debugfs_remove_recursive() on debug->root,
which during initialization has been set to minor->debugfs_root.

To allow cleaning up the DP driver's debugfs files either each dentry
needs to be kept track of or the files needs to be put in a subdirectory
which can be removed in one go.

By choosing to put the debugfs files in a subdirectory, based on the
name of the associated connector this also solves the problem that these
names would collide as support for multiple DP instances are introduced.

One alternative solution to the problem with colliding file names would
have been to put keep track of the individual files and put them under
the connector's debugfs directory. But while the drm_connector has been
allocated, its associated debugfs directory has not been created at the
time of initialization of the dp_debug.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

This depends on
https://lore.kernel.org/linux-arm-msm/20211010030435.4000642-1-bjorn.andersson@linaro.org/
reducing the connector from a double pointer.

 drivers/gpu/drm/msm/dp/dp_debug.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_debug.c b/drivers/gpu/drm/msm/dp/dp_debug.c
index da4323556ef3..67da4c69eca1 100644
--- a/drivers/gpu/drm/msm/dp/dp_debug.c
+++ b/drivers/gpu/drm/msm/dp/dp_debug.c
@@ -210,26 +210,29 @@ static const struct file_operations test_active_fops = {
 static int dp_debug_init(struct dp_debug *dp_debug, struct drm_minor *minor)
 {
 	int rc = 0;
+	char path[64];
 	struct dp_debug_private *debug = container_of(dp_debug,
 			struct dp_debug_private, dp_debug);
 
-	debugfs_create_file("dp_debug", 0444, minor->debugfs_root,
+	snprintf(path, sizeof(path), "msm_dp-%s", debug->connector->name);
+
+	debug->root = debugfs_create_dir(path, minor->debugfs_root);
+
+	debugfs_create_file("dp_debug", 0444, debug->root,
 			debug, &dp_debug_fops);
 
 	debugfs_create_file("msm_dp_test_active", 0444,
-			minor->debugfs_root,
+			debug->root,
 			debug, &test_active_fops);
 
 	debugfs_create_file("msm_dp_test_data", 0444,
-			minor->debugfs_root,
+			debug->root,
 			debug, &dp_test_data_fops);
 
 	debugfs_create_file("msm_dp_test_type", 0444,
-			minor->debugfs_root,
+			debug->root,
 			debug, &dp_test_type_fops);
 
-	debug->root = minor->debugfs_root;
-
 	return rc;
 }
 
-- 
2.29.2

