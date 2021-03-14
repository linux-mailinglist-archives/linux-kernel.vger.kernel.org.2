Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 582F833A47B
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 12:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235323AbhCNLOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 07:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235218AbhCNLN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 07:13:59 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4742DC061763
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 04:13:58 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id r10-20020a05600c35cab029010c946c95easo17727255wmq.4
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 04:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Und6/a+u/e43qwfpDbHhYJU3/UbWxvF+sZZzRPfE1rE=;
        b=ILhvmOQRVThFkn3DB3HkviSf7pFJZf+cm51BWhMtnwOR38FgBP3hJ+Db7xdOh5noev
         T+C4/xYXykuxLLsFU9QQ22OXAScO0dBnLemVqpmo5uyUTpXvhxwz+EsqhRQKGBEEM0sk
         pN9XxWrNWa3NR+z1+d/wHnunYKZiAGoDSzOwqbGziApiHt5QxjXMy6N3pIlfX7y5qWfO
         4v9BQ+edLaEsLEaOPJpBdf6QqursOTr1ViNyW66GUR7l2Kv7P5a5P6oiHNgt7A33Xg8A
         jYRr2ip7CQBzURuURwvajVDdAKtykgPh0wfhrv0cGdKgGD8JNc4JolraX90vUMS/BRLz
         2M8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Und6/a+u/e43qwfpDbHhYJU3/UbWxvF+sZZzRPfE1rE=;
        b=jrfZY2YYbquBq7UqDcmf88hhsjC0oYFZNsDFUjEyqMMfKk8VLpW9Sbm0ARn9Pkf4TS
         sPbpP7bPI1/Lm9wjRxgCy8FwxbGp3GWIrvphHTwf+pZqjVYtDZHcw+oDjOR+vep6oAwF
         tD5KuXw7/8DETPCm26qgc3Vgv6RsN4DAabLoT1DAXCh5L1IlTSPhGEYvTjGGl1DczHLE
         kYyX2lEMUKgi6+cDkz8hWnNSGFvMXH92yAeVHAyfPCfx0N5Zc3d1TVoJVulnfDwqvxM9
         krM+DMTdhtL07GPiqjFHGROsUInsSd6CsaBV+UqfgyLLYG3fIdg//5HoHGLxqXuLY9jh
         6jYQ==
X-Gm-Message-State: AOAM533NHCaRrcqHGnXWPrQlxsSK4wZ1TbZsLiVDt4Jq2K8sf3pk71Ff
        FRxd8PBFQ7WxWQ7B1UJxXfraSA==
X-Google-Smtp-Source: ABdhPJwWgFcyzxJYD0rcGgDk9uxK+qaPVPBZKczYvkMY/5DXjRClsbKragjcSPz0I2t7zaJs5b6W/A==
X-Received: by 2002:a1c:4143:: with SMTP id o64mr21443454wma.50.1615720436916;
        Sun, 14 Mar 2021 04:13:56 -0700 (PDT)
Received: from localhost.localdomain ([82.142.0.212])
        by smtp.gmail.com with ESMTPSA id i8sm16828330wry.90.2021.03.14.04.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Mar 2021 04:13:56 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        lukasz.luba@arm.com, Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v3 3/5] thermal/drivers/devfreq_cooling: Use device name instead of auto-numbering
Date:   Sun, 14 Mar 2021 12:13:31 +0100
Message-Id: <20210314111333.16551-3-daniel.lezcano@linaro.org>
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

 thermal-devfreq-0
 thermal-devfreq-1
 etc ...

The 'thermal' prefix is redundant with the subsystem namespace. This
patch removes the 'thermal' prefix and changes the number by the device
name. So the naming above becomes:

 devfreq-5000000.gpu
 devfreq-1d84000.ufshc
 etc ...

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
---
V2:
 - Removed idr.h header
 - Used kasprintf instead of fixed buffer length on the stack
 - Fixed typo in the log
---
 drivers/thermal/devfreq_cooling.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
index fed3121ff2a1..fb250ac16f50 100644
--- a/drivers/thermal/devfreq_cooling.c
+++ b/drivers/thermal/devfreq_cooling.c
@@ -14,7 +14,6 @@
 #include <linux/devfreq_cooling.h>
 #include <linux/energy_model.h>
 #include <linux/export.h>
-#include <linux/idr.h>
 #include <linux/slab.h>
 #include <linux/pm_opp.h>
 #include <linux/pm_qos.h>
@@ -25,11 +24,8 @@
 #define HZ_PER_KHZ		1000
 #define SCALE_ERROR_MITIGATION	100
 
-static DEFINE_IDA(devfreq_ida);
-
 /**
  * struct devfreq_cooling_device - Devfreq cooling device
- * @id:		unique integer value corresponding to each
  *		devfreq_cooling_device registered.
  * @cdev:	Pointer to associated thermal cooling device.
  * @devfreq:	Pointer to associated devfreq device.
@@ -51,7 +47,6 @@ static DEFINE_IDA(devfreq_ida);
  * @em_pd:		Energy Model for the associated Devfreq device
  */
 struct devfreq_cooling_device {
-	int id;
 	struct thermal_cooling_device *cdev;
 	struct devfreq *devfreq;
 	unsigned long cooling_state;
@@ -363,7 +358,7 @@ of_devfreq_cooling_register_power(struct device_node *np, struct devfreq *df,
 	struct thermal_cooling_device *cdev;
 	struct device *dev = df->dev.parent;
 	struct devfreq_cooling_device *dfc;
-	char dev_name[THERMAL_NAME_LENGTH];
+	char *name;
 	int err, num_opps;
 
 	dfc = kzalloc(sizeof(*dfc), GFP_KERNEL);
@@ -407,30 +402,27 @@ of_devfreq_cooling_register_power(struct device_node *np, struct devfreq *df,
 	if (err < 0)
 		goto free_table;
 
-	err = ida_simple_get(&devfreq_ida, 0, 0, GFP_KERNEL);
-	if (err < 0)
+	cdev = ERR_PTR(-ENOMEM);
+	name = kasprintf(GFP_KERNEL, "devfreq-%s", dev_name(dev));
+	if (!name)
 		goto remove_qos_req;
 
-	dfc->id = err;
-
-	snprintf(dev_name, sizeof(dev_name), "thermal-devfreq-%d", dfc->id);
-
-	cdev = thermal_of_cooling_device_register(np, dev_name, dfc,
+	cdev = thermal_of_cooling_device_register(np, name, dfc,
 						  &devfreq_cooling_ops);
+	kfree(name);
+
 	if (IS_ERR(cdev)) {
 		err = PTR_ERR(cdev);
 		dev_err(dev,
 			"Failed to register devfreq cooling device (%d)\n",
 			err);
-		goto release_ida;
+		goto remove_qos_req;
 	}
 
 	dfc->cdev = cdev;
 
 	return cdev;
 
-release_ida:
-	ida_simple_remove(&devfreq_ida, dfc->id);
 remove_qos_req:
 	dev_pm_qos_remove_request(&dfc->req_max_freq);
 free_table:
@@ -527,7 +519,6 @@ void devfreq_cooling_unregister(struct thermal_cooling_device *cdev)
 	dev = dfc->devfreq->dev.parent;
 
 	thermal_cooling_device_unregister(dfc->cdev);
-	ida_simple_remove(&devfreq_ida, dfc->id);
 	dev_pm_qos_remove_request(&dfc->req_max_freq);
 
 	em_dev_unregister_perf_domain(dev);
-- 
2.17.1

