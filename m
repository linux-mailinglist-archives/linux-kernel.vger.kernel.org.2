Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7F63DE8B0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 10:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234662AbhHCIqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 04:46:18 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:35553 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234687AbhHCIqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 04:46:12 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 5E5545809FD;
        Tue,  3 Aug 2021 04:46:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 03 Aug 2021 04:46:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=BAptCh5qSeNJY
        nOsKL6N4/7q1nSfd6pGGsM5k6xBcIs=; b=khnk2zgkbLCt3b40X5VFsRYXDyY3j
        w9mK/aoJS130jgoyo46qO0qMbaAbwovaW6whS9Vpx+P8p9D4xMyoaFvkDPEiB8U2
        gOn2sWY/H+gfF8e4f+2j9EmqQymHBNH2e+lT+XW0LCJkeWXjPB7nvbZwvemPBJ9f
        unF1ncEJ9DUo+Y/WNfAulfzisLM7d/NKEb/pMoRm8lhxGXxVh/LE88WB2/jzxtwi
        egxmde/S/SiRLz/65vaeFk3cGTuGFct6hMDtoyB/ucnYKYd3B8YseDy3/N6gj6Yy
        FyaByCRoRs9rU+Cf4ecoUs28cKTvvIjNf3HrKeLHeEXbfwWX2Po/+sfkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=BAptCh5qSeNJYnOsKL6N4/7q1nSfd6pGGsM5k6xBcIs=; b=twR46LIT
        lZ9ELVM4rrmOkRnwM4vdqGvJyZVQmdPaxKkNpsT/0Oii0LBvynGMHsXDFX9d7AHe
        9jku0C61ZnwEqpwkGdPx1l+Q/eyYNNZKM2N9opUkcfqME1zJBGNeNuVCu4NOhGAx
        WEPC74XvbfYNdl3tLMTSR/yHjXrqct3KY+/yJg+oxjJpyOYehnv81GIWwrPrjQR9
        Pw27ARgUfcFj6P880vh7WetbgJjlDha6MVk1DwouFW9Iw6MO1P9sb+OI/fqzl2ie
        WoMnWk/UBvjHSc0jhD/bXyIyr/XbSSMBLi7/JqVpB4SxIAIURxn5wkrYKl1+XWM0
        ViEyy07VNZNDrw==
X-ME-Sender: <xms:RwIJYR0wmnQ1qeaPu6PPkIoz6_WtwpD5t0RjUCX2dvaVYKXF5tglZw>
    <xme:RwIJYYGmkvWraFfVJ4uNfDIMIz2oX0z-hOEeM5mn9GdmNHZN0GHU4kK-77jMlwFMs
    wWQyikrUcMo8DDnB4w>
X-ME-Received: <xmr:RwIJYR4jVaVWxW84bDwrAKcVaZE65lWrIG32qwYrVp9uxF2hFe_qJrn8o9D2YlnT5LWGzJXtYEKnjgwdM6tPqTs2Ech2EiYNCao7cWJzjI0wNw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrieeggddthecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehlihhsthgr
    ihhrucfhrhgrnhgtihhsuceorghlihhsthgrihhrsegrlhhishhtrghirhdvfedrmhgvqe
    enucggtffrrghtthgvrhhnpeehffejteetteekfffhvdeghfegvedvvdeujeehheefveef
    udefgeeitdehueejleenucffohhmrghinheprhgvmhgrrhhkrggslhgvrdgtohhmnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgr
    ihhrsegrlhhishhtrghirhdvfedrmhgv
X-ME-Proxy: <xmx:RwIJYe1TWItEnInowAZpUIYr8vdg90DnlbO2-CChtCbB_x6ma9Rz7w>
    <xmx:RwIJYUFuwtC7ZwmsQzwrQgAVlwMss4WihtsyzqTShpQwYgna3N-aXw>
    <xmx:RwIJYf_zqRQBn-FwDbrf_hhVoQ_MmY-P6pJeDWPSlaquyZtsTt8SBQ>
    <xmx:SAIJYSYPKwb0_9Hs6MJEo-ShVw3W_GyewdJb5wsH0bDvLxdUThKoNQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Aug 2021 04:45:55 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com,
        Lars Ivar Miljeteig <lars.ivar.miljeteig@remarkable.no>,
        Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v8 03/11] thermal: sy7636a: Add thermal driver for sy7636a
Date:   Tue,  3 Aug 2021 18:44:50 +1000
Message-Id: <20210803084456.198-3-alistair@alistair23.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210803084456.198-1-alistair@alistair23.me>
References: <20210803084456.198-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lars Ivar Miljeteig <lars.ivar.miljeteig@remarkable.no>

Add thermal driver to enable kernel based polling
and shutdown of device for temperatures out of spec

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 drivers/thermal/Kconfig           |  7 +++
 drivers/thermal/Makefile          |  1 +
 drivers/thermal/sy7636a_thermal.c | 91 +++++++++++++++++++++++++++++++
 3 files changed, 99 insertions(+)
 create mode 100644 drivers/thermal/sy7636a_thermal.c

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index d7f44deab5b1..b383064a0ad7 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -450,6 +450,13 @@ depends on (ARCH_STI || ARCH_STM32) && OF
 source "drivers/thermal/st/Kconfig"
 endmenu
 
+config SY7636A_THERMAL
+	tristate "SY7636A thermal management"
+	depends on MFD_SY7636A
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
index 000000000000..1112108ad972
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
+	struct sy7636a *data = arg;
+	bool isVoltageActive;
+
+	ret = regmap_read(data->regmap,
+			SY7636A_REG_OPERATION_MODE_CRL, &mode_ctr);
+	if (ret)
+		return ret;
+
+	isVoltageActive = mode_ctr & SY7636A_OPERATION_MODE_CRL_ONOFF;
+
+	if (!isVoltageActive) {
+		ret = regmap_write(data->regmap,
+				SY7636A_REG_OPERATION_MODE_CRL,
+				mode_ctr | SY7636A_OPERATION_MODE_CRL_ONOFF);
+		if (ret)
+			return ret;
+	}
+
+	ret = regmap_read(data->regmap,
+			SY7636A_REG_TERMISTOR_READOUT, &reg_val);
+	if (ret)
+		return ret;
+
+	if (!isVoltageActive) {
+		ret = regmap_write(data->regmap,
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
+	struct sy7636a *sy7636a = dev_get_drvdata(pdev->dev.parent);
+	struct thermal_zone_device *thermal_zone_dev;
+
+	thermal_zone_dev = devm_thermal_zone_of_sensor_register(
+			pdev->dev.parent,
+			0,
+			sy7636a,
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

