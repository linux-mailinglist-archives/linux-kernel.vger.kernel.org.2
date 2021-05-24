Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 377A838ECA8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 17:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235391AbhEXPU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 11:20:59 -0400
Received: from smtp.outgoing.loopia.se ([93.188.3.37]:41018 "EHLO
        smtp.outgoing.loopia.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234651AbhEXPIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 11:08:35 -0400
Received: from s807.loopia.se (localhost [127.0.0.1])
        by s807.loopia.se (Postfix) with ESMTP id B263B2E6CB53
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 17:02:57 +0200 (CEST)
Received: from s499.loopia.se (unknown [172.22.191.6])
        by s807.loopia.se (Postfix) with ESMTP id A1BE52E2B91C;
        Mon, 24 May 2021 17:02:57 +0200 (CEST)
Received: from s474.loopia.se (unknown [172.22.191.5])
        by s499.loopia.se (Postfix) with ESMTP id 90DD61CE6014;
        Mon, 24 May 2021 17:02:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at amavis.loopia.se
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-999 required=6.2
        tests=[ALL_TRUSTED=-1] autolearn=disabled
Received: from s934.loopia.se ([172.22.191.5])
        by s474.loopia.se (s474.loopia.se [172.22.190.14]) (amavisd-new, port 10024)
        with UTF8LMTP id w377MzJFngl1; Mon, 24 May 2021 17:02:56 +0200 (CEST)
X-Loopia-Auth: user
X-Loopia-User: carl@hgsystem.se
X-Loopia-Originating-IP: 155.4.133.180
Received: from localhost.localdomain (h-155-4-133-180.NA.cust.bahnhof.se [155.4.133.180])
        (Authenticated sender: carl@hgsystem.se)
        by s934.loopia.se (Postfix) with ESMTPSA id 8A2747CE98D;
        Mon, 24 May 2021 17:02:56 +0200 (CEST)
From:   Erik Rosen <erik.rosen@metormote.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Erik Rosen <erik.rosen@metormote.com>
Subject: [PATCH v3 5/6] hwmon: (pmbus/pim4328) Add PMBus driver for PIM4006, PIM4328 and PIM4820
Date:   Mon, 24 May 2021 17:02:45 +0200
Message-Id: <20210524150246.90546-6-erik.rosen@metormote.com>
X-Mailer: git-send-email 2.11.0 (Apple Git-81)
In-Reply-To: <20210524150246.90546-1-erik.rosen@metormote.com>
References: <20210524150246.90546-1-erik.rosen@metormote.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add hardware monitoring support for Flex power interface modules PIM4006,
PIM4328 and PIM4820.

Signed-off-by: Erik Rosen <erik.rosen@metormote.com>
---
 drivers/hwmon/pmbus/Kconfig   |   9 ++
 drivers/hwmon/pmbus/Makefile  |   1 +
 drivers/hwmon/pmbus/pim4328.c | 240 ++++++++++++++++++++++++++++++++++
 3 files changed, 250 insertions(+)
 create mode 100644 drivers/hwmon/pmbus/pim4328.c

diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
index 37a5c39784fa..001527c71269 100644
--- a/drivers/hwmon/pmbus/Kconfig
+++ b/drivers/hwmon/pmbus/Kconfig
@@ -257,6 +257,15 @@ config SENSORS_MP2975
 	  This driver can also be built as a module. If so, the module will
 	  be called mp2975.
 
+config SENSORS_PIM4328
+	tristate "Flex PIM4328 and compatibles"
+	help
+	  If you say yes here you get hardware monitoring support for Flex
+	  PIM4328, PIM4820 and PIM4006 Power Interface Modules.
+
+	  This driver can also be built as a module. If so, the module will
+	  be called pim4328.
+
 config SENSORS_PM6764TR
 	tristate "ST PM6764TR"
 	help
diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
index f8dcc27cd56a..2a12397535ba 100644
--- a/drivers/hwmon/pmbus/Makefile
+++ b/drivers/hwmon/pmbus/Makefile
@@ -39,3 +39,4 @@ obj-$(CONFIG_SENSORS_UCD9000)	+= ucd9000.o
 obj-$(CONFIG_SENSORS_UCD9200)	+= ucd9200.o
 obj-$(CONFIG_SENSORS_XDPE122)	+= xdpe12284.o
 obj-$(CONFIG_SENSORS_ZL6100)	+= zl6100.o
+obj-$(CONFIG_SENSORS_PIM4328)   += pim4328.o
diff --git a/drivers/hwmon/pmbus/pim4328.c b/drivers/hwmon/pmbus/pim4328.c
new file mode 100644
index 000000000000..ead7419479ef
--- /dev/null
+++ b/drivers/hwmon/pmbus/pim4328.c
@@ -0,0 +1,240 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Hardware monitoring driver for PIM4006, PIM4328 and PIM4820
+ *
+ * Copyright (c) 2021 Flextronics International Sweden AB
+ */
+
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pmbus.h>
+#include <linux/slab.h>
+#include "pmbus.h"
+
+enum chips { pim4006, pim4328, pim4820 };
+
+struct pim4328_data {
+	enum chips id;
+	struct pmbus_driver_info info;
+};
+
+#define to_pim4328_data(x)  container_of(x, struct pim4328_data, info)
+
+/* PIM4006 and PIM4328 */
+#define PIM4328_MFR_READ_VINA		0xd3
+#define PIM4328_MFR_READ_VINB		0xd4
+
+/* PIM4006 */
+#define PIM4328_MFR_READ_IINA		0xd6
+#define PIM4328_MFR_READ_IINB		0xd7
+#define PIM4328_MFR_FET_CHECKSTATUS     0xd9
+
+/* PIM4328 */
+#define PIM4328_MFR_STATUS_BITS		0xd5
+
+/* PIM4820 */
+#define PIM4328_MFR_READ_STATUS		0xd0
+
+static const struct i2c_device_id pim4328_id[] = {
+	{"bmr455", pim4328},
+	{"pim4006", pim4006},
+	{"pim4106", pim4006},
+	{"pim4206", pim4006},
+	{"pim4306", pim4006},
+	{"pim4328", pim4328},
+	{"pim4406", pim4006},
+	{"pim4820", pim4820},
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, pim4328_id);
+
+static int pim4328_read_word_data(struct i2c_client *client, int page,
+				  int phase, int reg)
+{
+	int ret;
+
+	if (page > 0)
+		return -ENXIO;
+
+	switch (reg) {
+	case PMBUS_READ_VIN:
+		if (phase != 0xff) {
+			ret = pmbus_read_word_data(client, page, phase,
+						   phase == 0 ? PIM4328_MFR_READ_VINA
+							      : PIM4328_MFR_READ_VINB);
+		} else {
+			ret = -ENODATA;
+		}
+		break;
+	case PMBUS_READ_IIN:
+		if (phase != 0xff) {
+			ret = pmbus_read_word_data(client, page, phase,
+						   phase == 0 ? PIM4328_MFR_READ_IINA
+							      : PIM4328_MFR_READ_IINB);
+		} else {
+			ret = -ENODATA;
+		}
+		break;
+	default:
+		ret = -ENODATA;
+	}
+
+	return ret;
+}
+
+static int pim4328_read_byte_data(struct i2c_client *client, int page, int reg)
+{
+	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
+	struct pim4328_data *data = to_pim4328_data(info);
+	int ret, status;
+
+	if (page > 0)
+		return -ENXIO;
+
+	switch (reg) {
+	case PMBUS_STATUS_BYTE:
+		ret = pmbus_read_byte_data(client, page, PMBUS_STATUS_BYTE);
+		if (ret >= 0) {
+			if (data->id == pim4006) {
+				status = pmbus_read_word_data(client, page, 0xff,
+							      PIM4328_MFR_FET_CHECKSTATUS);
+				if (status > 0) {
+					if (status & 0x0630) /* Input UV */
+						ret |= 0x08;
+				}
+			} else if (data->id == pim4328) {
+				status = pmbus_read_byte_data(client, page,
+							      PIM4328_MFR_STATUS_BITS);
+				if (status > 0) {
+					if (status & 0x04) /* Input UV */
+						ret |= 0x08;
+					if (status & 0x40) /* Output UV */
+						ret |= 0x80;
+				}
+			} else if (data->id == pim4820) {
+				status = pmbus_read_byte_data(client, page,
+							      PIM4328_MFR_READ_STATUS);
+				if (status > 0) {
+					if (status & 0x05) /* Input OV or OC */
+						ret |= 0x01;
+					if (status & 0x1a) /* Input UV */
+						ret |= 0x08;
+					if (status & 0x40) /* OT */
+						ret |= 0x04;
+				}
+			}
+		}
+		break;
+	default:
+		ret = -ENODATA;
+	}
+
+	return ret;
+}
+
+static int pim4328_probe(struct i2c_client *client)
+{
+	int status;
+	u8 device_id[I2C_SMBUS_BLOCK_MAX + 1];
+	const struct i2c_device_id *mid;
+	struct pim4328_data *data;
+	struct pmbus_driver_info *info;
+	struct pmbus_platform_data *pdata;
+	struct device *dev = &client->dev;
+
+	if (!i2c_check_functionality(client->adapter,
+				     I2C_FUNC_SMBUS_READ_BYTE_DATA
+				     | I2C_FUNC_SMBUS_BLOCK_DATA))
+		return -ENODEV;
+
+	data = devm_kzalloc(&client->dev, sizeof(struct pim4328_data),
+			    GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	status = i2c_smbus_read_block_data(client, PMBUS_MFR_MODEL, device_id);
+	if (status < 0) {
+		dev_err(&client->dev, "Failed to read Manufacturer Model\n");
+		return status;
+	}
+	for (mid = pim4328_id; mid->name[0]; mid++) {
+		if (!strncasecmp(mid->name, device_id, strlen(mid->name)))
+			break;
+	}
+	if (!mid->name[0]) {
+		dev_err(&client->dev, "Unsupported device\n");
+		return -ENODEV;
+	}
+
+	if (strcmp(client->name, mid->name) != 0)
+		dev_notice(&client->dev,
+			   "Device mismatch: Configured %s, detected %s\n",
+			   client->name, mid->name);
+
+	data->id = mid->driver_data;
+	info = &data->info;
+	info->pages = 1;
+	info->read_byte_data = pim4328_read_byte_data;
+	info->read_word_data = pim4328_read_word_data;
+
+	switch (data->id) {
+	case pim4006:
+		info->phases[0] = 2;
+		info->func[0] = PMBUS_PHASE_VIRTUAL | PMBUS_HAVE_VIN
+			| PMBUS_HAVE_TEMP | PMBUS_HAVE_IOUT;
+		info->pfunc[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_IIN;
+		info->pfunc[1] = PMBUS_HAVE_VIN | PMBUS_HAVE_IIN;
+		break;
+	case pim4328:
+		info->phases[0] = 2;
+		info->func[0] = PMBUS_PHASE_VIRTUAL
+			| PMBUS_HAVE_VCAP | PMBUS_HAVE_VIN
+			| PMBUS_HAVE_TEMP | PMBUS_HAVE_IOUT;
+		info->pfunc[0] = PMBUS_HAVE_VIN;
+		info->pfunc[1] = PMBUS_HAVE_VIN;
+		info->format[PSC_VOLTAGE_IN] = direct;
+		info->format[PSC_TEMPERATURE] = direct;
+		info->format[PSC_CURRENT_OUT] = direct;
+		break;
+	case pim4820:
+		info->func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_TEMP
+			| PMBUS_HAVE_IIN;
+		info->format[PSC_VOLTAGE_IN] = direct;
+		info->format[PSC_TEMPERATURE] = direct;
+		info->format[PSC_CURRENT_IN] = direct;
+		break;
+	default:
+		return -ENODEV;
+	}
+
+	pdata = devm_kzalloc(dev, sizeof(struct pmbus_platform_data),
+			     GFP_KERNEL);
+	if (!pdata)
+		return -ENOMEM;
+
+	pdata->flags = PMBUS_NO_CAPABILITY | PMBUS_NO_WRITE_PROTECT;
+	if (data->id == pim4328 || data->id == pim4820)
+		pdata->flags |= PMBUS_USE_COEFFICIENTS_CMD;
+
+	dev->platform_data = pdata;
+
+	return pmbus_do_probe(client, info);
+}
+
+static struct i2c_driver pim4328_driver = {
+	.driver = {
+		   .name = "pim4328",
+		   },
+	.probe_new = pim4328_probe,
+	.id_table = pim4328_id,
+};
+
+module_i2c_driver(pim4328_driver);
+
+MODULE_AUTHOR("Erik Rosen <erik.rosen@metormote.com>");
+MODULE_DESCRIPTION("PMBus driver for PIM4006, PIM4328, PIM4820 power interface modules");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(PMBUS);
-- 
2.20.1

