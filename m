Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD4F36FA59
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 14:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbhD3MgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 08:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbhD3MgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 08:36:12 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF62DC06138B
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 05:35:22 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a4so11641091ejk.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 05:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EFs7L5e2ICQbQU3zEtC2UFHPBcpNTWgH/d2niDhfdDA=;
        b=qG3u5EKd3EYArbSxfgXycYhJUwLsuX679AjHs+5XsDAsvr6Vqu+QZdiweWYTUV/SUp
         n/ti64M+rZfKLgt7lFLdaxJGDIkcNe4k3UxlfHBetmc4K1QYOa93XsHmhLb+mPFwJ2ck
         hsFqMenR9of1JAR7FpY18XoEzHCljmNCNKO4ucxxSdHLCq9V8ZnJSu6qd3Z/pqw9TGOK
         ev3t4piRFQqx1uzhFqYHptpGcCHyVFbDtireqvdBoBW2t5DaKQjCt3dLlvHNTWNtp5bv
         4AyHp7vNqbGNFeqfxJtxVaaHaOoSYbUipmfO8w3p4hlXI1D60VpfJp32Yl0a6kDL+gtv
         inKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EFs7L5e2ICQbQU3zEtC2UFHPBcpNTWgH/d2niDhfdDA=;
        b=NxEL8ylLcihGGoc5/chwAK2NSRdyU2lbJqWepB4vYxr4WSGyXDmSpTN+yESnkWA/Ui
         n+xlyXuCJm4B2+V3fDtpHls1YHh/nievh/M6sgGRuL5LY20Ddp4B8zFtCVz043fIAaY0
         IwjjujIX/rkscNHtdpyDXCLnt4//9vQwx4qQdMs5xQCdLJB9cLqkFFbPJvYKozB8wUri
         EUgLGMfaioIIqPt7UGn0iPcsZ8sky+rfOGGii3gnMhBC0Kv0TxALATvH3yOTEBKOkByL
         clHUHmIjD/os8eimyaAJsYFQsS3dGYFffO+jw04aSm+tlCn8kM33IZ3XXhU55Fk0qUf4
         VMhw==
X-Gm-Message-State: AOAM530tPcEZ6/qbB5TRHt2Tn9V8c3Y8IXjp2iG+jONRTtngzU8m3UGN
        7cItFYUFFGIMdoZSCJ0E7VrEIQ==
X-Google-Smtp-Source: ABdhPJxp7LwL0cFAMV0aJSYBcj3ZbLngIAwieRg6R3F+waTsfcY0hjwoD8vTJt5PnnWArMrsntnGkw==
X-Received: by 2002:a17:906:3f88:: with SMTP id b8mr4195085ejj.36.1619786121639;
        Fri, 30 Apr 2021 05:35:21 -0700 (PDT)
Received: from localhost.localdomain (dh207-97-15.xnet.hr. [88.207.97.15])
        by smtp.googlemail.com with ESMTPSA id d15sm1822988ejj.42.2021.04.30.05.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 05:35:21 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     lee.jones@linaro.org, robh+dt@kernel.org, linus.walleij@linaro.org,
        bgolaszewski@baylibre.com, jdelvare@suse.com, linux@roeck-us.net,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-hwmon@vger.kernel.org
Cc:     luka.perkov@sartura.hr, jmp@epiphyte.org, pmenzel@molgen.mpg.de,
        buczek@molgen.mpg.de, Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH 1/6] mfd: Add Delta TN48M CPLD driver
Date:   Fri, 30 Apr 2021 14:35:06 +0200
Message-Id: <20210430123511.116057-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delta TN48M switches have a Lattice CPLD that serves
multiple purposes including being a GPIO expander.
So lets add the MFD core driver for it.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 drivers/mfd/Kconfig       |  13 +++
 drivers/mfd/Makefile      |   1 +
 drivers/mfd/tn48m-cpld.c  | 181 ++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/tn48m.h |  30 +++++++
 4 files changed, 225 insertions(+)
 create mode 100644 drivers/mfd/tn48m-cpld.c
 create mode 100644 include/linux/mfd/tn48m.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index b74efa469e90..809041f98d71 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -297,6 +297,19 @@ config MFD_ASIC3
 	  This driver supports the ASIC3 multifunction chip found on many
 	  PDAs (mainly iPAQ and HTC based ones)
 
+config MFD_TN48M_CPLD
+	tristate "Delta Networks TN48M switch CPLD driver"
+	depends on I2C
+	select MFD_CORE
+	select REGMAP_I2C
+	help
+	  Select this option to enable support for Delta Networks TN48M switch
+	  CPLD. It consists of GPIO and hwmon drivers.
+	  CPLD provides GPIOS-s for the SFP slots as well as power supply
+	  related information.
+	  Driver provides debugfs information about the board model as
+	  well as hardware and CPLD revision information.
+
 config PMIC_DA903X
 	bool "Dialog Semiconductor DA9030/DA9034 PMIC Support"
 	depends on I2C=y
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 834f5463af28..974663341f08 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -27,6 +27,7 @@ obj-$(CONFIG_MFD_TI_LP87565)	+= lp87565.o
 obj-$(CONFIG_MFD_DAVINCI_VOICECODEC)	+= davinci_voicecodec.o
 obj-$(CONFIG_MFD_DM355EVM_MSP)	+= dm355evm_msp.o
 obj-$(CONFIG_MFD_TI_AM335X_TSCADC)	+= ti_am335x_tscadc.o
+obj-$(CONFIG_MFD_TN48M_CPLD)	+= tn48m-cpld.o
 
 obj-$(CONFIG_MFD_STA2X11)	+= sta2x11-mfd.o
 obj-$(CONFIG_MFD_STMPE)		+= stmpe.o
diff --git a/drivers/mfd/tn48m-cpld.c b/drivers/mfd/tn48m-cpld.c
new file mode 100644
index 000000000000..b84510fb630a
--- /dev/null
+++ b/drivers/mfd/tn48m-cpld.c
@@ -0,0 +1,181 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Delta TN48M CPLD parent driver
+ *
+ * Copyright 2020 Sartura Ltd
+ *
+ * Author: Robert Marko <robert.marko@sartura.hr>
+ */
+
+#include <linux/debugfs.h>
+#include <linux/i2c.h>
+#include <linux/kernel.h>
+#include <linux/mfd/core.h>
+#include <linux/mfd/tn48m.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+
+static const struct mfd_cell tn48m_cell[] = {};
+
+static const struct regmap_config tn48m_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = 0x40,
+};
+
+static int hardware_version_show(struct seq_file *s, void *data)
+{
+	struct tn48m_data *priv = s->private;
+	unsigned int regval;
+	char *buf;
+
+	regmap_read(priv->regmap, HARDWARE_VERSION_ID, &regval);
+
+	switch (FIELD_GET(HARDWARE_VERSION_MASK, regval)) {
+	case HARDWARE_VERSION_EVT1:
+		buf = "EVT1";
+		break;
+	case HARDWARE_VERSION_EVT2:
+		buf = "EVT2";
+		break;
+	case HARDWARE_VERSION_DVT:
+		buf = "DVT";
+		break;
+	case HARDWARE_VERSION_PVT:
+		buf = "PVT";
+		break;
+	default:
+		buf = "Unknown";
+		break;
+	}
+
+	seq_printf(s, "%s\n", buf);
+
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(hardware_version);
+
+static int board_id_show(struct seq_file *s, void *data)
+{
+	struct tn48m_data *priv = s->private;
+	unsigned int regval;
+	char *buf;
+
+	regmap_read(priv->regmap, BOARD_ID, &regval);
+
+	switch (regval) {
+	case BOARD_ID_TN48M:
+		buf = "TN48M";
+		break;
+	case BOARD_ID_TN48M_P:
+		buf = "TN48-P";
+		break;
+	default:
+		buf = "Unknown";
+		break;
+	}
+
+	seq_printf(s, "%s\n", buf);
+
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(board_id);
+
+static int code_version_show(struct seq_file *s, void *data)
+{
+	struct tn48m_data *priv = s->private;
+	unsigned int regval;
+
+	regmap_read(priv->regmap, CPLD_CODE_VERSION, &regval);
+
+	seq_printf(s, "%d\n", regval);
+
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(code_version);
+
+static void tn48m_init_debugfs(struct tn48m_data *data)
+{
+	data->debugfs_dir = debugfs_create_dir(data->client->name, NULL);
+
+	debugfs_create_file("hardware_version",
+			    0400,
+			    data->debugfs_dir,
+			    data,
+			    &hardware_version_fops);
+
+	debugfs_create_file("board_id",
+			    0400,
+			    data->debugfs_dir,
+			    data,
+			    &board_id_fops);
+
+	debugfs_create_file("code_version",
+			    0400,
+			    data->debugfs_dir,
+			    data,
+			    &code_version_fops);
+}
+
+static int tn48m_probe(struct i2c_client *client)
+{
+	struct tn48m_data *data;
+	int ret;
+
+	data = devm_kzalloc(&client->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->client = client;
+	data->dev = &client->dev;
+	i2c_set_clientdata(client, data);
+
+	data->regmap = devm_regmap_init_i2c(client, &tn48m_regmap_config);
+	if (IS_ERR(data->regmap)) {
+		dev_err(data->dev, "Failed to allocate regmap\n");
+		return PTR_ERR(data->regmap);
+	}
+
+	ret = devm_mfd_add_devices(data->dev, PLATFORM_DEVID_AUTO, tn48m_cell,
+				   ARRAY_SIZE(tn48m_cell), NULL, 0, NULL);
+	if (ret)
+		dev_err(data->dev, "Failed to register sub-devices %d\n", ret);
+
+	tn48m_init_debugfs(data);
+
+	return ret;
+}
+
+static int tn48m_remove(struct i2c_client *client)
+{
+	struct tn48m_data *data = i2c_get_clientdata(client);
+
+	debugfs_remove_recursive(data->debugfs_dir);
+
+	return 0;
+}
+
+static const struct of_device_id tn48m_of_match[] = {
+	{ .compatible = "delta,tn48m-cpld"},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, tn48m_of_match);
+
+static struct i2c_driver tn48m_driver = {
+	.driver = {
+		.name = "tn48m-cpld",
+		.of_match_table = tn48m_of_match,
+	},
+	.probe_new	= tn48m_probe,
+	.remove		= tn48m_remove,
+};
+module_i2c_driver(tn48m_driver);
+
+MODULE_AUTHOR("Robert Marko <robert.marko@sartura.hr>");
+MODULE_DESCRIPTION("Delta TN48M CPLD parent driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/mfd/tn48m.h b/include/linux/mfd/tn48m.h
new file mode 100644
index 000000000000..551c550efa54
--- /dev/null
+++ b/include/linux/mfd/tn48m.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright 2020 Sartura Ltd
+ */
+
+#ifndef __TN48M_H__
+#define __TN48M_H__
+
+#include <linux/device.h>
+#include <linux/regmap.h>
+
+#define HARDWARE_VERSION_ID	0x0
+#define HARDWARE_VERSION_MASK	GENMASK(3, 0)
+#define HARDWARE_VERSION_EVT1	0
+#define HARDWARE_VERSION_EVT2	1
+#define HARDWARE_VERSION_DVT	2
+#define HARDWARE_VERSION_PVT	3
+#define BOARD_ID		0x1
+#define BOARD_ID_TN48M		0xa
+#define BOARD_ID_TN48M_P	0xb
+#define CPLD_CODE_VERSION	0x2
+
+struct tn48m_data {
+	struct device *dev;
+	struct regmap *regmap;
+	struct i2c_client *client;
+	struct dentry *debugfs_dir;
+};
+
+#endif
-- 
2.31.1

