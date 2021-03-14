Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37C5A33A47D
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 12:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235366AbhCNLOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 07:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235250AbhCNLOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 07:14:01 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A611C061762
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 04:14:01 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id u5-20020a7bcb050000b029010e9316b9d5so14778381wmj.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 04:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AIW5JdRiazsxMw3x5g28vgK5yNC5+8RelKPzLiP5l5I=;
        b=bTzF53DwJpsYl5uU/6LFHN9EfBLcWe7eeiehJ9VJxk9fAR6L6CjVSsViyPDfxbBc6y
         Bmy6cU2dv2N0/J61rN8xXi1j6TKQ139RqC2+3vMvFwdsbNqYt1ij1RLsBOffB1Sk8j+g
         g0B85O2p6njVG2H5bIurwnGP3E+pxIgrP/voa4vzGXRO+wyOmThd27N0o0cHQ1SArR0T
         Yx7PV7RQ3U75mrzEpfHhzGJMRkIshJSJulHT1bVq48LrUc/R1Dc8HuEmSQMR0aCXXN40
         9g53FRYLQJncIYke7+fQu+fxkYZI4S94fbbSQA2PG8RYS4Gld2pX/3ibRckUZ2NzYr/L
         pUcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AIW5JdRiazsxMw3x5g28vgK5yNC5+8RelKPzLiP5l5I=;
        b=r32ry4IjfMpUTV0Jm7PxUguzrrsP2NEvsVnIb4+uoSsU3rebD1SZGNrfXyqz1VYmnc
         Vg2u8GX9mYQVj39ghA6KDA0cDnuB6xD7ofzVKvKonpC56kPy/rOxcBIODDPb5VJ3vS2n
         ADkNAGjAt7n0mtrwP9WNVWn2dE9YMUeMzH0FOlOFORFDwNzTYHgigptt8TC0QrIN12cy
         k8GPkZihRAGXsQGGeR+34EUBY3FwelTK8V1WaGxYFbiej2S8DnIy0KkTKGxLt8lpokhK
         u6nXxvnJ9szAHUcsYi/mOLoQIUz5u5sCX6Zc1zkmEcBL/wghWSb5eQ78jA+9hkXffsBz
         QQ6w==
X-Gm-Message-State: AOAM533PGOw+89fBzs+4IDnSsHvnu2+SFQQ0z3+CaJD+9STckflCaPKP
        0qE0eSNfnLdmYjrDiLzxcFZtGg==
X-Google-Smtp-Source: ABdhPJyujMr9ypIYmrzGJYNAECWOW3MqVVFZYFjXW4QQXBNCVho4EINsCt6LCwG+o2SBWsIfUQ5b7A==
X-Received: by 2002:a7b:c407:: with SMTP id k7mr21829856wmi.136.1615720439841;
        Sun, 14 Mar 2021 04:13:59 -0700 (PDT)
Received: from localhost.localdomain ([82.142.0.212])
        by smtp.gmail.com with ESMTPSA id i8sm16828330wry.90.2021.03.14.04.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Mar 2021 04:13:59 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        lukasz.luba@arm.com, Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Javi Merino <javi.merino@kernel.org>,
        Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v3 5/5] thermal/drivers/cpufreq_cooling: Remove unused list
Date:   Sun, 14 Mar 2021 12:13:33 +0100
Message-Id: <20210314111333.16551-5-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210314111333.16551-1-daniel.lezcano@linaro.org>
References: <20210314111333.16551-1-daniel.lezcano@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a list with the purpose of grouping the cpufreq cooling
device together as described in the comments but actually it is
unused, the code evolved since 2012 and the list was no longer needed.

Delete the remaining unused list related code.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
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

