Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D99393DF5DE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 21:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240075AbhHCTkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 15:40:37 -0400
Received: from mga04.intel.com ([192.55.52.120]:21148 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240259AbhHCTk3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 15:40:29 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10065"; a="211899820"
X-IronPort-AV: E=Sophos;i="5.84,292,1620716400"; 
   d="scan'208";a="211899820"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2021 12:40:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,292,1620716400"; 
   d="scan'208";a="568769186"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 03 Aug 2021 12:40:15 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7FD15B9; Tue,  3 Aug 2021 22:40:44 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mark Gross <mgross@linux.intel.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
Subject: [RFT, PATCH v1 1/1] platform/x86: dell-smo8800: Convert to be a platform driver
Date:   Tue,  3 Aug 2021 22:40:39 +0300
Message-Id: <20210803194039.35083-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ACPI core in conjunction with platform driver core provides
an infrastructure to enumerate ACPI devices. Use it in order
to remove a lot of boilerplate code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/dell/Kconfig        |  2 +-
 drivers/platform/x86/dell/dell-smo8800.c | 74 ++++++------------------
 2 files changed, 20 insertions(+), 56 deletions(-)

diff --git a/drivers/platform/x86/dell/Kconfig b/drivers/platform/x86/dell/Kconfig
index 9e7314d90bea..821aba31821c 100644
--- a/drivers/platform/x86/dell/Kconfig
+++ b/drivers/platform/x86/dell/Kconfig
@@ -140,7 +140,7 @@ config DELL_SMBIOS_SMM
 config DELL_SMO8800
 	tristate "Dell Latitude freefall driver (ACPI SMO88XX)"
 	default m
-	depends on ACPI
+	depends on ACPI || COMPILE_TEST
 	help
 	  Say Y here if you want to support SMO88XX freefall devices
 	  on Dell Latitude laptops.
diff --git a/drivers/platform/x86/dell/dell-smo8800.c b/drivers/platform/x86/dell/dell-smo8800.c
index 5d9304a7de1b..3385e852104c 100644
--- a/drivers/platform/x86/dell/dell-smo8800.c
+++ b/drivers/platform/x86/dell/dell-smo8800.c
@@ -10,13 +10,14 @@
 
 #define DRIVER_NAME "smo8800"
 
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/acpi.h>
+#include <linux/fs.h>
 #include <linux/interrupt.h>
+#include <linux/kernel.h>
 #include <linux/miscdevice.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
 #include <linux/uaccess.h>
-#include <linux/fs.h>
 
 struct smo8800_device {
 	u32 irq;                     /* acpi device irq */
@@ -44,37 +45,6 @@ static irqreturn_t smo8800_interrupt_thread(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static acpi_status smo8800_get_resource(struct acpi_resource *resource,
-					void *context)
-{
-	struct acpi_resource_extended_irq *irq;
-
-	if (resource->type != ACPI_RESOURCE_TYPE_EXTENDED_IRQ)
-		return AE_OK;
-
-	irq = &resource->data.extended_irq;
-	if (!irq || !irq->interrupt_count)
-		return AE_OK;
-
-	*((u32 *)context) = irq->interrupts[0];
-	return AE_CTRL_TERMINATE;
-}
-
-static u32 smo8800_get_irq(struct acpi_device *device)
-{
-	u32 irq = 0;
-	acpi_status status;
-
-	status = acpi_walk_resources(device->handle, METHOD_NAME__CRS,
-				     smo8800_get_resource, &irq);
-	if (ACPI_FAILURE(status)) {
-		dev_err(&device->dev, "acpi_walk_resources failed\n");
-		return 0;
-	}
-
-	return irq;
-}
-
 static ssize_t smo8800_misc_read(struct file *file, char __user *buf,
 				 size_t count, loff_t *pos)
 {
@@ -136,7 +106,7 @@ static const struct file_operations smo8800_misc_fops = {
 	.release = smo8800_misc_release,
 };
 
-static int smo8800_add(struct acpi_device *device)
+static int smo8800_probe(struct platform_device *device)
 {
 	int err;
 	struct smo8800_device *smo8800;
@@ -160,14 +130,12 @@ static int smo8800_add(struct acpi_device *device)
 		return err;
 	}
 
-	device->driver_data = smo8800;
+	platform_set_drvdata(device, smo8800);
 
-	smo8800->irq = smo8800_get_irq(device);
-	if (!smo8800->irq) {
-		dev_err(&device->dev, "failed to obtain IRQ\n");
-		err = -EINVAL;
+	err = platform_get_irq(device, 0);
+	if (err < 0)
 		goto error;
-	}
+	smo8800->irq = err;
 
 	err = request_threaded_irq(smo8800->irq, smo8800_interrupt_quick,
 				   smo8800_interrupt_thread,
@@ -189,9 +157,9 @@ static int smo8800_add(struct acpi_device *device)
 	return err;
 }
 
-static int smo8800_remove(struct acpi_device *device)
+static int smo8800_remove(struct platform_device *device)
 {
-	struct smo8800_device *smo8800 = device->driver_data;
+	struct smo8800_device *smo8800 = platform_get_drvdata(device);
 
 	free_irq(smo8800->irq, smo8800);
 	misc_deregister(&smo8800->miscdev);
@@ -211,21 +179,17 @@ static const struct acpi_device_id smo8800_ids[] = {
 	{ "SMO8831", 0 },
 	{ "", 0 },
 };
-
 MODULE_DEVICE_TABLE(acpi, smo8800_ids);
 
-static struct acpi_driver smo8800_driver = {
-	.name = DRIVER_NAME,
-	.class = "Latitude",
-	.ids = smo8800_ids,
-	.ops = {
-		.add = smo8800_add,
-		.remove = smo8800_remove,
+static struct platform_driver smo8800_driver = {
+	.probe = smo8800_probe,
+	.remove = smo8800_remove,
+	.driver = {
+		.name = DRIVER_NAME,
+		.acpi_match_table = smo8800_ids,
 	},
-	.owner = THIS_MODULE,
 };
-
-module_acpi_driver(smo8800_driver);
+module_platform_driver(smo8800_driver);
 
 MODULE_DESCRIPTION("Dell Latitude freefall driver (ACPI SMO88XX)");
 MODULE_LICENSE("GPL");
-- 
2.30.2

