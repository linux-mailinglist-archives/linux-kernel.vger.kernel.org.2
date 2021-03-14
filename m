Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B09D333A477
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 12:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235224AbhCNLOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 07:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235181AbhCNLN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 07:13:57 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1DEC061764
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 04:13:57 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id w203-20020a1c49d40000b029010c706d0642so1046197wma.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 04:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=s7fCt8jAahXLsklhkFc/v9K2fCeNdzwdfE44cqbig58=;
        b=K7VrwnkRfLrUeSeIcYIRCBIcLacD2X4jICNHmsyBy1+d293KQskwN7hpsHzRLNYl9r
         zGPFSFcHdWBnRijlEVADWVuQg24UdnKyVQf9s4dtEeqVguRQAVv/pShMJI2HEt44r5Fq
         9TmhtrXGa9LGf7cUSpmWrWRNamoOLWva3vyg+PGLYNOKoiUQuD8P5R1cYAvEBbougiDj
         Xc5oVCJSzscgmTQE+zQZxkPE7vBhPtb+Nq7tCbs7l50qlFjbaSZmVdjnZm5v9FVhESeH
         h4DosGPfdepRQp5f+hdUBXedAx5gHbs1ejZ4ccqCPWBGrDp1G1OaKmlDfQxH1doHCOz8
         uSpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=s7fCt8jAahXLsklhkFc/v9K2fCeNdzwdfE44cqbig58=;
        b=GEnPANo9dRgMSvYBV95GEzc6GOj1WpvHqsLRvmfQfLmfVA0pRaij0ABjgS02k0o/qG
         slv9c1zlBDRAC3fHrsPYH8wg6mGr4Bxj8Rqrg3qNpwlsumtcYcJ1kF64/p61orpl3m9r
         9mm+sLIplBIWxiP1zCM1NdNFsRy+/GZx/aOESnAcyM7Toeiq8CJ5sLPxoQyAa3V6bGKX
         hh1UKRB9fbtRM74d8KIeqxahisTO4wtn/yBKqb+8qoHSy3+9bAFiu8CSe2WD+UL5zuXN
         aBE7LXPaT5cxlhwRW1PglORu0h8fRZOpl9WhArvbq1Mi3W6yIuxYjc6v02obpXdh6J/g
         0RFg==
X-Gm-Message-State: AOAM530f6xmOlCOwEMMB7UbWFpKuDxdHda0doAd76UCYd/MfooJ4OC/o
        jxaFy8sFePFIkOXreRzbRGyj8g==
X-Google-Smtp-Source: ABdhPJzg7OGbQMr2XP2DWw8PFIMj1KXzvq2t13+p4rxl//E6PYnOu27mbvgVd/dRLtRpP8xq9LT8Ww==
X-Received: by 2002:a1c:66c4:: with SMTP id a187mr21369695wmc.164.1615720435569;
        Sun, 14 Mar 2021 04:13:55 -0700 (PDT)
Received: from localhost.localdomain ([82.142.0.212])
        by smtp.gmail.com with ESMTPSA id i8sm16828330wry.90.2021.03.14.04.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Mar 2021 04:13:55 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        lukasz.luba@arm.com, Viresh Kumar <viresh.kumar@linaro.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v3 2/5] thermal/drivers/cpufreq_cooling: Use device name instead of auto-numbering
Date:   Sun, 14 Mar 2021 12:13:30 +0100
Message-Id: <20210314111333.16551-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210314111333.16551-1-daniel.lezcano@linaro.org>
References: <20210314111333.16551-1-daniel.lezcano@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the naming of a cooling device is just a cooling technique
followed by a number. When there are multiple cooling devices using
the same technique, it is impossible to clearly identify the related
device as this one is just a number.

For instance:

 thermal-cpufreq-0
 thermal-cpufreq-1
 etc ...

The 'thermal' prefix is redundant with the subsystem namespace. This
patch removes the 'thermal' prefix and changes the number by the device
name. So the naming above becomes:

 cpufreq-cpu0
 cpufreq-cpu4
 etc ...

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
---
V2:
  - Use kasprintf() instead of fixed array length on the stack
  - Fixed typo in the log
  - Removed idr.h inclusion
---
 drivers/thermal/cpufreq_cooling.c | 34 +++++++++++--------------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
index 10af3341e5ea..3f5f1dce1320 100644
--- a/drivers/thermal/cpufreq_cooling.c
+++ b/drivers/thermal/cpufreq_cooling.c
@@ -13,10 +13,10 @@
 #include <linux/cpu.h>
 #include <linux/cpufreq.h>
 #include <linux/cpu_cooling.h>
+#include <linux/device.h>
 #include <linux/energy_model.h>
 #include <linux/err.h>
 #include <linux/export.h>
-#include <linux/idr.h>
 #include <linux/pm_opp.h>
 #include <linux/pm_qos.h>
 #include <linux/slab.h>
@@ -50,8 +50,6 @@ struct time_in_idle {
 
 /**
  * struct cpufreq_cooling_device - data for cooling device with cpufreq
- * @id: unique integer value corresponding to each cpufreq_cooling_device
- *	registered.
  * @last_load: load measured by the latest call to cpufreq_get_requested_power()
  * @cpufreq_state: integer value representing the current state of cpufreq
  *	cooling	devices.
@@ -69,7 +67,6 @@ struct time_in_idle {
  * cpufreq_cooling_device.
  */
 struct cpufreq_cooling_device {
-	int id;
 	u32 last_load;
 	unsigned int cpufreq_state;
 	unsigned int max_level;
@@ -82,7 +79,6 @@ struct cpufreq_cooling_device {
 	struct freq_qos_request qos_req;
 };
 
-static DEFINE_IDA(cpufreq_ida);
 static DEFINE_MUTEX(cooling_list_lock);
 static LIST_HEAD(cpufreq_cdev_list);
 
@@ -528,11 +524,11 @@ __cpufreq_cooling_register(struct device_node *np,
 {
 	struct thermal_cooling_device *cdev;
 	struct cpufreq_cooling_device *cpufreq_cdev;
-	char dev_name[THERMAL_NAME_LENGTH];
 	unsigned int i;
 	struct device *dev;
 	int ret;
 	struct thermal_cooling_device_ops *cooling_ops;
+	char *name;
 
 	dev = get_cpu_device(policy->cpu);
 	if (unlikely(!dev)) {
@@ -567,16 +563,6 @@ __cpufreq_cooling_register(struct device_node *np,
 	/* max_level is an index, not a counter */
 	cpufreq_cdev->max_level = i - 1;
 
-	ret = ida_simple_get(&cpufreq_ida, 0, 0, GFP_KERNEL);
-	if (ret < 0) {
-		cdev = ERR_PTR(ret);
-		goto free_idle_time;
-	}
-	cpufreq_cdev->id = ret;
-
-	snprintf(dev_name, sizeof(dev_name), "thermal-cpufreq-%d",
-		 cpufreq_cdev->id);
-
 	cooling_ops = &cpufreq_cooling_ops;
 
 #ifdef CONFIG_THERMAL_GOV_POWER_ALLOCATOR
@@ -591,7 +577,7 @@ __cpufreq_cooling_register(struct device_node *np,
 		pr_err("%s: unsorted frequency tables are not supported\n",
 		       __func__);
 		cdev = ERR_PTR(-EINVAL);
-		goto remove_ida;
+		goto free_idle_time;
 	}
 
 	ret = freq_qos_add_request(&policy->constraints,
@@ -601,11 +587,18 @@ __cpufreq_cooling_register(struct device_node *np,
 		pr_err("%s: Failed to add freq constraint (%d)\n", __func__,
 		       ret);
 		cdev = ERR_PTR(ret);
-		goto remove_ida;
+		goto free_idle_time;
 	}
 
-	cdev = thermal_of_cooling_device_register(np, dev_name, cpufreq_cdev,
+	cdev = ERR_PTR(-ENOMEM);
+	name = kasprintf(GFP_KERNEL, "cpufreq-%s", dev_name(dev));
+	if (!name)
+		goto remove_qos_req;
+
+	cdev = thermal_of_cooling_device_register(np, name, cpufreq_cdev,
 						  cooling_ops);
+	kfree(name);
+
 	if (IS_ERR(cdev))
 		goto remove_qos_req;
 
@@ -617,8 +610,6 @@ __cpufreq_cooling_register(struct device_node *np,
 
 remove_qos_req:
 	freq_qos_remove_request(&cpufreq_cdev->qos_req);
-remove_ida:
-	ida_simple_remove(&cpufreq_ida, cpufreq_cdev->id);
 free_idle_time:
 	free_idle_time(cpufreq_cdev);
 free_cdev:
@@ -712,7 +703,6 @@ void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
 
 	thermal_cooling_device_unregister(cdev);
 	freq_qos_remove_request(&cpufreq_cdev->qos_req);
-	ida_simple_remove(&cpufreq_ida, cpufreq_cdev->id);
 	free_idle_time(cpufreq_cdev);
 	kfree(cpufreq_cdev);
 }
-- 
2.17.1

