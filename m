Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06CA23184D4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 06:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbhBKFZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 00:25:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbhBKFX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 00:23:57 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F47CC0617AA
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 21:22:42 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id 18so3019582pfz.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 21:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zs7t4gtlspYKBLgt0X8yFioevGEkxsHsUdG8VrdW6GY=;
        b=O0RksTus5x8byS8wXz+8jZvf7zXFao51R7zweM8dgMP/VE7e2LiNdlSLSGXX9uUfGz
         wBcSuQ32yCIZPYAIhRBBwmW061J00MYIEOGQdJZ9WJbfzzQATWnX9zjEv3sWXHhSxXNe
         0t6Rk3KFEk5yY0nTJKJ7VCNrNpQD7U5A+fjuw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zs7t4gtlspYKBLgt0X8yFioevGEkxsHsUdG8VrdW6GY=;
        b=uHj3h/c1DuEkyOW5poMVdafJ8aHJ8z1JxPP1YOP1qsandOrH99nCU53S+DUTZF6olF
         3+CaiVHEVF5vDw3WJJZFvBG54MVu1rEiqvBsqkDeUvz75bgsvHPKKeYBXksqNjMGvt/y
         9VvQil/BJn2x8/RW85u5nBMcVuVXirTaRodlk22S+vN9SJuRP2g+XN40L0U4f95kllEU
         BPrdP2iRnYVS6da13J81XBYJFBwCcMvYH6PCajazCFuiiiDgbvHtt54ThjeU0Lwl7RfG
         dFEr7DljOZbWusr1K0hHpo6dnOJaqfdxLg7c0lp5setc0TQg5Jbqp/IeZpQf8eABRndO
         RxkA==
X-Gm-Message-State: AOAM531aiMcCBcf3BC4KEqPinqGeIvqyFHqq9pPV/RssG77ez/a/8ylM
        EkB+bklyvlvSeuQA4IavH6Xpbw==
X-Google-Smtp-Source: ABdhPJy0HeVTVAnp3JYyDFIMzUpzeVJBERl7Z1lKhRLTKKccBWcfh+ou8QvkJsWmDUQ7WwWBRl+iSA==
X-Received: by 2002:a63:1157:: with SMTP id 23mr6605070pgr.418.1613020961065;
        Wed, 10 Feb 2021 21:22:41 -0800 (PST)
Received: from shiro.work (p345188-ipngn200408sizuokaden.shizuoka.ocn.ne.jp. [124.98.97.188])
        by smtp.googlemail.com with ESMTPSA id o21sm3493511pjp.42.2021.02.10.21.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 21:22:40 -0800 (PST)
From:   Daniel Palmer <daniel@0x0f.com>
To:     linux-clk@vger.kernel.org, sboyd@kernel.org,
        devicetree@vger.kernel.org
Cc:     w@1wt.eu, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH v2 4/7] clk: mstar: MStar/SigmaStar MPLL driver
Date:   Thu, 11 Feb 2021 14:22:03 +0900
Message-Id: <20210211052206.2955988-5-daniel@0x0f.com>
X-Mailer: git-send-email 2.30.0.rc2
In-Reply-To: <20210211052206.2955988-1-daniel@0x0f.com>
References: <20210211052206.2955988-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a basic driver for the MPLL block found in MStar/SigmaStar
ARMv7 SoCs.

Currently this driver is only good for calculating the rates of it's
outputs and the actual configuration must be done before the kernel
boots. Usually this is done even before u-boot starts.

This driver targets the MPLL block found in the MSC313/MSC313E but
there is no documentation this chip so the register descriptions for
the another MStar chip the MST786 were used as they seem to match.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 MAINTAINERS                         |   1 +
 drivers/clk/Kconfig                 |   1 +
 drivers/clk/Makefile                |   1 +
 drivers/clk/mstar/Kconfig           |   5 +
 drivers/clk/mstar/Makefile          |   6 ++
 drivers/clk/mstar/clk-msc313-mpll.c | 155 ++++++++++++++++++++++++++++
 6 files changed, 169 insertions(+)
 create mode 100644 drivers/clk/mstar/Kconfig
 create mode 100644 drivers/clk/mstar/Makefile
 create mode 100644 drivers/clk/mstar/clk-msc313-mpll.c

diff --git a/MAINTAINERS b/MAINTAINERS
index d004436c8860..d8414dbfebec 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2149,6 +2149,7 @@ F:	Documentation/devicetree/bindings/clock/mstar,msc313-mpll.yaml
 F:	Documentation/devicetree/bindings/gpio/mstar,msc313-gpio.yaml
 F:	arch/arm/boot/dts/mstar-*
 F:	arch/arm/mach-mstar/
+F:	drivers/clk/mstar/
 F:	drivers/gpio/gpio-msc313.c
 F:	include/dt-bindings/clock/mstar-*
 F:	include/dt-bindings/gpio/msc313-gpio.h
diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 85856cff506c..a29c15444d0e 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -379,6 +379,7 @@ source "drivers/clk/ingenic/Kconfig"
 source "drivers/clk/keystone/Kconfig"
 source "drivers/clk/mediatek/Kconfig"
 source "drivers/clk/meson/Kconfig"
+source "drivers/clk/mstar/Kconfig"
 source "drivers/clk/mvebu/Kconfig"
 source "drivers/clk/qcom/Kconfig"
 source "drivers/clk/renesas/Kconfig"
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index dbdc590e7de3..7fed7e5944cd 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -95,6 +95,7 @@ obj-$(CONFIG_MACH_PIC32)		+= microchip/
 ifeq ($(CONFIG_COMMON_CLK), y)
 obj-$(CONFIG_ARCH_MMP)			+= mmp/
 endif
+obj-$(CONFIG_ARCH_MSTARV7)		+= mstar/
 obj-y					+= mvebu/
 obj-$(CONFIG_ARCH_MXS)			+= mxs/
 obj-$(CONFIG_COMMON_CLK_NXP)		+= nxp/
diff --git a/drivers/clk/mstar/Kconfig b/drivers/clk/mstar/Kconfig
new file mode 100644
index 000000000000..23765edde3af
--- /dev/null
+++ b/drivers/clk/mstar/Kconfig
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config MSTAR_MSC313_MPLL
+	bool
+	select REGMAP
+	select REGMAP_MMIO
diff --git a/drivers/clk/mstar/Makefile b/drivers/clk/mstar/Makefile
new file mode 100644
index 000000000000..f8dcd25ede1d
--- /dev/null
+++ b/drivers/clk/mstar/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for mstar specific clk
+#
+
+obj-$(CONFIG_MSTAR_MSC313_MPLL) += clk-msc313-mpll.o
diff --git a/drivers/clk/mstar/clk-msc313-mpll.c b/drivers/clk/mstar/clk-msc313-mpll.c
new file mode 100644
index 000000000000..09f578108eef
--- /dev/null
+++ b/drivers/clk/mstar/clk-msc313-mpll.c
@@ -0,0 +1,155 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * MStar MSC313 MPLL driver
+ *
+ * Copyright (C) 2020 Daniel Palmer <daniel@thingy.jp>
+ */
+
+#include <linux/platform_device.h>
+#include <linux/of_address.h>
+#include <linux/clk-provider.h>
+#include <linux/regmap.h>
+
+#define REG_CONFIG1	0x8
+#define REG_CONFIG2	0xc
+
+static const struct regmap_config msc313_mpll_regmap_config = {
+	.reg_bits = 16,
+	.val_bits = 16,
+	.reg_stride = 4,
+};
+
+static const struct reg_field config1_loop_div_first = REG_FIELD(REG_CONFIG1, 8, 9);
+static const struct reg_field config1_input_div_first = REG_FIELD(REG_CONFIG1, 4, 5);
+static const struct reg_field config2_output_div_first = REG_FIELD(REG_CONFIG2, 12, 13);
+static const struct reg_field config2_loop_div_second = REG_FIELD(REG_CONFIG2, 0, 7);
+
+static const unsigned int output_dividers[] = {
+	2, 3, 4, 5, 6, 7, 10
+};
+
+#define NUMOUTPUTS (ARRAY_SIZE(output_dividers) + 1)
+
+struct msc313_mpll {
+	struct clk_hw clk_hw;
+	struct regmap_field *input_div;
+	struct regmap_field *loop_div_first;
+	struct regmap_field *loop_div_second;
+	struct regmap_field *output_div;
+	struct clk_hw_onecell_data *clk_data;
+};
+
+#define to_mpll(_hw) container_of(_hw, struct msc313_mpll, clk_hw)
+
+static unsigned long msc313_mpll_recalc_rate(struct clk_hw *hw,
+		unsigned long parent_rate)
+{
+	struct msc313_mpll *mpll = to_mpll(hw);
+	unsigned int input_div, output_div, loop_first, loop_second;
+	unsigned long output_rate;
+
+	regmap_field_read(mpll->input_div, &input_div);
+	regmap_field_read(mpll->output_div, &output_div);
+	regmap_field_read(mpll->loop_div_first, &loop_first);
+	regmap_field_read(mpll->loop_div_second, &loop_second);
+
+	output_rate = parent_rate / (1 << input_div);
+	output_rate *= (1 << loop_first) * max(loop_second, 1U);
+	output_rate /= max(output_div, 1U);
+
+	return output_rate;
+}
+
+static const struct clk_ops msc313_mpll_ops = {
+	.recalc_rate = msc313_mpll_recalc_rate,
+};
+
+static const struct clk_parent_data mpll_parent = {
+	.index	= 0,
+};
+
+static int msc313_mpll_probe(struct platform_device *pdev)
+{
+	void __iomem *base;
+	struct msc313_mpll *mpll;
+	struct clk_init_data clk_init = { };
+	struct device *dev = &pdev->dev;
+	struct regmap *regmap;
+	char *outputname;
+	struct clk_hw *divhw;
+	int ret, i;
+
+	mpll = devm_kzalloc(dev, sizeof(*mpll), GFP_KERNEL);
+	if (!mpll)
+		return -ENOMEM;
+
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	regmap = devm_regmap_init_mmio(dev, base, &msc313_mpll_regmap_config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	mpll->input_div = devm_regmap_field_alloc(dev, regmap, config1_input_div_first);
+	if (IS_ERR(mpll->input_div))
+		return PTR_ERR(mpll->input_div);
+	mpll->output_div = devm_regmap_field_alloc(dev, regmap, config2_output_div_first);
+	if (IS_ERR(mpll->output_div))
+		return PTR_ERR(mpll->output_div);
+	mpll->loop_div_first = devm_regmap_field_alloc(dev, regmap, config1_loop_div_first);
+	if (IS_ERR(mpll->loop_div_first))
+		return PTR_ERR(mpll->loop_div_first);
+	mpll->loop_div_second = devm_regmap_field_alloc(dev, regmap, config2_loop_div_second);
+	if (IS_ERR(mpll->loop_div_second))
+		return PTR_ERR(mpll->loop_div_second);
+
+	mpll->clk_data = devm_kzalloc(dev, struct_size(mpll->clk_data, hws,
+			ARRAY_SIZE(output_dividers)), GFP_KERNEL);
+	if (!mpll->clk_data)
+		return -ENOMEM;
+
+	clk_init.name = dev_name(dev);
+	clk_init.ops = &msc313_mpll_ops;
+	clk_init.parent_data = &mpll_parent;
+	clk_init.num_parents = 1;
+	mpll->clk_hw.init = &clk_init;
+
+	ret = devm_clk_hw_register(dev, &mpll->clk_hw);
+	if (ret)
+		return ret;
+
+	mpll->clk_data->num = NUMOUTPUTS;
+	mpll->clk_data->hws[0] = &mpll->clk_hw;
+
+	for (i = 0; i < ARRAY_SIZE(output_dividers); i++) {
+		outputname = devm_kasprintf(dev, GFP_KERNEL, "%s_div_%d",
+				clk_init.name, output_dividers[i]);
+		if (!outputname)
+			return -ENOMEM;
+		divhw = devm_clk_hw_register_fixed_factor(dev, outputname,
+				clk_init.name, 0, 1, output_dividers[i]);
+		if (IS_ERR(divhw))
+			return PTR_ERR(divhw);
+		mpll->clk_data->hws[i + 1] = divhw;
+	}
+
+	platform_set_drvdata(pdev, mpll);
+
+	return devm_of_clk_add_hw_provider(&pdev->dev, of_clk_hw_onecell_get,
+			mpll->clk_data);
+}
+
+static const struct of_device_id msc313_mpll_of_match[] = {
+	{ .compatible = "mstar,msc313-mpll", },
+	{}
+};
+
+static struct platform_driver msc313_mpll_driver = {
+	.driver = {
+		.name = "mstar-msc313-mpll",
+		.of_match_table = msc313_mpll_of_match,
+	},
+	.probe = msc313_mpll_probe,
+};
+builtin_platform_driver(msc313_mpll_driver);
-- 
2.30.0.rc2

