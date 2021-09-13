Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8FD7409B34
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 19:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244758AbhIMRve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 13:51:34 -0400
Received: from mga07.intel.com ([134.134.136.100]:64174 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244712AbhIMRv3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 13:51:29 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10106"; a="285446887"
X-IronPort-AV: E=Sophos;i="5.85,290,1624345200"; 
   d="scan'208";a="285446887"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2021 10:50:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,290,1624345200"; 
   d="scan'208";a="432659271"
Received: from bspteam04.iind.intel.com ([10.106.46.142])
  by orsmga006.jf.intel.com with ESMTP; 13 Sep 2021 10:50:03 -0700
From:   shruthi.sanil@intel.com
To:     daniel.lezcano@linaro.org, tglx@linutronix.de, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     andriy.shevchenko@linux.intel.com, kris.pan@linux.intel.com,
        mgross@linux.intel.com, srikanth.thokala@intel.com,
        lakshmi.bai.raja.subramanian@intel.com,
        mallikarjunappa.sangannavar@intel.com, shruthi.sanil@intel.com
Subject: [PATCH v7 2/2] clocksource: Add Intel Keem Bay timer support
Date:   Mon, 13 Sep 2021 23:19:55 +0530
Message-Id: <20210913174955.32330-3-shruthi.sanil@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210913174955.32330-1-shruthi.sanil@intel.com>
References: <20210913174955.32330-1-shruthi.sanil@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shruthi Sanil <shruthi.sanil@intel.com>

The Intel Keem Bay timer driver supports clocksource and clockevent
features for the timer IP used in Intel Keem Bay SoC.
The timer block supports 1 free running counter and 8 timers.
The free running counter can be used as a clocksource and
the timers can be used as clockevent. Each timer is capable of
generating individual interrupt.
Both the features are enabled through the timer general config register.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Shruthi Sanil <shruthi.sanil@intel.com>
---
 MAINTAINERS                         |   5 +
 drivers/clocksource/Kconfig         |  11 ++
 drivers/clocksource/Makefile        |   1 +
 drivers/clocksource/timer-keembay.c | 252 ++++++++++++++++++++++++++++
 4 files changed, 269 insertions(+)
 create mode 100644 drivers/clocksource/timer-keembay.c

diff --git a/MAINTAINERS b/MAINTAINERS
index eeb4c70b3d5b..1f58350f5f3c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9523,6 +9523,11 @@ F:	drivers/crypto/keembay/keembay-ocs-hcu-core.c
 F:	drivers/crypto/keembay/ocs-hcu.c
 F:	drivers/crypto/keembay/ocs-hcu.h
 
+INTEL KEEM BAY TIMER SUPPORT
+M:	Shruthi Sanil <shruthi.sanil@intel.com>
+S:	Maintained
+F:	drivers/clocksource/timer-keembay.c
+
 INTEL MANAGEMENT ENGINE (mei)
 M:	Tomas Winkler <tomas.winkler@intel.com>
 L:	linux-kernel@vger.kernel.org
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 0f5e3983951a..0dcf2c5aaaf2 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -708,4 +708,15 @@ config MICROCHIP_PIT64B
 	  modes and high resolution. It is used as a clocksource
 	  and a clockevent.
 
+config KEEMBAY_TIMER
+	bool "Intel Keem Bay timer"
+	depends on ARCH_KEEMBAY || COMPILE_TEST
+	select TIMER_OF
+	help
+	  This option enables the support for the Intel Keem Bay
+	  general purpose timer and free running counter driver.
+	  Each timer can generate an individual interrupt and
+	  supports oneshot and periodic modes.
+	  The 64-bit counter can be used as a clock source.
+
 endmenu
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index c17ee32a7151..ea319063ba47 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -88,3 +88,4 @@ obj-$(CONFIG_CSKY_MP_TIMER)		+= timer-mp-csky.o
 obj-$(CONFIG_GX6605S_TIMER)		+= timer-gx6605s.o
 obj-$(CONFIG_HYPERV_TIMER)		+= hyperv_timer.o
 obj-$(CONFIG_MICROCHIP_PIT64B)		+= timer-microchip-pit64b.o
+obj-$(CONFIG_KEEMBAY_TIMER)		+= timer-keembay.o
diff --git a/drivers/clocksource/timer-keembay.c b/drivers/clocksource/timer-keembay.c
new file mode 100644
index 000000000000..8647a05edf2e
--- /dev/null
+++ b/drivers/clocksource/timer-keembay.c
@@ -0,0 +1,252 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Intel Keem Bay Timer driver
+ *
+ * Copyright (C) 2020 Intel Corporation
+ */
+
+#include <linux/bitops.h>
+#include <linux/idr.h>
+#include <linux/interrupt.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/sizes.h>
+#include <linux/slab.h>
+#include <linux/regmap.h>
+
+#include "timer-of.h"
+
+/* Timer register offset */
+#define TIM_CNT_VAL_OFFSET		0x0
+#define TIM_RELOAD_VAL_OFFSET		0x4
+#define TIM_CONFIG_OFFSET		0x8
+
+/* Bit fields of timer general config register */
+#define TIM_CONFIG_PRESCALER_ENABLE	BIT(2)
+#define TIM_CONFIG_COUNTER_ENABLE	BIT(0)
+
+/* Bit fields of timer config register */
+#define TIM_CONFIG_INTERRUPT_PENDING	BIT(4)
+#define TIM_CONFIG_INTERRUPT_ENABLE	BIT(2)
+#define TIM_CONFIG_RESTART		BIT(1)
+#define TIM_CONFIG_ENABLE		BIT(0)
+
+#define TIM_GEN_MASK			GENMASK(31, 12)
+#define TIM_RATING			200
+#define TIM_CLKSRC_MASK_BITS		64
+
+#define TIMER_NAME_SIZE			25
+
+/* Provides a unique ID for each timer */
+static DEFINE_IDA(keembay_timer_ida);
+
+static inline void keembay_timer_enable(void __iomem *base, u32 flags)
+{
+	writel(TIM_CONFIG_ENABLE | flags, base + TIM_CONFIG_OFFSET);
+}
+
+static inline void keembay_timer_disable(void __iomem *base)
+{
+	writel(0x0, base + TIM_CONFIG_OFFSET);
+}
+
+static inline void keembay_timer_update_counter(void __iomem *base, u32 val)
+{
+	writel(val, base + TIM_CNT_VAL_OFFSET);
+	writel(val, base + TIM_RELOAD_VAL_OFFSET);
+}
+
+static inline void keembay_timer_clear_pending_int(void __iomem *base)
+{
+	u32 val;
+
+	val = readl(base + TIM_CONFIG_OFFSET);
+	val &= ~TIM_CONFIG_INTERRUPT_PENDING;
+	writel(val, base + TIM_CONFIG_OFFSET);
+}
+
+static int keembay_timer_set_next_event(unsigned long evt, struct clock_event_device *ce)
+{
+	u32 flags = TIM_CONFIG_INTERRUPT_ENABLE;
+	struct timer_of *to = to_timer_of(ce);
+	void __iomem *tim_base = timer_of_base(to);
+
+	keembay_timer_disable(tim_base);
+	keembay_timer_update_counter(tim_base, evt);
+	keembay_timer_enable(tim_base, flags);
+
+	return 0;
+}
+
+static int keembay_timer_periodic(struct clock_event_device *ce)
+{
+	u32 flags = TIM_CONFIG_INTERRUPT_ENABLE | TIM_CONFIG_RESTART;
+	struct timer_of *to = to_timer_of(ce);
+	void __iomem *tim_base = timer_of_base(to);
+
+	keembay_timer_disable(tim_base);
+	keembay_timer_update_counter(tim_base, timer_of_period(to));
+	keembay_timer_enable(tim_base, flags);
+
+	return 0;
+}
+
+static int keembay_timer_shutdown(struct clock_event_device *ce)
+{
+	struct timer_of *to = to_timer_of(ce);
+
+	keembay_timer_disable(timer_of_base(to));
+
+	return 0;
+}
+
+static irqreturn_t keembay_timer_isr(int irq, void *dev_id)
+{
+	struct clock_event_device *evt = dev_id;
+	struct timer_of *to = to_timer_of(evt);
+	void __iomem *tim_base = timer_of_base(to);
+	u32 val;
+
+	val = readl(tim_base + TIM_CONFIG_OFFSET);
+
+	if (val & TIM_CONFIG_RESTART) {
+		/* Clear interrupt for periodic timer*/
+		keembay_timer_clear_pending_int(tim_base);
+	} else {
+		/* Disable the timer for one shot timer */
+		keembay_timer_disable(tim_base);
+	}
+
+	evt->event_handler(evt);
+
+	return IRQ_HANDLED;
+}
+
+static int __init keembay_clockevent_init(struct device_node *np)
+{
+	struct timer_of *keembay_ce_to;
+	struct regmap *regmap;
+	char *timer_name;
+	int timer_id;
+	int ret;
+	u32 val;
+
+	regmap = device_node_to_regmap(np->parent);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	ret = regmap_read(regmap, TIM_CONFIG_OFFSET, &val);
+	if (ret)
+		return ret;
+
+	/* Prescaler bit must be enabled for the timer to function */
+	if (!(val & TIM_CONFIG_PRESCALER_ENABLE)) {
+		pr_err("%pOF: Prescaler is not enabled\n", np);
+		ret = -ENODEV;
+	}
+
+	keembay_ce_to = kzalloc(sizeof(*keembay_ce_to), GFP_KERNEL);
+	if (!keembay_ce_to)
+		ret = -ENOMEM;
+
+	timer_id = ida_alloc(&keembay_timer_ida, GFP_KERNEL);
+	if (timer_id < 0) {
+		ret = timer_id;
+		goto err_keembay_ce_to_free;
+	}
+
+	timer_name = kasprintf(GFP_KERNEL, "keembay_timer%d", timer_id);
+	if (!timer_name) {
+		ret = -ENOMEM;
+		goto err_free_ida;
+	}
+
+	keembay_ce_to->flags = TIMER_OF_IRQ | TIMER_OF_BASE | TIMER_OF_CLOCK;
+	keembay_ce_to->clkevt.name = timer_name;
+	keembay_ce_to->clkevt.cpumask = cpumask_of(0);
+	keembay_ce_to->clkevt.features = CLOCK_EVT_FEAT_PERIODIC |
+					 CLOCK_EVT_FEAT_ONESHOT  |
+					 CLOCK_EVT_FEAT_DYNIRQ;
+	keembay_ce_to->clkevt.rating = TIM_RATING;
+	keembay_ce_to->clkevt.set_next_event = keembay_timer_set_next_event;
+	keembay_ce_to->clkevt.set_state_periodic = keembay_timer_periodic;
+	keembay_ce_to->clkevt.set_state_shutdown = keembay_timer_shutdown;
+	keembay_ce_to->of_irq.handler = keembay_timer_isr;
+	keembay_ce_to->of_irq.flags = IRQF_TIMER;
+
+	ret = timer_of_init(np, keembay_ce_to);
+	if (ret)
+		goto err_timer_name_free;
+
+	ret = regmap_read(regmap, TIM_RELOAD_VAL_OFFSET, &val);
+	if (ret)
+		goto err_timer_name_free;
+
+	keembay_ce_to->of_clk.rate = keembay_ce_to->of_clk.rate / (val + 1);
+
+	clockevents_config_and_register(&keembay_ce_to->clkevt,
+					timer_of_rate(keembay_ce_to),
+					1,
+					U32_MAX);
+
+	return 0;
+
+err_timer_name_free:
+	kfree(timer_name);
+err_free_ida:
+	ida_free(&keembay_timer_ida, timer_id);
+err_keembay_ce_to_free:
+	kfree(keembay_ce_to);
+
+	return ret;
+}
+
+static struct timer_of keembay_cs_to = {
+	.flags	= TIMER_OF_BASE | TIMER_OF_CLOCK,
+};
+
+static u64 notrace keembay_clocksource_read(struct clocksource *cs)
+{
+	return lo_hi_readq(timer_of_base(&keembay_cs_to));
+}
+
+static struct clocksource keembay_counter = {
+	.name	= "keembay_sys_counter",
+	.rating	= TIM_RATING,
+	.read	= keembay_clocksource_read,
+	.mask	= CLOCKSOURCE_MASK(TIM_CLKSRC_MASK_BITS),
+	.flags	= CLOCK_SOURCE_IS_CONTINUOUS |
+		  CLOCK_SOURCE_SUSPEND_NONSTOP,
+};
+
+static int __init keembay_clocksource_init(struct device_node *np)
+{
+	struct regmap *regmap;
+	u32 val;
+	int ret;
+
+	regmap = device_node_to_regmap(np->parent);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	ret = regmap_read(regmap, TIM_CONFIG_OFFSET, &val);
+	if (ret)
+		return ret;
+
+	/* Free Running Counter bit must be enabled for counter to function */
+	if (!(val & TIM_CONFIG_COUNTER_ENABLE)) {
+		pr_err("%pOF: free running counter is not enabled\n", np);
+		return -ENODEV;
+	}
+
+	ret = timer_of_init(np, &keembay_cs_to);
+	if (ret)
+		return ret;
+
+	return clocksource_register_hz(&keembay_counter, timer_of_rate(&keembay_cs_to));
+}
+
+TIMER_OF_DECLARE(keembay_clockevent, "intel,keembay-timer", keembay_clockevent_init);
+TIMER_OF_DECLARE(keembay_clocksource, "intel,keembay-counter", keembay_clocksource_init);
-- 
2.17.1

