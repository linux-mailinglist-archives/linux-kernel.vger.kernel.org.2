Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 895BF30646A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 20:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232939AbhA0TrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 14:47:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344563AbhA0Tlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 14:41:36 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581BDC061574
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 11:40:53 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id s7so156095wru.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 11:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=PcWmJK7Dze/r/wUv0FSXsJbwz5Mept/IbtYNxoDr6rI=;
        b=my18lCcUw72G/3GMBnhG1Ahqiri1aO4swmUZWZMmfGN90SyV3mv2DQtwTQvV8EPtHt
         BYdbTkPv/vT5qUkh9KpiafH//Eyz5MWzquukfI3lDORqkamSyXUn9aqzDyEL9iixL3Gq
         0JcXXs1uUTlKjWZ5lOS7dCtN7WNVvdT1fA1zDP4k5Y/3UN2E8a5LALOK+z28tIb0CtWR
         I8tl6KJHvgviHQOiIzAIJX2vE05Gw13Bw5ed4bdG/vW/N0zRgNEpHA39/g3Ihf9BaBSv
         WDnjIgjt7Siwo/J3hShCdOP2dzAPVp2nhcv6tWJ2zdBuyxYHChRvjdwUrA99HzUMClSv
         tIBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PcWmJK7Dze/r/wUv0FSXsJbwz5Mept/IbtYNxoDr6rI=;
        b=lh/INdCSRnYK7dFLnqfChJCf5MdtOReYvsuz75vJtkytUwKy6wd3JMaHcKRivLpS/4
         6HffpZiMAwtxncmtRKgc5mSQk7ijttEPBx4MFpB2T7LgEWNr6Yw++XMLs+qAJvnEvBPb
         GJzIvJyAj42VnENte6zH453FD7z11GPIGWGZFreesxZuuxSYtqCmPDpri21CybQeCYtg
         nCrKi/3jl7ZlFZ5jvelED6vKueczkHh3KZ1uii/zj1/aF6wHFdRBIUx+9tvWCSUbPQqp
         YpZ7J8SnuEFirIqzIpYEDN49oVW5oxCMQXKxDYen5dw666osFxuVPG1ySSAdQIKWl2LP
         +EBg==
X-Gm-Message-State: AOAM530B5Rv1s242Au+x9DgYpeoeGeAw9zegNrjb+feCrviqNF2PJoPB
        ZWO9wdjPJ1Wdk6AMeaKLEWc=
X-Google-Smtp-Source: ABdhPJy3RfbeYRIMLYndPZDVwVhj97D1QkysNjbT5Mk8RnXZ+/O73ETbponAJJ19eqje28t1N1XkWQ==
X-Received: by 2002:adf:fe04:: with SMTP id n4mr13215849wrr.115.1611776452142;
        Wed, 27 Jan 2021 11:40:52 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id e11sm4075305wrx.14.2021.01.27.11.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 11:40:51 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Qiang Yu <yuq825@gmail.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, lima@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Steven Price <steven.price@arm.com>
Subject: [PATCH v2] drm/lima: add governor data with pre-defined thresholds
Date:   Wed, 27 Jan 2021 19:40:47 +0000
Message-Id: <20210127194047.21462-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adapts the panfrost pre-defined thresholds change [0] to the
lima driver to improve real-world performance. The upthreshold value has
been set to ramp GPU frequency to max freq faster (compared to panfrost)
to compensate for the lower overall performance of utgard devices.

[0] https://patchwork.kernel.org/project/dri-devel/patch/20210121170445.19761-1-lukasz.luba@arm.com/

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
Change since v1: increased upthreshold from 20 to 30, with a soft
dependency on Lukasz delayed timer patch [0]

[0] https://lore.kernel.org/lkml/20210127105121.20345-1-lukasz.luba@arm.com/

 drivers/gpu/drm/lima/lima_devfreq.c | 10 +++++++++-
 drivers/gpu/drm/lima/lima_devfreq.h |  2 ++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/lima/lima_devfreq.c b/drivers/gpu/drm/lima/lima_devfreq.c
index 5686ad4aaf7c..c9854315a0b5 100644
--- a/drivers/gpu/drm/lima/lima_devfreq.c
+++ b/drivers/gpu/drm/lima/lima_devfreq.c
@@ -163,8 +163,16 @@ int lima_devfreq_init(struct lima_device *ldev)
 	lima_devfreq_profile.initial_freq = cur_freq;
 	dev_pm_opp_put(opp);
 
+	/*
+	 * Setup default thresholds for the simple_ondemand governor.
+	 * The values are chosen based on experiments.
+	 */
+	ldevfreq->gov_data.upthreshold = 30;
+	ldevfreq->gov_data.downdifferential = 5;
+
 	devfreq = devm_devfreq_add_device(dev, &lima_devfreq_profile,
-					  DEVFREQ_GOV_SIMPLE_ONDEMAND, NULL);
+					  DEVFREQ_GOV_SIMPLE_ONDEMAND,
+					  &ldevfreq->gov_data);
 	if (IS_ERR(devfreq)) {
 		dev_err(dev, "Couldn't initialize GPU devfreq\n");
 		ret = PTR_ERR(devfreq);
diff --git a/drivers/gpu/drm/lima/lima_devfreq.h b/drivers/gpu/drm/lima/lima_devfreq.h
index 2d9b3008ce77..b0c7c736e81a 100644
--- a/drivers/gpu/drm/lima/lima_devfreq.h
+++ b/drivers/gpu/drm/lima/lima_devfreq.h
@@ -4,6 +4,7 @@
 #ifndef __LIMA_DEVFREQ_H__
 #define __LIMA_DEVFREQ_H__
 
+#include <linux/devfreq.h>
 #include <linux/spinlock.h>
 #include <linux/ktime.h>
 
@@ -18,6 +19,7 @@ struct lima_devfreq {
 	struct opp_table *clkname_opp_table;
 	struct opp_table *regulators_opp_table;
 	struct thermal_cooling_device *cooling;
+	struct devfreq_simple_ondemand_data gov_data;
 
 	ktime_t busy_time;
 	ktime_t idle_time;
-- 
2.17.1

