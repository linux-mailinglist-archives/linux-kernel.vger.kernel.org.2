Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A79CD31D7F9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 12:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbhBQLKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 06:10:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbhBQLH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 06:07:57 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03516C0613D6
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 03:07:16 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id a207so3245646wmd.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 03:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cVPq1afpL+Nx1c4ld2fK0O1zMPM373avRcTwFbh6f9A=;
        b=DLpwgcPJvpyXjVOz5J2+lCjBNHYb8JiW6WMSzqH1F0mfxmC41rBToK9eH8FskVdACa
         2izvgeyuyYLtM0trv4A/gFBCFYyPBGjeUYro56HaMm0Djo1dOcIttyJTUdEA+gz4CNQ/
         7qroTVKHptgk89iULLx2mgXkoKABixQupgUu3jgpiBiAM4h4TNT9zzUDOeP6LathOr/D
         wbQJ9h4mQFzYJ+nXTJmBfYjL/gugeHSj2ysGp8+ri7OrlxLnQxEDqqeXGRMJz7oKhsu+
         TwOI3JMlVu2USZI4b7eMamp9wmlW+bhBwbBIo2pbmdi3URehUWaa7t/4ZtG7i7Hu9o9Y
         1qjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cVPq1afpL+Nx1c4ld2fK0O1zMPM373avRcTwFbh6f9A=;
        b=D/tE/uvvLJ6iOKkh6C07cDXCEvUtvauAEzym4S+gOpieI3vwnoPdid/6Xe6SG5huY3
         iyo97h2GAxSFtdflAJjXMRG9GuWBUGkuMbXanAiNIm6WvlbPTr/8z3vlEYCI65nRPJdN
         nHNGcuydD21hFIwDlIDYcaI6AEYrOEkdFB5Qka8+CH5O0LSvvaArCftjaJqPugz2AdCG
         nDiWOO8LsqNP9dpjsb+yi9jeCl55frHgZ8gBIuVnDbTreyTtOl/98je/b9dcxhHLCUSC
         ENDpKeTSVg2QYg9nSyZ6H5ntA0rv4rEJ/QhoyNNebREjOJe4xYVACXbf8Pv+I+Yz1hBt
         fTHg==
X-Gm-Message-State: AOAM533FRyKan4GSesNyEOxGAR6iFEzrpxC+KUQyc6xLHq3BIhlGiVG5
        ml5fzcpicuZMOkd+LyIXyLw=
X-Google-Smtp-Source: ABdhPJxaFGN9NIiQNq09M/wNJHpqcdsYBQzvntl9MFrwItO+uQTHYkbdV9zUbcc7HTmWK9QMjFLw7Q==
X-Received: by 2002:a1c:6308:: with SMTP id x8mr6765384wmb.78.1613560034767;
        Wed, 17 Feb 2021 03:07:14 -0800 (PST)
Received: from poker.lan (static.2-229-210-222.ip198.fastwebnet.it. [2.229.210.222])
        by smtp.gmail.com with ESMTPSA id y1sm3594073wrr.41.2021.02.17.03.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 03:07:14 -0800 (PST)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     tglx@linutronix.de, daniel.lezcano@linaro.org
Cc:     Andrea Merello <andrea.merello@gmail.com>,
        Patrice Chotard <patrice.chotard@st.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Michal Simek <michal.simek@xilinx.com>,
        =?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann@xilinx.com>
Subject: [PATCH 1/2] clocksource: arm_global_timer: implement rate compensation whenever source clock changes
Date:   Wed, 17 Feb 2021 12:07:08 +0100
Message-Id: <20210217110709.17250-2-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210217110709.17250-1-andrea.merello@gmail.com>
References: <20210217110709.17250-1-andrea.merello@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds rate change notification support for the parent clock;
should that clock change, then we try to adjust the our prescaler in order
to compensate (i.e. we adjust to still get the same timer frequency).

This is loosely based on what it's done in timer-cadence-ttc. timer-sun51,
mips-gic-timer and smp_twd.c also seem to look at their parent clock rate
and to perform some kind of adjustment whenever needed.

In this particular case we have only one single counter and prescaler for
all clocksource, clockevent and timer_delay, and we just update it for all
(i.e. we don't let it go and call clockevents_update_freq() to notify to
the kernel that our rate has changed).

Note that, there is apparently no other way to fixup things, because once
we call register_current_timer_delay(), specifying the timer rate, it seems
that that rate is not supposed to change ever.

In order for this mechanism to work, we have to make assumptions about how
much the initial clock is supposed to eventually decrease from the initial
one, and set our initial prescaler to a value that we can eventually
decrease enough to compensate. We provide an option in KConfig for this.

In case we end up in a situation in which we are not able to compensate the
parent clock change, we fail returning NOTIFY_BAD.

This fixes a real-world problem with Zynq arch not being able to use this
driver and CPU_FREQ at the same time (because ARM global timer is fed by
the CPU clock, which may keep changing when CPU_FREQ is enabled).

Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
Cc: Patrice Chotard <patrice.chotard@st.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: Sören Brinkmann <soren.brinkmann@xilinx.com>
---
 drivers/clocksource/Kconfig            |  13 +++
 drivers/clocksource/arm_global_timer.c | 122 +++++++++++++++++++++++--
 2 files changed, 125 insertions(+), 10 deletions(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 14c7c4712478..0f1c625275a0 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -385,6 +385,19 @@ config ARM_GLOBAL_TIMER
 	help
 	  This option enables support for the ARM global timer unit.
 
+config ARM_GT_INITIAL_PRESCALER_VAL
+	int "ARM global timer initial prescaler value"
+	default 1
+	depends on ARM_GLOBAL_TIMER
+	help
+	  When the ARM global timer initializes, its current rate is declared
+	  to the kernel and maintained forever. Should it's parent clock
+	  change, the driver tries to fix the timer's internal prescaler.
+	  On some machs (i.e. Zynq) the initial prescaler value thus poses
+	  bounds about how much the parent clock is allowed to decrease or
+	  increase wrt the initial clock value.
+	  This affects CPU_FREQ max delta from the initial frequency.
+
 config ARM_TIMER_SP804
 	bool "Support for Dual Timer SP804 module" if COMPILE_TEST
 	depends on GENERIC_SCHED_CLOCK && CLKDEV_LOOKUP
diff --git a/drivers/clocksource/arm_global_timer.c b/drivers/clocksource/arm_global_timer.c
index 88b2d38a7a61..60a8047fd32e 100644
--- a/drivers/clocksource/arm_global_timer.c
+++ b/drivers/clocksource/arm_global_timer.c
@@ -31,6 +31,10 @@
 #define GT_CONTROL_COMP_ENABLE		BIT(1)	/* banked */
 #define GT_CONTROL_IRQ_ENABLE		BIT(2)	/* banked */
 #define GT_CONTROL_AUTO_INC		BIT(3)	/* banked */
+#define GT_CONTROL_PRESCALER_SHIFT      8
+#define GT_CONTROL_PRESCALER_MAX        0xF
+#define GT_CONTROL_PRESCALER_MASK       (GT_CONTROL_PRESCALER_MAX << \
+					 GT_CONTROL_PRESCALER_SHIFT)
 
 #define GT_INT_STATUS	0x0c
 #define GT_INT_STATUS_EVENT_FLAG	BIT(0)
@@ -39,6 +43,7 @@
 #define GT_COMP1	0x14
 #define GT_AUTO_INC	0x18
 
+#define MAX_F_ERR 50
 /*
  * We are expecting to be clocked by the ARM peripheral clock.
  *
@@ -46,7 +51,8 @@
  * the units for all operations.
  */
 static void __iomem *gt_base;
-static unsigned long gt_clk_rate;
+struct notifier_block gt_clk_rate_change_nb;
+static u32 gt_psv_new, gt_psv_bck, gt_target_rate;
 static int gt_ppi;
 static struct clock_event_device __percpu *gt_evt;
 
@@ -96,7 +102,10 @@ static void gt_compare_set(unsigned long delta, int periodic)
 	unsigned long ctrl;
 
 	counter += delta;
-	ctrl = GT_CONTROL_TIMER_ENABLE;
+	ctrl = readl(gt_base + GT_CONTROL);
+	ctrl &= ~(GT_CONTROL_COMP_ENABLE | GT_CONTROL_IRQ_ENABLE |
+		  GT_CONTROL_AUTO_INC | GT_CONTROL_AUTO_INC);
+	ctrl |= GT_CONTROL_TIMER_ENABLE;
 	writel_relaxed(ctrl, gt_base + GT_CONTROL);
 	writel_relaxed(lower_32_bits(counter), gt_base + GT_COMP0);
 	writel_relaxed(upper_32_bits(counter), gt_base + GT_COMP1);
@@ -123,7 +132,7 @@ static int gt_clockevent_shutdown(struct clock_event_device *evt)
 
 static int gt_clockevent_set_periodic(struct clock_event_device *evt)
 {
-	gt_compare_set(DIV_ROUND_CLOSEST(gt_clk_rate, HZ), 1);
+	gt_compare_set(DIV_ROUND_CLOSEST(gt_target_rate, HZ), 1);
 	return 0;
 }
 
@@ -177,7 +186,7 @@ static int gt_starting_cpu(unsigned int cpu)
 	clk->cpumask = cpumask_of(cpu);
 	clk->rating = 300;
 	clk->irq = gt_ppi;
-	clockevents_config_and_register(clk, gt_clk_rate,
+	clockevents_config_and_register(clk, gt_target_rate,
 					1, 0xffffffff);
 	enable_percpu_irq(clk->irq, IRQ_TYPE_NONE);
 	return 0;
@@ -232,9 +241,28 @@ static struct delay_timer gt_delay_timer = {
 	.read_current_timer = gt_read_long,
 };
 
+static void gt_write_presc(u32 psv)
+{
+	u32 reg;
+
+	reg = readl(gt_base + GT_CONTROL);
+	reg &= ~GT_CONTROL_PRESCALER_MASK;
+	reg |= psv << GT_CONTROL_PRESCALER_SHIFT;
+	writel(reg, gt_base + GT_CONTROL);
+}
+
+static u32 gt_read_presc(void)
+{
+	u32 reg;
+
+	reg = readl(gt_base + GT_CONTROL);
+	reg &= GT_CONTROL_PRESCALER_MASK;
+	return reg >> GT_CONTROL_PRESCALER_SHIFT;
+}
+
 static void __init gt_delay_timer_init(void)
 {
-	gt_delay_timer.freq = gt_clk_rate;
+	gt_delay_timer.freq = gt_target_rate;
 	register_current_timer_delay(&gt_delay_timer);
 }
 
@@ -243,18 +271,81 @@ static int __init gt_clocksource_init(void)
 	writel(0, gt_base + GT_CONTROL);
 	writel(0, gt_base + GT_COUNTER0);
 	writel(0, gt_base + GT_COUNTER1);
-	/* enables timer on all the cores */
-	writel(GT_CONTROL_TIMER_ENABLE, gt_base + GT_CONTROL);
+	/* set prescaler and enable timer on all the cores */
+	writel(((CONFIG_ARM_GT_INITIAL_PRESCALER_VAL - 1) <<
+		GT_CONTROL_PRESCALER_SHIFT)
+	       | GT_CONTROL_TIMER_ENABLE, gt_base + GT_CONTROL);
 
 #ifdef CONFIG_CLKSRC_ARM_GLOBAL_TIMER_SCHED_CLOCK
-	sched_clock_register(gt_sched_clock_read, 64, gt_clk_rate);
+	sched_clock_register(gt_sched_clock_read, 64, gt_target_rate);
 #endif
-	return clocksource_register_hz(&gt_clocksource, gt_clk_rate);
+	return clocksource_register_hz(&gt_clocksource, gt_target_rate);
+}
+
+static int gt_clk_rate_change_cb(struct notifier_block *nb,
+				 unsigned long event, void *data)
+{
+	struct clk_notifier_data *ndata = data;
+
+	switch (event) {
+	case PRE_RATE_CHANGE:
+	{
+		int psv;
+
+		psv = DIV_ROUND_CLOSEST(ndata->new_rate,
+					gt_target_rate);
+
+		if (abs(gt_target_rate - (ndata->new_rate / psv)) > MAX_F_ERR)
+			return NOTIFY_BAD;
+
+		psv--;
+
+		/* prescaler within legal range? */
+		if (psv < 0 || psv > GT_CONTROL_PRESCALER_MAX)
+			return NOTIFY_BAD;
+
+		/*
+		 * store timer clock ctrl register so we can restore it in case
+		 * of an abort.
+		 */
+		gt_psv_bck = gt_read_presc();
+		gt_psv_new = psv;
+		/* scale down: adjust divider in post-change notification */
+		if (ndata->new_rate < ndata->old_rate)
+			return NOTIFY_DONE;
+
+		/* scale up: adjust divider now - before frequency change */
+		gt_write_presc(psv);
+		break;
+	}
+	case POST_RATE_CHANGE:
+		/* scale up: pre-change notification did the adjustment */
+		if (ndata->new_rate > ndata->old_rate)
+			return NOTIFY_OK;
+
+		/* scale down: adjust divider now - after frequency change */
+		gt_write_presc(gt_psv_new);
+		break;
+
+	case ABORT_RATE_CHANGE:
+		/* we have to undo the adjustment in case we scale up */
+		if (ndata->new_rate < ndata->old_rate)
+			return NOTIFY_OK;
+
+		/* restore original register value */
+		gt_write_presc(gt_psv_bck);
+		break;
+	default:
+		return NOTIFY_DONE;
+	}
+
+	return NOTIFY_DONE;
 }
 
 static int __init global_timer_of_register(struct device_node *np)
 {
 	struct clk *gt_clk;
+	static unsigned long gt_clk_rate;
 	int err = 0;
 
 	/*
@@ -292,11 +383,20 @@ static int __init global_timer_of_register(struct device_node *np)
 	}
 
 	gt_clk_rate = clk_get_rate(gt_clk);
+	gt_target_rate = gt_clk_rate / CONFIG_ARM_GT_INITIAL_PRESCALER_VAL;
+	gt_clk_rate_change_nb.notifier_call =
+		gt_clk_rate_change_cb;
+	err = clk_notifier_register(gt_clk, &gt_clk_rate_change_nb);
+	if (err) {
+		pr_warn("Unable to register clock notifier\n");
+		goto out_clk;
+	}
+
 	gt_evt = alloc_percpu(struct clock_event_device);
 	if (!gt_evt) {
 		pr_warn("global-timer: can't allocate memory\n");
 		err = -ENOMEM;
-		goto out_clk;
+		goto out_clk_nb;
 	}
 
 	err = request_percpu_irq(gt_ppi, gt_clockevent_interrupt,
@@ -326,6 +426,8 @@ static int __init global_timer_of_register(struct device_node *np)
 	free_percpu_irq(gt_ppi, gt_evt);
 out_free:
 	free_percpu(gt_evt);
+out_clk_nb:
+	clk_notifier_unregister(gt_clk, &gt_clk_rate_change_nb);
 out_clk:
 	clk_disable_unprepare(gt_clk);
 out_unmap:
-- 
2.17.1

