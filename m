Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0559A35AE75
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 16:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234734AbhDJOlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 10:41:02 -0400
Received: from ned.t-8ch.de ([212.47.237.191]:54156 "EHLO ned.t-8ch.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234392AbhDJOlB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 10:41:01 -0400
From:   =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1618065634;
        bh=FSn3u/625sVad1IhVodmbe1R5OVkGxcIbmfN8fVeJdg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JydrRQxtH+bnEvAwnz8l5wlMdY52ocm+As1+fZqtbOuo9a2kHoaS0SyjPH2CsA2yb
         Vh2FOwFyGglUpFIenbazqxVJLYl8GLEVCq7B0n59HV+rNIAU73JuAR8zb2PtRN+zCe
         FHC7qgXnAIg8Zn1p8ObF/R7wLUbpFln7B1IHhWsM=
To:     platform-driver-x86@vger.kernel.org,
        Mark Gross <mgross@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Barnab=C3=A1s=20P=C5=91cze?= <pobrn@protonmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Cc:     =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Matthew Garrett <mjg59@srcf.ucam.org>
Subject: [PATCH v3] platform/x86: add Gigabyte WMI temperature driver
Date:   Sat, 10 Apr 2021 16:40:21 +0200
Message-Id: <20210410144021.138035-1-linux@weissschuh.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <117cadef-c1cb-d66a-15f8-ce50d596be4b@redhat.com>
References: <117cadef-c1cb-d66a-15f8-ce50d596be4b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v1:
* Incorporate feedback from Barnabás Pőcze
  * Use a WMI driver instead of a platform driver
  * Let the kernel manage the driver lifecycle
  * Fix errno/ACPI error confusion
  * Fix resource cleanup
  * Document reason for integer casting

Changes since v2:
* Style cleanups
* Test for usability during probing
* DMI-based whitelist
* CC hwmon maintainers

-- >8 --

Tested with a X570 I Aorus Pro Wifi.
The mainboard contains an ITE IT8688E chip for management.
This chips is also handled by drivers/hwmon/i87.c but as it is also used
by the firmware itself it needs an ACPI driver.

Unfortunately not all sensor registers are handled by the firmware and even
less are exposed via WMI.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 MAINTAINERS                         |   6 +
 drivers/platform/x86/Kconfig        |  11 ++
 drivers/platform/x86/Makefile       |   1 +
 drivers/platform/x86/gigabyte-wmi.c | 194 ++++++++++++++++++++++++++++
 4 files changed, 212 insertions(+)
 create mode 100644 drivers/platform/x86/gigabyte-wmi.c

diff --git a/MAINTAINERS b/MAINTAINERS
index d92f85ca831d..9c10cfc00fe8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7543,6 +7543,12 @@ F:	Documentation/filesystems/gfs2*
 F:	fs/gfs2/
 F:	include/uapi/linux/gfs2_ondisk.h
 
+GIGABYTE WMI DRIVER
+M:	Thomas Weißschuh <linux@weissschuh.net>
+L:	platform-driver-x86@vger.kernel.org
+S:	Maintained
+F:	drivers/platform/x86/gigabyte-wmi.c
+
 GNSS SUBSYSTEM
 M:	Johan Hovold <johan@kernel.org>
 S:	Maintained
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index ad4e630e73e2..96622a2106f7 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -123,6 +123,17 @@ config XIAOMI_WMI
 	  To compile this driver as a module, choose M here: the module will
 	  be called xiaomi-wmi.
 
+config GIGABYTE_WMI
+	tristate "Gigabyte WMI temperature driver"
+	depends on ACPI_WMI
+	depends on HWMON
+	help
+	  Say Y here if you want to support WMI-based temperature reporting on
+	  Gigabyte mainboards.
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
index 000000000000..fb4e6d4c1823
--- /dev/null
+++ b/drivers/platform/x86/gigabyte-wmi.c
@@ -0,0 +1,194 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *  Copyright (C) 2021 Thomas Weißschuh <thomas@weissschuh.net>
+ */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/acpi.h>
+#include <linux/dmi.h>
+#include <linux/hwmon.h>
+#include <linux/module.h>
+#include <linux/wmi.h>
+
+#define GIGABYTE_WMI_GUID "DEADBEEF-2001-0000-00A0-C90629100000"
+#define NUM_TEMPERATURE_SENSORS 6
+
+static bool force_load;
+module_param(force_load, bool, 0);
+MODULE_PARM_DESC(force_load, "Force loading on non-whitelisted platform");
+
+enum gigabyte_wmi_commandtype {
+	GIGABYTE_WMI_BUILD_DATE_QUERY       =   0x1,
+	GIGABYTE_WMI_MAINBOARD_TYPE_QUERY   =   0x2,
+	GIGABYTE_WMI_FIRMWARE_VERSION_QUERY =   0x4,
+	GIGABYTE_WMI_MAINBOARD_NAME_QUERY   =   0x5,
+	GIGABYTE_WMI_TEMPERATURE_QUERY      = 0x125,
+};
+
+struct gigabyte_wmi_args {
+	u32 arg1;
+};
+
+static int gigabyte_wmi_perform_query(struct wmi_device *wdev,
+				      enum gigabyte_wmi_commandtype command,
+				      struct gigabyte_wmi_args *args, struct acpi_buffer *out)
+{
+	const struct acpi_buffer in = {
+		.length = sizeof(*args),
+		.pointer = args,
+	};
+
+	acpi_status ret = wmidev_evaluate_method(wdev, 0x0, command, &in, out);
+
+	if ACPI_FAILURE(ret)
+		return -EIO;
+
+	return 0;
+}
+
+static int gigabyte_wmi_query_integer(struct wmi_device *wdev,
+				      enum gigabyte_wmi_commandtype command,
+				      struct gigabyte_wmi_args *args, u64 *res)
+{
+	union acpi_object *obj;
+	struct acpi_buffer result = { ACPI_ALLOCATE_BUFFER, NULL };
+	int ret;
+
+	ret = gigabyte_wmi_perform_query(wdev, command, args, &result);
+	if (ret)
+		return ret;
+	obj = result.pointer;
+	if (obj && obj->type == ACPI_TYPE_INTEGER)
+		*res = obj->integer.value;
+	else
+		ret = -EIO;
+	kfree(result.pointer);
+	return ret;
+}
+
+static int gigabyte_wmi_temperature(struct wmi_device *wdev, u8 sensor, long *res)
+{
+	struct gigabyte_wmi_args args = {
+		.arg1 = sensor,
+	};
+	u64 temp;
+	acpi_status ret;
+
+	ret = gigabyte_wmi_query_integer(wdev, GIGABYTE_WMI_TEMPERATURE_QUERY, &args, &temp);
+	if (ret == 0) {
+		if (temp == 0)
+			return -ENODEV;
+		*res = (s8)temp * 1000; // value is a signed 8-bit integer
+	}
+	return ret;
+}
+
+static int gigabyte_wmi_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
+				   u32 attr, int channel, long *val)
+{
+	struct wmi_device *wdev = dev_get_drvdata(dev);
+
+	return gigabyte_wmi_temperature(wdev, channel, val);
+}
+
+static umode_t gigabyte_wmi_hwmon_is_visible(const void *data, enum hwmon_sensor_types type,
+					     u32 attr, int channel)
+{
+	return 0444;
+}
+
+static const struct hwmon_channel_info *gigabyte_wmi_hwmon_info[] = {
+	HWMON_CHANNEL_INFO(temp,
+			   HWMON_T_INPUT,
+			   HWMON_T_INPUT,
+			   HWMON_T_INPUT,
+			   HWMON_T_INPUT,
+			   HWMON_T_INPUT,
+			   HWMON_T_INPUT),
+	NULL
+};
+
+static const struct hwmon_ops gigabyte_wmi_hwmon_ops = {
+	.read = gigabyte_wmi_hwmon_read,
+	.is_visible = gigabyte_wmi_hwmon_is_visible,
+};
+
+static const struct hwmon_chip_info gigabyte_wmi_hwmon_chip_info = {
+	.ops = &gigabyte_wmi_hwmon_ops,
+	.info = gigabyte_wmi_hwmon_info,
+};
+
+static int gigabyte_wmi_validate_sensor_presence(struct wmi_device *wdev)
+{
+	int working_sensors = 0, i;
+	long temp;
+
+	for (i = 0; i < NUM_TEMPERATURE_SENSORS; i++) {
+		if (!gigabyte_wmi_temperature(wdev, i, &temp))
+			working_sensors++;
+	}
+	return working_sensors ? 0 : -ENODEV;
+}
+
+static const struct dmi_system_id gigabyte_wmi_known_working_platforms[] = {
+	{ .matches = {
+		DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "Gigabyte Technology Co., Ltd."),
+		DMI_EXACT_MATCH(DMI_BOARD_NAME, "B550 GAMING X V2"),
+	}},
+	{ .matches = {
+		DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "Gigabyte Technology Co., Ltd."),
+		DMI_EXACT_MATCH(DMI_BOARD_NAME, "B550M DS3H"),
+	}},
+	{ .matches = {
+		DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "Gigabyte Technology Co., Ltd."),
+		DMI_EXACT_MATCH(DMI_BOARD_NAME, "Z390 I AORUS PRO WIFI-CF"),
+	}},
+	{ .matches = {
+		DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "Gigabyte Technology Co., Ltd."),
+		DMI_EXACT_MATCH(DMI_BOARD_NAME, "X570 I AORUS PRO WIFI"),
+	}},
+	{ }
+};
+
+static int gigabyte_wmi_probe(struct wmi_device *wdev, const void *context)
+{
+	struct device *hwmon_dev;
+	int ret;
+
+	if (!dmi_check_system(gigabyte_wmi_known_working_platforms)) {
+		if (force_load)
+			dev_warn(&wdev->dev, "Forcing loading on non-whitelisted platform");
+		else
+			return -ENODEV;
+	}
+
+	ret = gigabyte_wmi_validate_sensor_presence(wdev);
+	if (ret) {
+		dev_info(&wdev->dev, "No temperature sensors usable");
+		return ret;
+	}
+
+	hwmon_dev = devm_hwmon_device_register_with_info(&wdev->dev, "gigabyte_wmi", wdev,
+							 &gigabyte_wmi_hwmon_chip_info, NULL);
+
+	return PTR_ERR_OR_ZERO(hwmon_dev);
+}
+
+static const struct wmi_device_id gigabyte_wmi_id_table[] = {
+	{ GIGABYTE_WMI_GUID, NULL },
+	{ }
+};
+
+static struct wmi_driver gigabyte_wmi_driver = {
+	.driver = {
+		.name = "gigabyte-wmi",
+	},
+	.id_table = gigabyte_wmi_id_table,
+	.probe = gigabyte_wmi_probe,
+};
+module_wmi_driver(gigabyte_wmi_driver);
+
+MODULE_DEVICE_TABLE(wmi, gigabyte_wmi_id_table);
+MODULE_AUTHOR("Thomas Weißschuh <thomas@weissschuh.net>");
+MODULE_DESCRIPTION("Gigabyte WMI temperature Driver");
+MODULE_LICENSE("GPL");

base-commit: 144c79ef33536b4ecb4951e07dbc1f2b7fa99d32
-- 
2.31.1

