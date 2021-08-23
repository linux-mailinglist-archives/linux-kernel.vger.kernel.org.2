Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC7123F47AA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 11:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236045AbhHWJdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 05:33:51 -0400
Received: from mga17.intel.com ([192.55.52.151]:38854 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236091AbhHWJdh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 05:33:37 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10084"; a="197317356"
X-IronPort-AV: E=Sophos;i="5.84,344,1620716400"; 
   d="scan'208";a="197317356"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2021 02:32:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,344,1620716400"; 
   d="scan'208";a="642772522"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 23 Aug 2021 02:32:52 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E39E8D1; Mon, 23 Aug 2021 12:32:52 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Cc:     Eric Piel <eric.piel@tremplin-utc.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>
Subject: [PATCH v2 2/2] platform/x86: hp_accel: Convert to be a platform driver
Date:   Mon, 23 Aug 2021 12:32:22 +0300
Message-Id: <20210823093222.19544-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210823093222.19544-1-andriy.shevchenko@linux.intel.com>
References: <20210823093222.19544-1-andriy.shevchenko@linux.intel.com>
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
 drivers/platform/x86/hp_accel.c | 64 ++++++++-------------------------
 1 file changed, 14 insertions(+), 50 deletions(-)

diff --git a/drivers/platform/x86/hp_accel.c b/drivers/platform/x86/hp_accel.c
index 54a4addc7903..cc53f725c041 100644
--- a/drivers/platform/x86/hp_accel.c
+++ b/drivers/platform/x86/hp_accel.c
@@ -28,9 +28,6 @@
 #include <linux/serio.h>
 #include "../../misc/lis3lv02d/lis3lv02d.h"
 
-#define DRIVER_NAME     "hp_accel"
-#define ACPI_MDPS_CLASS "accelerometer"
-
 /* Delayed LEDs infrastructure ------------------------------------ */
 
 /* Special LED class that can defer work */
@@ -269,30 +266,6 @@ static struct delayed_led_classdev hpled_led = {
 	.set_brightness = hpled_set,
 };
 
-static acpi_status
-lis3lv02d_get_resource(struct acpi_resource *resource, void *context)
-{
-	if (resource->type == ACPI_RESOURCE_TYPE_EXTENDED_IRQ) {
-		struct acpi_resource_extended_irq *irq;
-		u32 *device_irq = context;
-
-		irq = &resource->data.extended_irq;
-		*device_irq = irq->interrupts[0];
-	}
-
-	return AE_OK;
-}
-
-static void lis3lv02d_enum_resources(struct acpi_device *device)
-{
-	acpi_status status;
-
-	status = acpi_walk_resources(device->handle, METHOD_NAME__CRS,
-					lis3lv02d_get_resource, &lis3_dev.irq);
-	if (ACPI_FAILURE(status))
-		printk(KERN_DEBUG DRIVER_NAME ": Error getting resources\n");
-}
-
 static bool hp_accel_i8042_filter(unsigned char data, unsigned char str,
 				  struct serio *port)
 {
@@ -322,23 +295,19 @@ static bool hp_accel_i8042_filter(unsigned char data, unsigned char str,
 	return false;
 }
 
-static int lis3lv02d_add(struct acpi_device *device)
+static int lis3lv02d_probe(struct platform_device *device)
 {
 	int ret;
 
-	if (!device)
-		return -EINVAL;
-
-	lis3_dev.bus_priv = device;
+	lis3_dev.bus_priv = ACPI_COMPANION(&device->dev);
 	lis3_dev.init = lis3lv02d_acpi_init;
 	lis3_dev.read = lis3lv02d_acpi_read;
 	lis3_dev.write = lis3lv02d_acpi_write;
-	strcpy(acpi_device_name(device), DRIVER_NAME);
-	strcpy(acpi_device_class(device), ACPI_MDPS_CLASS);
-	device->driver_data = &lis3_dev;
 
 	/* obtain IRQ number of our device from ACPI */
-	lis3lv02d_enum_resources(device);
+	ret = platform_get_irq_optional(device, 0);
+	if (ret > 0)
+		lis3_dev.irq = ret;
 
 	/* If possible use a "standard" axes order */
 	if (lis3_dev.ac.x && lis3_dev.ac.y && lis3_dev.ac.z) {
@@ -371,11 +340,8 @@ static int lis3lv02d_add(struct acpi_device *device)
 	return ret;
 }
 
-static int lis3lv02d_remove(struct acpi_device *device)
+static int lis3lv02d_remove(struct platform_device *device)
 {
-	if (!device)
-		return -EINVAL;
-
 	i8042_remove_filter(hp_accel_i8042_filter);
 	lis3lv02d_joystick_disable(&lis3_dev);
 	lis3lv02d_poweroff(&lis3_dev);
@@ -386,7 +352,6 @@ static int lis3lv02d_remove(struct acpi_device *device)
 	return lis3lv02d_remove_fs(&lis3_dev);
 }
 
-
 #ifdef CONFIG_PM_SLEEP
 static int lis3lv02d_suspend(struct device *dev)
 {
@@ -422,17 +387,16 @@ static const struct dev_pm_ops hp_accel_pm = {
 #endif
 
 /* For the HP MDPS aka 3D Driveguard */
-static struct acpi_driver lis3lv02d_driver = {
-	.name  = DRIVER_NAME,
-	.class = ACPI_MDPS_CLASS,
-	.ids   = lis3lv02d_device_ids,
-	.ops = {
-		.add     = lis3lv02d_add,
-		.remove  = lis3lv02d_remove,
+static struct platform_driver lis3lv02d_driver = {
+	.probe	= lis3lv02d_probe,
+	.remove	= lis3lv02d_remove,
+	.driver	= {
+		.name	= "hp_accel",
+		.pm	= HP_ACCEL_PM,
+		.acpi_match_table = lis3lv02d_device_ids,
 	},
-	.drv.pm = HP_ACCEL_PM,
 };
-module_acpi_driver(lis3lv02d_driver);
+module_platform_driver(lis3lv02d_driver);
 
 MODULE_DESCRIPTION("Glue between LIS3LV02Dx and HP ACPI BIOS and support for disk protection LED.");
 MODULE_AUTHOR("Yan Burman, Eric Piel, Pavel Machek");
-- 
2.32.0

