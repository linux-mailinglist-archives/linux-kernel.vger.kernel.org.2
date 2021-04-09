Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7FE359176
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 03:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233183AbhDIB33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 21:29:29 -0400
Received: from mail-wm1-f45.google.com ([209.85.128.45]:36539 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbhDIB3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 21:29:25 -0400
Received: by mail-wm1-f45.google.com with SMTP id j20-20020a05600c1914b029010f31e15a7fso3830925wmq.1;
        Thu, 08 Apr 2021 18:29:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jz/BmwXT2JiSpalzUV9orhkrmdLN5+8cxM2L7471wQw=;
        b=kfw/aMnDg0SXRzTERZuFykQ7kS8+TfEs0DYgKkE+RsN0j3Zzrl5QpiAMWEXACV+66I
         nTtzn4MT6l9X44uZf7o8Wwd+tiIQEBzB83bTadSJ+uoyyUHK1ZtJn+nk+l/M0NQGsVie
         7fu51AquxaCTOuD4H3R8vcCb+SfeekB/4pF1b+nwUOel0HRC2+J2nZoijYgmzKvNVDrF
         VxHfpzX1R9wuow4fQg+u8Fwpr534cwCQvMrZ+hIE9k2u3C+/wDmj3N/wfKlNqYRzk9vG
         vKAFGANcANv/hqKnAIFsrYCpjtSzw795yPO1si5E5UHJldbuAwgPvFIWJWU/ckZdmXkO
         DIaA==
X-Gm-Message-State: AOAM531xkGExSgPjcPNRsztkClhtyQEunRhScEAeHhHB53QB2MsUyhv8
        YEB6yYadXKz2F/uZyK+9Jb8=
X-Google-Smtp-Source: ABdhPJzGGzoFsInsb2qvqAsZWueg0bw4MCn2OBrForF752zHeFILftrtggjFqx1wiD7nSDh8yrudwQ==
X-Received: by 2002:a1c:f20f:: with SMTP id s15mr11782340wmc.61.1617931752741;
        Thu, 08 Apr 2021 18:29:12 -0700 (PDT)
Received: from localhost ([2a02:8308:387:c900:a7b5:b859:9449:c07b])
        by smtp.gmail.com with ESMTPSA id o8sm1679420wrv.49.2021.04.08.18.29.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Apr 2021 18:29:11 -0700 (PDT)
From:   =?UTF-8?q?V=C3=A1clav=20Kubern=C3=A1t?= <kubernat@cesnet.cz>
Cc:     =?UTF-8?q?V=C3=A1clav=20Kubern=C3=A1t?= <kubernat@cesnet.cz>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] hwmon: Add driver for fsp-3y PSUs and PDUs
Date:   Fri,  9 Apr 2021 03:27:53 +0200
Message-Id: <20210409012754.743045-1-kubernat@cesnet.cz>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210329143833.1047539-1-kubernat@cesnet.cz>
References: <20210329143833.1047539-1-kubernat@cesnet.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for these devices:
- YH-5151E - the PDU
- YM-2151E - the PSU

The device datasheet says that the devices support PMBus 1.2, but in my
testing, a lot of the commands aren't supported and if they are, they
sometimes behave strangely or inconsistently. For example, writes to the
PAGE command requires using PEC, otherwise the write won't work and the
page won't switch, even though, the standard says that PEC is opiotnal.
On the other hand, writes the SMBALERT don't require PEC. Because of
this, the driver is mostly reverse engineered with the help of a tool
called pmbus_peek written by David Brownell (and later adopted by my
colleague Jan Kundrát).

The device also has some sort of a timing issue when switching pages,
which is explained further in the code.

Because of this, the driver support is limited. It exposes only the
values, that have been tested to work correctly.

Signed-off-by: Václav Kubernát <kubernat@cesnet.cz>
---
 Documentation/hwmon/fsp-3y.rst |  26 ++++
 drivers/hwmon/pmbus/Kconfig    |  10 ++
 drivers/hwmon/pmbus/Makefile   |   1 +
 drivers/hwmon/pmbus/fsp-3y.c   | 236 +++++++++++++++++++++++++++++++++
 4 files changed, 273 insertions(+)
 create mode 100644 Documentation/hwmon/fsp-3y.rst
 create mode 100644 drivers/hwmon/pmbus/fsp-3y.c

diff --git a/Documentation/hwmon/fsp-3y.rst b/Documentation/hwmon/fsp-3y.rst
new file mode 100644
index 000000000000..68a547021846
--- /dev/null
+++ b/Documentation/hwmon/fsp-3y.rst
@@ -0,0 +1,26 @@
+Kernel driver fsp3y
+======================
+Supported devices:
+  * 3Y POWER YH-5151E
+  * 3Y POWER YM-2151E
+
+Author: Václav Kubernát <kubernat@cesnet.cz>
+
+Description
+-----------
+This driver implements limited support for two 3Y POWER devices.
+
+Sysfs entries
+-------------
+in1_input            input voltage
+in2_input            12V output voltage
+in3_input            5V output voltage
+curr1_input          input current
+curr2_input          12V output current
+curr3_input          5V output current
+fan1_input           fan rpm
+temp1_input          temperature 1
+temp2_input          temperature 2
+temp3_input          temperature 3
+power1_input         input power
+power2_input         output power
diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
index 03606d4298a4..9d12d446396c 100644
--- a/drivers/hwmon/pmbus/Kconfig
+++ b/drivers/hwmon/pmbus/Kconfig
@@ -56,6 +56,16 @@ config SENSORS_BEL_PFE
 	  This driver can also be built as a module. If so, the module will
 	  be called bel-pfe.
 
+config SENSORS_FSP_3Y
+	tristate "FSP/3Y-Power power supplies"
+	help
+	  If you say yes here you get hardware monitoring support for
+	  FSP/3Y-Power hot-swap power supplies.
+	  Supported models: YH-5151E, YM-2151E
+
+	  This driver can also be built as a module. If so, the module will
+	  be called fsp-3y.
+
 config SENSORS_IBM_CFFPS
 	tristate "IBM Common Form Factor Power Supply"
 	depends on LEDS_CLASS
diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
index 6a4ba0fdc1db..bfe218ad898f 100644
--- a/drivers/hwmon/pmbus/Makefile
+++ b/drivers/hwmon/pmbus/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_SENSORS_PMBUS)	+= pmbus.o
 obj-$(CONFIG_SENSORS_ADM1266)	+= adm1266.o
 obj-$(CONFIG_SENSORS_ADM1275)	+= adm1275.o
 obj-$(CONFIG_SENSORS_BEL_PFE)	+= bel-pfe.o
+obj-$(CONFIG_SENSORS_FSP_3Y)	+= fsp-3y.o
 obj-$(CONFIG_SENSORS_IBM_CFFPS)	+= ibm-cffps.o
 obj-$(CONFIG_SENSORS_INSPUR_IPSPS) += inspur-ipsps.o
 obj-$(CONFIG_SENSORS_IR35221)	+= ir35221.o
diff --git a/drivers/hwmon/pmbus/fsp-3y.c b/drivers/hwmon/pmbus/fsp-3y.c
new file mode 100644
index 000000000000..f03c4e27ec8c
--- /dev/null
+++ b/drivers/hwmon/pmbus/fsp-3y.c
@@ -0,0 +1,236 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Hardware monitoring driver for FSP 3Y-Power PSUs
+ *
+ * Copyright (c) 2021 Václav Kubernát, CESNET
+ */
+
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include "pmbus.h"
+
+#define YM2151_PAGE_12V_LOG	0x00
+#define YM2151_PAGE_12V_REAL	0x00
+#define YM2151_PAGE_5VSB_LOG	0x01
+#define YM2151_PAGE_5VSB_REAL	0x20
+#define YH5151E_PAGE_12V_LOG	0x00
+#define YH5151E_PAGE_12V_REAL	0x00
+#define YH5151E_PAGE_5V_LOG	0x01
+#define YH5151E_PAGE_5V_REAL	0x10
+#define YH5151E_PAGE_3V3_LOG	0x02
+#define YH5151E_PAGE_3V3_REAL	0x11
+
+enum chips {
+	ym2151e,
+	yh5151e
+};
+
+struct fsp3y_data {
+	struct pmbus_driver_info info;
+	enum chips chip;
+	int page;
+};
+
+#define to_fsp3y_data(x) container_of(x, struct fsp3y_data, info)
+
+static int page_log_to_page_real(int page_log, enum chips chip)
+{
+	switch (chip) {
+	case ym2151e:
+		switch (page_log) {
+		case YM2151_PAGE_12V_LOG:
+			return YM2151_PAGE_12V_REAL;
+		case YM2151_PAGE_5VSB_LOG:
+			return YM2151_PAGE_5VSB_REAL;
+		}
+		return -EINVAL;
+	case yh5151e:
+		switch (page_log) {
+		case YH5151E_PAGE_12V_LOG:
+			return YH5151E_PAGE_12V_REAL;
+		case YH5151E_PAGE_5V_LOG:
+			return YH5151E_PAGE_5V_LOG;
+		case YH5151E_PAGE_3V3_LOG:
+			return YH5151E_PAGE_3V3_REAL;
+		}
+		return -EINVAL;
+	}
+
+	return -EINVAL;
+}
+
+static int set_page(struct i2c_client *client, int page_log)
+{
+	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
+	struct fsp3y_data *data = to_fsp3y_data(info);
+	int rv;
+	int page_real;
+
+	if (page_log < 0)
+		return 0;
+
+	page_real = page_log_to_page_real(page_log, data->chip);
+	if (page_real < 0)
+		return page_real;
+
+	if (data->page != page_real) {
+		rv = pmbus_set_page(client, page_real, 0xff);
+		if (rv < 0)
+			return rv;
+
+		data->page = page_real;
+
+		/* Testing showed that the device has a timing issue. After
+		 * setting a page, it takes a while, before the device actually
+		 * gives the correct values from the correct page. 20 ms was
+		 * tested to be enough to not give wrong values (15 ms wasn't
+		 * enough)
+		 */
+		usleep_range(20000, 30000);
+	}
+
+	return 0;
+}
+
+static int fsp3y_read_byte_data(struct i2c_client *client, int page, int reg)
+{
+	int rv;
+
+	rv = set_page(client, page);
+	if (rv < 0)
+		return rv;
+
+	return i2c_smbus_read_byte_data(client, reg);
+}
+
+static int fsp3y_read_word_data(struct i2c_client *client, int page, int phase, int reg)
+{
+	int rv;
+
+	switch (reg) {
+	case PMBUS_READ_FAN_SPEED_1:
+	case PMBUS_READ_IIN:
+	case PMBUS_READ_IOUT:
+	case PMBUS_READ_PIN:
+	case PMBUS_READ_POUT:
+	case PMBUS_READ_TEMPERATURE_1:
+	case PMBUS_READ_TEMPERATURE_2:
+	case PMBUS_READ_TEMPERATURE_3:
+	case PMBUS_READ_VIN:
+	case PMBUS_READ_VOUT:
+	case PMBUS_STATUS_WORD:
+		break;
+	default:
+		return -ENXIO;
+	}
+
+	rv = set_page(client, page);
+	if (rv < 0)
+		return rv;
+
+	return i2c_smbus_read_word_data(client, reg);
+}
+
+struct pmbus_driver_info fsp3y_info[] = {
+	[ym2151e] = {
+		.pages = 2,
+		.func[YM2151_PAGE_12V_LOG] =
+			PMBUS_HAVE_VOUT | PMBUS_HAVE_IOUT |
+			PMBUS_HAVE_PIN | PMBUS_HAVE_POUT  |
+			PMBUS_HAVE_TEMP | PMBUS_HAVE_TEMP2 |
+			PMBUS_HAVE_VIN | PMBUS_HAVE_IIN |
+			PMBUS_HAVE_FAN12,
+		.func[YM2151_PAGE_5VSB_LOG] =
+			PMBUS_HAVE_VOUT | PMBUS_HAVE_IOUT,
+			PMBUS_HAVE_IIN,
+		.read_word_data = fsp3y_read_word_data,
+		.read_byte_data = fsp3y_read_byte_data,
+	},
+	[yh5151e] = {
+		.pages = 3,
+		.func[YH5151E_PAGE_12V_LOG] =
+			PMBUS_HAVE_VOUT | PMBUS_HAVE_IOUT |
+			PMBUS_HAVE_POUT  |
+			PMBUS_HAVE_TEMP | PMBUS_HAVE_TEMP2 | PMBUS_HAVE_TEMP3,
+		.func[YH5151E_PAGE_5V_LOG] =
+			PMBUS_HAVE_VOUT | PMBUS_HAVE_IOUT |
+			PMBUS_HAVE_POUT,
+		.func[YH5151E_PAGE_3V3_LOG] =
+			PMBUS_HAVE_VOUT | PMBUS_HAVE_IOUT |
+			PMBUS_HAVE_POUT,
+		.read_word_data = fsp3y_read_word_data,
+		.read_byte_data = fsp3y_read_byte_data,
+	}
+};
+
+static int fsp3y_detect(struct i2c_client *client)
+{
+	int rv;
+	u8 buf[I2C_SMBUS_BLOCK_MAX];
+
+	rv = i2c_smbus_read_block_data(client, PMBUS_MFR_MODEL, buf);
+	if (rv < 0)
+		return rv;
+
+	if (rv == 8 && !strncmp(buf, "YM-2151E", strlen("YM-2151E")))
+		return ym2151e;
+	else if (rv == 8 && !strncmp(buf, "YH-5151E", strlen("YH-5151E")))
+		return yh5151e;
+
+	dev_err(&client->dev, "Unsupported model %.*s\n", rv, buf);
+	return -ENODEV;
+}
+
+static const struct i2c_device_id fsp3y_id[] = {
+	{"ym2151e", ym2151e},
+	{"yh5151e", yh5151e}
+};
+
+static int fsp3y_probe(struct i2c_client *client)
+{
+	struct fsp3y_data *data;
+	const struct i2c_device_id *id;
+	int rv;
+
+	data = devm_kzalloc(&client->dev, sizeof(struct fsp3y_data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->chip = fsp3y_detect(client);
+
+	id = i2c_match_id(fsp3y_id, client);
+	if (data->chip != id->driver_data)
+		dev_warn(&client->dev,
+			 "Device mismatch: Configured %s (%d), detected %d\n",
+			 id->name,
+			 (int)id->driver_data,
+			 data->chip);
+
+	rv = i2c_smbus_read_byte_data(client, PMBUS_PAGE);
+	if (rv < 0)
+		return rv;
+	data->page = rv;
+
+	data->info = fsp3y_info[data->chip];
+
+	return pmbus_do_probe(client, &data->info);
+}
+
+MODULE_DEVICE_TABLE(i2c, pmbus_id);
+
+/* This is the driver that will be inserted */
+static struct i2c_driver fsp3y_driver = {
+	.driver = {
+		   .name = "fsp3y",
+		   },
+	.probe_new = fsp3y_probe,
+	.id_table = fsp3y_id
+};
+
+module_i2c_driver(fsp3y_driver);
+
+MODULE_AUTHOR("Václav Kubernát");
+MODULE_DESCRIPTION("PMBus driver for FSP/3Y-Power power supplies");
+MODULE_LICENSE("GPL");
-- 
2.31.1

