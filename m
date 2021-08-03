Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 909F63DF615
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 22:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240377AbhHCUIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 16:08:10 -0400
Received: from mga03.intel.com ([134.134.136.65]:14659 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240085AbhHCUII (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 16:08:08 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10065"; a="213803078"
X-IronPort-AV: E=Sophos;i="5.84,292,1620716400"; 
   d="scan'208";a="213803078"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2021 13:07:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,292,1620716400"; 
   d="scan'208";a="479714672"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 03 Aug 2021 13:07:53 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B05EFB9; Tue,  3 Aug 2021 23:08:22 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Eric Piel <eric.piel@tremplin-utc.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>
Subject: [RFT, PATCH v1 1/1] platform/x86: hp_accel: Convert to be a platform driver
Date:   Tue,  3 Aug 2021 23:08:20 +0300
Message-Id: <20210803200820.3259-1-andriy.shevchenko@linux.intel.com>
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

Not sure what buys us to run _INI on PM calls. It's against the spec AFAICT.
In any case ACPICA runs _INI as per specification when devices are
instantiated.

 drivers/platform/x86/hp_accel.c | 74 +++++++--------------------------
 1 file changed, 14 insertions(+), 60 deletions(-)

diff --git a/drivers/platform/x86/hp_accel.c b/drivers/platform/x86/hp_accel.c
index 8c0867bda828..69f86b761c7f 100644
--- a/drivers/platform/x86/hp_accel.c
+++ b/drivers/platform/x86/hp_accel.c
@@ -29,7 +29,6 @@
 #include "../../misc/lis3lv02d/lis3lv02d.h"
 
 #define DRIVER_NAME     "hp_accel"
-#define ACPI_MDPS_CLASS "accelerometer"
 
 /* Delayed LEDs infrastructure ------------------------------------ */
 
@@ -78,7 +77,6 @@ static const struct acpi_device_id lis3lv02d_device_ids[] = {
 };
 MODULE_DEVICE_TABLE(acpi, lis3lv02d_device_ids);
 
-
 /**
  * lis3lv02d_acpi_init - ACPI _INI method: initialize the device.
  * @lis3: pointer to the device struct
@@ -87,14 +85,6 @@ MODULE_DEVICE_TABLE(acpi, lis3lv02d_device_ids);
  */
 static int lis3lv02d_acpi_init(struct lis3lv02d *lis3)
 {
-	struct acpi_device *dev = lis3->bus_priv;
-	if (!lis3->init_required)
-		return 0;
-
-	if (acpi_evaluate_object(dev->handle, METHOD_NAME__INI,
-				 NULL, NULL) != AE_OK)
-		return -EINVAL;
-
 	return 0;
 }
 
@@ -278,30 +268,6 @@ static struct delayed_led_classdev hpled_led = {
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
@@ -331,23 +297,19 @@ static bool hp_accel_i8042_filter(unsigned char data, unsigned char str,
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
@@ -359,7 +321,6 @@ static int lis3lv02d_add(struct acpi_device *device)
 	}
 
 	/* call the core layer do its init */
-	lis3_dev.init_required = true;
 	ret = lis3lv02d_init_device(&lis3_dev);
 	if (ret)
 		return ret;
@@ -381,11 +342,8 @@ static int lis3lv02d_add(struct acpi_device *device)
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
@@ -396,7 +354,6 @@ static int lis3lv02d_remove(struct acpi_device *device)
 	return lis3lv02d_remove_fs(&lis3_dev);
 }
 
-
 #ifdef CONFIG_PM_SLEEP
 static int lis3lv02d_suspend(struct device *dev)
 {
@@ -407,14 +364,12 @@ static int lis3lv02d_suspend(struct device *dev)
 
 static int lis3lv02d_resume(struct device *dev)
 {
-	lis3_dev.init_required = false;
 	lis3lv02d_poweron(&lis3_dev);
 	return 0;
 }
 
 static int lis3lv02d_restore(struct device *dev)
 {
-	lis3_dev.init_required = true;
 	lis3lv02d_poweron(&lis3_dev);
 	return 0;
 }
@@ -434,17 +389,16 @@ static const struct dev_pm_ops hp_accel_pm = {
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
+		.name	= DRIVER_NAME,
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
2.30.2

