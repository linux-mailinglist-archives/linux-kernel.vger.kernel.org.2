Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 691D83BF970
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 13:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbhGHMBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 08:01:04 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:47163 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231347AbhGHMBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 08:01:03 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.nyi.internal (Postfix) with ESMTP id F081B58057A;
        Thu,  8 Jul 2021 07:58:21 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 08 Jul 2021 07:58:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=+CJTfInSHFK2B
        aVPjtCvIlAEU6b/iEqjuBkVjoLMTG8=; b=ZYhnU/f5dKm1VnShTylYVHC23dGyU
        y1wuxEmolojBe85xbDBCAAeKNfDFw2BVGYC3PRDiArXdja+qvMTje3kht77Y1dQT
        NuLrCMMWAJz/5cxl9IlIMerqoqjkOKXrPpdIK/PQDSF05HllavdDtp3FxPZ+Vap0
        +qkxMM0lWzEwBBVetYVZjzDYcjefQr64QEbbEMcqfsqYITkmmck/0hcJK4ZNeO7l
        sN0vYSt8e4GrcbV6xLHwiiqpPt4s3H8I29fod2AsvyB4n65G3ajZv0ldVSs+aC0A
        0Rou3B9/AXHh4aL2MwzDYlzNPGoos115Zd+Kbh9ldGfZ1knsqYn9gRe7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=+CJTfInSHFK2BaVPjtCvIlAEU6b/iEqjuBkVjoLMTG8=; b=XbqkpFGD
        Or48Fd3/pBtGw3pDeqfnT9YhI17uLEwSkfG9KjpHeysM76G8ymsOdvXDABsdnMmU
        aAOnAbBfLHQjVsvh2G5Q7CGUeGamNjlo4jS70Ymv/NDS6ljSoZckCIOVUxyzdAxy
        UWh22ZhYaEc0mD+x1F1Md5FomAUNVvKzqfe2ZRyIoQmnB3zKHTeINVAll58PgHvP
        GCYm1y7gXi0PzIiPRCulFNZ0gpRuLLSVWG9v1fN8pa6faO3JcjkfEJEtpfpJth5/
        beeGFZprbnGrKoa75IKBpi5n9pTa4jHVL2VMZBLT44xkvSctQi10N9eqIhIRnmc/
        rpA0wl9lnPNL4A==
X-ME-Sender: <xms:XejmYD19GkWwH6iNzZ7T4rtIMorZLAdXKxXXhJc5WLvIuK0K86IwwQ>
    <xme:XejmYCE9_tqTkVEDOXDMt4ValbRd1u48ln4Fzx8Wo5tScudsJqgq1gMvh1F-FGY6I
    6JWfSJp8oNx2PPfcqY>
X-ME-Received: <xmr:XejmYD4F-JjkmcKBeR3AJSI_EsNSYf7HnASMwPcfpBgmEPt0qP5fMypRoNKyOPPN4WIBgVE4RLj6cg0jei8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrtdeggdeghecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehlihhsthgr
    ihhrucfhrhgrnhgtihhsuceorghlihhsthgrihhrsegrlhhishhtrghirhdvfedrmhgvqe
    enucggtffrrghtthgvrhhnpeehffejteetteekfffhvdeghfegvedvvdeujeehheefveef
    udefgeeitdehueejleenucffohhmrghinheprhgvmhgrrhhkrggslhgvrdgtohhmnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgr
    ihhrsegrlhhishhtrghirhdvfedrmhgv
X-ME-Proxy: <xmx:XejmYI1bW9T5iJBOVvFPNNDrHRPsY8cSGgSyVTcsgDDZjbc1MDEYmQ>
    <xmx:XejmYGFtZmewkoueOx1AGX1RWQPMc3Eroy046D_UmOx3V_BxKEq-6A>
    <xmx:XejmYJ9UNIFo4zpl7ak1FgvV245oVYD60R7mgbLuVZdrR73-XBVIOA>
    <xmx:XejmYEa5yp7WA2UotYM-HuvBgiywa1LV4U7ob4-waHxQD4zj3vDnwA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Jul 2021 07:58:17 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com,
        Lars Ivar Miljeteig <lars.ivar.miljeteig@remarkable.no>,
        Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v7 2/6] thermal: sy7636a: Add thermal driver for sy7636a
Date:   Thu,  8 Jul 2021 21:58:00 +1000
Message-Id: <20210708115804.212-2-alistair@alistair23.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210708115804.212-1-alistair@alistair23.me>
References: <20210708115804.212-1-alistair@alistair23.me>
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
 drivers/thermal/Kconfig           |   7 ++
 drivers/thermal/Makefile          |   1 +
 drivers/thermal/sy7636a_thermal.c | 107 ++++++++++++++++++++++++++++++
 3 files changed, 115 insertions(+)
 create mode 100644 drivers/thermal/sy7636a_thermal.c

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index d7f44deab5b1..7112c63d9021 100644
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
+	  temperature sensor embedded in Silabs SY7636A chip.
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
index 000000000000..705a16fb1045
--- /dev/null
+++ b/drivers/thermal/sy7636a_thermal.c
@@ -0,0 +1,107 @@
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
+struct sy7636a_data {
+	struct sy7636a *sy7636a;
+	struct thermal_zone_device *thermal_zone_dev;
+};
+
+static int sy7636a_get_temp(void *arg, int *res)
+{
+	unsigned int reg_val, mode_ctr;
+	int ret;
+	struct sy7636a_data *data = arg;
+	bool isVoltageActive;
+
+	ret = regmap_read(data->sy7636a->regmap,
+			SY7636A_REG_OPERATION_MODE_CRL, &mode_ctr);
+	if (ret)
+		return ret;
+
+	isVoltageActive = mode_ctr & SY7636A_OPERATION_MODE_CRL_ONOFF;
+
+	if (!isVoltageActive) {
+		ret = regmap_write(data->sy7636a->regmap,
+				SY7636A_REG_OPERATION_MODE_CRL,
+				mode_ctr | SY7636A_OPERATION_MODE_CRL_ONOFF);
+		if (ret)
+			return ret;
+	}
+
+	ret = regmap_read(data->sy7636a->regmap,
+			SY7636A_REG_TERMISTOR_READOUT, &reg_val);
+	if (ret)
+		return ret;
+
+	if (!isVoltageActive) {
+		ret = regmap_write(data->sy7636a->regmap,
+				SY7636A_REG_OPERATION_MODE_CRL,
+				mode_ctr);
+		if (ret)
+			return ret;
+	}
+
+	*res = *((signed char*)&reg_val);
+	*res *= 1000;
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
+	struct sy7636a_data *data;
+
+	if (!sy7636a)
+		return -EPROBE_DEFER;
+
+	data = devm_kzalloc(&pdev->dev, sizeof(struct sy7636a_data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, data);
+
+	data->sy7636a = sy7636a;
+	data->thermal_zone_dev = devm_thermal_zone_of_sensor_register(
+			pdev->dev.parent,
+			0,
+			data,
+			&ops);
+
+	return PTR_ERR_OR_ZERO(data->thermal_zone_dev);
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

