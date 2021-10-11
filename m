Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 294494286A8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 08:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234053AbhJKGOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 02:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbhJKGN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 02:13:59 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4BD7C061570
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 23:11:59 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id u18so68885814lfd.12
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 23:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/dVgWc6+4MzoWRK42TiPE1G1HBCkwWERwf3JbfzTOpA=;
        b=7aoGcbgNBOSTaqyC1LCqGB78lTC9nWO3xXom9SeY39lkmSrxwAkkbJbzOxy8Qw8Lax
         dq71WZDQIp7PWLpawviuWd5bbdNuTCmJkusQ1RsQ+cEGIYx8BsPhcLRa+AOQ+zEvNeQF
         ciSxCmpjiUSYU+mZYnlXGhl6L0zgaVvOd76F/o/9PZ0DJUAW9m9ZuS0OuSq8M4+nNs8w
         NFt5wPhczFDKGSUpWWw+YahiAwvi88Vt+bcp+A/9qmzQ5/viOsmlYZKrDFCNeVqu42zG
         hDdmLdTkb08DZfWl05O28Ks2urAH2YDG2Gg6kdr7Ew2+8KNlmZZSR/iyMvLt/27O4p9m
         FYWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/dVgWc6+4MzoWRK42TiPE1G1HBCkwWERwf3JbfzTOpA=;
        b=g6dyKycACaCPJg35np/dQExoCahlhkkmum9WmtXAmlE7761kwUK+uZUU7kqcHXoif7
         7auK+/SRJ7hbhQ2TadsYwbd7rl6Cx/Efa0mwoPwv+w7LVdl4xjdVBSRjKiMXXtTh37Vg
         D0mBjbz32b3jcka3LkrXkp9uXfbBQQ4zZvcs7W6MRFybUtrZKYTiL+CWfooJ9an7cgNE
         XqxPIDfPu0nSOzonC7nTfikHkiTgrcgqJZiq2COhX39rCKGB8dDAK34VkQKJJr6p3qsr
         8iJD4uYo9OuLC+tRHzBCDuTRxiAyDM3F45AE1vQI+WvovIDPFbA9ACvPJyOsk9yqhqXs
         62fw==
X-Gm-Message-State: AOAM532GW1GsnAvO492TdOdSBlGetp/duxvkrubYOh4T+NTXLohYdNXr
        pFjXX03TvEh2Z3RHUfBwmxTQOQ==
X-Google-Smtp-Source: ABdhPJwllDyi9j3CEsK92cAQqYD4fdLr2nawUkaHJluQK2QqkkjEe4KiLN7CpgfD6kjM10KVxKHsAA==
X-Received: by 2002:a05:6512:39c5:: with SMTP id k5mr22647652lfu.230.1633932718217;
        Sun, 10 Oct 2021 23:11:58 -0700 (PDT)
Received: from cobook.home (nikaet.starlink.ru. [94.141.168.29])
        by smtp.gmail.com with ESMTPSA id b22sm638438lfv.286.2021.10.10.23.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Oct 2021 23:11:57 -0700 (PDT)
From:   Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christian Gromm <christian.gromm@microchip.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH v2 1/2] staging: most: dim2: do not double-register the same device
Date:   Mon, 11 Oct 2021 09:11:18 +0300
Message-Id: <20211011061117.21435-1-nikita.yoush@cogentembedded.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <YWKHvvLtb0MSJy2X@kroah.com>
References: <YWKHvvLtb0MSJy2X@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 723de0f9171e ("staging: most: remove device from interface
structure") moved registration of driver-provided struct device to
the most subsystem.

Dim2 used to register the same struct device to provide a custom device
attribute. This causes double-registration of the same struct device.

Fix that by moving the custom attribute to driver's dev_groups.
This moves attribute to the platform_device object, which is a better
location for platform-specific attributes anyway.

Fixes: 723de0f9171e ("staging: most: remove device from interface structure")
Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
Changes from v1:
- use ATTRIBUTE_GROUPS()
- use sysfs_emit()

 drivers/staging/most/dim2/Makefile |  2 +-
 drivers/staging/most/dim2/dim2.c   | 24 ++++++++-------
 drivers/staging/most/dim2/sysfs.c  | 49 ------------------------------
 drivers/staging/most/dim2/sysfs.h  | 11 -------
 4 files changed, 14 insertions(+), 72 deletions(-)
 delete mode 100644 drivers/staging/most/dim2/sysfs.c

diff --git a/drivers/staging/most/dim2/Makefile b/drivers/staging/most/dim2/Makefile
index 861adacf6c72..5f9612af3fa3 100644
--- a/drivers/staging/most/dim2/Makefile
+++ b/drivers/staging/most/dim2/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_MOST_DIM2) += most_dim2.o
 
-most_dim2-objs := dim2.o hal.o sysfs.o
+most_dim2-objs := dim2.o hal.o
diff --git a/drivers/staging/most/dim2/dim2.c b/drivers/staging/most/dim2/dim2.c
index e8b03fa90e80..96cb5280a385 100644
--- a/drivers/staging/most/dim2/dim2.c
+++ b/drivers/staging/most/dim2/dim2.c
@@ -118,7 +118,8 @@ struct dim2_platform_data {
 	(((p)[1] == 0x18) && ((p)[2] == 0x05) && ((p)[3] == 0x0C) && \
 	 ((p)[13] == 0x3C) && ((p)[14] == 0x00) && ((p)[15] == 0x0A))
 
-bool dim2_sysfs_get_state_cb(void)
+static ssize_t state_show(struct device *dev, struct device_attribute *attr,
+			  char *buf)
 {
 	bool state;
 	unsigned long flags;
@@ -127,9 +128,18 @@ bool dim2_sysfs_get_state_cb(void)
 	state = dim_get_lock_state();
 	spin_unlock_irqrestore(&dim_lock, flags);
 
-	return state;
+	return sysfs_emit(buf, "%s\n", state ? "locked" : "");
 }
 
+static DEVICE_ATTR_RO(state);
+
+static struct attribute *dim2_attrs[] = {
+	&dev_attr_state.attr,
+	NULL,
+};
+
+ATTRIBUTE_GROUPS(dim2);
+
 /**
  * dimcb_on_error - callback from HAL to report miscommunication between
  * HDM and HAL
@@ -874,16 +884,8 @@ static int dim2_probe(struct platform_device *pdev)
 		goto err_stop_thread;
 	}
 
-	ret = dim2_sysfs_probe(&dev->dev);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to create sysfs attribute\n");
-		goto err_unreg_iface;
-	}
-
 	return 0;
 
-err_unreg_iface:
-	most_deregister_interface(&dev->most_iface);
 err_stop_thread:
 	kthread_stop(dev->netinfo_task);
 err_shutdown_dim:
@@ -906,7 +908,6 @@ static int dim2_remove(struct platform_device *pdev)
 	struct dim2_hdm *dev = platform_get_drvdata(pdev);
 	unsigned long flags;
 
-	dim2_sysfs_destroy(&dev->dev);
 	most_deregister_interface(&dev->most_iface);
 	kthread_stop(dev->netinfo_task);
 
@@ -1100,6 +1101,7 @@ static struct platform_driver dim2_driver = {
 	.driver = {
 		.name = "hdm_dim2",
 		.of_match_table = dim2_of_match,
+		.dev_groups = dim2_groups,
 	},
 };
 
diff --git a/drivers/staging/most/dim2/sysfs.c b/drivers/staging/most/dim2/sysfs.c
deleted file mode 100644
index c85b2cdcdca3..000000000000
--- a/drivers/staging/most/dim2/sysfs.c
+++ /dev/null
@@ -1,49 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * sysfs.c - MediaLB sysfs information
- *
- * Copyright (C) 2015, Microchip Technology Germany II GmbH & Co. KG
- */
-
-/* Author: Andrey Shvetsov <andrey.shvetsov@k2l.de> */
-
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
-#include <linux/kernel.h>
-#include "sysfs.h"
-#include <linux/device.h>
-
-static ssize_t state_show(struct device *dev, struct device_attribute *attr,
-			  char *buf)
-{
-	bool state = dim2_sysfs_get_state_cb();
-
-	return sprintf(buf, "%s\n", state ? "locked" : "");
-}
-
-static DEVICE_ATTR_RO(state);
-
-static struct attribute *dev_attrs[] = {
-	&dev_attr_state.attr,
-	NULL,
-};
-
-static struct attribute_group dev_attr_group = {
-	.attrs = dev_attrs,
-};
-
-static const struct attribute_group *dev_attr_groups[] = {
-	&dev_attr_group,
-	NULL,
-};
-
-int dim2_sysfs_probe(struct device *dev)
-{
-	dev->groups = dev_attr_groups;
-	return device_register(dev);
-}
-
-void dim2_sysfs_destroy(struct device *dev)
-{
-	device_unregister(dev);
-}
diff --git a/drivers/staging/most/dim2/sysfs.h b/drivers/staging/most/dim2/sysfs.h
index 24277a17cff3..09115cf4ed00 100644
--- a/drivers/staging/most/dim2/sysfs.h
+++ b/drivers/staging/most/dim2/sysfs.h
@@ -16,15 +16,4 @@ struct medialb_bus {
 	struct kobject kobj_group;
 };
 
-struct device;
-
-int dim2_sysfs_probe(struct device *dev);
-void dim2_sysfs_destroy(struct device *dev);
-
-/*
- * callback,
- * must deliver MediaLB state as true if locked or false if unlocked
- */
-bool dim2_sysfs_get_state_cb(void);
-
 #endif	/* DIM2_SYSFS_H */
-- 
2.30.2

