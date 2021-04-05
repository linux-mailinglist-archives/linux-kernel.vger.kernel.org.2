Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAACD354259
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 15:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236870AbhDEN0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 09:26:13 -0400
Received: from ned.t-8ch.de ([212.47.237.191]:60690 "EHLO ned.t-8ch.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232694AbhDEN0L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 09:26:11 -0400
X-Greylist: delayed 332 seconds by postgrey-1.27 at vger.kernel.org; Mon, 05 Apr 2021 09:26:10 EDT
From:   =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1617628822;
        bh=fuXZ8WNgMxgp8Za4Y5VnwWcY6jKNaTmWRbdm6/uLT10=;
        h=From:To:Cc:Subject:Date:From;
        b=YamXojY7xrZkEVeNPJgRQYUaZAu5GQHnj8pMx1v9i2F2ZRZEWBDRjanoRY9KrcMxc
         uyMqMZNdtrp+UM/OOp2a4m/miOdwB9m1cKymRQyq3qE9DU9+yeXGLRfdnKNJnGSdSM
         ZrBo7CEZuNMM4n6z3FFtS+b/U4NClrHlgE5j290g=
To:     platform-driver-x86@vger.kernel.org,
        Mark Gross <mgross@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Matthew Garrett <mjg59@srcf.ucam.org>
Subject: [PATCH] platform/x86: add Gigabyte WMI temperature driver
Date:   Mon,  5 Apr 2021 15:20:07 +0200
Message-Id: <20210405132007.290275-1-linux@weissschuh.net>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this patch adds support for temperature readings on Gigabyte Mainboards.
(At least on mine)

The current code should be usable as is.
I'd like for people to test it though and report their results with different
hardware.

Further development I have some general questions:

The ASL IndexField does not cover all relevant registers, can it be extended by
driver code?

* Not all registers are exposed via ACPI methods, can they be accessed via ACPI directly?
* Some registers are exposed via ACPI methods but are not reachable directly from the WMI dispatcher.
  * Does ASL have some sort of reflection that could enable those methods?
  * Is it possible to call those methods directly, bypassing WMI?

I suspect the answer to be "no" for all of these, but maybe I am wrong.

Furthermore there are WMI methods to return information about the installed
firmware.

* Version
* Build-date
* Motherboard name

Would it make sense to add this information as attributes to the
platform_device?

The ACPI tables can be found here:
https://github.com/t-8ch/linux-gigabyte-wmi-driver/blob/main/ssdt8.dsl

Thanks,
Thomas

-- >8 --

Tested with a X570 I Aorus Pro Wifi.
The mainboard contains a ITE IT8688E chip for management.
This chips is also handled by drivers/hwmon/i87.c but as it is also used
by the firmware itself it needs an ACPI driver.

Unfortunately not all sensor registers are handled by the firmware and even
less are exposed via WMI.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/platform/x86/Kconfig        |  10 ++
 drivers/platform/x86/Makefile       |   1 +
 drivers/platform/x86/gigabyte-wmi.c | 178 ++++++++++++++++++++++++++++
 3 files changed, 189 insertions(+)
 create mode 100644 drivers/platform/x86/gigabyte-wmi.c

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index ad4e630e73e2..40d593ff1f01 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -123,6 +123,16 @@ config XIAOMI_WMI
 	  To compile this driver as a module, choose M here: the module will
 	  be called xiaomi-wmi.
 
+config GIGABYTE_WMI
+	tristate "Gigabyte WMI temperature driver"
+	depends on ACPI_WMI
+	depends on HWMON
+	help
+	  Say Y here if you want to support WMI-based temperature on Gigabyte mainboards.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called gigabyte-wmi.
+
 config ACERHDF
 	tristate "Acer Aspire One temperature and fan driver"
 	depends on ACPI && THERMAL
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 60d554073749..1621ebfd04fd 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_INTEL_WMI_THUNDERBOLT)	+= intel-wmi-thunderbolt.o
 obj-$(CONFIG_MXM_WMI)			+= mxm-wmi.o
 obj-$(CONFIG_PEAQ_WMI)			+= peaq-wmi.o
 obj-$(CONFIG_XIAOMI_WMI)		+= xiaomi-wmi.o
+obj-$(CONFIG_GIGABYTE_WMI)		+= gigabyte-wmi.o
 
 # Acer
 obj-$(CONFIG_ACERHDF)		+= acerhdf.o
diff --git a/drivers/platform/x86/gigabyte-wmi.c b/drivers/platform/x86/gigabyte-wmi.c
new file mode 100644
index 000000000000..a3749cf248cb
--- /dev/null
+++ b/drivers/platform/x86/gigabyte-wmi.c
@@ -0,0 +1,178 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Gigabyte WMI temperature driver
+ *
+ * Copyright (C) 2021 Thomas Weißschuh <linux@weissschuh.net>
+ */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/acpi.h>
+#include <linux/platform_device.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+
+#define GIGABYTE_WMI_GUID "DEADBEEF-2001-0000-00A0-C90629100000"
+#define DRVNAME "gigabyte-wmi"
+
+MODULE_AUTHOR("Thomas Weißschuh <thomas@weissschuh.net>");
+MODULE_DESCRIPTION("Gigabyte Generic WMI Driver");
+MODULE_LICENSE("GPL");
+
+MODULE_ALIAS("wmi:" GIGABYTE_WMI_GUID);
+
+enum gigabyte_wmi_commandtype {
+	GIGABYTE_WMI_BUILD_DATE_QUERY       =   0x1,
+	GIGABYTE_WMI_MAINBOARD_TYPE_QUERY   =   0x2,
+	GIGABYTE_WMI_FIRMWARE_VERSION_QUERY =   0x4,
+	GIGABYTE_WMI_MAINBOARD_NAME_QUERY   =   0x5,
+	GIGABYTE_WMI_TEMPERATURE_QUERY      = 0x125,
+};
+
+static int gigabyte_wmi_temperature(u8 sensor, s8 *res);
+
+static ssize_t temp_show(struct device *dev, struct device_attribute *attr,
+			 char *buf)
+{
+	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
+	int index = sattr->index;
+	s8 temp;
+	acpi_status res;
+
+	res = gigabyte_wmi_temperature(index, &temp);
+	if (ACPI_FAILURE(res))
+		return -res;
+
+	return sprintf(buf, "%d\n", temp * 1000);
+}
+
+static SENSOR_DEVICE_ATTR_2_RO(temp1_input, temp, 0, 0);
+static SENSOR_DEVICE_ATTR_2_RO(temp2_input, temp, 0, 1);
+static SENSOR_DEVICE_ATTR_2_RO(temp3_input, temp, 0, 2);
+static SENSOR_DEVICE_ATTR_2_RO(temp4_input, temp, 0, 3);
+static SENSOR_DEVICE_ATTR_2_RO(temp5_input, temp, 0, 4);
+static SENSOR_DEVICE_ATTR_2_RO(temp6_input, temp, 0, 5);
+
+static struct platform_device *gigabyte_wmi_pdev;
+
+
+static struct attribute *gigabyte_wmi_hwmon_attributes_temp[] = {
+	&sensor_dev_attr_temp1_input.dev_attr.attr,
+	&sensor_dev_attr_temp2_input.dev_attr.attr,
+	&sensor_dev_attr_temp3_input.dev_attr.attr,
+	&sensor_dev_attr_temp4_input.dev_attr.attr,
+	&sensor_dev_attr_temp5_input.dev_attr.attr,
+	&sensor_dev_attr_temp6_input.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group gigabyte_wmi_hwmon_group_temp = {
+	.attrs = gigabyte_wmi_hwmon_attributes_temp,
+};
+
+static const struct attribute_group *gigabyte_wmi_hwmon_groups[] = {
+	&gigabyte_wmi_hwmon_group_temp,
+	NULL,
+};
+
+static int gigabyte_wmi_probe(struct platform_device *pdev)
+{
+	struct device *hwmon_dev;
+	struct device *dev = &pdev->dev;
+
+	if (!wmi_has_guid(GIGABYTE_WMI_GUID))
+		return -ENODEV;
+	gigabyte_wmi_pdev = pdev;
+
+	hwmon_dev = devm_hwmon_device_register_with_groups(dev,
+					"gigabyte_wmi",
+					NULL, gigabyte_wmi_hwmon_groups);
+	return PTR_ERR_OR_ZERO(hwmon_dev);
+}
+
+static struct platform_driver gigabyte_wmi_driver = {
+	.driver = {
+		.name	= DRVNAME,
+	},
+	.probe	= gigabyte_wmi_probe,
+};
+
+struct args {
+	u32 arg1;
+	u32 arg2;
+	u32 arg3;
+};
+
+static acpi_status gigabyte_wmi_perform_query(
+		enum gigabyte_wmi_commandtype command, struct args *args, struct acpi_buffer *out)
+{
+	struct acpi_buffer in = {};
+
+	if (!args) {
+		struct args empty_args = {};
+
+		args = &empty_args;
+	}
+	in.length = sizeof(*args);
+	in.pointer = args;
+	return wmi_evaluate_method(GIGABYTE_WMI_GUID, 0x0, command, &in, out);
+}
+
+static int gigabyte_wmi_query_integer(
+		enum gigabyte_wmi_commandtype command, struct args *args, u64 *res)
+{
+	union acpi_object *obj;
+	struct acpi_buffer result = { ACPI_ALLOCATE_BUFFER, NULL };
+	acpi_status ret;
+
+	ret = gigabyte_wmi_perform_query(command, args, &result);
+	if (ACPI_FAILURE(ret))
+		return -ENXIO;
+	obj = result.pointer;
+	if (!obj || obj->type != ACPI_TYPE_INTEGER) {
+		pr_warn("Unexpected result type %d for command %d", obj->type, command);
+		return -ENXIO;
+	}
+	*res = obj->integer.value;
+	return AE_OK;
+}
+
+static int gigabyte_wmi_temperature(u8 sensor, s8 *res)
+{
+	struct args args = {
+		.arg1 = sensor,
+	};
+	u64 temp;
+	acpi_status ret;
+
+	ret = gigabyte_wmi_query_integer(GIGABYTE_WMI_TEMPERATURE_QUERY, &args, &temp);
+	if (ret == 0)
+		*res = (s8) temp;
+	return ret;
+}
+
+static int __init gigabyte_wmi_init(void)
+{
+	struct platform_device *pdev;
+	int err;
+
+	err = platform_driver_register(&gigabyte_wmi_driver);
+	if (err)
+		return err;
+	pdev = platform_device_alloc(DRVNAME, -1);
+	if (!pdev) {
+		platform_driver_unregister(&gigabyte_wmi_driver);
+		return -ENOMEM;
+	}
+	return platform_device_add(pdev);
+}
+module_init(gigabyte_wmi_init);
+
+static void __exit gigabyte_wmi_exit(void)
+{
+	platform_device_unregister(gigabyte_wmi_pdev);
+	platform_driver_unregister(&gigabyte_wmi_driver);
+}
+module_exit(gigabyte_wmi_exit);

base-commit: 144c79ef33536b4ecb4951e07dbc1f2b7fa99d32
-- 
2.31.1

