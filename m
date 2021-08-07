Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FCCC3E34F1
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 12:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbhHGKk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 06:40:57 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:43139 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232085AbhHGKkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 06:40:36 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id DE42D5C00E4;
        Sat,  7 Aug 2021 06:40:18 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sat, 07 Aug 2021 06:40:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=O49nkM13Pyw7y
        jqsOXNKXTJZ6C6L1h91HccgIb6hk3M=; b=NKMhdYpv5lAM7yexVxcNX+eSeCX2j
        aSNLlPemHX73nVXD/1MQjsTLs4AvujgFZmbAv4UFzRcOcYICwoD4PqGgRlD08Q9E
        YRDNKMl07TbcHo/BQuJZKWtKTncW2HFcgveNfB+sF2rfMiYVZXysGSbh1mGmHeFz
        N6Ip6syC/Z5IbkOeVH9Gd+/39Cmk3UnwdHinf7+T9leFTecBbBaq+Et9XGdUVtXH
        +LvSVa4D/6RiL+139lRewIXdPPfwSIaxD2svGFUSul431vBV+BD/Z3WBCzV6QDEO
        ubF2CYEd3ei+YHiTqWXyDLCtvthbUBrd5mYx4fWUXMqQ3Mipd0AVX21VA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=O49nkM13Pyw7yjqsOXNKXTJZ6C6L1h91HccgIb6hk3M=; b=iSoj4VQ0
        XB3tJt9LBYXZ+k7n18++R07ydIj3nJbKuuwsCfRsgJjhz2++B0xZZKzrNoWM0Jzl
        Ru6OUwqNWbsxc+7oq6jH6BWhELYjjOHW3rQs3MxCLQ4ZBreebi8Hs6HilLNqcjbC
        HXy3tweJ6ftzgL6lWkawTuIW3r2UuhSStR8gIF0SO8a+QBx5fRhf15PbrBeJmcwI
        N/LhHm3n9qpQGq9JidjEEnQaLOpFFqFTeDjZ+cMjrGdSCSIxQvTyNDA7wu3VW8JS
        Pbye0js+wc0fROgz2oa3uQnQpHEm62dklBoxJWRGzhtwLt+lYV8Y4ToYXWVyVcBJ
        Y0UdDRvnm5dgqg==
X-ME-Sender: <xms:EmMOYUMhsHuvSOTVOkr5s0vDkq1ONFekd_bXppZ6lTdg2JoejGUfYg>
    <xme:EmMOYa93mvM2n2Spkqb8g1lYbu73f2IxF7yqwllAUt9KzzRNukz7h9ABINK8bBC56
    Vq5VkGVom1bSIMyJDU>
X-ME-Received: <xmr:EmMOYbSHAI9dREcgwbnIyEQlZBBnbvqNa57LCaK9MMyH8mVi7DdQbAec711PY1NFyjuclRCemvC_g6uw28YKM8Avm5QWDVUbjqoExL9n8eKN4ylmDQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrjeefgdeftdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepheffjeetteetke
    ffhfdvgefhgeevvddvueejheehfeevfedufeegiedtheeujeelnecuffhomhgrihhnpehr
    vghmrghrkhgrsghlvgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlihhsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:EmMOYcvr-NM0kFSZ44ZDT0KKzWBS2asociLQP4PgtZ-T71trsCyf_w>
    <xmx:EmMOYceLPIr8oZsqqM-FkFYL5d6MlBV4Yl6I0vV2oflYqx7fnGdFiQ>
    <xmx:EmMOYQ3qti-Ddc3PpECSl_czWB5gQj4kF4l_XYFRIW5eqiHvOaAUEg>
    <xmx:EmMOYatL3dyzCUTd3XuqMLKZJ1yYWLF8CKoskJ64jDE4O8j-VBxnxA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 7 Aug 2021 06:40:15 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v10 06/11] thermal: sy7636a: Add thermal driver for sy7636a
Date:   Sat,  7 Aug 2021 20:39:35 +1000
Message-Id: <20210807103940.152-7-alistair@alistair23.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210807103940.152-1-alistair@alistair23.me>
References: <20210807103940.152-1-alistair@alistair23.me>
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
index 000000000000..0a34071580f1
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

