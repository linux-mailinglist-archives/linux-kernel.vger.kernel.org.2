Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC8E316418
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 11:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbhBJKnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 05:43:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbhBJKl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 05:41:28 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E37C061786
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 02:40:47 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id t29so980072pfg.11
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 02:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NkuoftoATf5MGj312K8XaUKxCWacao5e0Zxk3QNi+MM=;
        b=Gnaj/hxyIQ2c5YifSVxpjkP8x45IcB2DtplD2cVRgmqzGccuq7Ep6FHuJGKLBDCAwR
         9myCuhkXRkK99aJI7GrYryohTHpXHAUQC21RuhvlKkcrb7TrIErlSNRltDBhrl2jJZSN
         BnPujlWQ8PBbmIyuEQpJOvo0D8yvA8NHe0eZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NkuoftoATf5MGj312K8XaUKxCWacao5e0Zxk3QNi+MM=;
        b=smgp2XgrgVR71jqcTWHs9Lg3TmZZo+z87pxkg8o3XIf3tneSuGIUv0pQisLtzdnuc1
         0vbmmTb0KhCSZjBRMArG+y8awDO0Vx8np/K9GcOJHijgmL0cnQ80bREcrFRZ2EGoZ1up
         rC7NBHIMCns767SLKsariQW+p4ZstW3yhWFH1jafADPTJ4iZ0gJv8VJqLKL0RpYAwpRF
         2xXwJGz/yGllF8fvJQBe2uCcDZbYWVK2Kzq9jSWfSOKFsezSiC2OkVa9kkPXZSbJk7DW
         vz3yNpAaHEhLkIvy/yGjM13Nar3cWEQ78Np8mD6PXoc5l2WH0NrIYudT/pzLTCrWrw/a
         egvQ==
X-Gm-Message-State: AOAM533UapF0pNUzzOt/yM5kV1N0q935RXyUx+QNs4U0ZxcbdZHxKuVf
        dCZQYHOIrsPUtxvUcdmrFG7dXkXG8hbfBindjJc=
X-Google-Smtp-Source: ABdhPJwy7U3EWdKWIeFhC4hpg9WAxJDpQlaAIliiZP/YA+uFBlysnaFfZF0YZNN8efc6jaFGzfdGxA==
X-Received: by 2002:a63:f044:: with SMTP id s4mr2452738pgj.355.1612953646370;
        Wed, 10 Feb 2021 02:40:46 -0800 (PST)
Received: from hikalium0.c.googlers.com.com (160.131.236.35.bc.googleusercontent.com. [35.236.131.160])
        by smtp.gmail.com with ESMTPSA id j20sm1908729pfe.172.2021.02.10.02.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 02:40:45 -0800 (PST)
From:   Hikaru Nishida <hikalium@chromium.org>
X-Google-Original-From: Hikaru Nishida <hikalium@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     suleiman@google.com, Hikaru Nishida <hikalium@chromium.org>,
        Alexander Graf <graf@amazon.com>,
        Andra Paraschiv <andraprs@amazon.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [RFC PATCH 2/2] drivers/virt: introduce CLOCK_BOOTTIME adjustment sysfs interface driver
Date:   Wed, 10 Feb 2021 19:39:08 +0900
Message-Id: <20210210193728.RFC.2.I03c0323c1564a18210ec98fb78b3eb728a90c2d2@changeid>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
In-Reply-To: <20210210103908.1720658-1-hikalium@google.com>
References: <20210210103908.1720658-1-hikalium@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hikaru Nishida <hikalium@chromium.org>

This adds a sysfs interface /sys/kernel/boottime_adj to enable advancing
CLOCK_BOOTTIME from the userspace without actual susupend/resume cycles.

This gives a way to mitigate CLOCK_BOOTTIME divergence between guest
and host on virtualized environments after suspend/resume cycles on
the host.

We observed an issue of a guest application that expects there is a gap
between CLOCK_BOOTTIME and CLOCK_MONOTONIC after the device is suspended
to detect whether the device went into suspend or not.
Since the guest is paused instead of being actually suspended during the
host's suspension, guest kernel doesn't advance CLOCK_BOOTTIME correctly
and there is no way to correct that.

To solve the problem, this change introduces a way to modify a gap
between those clocks and align the timer behavior to host's one.

Signed-off-by: Hikaru Nishida <hikalium@chromium.org>
---

 drivers/virt/Kconfig        |  9 ++++++
 drivers/virt/Makefile       |  1 +
 drivers/virt/boottime_adj.c | 57 +++++++++++++++++++++++++++++++++++++
 3 files changed, 67 insertions(+)
 create mode 100644 drivers/virt/boottime_adj.c

diff --git a/drivers/virt/Kconfig b/drivers/virt/Kconfig
index 80c5f9c16ec1..149b4e763e4d 100644
--- a/drivers/virt/Kconfig
+++ b/drivers/virt/Kconfig
@@ -13,6 +13,15 @@ menuconfig VIRT_DRIVERS
 
 if VIRT_DRIVERS
 
+config BOOTTIME_ADJUSTMENT
+	tristate "CLOCK_BOOTTIME adjustment sysfs interface"
+	help
+          The CLOCK_BOOTTIME adjustment sysfs interface driver
+          provides a sysfs interface ( /sys/kernel/boottime_adj )
+          to enable adjusting CLOCK_BOOTTIME from the userspace.
+
+          If unsure, say N.
+
 config FSL_HV_MANAGER
 	tristate "Freescale hypervisor management driver"
 	depends on FSL_SOC
diff --git a/drivers/virt/Makefile b/drivers/virt/Makefile
index f28425ce4b39..1bbb476ddba9 100644
--- a/drivers/virt/Makefile
+++ b/drivers/virt/Makefile
@@ -3,6 +3,7 @@
 # Makefile for drivers that support virtualization
 #
 
+obj-$(CONFIG_BOOTTIME_ADJUSTMENT)	+= boottime_adj.o
 obj-$(CONFIG_FSL_HV_MANAGER)	+= fsl_hypervisor.o
 obj-y				+= vboxguest/
 
diff --git a/drivers/virt/boottime_adj.c b/drivers/virt/boottime_adj.c
new file mode 100644
index 000000000000..9cc717d8accc
--- /dev/null
+++ b/drivers/virt/boottime_adj.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * CLOCK_BOOTTIME Adjustment Interface Driver
+ */
+
+#include <linux/kobject.h>
+#include <linux/module.h>
+#include <linux/timekeeping.h>
+
+static struct kobject *kobj_boottime_adj;
+
+/*
+ * Write to /sys/kernel/boottime_adj advances CLOCK_BOOTTIME by given delta.
+ */
+static ssize_t boottime_adj_write(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf,
+		size_t count)
+{
+	int error;
+	struct timespec64 delta;
+
+	if (sscanf(buf, "%lld %ld", &delta.tv_sec, &delta.tv_nsec) != 2)
+		return -EINVAL;
+
+	error = timekeeping_adjust_boottime(&delta);
+	if (error)
+		return error;
+
+	pr_info("%s: CLOCK_BOOTTIME has been advanced by %+lld seconds and %+ld nanoseconds\n",
+			__func__, delta.tv_sec, delta.tv_nsec);
+	return count;
+}
+
+static struct kobj_attribute boottime_adj_attr =
+__ATTR(boottime_adj, 0200, NULL, boottime_adj_write);
+
+static int __init boottime_adj_init(void)
+{
+	int error;
+
+	error = sysfs_create_file(kernel_kobj, &boottime_adj_attr.attr);
+	if (error) {
+		pr_warn("%s: failed to init\n", __func__);
+		return error;
+	}
+	return 0;
+}
+
+static void __exit boottime_adj_cleanup(void)
+{
+	kobject_put(kobj_boottime_adj);
+}
+
+module_init(boottime_adj_init);
+module_exit(boottime_adj_cleanup);
+MODULE_DESCRIPTION("CLOCK_BOOTTIME adjustment interface driver");
+MODULE_LICENSE("GPL");
-- 
2.30.0.478.g8a0d178c01-goog

