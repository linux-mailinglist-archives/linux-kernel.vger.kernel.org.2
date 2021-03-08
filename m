Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9047330A24
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 10:18:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbhCHJRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 04:17:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbhCHJQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 04:16:58 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562EEC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 01:16:58 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id v15so10612043wrx.4
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 01:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lZkNk3yYW/8ijhrD082tSx7qBCi8O3cbnVc/FrlwdlU=;
        b=xJPJiPhL2CvJWDgXMAAvBiTvcIxvXystP9YkIlHtva74Kx3KKrXMzr5ExU/2veL6gL
         JN0tiwqQkJZE+39MgAeg+OMCaGrK8S9+YOsDQDWd+3dTc2g301WBoII1352/ShtfExle
         I8X285pwmJ87QjUDuabk+LHDri4SK9gCM4d4FWGSbxLmNabTDCCbOJ7VDDWJcvzONPg+
         GTa5resMnc34uJs35KxsGGVOTP1jPcf82BNAgk1ep7qrWnin5hljOJvwHYhTfXPo8NMC
         kc9OFA5NMopEHc1N0LYFDbP7CVmW4PVVBBE9rTuMk3CceWr7P4Tmd6BHvIh5c+x1JqKL
         Y8Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lZkNk3yYW/8ijhrD082tSx7qBCi8O3cbnVc/FrlwdlU=;
        b=unly5ts84ZwxTyfkuPI63W4HICgFZEpN4frL8E2Nqwe1E4rZ/thzXaLIB7wku3z2fo
         5liNOzGO315gZqypTBf2JNnV1bK159f98OT9URMSNB9Ak+erkp82aMVmz//M41g8/5ZQ
         XsAMXkn+133UHZSB7u2wx87OR+UrVryRmbR32Xe1c3kDH0DdtN37A2rpBGNQf3J2JVQY
         4MfJWm1mHcaRolV1KETWJ+AE6KpfyjGOLO79u85g6qVXXH3aAvn7fPmh9bUx+tWcEPpS
         7J7b9U0BS6MmFEUwmVsNtz95QFlfk5/pKldGH1AdBW9pxGxljAw8gNvjmCJVmdGhSPP+
         vULA==
X-Gm-Message-State: AOAM533SyG5Z9ag9A3kX6pCx9c/h/hZurbNAx/tPvyS4VAGJ944ot5MB
        uNLkf/2E9J/Dr/nM/qxUS+YPoQ==
X-Google-Smtp-Source: ABdhPJx3SkKA8CuJm1YO3uuuPCxJ7WvFkCcM1T13tKInBZsMtLPFIiucfYx1JIM0Or2VdzZVpvcZLg==
X-Received: by 2002:a05:6000:1107:: with SMTP id z7mr1424030wrw.415.1615195017010;
        Mon, 08 Mar 2021 01:16:57 -0800 (PST)
Received: from localhost.localdomain (lns-bzn-59-82-252-141-80.adsl.proxad.net. [82.252.141.80])
        by smtp.gmail.com with ESMTPSA id i17sm6068135wrp.77.2021.03.08.01.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 01:16:56 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     cwchoi00@gmail.com
Cc:     lukasz.luba@arm.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, steven.price@arm.com,
        Qiang Yu <yuq825@gmail.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS FOR LIMA),
        lima@lists.freedesktop.org (moderated list:DRM DRIVERS FOR LIMA)
Subject: [PATCH v5 4/4] PM / devfreq: lima: Use devfreq cooling device registration
Date:   Mon,  8 Mar 2021 10:16:45 +0100
Message-Id: <20210308091646.28096-4-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210308091646.28096-1-daniel.lezcano@linaro.org>
References: <20210308091646.28096-1-daniel.lezcano@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The devfreq core code is able to register the devfreq device as a
cooling device if the 'is_cooling_device' flag is set in the profile.

Use this flag and remove the cooling device registering code.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/gpu/drm/lima/lima_devfreq.c | 14 +-------------
 drivers/gpu/drm/lima/lima_devfreq.h |  2 --
 2 files changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/lima/lima_devfreq.c b/drivers/gpu/drm/lima/lima_devfreq.c
index 5686ad4aaf7c..86aea1bdc4f4 100644
--- a/drivers/gpu/drm/lima/lima_devfreq.c
+++ b/drivers/gpu/drm/lima/lima_devfreq.c
@@ -7,7 +7,6 @@
  */
 #include <linux/clk.h>
 #include <linux/devfreq.h>
-#include <linux/devfreq_cooling.h>
 #include <linux/device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_opp.h>
@@ -84,17 +83,13 @@ static struct devfreq_dev_profile lima_devfreq_profile = {
 	.polling_ms = 50, /* ~3 frames */
 	.target = lima_devfreq_target,
 	.get_dev_status = lima_devfreq_get_dev_status,
+	.is_cooling_device = true,
 };
 
 void lima_devfreq_fini(struct lima_device *ldev)
 {
 	struct lima_devfreq *devfreq = &ldev->devfreq;
 
-	if (devfreq->cooling) {
-		devfreq_cooling_unregister(devfreq->cooling);
-		devfreq->cooling = NULL;
-	}
-
 	if (devfreq->devfreq) {
 		devm_devfreq_remove_device(ldev->dev, devfreq->devfreq);
 		devfreq->devfreq = NULL;
@@ -110,7 +105,6 @@ void lima_devfreq_fini(struct lima_device *ldev)
 
 int lima_devfreq_init(struct lima_device *ldev)
 {
-	struct thermal_cooling_device *cooling;
 	struct device *dev = ldev->dev;
 	struct opp_table *opp_table;
 	struct devfreq *devfreq;
@@ -173,12 +167,6 @@ int lima_devfreq_init(struct lima_device *ldev)
 
 	ldevfreq->devfreq = devfreq;
 
-	cooling = of_devfreq_cooling_register(dev->of_node, devfreq);
-	if (IS_ERR(cooling))
-		dev_info(dev, "Failed to register cooling device\n");
-	else
-		ldevfreq->cooling = cooling;
-
 	return 0;
 
 err_fini:
diff --git a/drivers/gpu/drm/lima/lima_devfreq.h b/drivers/gpu/drm/lima/lima_devfreq.h
index 2d9b3008ce77..c43a2069e5d3 100644
--- a/drivers/gpu/drm/lima/lima_devfreq.h
+++ b/drivers/gpu/drm/lima/lima_devfreq.h
@@ -9,7 +9,6 @@
 
 struct devfreq;
 struct opp_table;
-struct thermal_cooling_device;
 
 struct lima_device;
 
@@ -17,7 +16,6 @@ struct lima_devfreq {
 	struct devfreq *devfreq;
 	struct opp_table *clkname_opp_table;
 	struct opp_table *regulators_opp_table;
-	struct thermal_cooling_device *cooling;
 
 	ktime_t busy_time;
 	ktime_t idle_time;
-- 
2.17.1

