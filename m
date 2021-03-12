Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 617B8339442
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 18:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbhCLRDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 12:03:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232769AbhCLRDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 12:03:36 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE75CC061761
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 09:03:35 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id g8so4223888wmd.4
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 09:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0xkCbEvZITlI3FuObl7ojygKHKc8b/X8zJQNxRSg5U8=;
        b=vSNwp16ODVdxzM23E/bgP/ktZVmMyV0r0DypdYvSkDZF1m9PRNfX52KlC9ibbZU6H9
         TljQagWPlpVNGNVlZiEtawxLYbPSPFHaEK6eQurl0lFgXoDL7lv4wnUZ7Fh+4pYwym00
         UEtQ4EaAw/4OQodzQN0QbNHmMyN1BNx5ZQ0BsKZ11rP/5Q2fmCkdScrEZj4i4fTz05ZA
         UmfzaJ1wYUwe7di/LY0x5LFMkn5efvM3H4ZwoeIwBoRjqWMAB3PUVBtWDzGNxmIaI26Y
         RjtC0rqhlw+aIJmDSNpf49h3Vy7xQe8iogeTHIozjnUQAO3wy+w+FfGyktTHmnH5oaMB
         w0bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0xkCbEvZITlI3FuObl7ojygKHKc8b/X8zJQNxRSg5U8=;
        b=FvTbRAgjBAoy3oG/mGrnxKkcdUfkNmDowjhe929U0G3c7901EVkdyP1PgqVS178O9h
         bUnziWDcc3g/OeVnhsKDaAaEFZ5J61eTMmhcIx0Dpbh5d96JdwXw5BM2CJGVO7a0HxSV
         6Yx+jPcRDOv6GIbLadr367KfOCsiPA3oM0XkO3L21ZtDr0B+NE8g1Z1U1HBoHmUeIG7V
         IBzHacQb9mpCkj8WqnweSwGgfcqn4frmZMaNbi6BZ02OJsfn9g91pC4k7tnGg4cbz7lk
         5dSZpdRObGrGEi2WtZ/GrDG9hVd34yteI891rxtJ6/jckVNwCLOw4Z151Kk/2xvTdX9Q
         1v5A==
X-Gm-Message-State: AOAM5334eby3gGX0Uw7/GGLCLZsPOq/GOBVDOuVdTMm2KQAj5iUpjOQ1
        v7SetR52HxteMw1l/3Ey8T84Kw==
X-Google-Smtp-Source: ABdhPJzMVkkJH5FBKuz/H/AKJCdoc31BdUq0HscoqSrBMFDJey3SjjZ1UrkMe9a1e6HCrTRNifKbYg==
X-Received: by 2002:a7b:c087:: with SMTP id r7mr14049213wmh.110.1615568614327;
        Fri, 12 Mar 2021 09:03:34 -0800 (PST)
Received: from localhost.localdomain ([82.142.0.212])
        by smtp.gmail.com with ESMTPSA id 1sm2854681wmj.2.2021.03.12.09.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 09:03:33 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        lukasz.luba@arm.com, Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Javi Merino <javi.merino@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v2 5/5] thermal/drivers/cpufreq_cooling: Remove unused list
Date:   Fri, 12 Mar 2021 18:03:16 +0100
Message-Id: <20210312170316.3138-5-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210312170316.3138-1-daniel.lezcano@linaro.org>
References: <20210312170316.3138-1-daniel.lezcano@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a list with the purpose of grouping the cpufreq cooling
device together as described in the comments but actually it is
unused, the code evolved since 2012 and the list was no longer needed.

Delete the remaining unused list related code.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/cpufreq_cooling.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
index 3f5f1dce1320..f3d308427665 100644
--- a/drivers/thermal/cpufreq_cooling.c
+++ b/drivers/thermal/cpufreq_cooling.c
@@ -59,7 +59,6 @@ struct time_in_idle {
  * @cdev: thermal_cooling_device pointer to keep track of the
  *	registered cooling device.
  * @policy: cpufreq policy.
- * @node: list_head to link all cpufreq_cooling_device together.
  * @idle_time: idle time stats
  * @qos_req: PM QoS contraint to apply
  *
@@ -72,16 +71,12 @@ struct cpufreq_cooling_device {
 	unsigned int max_level;
 	struct em_perf_domain *em;
 	struct cpufreq_policy *policy;
-	struct list_head node;
 #ifndef CONFIG_SMP
 	struct time_in_idle *idle_time;
 #endif
 	struct freq_qos_request qos_req;
 };
 
-static DEFINE_MUTEX(cooling_list_lock);
-static LIST_HEAD(cpufreq_cdev_list);
-
 #ifdef CONFIG_THERMAL_GOV_POWER_ALLOCATOR
 /**
  * get_level: Find the level for a particular frequency
@@ -602,10 +597,6 @@ __cpufreq_cooling_register(struct device_node *np,
 	if (IS_ERR(cdev))
 		goto remove_qos_req;
 
-	mutex_lock(&cooling_list_lock);
-	list_add(&cpufreq_cdev->node, &cpufreq_cdev_list);
-	mutex_unlock(&cooling_list_lock);
-
 	return cdev;
 
 remove_qos_req:
@@ -697,10 +688,6 @@ void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
 
 	cpufreq_cdev = cdev->devdata;
 
-	mutex_lock(&cooling_list_lock);
-	list_del(&cpufreq_cdev->node);
-	mutex_unlock(&cooling_list_lock);
-
 	thermal_cooling_device_unregister(cdev);
 	freq_qos_remove_request(&cpufreq_cdev->qos_req);
 	free_idle_time(cpufreq_cdev);
-- 
2.17.1

