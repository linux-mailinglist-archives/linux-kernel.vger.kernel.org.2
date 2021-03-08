Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B787330F48
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 14:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbhCHNdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 08:33:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbhCHNdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 08:33:06 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2091AC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 05:33:06 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id a18so11421082wrc.13
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 05:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=J0pMDMLQYonh2LUAb2dlhU8EbvFz9XpgingsiOtgtMc=;
        b=aznnqh2T3Zo/ye0wQxu4uu7WkI9p4Fo1vM45a+PbzzUbGXmV+uoFVC65GRcNOuebGg
         E5BvHVz/7mdWhAYj9loL7956OKzGXqDNPdqWlcqjE91NNGT3ZXHdSXmIEc2+8eGCoWYY
         kjqdsdoqhpmZ8Snkd43BgFzLBL33N6nAvimZYEXy/m3UJ/JGdY0kkHmK626VA58wnLkM
         K7H9bMbVItZS2QRjUgy5IHyHXs1EDmg1giqbaqfNgcRclQfgvwCYDATqHTBewo7C6lsw
         AClNtA0GF0e6NkU8HulZDKP1uzL7DF33tucki9I/OZquVvMdCuxIAZvn87IKJoAkITTi
         7WCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=J0pMDMLQYonh2LUAb2dlhU8EbvFz9XpgingsiOtgtMc=;
        b=TNIhkwYpv/AZW4uTsDec6vtN59CqlTfhj6LeHKOXzmJ3Ff8koTIRDAi5cP+PfvUPTE
         V1Z81zIJwtYB2I/9BC/4f/i6zVewr2d7bmAR45zz3G0Ux4q+gZj9Iwz6Zy3uZ4fsXe6o
         AO+r8aYjpXHHSb52FVKw4pWATC7MNAkFpZg51Sl9pDjgCnm5egkhyT/iPKcOliOUCIsw
         M+jkKY4WQsJvEQUD2YzYcMFy9hO0qPJhFbEUefIqCvDFCR9ju+Jp3Wc/J0Lxv9FYER6a
         nL+sXP6zViRenKetYn+5Pzz50wpspf9G26da7MjfmEbOXvAc5j/znlq0LfjMpC36zjDc
         iigw==
X-Gm-Message-State: AOAM531YE2qFXVp+GcFoZRJzW+8Q5nfLbFNdtVazFPlVMOg/JN2TlTqc
        iBTfanxg6UCqmNwWxEfzTZsO2g==
X-Google-Smtp-Source: ABdhPJzP+tBg7x/TF2MoluQB+vkl2Pe4y4GFj8UWHQo9uVl68VMk6NHFuFiSqg+ZOzM03r4vF13hDA==
X-Received: by 2002:adf:8545:: with SMTP id 63mr22485301wrh.128.1615210384711;
        Mon, 08 Mar 2021 05:33:04 -0800 (PST)
Received: from localhost.localdomain (lns-bzn-59-82-252-141-80.adsl.proxad.net. [82.252.141.80])
        by smtp.gmail.com with ESMTPSA id m11sm18942665wrz.40.2021.03.08.05.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 05:33:04 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     cwchoi00@gmail.com
Cc:     lukasz.luba@arm.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, steven.price@arm.com,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v6 1/4] PM / devfreq: Register devfreq as a cooling device on demand
Date:   Mon,  8 Mar 2021 14:30:37 +0100
Message-Id: <20210308133041.10516-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the default behavior is to manually having the devfreq
backend to register themselves as a devfreq cooling device.

Instead of adding the code in the drivers for the thermal cooling
device registering, let's provide a flag in the devfreq's profile to
tell the common devfreq code to register the newly created devfreq as
a cooling device.

Suggested-by: Chanwoo Choi <cwchoi00@gmail.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Steven Price <steven.price@arm.com>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
---
 V6:
   - Did one line string instead of multiline
   - Removed thermal.h header inclusion as it is in devfreq_cooling.h
   - Added forward declaration for thermal_cooling_device pointer in devfreq.h
 V5:
   - Changed subject prefix by:  PM / devfreq
 V4:
   - Replaced thermal_cooling_device_unregister() by
     devfreq_cooling_unregister()
 V3:
   - Rebased on linux-pm branch without units.h
   - Set the cdev to NULL in case of error
   - Added description for the cdev field in the devfreq structure
 V2:
   - Added is_cooling_device boolean in profile structure
   - Register cooling device when the is_cooling_device boolean is set
   - Remove devfreq cooling device registration in the backend drivers
 V1:
   - Register devfreq as a cooling device unconditionnally
---
 drivers/devfreq/devfreq.c | 9 +++++++++
 include/linux/devfreq.h   | 9 +++++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index bf3047896e41..b6d3e7db0b09 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -11,6 +11,7 @@
 #include <linux/kmod.h>
 #include <linux/sched.h>
 #include <linux/debugfs.h>
+#include <linux/devfreq_cooling.h>
 #include <linux/errno.h>
 #include <linux/err.h>
 #include <linux/init.h>
@@ -935,6 +936,12 @@ struct devfreq *devfreq_add_device(struct device *dev,
 
 	mutex_unlock(&devfreq_list_lock);
 
+	if (devfreq->profile->is_cooling_device) {
+		devfreq->cdev = devfreq_cooling_em_register(devfreq, NULL);
+		if (IS_ERR(devfreq->cdev))
+			devfreq->cdev = NULL;
+	}
+
 	return devfreq;
 
 err_init:
@@ -960,6 +967,8 @@ int devfreq_remove_device(struct devfreq *devfreq)
 	if (!devfreq)
 		return -EINVAL;
 
+	devfreq_cooling_unregister(devfreq->cdev);
+
 	if (devfreq->governor) {
 		devfreq->governor->event_handler(devfreq,
 						 DEVFREQ_GOV_STOP, NULL);
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index 26ea0850be9b..142474b4af96 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -38,6 +38,7 @@ enum devfreq_timer {
 
 struct devfreq;
 struct devfreq_governor;
+struct thermal_cooling_device;
 
 /**
  * struct devfreq_dev_status - Data given from devfreq user device to
@@ -98,11 +99,15 @@ struct devfreq_dev_status {
  * @freq_table:		Optional list of frequencies to support statistics
  *			and freq_table must be generated in ascending order.
  * @max_state:		The size of freq_table.
+ *
+ * @is_cooling_device: A self-explanatory boolean giving the device a
+ *                     cooling effect property.
  */
 struct devfreq_dev_profile {
 	unsigned long initial_freq;
 	unsigned int polling_ms;
 	enum devfreq_timer timer;
+	bool is_cooling_device;
 
 	int (*target)(struct device *dev, unsigned long *freq, u32 flags);
 	int (*get_dev_status)(struct device *dev,
@@ -156,6 +161,7 @@ struct devfreq_stats {
  * @suspend_count:	 suspend requests counter for a device.
  * @stats:	Statistics of devfreq device behavior
  * @transition_notifier_list: list head of DEVFREQ_TRANSITION_NOTIFIER notifier
+ * @cdev:	Cooling device pointer if the devfreq has cooling property
  * @nb_min:		Notifier block for DEV_PM_QOS_MIN_FREQUENCY
  * @nb_max:		Notifier block for DEV_PM_QOS_MAX_FREQUENCY
  *
@@ -198,6 +204,9 @@ struct devfreq {
 
 	struct srcu_notifier_head transition_notifier_list;
 
+	/* Pointer to the cooling device if used for thermal mitigation */
+	struct thermal_cooling_device *cdev;
+
 	struct notifier_block nb_min;
 	struct notifier_block nb_max;
 };
-- 
2.17.1

