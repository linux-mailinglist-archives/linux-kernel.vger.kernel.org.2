Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2DD23E7C64
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 17:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243362AbhHJPfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 11:35:34 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:34984 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243298AbhHJPfK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 11:35:10 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 79F3D467A1;
        Tue, 10 Aug 2021 15:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1628609683; x=1630424084; bh=AivYNDMzDMm3bvnJcjBWh/FPaETWiSzReQt
        QNoQ9vcQ=; b=LbMpZMXJULlzSoSyOfmfjDGWvAJowItBn1cKRTqdLikLnoyXMql
        JHcLgp9dmrVW5RcVcaai9xovbHlrtgP6Xc84hJqJNH8XHvG+AQFlQafPdSCJzi8p
        W856c1zMf+3aijgSA2LgsEN4cV1pqH5k8MAF5yjzR4Xi4darD67KoKgk=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Zh4kXMivqSLS; Tue, 10 Aug 2021 18:34:43 +0300 (MSK)
Received: from T-EXCH-04.corp.yadro.com (t-exch-04.corp.yadro.com [172.17.100.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 0F822412DE;
        Tue, 10 Aug 2021 18:34:43 +0300 (MSK)
Received: from fedora.bbmc.yadro.com (10.199.0.188) by
 T-EXCH-04.corp.yadro.com (172.17.100.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Tue, 10 Aug 2021 18:34:39 +0300
From:   Ivan Mikhaylov <i.mikhaylov@yadro.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     Ivan Mikhaylov <i.mikhaylov@yadro.com>,
        <linux-kernel@vger.kernel.org>, <openbmc@lists.ozlabs.org>
Subject: [PATCH 1/2] rtc: pch-rtc: add RTC driver for Intel Series PCH
Date:   Tue, 10 Aug 2021 18:44:35 +0300
Message-ID: <20210810154436.125678-2-i.mikhaylov@yadro.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210810154436.125678-1-i.mikhaylov@yadro.com>
References: <20210810154436.125678-1-i.mikhaylov@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.199.0.188]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-04.corp.yadro.com (172.17.100.104)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the Intel Series PCH built-in read-only RTC. This driver is not for
in-system use on x86 but rather is for external access over I2C from a BMC.

Signed-off-by: Ivan Mikhaylov <i.mikhaylov@yadro.com>
---
 drivers/rtc/Kconfig   |  10 +++
 drivers/rtc/Makefile  |   1 +
 drivers/rtc/rtc-pch.c | 148 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 159 insertions(+)
 create mode 100644 drivers/rtc/rtc-pch.c

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 12153d5801ce..4f31bcbf0736 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -555,6 +555,16 @@ config RTC_DRV_PALMAS
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-palma.
 
+config RTC_DRV_PCH
+	tristate "PCH RTC driver"
+	help
+	  If you say yes here you get support for the Intel Series PCH
+	  built-in read-only RTC. This driver is not for in-system use on x86,
+	  but rather is for external access over I2C from a BMC.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called rtc-pch.
+
 config RTC_DRV_TPS6586X
 	tristate "TI TPS6586X RTC driver"
 	depends on MFD_TPS6586X
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index 2dd0dd956b0e..cb2804433d87 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -121,6 +121,7 @@ obj-$(CONFIG_RTC_DRV_PCF8523)	+= rtc-pcf8523.o
 obj-$(CONFIG_RTC_DRV_PCF85363)	+= rtc-pcf85363.o
 obj-$(CONFIG_RTC_DRV_PCF8563)	+= rtc-pcf8563.o
 obj-$(CONFIG_RTC_DRV_PCF8583)	+= rtc-pcf8583.o
+obj-$(CONFIG_RTC_DRV_PCH)	+= rtc-pch.o
 obj-$(CONFIG_RTC_DRV_PIC32)	+= rtc-pic32.o
 obj-$(CONFIG_RTC_DRV_PL030)	+= rtc-pl030.o
 obj-$(CONFIG_RTC_DRV_PL031)	+= rtc-pl031.o
diff --git a/drivers/rtc/rtc-pch.c b/drivers/rtc/rtc-pch.c
new file mode 100644
index 000000000000..a2918257bf39
--- /dev/null
+++ b/drivers/rtc/rtc-pch.c
@@ -0,0 +1,148 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * I2C read-only RTC driver for PCH with additional sysfs attribute for host
+ * power control.
+ *
+ * Copyright (C) 2021 YADRO
+ */
+
+#include <linux/i2c.h>
+#include <linux/slab.h>
+#include <linux/rtc.h>
+#include <linux/bcd.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+
+#define PCH_REG_FORCE_OFF		0x00
+#define PCH_REG_SC			0x09
+#define PCH_REG_MN			0x0a
+#define PCH_REG_HR			0x0b
+#define PCH_REG_DW			0x0c
+#define PCH_REG_DM			0x0d
+#define PCH_REG_MO			0x0e
+#define PCH_REG_YR			0x0f
+
+#define NUM_TIME_REGS   (PCH_REG_YR - PCH_REG_SC + 1)
+
+struct pch {
+	struct rtc_device *rtc;
+	struct regmap *regmap;
+};
+
+static int pch_rtc_read_time(struct device *dev, struct rtc_time *tm)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct pch *pch = i2c_get_clientdata(client);
+	unsigned char rtc_data[NUM_TIME_REGS] = {0};
+	int rc;
+
+	rc = regmap_bulk_read(pch->regmap, PCH_REG_SC, rtc_data, NUM_TIME_REGS);
+	if (rc < 0) {
+		dev_err(dev, "fail to read time reg(%d)\n", rc);
+		return rc;
+	}
+
+	tm->tm_sec	= bcd2bin(rtc_data[0]);
+	tm->tm_min	= bcd2bin(rtc_data[1]);
+	tm->tm_hour	= bcd2bin(rtc_data[2]);
+	tm->tm_wday	= rtc_data[3];
+	tm->tm_mday	= bcd2bin(rtc_data[4]);
+	tm->tm_mon	= bcd2bin(rtc_data[5]) - 1;
+	tm->tm_year	= bcd2bin(rtc_data[6]) + 100;
+
+	return 0;
+}
+
+static ssize_t force_off_store(struct device *dev,
+			       struct device_attribute *attr,
+			       const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct pch *pch = i2c_get_clientdata(client);
+	unsigned long val;
+	int rc;
+
+	if (kstrtoul(buf, 10, &val))
+		return -EINVAL;
+
+	if (val) {
+		/* 0x02 host force off */
+		rc = regmap_write(pch->regmap, PCH_REG_FORCE_OFF, 0x2);
+		if (rc < 0) {
+			dev_err(dev, "Fail to read time reg(%d)\n", rc);
+			return rc;
+		}
+	}
+
+	return 0;
+}
+static DEVICE_ATTR_WO(force_off);
+
+static const struct rtc_class_ops pch_rtc_ops = {
+	.read_time = pch_rtc_read_time,
+};
+
+static const struct regmap_config pch_rtc_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.use_single_read = true,
+};
+
+static int pch_rtc_probe(struct i2c_client *client)
+{
+	struct pch *pch;
+	int rc;
+
+	pch = devm_kzalloc(&client->dev, sizeof(*pch), GFP_KERNEL);
+	if (!pch)
+		return -ENOMEM;
+
+	pch->regmap = devm_regmap_init_i2c(client, &pch_rtc_regmap_config);
+	if (IS_ERR(pch->regmap)) {
+		dev_err(&client->dev, "regmap_init failed\n");
+		return PTR_ERR(pch->regmap);
+	}
+
+	i2c_set_clientdata(client, pch);
+
+	pch->rtc = devm_rtc_device_register(&client->dev, "pch-rtc",
+					    &pch_rtc_ops, THIS_MODULE);
+	if (IS_ERR(pch->rtc)) {
+		dev_err(&client->dev, "rtc device register failed\n");
+		return PTR_ERR(pch->rtc);
+	}
+
+	rc = sysfs_create_file(&client->dev.kobj, &dev_attr_force_off.attr);
+	if (rc) {
+		dev_err(&client->dev, "couldn't create sysfs attr : %i\n", rc);
+		return rc;
+	}
+
+	return 0;
+}
+
+static int pch_rtc_remove(struct i2c_client *client)
+{
+	sysfs_remove_file(&client->dev.kobj, &dev_attr_force_off.attr);
+	return 0;
+}
+
+static const struct of_device_id pch_rtc_of_match[] = {
+	{ .compatible = "intel,pch-rtc", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, pch_rtc_of_match);
+
+static struct i2c_driver pch_rtc_driver = {
+	.driver		= {
+		.name	= "pch-rtc",
+		.of_match_table = pch_rtc_of_match,
+	},
+	.probe_new	= pch_rtc_probe,
+	.remove		= pch_rtc_remove,
+};
+module_i2c_driver(pch_rtc_driver);
+
+MODULE_DESCRIPTION("RTC PCH driver");
+MODULE_AUTHOR("Ivan Mikhaylov <i.mikhaylov@yadro.com>");
+MODULE_LICENSE("GPL");
-- 
2.31.1

