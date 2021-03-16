Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C511133CB87
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 03:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234686AbhCPCfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 22:35:38 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:56191 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234674AbhCPCfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 22:35:33 -0400
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 2CD9D891AE;
        Tue, 16 Mar 2021 15:35:32 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1615862132;
        bh=SJTQqdkH3Iwsyfqc8RKaJjOT747DtryCOi9XYjP6qaA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=u/JdYFmWn0u2ZfhP8dUYIXZmDd5chdZIPVVq1XB+ucjfNr1GtXEc4256JR7LLQRV2
         /j/1wBQ6iE9Zyx723TmqMKaGkfSEODVfFzovB/0ZRZDHcNhbtXO4xxksl6T2ICkIQd
         UkhnYwKpxK6W4e6u925ZcRZXg2qHQ7tCOes2kJWKV2hbtkrPhhXZ5chkvVLP1REXU3
         +VeMrngBvAI+qfCNRxMAczS1iVosdTdCsnsMaGTNHc7AIm6oNceIvcU9MP9ZsXYohd
         Oq67k7kSdB0TT6F8Uv/ay/ZqpLKyWkG5+fOCVHrqaDw8oArBKtCnG1GMOMix1k67mC
         8eQ1S+tzAZ5iQ==
Received: from smtp (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B605019730000>; Tue, 16 Mar 2021 15:35:31 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by smtp (Postfix) with ESMTP id 2780613EED0;
        Tue, 16 Mar 2021 15:35:45 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 4E45A284092; Tue, 16 Mar 2021 15:35:31 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     robh+dt@kernel.org, jdelvare@suse.com, linux@roeck-us.net
Cc:     devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH 2/2] hwmon: (pmbus): Add driver for BluTek BPA-RS600
Date:   Tue, 16 Mar 2021 15:35:24 +1300
Message-Id: <20210316023524.12574-2-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210316023524.12574-1-chris.packham@alliedtelesis.co.nz>
References: <20210316023524.12574-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=GfppYjfL c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=dESyimp9J3IA:10 a=eWWmYPuaAAAA:8 a=eqJHQH7iNzQl1GEjYHoA:9 a=GlNYzQxvk2U_gD8pBxfO:22
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BPA-RS600 is a compact 600W AC to DC removable power supply module.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 Documentation/hwmon/bpa-rs600.rst |  74 ++++++++++++
 drivers/hwmon/pmbus/Kconfig       |  10 ++
 drivers/hwmon/pmbus/Makefile      |   1 +
 drivers/hwmon/pmbus/bpa-rs600.c   | 179 ++++++++++++++++++++++++++++++
 4 files changed, 264 insertions(+)
 create mode 100644 Documentation/hwmon/bpa-rs600.rst
 create mode 100644 drivers/hwmon/pmbus/bpa-rs600.c

diff --git a/Documentation/hwmon/bpa-rs600.rst b/Documentation/hwmon/bpa-=
rs600.rst
new file mode 100644
index 000000000000..28313995d4ae
--- /dev/null
+++ b/Documentation/hwmon/bpa-rs600.rst
@@ -0,0 +1,74 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Kernel driver bpa-rs600
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Supported chips:
+
+  * BPA-RS600-120
+
+    Datasheet: Publicly available at the BluTek website
+       http://blutekpower.com/wp-content/uploads/2019/01/BPA-RS600-120-0=
7-19-2018.pdf
+
+Authors:
+      - Chris Packham <chris.packham@alliedtelesis.co.nz>
+
+Description
+-----------
+
+The BPA-RS600 is a compact 600W removable power supply module.
+
+Usage Notes
+-----------
+
+This driver does not probe for PMBus devices. You will have to instantia=
te
+devices explicitly.
+
+Sysfs attributes
+----------------
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+curr1_label             "iin"
+curr1_input		Measured input current
+curr1_max		Maximum input current
+curr1_max_alarm		Input current high alarm
+
+curr2_label		"iout1"
+curr2_input		Measured output current
+curr2_max		Maximum output current
+curr2_max_alarm		Output current high alarm
+
+fan1_input		Measured fan speed
+fan1_alarm		Fan warning
+fan1_fault		Fan fault
+
+in1_label		"vin"
+in1_input		Measured input voltage
+in1_max			Maximum input voltage
+in1_max_alarm		Input voltage high alarm
+in1_min			Minimum input voltage
+in1_min_alarm		Input voltage low alarm
+
+in2_label		"vout1"
+in2_input		Measured output voltage
+in2_max			Maximum output voltage
+in2_max_alarm		Output voltage high alarm
+in2_min			Maximum output voltage
+in2_min_alarm		Output voltage low alarm
+
+power1_label		"pin"
+power1_input		Measured input power
+power1_alarm		Input power alarm
+power1_max		Maximum input power
+
+power2_label		"pout1"
+power2_input		Measured output power
+power2_max		Maximum output power
+power2_max_alarm	Output power high alarm
+
+temp1_input		Measured temperature around input connector
+temp1_alarm		Temperature alarm
+
+temp2_input		Measured temperature around output connector
+temp2_alarm		Temperature alarm
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
index 32d2fc850621..d1f0f1cd8247 100644
--- a/drivers/hwmon/pmbus/Kconfig
+++ b/drivers/hwmon/pmbus/Kconfig
@@ -56,6 +56,16 @@ config SENSORS_BEL_PFE
 	  This driver can also be built as a module. If so, the module will
 	  be called bel-pfe.
=20
+config SENSORS_BPA_RS600
+	tristate "BluTek BPD-RS600 Power Supplies"
+	help
+	  If you say yes here you get hardware monitoring support for BluTek
+	  BPD-RS600 Power Supplies.
+
+	  This driver can also be built as a module. If so, the module will
+	  be called bpd-rs600.
+
+
 config SENSORS_IBM_CFFPS
 	tristate "IBM Common Form Factor Power Supply"
 	depends on LEDS_CLASS
diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
index 6a4ba0fdc1db..80a437060dc4 100644
--- a/drivers/hwmon/pmbus/Makefile
+++ b/drivers/hwmon/pmbus/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_SENSORS_PMBUS)	+=3D pmbus.o
 obj-$(CONFIG_SENSORS_ADM1266)	+=3D adm1266.o
 obj-$(CONFIG_SENSORS_ADM1275)	+=3D adm1275.o
 obj-$(CONFIG_SENSORS_BEL_PFE)	+=3D bel-pfe.o
+obj-$(CONFIG_SENSORS_BPA_RS600)	+=3D bpa-rs600.o
 obj-$(CONFIG_SENSORS_IBM_CFFPS)	+=3D ibm-cffps.o
 obj-$(CONFIG_SENSORS_INSPUR_IPSPS) +=3D inspur-ipsps.o
 obj-$(CONFIG_SENSORS_IR35221)	+=3D ir35221.o
diff --git a/drivers/hwmon/pmbus/bpa-rs600.c b/drivers/hwmon/pmbus/bpa-rs=
600.c
new file mode 100644
index 000000000000..94cbf42816f0
--- /dev/null
+++ b/drivers/hwmon/pmbus/bpa-rs600.c
@@ -0,0 +1,179 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Hardware monitoring driver for BluTek BPA-RS600 Power Supplies
+ *
+ * Copyright 2021 Allied Telesis Labs
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/i2c.h>
+#include <linux/pmbus.h>
+#include "pmbus.h"
+
+#define BPARS600_MFR_VIN_MIN	0xa0
+#define BPARS600_MFR_VIN_MAX	0xa1
+#define BPARS600_MFR_IIN_MAX	0xa2
+#define BPARS600_MFR_PIN_MAX	0xa3
+#define BPARS600_MFR_VOUT_MIN	0xa4
+#define BPARS600_MFR_VOUT_MAX	0xa5
+#define BPARS600_MFR_IOUT_MAX	0xa6
+#define BPARS600_MFR_POUT_MAX	0xa7
+
+static int bpa_rs600_read_byte_data(struct i2c_client *client, int page,
+				    int reg)
+{
+	int ret;
+
+	if (page > 0)
+		return -ENXIO;
+
+	switch (reg) {
+	case PMBUS_FAN_CONFIG_12:
+		ret =3D pmbus_read_byte_data(client, 0,
+					   PMBUS_FAN_CONFIG_12);
+		if (ret >=3D 0)
+			ret &=3D ~(PB_FAN_2_INSTALLED | PB_FAN_2_PULSE_MASK);
+		break;
+	default:
+		ret =3D -ENODATA;
+		break;
+	}
+
+	return ret;
+}
+
+static int bpa_rs600_read_word_data(struct i2c_client *client, int page,
+		int phase, int reg)
+{
+	int ret;
+
+	if (page > 0)
+		return -ENXIO;
+
+	switch (reg) {
+	case PMBUS_VIN_UV_FAULT_LIMIT:
+	case PMBUS_VIN_OV_FAULT_LIMIT:
+	case PMBUS_VOUT_UV_FAULT_LIMIT:
+	case PMBUS_VOUT_OV_FAULT_LIMIT:
+		ret =3D -ENXIO;
+		break;
+	case PMBUS_VIN_UV_WARN_LIMIT:
+		ret =3D pmbus_read_word_data(client, 0, 0xff,
+					   BPARS600_MFR_VIN_MIN);
+		break;
+	case PMBUS_VIN_OV_WARN_LIMIT:
+		ret =3D pmbus_read_word_data(client, 0, 0xff,
+					   BPARS600_MFR_VIN_MAX);
+		break;
+	case PMBUS_VOUT_UV_WARN_LIMIT:
+		ret =3D pmbus_read_word_data(client, 0, 0xff,
+					   BPARS600_MFR_VOUT_MIN);
+		break;
+	case PMBUS_VOUT_OV_WARN_LIMIT:
+		ret =3D pmbus_read_word_data(client, 0, 0xff,
+					   BPARS600_MFR_VOUT_MAX);
+		break;
+	case PMBUS_IIN_OC_WARN_LIMIT:
+		ret =3D pmbus_read_word_data(client, 0, 0xff,
+					   BPARS600_MFR_IIN_MAX);
+		break;
+	case PMBUS_IOUT_OC_WARN_LIMIT:
+		ret =3D pmbus_read_word_data(client, 0, 0xff,
+					   BPARS600_MFR_IOUT_MAX);
+		break;
+	case PMBUS_PIN_OP_WARN_LIMIT:
+		ret =3D pmbus_read_word_data(client, 0, 0xff,
+					   BPARS600_MFR_PIN_MAX);
+		break;
+	case PMBUS_POUT_OP_WARN_LIMIT:
+		ret =3D pmbus_read_word_data(client, 0, 0xff,
+					   BPARS600_MFR_POUT_MAX);
+		break;
+	default:
+		if (reg >=3D PMBUS_VIRT_BASE)
+			ret =3D -ENXIO;
+		else
+			ret =3D -ENODATA;
+		break;
+	}
+
+	return ret;
+}
+
+static struct pmbus_driver_info bpa_rs600_info =3D {
+	.pages =3D 1,
+	.format[PSC_VOLTAGE_IN] =3D linear,
+	.format[PSC_VOLTAGE_OUT] =3D linear,
+	.format[PSC_CURRENT_IN] =3D linear,
+	.format[PSC_CURRENT_OUT] =3D linear,
+	.format[PSC_POWER] =3D linear,
+	.format[PSC_TEMPERATURE] =3D linear,
+	.format[PSC_FAN] =3D linear,
+	.func[0] =3D PMBUS_HAVE_VIN | PMBUS_HAVE_VOUT |
+		PMBUS_HAVE_IIN | PMBUS_HAVE_IOUT |
+		PMBUS_HAVE_PIN | PMBUS_HAVE_POUT |
+		PMBUS_HAVE_TEMP | PMBUS_HAVE_TEMP2 |
+		PMBUS_HAVE_FAN12 |
+		PMBUS_HAVE_STATUS_VOUT | PMBUS_HAVE_STATUS_IOUT |
+		PMBUS_HAVE_STATUS_INPUT | PMBUS_HAVE_STATUS_TEMP |
+		PMBUS_HAVE_STATUS_FAN12,
+	.read_byte_data =3D bpa_rs600_read_byte_data,
+	.read_word_data =3D bpa_rs600_read_word_data,
+};
+
+static int bpa_rs600_probe(struct i2c_client *client)
+{
+	struct device *dev =3D &client->dev;
+	u8 buf[I2C_SMBUS_BLOCK_MAX];
+	int ret;
+
+	if (!i2c_check_functionality(client->adapter,
+				     I2C_FUNC_SMBUS_READ_BYTE_DATA
+				     | I2C_FUNC_SMBUS_READ_WORD_DATA
+				     | I2C_FUNC_SMBUS_READ_BLOCK_DATA))
+		return -ENODEV;
+
+
+	ret =3D i2c_smbus_read_block_data(client, PMBUS_MFR_MODEL, buf);
+	if (ret < 0) {
+		dev_err(dev, "Failed to read Manufacturer Model\n");
+		return ret;
+	}
+
+	if (strncmp(buf, "BPA-RS600", 8)) {
+		buf[ret] =3D '\0';
+		dev_err(dev, "Unsupported Manufacturer Model '%s'\n", buf);
+		return -ENODEV;
+	}
+
+	return pmbus_do_probe(client, &bpa_rs600_info);
+}
+
+static const struct i2c_device_id bpa_rs600_id[] =3D {
+	{ "bpa_rs600", 0 },
+	{},
+};
+MODULE_DEVICE_TABLE(i2c, bpa_rs600_id);
+
+static const struct of_device_id __maybe_unused bpa_rs600_of_match[] =3D=
 {
+	{ .compatible =3D "blutek,bpa-rs600" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, bpa_rs600_of_match);
+
+static struct i2c_driver bpa_rs600_driver =3D {
+	.driver =3D {
+		.name =3D "bpa-rs600",
+		.of_match_table =3D of_match_ptr(bpa_rs600_of_match),
+	},
+	.probe_new =3D bpa_rs600_probe,
+	.id_table =3D bpa_rs600_id,
+};
+
+module_i2c_driver(bpa_rs600_driver);
+
+MODULE_AUTHOR("Chris Packham");
+MODULE_DESCRIPTION("PMBus driver for BluTek BPA-RS600");
+MODULE_LICENSE("GPL");
--=20
2.30.2

