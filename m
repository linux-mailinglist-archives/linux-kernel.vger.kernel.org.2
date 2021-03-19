Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 479213421E9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 17:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbhCSQ3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 12:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbhCSQ27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 12:28:59 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E6AC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 09:28:58 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id d8-20020a1c1d080000b029010f15546281so5315688wmd.4
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 09:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=YgpsFQa+ssT3mpVSJ8Q1jPdWhVCO8gVCGDzCADExS50=;
        b=VKHtRA2n4mtkuU5BUHDf9wzhedc1tNL+Rt/dupUv2iwirDj8ECEHVy0S0noyByyEKo
         gbfKHuQk7aHdiYFrKoZHyoyE+jtJTEKGHcToF7ge0lfx8kR7bmzsoVeQ9wrg3gynwv2a
         zcze7KmxwFsVDhAq4sovmkEnjvzv1rzG/q+uL/PD0G9OFcHmo6Bu2Lw7KTFiZCwDmzHf
         H5S5LTaa79Ina1E/o3Aw8JZJh+wxt+kTB0Kmf4EWDo5jgbGZKxcEQXJ5V6ega+t9HulP
         95vrSQyBwEPNYc8wgYbGw+hPCoh2Y3uD0RTq2j8uUBrotOAHAyBpz86RtpAHMRP2PqDz
         Ztew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YgpsFQa+ssT3mpVSJ8Q1jPdWhVCO8gVCGDzCADExS50=;
        b=ouXtfbKqwI3m1SpAw1pMfseIc2I4hPKjfo6W4s0dBPZC3v0DqdVNoRkzCog9NszPEI
         nmvQWS96HrhsvKyiTC+mqf4ksijQVIWey45krIxcH6yIQWheWzRtqBneZm8PBrDg6VUU
         J+FKdXZ23+oqRV1e687vT7+aA4rqFJvyWCuE1KVAM4gvy8r8dSo2f0RmepR0GAC2TviY
         rlQj5ONZhxDnoR7CFp7rrcf/WdCwpOu86rjbNIRO6KOfZfQ8NMvMAGywnmyoRyPI7vQl
         f0dCbeV/mboWtr2pWeTAg2VbyMKZ38Tld1ugGjjoB9X33GWcZ+z5RcPNuUzqQdNNp47u
         bViA==
X-Gm-Message-State: AOAM532jIgN7Ur6FFzTDeHG1RUq3Oc6a+Hldy4iLzxPJVzVSe9CEB/67
        7orbP/JUCQr3SSN2KujM2gHfXw==
X-Google-Smtp-Source: ABdhPJyn31a9ffrv8v8kFksNATORwVF8RUG/gAXqXC362Ie2d54r/L3TWPWBJe8/UBKC2ASxhsv2Dw==
X-Received: by 2002:a05:600c:4151:: with SMTP id h17mr4535213wmm.68.1616171337289;
        Fri, 19 Mar 2021 09:28:57 -0700 (PDT)
Received: from localhost.localdomain ([82.142.13.80])
        by smtp.gmail.com with ESMTPSA id f126sm7100236wmf.17.2021.03.19.09.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 09:28:56 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org
Cc:     lukasz.luba@arm.com, cwchoi00@gmail.com, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, rafael@kernel.org
Subject: [PATCH] powercap/drivers/dtpm: Add dtpm devfreq with energy model support
Date:   Fri, 19 Mar 2021 17:28:36 +0100
Message-Id: <20210319162836.9364-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the dtpm supports the CPUs via cpufreq and the energy
model. This change provides the same for the device which supports
devfreq.

Each device supporting devfreq and having an energy model can register
themselves in the list of supported devices.

The concept is the same as the cpufreq dtpm support: the QoS is used
to aggregate the requests and the energy model gives the value of the
instantaneous power consumption ponderated by the load of the device.

Cc: Chanwoo Choi <cwchoi00@gmail.com>
Cc: Lukasz Luba <lukasz.luba@arm.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/powercap/Kconfig        |   7 ++
 drivers/powercap/Makefile       |   1 +
 drivers/powercap/dtpm_devfreq.c | 198 ++++++++++++++++++++++++++++++++
 include/linux/dtpm.h            |  13 +++
 4 files changed, 219 insertions(+)
 create mode 100644 drivers/powercap/dtpm_devfreq.c

diff --git a/drivers/powercap/Kconfig b/drivers/powercap/Kconfig
index 599b41e4e0a7..acdb047d8f1b 100644
--- a/drivers/powercap/Kconfig
+++ b/drivers/powercap/Kconfig
@@ -64,4 +64,11 @@ config DTPM_CPU
 	help
 	  This enables support for CPU power limitation based on
 	  energy model.
+
+config DTPM_DEVFREQ
+	bool "Add device power capping based on the energy model"
+	depends on DTPM && ENERGY_MODEL
+	help
+	  This enables support for device power limitation based on
+	  energy model.
 endif
diff --git a/drivers/powercap/Makefile b/drivers/powercap/Makefile
index 519cabc624c3..e47f4fd68fb9 100644
--- a/drivers/powercap/Makefile
+++ b/drivers/powercap/Makefile
@@ -2,6 +2,7 @@
 obj-$(CONFIG_DTPM) += dtpm.o
 obj-$(CONFIG_DTPM_CONFIGFS) += dtpm_configfs.o
 obj-$(CONFIG_DTPM_CPU) += dtpm_cpu.o
+obj-$(CONFIG_DTPM_DEVFREQ) += dtpm_devfreq.o
 obj-$(CONFIG_POWERCAP)	+= powercap_sys.o
 obj-$(CONFIG_INTEL_RAPL_CORE) += intel_rapl_common.o
 obj-$(CONFIG_INTEL_RAPL) += intel_rapl_msr.o
diff --git a/drivers/powercap/dtpm_devfreq.c b/drivers/powercap/dtpm_devfreq.c
new file mode 100644
index 000000000000..0f259238a45d
--- /dev/null
+++ b/drivers/powercap/dtpm_devfreq.c
@@ -0,0 +1,198 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2021 Linaro Limited
+ *
+ * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
+ *
+ * The devfreq device combined with the energy model and the load can
+ * give an estimation of the power consumption as well as limiting the
+ * power.
+ *
+ */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/cpumask.h>
+#include <linux/devfreq.h>
+#include <linux/dtpm.h>
+#include <linux/energy_model.h>
+#include <linux/pm_qos.h>
+#include <linux/slab.h>
+#include <linux/units.h>
+
+#ifndef HZ_PER_KHZ
+#define HZ_PER_KHZ 1000UL
+#endif
+
+struct dtpm_devfreq {
+	struct dtpm dtpm;
+	struct dev_pm_qos_request qos_req;
+	struct devfreq *devfreq;
+};
+
+struct dtpm_devfreq *to_dtpm_devfreq(struct dtpm *dtpm)
+{
+	return container_of(dtpm, struct dtpm_devfreq, dtpm);
+}
+
+static int update_pd_power_uw(struct dtpm *dtpm)
+{
+	struct dtpm_devfreq *dtpm_devfreq = to_dtpm_devfreq(dtpm);
+	struct devfreq *devfreq = dtpm_devfreq->devfreq;
+	struct device *dev = devfreq->dev.parent;
+	struct em_perf_domain *pd = em_pd_get(dev);
+
+	dtpm->power_min = pd->table[0].power;
+	dtpm->power_min *= MICROWATT_PER_MILLIWATT;
+
+	dtpm->power_max = pd->table[pd->nr_perf_states - 1].power;
+	dtpm->power_max *= MICROWATT_PER_MILLIWATT;
+
+	return 0;
+}
+
+static u64 set_pd_power_limit(struct dtpm *dtpm, u64 power_limit)
+{
+	struct dtpm_devfreq *dtpm_devfreq = to_dtpm_devfreq(dtpm);
+	struct devfreq *devfreq = dtpm_devfreq->devfreq;
+	struct device *dev = devfreq->dev.parent;
+	struct em_perf_domain *pd = em_pd_get(dev);
+	unsigned long freq;
+	u64 power;
+	int i;
+
+	for (i = 0; i < pd->nr_perf_states; i++) {
+
+		power = pd->table[i].power * MICROWATT_PER_MILLIWATT;
+		if (power > power_limit)
+			break;
+	}
+
+	freq = pd->table[i - 1].frequency;
+
+	dev_pm_qos_update_request(&dtpm_devfreq->qos_req, freq);
+
+	power_limit = pd->table[i - 1].power * MICROWATT_PER_MILLIWATT;
+
+	return power_limit;
+}
+
+static void _normalize_load(struct devfreq_dev_status *status)
+{
+	if (status->total_time > 0xfffff) {
+		status->total_time >>= 10;
+		status->busy_time >>= 10;
+	}
+
+	status->busy_time <<= 10;
+	status->busy_time /= status->total_time ? : 1;
+
+	status->busy_time = status->busy_time ? : 1;
+	status->total_time = 1024;
+}
+
+static u64 get_pd_power_uw(struct dtpm *dtpm)
+{
+	struct dtpm_devfreq *dtpm_devfreq = to_dtpm_devfreq(dtpm);
+	struct devfreq *devfreq = dtpm_devfreq->devfreq;
+	struct device *dev = devfreq->dev.parent;
+	struct em_perf_domain *pd = em_pd_get(dev);
+	struct devfreq_dev_status status;
+	unsigned long freq;
+	u64 power;
+	int i;
+
+	mutex_lock(&devfreq->lock);
+	status = devfreq->last_status;
+	mutex_unlock(&devfreq->lock);
+
+	freq = DIV_ROUND_UP(status.current_frequency, HZ_PER_KHZ);
+	_normalize_load(&status);
+
+	for (i = 0; i < pd->nr_perf_states; i++) {
+
+		if (pd->table[i].frequency < freq)
+			continue;
+
+		power = pd->table[i].power * MICROWATT_PER_MILLIWATT;
+		power *= status.busy_time;
+		power >>= 10;
+
+		return power;
+	}
+
+	return 0;
+}
+
+static void pd_release(struct dtpm *dtpm)
+{
+	struct dtpm_devfreq *dtpm_devfreq = to_dtpm_devfreq(dtpm);
+
+	if (dev_pm_qos_request_active(&dtpm_devfreq->qos_req))
+		dev_pm_qos_remove_request(&dtpm_devfreq->qos_req);
+
+	kfree(dtpm_devfreq);
+}
+
+static struct dtpm_ops dtpm_ops = {
+	.set_power_uw = set_pd_power_limit,
+	.get_power_uw = get_pd_power_uw,
+	.update_power_uw = update_pd_power_uw,
+	.release = pd_release,
+};
+
+int dtpm_register_devfreq(struct devfreq *devfreq)
+{
+	struct device *dev = devfreq->dev.parent;
+	struct dtpm_devfreq *dtpm_devfreq;
+	struct em_perf_domain *pd;
+	char *name;
+	int ret = -ENOMEM;
+
+	pd = em_pd_get(dev);
+	if (!pd) {
+		ret = dev_pm_opp_of_register_em(dev, NULL);
+		if (ret) {
+			pr_err("No energy model available for '%s'\n", name);
+			return -EINVAL;
+		}
+	}
+
+	dtpm_devfreq = kzalloc(sizeof(*dtpm_devfreq), GFP_KERNEL);
+	if (!dtpm_devfreq)
+		return -ENOMEM;
+
+	dtpm_init(&dtpm_devfreq->dtpm, &dtpm_ops);
+
+	dtpm_devfreq->devfreq = devfreq;
+
+	name = kasprintf(GFP_KERNEL, "%s-devfreq", dev_name(dev));
+	if (!name)
+		goto out_dtpm_devfreq;
+
+	ret = dtpm_register(name, &dtpm_devfreq->dtpm);
+	if (ret) {
+		pr_err("Failed to register '%s': %d\n", name, ret);
+		goto out_kfree_name;
+	}
+
+	ret = dev_pm_qos_add_request(dev, &dtpm_devfreq->qos_req,
+				     DEV_PM_QOS_MAX_FREQUENCY,
+				     PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE);
+	if (ret) {
+		pr_err("Failed to add QoS request: %d\n", ret);
+		goto out_dtpm_unregister;
+	}
+
+	kfree(name);
+
+	return 0;
+
+out_dtpm_unregister:
+	dtpm_unregister(name);
+out_kfree_name:
+	kfree(name);
+out_dtpm_devfreq:
+	kfree(dtpm_devfreq);
+
+	return ret;
+}
diff --git a/include/linux/dtpm.h b/include/linux/dtpm.h
index 6b9761aa5ea7..5df4f99c3553 100644
--- a/include/linux/dtpm.h
+++ b/include/linux/dtpm.h
@@ -80,4 +80,17 @@ void dtpm_unregister(const char *name);
 struct dtpm *dtpm_get(const char *name);
 
 void dtpm_put(struct dtpm *dtpm);
+
+#ifdef CONFIG_DTPM_DEVFREQ
+
+struct devfreq;
+
+int dtpm_register_devfreq(struct devfreq *devfreq);
+#else
+static inline int dtpm_register_devfreq(struct devfreq *devfreq)
+{
+	return 0;
+}
+#endif
+
 #endif
-- 
2.17.1

