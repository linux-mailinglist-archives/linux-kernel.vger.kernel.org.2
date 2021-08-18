Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 412433F17D6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 13:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238449AbhHSLQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 07:16:51 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:57183 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238465AbhHSLQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 07:16:45 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 001A55C0076;
        Thu, 19 Aug 2021 07:16:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 19 Aug 2021 07:16:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=pyVtUnZYzGrcH
        1g1RkGLXUcs/0mV92qZW3HWmcKlct4=; b=HeS/Jp8PsFo6dXD0Iv+NeaX/aYqy3
        tNlHMO66L2KVZvIRTnCZoMtieio5LGyk+HXP9vhjZ0/e9EoOLyydgoC51y1jENud
        3/55GOu8deRsM18TvNjYfS+wZeOV6t9PMyNefy/CGu7WF3EahRpFcTYvPz2nMH8/
        0+XvQk5syPiSYaLMbMlNh3wl5upJ1e2nYhHY5hMq/0Qs6zW3xNQ1Qlp6haX00BJ5
        kLvvb+yQyswRbXKCJtnYpbwiP4+tvIImUcTy+jkS+swP7Kx3qq4ZL4+kektnX5rT
        2wJAJfdlpcRRbuUA/EyUMY32M+on8pcgBq1lGagO+2njBbxMr4gpDIgzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=pyVtUnZYzGrcH1g1RkGLXUcs/0mV92qZW3HWmcKlct4=; b=V1No3on0
        tbkDFYCbCyo/vKR207JcIG5k8dbvP/Ae4seaYrVQJEBK4m72xGQ9hdFoSROwnSaG
        kZrgOTEp7zzGrdeifedxOcSGPnSKRVqMwJSKCxmhXfNeWqyDySLv6OtvubtQx/hH
        JgyY3dbGGfmwjSiU4rKirx/MBd2fQvcRrY145/tsRBvHVy6xvzVAgTSyBiYfQ01E
        vpf1tcRQyj36Xczuxa4uS3yO77BiVWW2V6iNzjxaSo6oOo07BnRLi8ltfNY+d9EI
        Sg0Plf+/GtphOb7zdYw2dbJWCN+qka3ZC0M1sag3mgMO8uByr8pi+9WpGss9pquB
        j3qK6nUmig+/sw==
X-ME-Sender: <xms:eD0eYS46z65gqzETfWgvdx0ln7zvvzMD1938aDADOAiuDpi4ikT4Nw>
    <xme:eD0eYb4132rk2sNPNAQrX4dL_X3gwPG9h033e-w1hXrBz_fdkfJx4vNbiUcCLP8Y3
    Nq2-yNEleikdbISo3A>
X-ME-Received: <xmr:eD0eYRfu2lENROcZGMfkpHAnjmzH3zCJB7GbW_ibkcmaN5kR6m5FZ2aNuzmMjSmeYhf9mQlXvjWiIvxMV2wRuEbMtx4jaH7t6wnCG7AmY9x-zUFwXg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrleejgdefiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepheffjeetteetke
    ffhfdvgefhgeevvddvueejheehfeevfedufeegiedtheeujeelnecuffhomhgrihhnpehr
    vghmrghrkhgrsghlvgdrtghomhenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlihhsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:eD0eYfJ1N0DeLNDD6LcXLXTQRpBeyGDNn0_pIOxowNhTzWJW9rarfQ>
    <xmx:eD0eYWJo8P5uomz-ACO0hwGyBRqryvZ9Mu3-kN0mDIEFKWGfiTwMMw>
    <xmx:eD0eYQwaY0EYpA04u0rJa8tsQ_YC5ZjiEpIy0PhjaxiPGLjKgxSqxg>
    <xmx:eD0eYXqrmW2i4xoBAVUneAV8TBkwFDEQeHDAkdNGFeRAKtUhcB9YGw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Aug 2021 07:16:05 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v11 05/10] thermal: sy7636a: Add thermal driver for sy7636a
Date:   Thu, 19 Aug 2021 01:44:44 +1000
Message-Id: <20210818154449.1037-6-alistair@alistair23.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210818154449.1037-1-alistair@alistair23.me>
References: <20210818154449.1037-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add thermal driver to enable kernel based polling
and shutdown of device for temperatures out of spec

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 drivers/thermal/Kconfig           |  6 ++
 drivers/thermal/Makefile          |  1 +
 drivers/thermal/sy7636a_thermal.c | 94 +++++++++++++++++++++++++++++++
 3 files changed, 101 insertions(+)
 create mode 100644 drivers/thermal/sy7636a_thermal.c

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index d7f44deab5b1..6ee0e7de1b37 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -450,6 +450,12 @@ depends on (ARCH_STI || ARCH_STM32) && OF
 source "drivers/thermal/st/Kconfig"
 endmenu
 
+config SY7636A_THERMAL
+	tristate "SY7636A thermal management"
+	help
+	  Enable the sy7636a thermal driver, which supports the
+	  temperature sensor embedded in Silabs SY7636A IC.
+
 source "drivers/thermal/tegra/Kconfig"
 
 config GENERIC_ADC_THERMAL
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index 82fc3e616e54..2e1aca8a0a09 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -51,6 +51,7 @@ obj-$(CONFIG_DA9062_THERMAL)	+= da9062-thermal.o
 obj-y				+= intel/
 obj-$(CONFIG_TI_SOC_THERMAL)	+= ti-soc-thermal/
 obj-y				+= st/
+obj-$(CONFIG_SY7636A_THERMAL)	+= sy7636a_thermal.o
 obj-$(CONFIG_QCOM_TSENS)	+= qcom/
 obj-y				+= tegra/
 obj-$(CONFIG_HISI_THERMAL)     += hisi_thermal.o
diff --git a/drivers/thermal/sy7636a_thermal.c b/drivers/thermal/sy7636a_thermal.c
new file mode 100644
index 000000000000..9e58305ca3ce
--- /dev/null
+++ b/drivers/thermal/sy7636a_thermal.c
@@ -0,0 +1,94 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Functions to access SY3686A power management chip temperature
+ *
+ * Copyright (C) 2019 reMarkable AS - http://www.remarkable.com/
+ *
+ * Authors: Lars Ivar Miljeteig <lars.ivar.miljeteig@remarkable.com>
+ *          Alistair Francis <alistair@alistair23.me>
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/thermal.h>
+
+#include <linux/mfd/sy7636a.h>
+
+static int sy7636a_get_temp(void *arg, int *res)
+{
+	unsigned int mode_ctr;
+	int ret, reg_val;
+	struct regmap *regmap = arg;
+	bool isVoltageActive;
+
+	ret = regmap_read(regmap,
+			SY7636A_REG_OPERATION_MODE_CRL, &mode_ctr);
+	if (ret)
+		return ret;
+
+	isVoltageActive = mode_ctr & SY7636A_OPERATION_MODE_CRL_ONOFF;
+
+	/* If operation mode isn't set to control, then let's set it. */
+	if (!isVoltageActive) {
+		ret = regmap_write(regmap,
+				SY7636A_REG_OPERATION_MODE_CRL,
+				mode_ctr | SY7636A_OPERATION_MODE_CRL_ONOFF);
+		if (ret)
+			return ret;
+	}
+
+	ret = regmap_read(regmap,
+			SY7636A_REG_TERMISTOR_READOUT, &reg_val);
+	if (ret)
+		return ret;
+
+	/* Restore the operation mode if it wasn't set */
+	if (!isVoltageActive) {
+		ret = regmap_write(regmap,
+				SY7636A_REG_OPERATION_MODE_CRL,
+				mode_ctr);
+		if (ret)
+			return ret;
+	}
+
+	*res = reg_val * 1000;
+
+	return ret;
+}
+
+static const struct thermal_zone_of_device_ops ops = {
+	.get_temp	= sy7636a_get_temp,
+};
+
+static int sy7636a_thermal_probe(struct platform_device *pdev)
+{
+	struct regmap *regmap = dev_get_regmap(pdev->dev.parent, NULL);
+	struct thermal_zone_device *thermal_zone_dev;
+
+	thermal_zone_dev = devm_thermal_zone_of_sensor_register(
+			pdev->dev.parent,
+			0,
+			regmap,
+			&ops);
+
+	return PTR_ERR_OR_ZERO(thermal_zone_dev);
+}
+
+static const struct platform_device_id sy7636a_thermal_id_table[] = {
+	{ "sy7636a-thermal", },
+	{ }
+};
+MODULE_DEVICE_TABLE(platform, sy7636a_thermal_id_table);
+
+static struct platform_driver sy7636a_thermal_driver = {
+	.driver = {
+		.name = "sy7636a-thermal",
+	},
+	.probe = sy7636a_thermal_probe,
+	.id_table = sy7636a_thermal_id_table,
+};
+module_platform_driver(sy7636a_thermal_driver);
+
+MODULE_AUTHOR("Lars Ivar Miljeteig <lars.ivar.miljeteig@remarkable.com>");
+MODULE_DESCRIPTION("SY7636A thermal driver");
+MODULE_LICENSE("GPL v2");
-- 
2.31.1

