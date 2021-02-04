Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3968130F3E2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 14:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236332AbhBDN3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 08:29:25 -0500
Received: from smtp.outgoing.loopia.se ([93.188.3.37]:18281 "EHLO
        smtp.outgoing.loopia.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236277AbhBDN3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 08:29:17 -0500
Received: from s807.loopia.se (localhost [127.0.0.1])
        by s807.loopia.se (Postfix) with ESMTP id 0A0601A91380
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 14:21:07 +0100 (CET)
Received: from s498.loopia.se (unknown [172.22.191.6])
        by s807.loopia.se (Postfix) with ESMTP id DD0FF2E2B85F;
        Thu,  4 Feb 2021 14:21:06 +0100 (CET)
Received: from s473.loopia.se (unknown [172.22.191.5])
        by s498.loopia.se (Postfix) with ESMTP id D1293489457;
        Thu,  4 Feb 2021 14:21:06 +0100 (CET)
X-Virus-Scanned: amavisd-new at amavis.loopia.se
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-999 required=6.2
        tests=[ALL_TRUSTED=-1] autolearn=disabled
Received: from s499.loopia.se ([172.22.191.6])
        by s473.loopia.se (s473.loopia.se [172.22.190.13]) (amavisd-new, port 10024)
        with LMTP id kz6Cu-GSSzrG; Thu,  4 Feb 2021 14:21:05 +0100 (CET)
X-Loopia-Auth: user
X-Loopia-User: carl@hgsystem.se
X-Loopia-Originating-IP: 155.4.131.176
Received: from localhost.localdomain (h-155-4-131-176.NA.cust.bahnhof.se [155.4.131.176])
        (Authenticated sender: carl@hgsystem.se)
        by s499.loopia.se (Postfix) with ESMTPSA id 601EE1CE5C70;
        Thu,  4 Feb 2021 14:21:05 +0100 (CET)
From:   Erik Rosen <erik.rosen@metormote.com>
To:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-hwmon@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Cc:     Erik Rosen <erik.rosen@metormote.com>
Subject: [PATCH V2 2/2] hwmon: (pmbus/stpddc60) Add ST STPDDC60 pmbus driver
Date:   Thu,  4 Feb 2021 14:20:40 +0100
Message-Id: <20210204132040.3868-3-erik.rosen@metormote.com>
X-Mailer: git-send-email 2.11.0 (Apple Git-81)
In-Reply-To: <20210204132040.3868-1-erik.rosen@metormote.com>
References: <20210204132040.3868-1-erik.rosen@metormote.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add hardware monitoring support for ST STPDDC60 Unversal Digital
Multicell Controller.

Signed-off-by: Erik Rosen <erik.rosen@metormote.com>
---
 Documentation/hwmon/index.rst    |   1 +
 Documentation/hwmon/stpddc60.rst |  90 +++++++++++
 MAINTAINERS                      |   7 +
 drivers/hwmon/pmbus/Kconfig      |  10 ++
 drivers/hwmon/pmbus/Makefile     |   2 +
 drivers/hwmon/pmbus/stpddc60.c   | 248 +++++++++++++++++++++++++++++++
 6 files changed, 358 insertions(+)
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
index 000000000000..7f7ce7f7871b
--- /dev/null
+++ b/Documentation/hwmon/stpddc60.rst
@@ -0,0 +1,90 @@
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
+The vout under- and over-voltage limits are set in relation to the commanded
+output voltage as a positive or negative offset in the interval 50mV to 400mV
+in 50mV steps. This means that the absolute values of the limits will change
+when the commanded output voltage changes. Also, care should be taken when
+writing to those limits since in the worst case the commanded output voltage
+could change at the same time as the limit is written to, wich will lead to
+unpredictable results.
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
+The following attributes are supported. Vin, iout, pout and temp limits
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
+in2_lcrit		Critical minimum output voltage.
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
+power1_label		"pout1"
+power1_input		Measured output power.
+power1_crit		Critical maximum output power.
+power1_crit_alarm	Output power critical high alarm.
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
index 000000000000..9a3348f45bc2
--- /dev/null
+++ b/drivers/hwmon/pmbus/stpddc60.c
@@ -0,0 +1,248 @@
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
+#define STPDDC60_MFR_READ_VOUT		0xd2
+#define STPDDC60_MFR_OV_LIMIT_OFFSET	0xe5
+#define STPDDC60_MFR_UV_LIMIT_OFFSET	0xe6
+
+static const struct i2c_device_id stpddc60_id[] = {
+	{"stpddc60", 0},
+	{"bmr481", 0},
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
+ * Calculate the closest absolute offset between commanded vout value
+ * and limit value in steps of 50mv in the range 0 (50mv) to 7 (400mv).
+ * Return 0 if the upper limit is lower than vout or if the lower limit
+ * is higher than vout.
+ */
+static u8 stpddc60_get_offset(int vout, u16 limit, bool over)
+{
+	u8 offset;
+	long v, l;
+
+	v = 250 + (vout - 1) * 5; /* Convert VID to mv */
+	l = (limit * 1000L) >> 8; /* Convert LINEAR to mv */
+
+	if (over != (l > v))
+		return 0;
+
+	offset = DIV_ROUND_CLOSEST(abs(l - v), 50);
+
+	if (offset > 0)
+		offset--;
+
+	return clamp_val(offset, 0, 7);
+}
+
+/*
+ * Adjust the linear format word to use the given fixed exponent.
+ */
+static u16 stpddc60_adjust_linear(u16 word, s16 fixed)
+{
+	s16 e, m, d;
+
+	e = ((s16)word) >> 11;
+	m = ((s16)((word & 0x7ff) << 5)) >> 5;
+	d = e - fixed;
+
+	if (d >= 0)
+		m <<= d;
+	else
+		m >>= -d;
+
+	return clamp_val(m, 0, 0x3ff) | ((fixed << 11) & 0xf800);
+}
+
+/*
+ * The VOUT_COMMAND register uses the VID format but the vout alarm limit
+ * registers use the LINEAR format so we override VOUT_MODE here to force
+ * LINEAR format for all registers.
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
+ * The vout related registers return values in LINEAR11 format when LINEAR16
+ * is expected. Clear the top 5 bits to set the exponent part to zero to
+ * convert the value to LINEAR16 format.
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
+		ret = pmbus_read_word_data(client, page, phase,
+					   STPDDC60_MFR_READ_VOUT);
+		if (ret < 0)
+			return ret;
+		ret &= 0x7ff;
+		break;
+	case PMBUS_VOUT_OV_FAULT_LIMIT:
+	case PMBUS_VOUT_UV_FAULT_LIMIT:
+		ret = pmbus_read_word_data(client, page, phase, reg);
+		if (ret < 0)
+			return ret;
+		ret &= 0x7ff;
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
+ * The vout under- and over-voltage limits are set as an offset relative to
+ * the commanded vout voltage. The vin, iout, pout and temp limits must use
+ * the same fixed exponent the chip uses to encode the data when read.
+ */
+static int stpddc60_write_word_data(struct i2c_client *client, int page,
+				    int reg, u16 word)
+{
+	int ret;
+	u8 offset;
+
+	if (page > 0)
+		return -ENXIO;
+
+	switch (reg) {
+	case PMBUS_VOUT_OV_FAULT_LIMIT:
+		ret = pmbus_read_word_data(client, page, 0xff,
+					   PMBUS_VOUT_COMMAND);
+		if (ret < 0)
+			return ret;
+		offset = stpddc60_get_offset(ret, word, true);
+		ret = pmbus_write_byte_data(client, page,
+					    STPDDC60_MFR_OV_LIMIT_OFFSET,
+					    offset);
+		break;
+	case PMBUS_VOUT_UV_FAULT_LIMIT:
+		ret = pmbus_read_word_data(client, page, 0xff,
+					   PMBUS_VOUT_COMMAND);
+		if (ret < 0)
+			return ret;
+		offset = stpddc60_get_offset(ret, word, false);
+		ret = pmbus_write_byte_data(client, page,
+					    STPDDC60_MFR_UV_LIMIT_OFFSET,
+					    offset);
+		break;
+	case PMBUS_VIN_OV_FAULT_LIMIT:
+	case PMBUS_VIN_UV_FAULT_LIMIT:
+	case PMBUS_OT_FAULT_LIMIT:
+	case PMBUS_OT_WARN_LIMIT:
+	case PMBUS_IOUT_OC_FAULT_LIMIT:
+	case PMBUS_IOUT_OC_WARN_LIMIT:
+	case PMBUS_POUT_OP_FAULT_LIMIT:
+		ret = pmbus_read_word_data(client, page, 0xff, reg);
+		if (ret < 0)
+			return ret;
+		word = stpddc60_adjust_linear(word, ret >> 11);
+		ret = pmbus_write_word_data(client, page, reg, word);
+		break;
+	default:
+		ret = -ENODATA;
+		break;
+	}
+
+	return ret;
+}
+
+static int stpddc60_probe(struct i2c_client *client)
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
+	status = pmbus_do_probe(client, info);
+	if (status < 0)
+		return status;
+
+	pmbus_set_update(client, PMBUS_VOUT_OV_FAULT_LIMIT, true);
+	pmbus_set_update(client, PMBUS_VOUT_UV_FAULT_LIMIT, true);
+
+	return 0;
+}
+
+static struct i2c_driver stpddc60_driver = {
+	.driver = {
+		   .name = "stpddc60",
+		   },
+	.probe_new = stpddc60_probe,
+	.id_table = stpddc60_id,
+};
+
+module_i2c_driver(stpddc60_driver);
+
+MODULE_AUTHOR("Erik Rosen <erik.rosen@metormote.com>");
+MODULE_DESCRIPTION("PMBus driver for ST STPDDC60");
+MODULE_LICENSE("GPL");
-- 
2.30.0

