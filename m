Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECA034D281
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 16:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbhC2OjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 10:39:12 -0400
Received: from mail-ej1-f47.google.com ([209.85.218.47]:38653 "EHLO
        mail-ej1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbhC2Oik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 10:38:40 -0400
Received: by mail-ej1-f47.google.com with SMTP id r12so19842553ejr.5;
        Mon, 29 Mar 2021 07:38:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aN3CiSsEh4jbHSDVM4VOQL1SaLegEtHXJK8dn4OL0w8=;
        b=k9JUVphfUh1dpHKYfaj3Jpl4g+N1Bb9QTk2w0WfcFqS1xW2Z624ixHLvSF55fTiFwC
         h6BtwesO+8bwiiGUYha3GfJtF4IUZuRCJraQmlloWs5uCRSgGj9Kb4D5VHvS73yPSOdV
         hSinW3jWo86I/kTtzrNQ7C7s79509lytTLfunca6FIPaI8TYpzHUagTQtOMtMkOcopdF
         UW7Ywh7r4bX6VdJeB606YPKALM08Gg3kyYwnC6BqjnUeAiVxdqdnIK2V9kTcEvScM+eI
         BeVCNIipLJeEsy2hdXEIWubSbxa430YAPbEYfqJzexXf47EbCiVNkPB7kMgoA05mLPG0
         xjIQ==
X-Gm-Message-State: AOAM532doCZWoRNxVKNOzvn+qt98/N1kuN6TkBCQBQHrfOrQ83fc5VNQ
        pKhlLwRLEQ2haWrLigWA3Gk=
X-Google-Smtp-Source: ABdhPJzyt4sgZVd9a6FFLpiQYvzr58VKauNRgf8oCFjnSaGVHqN3zD3jhCEiNVETbADVkRF3yh406A==
X-Received: by 2002:a17:907:2809:: with SMTP id eb9mr28072940ejc.204.1617028718961;
        Mon, 29 Mar 2021 07:38:38 -0700 (PDT)
Received: from localhost ([2a02:8308:387:c900:a7b5:b859:9449:c07b])
        by smtp.gmail.com with ESMTPSA id bc16sm4735925edb.17.2021.03.29.07.38.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Mar 2021 07:38:38 -0700 (PDT)
From:   =?UTF-8?q?V=C3=A1clav=20Kubern=C3=A1t?= <kubernat@cesnet.cz>
Cc:     =?UTF-8?q?V=C3=A1clav=20Kubern=C3=A1t?= <kubernat@cesnet.cz>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Subject: [PATCH] hwmon: Add driver for fsp-3y PSUs and PDUs
Date:   Mon, 29 Mar 2021 16:38:31 +0200
Message-Id: <20210329143833.1047539-1-kubernat@cesnet.cz>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After some testing, I have found out there is a timing issue with this
device. After setting page, the device doesn't immediately react and
gives values from the previous page for some time. This is why there
needs to be a delay between pmbus_set_page and the actual read.

Also, a lot of the standard commands don't work with the devices, so
they are filtered out in the custom read function.

Signed-off-by: Václav Kubernát <kubernat@cesnet.cz>
---
 drivers/hwmon/pmbus/Kconfig  |   9 ++
 drivers/hwmon/pmbus/Makefile |   1 +
 drivers/hwmon/pmbus/fsp-3y.c | 164 +++++++++++++++++++++++++++++++++++
 3 files changed, 174 insertions(+)
 create mode 100644 drivers/hwmon/pmbus/fsp-3y.c

diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
index 03606d4298a4..66d1655b6750 100644
--- a/drivers/hwmon/pmbus/Kconfig
+++ b/drivers/hwmon/pmbus/Kconfig
@@ -56,6 +56,15 @@ config SENSORS_BEL_PFE
 	  This driver can also be built as a module. If so, the module will
 	  be called bel-pfe.
 
+config SENSORS_FSP_3Y
+	tristate "FSP/3Y-Power power supplies"
+	help
+	  If you say yes here you get hardware monitoring support for
+	  FSP/3Y-Power hot-swap power supplies.
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
index 000000000000..7f3c3de3a1e6
--- /dev/null
+++ b/drivers/hwmon/pmbus/fsp-3y.c
@@ -0,0 +1,164 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Hardware monitoring driver for FSP 3Y-Power PSUs
+ *
+ * Copyright (c) 2021 Václav Kubernát, CESNET
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include "pmbus.h"
+
+#define YM2151_PAGE_12V		0x00
+#define YM2151_PAGE_5V		0x20
+#define YH5151E_PAGE_12V	0x00
+#define YH5151E_PAGE_5V		0x10
+#define YH5151E_PAGE_3V3	0x11
+
+enum chips {
+	ym2151e,
+	yh5151e
+};
+
+static int set_page(struct i2c_client *client, int page)
+{
+	int rv;
+
+	rv = i2c_smbus_read_byte_data(client, PMBUS_PAGE);
+
+	if (rv < 0)
+		return rv;
+
+	if (rv != page) {
+		rv = pmbus_set_page(client, page, 0xff);
+		if (rv < 0)
+			return rv;
+
+		msleep(20);
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
+	if (reg >= PMBUS_VIRT_BASE)
+		return -ENXIO;
+
+	switch (reg) {
+	case PMBUS_OT_WARN_LIMIT:
+	case PMBUS_OT_FAULT_LIMIT:
+	case PMBUS_UT_WARN_LIMIT:
+	case PMBUS_UT_FAULT_LIMIT:
+	case PMBUS_VIN_UV_WARN_LIMIT:
+	case PMBUS_VIN_UV_FAULT_LIMIT:
+	case PMBUS_VIN_OV_FAULT_LIMIT:
+	case PMBUS_VIN_OV_WARN_LIMIT:
+	case PMBUS_IOUT_OC_WARN_LIMIT:
+	case PMBUS_IOUT_UC_FAULT_LIMIT:
+	case PMBUS_IOUT_OC_FAULT_LIMIT:
+	case PMBUS_IIN_OC_WARN_LIMIT:
+	case PMBUS_IIN_OC_FAULT_LIMIT:
+	case PMBUS_VOUT_UV_WARN_LIMIT:
+	case PMBUS_VOUT_UV_FAULT_LIMIT:
+	case PMBUS_VOUT_OV_WARN_LIMIT:
+	case PMBUS_VOUT_OV_FAULT_LIMIT:
+	case PMBUS_MFR_VIN_MIN:
+	case PMBUS_MFR_VIN_MAX:
+	case PMBUS_MFR_IIN_MAX:
+	case PMBUS_MFR_VOUT_MIN:
+	case PMBUS_MFR_VOUT_MAX:
+	case PMBUS_MFR_IOUT_MAX:
+	case PMBUS_MFR_PIN_MAX:
+	case PMBUS_POUT_MAX:
+	case PMBUS_POUT_OP_WARN_LIMIT:
+	case PMBUS_POUT_OP_FAULT_LIMIT:
+	case PMBUS_MFR_MAX_TEMP_1:
+	case PMBUS_MFR_MAX_TEMP_2:
+	case PMBUS_MFR_MAX_TEMP_3:
+	case PMBUS_MFR_POUT_MAX:
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
+		.pages = 0x21,
+		.func[YM2151_PAGE_12V] =
+			PMBUS_HAVE_VOUT | PMBUS_HAVE_IOUT |
+			PMBUS_HAVE_PIN | PMBUS_HAVE_POUT  |
+			PMBUS_HAVE_TEMP | PMBUS_HAVE_TEMP2 |
+			PMBUS_HAVE_VIN | PMBUS_HAVE_IIN |
+			PMBUS_HAVE_FAN12,
+		.func[YM2151_PAGE_5V] =
+			PMBUS_HAVE_VOUT | PMBUS_HAVE_IOUT,
+			PMBUS_HAVE_IIN,
+		.read_word_data = fsp3y_read_word_data,
+		.read_byte_data = fsp3y_read_byte_data,
+	},
+	[yh5151e] = {
+		.pages = 0x12,
+		.func[YH5151E_PAGE_12V] =
+			PMBUS_HAVE_VOUT | PMBUS_HAVE_IOUT |
+			PMBUS_HAVE_POUT  |
+			PMBUS_HAVE_TEMP | PMBUS_HAVE_TEMP2 | PMBUS_HAVE_TEMP3,
+		.func[YH5151E_PAGE_5V] =
+			PMBUS_HAVE_VOUT | PMBUS_HAVE_IOUT |
+			PMBUS_HAVE_POUT,
+		.func[YH5151E_PAGE_3V3] =
+			PMBUS_HAVE_VOUT | PMBUS_HAVE_IOUT |
+			PMBUS_HAVE_POUT,
+		.read_word_data = fsp3y_read_word_data,
+		.read_byte_data = fsp3y_read_byte_data,
+	}
+};
+
+static int fsp3y_probe(struct i2c_client *client,
+		       const struct i2c_device_id *id)
+{
+	return pmbus_do_probe(client, &fsp3y_info[id->driver_data]);
+}
+
+static const struct i2c_device_id pmbus_id[] = {
+	{"fsp3y_ym2151e", ym2151e},
+	{"fsp3y_yh5151e", yh5151e},
+	{}
+};
+
+MODULE_DEVICE_TABLE(i2c, pmbus_id);
+
+/* This is the driver that will be inserted */
+static struct i2c_driver fsp3y_driver = {
+	.driver = {
+		   .name = "fsp3y",
+		   },
+	.probe = fsp3y_probe,
+	.id_table = pmbus_id
+};
+
+module_i2c_driver(fsp3y_driver);
+
+MODULE_AUTHOR("Václav Kubernát");
+MODULE_DESCRIPTION("PMBus driver for FSP/3Y-Power power supplies");
+MODULE_LICENSE("GPL");
-- 
2.31.1

