Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 675F045F5C7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 21:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240523AbhKZU2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 15:28:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233699AbhKZU0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 15:26:05 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F64DC061748;
        Fri, 26 Nov 2021 12:22:03 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id t9so4009886wrx.7;
        Fri, 26 Nov 2021 12:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WoZhLfvDm+L99HoPOnksDANG3fbG7ckhGdgFkoSItVw=;
        b=U829GneLOuDIJS6pH3revEcaJhxH5S2UX6CdW0CLnBHNWqBA7zdlQN4E9hyogJ1lVA
         bG6cYuMStyQK3fdIcvhMrDycOXRtd/4sGCBeCELQYxQQF79oOgolG72aNfAoaYC+E6wY
         GDYD0e6Z/oAWqvHPaJmAOY+umH70DgSgG2WpKLGYmuP+JP+8Bi3m8MKz6GQ/10IQlWHn
         hPpkzJcPJVZLNYk2kOFPrETxyTrtnhnyqItOYQ9ifpre6LkplZ46En4ZTDiyOzedGWYM
         MgWI26VX0+8+1x0S+0BWhovX/sOYvaEt6y9p5VATg9AP2uszVhBYHIOrJ7vWSHhGwMTJ
         NpNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WoZhLfvDm+L99HoPOnksDANG3fbG7ckhGdgFkoSItVw=;
        b=dMoKsAjqBfv8X2GVuPTU5rrzCxxmKCg+WO3lXVw9UXrdVTE9BROxpBceve72NR2Oi4
         OaQf81cXH+RqAccfzKR6JZVr7JnNjv6dqQJ/OCfbrq7BM7HZxI+2UrDNNJ815srxumAk
         AKmhYVLvSr9WnaI/lJ+7C75fx7iGLCL364GAXfYy0FW4vKiiJ/qKWcUAzhRP2ZcNGpHb
         YFq+nQnweOskC9ehk0v9MhA5mt54njG4P/VVqgj2XQ1V4SHavgAOxiZI6+sywIwS2Aw8
         nJMG0TMaTq57/E8Nv9aC56ZXQmXO+PFJKFyW/e3CSXvtOdnwpRQYEvekUSjiUFHjSUyL
         iBWQ==
X-Gm-Message-State: AOAM532WKwFc39cy95t1lJVLNSl9q2TdSuiALT3OG1ciDY5X720ysa1v
        ybsX1pxdcyMWADiU+z7n2mFTwrgu8zw=
X-Google-Smtp-Source: ABdhPJxAj+GzV4qkcmRopmJdcF2SNPVQWiFXjjXS6uLCVyAnDT1unI7LKakikwA4IevYMCsTIcxbxg==
X-Received: by 2002:adf:8bd8:: with SMTP id w24mr16668961wra.540.1637958121727;
        Fri, 26 Nov 2021 12:22:01 -0800 (PST)
Received: from debby ([2a01:e0a:a6d:a8d0:7ff4:8f61:5574:9f95])
        by smtp.gmail.com with ESMTPSA id t11sm6638917wrz.97.2021.11.26.12.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Nov 2021 12:22:01 -0800 (PST)
From:   Romain Perier <romain.perier@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Palmer <daniel@0x0f.com>,
        Romain Perier <romain.perier@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] clocksource: Add MStar MSC313e timer support
Date:   Fri, 26 Nov 2021 21:21:39 +0100
Message-Id: <20211126202144.72936-2-romain.perier@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211126202144.72936-1-romain.perier@gmail.com>
References: <20211126202144.72936-1-romain.perier@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MSC313e-compatible SoCs have 3 timer hardware blocks. All of these
are free running 32-bit increasing counters and can generate interrupts.
This commit adds basic support for these timers, the first timer block
being used as clocksource/sched_clock and delay, while the others will
be used as clockevents.

Signed-off-by: Romain Perier <romain.perier@gmail.com>
Co-developed-by: Daniel Palmer <daniel@0x0f.com>
Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 MAINTAINERS                         |   1 +
 drivers/clocksource/Kconfig         |  10 ++
 drivers/clocksource/Makefile        |   1 +
 drivers/clocksource/timer-msc313e.c | 228 ++++++++++++++++++++++++++++
 4 files changed, 240 insertions(+)
 create mode 100644 drivers/clocksource/timer-msc313e.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 7a2345ce8521..f39a1617bf50 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2282,6 +2282,7 @@ F:	Documentation/devicetree/bindings/gpio/mstar,msc313-gpio.yaml
 F:	arch/arm/boot/dts/mstar-*
 F:	arch/arm/mach-mstar/
 F:	drivers/clk/mstar/
+F:	drivers/clocksource/timer-msc313e.c
 F:	drivers/gpio/gpio-msc313.c
 F:	drivers/rtc/rtc-msc313.c
 F:	drivers/watchdog/msc313e_wdt.c
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index f65e31bab9ae..822e711da284 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -671,6 +671,16 @@ config MILBEAUT_TIMER
 	help
 	  Enables the support for Milbeaut timer driver.
 
+config MSC313E_TIMER
+	bool "MSC313E timer driver"
+	depends on ARCH_MSTARV7 || COMPILE_TEST
+	select TIMER_OF
+	select CLKSRC_MMIO
+	help
+	  Enables support for the MStar MSC313E timer driver.
+	  This provides access to multiple interrupt generating
+	  programmable 32-bit free running incrementing counters.
+
 config INGENIC_TIMER
 	bool "Clocksource/timer using the TCU in Ingenic JZ SoCs"
 	default MACH_INGENIC
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index c17ee32a7151..fa5f624eadb6 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -88,3 +88,4 @@ obj-$(CONFIG_CSKY_MP_TIMER)		+= timer-mp-csky.o
 obj-$(CONFIG_GX6605S_TIMER)		+= timer-gx6605s.o
 obj-$(CONFIG_HYPERV_TIMER)		+= hyperv_timer.o
 obj-$(CONFIG_MICROCHIP_PIT64B)		+= timer-microchip-pit64b.o
+obj-$(CONFIG_MSC313E_TIMER)		+= timer-msc313e.o
diff --git a/drivers/clocksource/timer-msc313e.c b/drivers/clocksource/timer-msc313e.c
new file mode 100644
index 000000000000..81f161744349
--- /dev/null
+++ b/drivers/clocksource/timer-msc313e.c
@@ -0,0 +1,228 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * MStar timer driver
+ *
+ * Copyright (C) 2021 Daniel Palmer
+ * Copyright (C) 2021 Romain Perier
+ *
+ */
+
+#include <linux/clk.h>
+#include <linux/clockchips.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqreturn.h>
+#include <linux/sched_clock.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/delay.h>
+
+#include "timer-of.h"
+
+#define TIMER_NAME "msc313e_timer"
+
+#define MSC313E_REG_CTRL		0x00
+#define MSC313E_REG_CTRL_TIMER_EN	BIT(0)
+#define MSC313E_REG_CTRL_TIMER_TRIG	BIT(1)
+#define MSC313E_REG_CTRL_TIMER_INT_EN	BIT(8)
+#define MSC313E_REG_TIMER_MAX_LOW	0x08
+#define MSC313E_REG_TIMER_MAX_HIGH	0x0c
+#define MSC313E_REG_COUNTER_LOW		0x10
+#define MSC313E_REG_COUNTER_HIGH	0x14
+
+#define TIMER_SYNC_TICKS		3
+
+struct msc313e_delay {
+	void __iomem *base;
+	struct delay_timer delay;
+};
+
+static void __iomem *msc313e_clksrc;
+static struct msc313e_delay msc313e_delay;
+
+static void msc313e_timer_stop(void __iomem *base)
+{
+	writew(0, base + MSC313E_REG_CTRL);
+}
+
+static void msc313e_timer_start(void __iomem *base, bool periodic)
+{
+	u16 reg;
+
+	reg = readw(base + MSC313E_REG_CTRL);
+	if (periodic)
+		reg |= MSC313E_REG_CTRL_TIMER_EN;
+	else
+		reg |= MSC313E_REG_CTRL_TIMER_TRIG;
+	writew(reg | MSC313E_REG_CTRL_TIMER_INT_EN, base + MSC313E_REG_CTRL);
+}
+
+static void msc313e_timer_setup(void __iomem *base, unsigned long delay)
+{
+	writew(delay >> 16, base + MSC313E_REG_TIMER_MAX_HIGH);
+	writew(delay & 0xffff, base + MSC313E_REG_TIMER_MAX_LOW);
+}
+
+static unsigned long msc313e_timer_current_value(void __iomem *base)
+{
+	unsigned long result;
+
+	result = readw(base + MSC313E_REG_COUNTER_LOW);
+	result |= readw(base + MSC313E_REG_COUNTER_HIGH) << 16;
+
+	return result;
+}
+
+static int msc313e_timer_clkevt_shutdown(struct clock_event_device *evt)
+{
+	struct timer_of *timer = to_timer_of(evt);
+
+	msc313e_timer_stop(timer_of_base(timer));
+
+	return 0;
+}
+
+static int msc313e_timer_clkevt_set_oneshot(struct clock_event_device *evt)
+{
+	struct timer_of *timer = to_timer_of(evt);
+
+	msc313e_timer_stop(timer_of_base(timer));
+	msc313e_timer_start(timer_of_base(timer), false);
+
+	return 0;
+}
+
+static int msc313e_timer_clkevt_set_periodic(struct clock_event_device *evt)
+{
+	struct timer_of *timer = to_timer_of(evt);
+
+	msc313e_timer_stop(timer_of_base(timer));
+	msc313e_timer_setup(timer_of_base(timer), timer_of_period(timer));
+	msc313e_timer_start(timer_of_base(timer), true);
+
+	return 0;
+}
+
+static int msc313e_timer_clkevt_next_event(unsigned long evt, struct clock_event_device *clkevt)
+{
+	struct timer_of *timer = to_timer_of(clkevt);
+
+	msc313e_timer_stop(timer_of_base(timer));
+	msc313e_timer_setup(timer_of_base(timer), evt);
+	msc313e_timer_start(timer_of_base(timer), false);
+
+	return 0;
+}
+
+static irqreturn_t msc313e_timer_clkevt_irq(int irq, void *dev_id)
+{
+	struct clock_event_device *evt = dev_id;
+
+	evt->event_handler(evt);
+
+	return IRQ_HANDLED;
+}
+
+static u64 msc313e_timer_clksrc_read(struct clocksource *cs)
+{
+	return msc313e_timer_current_value(msc313e_clksrc) & cs->mask;
+}
+
+static unsigned long msc313e_read_delay_timer_read(void)
+{
+	return msc313e_timer_current_value(msc313e_delay.base);
+}
+
+static u64 msc313e_timer_sched_clock_read(void)
+{
+	return msc313e_timer_current_value(msc313e_clksrc);
+}
+
+static struct clock_event_device msc313e_clkevt = {
+	.name = TIMER_NAME,
+	.rating = 300,
+	.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
+	.set_state_shutdown = msc313e_timer_clkevt_shutdown,
+	.set_state_periodic = msc313e_timer_clkevt_set_periodic,
+	.set_state_oneshot = msc313e_timer_clkevt_set_oneshot,
+	.tick_resume = msc313e_timer_clkevt_shutdown,
+	.set_next_event = msc313e_timer_clkevt_next_event,
+};
+
+static int __init msc313e_clkevt_init(struct device_node *np)
+{
+	int ret;
+	struct timer_of *to;
+
+	to = kzalloc(sizeof(*to), GFP_KERNEL);
+	if (!to)
+		return -ENOMEM;
+
+	to->flags = TIMER_OF_IRQ | TIMER_OF_CLOCK | TIMER_OF_BASE;
+	to->of_irq.handler = msc313e_timer_clkevt_irq;
+	ret = timer_of_init(np, to);
+	if (ret)
+		return ret;
+
+	msc313e_clkevt.cpumask = cpu_possible_mask;
+	msc313e_clkevt.irq = to->of_irq.irq;
+	to->clkevt = msc313e_clkevt;
+
+	clockevents_config_and_register(&to->clkevt, timer_of_rate(to),
+					TIMER_SYNC_TICKS, 0xffffffff);
+	return 0;
+}
+
+static int __init msc313e_clksrc_init(struct device_node *np)
+{
+	struct timer_of to = { 0 };
+	int ret;
+	u16 reg;
+
+	to.flags = TIMER_OF_BASE | TIMER_OF_CLOCK;
+	ret = timer_of_init(np, &to);
+	if (ret)
+		return ret;
+
+	msc313e_delay.base = timer_of_base(&to);
+	msc313e_delay.delay.read_current_timer = msc313e_read_delay_timer_read;
+	msc313e_delay.delay.freq = timer_of_rate(&to);
+
+	msc313e_clksrc = timer_of_base(&to);
+	reg = readw(msc313e_clksrc + MSC313E_REG_CTRL);
+	reg |= MSC313E_REG_CTRL_TIMER_EN;
+	writew(reg, msc313e_clksrc + MSC313E_REG_CTRL);
+
+	register_current_timer_delay(&msc313e_delay.delay);
+
+	sched_clock_register(msc313e_timer_sched_clock_read, 32, timer_of_rate(&to));
+	return clocksource_mmio_init(timer_of_base(&to), TIMER_NAME, timer_of_rate(&to), 300, 32,
+				     msc313e_timer_clksrc_read);
+}
+
+static int __init msc313e_timer_init(struct device_node *np)
+{
+	int ret = 0;
+	static int num_called;
+
+	switch (num_called) {
+	case 0:
+		ret = msc313e_clksrc_init(np);
+		if (ret)
+			return ret;
+		break;
+
+	default:
+		ret = msc313e_clkevt_init(np);
+		if (ret)
+			return ret;
+		break;
+	}
+
+	num_called++;
+
+	return 0;
+}
+
+TIMER_OF_DECLARE(msc313, "mstar,msc313e-timer", msc313e_timer_init);
-- 
2.33.0

