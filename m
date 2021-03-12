Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1398D339441
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 18:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232892AbhCLRDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 12:03:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232738AbhCLRDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 12:03:34 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3BEC061761
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 09:03:34 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id m20-20020a7bcb940000b029010cab7e5a9fso16211159wmi.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 09:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DuYOMewCZUtcJ4+tVTYyeku7t/eSId6NRi7iq7c/+IU=;
        b=UR3krhYk1OkiuZslRgZbNmXQw0Uo7wx0N/Xc74UmSpEbAsJc6QGrlu7dQze9yNBJDJ
         lpS+NtBDBZ+d4FrfzPCd96WUxNvu5pCD8+vwyGmTfBCF3esMo/WPmTUib/R06sMV1j1O
         kI2GRSZcWLFZhtLe3AB6reIJNuYGdL3JSyIZs7eC3hJ+a2YEscA+z977dGNVrcYQesA/
         Y9sQEnUNWowuuPLkEsc47miqqQkRR7pTr4XGrX85jT3jnUnvxbKiTNtg0C3YwRmLDifH
         IJBxxD+R/wf6aXTd4srnagSHEYDBF1sQC6thqWiF3xJZBDrVwH0EmUeVbTPUR4MA0fn8
         BmBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DuYOMewCZUtcJ4+tVTYyeku7t/eSId6NRi7iq7c/+IU=;
        b=SDEz+0v5fnm1P100fEfj+DNjrUr+RBf+xIw7SbPM6AboWxHRm98pxSMF7mr+bQwCHR
         JFQbYvtvAHNo7QyJsCwzf0rYBiUnKFzqaKauMjCvIs1mWOy73V7aQst/e+HkO07Efd+5
         1wPvGL7yqaQVJxBNwvtT5gPXKZj8D8hptMJmQTDuWdTCM/gIdp5T/CiV6V3Xw7GaP3vs
         7S3ewxumUNzezewOQ//nOrfdm0P0/2CUXaxnf/sSmmYLC5PbvaFkbzbvuu4VKm+fCrpU
         yFoLT1mM5KhRiDVVXEWKJH/tVfsiV/dRlgUZHuufHJXWNVOR3gQ+FH7xiPDVKVboU+n0
         skug==
X-Gm-Message-State: AOAM531ihfUfSYxVEns4GQadCDKasLhJcwR/b2wqWYqcfAj4JijnglLD
        S1asQXxL2cioYnpK0XJSfgYROw==
X-Google-Smtp-Source: ABdhPJx/0yMlqELvHX3Bz7lTFC6mlcBLsaLoGNzYC2DSTXqCO3bRRdmjW4enBbp3Phxsgv07f67dEA==
X-Received: by 2002:a1c:4e0f:: with SMTP id g15mr14267749wmh.144.1615568612905;
        Fri, 12 Mar 2021 09:03:32 -0800 (PST)
Received: from localhost.localdomain ([82.142.0.212])
        by smtp.gmail.com with ESMTPSA id 1sm2854681wmj.2.2021.03.12.09.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 09:03:32 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        lukasz.luba@arm.com, Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Javi Merino <javi.merino@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v2 4/5] thermal/drivers/cpuidle_cooling: Use device name instead of auto-numbering
Date:   Fri, 12 Mar 2021 18:03:15 +0100
Message-Id: <20210312170316.3138-4-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210312170316.3138-1-daniel.lezcano@linaro.org>
References: <20210312170316.3138-1-daniel.lezcano@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the naming of a cooling device is just a cooling technique
followed by a number. When there are multiple cooling devices using
the same technique, it is impossible to clearly identify the related
device as this one is just a number.

For instance:

 thermal-idle-0
 thermal-idle-1
 thermal-idle-2
 thermal-idle-3
 etc ...

The 'thermal' prefix is redundant with the subsystem namespace. This
patch removes the 'thermal prefix and changes the number by the device
name. So the naming above becomes:

 idle-cpu0
 idle-cpu1
 idle-cpu2
 idle-cpu3
 etc ...

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
---
V2:
  - Removed idr.h header
  - Used kasprintf instead of fixed buffer length on the stack
  - Fixed typo in the log
---
 drivers/thermal/cpuidle_cooling.c | 33 +++++++++++++++----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/thermal/cpuidle_cooling.c b/drivers/thermal/cpuidle_cooling.c
index 7ecab4b16b29..f32976163bad 100644
--- a/drivers/thermal/cpuidle_cooling.c
+++ b/drivers/thermal/cpuidle_cooling.c
@@ -9,9 +9,9 @@
 
 #include <linux/cpu_cooling.h>
 #include <linux/cpuidle.h>
+#include <linux/device.h>
 #include <linux/err.h>
 #include <linux/idle_inject.h>
-#include <linux/idr.h>
 #include <linux/of_device.h>
 #include <linux/slab.h>
 #include <linux/thermal.h>
@@ -26,8 +26,6 @@ struct cpuidle_cooling_device {
 	unsigned long state;
 };
 
-static DEFINE_IDA(cpuidle_ida);
-
 /**
  * cpuidle_cooling_runtime - Running time computation
  * @idle_duration_us: CPU idle time to inject in microseconds
@@ -174,10 +172,11 @@ static int __cpuidle_cooling_register(struct device_node *np,
 	struct idle_inject_device *ii_dev;
 	struct cpuidle_cooling_device *idle_cdev;
 	struct thermal_cooling_device *cdev;
+	struct device *dev;
 	unsigned int idle_duration_us = TICK_USEC;
 	unsigned int latency_us = UINT_MAX;
-	char dev_name[THERMAL_NAME_LENGTH];
-	int id, ret;
+	char *name;
+	int ret;
 
 	idle_cdev = kzalloc(sizeof(*idle_cdev), GFP_KERNEL);
 	if (!idle_cdev) {
@@ -185,16 +184,10 @@ static int __cpuidle_cooling_register(struct device_node *np,
 		goto out;
 	}
 
-	id = ida_simple_get(&cpuidle_ida, 0, 0, GFP_KERNEL);
-	if (id < 0) {
-		ret = id;
-		goto out_kfree;
-	}
-
 	ii_dev = idle_inject_register(drv->cpumask);
 	if (!ii_dev) {
 		ret = -EINVAL;
-		goto out_id;
+		goto out_kfree;
 	}
 
 	of_property_read_u32(np, "duration-us", &idle_duration_us);
@@ -205,24 +198,30 @@ static int __cpuidle_cooling_register(struct device_node *np,
 
 	idle_cdev->ii_dev = ii_dev;
 
-	snprintf(dev_name, sizeof(dev_name), "thermal-idle-%d", id);
+	dev = get_cpu_device(cpumask_first(drv->cpumask));
 
-	cdev = thermal_of_cooling_device_register(np, dev_name, idle_cdev,
+	name = kasprintf(GFP_KERNEL, "idle-%s", dev_name(dev));
+	if (!name) {
+		ret = -ENOMEM;
+		goto out_unregister;
+	}
+
+	cdev = thermal_of_cooling_device_register(np, name, idle_cdev,
 						  &cpuidle_cooling_ops);
+	kfree(name);
+
 	if (IS_ERR(cdev)) {
 		ret = PTR_ERR(cdev);
 		goto out_unregister;
 	}
 
 	pr_debug("%s: Idle injection set with idle duration=%u, latency=%u\n",
-		 dev_name, idle_duration_us, latency_us);
+		 name, idle_duration_us, latency_us);
 
 	return 0;
 
 out_unregister:
 	idle_inject_unregister(ii_dev);
-out_id:
-	ida_simple_remove(&cpuidle_ida, id);
 out_kfree:
 	kfree(idle_cdev);
 out:
-- 
2.17.1

