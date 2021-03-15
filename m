Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7537333B2AF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 13:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbhCOM0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 08:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbhCOM0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 08:26:14 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58DACC061574;
        Mon, 15 Mar 2021 05:26:12 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id w11so8562691wrr.10;
        Mon, 15 Mar 2021 05:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=+9zt49fikWOqfDxTMbEBEb4hG/YqPjQSW82REHjyXDA=;
        b=vQArxQRp0hSz2PkncaILmCft97NDuAqBp31KJn2dK9y6Qo6K7ZoxkDx/dKpwViwLUt
         ho8GhyfDdGN4T9Z5/XToemJ97fo+wIYysVmjcKGWiwTs8xJ5qOZ+aiDWM25MeFe/AZz1
         iCFihtvMYMtzluf9nBRcI+QYpH5n9KVoy4oRW2MtJ50dzCh8GR+IgvxAuySj0kXsOChu
         j2jabx+4EZmj0mESZ5UHsvkBy8hJpArvGdLjy0TyVsabp8jNl/Qz5jbLnMlpDFGfwNOn
         3Xz0RbTMTrCwyuuMfc3UZUJYZJWZuRouDn/YPOWnlxjUnqgwjSgwAa8YWZoonHZbPVJ4
         dv6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+9zt49fikWOqfDxTMbEBEb4hG/YqPjQSW82REHjyXDA=;
        b=PdYNBtWRBXxJYcBTUm/W2LPthtPTYlx3cF9cNqr6RYJbr42H9VxcsGG3dlVQ654zTR
         Rrlci8227sKgIFP8lZFDeoEJVLv6kyzMJy9jaV1X01bNWkK3l2RDGBwLANY7d1uP0NIM
         WLtRWeQHaaVRGlOyXJN9UJfpypiIYcYNAB2B3gZE6Euz+PBVPIofsHMv27fazIQl4cGz
         DqWeTCcXUYEhQWLU+HwpaYuxYCQm9W0eo1Z5nkjlWSNEB6X+4dW43g4mXHdXRJuB51QQ
         L/SJCXvBLn5VTfdeMB5sSYDAjEuB7ZsUGstKoiQTeRvKUgeqNTitC35SaAifqfmnHJk6
         pSbQ==
X-Gm-Message-State: AOAM532kiSbm5lA5MdN9WEiGjoFXsoZnTnahzLzXdj01yZRZ7XKT5u5X
        HrFUu+Tlqh9HaVxDyAypxKo=
X-Google-Smtp-Source: ABdhPJw3myQ/eowQUQ0FJIE6cG+CnV6fuDCB1J3HqUxY392nHUfJ6qv6YOSqliVY30l1gFZeVze30A==
X-Received: by 2002:a5d:4e83:: with SMTP id e3mr27228955wru.82.1615811170956;
        Mon, 15 Mar 2021 05:26:10 -0700 (PDT)
Received: from skynet.lan ([80.31.204.166])
        by smtp.gmail.com with ESMTPSA id o7sm18317851wrs.16.2021.03.15.05.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 05:26:10 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     jonas.gorski@gmail.com,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Maxime Ripard <maxime@cerno.tech>,
        =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>, Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] clk: bcm: Add BCM63268 timer clock and reset driver
Date:   Mon, 15 Mar 2021 13:26:05 +0100
Message-Id: <20210315122605.28437-5-noltari@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210315122605.28437-1-noltari@gmail.com>
References: <20210315122605.28437-1-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add driver for BCM63268 timer clock and reset controller.

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 v2: add changes suggested by Stephen Boyd

 drivers/clk/bcm/Kconfig              |   9 ++
 drivers/clk/bcm/Makefile             |   1 +
 drivers/clk/bcm/clk-bcm63268-timer.c | 231 +++++++++++++++++++++++++++
 3 files changed, 241 insertions(+)
 create mode 100644 drivers/clk/bcm/clk-bcm63268-timer.c

diff --git a/drivers/clk/bcm/Kconfig b/drivers/clk/bcm/Kconfig
index ec738f74a026..952c3b6ff71a 100644
--- a/drivers/clk/bcm/Kconfig
+++ b/drivers/clk/bcm/Kconfig
@@ -37,6 +37,15 @@ config CLK_BCM_63XX_GATE
 	  Enable common clock framework support for Broadcom BCM63xx DSL SoCs
 	  based on the MIPS architecture
 
+config CLK_BCM63268_TIMER
+	bool "Broadcom BCM63268 timer clock and reset support"
+	depends on BMIPS_GENERIC || COMPILE_TEST
+	default BMIPS_GENERIC
+	select RESET_CONTROLLER
+	help
+	  Enable timer clock and reset support for Broadcom BCM63268 DSL SoCs
+	  based on the MIPS architecture.
+
 config CLK_BCM_KONA
 	bool "Broadcom Kona CCU clock support"
 	depends on ARCH_BCM_MOBILE || COMPILE_TEST
diff --git a/drivers/clk/bcm/Makefile b/drivers/clk/bcm/Makefile
index edb66b44cb27..d0b6f4b1fb08 100644
--- a/drivers/clk/bcm/Makefile
+++ b/drivers/clk/bcm/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_CLK_BCM_63XX)	+= clk-bcm63xx.o
 obj-$(CONFIG_CLK_BCM_63XX_GATE)	+= clk-bcm63xx-gate.o
+obj-$(CONFIG_CLK_BCM63268_TIMER) += clk-bcm63268-timer.o
 obj-$(CONFIG_CLK_BCM_KONA)	+= clk-kona.o
 obj-$(CONFIG_CLK_BCM_KONA)	+= clk-kona-setup.o
 obj-$(CONFIG_CLK_BCM_KONA)	+= clk-bcm281xx.o
diff --git a/drivers/clk/bcm/clk-bcm63268-timer.c b/drivers/clk/bcm/clk-bcm63268-timer.c
new file mode 100644
index 000000000000..c86394b434ec
--- /dev/null
+++ b/drivers/clk/bcm/clk-bcm63268-timer.c
@@ -0,0 +1,231 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * BCM63268 Timer Clock and Reset Controller Driver
+ *
+ * Copyright (C) 2021 Álvaro Fernández Rojas <noltari@gmail.com>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/delay.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/reset-controller.h>
+
+#include <dt-bindings/clock/bcm63268-clock.h>
+
+#define BCM63268_TIMER_RESET_SLEEP_MIN_US	10000
+#define BCM63268_TIMER_RESET_SLEEP_MAX_US	20000
+
+struct bcm63268_tclkrst_hw {
+	void __iomem *regs;
+	spinlock_t lock;
+
+	struct reset_controller_dev rcdev;
+	struct clk_hw_onecell_data data;
+};
+
+struct bcm63268_tclk_table_entry {
+	const char * const name;
+	u8 bit;
+};
+
+static const struct bcm63268_tclk_table_entry bcm63268_timer_clocks[] = {
+	{
+		.name = "ephy1",
+		.bit = BCM63268_TCLK_EPHY1,
+	}, {
+		.name = "ephy2",
+		.bit = BCM63268_TCLK_EPHY2,
+	}, {
+		.name = "ephy3",
+		.bit = BCM63268_TCLK_EPHY3,
+	}, {
+		.name = "gphy1",
+		.bit = BCM63268_TCLK_GPHY1,
+	}, {
+		.name = "dsl",
+		.bit = BCM63268_TCLK_DSL,
+	}, {
+		.name = "wakeon_ephy",
+		.bit = BCM63268_TCLK_WAKEON_EPHY,
+	}, {
+		.name = "wakeon_dsl",
+		.bit = BCM63268_TCLK_WAKEON_DSL,
+	}, {
+		.name = "fap1_pll",
+		.bit = BCM63268_TCLK_FAP1,
+	}, {
+		.name = "fap2_pll",
+		.bit = BCM63268_TCLK_FAP2,
+	}, {
+		.name = "uto_50",
+		.bit = BCM63268_TCLK_UTO_50,
+	}, {
+		.name = "uto_extin",
+		.bit = BCM63268_TCLK_UTO_EXTIN,
+	}, {
+		.name = "usb_ref",
+		.bit = BCM63268_TCLK_USB_REF,
+	}, {
+		/* sentinel */
+	}
+};
+
+static inline struct bcm63268_tclkrst_hw *
+to_bcm63268_timer_reset(struct reset_controller_dev *rcdev)
+{
+	return container_of(rcdev, struct bcm63268_tclkrst_hw, rcdev);
+}
+
+static int bcm63268_timer_reset_update(struct reset_controller_dev *rcdev,
+				unsigned long id, bool assert)
+{
+	struct bcm63268_tclkrst_hw *reset = to_bcm63268_timer_reset(rcdev);
+	unsigned long flags;
+	uint32_t val;
+
+	spin_lock_irqsave(&reset->lock, flags);
+	val = __raw_readl(reset->regs);
+	if (assert)
+		val &= ~BIT(id);
+	else
+		val |= BIT(id);
+	__raw_writel(val, reset->regs);
+	spin_unlock_irqrestore(&reset->lock, flags);
+
+	return 0;
+}
+
+static int bcm63268_timer_reset_assert(struct reset_controller_dev *rcdev,
+				unsigned long id)
+{
+	return bcm63268_timer_reset_update(rcdev, id, true);
+}
+
+static int bcm63268_timer_reset_deassert(struct reset_controller_dev *rcdev,
+				  unsigned long id)
+{
+	return bcm63268_timer_reset_update(rcdev, id, false);
+}
+
+static int bcm63268_timer_reset_reset(struct reset_controller_dev *rcdev,
+			       unsigned long id)
+{
+	bcm63268_timer_reset_update(rcdev, id, true);
+	usleep_range(BCM63268_TIMER_RESET_SLEEP_MIN_US,
+		     BCM63268_TIMER_RESET_SLEEP_MAX_US);
+
+	bcm63268_timer_reset_update(rcdev, id, false);
+	/*
+	 * Ensure component is taken out reset state by sleeping also after
+	 * deasserting the reset. Otherwise, the component may not be ready
+	 * for operation.
+	 */
+	usleep_range(BCM63268_TIMER_RESET_SLEEP_MIN_US,
+		     BCM63268_TIMER_RESET_SLEEP_MAX_US);
+
+	return 0;
+}
+
+static int bcm63268_timer_reset_status(struct reset_controller_dev *rcdev,
+				unsigned long id)
+{
+	struct bcm63268_tclkrst_hw *reset = to_bcm63268_timer_reset(rcdev);
+
+	return !(__raw_readl(reset->regs) & BIT(id));
+}
+
+static struct reset_control_ops bcm63268_timer_reset_ops = {
+	.assert = bcm63268_timer_reset_assert,
+	.deassert = bcm63268_timer_reset_deassert,
+	.reset = bcm63268_timer_reset_reset,
+	.status = bcm63268_timer_reset_status,
+};
+
+static int bcm63268_tclk_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	const struct bcm63268_tclk_table_entry *entry, *table;
+	struct bcm63268_tclkrst_hw *hw;
+	struct clk_hw *clk;
+	u8 maxbit = 0;
+	int i, ret;
+
+	table = of_device_get_match_data(dev);
+	if (!table)
+		return -EINVAL;
+
+	for (entry = table; entry->name; entry++)
+		maxbit = max(maxbit, entry->bit);
+	maxbit++;
+
+	hw = devm_kzalloc(&pdev->dev, struct_size(hw, data.hws, maxbit),
+			  GFP_KERNEL);
+	if (!hw)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, hw);
+
+	spin_lock_init(&hw->lock);
+
+	hw->data.num = maxbit;
+	for (i = 0; i < maxbit; i++)
+		hw->data.hws[i] = ERR_PTR(-ENODEV);
+
+	hw->regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(hw->regs))
+		return PTR_ERR(hw->regs);
+
+	for (entry = table; entry->name; entry++) {
+		clk = clk_hw_register_gate(dev, entry->name, NULL, 0,
+					   hw->regs, entry->bit,
+					   CLK_GATE_BIG_ENDIAN, &hw->lock);
+		if (IS_ERR(clk)) {
+			ret = PTR_ERR(clk);
+			goto out_err;
+		}
+
+		hw->data.hws[entry->bit] = clk;
+	}
+
+	ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
+					  &hw->data);
+	if (ret)
+		return ret;
+
+	hw->rcdev.of_node = dev->of_node;
+	hw->rcdev.ops = &bcm63268_timer_reset_ops;
+
+	ret = devm_reset_controller_register(dev, &hw->rcdev);
+	if (ret)
+		dev_err(dev, "Failed to register reset controller\n");
+
+	return 0;
+
+out_err:
+	for (i = 0; i < hw->data.num; i++) {
+		if (!IS_ERR(hw->data.hws[i]))
+			clk_hw_unregister_gate(hw->data.hws[i]);
+	}
+
+	return ret;
+}
+
+static const struct of_device_id bcm63268_tclk_dt_ids[] = {
+	{
+		.compatible = "brcm,bcm63268-timer-clocks",
+		.data = &bcm63268_timer_clocks,
+	}, {
+		/* sentinel */
+	}
+};
+
+static struct platform_driver bcm63268_tclk = {
+	.probe = bcm63268_tclk_probe,
+	.driver = {
+		.name = "bcm63268-timer-clock",
+		.of_match_table = bcm63268_tclk_dt_ids,
+	},
+};
+builtin_platform_driver(bcm63268_tclk);
-- 
2.20.1

