Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0B03E26E1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 11:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244286AbhHFJMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 05:12:10 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:49671 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244270AbhHFJL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 05:11:58 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 073E15C00D8;
        Fri,  6 Aug 2021 05:11:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 06 Aug 2021 05:11:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=Ak46xq3GXQE1n
        +Zrtgy3l+N9eiZ5hizKgn/u3ZOltnE=; b=nQimZSsXwodQnXvtdIvaMcDTKAdW0
        vEy+HxwhD0/K9bEuE9fqRMCjlNWKK+YcGHD7LkkmkzuZm/bDdH0agoJZ7xAzgtiY
        4BK6Syx9DLv4oAZeyw+qmWznAo+aLSE/N5v33aa5nZWvgOfFwqiWzGkREvUhrw2K
        QG94ZKmSgbQyBHpMxIJ5ZXAoz78pKKfJahH6P0ttWufo/1sT8DTsL+oG94OEU7m/
        6H/bKUSP6g7tO5CALZYK/1MY7XJ9HVqmPY5aeJt0vMDihJjexf3ZCGBaOwbKypIZ
        18YACb0NJvoIo+KYZFZNLnwt/0ByIJxLVp4xRts/aXhkodjBOKLP+9gwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=Ak46xq3GXQE1n+Zrtgy3l+N9eiZ5hizKgn/u3ZOltnE=; b=W23dEUrv
        KxRSlUOfrzl0CgVf1rQ1NIScwxyo6bTXx8eZFaPMJx8CFZkQKvP3uMQtdvZawdyK
        4FO18qeQMDS88x4Tk3Ymudz3AlrXYsRRaXp58DuWxWuV61xp3CpO0bPQ26qvs1RL
        tDXBEWqgg2d0QFyLnofuPAHYDqU3tFkcpM23nkih/17zaqhykEezSbsZ1PPVGjhJ
        AjOIOP+YfQpckjveXY8lCtPy7H7GJTD2ha08pOF6w1Uwsd4wDxq7whHKbEWzaHA4
        qSwNvq0eZzFotfzr8buU6EIFdPtP3jOguvH5uyaDWfLPelSAjVpO4i6kpfESqBcx
        zZ7nFP0m1zc66Q==
X-ME-Sender: <xms:zvwMYURJ6xepP_57kVtzJbwUSjpH57WcYiEYsmoa1O-6t0cBoeNSAQ>
    <xme:zvwMYRxmp11pllRbOdtYlL6O9dufQQnR08m4IsXmB6D3zCPCJQxxQxRHvGu6pAUm_
    lSdGHkPuhr28l5Wx2Y>
X-ME-Received: <xmr:zvwMYR36M6duk_tEwN9AcNnk03ZRpKhAqHMjBtbXdFUZy-MsWMFqMfopkf44p2s8EQhjO6_g-l3XAYoPKA_U6_bid4SfVqL6rIKJTkvhMQoT7Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrjedugdduudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepheffjeetteetke
    ffhfdvgefhgeevvddvueejheehfeevfedufeegiedtheeujeelnecuffhomhgrihhnpehr
    vghmrghrkhgrsghlvgdrtghomhenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlihhsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:zvwMYYD4duGoCPSmX6leFxX4nUVcpqsugZRD3yAAX-Tmbse0OW-uEw>
    <xmx:zvwMYdiSLjVAHaxAAl4yqNQdZSawbcECqiBABW3gTC38zr63-vTlag>
    <xmx:zvwMYUoyyayOnmkbRmo828vZ6o2ISKnJ55LhiwxT505-FfjWgTfmZw>
    <xmx:z_wMYVivZs0oiMGTCXWHUnKSlx4ksqDoW4cl1T1xJyI30zJm8kWQDg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Aug 2021 05:11:39 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v9 07/12] thermal: sy7636a: Add thermal driver for sy7636a
Date:   Fri,  6 Aug 2021 19:10:53 +1000
Message-Id: <20210806091058.141-8-alistair@alistair23.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210806091058.141-1-alistair@alistair23.me>
References: <20210806091058.141-1-alistair@alistair23.me>
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
 drivers/thermal/sy7636a_thermal.c | 91 +++++++++++++++++++++++++++++++
 3 files changed, 98 insertions(+)
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
index 000000000000..4e41ae78d11c
--- /dev/null
+++ b/drivers/thermal/sy7636a_thermal.c
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: GPL-2.0+
+//
+// Functions to access SY3686A power management chip temperature
+//
+// Copyright (C) 2019 reMarkable AS - http://www.remarkable.com/
+//
+// Authors: Lars Ivar Miljeteig <lars.ivar.miljeteig@remarkable.com>
+//          Alistair Francis <alistair@alistair23.me>
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/thermal.h>
+
+#include <linux/mfd/sy7636a.h>
+
+static int sy7636a_get_temp(void *arg, int *res)
+{
+	unsigned int reg_val, mode_ctr;
+	int ret;
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
+	struct regmap *regmap = dev_get_drvdata(pdev->dev.parent);
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

