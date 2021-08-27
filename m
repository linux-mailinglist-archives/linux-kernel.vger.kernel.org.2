Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 041183F9611
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 10:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244576AbhH0I0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 04:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244489AbhH0I0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 04:26:40 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD00C061757;
        Fri, 27 Aug 2021 01:25:51 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id u3so12069988ejz.1;
        Fri, 27 Aug 2021 01:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tdkZKxMKiK2h45e6uWzLqY8l56ZZ/jekrcSnqfA07Ko=;
        b=hAKPkG+M7eufcVDamSYIAc1riehdCYD2XSK8WLqwkgL0AzFaKICEEzWsqTf6oCEZFm
         pzJE/z6ulS5st26aOS1/K8AE/QlQyfow0J9P0VirSWJrs5cymMiEgX0ZgKRxp4j4z10C
         AjC0gFvfpbzrIdNqm40STGGGtpycNeN4xWGTPkiFbsino358EXA6yAk6m6M6KeYsBLWJ
         z3n3GIH03WYoW8BuZGHr/+M1pg1n7yx/BpmJ9fis8/KsojaMv9plFzePZy+HPpmmlv98
         xlpexTVtslJvUpSV9IPufDcSihAmyBcLWruRrvcOsZRb/VUhTppd7YNgy3IX7AjmLTWN
         rVgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tdkZKxMKiK2h45e6uWzLqY8l56ZZ/jekrcSnqfA07Ko=;
        b=t/0DfKCfJCWe7YJgDxkbdM/bxsYbfbUMVY1TNZvwFnjhTnzBHiPfodlzwmeAhIFpux
         hLOakzo6OU1CTXgYfcU6xr4qHy2tFiOidi8ChyJoiNI89bNPi8ulOSKO7O/5b90SpbdF
         Eig8mNq77OGRugLCgMKffvYi9n2WTBYiERAWMpjwsxC6TCJFvYlk+OS+CaeQqNSNKZSk
         H9PFmv9vLMiktKFLUIpRcPMBVtdC+s8SwNTaGvVWsnMMDRw5OFulwbdcoll+Vug52OS/
         2ri0n6xG8m/BNqGxwSDN7ISasjCxIAV0N5q9Fy0jeB476x10d3TtS7rlNXa7V2dw8BqF
         WCDw==
X-Gm-Message-State: AOAM530QmhOv/D+Nyex5faBUS9N7EE8rQgHJuOjP3vrl9c1Eh2GluVty
        hylKX9THl0jTr3ZNd70jkcpmtAPBMhE8Jkk+30A=
X-Google-Smtp-Source: ABdhPJwfLKuNTFioiaSA3e0GgsXrQKEe6v06ykjs+9NDqEQfKcut0eUSZ5fvtkHqk+zRwKPUKFn8sQ==
X-Received: by 2002:a17:907:1b1b:: with SMTP id mp27mr8620472ejc.538.1630052749663;
        Fri, 27 Aug 2021 01:25:49 -0700 (PDT)
Received: from fedora.localdomain (cable-178-148-241-131.dynamic.sbb.rs. [178.148.241.131])
        by smtp.googlemail.com with ESMTPSA id c21sm2460426ejz.69.2021.08.27.01.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 01:25:49 -0700 (PDT)
From:   Aleksa Savic <savicaleksa83@gmail.com>
To:     linux-hwmon@vger.kernel.org
Cc:     Aleksa Savic <savicaleksa83@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: add driver for Aquacomputer D5 Next
Date:   Fri, 27 Aug 2021 10:25:05 +0200
Message-Id: <20210827082507.10591-1-savicaleksa83@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver exposes hardware sensors of the Aquacomputer D5 Next
watercooling pump, which communicates through a proprietary USB HID
protocol.

Available sensors are pump and fan speed, power, voltage and current, as
well as coolant temperature. Also available through debugfs are the serial
number, firmware version and power-on count.

Attaching a fan is optional and allows it to be controlled using
temperature curves directly from the pump. If it's not connected,
the fan-related sensors will report zeroes.

The pump can be configured either through software or via its physical
interface. Configuring the pump through this driver is not implemented,
as it seems to require sending it a complete configuration. That
includes addressable RGB LEDs, for which there is no standard sysfs
interface. Thus, that task is better suited for userspace tools.

This driver has been tested on x86_64, both in-kernel and as a module.

Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>
---
 Documentation/hwmon/aquacomputer_d5next.rst |  61 ++++
 Documentation/hwmon/index.rst               |   1 +
 MAINTAINERS                                 |   7 +
 drivers/hwmon/Kconfig                       |  10 +
 drivers/hwmon/Makefile                      |   1 +
 drivers/hwmon/aquacomputer_d5next.c         | 366 ++++++++++++++++++++
 6 files changed, 446 insertions(+)
 create mode 100644 Documentation/hwmon/aquacomputer_d5next.rst
 create mode 100644 drivers/hwmon/aquacomputer_d5next.c

diff --git a/Documentation/hwmon/aquacomputer_d5next.rst b/Documentation/hwmon/aquacomputer_d5next.rst
new file mode 100644
index 000000000000..1f4bb4ba2e4b
--- /dev/null
+++ b/Documentation/hwmon/aquacomputer_d5next.rst
@@ -0,0 +1,61 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Kernel driver aquacomputer-d5next
+=================================
+
+Supported devices:
+
+* Aquacomputer D5 Next watercooling pump
+
+Author: Aleksa Savic
+
+Description
+-----------
+
+This driver exposes hardware sensors of the Aquacomputer D5 Next watercooling
+pump, which communicates through a proprietary USB HID protocol.
+
+Available sensors are pump and fan speed, power, voltage and current, as
+well as coolant temperature. Also available through debugfs are the serial
+number, firmware version and power-on count.
+
+Attaching a fan is optional and allows it to be controlled using temperature
+curves directly from the pump. If it's not connected, the fan-related sensors
+will report zeroes.
+
+The pump can be configured either through software or via its physical
+interface. Configuring the pump through this driver is not implemented, as it
+seems to require sending it a complete configuration. That includes addressable
+RGB LEDs, for which there is no standard sysfs interface. Thus, that task is
+better suited for userspace tools.
+
+Usage notes
+-----------
+
+The pump communicates via HID reports. The driver is loaded automatically by
+the kernel and supports hotswapping.
+
+Sysfs entries
+-------------
+
+============ =============================================
+temp1_input  Coolant temperature (in millidegrees Celsius)
+fan1_input   Pump speed (in RPM)
+fan2_input   Fan speed (in RPM)
+power1_input Pump power (in micro Watts)
+power2_input Fan power (in micro Watts)
+in0_input    Pump voltage (in milli Volts)
+in1_input    Fan voltage (in milli Volts)
+in2_input    +5V rail voltage (in milli Volts)
+curr1_input  Pump current (in milli Amperes)
+curr2_input  Fan current (in milli Amperes)
+============ =============================================
+
+Debugfs entries
+---------------
+
+================ ===============================================
+serial_number    Serial number of the pump
+firmware_version Version of installed firmware
+power_cycles     Count of how many times the pump was powered on
+================ ===============================================
diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
index bc01601ea81a..77bfb2e2e8a9 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -39,6 +39,7 @@ Hardware Monitoring Kernel Drivers
    adt7475
    aht10
    amc6821
+   aquacomputer_d5next
    asb100
    asc7621
    aspeed-pwm-tacho
diff --git a/MAINTAINERS b/MAINTAINERS
index d7b4f32875a9..ec0aa0dcf635 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1316,6 +1316,13 @@ L:	linux-media@vger.kernel.org
 S:	Maintained
 F:	drivers/media/i2c/aptina-pll.*
 
+AQUACOMPUTER D5 NEXT PUMP SENSOR DRIVER
+M:	Aleksa Savic <savicaleksa83@gmail.com>
+L:	linux-hwmon@vger.kernel.org
+S:	Maintained
+F:	Documentation/hwmon/aquacomputer_d5next.rst
+F:	drivers/hwmon/aquacomputer_d5next.c
+
 AQUANTIA ETHERNET DRIVER (atlantic)
 M:	Igor Russkikh <irusskikh@marvell.com>
 L:	netdev@vger.kernel.org
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index e3675377bc5d..2bd563850f87 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -254,6 +254,16 @@ config SENSORS_AHT10
 	  This driver can also be built as a module. If so, the module
 	  will be called aht10.
 
+config SENSORS_AQUACOMPUTER_D5NEXT
+	tristate "Aquacomputer D5 Next watercooling pump"
+	depends on USB_HID
+	help
+	  If you say yes here you get support for the Aquacomputer D5 Next
+	  watercooling pump sensors.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called aquacomputer_d5next.
+
 config SENSORS_AS370
 	tristate "Synaptics AS370 SoC hardware monitoring driver"
 	help
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index d712c61c1f5e..790a611a3188 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -47,6 +47,7 @@ obj-$(CONFIG_SENSORS_ADT7475)	+= adt7475.o
 obj-$(CONFIG_SENSORS_AHT10)	+= aht10.o
 obj-$(CONFIG_SENSORS_AMD_ENERGY) += amd_energy.o
 obj-$(CONFIG_SENSORS_APPLESMC)	+= applesmc.o
+obj-$(CONFIG_SENSORS_AQUACOMPUTER_D5NEXT) += aquacomputer_d5next.o
 obj-$(CONFIG_SENSORS_ARM_SCMI)	+= scmi-hwmon.o
 obj-$(CONFIG_SENSORS_ARM_SCPI)	+= scpi-hwmon.o
 obj-$(CONFIG_SENSORS_AS370)	+= as370-hwmon.o
diff --git a/drivers/hwmon/aquacomputer_d5next.c b/drivers/hwmon/aquacomputer_d5next.c
new file mode 100644
index 000000000000..0f831b0eb94c
--- /dev/null
+++ b/drivers/hwmon/aquacomputer_d5next.c
@@ -0,0 +1,366 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * hwmon driver for Aquacomputer D5 Next watercooling pump
+ *
+ * The D5 Next sends HID reports (with ID 0x01) every second to report sensor values
+ * (coolant temperature, pump and fan speed, voltage, current and power). It responds to
+ * Get_Report requests, but returns a dummy value of no use.
+ *
+ * Copyright 2021 Aleksa Savic <savicaleksa83@gmail.com>
+ */
+
+#include <asm/unaligned.h>
+#include <linux/debugfs.h>
+#include <linux/hid.h>
+#include <linux/hwmon.h>
+#include <linux/jiffies.h>
+#include <linux/module.h>
+
+#define DRIVER_NAME		      "aquacomputer-d5next"
+
+#define D5NEXT_STATUS_REPORT_ID	      0x01
+#define D5NEXT_STATUS_UPDATE_INTERVAL 1 /* In seconds */
+
+/* Register offsets for the D5 Next pump */
+
+#define D5NEXT_SERIAL_FIRST_PART      3
+#define D5NEXT_SERIAL_SECOND_PART     5
+#define D5NEXT_FIRMWARE_VERSION	      13
+#define D5NEXT_POWER_CYCLES	      24
+
+#define D5NEXT_COOLANT_TEMP	      87
+
+#define D5NEXT_PUMP_SPEED	      116
+#define D5NEXT_FAN_SPEED	      103
+
+#define D5NEXT_PUMP_POWER	      114
+#define D5NEXT_FAN_POWER	      101
+
+#define D5NEXT_PUMP_VOLTAGE	      110
+#define D5NEXT_FAN_VOLTAGE	      97
+#define D5NEXT_5V_VOLTAGE	      57
+
+#define D5NEXT_PUMP_CURRENT	      112
+#define D5NEXT_FAN_CURRENT	      99
+
+/* Labels for provided values */
+
+#define L_COOLANT_TEMP		      "Coolant temp"
+
+#define L_PUMP_SPEED		      "Pump speed"
+#define L_FAN_SPEED		      "Fan speed"
+
+#define L_PUMP_POWER		      "Pump power"
+#define L_FAN_POWER		      "Fan power"
+
+#define L_PUMP_VOLTAGE		      "Pump voltage"
+#define L_FAN_VOLTAGE		      "Fan voltage"
+#define L_5V_VOLTAGE		      "+5V voltage"
+
+#define L_PUMP_CURRENT		      "Pump current"
+#define L_FAN_CURRENT		      "Fan current"
+
+static const char *const label_temp[] = {
+	L_COOLANT_TEMP,
+};
+
+static const char *const label_speeds[] = {
+	L_PUMP_SPEED,
+	L_FAN_SPEED,
+};
+
+static const char *const label_power[] = {
+	L_PUMP_POWER,
+	L_FAN_POWER,
+};
+
+static const char *const label_voltages[] = {
+	L_PUMP_VOLTAGE,
+	L_FAN_VOLTAGE,
+	L_5V_VOLTAGE,
+};
+
+static const char *const label_current[] = {
+	L_PUMP_CURRENT,
+	L_FAN_CURRENT,
+};
+
+struct d5next_data {
+	struct hid_device *hdev;
+	struct device *hwmon_dev;
+	struct dentry *debugfs;
+	s32 temp_input[1];
+	u16 speed_input[2];
+	u32 power_input[2];
+	u16 voltage_input[3];
+	u16 current_input[2];
+	u32 serial_number[2];
+	u16 firmware_version;
+	u32 power_cycles; /* How many times the device was powered on */
+	unsigned long updated;
+};
+
+static umode_t d5next_is_visible(const void *data, enum hwmon_sensor_types type, u32 attr,
+				 int channel)
+{
+	return 0444;
+}
+
+static int d5next_read(struct device *dev, enum hwmon_sensor_types type, u32 attr, int channel,
+		       long *val)
+{
+	struct d5next_data *priv = dev_get_drvdata(dev);
+
+	if (time_after(jiffies, priv->updated + D5NEXT_STATUS_UPDATE_INTERVAL * HZ))
+		return -ENODATA;
+
+	switch (type) {
+	case hwmon_temp:
+		*val = priv->temp_input[channel];
+		break;
+	case hwmon_fan:
+		*val = priv->speed_input[channel];
+		break;
+	case hwmon_power:
+		*val = priv->power_input[channel];
+		break;
+	case hwmon_in:
+		*val = priv->voltage_input[channel];
+		break;
+	case hwmon_curr:
+		*val = priv->current_input[channel];
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static int d5next_read_string(struct device *dev, enum hwmon_sensor_types type, u32 attr,
+			      int channel, const char **str)
+{
+	switch (type) {
+	case hwmon_temp:
+		*str = label_temp[channel];
+		break;
+	case hwmon_fan:
+		*str = label_speeds[channel];
+		break;
+	case hwmon_power:
+		*str = label_power[channel];
+		break;
+	case hwmon_in:
+		*str = label_voltages[channel];
+		break;
+	case hwmon_curr:
+		*str = label_current[channel];
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static const struct hwmon_ops d5next_hwmon_ops = {
+	.is_visible = d5next_is_visible,
+	.read = d5next_read,
+	.read_string = d5next_read_string,
+};
+
+static const struct hwmon_channel_info *d5next_info[] = {
+	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT | HWMON_T_LABEL),
+	HWMON_CHANNEL_INFO(fan, HWMON_F_INPUT | HWMON_F_LABEL, HWMON_F_INPUT | HWMON_F_LABEL),
+	HWMON_CHANNEL_INFO(power, HWMON_P_INPUT | HWMON_P_LABEL, HWMON_P_INPUT | HWMON_P_LABEL),
+	HWMON_CHANNEL_INFO(in, HWMON_I_INPUT | HWMON_I_LABEL, HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL),
+	HWMON_CHANNEL_INFO(curr, HWMON_C_INPUT | HWMON_C_LABEL, HWMON_C_INPUT | HWMON_C_LABEL),
+	NULL
+};
+
+static const struct hwmon_chip_info d5next_chip_info = {
+	.ops = &d5next_hwmon_ops,
+	.info = d5next_info,
+};
+
+static int d5next_raw_event(struct hid_device *hdev, struct hid_report *report, u8 *data, int size)
+{
+	struct d5next_data *priv;
+
+	if (report->id != D5NEXT_STATUS_REPORT_ID)
+		return 0;
+
+	priv = hid_get_drvdata(hdev);
+
+	/* Info provided with every report */
+
+	priv->serial_number[0] = get_unaligned_be16(data + D5NEXT_SERIAL_FIRST_PART);
+	priv->serial_number[1] = get_unaligned_be16(data + D5NEXT_SERIAL_SECOND_PART);
+
+	priv->firmware_version = get_unaligned_be16(data + D5NEXT_FIRMWARE_VERSION);
+	priv->power_cycles = get_unaligned_be32(data + D5NEXT_POWER_CYCLES);
+
+	/* Sensor readings */
+
+	priv->temp_input[0] = get_unaligned_be16(data + D5NEXT_COOLANT_TEMP) * 10;
+
+	priv->speed_input[0] = get_unaligned_be16(data + D5NEXT_PUMP_SPEED);
+	priv->speed_input[1] = get_unaligned_be16(data + D5NEXT_FAN_SPEED);
+
+	priv->power_input[0] = get_unaligned_be16(data + D5NEXT_PUMP_POWER) * 10000;
+	priv->power_input[1] = get_unaligned_be16(data + D5NEXT_FAN_POWER) * 10000;
+
+	priv->voltage_input[0] = get_unaligned_be16(data + D5NEXT_PUMP_VOLTAGE) * 10;
+	priv->voltage_input[1] = get_unaligned_be16(data + D5NEXT_FAN_VOLTAGE) * 10;
+	priv->voltage_input[2] = get_unaligned_be16(data + D5NEXT_5V_VOLTAGE) * 10;
+
+	priv->current_input[0] = get_unaligned_be16(data + D5NEXT_PUMP_CURRENT);
+	priv->current_input[1] = get_unaligned_be16(data + D5NEXT_FAN_CURRENT);
+
+	priv->updated = jiffies;
+
+	return 0;
+}
+
+#ifdef CONFIG_DEBUG_FS
+
+static int serial_number_show(struct seq_file *seqf, void *unused)
+{
+	struct d5next_data *priv = seqf->private;
+
+	seq_printf(seqf, "%05u-%05u\n", priv->serial_number[0], priv->serial_number[1]);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(serial_number);
+
+static int firmware_version_show(struct seq_file *seqf, void *unused)
+{
+	struct d5next_data *priv = seqf->private;
+
+	seq_printf(seqf, "%u\n", priv->firmware_version);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(firmware_version);
+
+static int power_cycles_show(struct seq_file *seqf, void *unused)
+{
+	struct d5next_data *priv = seqf->private;
+
+	seq_printf(seqf, "%u\n", priv->power_cycles);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(power_cycles);
+
+static void d5next_debugfs_init(struct d5next_data *priv)
+{
+	char name[32];
+
+	scnprintf(name, sizeof(name), "%s-%s", DRIVER_NAME, dev_name(&priv->hdev->dev));
+
+	priv->debugfs = debugfs_create_dir(name, NULL);
+	debugfs_create_file("serial_number", 0444, priv->debugfs, priv, &serial_number_fops);
+	debugfs_create_file("firmware_version", 0444, priv->debugfs, priv, &firmware_version_fops);
+	debugfs_create_file("power_cycles", 0444, priv->debugfs, priv, &power_cycles_fops);
+}
+
+#else
+
+static void d5next_debugfs_init(struct d5next_data *priv)
+{
+}
+
+#endif
+
+static int d5next_probe(struct hid_device *hdev, const struct hid_device_id *id)
+{
+	struct d5next_data *priv;
+	int ret;
+
+	priv = devm_kzalloc(&hdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->hdev = hdev;
+	hid_set_drvdata(hdev, priv);
+
+	priv->updated = jiffies - D5NEXT_STATUS_UPDATE_INTERVAL * HZ;
+
+	ret = hid_parse(hdev);
+	if (ret)
+		return ret;
+
+	ret = hid_hw_start(hdev, HID_CONNECT_HIDRAW);
+	if (ret)
+		return ret;
+
+	ret = hid_hw_open(hdev);
+	if (ret)
+		goto fail_and_stop;
+
+	priv->hwmon_dev = hwmon_device_register_with_info(&hdev->dev, "d5next", priv,
+							  &d5next_chip_info, NULL);
+
+	if (IS_ERR(priv->hwmon_dev)) {
+		ret = PTR_ERR(priv->hwmon_dev);
+		goto fail_and_close;
+	}
+
+	d5next_debugfs_init(priv);
+
+	return 0;
+
+fail_and_close:
+	hid_hw_close(hdev);
+fail_and_stop:
+	hid_hw_stop(hdev);
+	return ret;
+}
+
+static void d5next_remove(struct hid_device *hdev)
+{
+	struct d5next_data *priv = hid_get_drvdata(hdev);
+
+	debugfs_remove_recursive(priv->debugfs);
+	hwmon_device_unregister(priv->hwmon_dev);
+
+	hid_hw_close(hdev);
+	hid_hw_stop(hdev);
+}
+
+static const struct hid_device_id d5next_table[] = {
+	{ HID_USB_DEVICE(0x0c70, 0xf00e) }, /* Aquacomputer D5 Next */
+	{},
+};
+
+MODULE_DEVICE_TABLE(hid, d5next_table);
+
+static struct hid_driver d5next_driver = {
+	.name = DRIVER_NAME,
+	.id_table = d5next_table,
+	.probe = d5next_probe,
+	.remove = d5next_remove,
+	.raw_event = d5next_raw_event,
+};
+
+static int __init d5next_init(void)
+{
+	return hid_register_driver(&d5next_driver);
+}
+
+static void __exit d5next_exit(void)
+{
+	hid_unregister_driver(&d5next_driver);
+}
+
+/* Request to initialize after the HID bus to ensure it's not being loaded before */
+
+late_initcall(d5next_init);
+module_exit(d5next_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Aleksa Savic <savicaleksa83@gmail.com>");
+MODULE_DESCRIPTION("Hwmon driver for Aquacomputer D5 Next pump");
-- 
2.31.1

