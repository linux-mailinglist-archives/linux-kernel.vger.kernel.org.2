Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3206E3056D8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 10:25:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235188AbhA0JZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 04:25:12 -0500
Received: from smtp.outgoing.loopia.se ([93.188.3.37]:58417 "EHLO
        smtp.outgoing.loopia.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbhA0JFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 04:05:39 -0500
Received: from s807.loopia.se (localhost [127.0.0.1])
        by s807.loopia.se (Postfix) with ESMTP id 788A624694E2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 09:42:43 +0100 (CET)
Received: from s500.loopia.se (unknown [172.22.191.5])
        by s807.loopia.se (Postfix) with ESMTP id 57CC32E29A02;
        Wed, 27 Jan 2021 09:42:43 +0100 (CET)
Received: from s474.loopia.se (unknown [172.22.191.6])
        by s500.loopia.se (Postfix) with ESMTP id 42C9E1E32E90;
        Wed, 27 Jan 2021 09:42:43 +0100 (CET)
X-Virus-Scanned: amavisd-new at amavis.loopia.se
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-999 required=6.2
        tests=[ALL_TRUSTED=-1] autolearn=disabled
Received: from s500.loopia.se ([172.22.191.6])
        by s474.loopia.se (s474.loopia.se [172.22.190.14]) (amavisd-new, port 10024)
        with LMTP id QkIGDK_0Ygsc; Wed, 27 Jan 2021 09:42:42 +0100 (CET)
X-Loopia-Auth: user
X-Loopia-User: carl@hgsystem.se
X-Loopia-Originating-IP: 94.234.44.220
Received: from localhost.localdomain (unknown [94.234.44.220])
        (Authenticated sender: carl@hgsystem.se)
        by s500.loopia.se (Postfix) with ESMTPSA id D13251E32EB5;
        Wed, 27 Jan 2021 09:42:41 +0100 (CET)
From:   Erik Rosen <erik.rosen@metormote.com>
To:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-hwmon@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Cc:     Erik Rosen <erik.rosen@metormote.com>
Subject: [PATCH 1/1] Add ST STPDDC60 pmbus driver
Date:   Wed, 27 Jan 2021 09:41:40 +0100
Message-Id: <20210127084140.35626-2-erik.rosen@metormote.com>
X-Mailer: git-send-email 2.11.0 (Apple Git-81)
In-Reply-To: <20210127084140.35626-1-erik.rosen@metormote.com>
References: <20210127084140.35626-1-erik.rosen@metormote.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ST STPDDC60 pmbus client driver.

Signed-off-by: Erik Rosen <erik.rosen@metormote.com>
---
 Documentation/hwmon/index.rst    |   1 +
 Documentation/hwmon/stpddc60.rst |  79 +++++++++++++
 MAINTAINERS                      |   7 ++
 drivers/hwmon/pmbus/Kconfig      |  10 ++
 drivers/hwmon/pmbus/Makefile     |   2 +
 drivers/hwmon/pmbus/stpddc60.c   | 188 +++++++++++++++++++++++++++++++
 6 files changed, 287 insertions(+)
 create mode 100644 Documentation/hwmon/stpddc60.rst
 create mode 100644 drivers/hwmon/pmbus/stpddc60.c

diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
index fcb870ce6286..94b4fcf182cd 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -169,6 +169,7 @@ Hardware Monitoring Kernel Drivers
    smsc47m192
    smsc47m1
    sparx5-temp
+   stpddc60
    tc654
    tc74
    thmc50
diff --git a/Documentation/hwmon/stpddc60.rst b/Documentation/hwmon/stpddc60.rst
new file mode 100644
index 000000000000..11d5a9977e80
--- /dev/null
+++ b/Documentation/hwmon/stpddc60.rst
@@ -0,0 +1,79 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Kernel driver stpddc60
+======================
+
+Supported chips:
+
+  * ST STPDDC60
+
+    Prefix: 'stpddc60', 'bmr481'
+
+    Addresses scanned: -
+
+    Datasheet: https://flexpowermodules.com/documents/fpm-techspec-bmr481
+
+Author: Erik Rosen <erik.rosen@metormote.com>
+
+
+Description
+-----------
+
+This driver supports hardware monitoring for ST STPDDC60 controller chip and
+compatible modules.
+
+The driver is a client driver to the core PMBus driver. Please see
+Documentation/hwmon/pmbus.rst and Documentation.hwmon/pmbus-core for details
+on PMBus client drivers.
+
+
+Usage Notes
+-----------
+
+This driver does not auto-detect devices. You will have to instantiate the
+devices explicitly. Please see Documentation/i2c/instantiating-devices.rst for
+details.
+
+The vout under- and over-voltage limits are read-only for this chip.
+
+
+Platform data support
+---------------------
+
+The driver supports standard PMBus driver platform data.
+
+
+Sysfs entries
+-------------
+
+The following attributes are supported. Vin, iout and temp limits
+are read-write; all other attributes are read-only.
+
+======================= ========================================================
+in1_label		"vin"
+in1_input		Measured input voltage.
+in1_lcrit		Critical minimum input voltage.
+in1_crit		Critical maximum input voltage.
+in1_lcrit_alarm		Input voltage critical low alarm.
+in1_crit_alarm		Input voltage critical high alarm.
+
+in2_label		"vout1"
+in2_input		Measured output voltage.
+in2_lcrit		Critical minimum output Voltage.
+in2_crit		Critical maximum output voltage.
+in2_lcrit_alarm		Critical output voltage critical low alarm.
+in2_crit_alarm		Critical output voltage critical high alarm.
+
+curr1_label		"iout1"
+curr1_input		Measured output current.
+curr1_max		Maximum output current.
+curr1_max_alarm		Output current high alarm.
+curr1_crit		Critical maximum output current.
+curr1_crit_alarm	Output current critical high alarm.
+
+temp1_input		Measured maximum temperature of all phases.
+temp1_max		Maximum temperature limit.
+temp1_max_alarm		High temperature alarm.
+temp1_crit		Critical maximum temperature limit.
+temp1_crit_alarm	Critical maximum temperature alarm.
+======================= ========================================================
diff --git a/MAINTAINERS b/MAINTAINERS
index 992fe3b0900a..e4c696f8eabe 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16819,6 +16819,13 @@ L:	linux-i2c@vger.kernel.org
 S:	Maintained
 F:	drivers/i2c/busses/i2c-stm32*
 
+ST STPDDC60 DRIVER
+M:	Daniel Nilsson <daniel.nilsson@flex.com>
+L:	linux-hwmon@vger.kernel.org
+S:	Maintained
+F:	Documentation/hwmon/stpddc60.rst
+F:	drivers/hwmon/pmbus/stpddc60.c
+
 ST VL53L0X ToF RANGER(I2C) IIO DRIVER
 M:	Song Qiang <songqiang1304521@gmail.com>
 L:	linux-iio@vger.kernel.org
diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
index 03606d4298a4..b2becdd84b11 100644
--- a/drivers/hwmon/pmbus/Kconfig
+++ b/drivers/hwmon/pmbus/Kconfig
@@ -247,6 +247,16 @@ config SENSORS_Q54SJ108A2
 	  This driver can also be built as a module. If so, the module will
 	  be called q54sj108a2.
 
+config SENSORS_STPDDC60
+	tristate "ST STPDDC60"
+	help
+	  If you say yes here you get hardware monitoring support for ST
+	  STPDDC60 Universal Digital Multicell Controller, as well as for
+	  Flex BMR481.
+
+	  This driver can also be built as a module. If so, the module will
+	  be called stpddc60.
+
 config SENSORS_TPS40422
 	tristate "TI TPS40422"
 	help
diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
index 6a4ba0fdc1db..ef468806238c 100644
--- a/drivers/hwmon/pmbus/Makefile
+++ b/drivers/hwmon/pmbus/Makefile
@@ -28,9 +28,11 @@ obj-$(CONFIG_SENSORS_MP2975)	+= mp2975.o
 obj-$(CONFIG_SENSORS_PM6764TR)	+= pm6764tr.o
 obj-$(CONFIG_SENSORS_PXE1610)	+= pxe1610.o
 obj-$(CONFIG_SENSORS_Q54SJ108A2)	+= q54sj108a2.o
+obj-$(CONFIG_SENSORS_STPDDC60)	+= stpddc60.o
 obj-$(CONFIG_SENSORS_TPS40422)	+= tps40422.o
 obj-$(CONFIG_SENSORS_TPS53679)	+= tps53679.o
 obj-$(CONFIG_SENSORS_UCD9000)	+= ucd9000.o
 obj-$(CONFIG_SENSORS_UCD9200)	+= ucd9200.o
 obj-$(CONFIG_SENSORS_XDPE122)	+= xdpe12284.o
 obj-$(CONFIG_SENSORS_ZL6100)	+= zl6100.o
+
diff --git a/drivers/hwmon/pmbus/stpddc60.c b/drivers/hwmon/pmbus/stpddc60.c
new file mode 100644
index 000000000000..4e3ab260a3c2
--- /dev/null
+++ b/drivers/hwmon/pmbus/stpddc60.c
@@ -0,0 +1,188 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Hardware monitoring driver for the STPDDC60 controller
+ *
+ * Copyright (c) 2021 Flextronics International Sweden AB.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/pmbus.h>
+#include "pmbus.h"
+
+enum chips { stpddc60 };
+
+static const struct i2c_device_id stpddc60_id[] = {
+	{"stpddc60", stpddc60},
+	{"bmr481", stpddc60},
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, stpddc60_id);
+
+static struct pmbus_driver_info stpddc60_info = {
+	.pages = 1,
+	.func[0] = PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT
+		| PMBUS_HAVE_VIN | PMBUS_HAVE_STATUS_INPUT
+		| PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP
+		| PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT
+		| PMBUS_HAVE_POUT,
+};
+
+/*
+ * Convert VID value to milli-volt
+ */
+static long stpddc60_vid2mv(int val)
+{
+	long rv = 0;
+
+	if (val >= 0x01)
+		rv = 250 + (val - 1) * 5;
+
+	return rv;
+}
+
+/*
+ * Convert milli-volt to linear
+ */
+static int stpddc60_mv2l(long mv)
+{
+	int rv;
+
+	rv = (mv << 8) / 1000;
+
+	return rv;
+}
+
+/*
+ * The VOUT_COMMAND register uses the VID format but the vout alarm limit
+ * registers use the linear format so we override VOUT_MODE here to force
+ * linear format for all registers.
+ */
+static int stpddc60_read_byte_data(struct i2c_client *client, int page, int reg)
+{
+	int ret;
+
+	if (page > 0)
+		return -ENXIO;
+
+	switch (reg) {
+	case PMBUS_VOUT_MODE:
+		ret = 0x18;
+		break;
+	default:
+		ret = -ENODATA;
+		break;
+	}
+
+	return ret;
+}
+
+/*
+ * Do the necessary conversions between VID and linear data format.
+ */
+static int stpddc60_read_word_data(struct i2c_client *client, int page,
+				   int phase, int reg)
+{
+	int ret;
+
+	if (page > 0)
+		return -ENXIO;
+
+	switch (reg) {
+	case PMBUS_READ_VOUT:
+		ret = pmbus_read_word_data(client, page, phase, reg);
+		if (ret < 0)
+			return ret;
+		ret = stpddc60_mv2l(stpddc60_vid2mv(ret));
+		break;
+	case PMBUS_VOUT_OV_FAULT_LIMIT:
+	case PMBUS_VOUT_UV_FAULT_LIMIT:
+		ret = pmbus_read_word_data(client, page, phase, reg);
+		if (ret < 0)
+			return ret;
+		ret &= 0x07ff;
+		break;
+	default:
+		ret = -ENODATA;
+		break;
+	}
+
+	return ret;
+}
+
+/*
+ * The vout under- and over-voltage limits are readonly for this chip.
+ */
+static int stpddc60_write_word_data(struct i2c_client *client, int page,
+				    int reg, u16 word)
+{
+	int ret;
+
+	if (page > 0)
+		return -ENXIO;
+
+	switch (reg) {
+	case PMBUS_VOUT_OV_FAULT_LIMIT:
+		ret = -EACCES;
+		break;
+	case PMBUS_VOUT_UV_FAULT_LIMIT:
+		ret = -EACCES;
+		break;
+	default:
+		ret = -ENODATA;
+		break;
+	}
+
+	return ret;
+}
+
+static int stpddc60_probe(struct i2c_client *client,
+			  const struct i2c_device_id *id)
+{
+	int status;
+	u8 device_id[I2C_SMBUS_BLOCK_MAX + 1];
+	const struct i2c_device_id *mid;
+	struct pmbus_driver_info *info = &stpddc60_info;
+
+	if (!i2c_check_functionality(client->adapter,
+				     I2C_FUNC_SMBUS_READ_BYTE_DATA
+				     | I2C_FUNC_SMBUS_BLOCK_DATA))
+		return -ENODEV;
+
+	status = i2c_smbus_read_block_data(client, PMBUS_MFR_MODEL, device_id);
+	if (status < 0) {
+		dev_err(&client->dev, "Failed to read Manufacturer Model\n");
+		return status;
+	}
+	for (mid = stpddc60_id; mid->name[0]; mid++) {
+		if (!strncasecmp(mid->name, device_id, strlen(mid->name)))
+			break;
+	}
+	if (!mid->name[0]) {
+		dev_err(&client->dev, "Unsupported device\n");
+		return -ENODEV;
+	}
+
+	info->read_byte_data = stpddc60_read_byte_data;
+	info->read_word_data = stpddc60_read_word_data;
+	info->write_word_data = stpddc60_write_word_data;
+
+	return pmbus_do_probe(client, info);
+}
+
+static struct i2c_driver stpddc60_driver = {
+	.driver = {
+		   .name = "stpddc60",
+		   },
+	.probe = stpddc60_probe,
+	.id_table = stpddc60_id,
+};
+
+module_i2c_driver(stpddc60_driver);
+
+MODULE_AUTHOR("Erik Rosen <erik.rosen@metormote.com>");
+MODULE_DESCRIPTION("PMBus driver for ST STPDDC60");
+MODULE_LICENSE("GPL");
-- 
2.20.1

