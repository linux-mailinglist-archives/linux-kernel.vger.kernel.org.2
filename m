Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5E1938F2F8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 20:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233832AbhEXS3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 14:29:34 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:34917 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233681AbhEXS3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 14:29:31 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 501B6581E78;
        Mon, 24 May 2021 14:28:02 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 24 May 2021 14:28:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=tUG8E8y1qF72Z
        2wc4W2MFpiXtVOxUG4yzQDw5VhB6r8=; b=p3WaX6fr19fhNWEztsLyK+0iDt/Aj
        wq0vgRm5r2gwPIHPA3tp1H/aDjPVp3v9nuzR4vXRO38fHY7NtsX80JzF9P/lGR8/
        530/an0vTDWVq2r9lwoEC586rRj5sWKI8fmhR781o3rtPhwieT6BV6FKDg9WP1BJ
        mSPTMcadouUgcy2KoI83EdoTRSZexaDy0v36ZUdR36bLw090QO2n9Rp83hvSG5Rk
        HoaDlLa+GfTUMVm8BTALkSABsygpAbmVg6KLGe1TG7CHH0RaRBszKMJI+8yXi0od
        2yAqkVyDE0d/UaQortH0gsUskGEd55edu2vlFPii/O3GvjCMslm2Y+ZzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=tUG8E8y1qF72Z2wc4W2MFpiXtVOxUG4yzQDw5VhB6r8=; b=mYnTIV4Q
        Fmiphzl52G+ra5Z+agtLQ32rpMbeFlj+7cCNbtufbR54dznOuI+xGZdhEfbsKULv
        uuKZgkCFwSmQti403fXBvHG8D8p1EvIp2nDsBr3pa0JSsKVler3UcZERN4OJE2To
        E11mugyOQ5oIuIJMuPRljkYla9/uPTVFgF86Nq+CgDsosuvugcy3GxUvrPaBOJkt
        YSX8yN1ATcGaEm1grqXFO4P2ysZZKUAV9v413YoZCphHcVnXBRF5NoU/j04Ouqxk
        I4AGVYnhRnqZ12yzxJ897Hk4ZckfUT37DFxbgf8G1uKZhXR44VEVLu2SaOHufttL
        REdEu/ounWBkkg==
X-ME-Sender: <xms:MvCrYP42xtypnl0sA2GaLbjVwlVYHDizoe8dl5jfQklFJokRfojQ_A>
    <xme:MvCrYE6661PAOIghMoopsfCLfN5h5fHsTJ8mE4K850PgbufOss6FSJh6doj2eVJMI
    nhIEpRO2kicI4SZB2U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdejledguddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufhvvghn
    ucfrvghtvghruceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrghtth
    gvrhhnpeetvdekteeluefffffhkeetteffgefggfevheeileeufedvtdeuffevveelhfef
    jeenucfkphepudejiedrudelledrvdduuddruddvgeenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsvhgvnhesshhvvghnphgvthgvrhdruggv
    vh
X-ME-Proxy: <xmx:MvCrYGe_COBpfg2yLYUf6E6kqhAMoLbJ-X7ygtLxMoLpmC3hg2PuLA>
    <xmx:MvCrYAJ1h0lE384tjSA05ZOsNqTdaWGuvxQ4PU0LMYGTl4Q5TYiMdg>
    <xmx:MvCrYDJi6NfVdlfctv8GFTmp4CgD8JLC8DgK4yAsbmHwxtaPpLJtxg>
    <xmx:MvCrYK9PEoYg5VJujjeMZ5yP19qIr94OQU1YFmOz2zabpKZWRT64GA>
Received: from photon.s7r42.com (ip-176-199-211-124.hsi06.unitymediagroup.de [176.199.211.124])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Mon, 24 May 2021 14:28:00 -0400 (EDT)
From:   Sven Peter <sven@svenpeter.dev>
To:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org
Cc:     Sven Peter <sven@svenpeter.dev>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Arnd Bergmann <arnd@kernel.org>
Subject: [PATCH 2/3] clk: add support for gate clocks on Apple SoCs
Date:   Mon, 24 May 2021 20:27:44 +0200
Message-Id: <20210524182745.22923-3-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210524182745.22923-1-sven@svenpeter.dev>
References: <20210524182745.22923-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a simple driver for gate clocks found on Apple SoCs. These don't
have any frequency associated with them and are only used to enable
access to MMIO regions of various peripherals.

Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 MAINTAINERS                  |   1 +
 drivers/clk/Kconfig          |  12 +++
 drivers/clk/Makefile         |   1 +
 drivers/clk/clk-apple-gate.c | 152 +++++++++++++++++++++++++++++++++++
 4 files changed, 166 insertions(+)
 create mode 100644 drivers/clk/clk-apple-gate.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 59c026ce4d73..4b5d8e7a0fbc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1657,6 +1657,7 @@ F:	Documentation/devicetree/bindings/arm/apple.yaml
 F:	Documentation/devicetree/bindings/clock/apple,gate-clock.yaml
 F:	Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
 F:	arch/arm64/boot/dts/apple/
+F:	drivers/clk/clk-apple-gate.c
 F:	drivers/irqchip/irq-apple-aic.c
 F:	include/dt-bindings/interrupt-controller/apple-aic.h
 
diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index e80918be8e9c..ac987a8cf318 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -245,6 +245,18 @@ config CLK_TWL6040
 	  McPDM. McPDM module is using the external bit clock on the McPDM bus
 	  as functional clock.
 
+config COMMON_CLK_APPLE
+	tristate "Clock driver for Apple platforms"
+	depends on ARCH_APPLE && COMMON_CLK
+	default ARCH_APPLE
+	help
+	  Support for clock gates on Apple SoCs such as the M1.
+
+	  These clock gates do not have a frequency associated with them and
+	  are only used to power on/off various peripherals. Generally, a clock
+	  gate needs to be enabled before the respective MMIO region can be
+	  accessed.
+
 config COMMON_CLK_AXI_CLKGEN
 	tristate "AXI clkgen driver"
 	depends on HAS_IOMEM || COMPILE_TEST
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 5f06879d7fe9..ba73960694e3 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -18,6 +18,7 @@ endif
 
 # hardware specific clock types
 # please keep this section sorted lexicographically by file path name
+obj-$(CONFIG_COMMON_CLK_APPLE)		+= clk-apple-gate.o
 obj-$(CONFIG_MACH_ASM9260)		+= clk-asm9260.o
 obj-$(CONFIG_COMMON_CLK_AXI_CLKGEN)	+= clk-axi-clkgen.o
 obj-$(CONFIG_ARCH_AXXIA)		+= clk-axm5516.o
diff --git a/drivers/clk/clk-apple-gate.c b/drivers/clk/clk-apple-gate.c
new file mode 100644
index 000000000000..799e9269758f
--- /dev/null
+++ b/drivers/clk/clk-apple-gate.c
@@ -0,0 +1,152 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Apple SoC clock/power gating driver
+ *
+ * Copyright The Asahi Linux Contributors
+ */
+
+#include <linux/clk.h>
+#include <linux/clkdev.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/clk-provider.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/module.h>
+
+#define CLOCK_TARGET_MODE_MASK 0x0f
+#define CLOCK_TARGET_MODE(m) (((m)&0xf))
+#define CLOCK_ACTUAL_MODE_MASK 0xf0
+#define CLOCK_ACTUAL_MODE(m) (((m)&0xf) << 4)
+
+#define CLOCK_MODE_ENABLE 0xf
+#define CLOCK_MODE_DISABLE 0
+
+#define CLOCK_ENDISABLE_TIMEOUT 100
+
+struct apple_clk_gate {
+	struct clk_hw hw;
+	void __iomem *reg;
+};
+
+#define to_apple_clk_gate(_hw) container_of(_hw, struct apple_clk_gate, hw)
+
+static int apple_clk_gate_endisable(struct clk_hw *hw, int enable)
+{
+	struct apple_clk_gate *gate = to_apple_clk_gate(hw);
+	u32 reg;
+	u32 mode;
+
+	if (enable)
+		mode = CLOCK_MODE_ENABLE;
+	else
+		mode = CLOCK_MODE_DISABLE;
+
+	reg = readl(gate->reg);
+	reg &= ~CLOCK_TARGET_MODE_MASK;
+	reg |= CLOCK_TARGET_MODE(mode);
+	writel(reg, gate->reg);
+
+	return readl_poll_timeout_atomic(gate->reg, reg,
+					 (reg & CLOCK_ACTUAL_MODE_MASK) ==
+						 CLOCK_ACTUAL_MODE(mode),
+					 1, CLOCK_ENDISABLE_TIMEOUT);
+}
+
+static int apple_clk_gate_enable(struct clk_hw *hw)
+{
+	return apple_clk_gate_endisable(hw, 1);
+}
+
+static void apple_clk_gate_disable(struct clk_hw *hw)
+{
+	apple_clk_gate_endisable(hw, 0);
+}
+
+static int apple_clk_gate_is_enabled(struct clk_hw *hw)
+{
+	struct apple_clk_gate *gate = to_apple_clk_gate(hw);
+	u32 reg;
+
+	reg = readl(gate->reg);
+
+	if ((reg & CLOCK_ACTUAL_MODE_MASK) == CLOCK_ACTUAL_MODE(CLOCK_MODE_ENABLE))
+		return 1;
+	return 0;
+}
+
+static const struct clk_ops apple_clk_gate_ops = {
+	.enable = apple_clk_gate_enable,
+	.disable = apple_clk_gate_disable,
+	.is_enabled = apple_clk_gate_is_enabled,
+};
+
+static int apple_gate_clk_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *node = dev->of_node;
+	const struct clk_parent_data parent_data[] = {
+		{ .index = 0 },
+	};
+	struct apple_clk_gate *data;
+	struct clk_hw *hw;
+	struct clk_init_data init;
+	struct resource *res;
+	int num_parents;
+	int ret;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	data->reg = devm_ioremap_resource(dev, res);
+	if (IS_ERR(data->reg))
+		return PTR_ERR(data->reg);
+
+	num_parents = of_clk_get_parent_count(node);
+	if (num_parents > 1) {
+		dev_err(dev, "clock supports at most one parent\n");
+		return -EINVAL;
+	}
+
+	init.name = dev->of_node->name;
+	init.ops = &apple_clk_gate_ops;
+	init.flags = 0;
+	init.parent_names = NULL;
+	init.parent_data = parent_data;
+	init.num_parents = num_parents;
+
+	data->hw.init = &init;
+	hw = &data->hw;
+
+	ret = devm_clk_hw_register(dev, hw);
+	if (ret)
+		return ret;
+
+	return devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get, hw);
+}
+
+static const struct of_device_id apple_gate_clk_of_match[] = {
+	{ .compatible = "apple,t8103-gate-clock" },
+	{ .compatible = "apple,gate-clock" },
+	{}
+};
+
+MODULE_DEVICE_TABLE(of, apple_gate_clk_of_match);
+
+static struct platform_driver apple_gate_clkdriver = {
+	.probe = apple_gate_clk_probe,
+	.driver = {
+		.name = "apple-gate-clock",
+		.of_match_table = apple_gate_clk_of_match,
+	},
+};
+
+MODULE_AUTHOR("Sven Peter <sven@svenpeter.dev>");
+MODULE_DESCRIPTION("Clock gating driver for Apple SoCs");
+MODULE_LICENSE("GPL v2");
+
+module_platform_driver(apple_gate_clkdriver);
-- 
2.25.1

