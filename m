Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D683539A1A3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 14:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbhFCM5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 08:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhFCM5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 08:57:32 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9561CC061756
        for <linux-kernel@vger.kernel.org>; Thu,  3 Jun 2021 05:55:47 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: aratiu)
        with ESMTPSA id CCB041F4305B
From:   Adrian Ratiu <adrian.ratiu@collabora.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, kernel@collabora.com,
        linux-kernel@vger.kernel.org,
        Guillaume Tucker <gtucker.collabora@gmail.com>,
        =?UTF-8?q?Enric=20Balletb=C3=B2?= <enric.balletbo@collabora.com>
Subject: [RFC PATCH 1/1] drivers: base: Expose probe failures via debugfs
Date:   Thu,  3 Jun 2021 15:55:34 +0300
Message-Id: <20210603125534.638672-2-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210603125534.638672-1-adrian.ratiu@collabora.com>
References: <20210603125534.638672-1-adrian.ratiu@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a new devices_failed debugfs attribute to list driver
probe failures excepting -EPROBE_DEFER which are still handled
as before via their own devices_deferred attribute.

This is useful on automated test systems like KernelCI to avoid
filtering dmesg dev_err() messages to extract potential probe
failures.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Guillaume Tucker <gtucker.collabora@gmail.com>
Suggested-by: Enric Balletbò <enric.balletbo@collabora.com>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 drivers/base/core.c | 76 +++++++++++++++++++++++++++++++++++++++++++--
 lib/Kconfig.debug   | 23 ++++++++++++++
 2 files changed, 96 insertions(+), 3 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index b8a8c96dca58..74bf057234b8 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -9,7 +9,9 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/circ_buf.h>
 #include <linux/cpufreq.h>
+#include <linux/debugfs.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/fwnode.h>
@@ -53,6 +55,15 @@ static DEFINE_MUTEX(fwnode_link_lock);
 static bool fw_devlink_is_permissive(void);
 static bool fw_devlink_drv_reg_done;
 
+#ifdef CONFIG_DEBUG_FS_PROBE_ERR
+#define PROBE_ERR_BUF_ELEM_SIZE	64
+#define PROBE_ERR_BUF_SIZE	(1 << CONFIG_DEBUG_FS_PROBE_ERR_BUF_SHIFT)
+static struct circ_buf probe_err_crbuf;
+static char failed_probe_buffer[PROBE_ERR_BUF_SIZE];
+static DEFINE_MUTEX(failed_probe_mutex);
+static struct dentry *devices_failed_probe;
+#endif
+
 /**
  * fwnode_link_add - Create a link between two fwnode_handles.
  * @con: Consumer end of the link.
@@ -3769,6 +3780,29 @@ struct device *device_find_child_by_name(struct device *parent,
 }
 EXPORT_SYMBOL_GPL(device_find_child_by_name);
 
+/*
+ * failed_devs_show() - Show devices & drivers which failed to probe.
+ */
+#ifdef CONFIG_DEBUG_FS_PROBE_ERR
+static int failed_devs_show(struct seq_file *s, void *data)
+{
+	size_t offset;
+
+	mutex_lock(&failed_probe_mutex);
+
+	for (offset = 0;
+	     offset < PROBE_ERR_BUF_SIZE;
+	     offset += PROBE_ERR_BUF_ELEM_SIZE)
+		if (probe_err_crbuf.buf[offset])
+			seq_printf(s, "%s\n", probe_err_crbuf.buf + offset);
+
+	mutex_unlock(&failed_probe_mutex);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(failed_devs);
+#endif
+
 int __init devices_init(void)
 {
 	devices_kset = kset_create_and_add("devices", &device_uevent_ops, NULL);
@@ -3784,6 +3818,12 @@ int __init devices_init(void)
 	if (!sysfs_dev_char_kobj)
 		goto char_kobj_err;
 
+#ifdef CONFIG_DEBUG_FS_PROBE_ERR
+	devices_failed_probe = debugfs_create_file("devices_failed", 0444, NULL,
+						   NULL, &failed_devs_fops);
+	probe_err_crbuf.buf = failed_probe_buffer;
+#endif
+
 	return 0;
 
  char_kobj_err:
@@ -4623,6 +4663,34 @@ define_dev_printk_level(_dev_info, KERN_INFO);
 
 #endif
 
+/**
+ * device_log_probe_failure: Print err to kernel log then add debugfs entry
+ * @dev: the pointer to the struct device
+ * @err: error value to print
+ * @vaf: struct containing printf-style error format string and arguments
+ */
+void device_log_probe_failure(const struct device *dev, int err,
+			      struct va_format *vaf)
+{
+	dev_err(dev, "error %pe: %pV", ERR_PTR(err), vaf);
+
+#ifdef CONFIG_DEBUG_FS_PROBE_ERR
+	mutex_lock(&failed_probe_mutex);
+
+	snprintf(probe_err_crbuf.buf + probe_err_crbuf.head,
+		 PROBE_ERR_BUF_ELEM_SIZE,
+		 "%s %s %d %pV",
+		 dev_driver_string(dev), dev_name(dev), err, vaf);
+
+	if (probe_err_crbuf.head < PROBE_ERR_BUF_SIZE - PROBE_ERR_BUF_ELEM_SIZE)
+		probe_err_crbuf.head += PROBE_ERR_BUF_ELEM_SIZE;
+	else
+		probe_err_crbuf.head = 0;
+
+	mutex_unlock(&failed_probe_mutex);
+#endif
+}
+
 /**
  * dev_err_probe - probe error check and log helper
  * @dev: the pointer to the struct device
@@ -4631,10 +4699,12 @@ define_dev_printk_level(_dev_info, KERN_INFO);
  * @...: arguments as specified in the format string
  *
  * This helper implements common pattern present in probe functions for error
- * checking: print debug or error message depending if the error value is
- * -EPROBE_DEFER and propagate error upwards.
+ * checking: print debug or error message depending on the error value and then
+ * propagate the error upwards.
  * In case of -EPROBE_DEFER it sets also defer probe reason, which can be
  * checked later by reading devices_deferred debugfs attribute.
+ * Errors other than -EPROBE_DEFER can be checked by reading the devices_failed
+ * debugfs attribute if CONFIG_DEBUG_FS_PROBE_ERR is enabled.
  * It replaces code sequence::
  *
  * 	if (err != -EPROBE_DEFER)
@@ -4660,7 +4730,7 @@ int dev_err_probe(const struct device *dev, int err, const char *fmt, ...)
 	vaf.va = &args;
 
 	if (err != -EPROBE_DEFER) {
-		dev_err(dev, "error %pe: %pV", ERR_PTR(err), &vaf);
+		device_log_probe_failure(dev, err, &vaf);
 	} else {
 		device_set_deferred_probe_reason(dev, &vaf);
 		dev_dbg(dev, "error %pe: %pV", ERR_PTR(err), &vaf);
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 150f13baa6cc..10044ba47c26 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -578,6 +578,29 @@ config DEBUG_FS_ALLOW_NONE
 
 endchoice
 
+config DEBUG_FS_PROBE_ERR
+	bool "Show device driver probe failures"
+	depends on DEBUG_FS
+	help
+	  This feature enables a devices_failed debugfs attribute exposing
+	  driver probe failures different from -EPROBE_DEFER.
+
+config DEBUG_FS_PROBE_ERR_BUF_SHIFT
+	int "Probe failures log buffer size"
+	depends on DEBUG_FS && DEBUG_FS_PROBE_ERR
+	range 12 16
+	default 12
+	help
+	  This options allows to increase the default ringbuffer size for
+	  driver probe failures as a power of 2.
+
+	  Examples:
+		     16 => 64 KB
+		     15 => 32 KB
+		     14 => 16 KB
+		     13 =>  8 KB
+		     12 =>  4 KB
+
 source "lib/Kconfig.kgdb"
 source "lib/Kconfig.ubsan"
 source "lib/Kconfig.kcsan"
-- 
2.31.1

