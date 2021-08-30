Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F25E3FB404
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 12:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236411AbhH3Kpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 06:45:53 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50972 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235989AbhH3Kpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 06:45:40 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630320287;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=ox681dHlFU2w+qPjiFa34Xp42MBm5hohwTxdbVR8+Pg=;
        b=cViTtmDix8tOPyqQTBq0rcjQ+XDx7+eqB1/34hSdGP4At6QrI/ZaFiBq0uhs3fZb5qHKrL
        281xyoNrrrZo7XaJpkdm2LAtHLLN3h4udiuUGQiLUAf4+IxGBRC+dPhcGoMhjBTf2kHSZL
        hCG3BQ0Iv41R9/YXEhNTVcXt1DgLEl2ncftJgqvm3FCZBi2N/QrORY2xAS4rdwXNeYnwtQ
        Gm0E5ScEep5IRKqFochdtqW8MhSeIV3bAdtUcqj0MOXlCAvBBv9NZh2eatySl5p/fP7qiD
        0+O3l7ID2svvy5RWQ+7kOxqoXGAix2dcGAIBPBqYVWPvbgjg2/earnmDnsQ+hw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630320287;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=ox681dHlFU2w+qPjiFa34Xp42MBm5hohwTxdbVR8+Pg=;
        b=DPWXjZ3Ie02qRyE0HNx3Bpa98CneIz64sp24usGrHKFX1DTWI+sZx+6NCGAY0bqHFYrLPc
        v6Rh/qy6ygpMOlAw==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] timers/core for v5.15-rc1
References: <163031993120.58256.1250660796395121952.tglx@xen13.tec.linutronix.de>
Message-ID: <163031993620.58256.3173641822017840619.tglx@xen13.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Mon, 30 Aug 2021 12:44:46 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest timers/core branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2021=
-08-30

up to:  d25a025201ed: clocksource: Make clocksource watchdog test safe for sl=
ow-HZ systems


Updates for timekeeping, timers and related drivers:

Core code:

  - Cure a couple of incorrectness issues in the posix CPU timer code to
    prevent that the tick dependency for NOHZ full is kept alive for no
    reason.

  - Avoid expensive double reprogramming of the clockevent device in
    hrtimer_start_range_ns().

  - Avoid pointless SMP function calls when the clock was set to avoid
    disturbing CPUs which do not have any affected timers queued.

  - Make the clocksource watchdog test work correctly when CONFIG_HZ is
    less than 100.

Drivers:

  - Prefer the ARM architected timer over the Exynos timer which is way
    more expensive to access.

  - Add device tree bindings for new Ingenic SoCs

  - The usual improvements and cleanups all over the place

Thanks,

	tglx

------------------>
Colin Ian King (1):
      posix-timers: Remove redundant initialization of variable ret

Ezequiel Garcia (1):
      dt-bindings: timer: convert rockchip,rk-timer.txt to YAML

Fengquan Chen (1):
      clocksource/drivers/mediatek: Optimize systimer irq clear flow on shutd=
own

Frederic Weisbecker (6):
      posix-cpu-timers: Assert task sighand is locked while starting cputime =
counter
      posix-cpu-timers: Force next_expiration recalc after timer deletion
      posix-cpu-timers: Force next expiration recalc after itimer reset
      posix-cpu-timers: Remove confusing return value override
      posix-cpu-timers: Consolidate timer base accessor
      posix-cpu-timers: Recalc next expiration when timer_settime() ends up n=
ot queueing

Linus Walleij (1):
      clocksource/drivers/fttmr010: Pass around less pointers

Marcelo Tosatti (1):
      hrtimer: Avoid unnecessary SMP function calls in clock_was_set()

Paul E. McKenney (1):
      clocksource: Make clocksource watchdog test safe for slow-HZ systems

Peter Zijlstra (1):
      hrtimer: Consolidate reprogramming code

Phong Hoang (1):
      clocksource/drivers/sh_cmt: Fix wrong setting if don't request IRQ for =
clock source channel

Sebastian Andrzej Siewior (1):
      clocksource: Replace deprecated CPU-hotplug functions.

Thomas Gleixner (10):
      hrtimer: Avoid double reprogramming in __hrtimer_start_range_ns()
      hrtimer: Ensure timerfd notification for HIGHRES=3Dn
      hrtimer: Force clock_was_set() handling for the HIGHRES=3Dn, NOHZ=3Dy c=
ase
      timerfd: Provide timerfd_resume()
      timekeeping: Distangle resume and clock-was-set events
      time/timekeeping: Avoid invoking clock_was_set() twice
      hrtimer: Add bases argument to clock_was_set()
      hrtimer: Avoid more SMP function calls in clock_was_set()
      hrtimer: Use raw_cpu_ptr() in clock_was_set()
      hrtimer: Unbreak hrtimer_force_reprogram()

Will Deacon (2):
      clocksource/drivers/exynos_mct: Prioritise Arm arch timer on arm64
      clocksource/drivers/exynos_mct: Mark MCT device as CLOCK_EVT_FEAT_PERCPU

=E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou Yanjie) (2):
      clocksource/drivers/ingenic: Use bitfield macro helpers
      dt-bindings: timer: Add ABIs for new Ingenic SoCs


 .../bindings/timer/rockchip,rk-timer.txt           |  27 --
 .../bindings/timer/rockchip,rk-timer.yaml          |  64 ++++
 drivers/clocksource/exynos_mct.c                   |  16 +-
 drivers/clocksource/ingenic-sysost.c               |  13 +-
 drivers/clocksource/sh_cmt.c                       |  30 +-
 drivers/clocksource/timer-fttmr010.c               |  32 +-
 drivers/clocksource/timer-mediatek.c               |   8 +-
 fs/timerfd.c                                       |  16 +
 include/dt-bindings/clock/ingenic,sysost.h         |  19 ++
 include/linux/hrtimer.h                            |   8 +-
 include/linux/posix-timers.h                       |  11 +-
 include/linux/sched/signal.h                       |   6 +
 kernel/signal.c                                    |  15 +
 kernel/time/clocksource-wdtest.c                   |   5 +-
 kernel/time/clocksource.c                          |   6 +-
 kernel/time/hrtimer.c                              | 340 +++++++++++++++----=
--
 kernel/time/jiffies.c                              |  21 +-
 kernel/time/posix-cpu-timers.c                     |  90 ++++--
 kernel/time/posix-timers.c                         |   2 +-
 kernel/time/tick-common.c                          |   7 +
 kernel/time/tick-internal.h                        |  32 ++
 kernel/time/timekeeping.c                          |  36 ++-
 22 files changed, 574 insertions(+), 230 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/timer/rockchip,rk-timer=
.txt
 create mode 100644 Documentation/devicetree/bindings/timer/rockchip,rk-timer=
.yaml

diff --git a/Documentation/devicetree/bindings/timer/rockchip,rk-timer.txt b/=
Documentation/devicetree/bindings/timer/rockchip,rk-timer.txt
deleted file mode 100644
index d65fdce7c7f0..000000000000
--- a/Documentation/devicetree/bindings/timer/rockchip,rk-timer.txt
+++ /dev/null
@@ -1,27 +0,0 @@
-Rockchip rk timer
-
-Required properties:
-- compatible: should be:
-  "rockchip,rv1108-timer", "rockchip,rk3288-timer": for Rockchip RV1108
-  "rockchip,rk3036-timer", "rockchip,rk3288-timer": for Rockchip RK3036
-  "rockchip,rk3066-timer", "rockchip,rk3288-timer": for Rockchip RK3066
-  "rockchip,rk3188-timer", "rockchip,rk3288-timer": for Rockchip RK3188
-  "rockchip,rk3228-timer", "rockchip,rk3288-timer": for Rockchip RK3228
-  "rockchip,rk3229-timer", "rockchip,rk3288-timer": for Rockchip RK3229
-  "rockchip,rk3288-timer": for Rockchip RK3288
-  "rockchip,rk3368-timer", "rockchip,rk3288-timer": for Rockchip RK3368
-  "rockchip,rk3399-timer": for Rockchip RK3399
-- reg: base address of the timer register starting with TIMERS CONTROL regis=
ter
-- interrupts: should contain the interrupts for Timer0
-- clocks : must contain an entry for each entry in clock-names
-- clock-names : must include the following entries:
-  "timer", "pclk"
-
-Example:
-	timer: timer@ff810000 {
-		compatible =3D "rockchip,rk3288-timer";
-		reg =3D <0xff810000 0x20>;
-		interrupts =3D <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
-		clocks =3D <&xin24m>, <&cru PCLK_TIMER>;
-		clock-names =3D "timer", "pclk";
-	};
diff --git a/Documentation/devicetree/bindings/timer/rockchip,rk-timer.yaml b=
/Documentation/devicetree/bindings/timer/rockchip,rk-timer.yaml
new file mode 100644
index 000000000000..e26ecb5893ae
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/rockchip,rk-timer.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/rockchip,rk-timer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip Timer Device Tree Bindings
+
+maintainers:
+  - Daniel Lezcano <daniel.lezcano@linaro.org>
+
+properties:
+  compatible:
+    oneOf:
+      - const: rockchip,rk3288-timer
+      - const: rockchip,rk3399-timer
+      - items:
+          - enum:
+              - rockchip,rv1108-timer
+              - rockchip,rk3036-timer
+              - rockchip,rk3066-timer
+              - rockchip,rk3188-timer
+              - rockchip,rk3228-timer
+              - rockchip,rk3229-timer
+              - rockchip,rk3288-timer
+              - rockchip,rk3368-timer
+              - rockchip,px30-timer
+          - const: rockchip,rk3288-timer
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    minItems: 2
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: pclk
+      - const: timer
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/rk3288-cru.h>
+
+    timer: timer@ff810000 {
+        compatible =3D "rockchip,rk3288-timer";
+        reg =3D <0xff810000 0x20>;
+        interrupts =3D <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
+        clocks =3D <&cru PCLK_TIMER>, <&xin24m>;
+        clock-names =3D "pclk", "timer";
+    };
diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mc=
t.c
index fabad79baafc..5e3e96d3d1b9 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -51,6 +51,15 @@
=20
 #define TICK_BASE_CNT	1
=20
+#ifdef CONFIG_ARM
+/* Use values higher than ARM arch timer. See 6282edb72bed. */
+#define MCT_CLKSOURCE_RATING		450
+#define MCT_CLKEVENTS_RATING		500
+#else
+#define MCT_CLKSOURCE_RATING		350
+#define MCT_CLKEVENTS_RATING		350
+#endif
+
 enum {
 	MCT_INT_SPI,
 	MCT_INT_PPI
@@ -206,7 +215,7 @@ static void exynos4_frc_resume(struct clocksource *cs)
=20
 static struct clocksource mct_frc =3D {
 	.name		=3D "mct-frc",
-	.rating		=3D 450,	/* use value higher than ARM arch timer */
+	.rating		=3D MCT_CLKSOURCE_RATING,
 	.read		=3D exynos4_frc_read,
 	.mask		=3D CLOCKSOURCE_MASK(32),
 	.flags		=3D CLOCK_SOURCE_IS_CONTINUOUS,
@@ -456,8 +465,9 @@ static int exynos4_mct_starting_cpu(unsigned int cpu)
 	evt->set_state_oneshot =3D set_state_shutdown;
 	evt->set_state_oneshot_stopped =3D set_state_shutdown;
 	evt->tick_resume =3D set_state_shutdown;
-	evt->features =3D CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
-	evt->rating =3D 500;	/* use value higher than ARM arch timer */
+	evt->features =3D CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT |
+			CLOCK_EVT_FEAT_PERCPU;
+	evt->rating =3D MCT_CLKEVENTS_RATING,
=20
 	exynos4_mct_write(TICK_BASE_CNT, mevt->base + MCT_L_TCNTB_OFFSET);
=20
diff --git a/drivers/clocksource/ingenic-sysost.c b/drivers/clocksource/ingen=
ic-sysost.c
index a129840f14f9..cb6fc2f152d4 100644
--- a/drivers/clocksource/ingenic-sysost.c
+++ b/drivers/clocksource/ingenic-sysost.c
@@ -4,6 +4,7 @@
  * Copyright (c) 2020 =E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou Yanjie) <zhouyanjie@=
wanyeetech.com>
  */
=20
+#include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
@@ -34,8 +35,6 @@
 /* bits within the OSTCCR register */
 #define OSTCCR_PRESCALE1_MASK	0x3
 #define OSTCCR_PRESCALE2_MASK	0xc
-#define OSTCCR_PRESCALE1_LSB	0
-#define OSTCCR_PRESCALE2_LSB	2
=20
 /* bits within the OSTCR register */
 #define OSTCR_OST1CLR			BIT(0)
@@ -98,7 +97,7 @@ static unsigned long ingenic_ost_percpu_timer_recalc_rate(s=
truct clk_hw *hw,
=20
 	prescale =3D readl(ost_clk->ost->base + info->ostccr_reg);
=20
-	prescale =3D (prescale & OSTCCR_PRESCALE1_MASK) >> OSTCCR_PRESCALE1_LSB;
+	prescale =3D FIELD_GET(OSTCCR_PRESCALE1_MASK, prescale);
=20
 	return parent_rate >> (prescale * 2);
 }
@@ -112,7 +111,7 @@ static unsigned long ingenic_ost_global_timer_recalc_rate=
(struct clk_hw *hw,
=20
 	prescale =3D readl(ost_clk->ost->base + info->ostccr_reg);
=20
-	prescale =3D (prescale & OSTCCR_PRESCALE2_MASK) >> OSTCCR_PRESCALE2_LSB;
+	prescale =3D FIELD_GET(OSTCCR_PRESCALE2_MASK, prescale);
=20
 	return parent_rate >> (prescale * 2);
 }
@@ -151,7 +150,8 @@ static int ingenic_ost_percpu_timer_set_rate(struct clk_h=
w *hw, unsigned long re
 	int val;
=20
 	val =3D readl(ost_clk->ost->base + info->ostccr_reg);
-	val =3D (val & ~OSTCCR_PRESCALE1_MASK) | (prescale << OSTCCR_PRESCALE1_LSB);
+	val &=3D ~OSTCCR_PRESCALE1_MASK;
+	val |=3D FIELD_PREP(OSTCCR_PRESCALE1_MASK, prescale);
 	writel(val, ost_clk->ost->base + info->ostccr_reg);
=20
 	return 0;
@@ -166,7 +166,8 @@ static int ingenic_ost_global_timer_set_rate(struct clk_h=
w *hw, unsigned long re
 	int val;
=20
 	val =3D readl(ost_clk->ost->base + info->ostccr_reg);
-	val =3D (val & ~OSTCCR_PRESCALE2_MASK) | (prescale << OSTCCR_PRESCALE2_LSB);
+	val &=3D ~OSTCCR_PRESCALE2_MASK;
+	val |=3D FIELD_PREP(OSTCCR_PRESCALE2_MASK, prescale);
 	writel(val, ost_clk->ost->base + info->ostccr_reg);
=20
 	return 0;
diff --git a/drivers/clocksource/sh_cmt.c b/drivers/clocksource/sh_cmt.c
index d7ed99f0001f..dd0956ad969c 100644
--- a/drivers/clocksource/sh_cmt.c
+++ b/drivers/clocksource/sh_cmt.c
@@ -579,7 +579,8 @@ static int sh_cmt_start(struct sh_cmt_channel *ch, unsign=
ed long flag)
 	ch->flags |=3D flag;
=20
 	/* setup timeout if no clockevent */
-	if ((flag =3D=3D FLAG_CLOCKSOURCE) && (!(ch->flags & FLAG_CLOCKEVENT)))
+	if (ch->cmt->num_channels =3D=3D 1 &&
+	    flag =3D=3D FLAG_CLOCKSOURCE && (!(ch->flags & FLAG_CLOCKEVENT)))
 		__sh_cmt_set_next(ch, ch->max_match_value);
  out:
 	raw_spin_unlock_irqrestore(&ch->lock, flags);
@@ -621,20 +622,25 @@ static struct sh_cmt_channel *cs_to_sh_cmt(struct clock=
source *cs)
 static u64 sh_cmt_clocksource_read(struct clocksource *cs)
 {
 	struct sh_cmt_channel *ch =3D cs_to_sh_cmt(cs);
-	unsigned long flags;
 	u32 has_wrapped;
-	u64 value;
-	u32 raw;
=20
-	raw_spin_lock_irqsave(&ch->lock, flags);
-	value =3D ch->total_cycles;
-	raw =3D sh_cmt_get_counter(ch, &has_wrapped);
+	if (ch->cmt->num_channels =3D=3D 1) {
+		unsigned long flags;
+		u64 value;
+		u32 raw;
=20
-	if (unlikely(has_wrapped))
-		raw +=3D ch->match_value + 1;
-	raw_spin_unlock_irqrestore(&ch->lock, flags);
+		raw_spin_lock_irqsave(&ch->lock, flags);
+		value =3D ch->total_cycles;
+		raw =3D sh_cmt_get_counter(ch, &has_wrapped);
+
+		if (unlikely(has_wrapped))
+			raw +=3D ch->match_value + 1;
+		raw_spin_unlock_irqrestore(&ch->lock, flags);
+
+		return value + raw;
+	}
=20
-	return value + raw;
+	return sh_cmt_get_counter(ch, &has_wrapped);
 }
=20
 static int sh_cmt_clocksource_enable(struct clocksource *cs)
@@ -697,7 +703,7 @@ static int sh_cmt_register_clocksource(struct sh_cmt_chan=
nel *ch,
 	cs->disable =3D sh_cmt_clocksource_disable;
 	cs->suspend =3D sh_cmt_clocksource_suspend;
 	cs->resume =3D sh_cmt_clocksource_resume;
-	cs->mask =3D CLOCKSOURCE_MASK(sizeof(u64) * 8);
+	cs->mask =3D CLOCKSOURCE_MASK(ch->cmt->info->width);
 	cs->flags =3D CLOCK_SOURCE_IS_CONTINUOUS;
=20
 	dev_info(&ch->cmt->pdev->dev, "ch%u: used as clock source\n",
diff --git a/drivers/clocksource/timer-fttmr010.c b/drivers/clocksource/timer=
-fttmr010.c
index edb1d5f193f5..126fb1f259b2 100644
--- a/drivers/clocksource/timer-fttmr010.c
+++ b/drivers/clocksource/timer-fttmr010.c
@@ -271,9 +271,7 @@ static irqreturn_t ast2600_timer_interrupt(int irq, void =
*dev_id)
 }
=20
 static int __init fttmr010_common_init(struct device_node *np,
-		bool is_aspeed,
-		int (*timer_shutdown)(struct clock_event_device *),
-		irq_handler_t irq_handler)
+				       bool is_aspeed, bool is_ast2600)
 {
 	struct fttmr010 *fttmr010;
 	int irq;
@@ -374,8 +372,6 @@ static int __init fttmr010_common_init(struct device_node=
 *np,
 				     fttmr010->tick_rate);
 	}
=20
-	fttmr010->timer_shutdown =3D timer_shutdown;
-
 	/*
 	 * Setup clockevent timer (interrupt-driven) on timer 1.
 	 */
@@ -383,8 +379,18 @@ static int __init fttmr010_common_init(struct device_nod=
e *np,
 	writel(0, fttmr010->base + TIMER1_LOAD);
 	writel(0, fttmr010->base + TIMER1_MATCH1);
 	writel(0, fttmr010->base + TIMER1_MATCH2);
-	ret =3D request_irq(irq, irq_handler, IRQF_TIMER,
-			  "FTTMR010-TIMER1", &fttmr010->clkevt);
+
+	if (is_ast2600) {
+		fttmr010->timer_shutdown =3D ast2600_timer_shutdown;
+		ret =3D request_irq(irq, ast2600_timer_interrupt,
+				  IRQF_TIMER, "FTTMR010-TIMER1",
+				  &fttmr010->clkevt);
+	} else {
+		fttmr010->timer_shutdown =3D fttmr010_timer_shutdown;
+		ret =3D request_irq(irq, fttmr010_timer_interrupt,
+				  IRQF_TIMER, "FTTMR010-TIMER1",
+				  &fttmr010->clkevt);
+	}
 	if (ret) {
 		pr_err("FTTMR010-TIMER1 no IRQ\n");
 		goto out_unmap;
@@ -432,23 +438,17 @@ static int __init fttmr010_common_init(struct device_no=
de *np,
=20
 static __init int ast2600_timer_init(struct device_node *np)
 {
-	return fttmr010_common_init(np, true,
-			ast2600_timer_shutdown,
-			ast2600_timer_interrupt);
+	return fttmr010_common_init(np, true, true);
 }
=20
 static __init int aspeed_timer_init(struct device_node *np)
 {
-	return fttmr010_common_init(np, true,
-			fttmr010_timer_shutdown,
-			fttmr010_timer_interrupt);
+	return fttmr010_common_init(np, true, false);
 }
=20
 static __init int fttmr010_timer_init(struct device_node *np)
 {
-	return fttmr010_common_init(np, false,
-			fttmr010_timer_shutdown,
-			fttmr010_timer_interrupt);
+	return fttmr010_common_init(np, false, false);
 }
=20
 TIMER_OF_DECLARE(fttmr010, "faraday,fttmr010", fttmr010_timer_init);
diff --git a/drivers/clocksource/timer-mediatek.c b/drivers/clocksource/timer=
-mediatek.c
index ab63b95e414f..7bcb4a3f26fb 100644
--- a/drivers/clocksource/timer-mediatek.c
+++ b/drivers/clocksource/timer-mediatek.c
@@ -60,9 +60,9 @@
  * SYST_CON_EN: Clock enable. Shall be set to
  *   - Start timer countdown.
  *   - Allow timeout ticks being updated.
- *   - Allow changing interrupt functions.
+ *   - Allow changing interrupt status,like clear irq pending.
  *
- * SYST_CON_IRQ_EN: Set to allow interrupt.
+ * SYST_CON_IRQ_EN: Set to enable interrupt.
  *
  * SYST_CON_IRQ_CLR: Set to clear interrupt.
  */
@@ -75,6 +75,7 @@ static void __iomem *gpt_sched_reg __read_mostly;
 static void mtk_syst_ack_irq(struct timer_of *to)
 {
 	/* Clear and disable interrupt */
+	writel(SYST_CON_EN, SYST_CON_REG(to));
 	writel(SYST_CON_IRQ_CLR | SYST_CON_EN, SYST_CON_REG(to));
 }
=20
@@ -111,6 +112,9 @@ static int mtk_syst_clkevt_next_event(unsigned long ticks,
=20
 static int mtk_syst_clkevt_shutdown(struct clock_event_device *clkevt)
 {
+	/* Clear any irq */
+	mtk_syst_ack_irq(to_timer_of(clkevt));
+
 	/* Disable timer */
 	writel(0, SYST_CON_REG(to_timer_of(clkevt)));
=20
diff --git a/fs/timerfd.c b/fs/timerfd.c
index c5509d2448e3..e9c96a0c79f1 100644
--- a/fs/timerfd.c
+++ b/fs/timerfd.c
@@ -115,6 +115,22 @@ void timerfd_clock_was_set(void)
 	rcu_read_unlock();
 }
=20
+static void timerfd_resume_work(struct work_struct *work)
+{
+	timerfd_clock_was_set();
+}
+
+static DECLARE_WORK(timerfd_work, timerfd_resume_work);
+
+/*
+ * Invoked from timekeeping_resume(). Defer the actual update to work so
+ * timerfd_clock_was_set() runs in task context.
+ */
+void timerfd_resume(void)
+{
+	schedule_work(&timerfd_work);
+}
+
 static void __timerfd_remove_cancel(struct timerfd_ctx *ctx)
 {
 	if (ctx->might_cancel) {
diff --git a/include/dt-bindings/clock/ingenic,sysost.h b/include/dt-bindings=
/clock/ingenic,sysost.h
index 063791b01ab3..d7aa42c08ded 100644
--- a/include/dt-bindings/clock/ingenic,sysost.h
+++ b/include/dt-bindings/clock/ingenic,sysost.h
@@ -13,4 +13,23 @@
 #define OST_CLK_PERCPU_TIMER2	3
 #define OST_CLK_PERCPU_TIMER3	4
=20
+#define OST_CLK_EVENT_TIMER		1
+
+#define OST_CLK_EVENT_TIMER0	0
+#define OST_CLK_EVENT_TIMER1	1
+#define OST_CLK_EVENT_TIMER2	2
+#define OST_CLK_EVENT_TIMER3	3
+#define OST_CLK_EVENT_TIMER4	4
+#define OST_CLK_EVENT_TIMER5	5
+#define OST_CLK_EVENT_TIMER6	6
+#define OST_CLK_EVENT_TIMER7	7
+#define OST_CLK_EVENT_TIMER8	8
+#define OST_CLK_EVENT_TIMER9	9
+#define OST_CLK_EVENT_TIMER10	10
+#define OST_CLK_EVENT_TIMER11	11
+#define OST_CLK_EVENT_TIMER12	12
+#define OST_CLK_EVENT_TIMER13	13
+#define OST_CLK_EVENT_TIMER14	14
+#define OST_CLK_EVENT_TIMER15	15
+
 #endif /* __DT_BINDINGS_CLOCK_INGENIC_OST_H__ */
diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index bb5e7b0a4274..0ee140176f10 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -318,16 +318,12 @@ struct clock_event_device;
=20
 extern void hrtimer_interrupt(struct clock_event_device *dev);
=20
-extern void clock_was_set_delayed(void);
-
 extern unsigned int hrtimer_resolution;
=20
 #else
=20
 #define hrtimer_resolution	(unsigned int)LOW_RES_NSEC
=20
-static inline void clock_was_set_delayed(void) { }
-
 #endif
=20
 static inline ktime_t
@@ -351,13 +347,13 @@ hrtimer_expires_remaining_adjusted(const struct hrtimer=
 *timer)
 						    timer->base->get_time());
 }
=20
-extern void clock_was_set(void);
 #ifdef CONFIG_TIMERFD
 extern void timerfd_clock_was_set(void);
+extern void timerfd_resume(void);
 #else
 static inline void timerfd_clock_was_set(void) { }
+static inline void timerfd_resume(void) { }
 #endif
-extern void hrtimers_resume(void);
=20
 DECLARE_PER_CPU(struct tick_device, tick_cpu_device);
=20
diff --git a/include/linux/posix-timers.h b/include/linux/posix-timers.h
index 896c16d2c5fb..00fef0064355 100644
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -82,12 +82,19 @@ static inline bool cpu_timer_enqueue(struct timerqueue_he=
ad *head,
 	return timerqueue_add(head, &ctmr->node);
 }
=20
-static inline void cpu_timer_dequeue(struct cpu_timer *ctmr)
+static inline bool cpu_timer_queued(struct cpu_timer *ctmr)
 {
-	if (ctmr->head) {
+	return !!ctmr->head;
+}
+
+static inline bool cpu_timer_dequeue(struct cpu_timer *ctmr)
+{
+	if (cpu_timer_queued(ctmr)) {
 		timerqueue_del(ctmr->head, &ctmr->node);
 		ctmr->head =3D NULL;
+		return true;
 	}
+	return false;
 }
=20
 static inline u64 cpu_timer_getexpires(struct cpu_timer *ctmr)
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index b9126fe06c3f..0310a5add9ab 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -714,6 +714,12 @@ static inline void unlock_task_sighand(struct task_struc=
t *task,
 	spin_unlock_irqrestore(&task->sighand->siglock, *flags);
 }
=20
+#ifdef CONFIG_LOCKDEP
+extern void lockdep_assert_task_sighand_held(struct task_struct *task);
+#else
+static inline void lockdep_assert_task_sighand_held(struct task_struct *task=
) { }
+#endif
+
 static inline unsigned long task_rlimit(const struct task_struct *task,
 		unsigned int limit)
 {
diff --git a/kernel/signal.c b/kernel/signal.c
index a3229add4455..52b6abec0ff8 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1413,6 +1413,21 @@ struct sighand_struct *__lock_task_sighand(struct task=
_struct *tsk,
 	return sighand;
 }
=20
+#ifdef CONFIG_LOCKDEP
+void lockdep_assert_task_sighand_held(struct task_struct *task)
+{
+	struct sighand_struct *sighand;
+
+	rcu_read_lock();
+	sighand =3D rcu_dereference(task->sighand);
+	if (sighand)
+		lockdep_assert_held(&sighand->siglock);
+	else
+		WARN_ON_ONCE(1);
+	rcu_read_unlock();
+}
+#endif
+
 /*
  * send signal info to all the members of a group
  */
diff --git a/kernel/time/clocksource-wdtest.c b/kernel/time/clocksource-wdtes=
t.c
index 01df12395c0e..df922f49d171 100644
--- a/kernel/time/clocksource-wdtest.c
+++ b/kernel/time/clocksource-wdtest.c
@@ -19,6 +19,8 @@
 #include <linux/prandom.h>
 #include <linux/cpu.h>
=20
+#include "tick-internal.h"
+
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Paul E. McKenney <paulmck@kernel.org>");
=20
@@ -34,9 +36,6 @@ static u64 wdtest_jiffies_read(struct clocksource *cs)
 	return (u64)jiffies;
 }
=20
-/* Assume HZ > 100. */
-#define JIFFIES_SHIFT	8
-
 static struct clocksource clocksource_wdtest_jiffies =3D {
 	.name			=3D "wdtest-jiffies",
 	.rating			=3D 1, /* lowest valid rating*/
diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index b89c76e1c02c..b8a14d2fb5ba 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -306,12 +306,12 @@ void clocksource_verify_percpu(struct clocksource *cs)
 		return;
 	cpumask_clear(&cpus_ahead);
 	cpumask_clear(&cpus_behind);
-	get_online_cpus();
+	cpus_read_lock();
 	preempt_disable();
 	clocksource_verify_choose_cpus();
 	if (cpumask_weight(&cpus_chosen) =3D=3D 0) {
 		preempt_enable();
-		put_online_cpus();
+		cpus_read_unlock();
 		pr_warn("Not enough CPUs to check clocksource '%s'.\n", cs->name);
 		return;
 	}
@@ -337,7 +337,7 @@ void clocksource_verify_percpu(struct clocksource *cs)
 			cs_nsec_min =3D cs_nsec;
 	}
 	preempt_enable();
-	put_online_cpus();
+	cpus_read_unlock();
 	if (!cpumask_empty(&cpus_ahead))
 		pr_warn("        CPUs %*pbl ahead of CPU %d for clocksource %s.\n",
 			cpumask_pr_args(&cpus_ahead), testcpu, cs->name);
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 4a66725b1d4a..0ea8702eb516 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -652,21 +652,10 @@ static inline int hrtimer_hres_active(void)
 	return __hrtimer_hres_active(this_cpu_ptr(&hrtimer_bases));
 }
=20
-/*
- * Reprogram the event source with checking both queues for the
- * next event
- * Called with interrupts disabled and base->lock held
- */
-static void
-hrtimer_force_reprogram(struct hrtimer_cpu_base *cpu_base, int skip_equal)
+static void __hrtimer_reprogram(struct hrtimer_cpu_base *cpu_base,
+				struct hrtimer *next_timer,
+				ktime_t expires_next)
 {
-	ktime_t expires_next;
-
-	expires_next =3D hrtimer_update_next_event(cpu_base);
-
-	if (skip_equal && expires_next =3D=3D cpu_base->expires_next)
-		return;
-
 	cpu_base->expires_next =3D expires_next;
=20
 	/*
@@ -689,7 +678,25 @@ hrtimer_force_reprogram(struct hrtimer_cpu_base *cpu_bas=
e, int skip_equal)
 	if (!__hrtimer_hres_active(cpu_base) || cpu_base->hang_detected)
 		return;
=20
-	tick_program_event(cpu_base->expires_next, 1);
+	tick_program_event(expires_next, 1);
+}
+
+/*
+ * Reprogram the event source with checking both queues for the
+ * next event
+ * Called with interrupts disabled and base->lock held
+ */
+static void
+hrtimer_force_reprogram(struct hrtimer_cpu_base *cpu_base, int skip_equal)
+{
+	ktime_t expires_next;
+
+	expires_next =3D hrtimer_update_next_event(cpu_base);
+
+	if (skip_equal && expires_next =3D=3D cpu_base->expires_next)
+		return;
+
+	__hrtimer_reprogram(cpu_base, cpu_base->next_timer, expires_next);
 }
=20
 /* High resolution timer related functions */
@@ -720,23 +727,7 @@ static inline int hrtimer_is_hres_enabled(void)
 	return hrtimer_hres_enabled;
 }
=20
-/*
- * Retrigger next event is called after clock was set
- *
- * Called with interrupts disabled via on_each_cpu()
- */
-static void retrigger_next_event(void *arg)
-{
-	struct hrtimer_cpu_base *base =3D this_cpu_ptr(&hrtimer_bases);
-
-	if (!__hrtimer_hres_active(base))
-		return;
-
-	raw_spin_lock(&base->lock);
-	hrtimer_update_base(base);
-	hrtimer_force_reprogram(base, 0);
-	raw_spin_unlock(&base->lock);
-}
+static void retrigger_next_event(void *arg);
=20
 /*
  * Switch to high resolution mode
@@ -758,29 +749,54 @@ static void hrtimer_switch_to_hres(void)
 	retrigger_next_event(NULL);
 }
=20
-static void clock_was_set_work(struct work_struct *work)
-{
-	clock_was_set();
-}
+#else
=20
-static DECLARE_WORK(hrtimer_work, clock_was_set_work);
+static inline int hrtimer_is_hres_enabled(void) { return 0; }
+static inline void hrtimer_switch_to_hres(void) { }
=20
+#endif /* CONFIG_HIGH_RES_TIMERS */
 /*
- * Called from timekeeping and resume code to reprogram the hrtimer
- * interrupt device on all cpus.
+ * Retrigger next event is called after clock was set with interrupts
+ * disabled through an SMP function call or directly from low level
+ * resume code.
+ *
+ * This is only invoked when:
+ *	- CONFIG_HIGH_RES_TIMERS is enabled.
+ *	- CONFIG_NOHZ_COMMON is enabled
+ *
+ * For the other cases this function is empty and because the call sites
+ * are optimized out it vanishes as well, i.e. no need for lots of
+ * #ifdeffery.
  */
-void clock_was_set_delayed(void)
+static void retrigger_next_event(void *arg)
 {
-	schedule_work(&hrtimer_work);
-}
-
-#else
+	struct hrtimer_cpu_base *base =3D this_cpu_ptr(&hrtimer_bases);
=20
-static inline int hrtimer_is_hres_enabled(void) { return 0; }
-static inline void hrtimer_switch_to_hres(void) { }
-static inline void retrigger_next_event(void *arg) { }
+	/*
+	 * When high resolution mode or nohz is active, then the offsets of
+	 * CLOCK_REALTIME/TAI/BOOTTIME have to be updated. Otherwise the
+	 * next tick will take care of that.
+	 *
+	 * If high resolution mode is active then the next expiring timer
+	 * must be reevaluated and the clock event device reprogrammed if
+	 * necessary.
+	 *
+	 * In the NOHZ case the update of the offset and the reevaluation
+	 * of the next expiring timer is enough. The return from the SMP
+	 * function call will take care of the reprogramming in case the
+	 * CPU was in a NOHZ idle sleep.
+	 */
+	if (!__hrtimer_hres_active(base) && !tick_nohz_active)
+		return;
=20
-#endif /* CONFIG_HIGH_RES_TIMERS */
+	raw_spin_lock(&base->lock);
+	hrtimer_update_base(base);
+	if (__hrtimer_hres_active(base))
+		hrtimer_force_reprogram(base, 0);
+	else
+		hrtimer_update_next_event(base);
+	raw_spin_unlock(&base->lock);
+}
=20
 /*
  * When a timer is enqueued and expires earlier than the already enqueued
@@ -835,75 +851,161 @@ static void hrtimer_reprogram(struct hrtimer *timer, b=
ool reprogram)
 	if (base->cpu_base !=3D cpu_base)
 		return;
=20
+	if (expires >=3D cpu_base->expires_next)
+		return;
+
 	/*
-	 * If the hrtimer interrupt is running, then it will
-	 * reevaluate the clock bases and reprogram the clock event
-	 * device. The callbacks are always executed in hard interrupt
-	 * context so we don't need an extra check for a running
-	 * callback.
+	 * If the hrtimer interrupt is running, then it will reevaluate the
+	 * clock bases and reprogram the clock event device.
 	 */
 	if (cpu_base->in_hrtirq)
 		return;
=20
-	if (expires >=3D cpu_base->expires_next)
-		return;
-
-	/* Update the pointer to the next expiring timer */
 	cpu_base->next_timer =3D timer;
-	cpu_base->expires_next =3D expires;
+
+	__hrtimer_reprogram(cpu_base, timer, expires);
+}
+
+static bool update_needs_ipi(struct hrtimer_cpu_base *cpu_base,
+			     unsigned int active)
+{
+	struct hrtimer_clock_base *base;
+	unsigned int seq;
+	ktime_t expires;
=20
 	/*
-	 * If hres is not active, hardware does not have to be
-	 * programmed yet.
+	 * Update the base offsets unconditionally so the following
+	 * checks whether the SMP function call is required works.
 	 *
-	 * If a hang was detected in the last timer interrupt then we
-	 * do not schedule a timer which is earlier than the expiry
-	 * which we enforced in the hang detection. We want the system
-	 * to make progress.
+	 * The update is safe even when the remote CPU is in the hrtimer
+	 * interrupt or the hrtimer soft interrupt and expiring affected
+	 * bases. Either it will see the update before handling a base or
+	 * it will see it when it finishes the processing and reevaluates
+	 * the next expiring timer.
 	 */
-	if (!__hrtimer_hres_active(cpu_base) || cpu_base->hang_detected)
-		return;
+	seq =3D cpu_base->clock_was_set_seq;
+	hrtimer_update_base(cpu_base);
+
+	/*
+	 * If the sequence did not change over the update then the
+	 * remote CPU already handled it.
+	 */
+	if (seq =3D=3D cpu_base->clock_was_set_seq)
+		return false;
+
+	/*
+	 * If the remote CPU is currently handling an hrtimer interrupt, it
+	 * will reevaluate the first expiring timer of all clock bases
+	 * before reprogramming. Nothing to do here.
+	 */
+	if (cpu_base->in_hrtirq)
+		return false;
=20
 	/*
-	 * Program the timer hardware. We enforce the expiry for
-	 * events which are already in the past.
+	 * Walk the affected clock bases and check whether the first expiring
+	 * timer in a clock base is moving ahead of the first expiring timer of
+	 * @cpu_base. If so, the IPI must be invoked because per CPU clock
+	 * event devices cannot be remotely reprogrammed.
 	 */
-	tick_program_event(expires, 1);
+	active &=3D cpu_base->active_bases;
+
+	for_each_active_base(base, cpu_base, active) {
+		struct timerqueue_node *next;
+
+		next =3D timerqueue_getnext(&base->active);
+		expires =3D ktime_sub(next->expires, base->offset);
+		if (expires < cpu_base->expires_next)
+			return true;
+
+		/* Extra check for softirq clock bases */
+		if (base->clockid < HRTIMER_BASE_MONOTONIC_SOFT)
+			continue;
+		if (cpu_base->softirq_activated)
+			continue;
+		if (expires < cpu_base->softirq_expires_next)
+			return true;
+	}
+	return false;
 }
=20
 /*
- * Clock realtime was set
- *
- * Change the offset of the realtime clock vs. the monotonic
- * clock.
+ * Clock was set. This might affect CLOCK_REALTIME, CLOCK_TAI and
+ * CLOCK_BOOTTIME (for late sleep time injection).
  *
- * We might have to reprogram the high resolution timer interrupt. On
- * SMP we call the architecture specific code to retrigger _all_ high
- * resolution timer interrupts. On UP we just disable interrupts and
- * call the high resolution interrupt code.
+ * This requires to update the offsets for these clocks
+ * vs. CLOCK_MONOTONIC. When high resolution timers are enabled, then this
+ * also requires to eventually reprogram the per CPU clock event devices
+ * when the change moves an affected timer ahead of the first expiring
+ * timer on that CPU. Obviously remote per CPU clock event devices cannot
+ * be reprogrammed. The other reason why an IPI has to be sent is when the
+ * system is in !HIGH_RES and NOHZ mode. The NOHZ mode updates the offsets
+ * in the tick, which obviously might be stopped, so this has to bring out
+ * the remote CPU which might sleep in idle to get this sorted.
  */
-void clock_was_set(void)
+void clock_was_set(unsigned int bases)
 {
-#ifdef CONFIG_HIGH_RES_TIMERS
-	/* Retrigger the CPU local events everywhere */
-	on_each_cpu(retrigger_next_event, NULL, 1);
-#endif
+	struct hrtimer_cpu_base *cpu_base =3D raw_cpu_ptr(&hrtimer_bases);
+	cpumask_var_t mask;
+	int cpu;
+
+	if (!__hrtimer_hres_active(cpu_base) && !tick_nohz_active)
+		goto out_timerfd;
+
+	if (!zalloc_cpumask_var(&mask, GFP_KERNEL)) {
+		on_each_cpu(retrigger_next_event, NULL, 1);
+		goto out_timerfd;
+	}
+
+	/* Avoid interrupting CPUs if possible */
+	cpus_read_lock();
+	for_each_online_cpu(cpu) {
+		unsigned long flags;
+
+		cpu_base =3D &per_cpu(hrtimer_bases, cpu);
+		raw_spin_lock_irqsave(&cpu_base->lock, flags);
+
+		if (update_needs_ipi(cpu_base, bases))
+			cpumask_set_cpu(cpu, mask);
+
+		raw_spin_unlock_irqrestore(&cpu_base->lock, flags);
+	}
+
+	preempt_disable();
+	smp_call_function_many(mask, retrigger_next_event, NULL, 1);
+	preempt_enable();
+	cpus_read_unlock();
+	free_cpumask_var(mask);
+
+out_timerfd:
 	timerfd_clock_was_set();
 }
=20
+static void clock_was_set_work(struct work_struct *work)
+{
+	clock_was_set(CLOCK_SET_WALL);
+}
+
+static DECLARE_WORK(hrtimer_work, clock_was_set_work);
+
+/*
+ * Called from timekeeping code to reprogram the hrtimer interrupt device
+ * on all cpus and to notify timerfd.
+ */
+void clock_was_set_delayed(void)
+{
+	schedule_work(&hrtimer_work);
+}
+
 /*
- * During resume we might have to reprogram the high resolution timer
- * interrupt on all online CPUs.  However, all other CPUs will be
- * stopped with IRQs interrupts disabled so the clock_was_set() call
- * must be deferred.
+ * Called during resume either directly from via timekeeping_resume()
+ * or in the case of s2idle from tick_unfreeze() to ensure that the
+ * hrtimers are up to date.
  */
-void hrtimers_resume(void)
+void hrtimers_resume_local(void)
 {
 	lockdep_assert_irqs_disabled();
 	/* Retrigger on the local CPU */
 	retrigger_next_event(NULL);
-	/* And schedule a retrigger for all others */
-	clock_was_set_delayed();
 }
=20
 /*
@@ -1030,12 +1132,13 @@ static void __remove_hrtimer(struct hrtimer *timer,
  * remove hrtimer, called with base lock held
  */
 static inline int
-remove_hrtimer(struct hrtimer *timer, struct hrtimer_clock_base *base, bool =
restart)
+remove_hrtimer(struct hrtimer *timer, struct hrtimer_clock_base *base,
+	       bool restart, bool keep_local)
 {
 	u8 state =3D timer->state;
=20
 	if (state & HRTIMER_STATE_ENQUEUED) {
-		int reprogram;
+		bool reprogram;
=20
 		/*
 		 * Remove the timer and force reprogramming when high
@@ -1048,8 +1151,16 @@ remove_hrtimer(struct hrtimer *timer, struct hrtimer_c=
lock_base *base, bool rest
 		debug_deactivate(timer);
 		reprogram =3D base->cpu_base =3D=3D this_cpu_ptr(&hrtimer_bases);
=20
+		/*
+		 * If the timer is not restarted then reprogramming is
+		 * required if the timer is local. If it is local and about
+		 * to be restarted, avoid programming it twice (on removal
+		 * and a moment later when it's requeued).
+		 */
 		if (!restart)
 			state =3D HRTIMER_STATE_INACTIVE;
+		else
+			reprogram &=3D !keep_local;
=20
 		__remove_hrtimer(timer, base, state, reprogram);
 		return 1;
@@ -1103,9 +1214,31 @@ static int __hrtimer_start_range_ns(struct hrtimer *ti=
mer, ktime_t tim,
 				    struct hrtimer_clock_base *base)
 {
 	struct hrtimer_clock_base *new_base;
+	bool force_local, first;
=20
-	/* Remove an active timer from the queue: */
-	remove_hrtimer(timer, base, true);
+	/*
+	 * If the timer is on the local cpu base and is the first expiring
+	 * timer then this might end up reprogramming the hardware twice
+	 * (on removal and on enqueue). To avoid that by prevent the
+	 * reprogram on removal, keep the timer local to the current CPU
+	 * and enforce reprogramming after it is queued no matter whether
+	 * it is the new first expiring timer again or not.
+	 */
+	force_local =3D base->cpu_base =3D=3D this_cpu_ptr(&hrtimer_bases);
+	force_local &=3D base->cpu_base->next_timer =3D=3D timer;
+
+	/*
+	 * Remove an active timer from the queue. In case it is not queued
+	 * on the current CPU, make sure that remove_hrtimer() updates the
+	 * remote data correctly.
+	 *
+	 * If it's on the current CPU and the first expiring timer, then
+	 * skip reprogramming, keep the timer local and enforce
+	 * reprogramming later if it was the first expiring timer.  This
+	 * avoids programming the underlying clock event twice (once at
+	 * removal and once after enqueue).
+	 */
+	remove_hrtimer(timer, base, true, force_local);
=20
 	if (mode & HRTIMER_MODE_REL)
 		tim =3D ktime_add_safe(tim, base->get_time());
@@ -1115,9 +1248,24 @@ static int __hrtimer_start_range_ns(struct hrtimer *ti=
mer, ktime_t tim,
 	hrtimer_set_expires_range_ns(timer, tim, delta_ns);
=20
 	/* Switch the timer base, if necessary: */
-	new_base =3D switch_hrtimer_base(timer, base, mode & HRTIMER_MODE_PINNED);
+	if (!force_local) {
+		new_base =3D switch_hrtimer_base(timer, base,
+					       mode & HRTIMER_MODE_PINNED);
+	} else {
+		new_base =3D base;
+	}
=20
-	return enqueue_hrtimer(timer, new_base, mode);
+	first =3D enqueue_hrtimer(timer, new_base, mode);
+	if (!force_local)
+		return first;
+
+	/*
+	 * Timer was forced to stay on the current CPU to avoid
+	 * reprogramming on removal and enqueue. Force reprogram the
+	 * hardware by evaluating the new first expiring timer.
+	 */
+	hrtimer_force_reprogram(new_base->cpu_base, 1);
+	return 0;
 }
=20
 /**
@@ -1183,7 +1331,7 @@ int hrtimer_try_to_cancel(struct hrtimer *timer)
 	base =3D lock_hrtimer_base(timer, &flags);
=20
 	if (!hrtimer_callback_running(timer))
-		ret =3D remove_hrtimer(timer, base, false);
+		ret =3D remove_hrtimer(timer, base, false, false);
=20
 	unlock_hrtimer_base(timer, &flags);
=20
diff --git a/kernel/time/jiffies.c b/kernel/time/jiffies.c
index 01935aafdb46..bc4db9e5ab70 100644
--- a/kernel/time/jiffies.c
+++ b/kernel/time/jiffies.c
@@ -10,28 +10,9 @@
 #include <linux/init.h>
=20
 #include "timekeeping.h"
+#include "tick-internal.h"
=20
=20
-/* Since jiffies uses a simple TICK_NSEC multiplier
- * conversion, the .shift value could be zero. However
- * this would make NTP adjustments impossible as they are
- * in units of 1/2^.shift. Thus we use JIFFIES_SHIFT to
- * shift both the nominator and denominator the same
- * amount, and give ntp adjustments in units of 1/2^8
- *
- * The value 8 is somewhat carefully chosen, as anything
- * larger can result in overflows. TICK_NSEC grows as HZ
- * shrinks, so values greater than 8 overflow 32bits when
- * HZ=3D100.
- */
-#if HZ < 34
-#define JIFFIES_SHIFT	6
-#elif HZ < 67
-#define JIFFIES_SHIFT	7
-#else
-#define JIFFIES_SHIFT	8
-#endif
-
 static u64 jiffies_read(struct clocksource *cs)
 {
 	return (u64) jiffies;
diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 517be7fd175e..ee736861b18f 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -291,6 +291,8 @@ static void thread_group_start_cputime(struct task_struct=
 *tsk, u64 *samples)
 	struct thread_group_cputimer *cputimer =3D &tsk->signal->cputimer;
 	struct posix_cputimers *pct =3D &tsk->signal->posix_cputimers;
=20
+	lockdep_assert_task_sighand_held(tsk);
+
 	/* Check if cputimer isn't running. This is accessed without locking. */
 	if (!READ_ONCE(pct->timers_active)) {
 		struct task_cputime sum;
@@ -405,6 +407,55 @@ static int posix_cpu_timer_create(struct k_itimer *new_t=
imer)
 	return 0;
 }
=20
+static struct posix_cputimer_base *timer_base(struct k_itimer *timer,
+					      struct task_struct *tsk)
+{
+	int clkidx =3D CPUCLOCK_WHICH(timer->it_clock);
+
+	if (CPUCLOCK_PERTHREAD(timer->it_clock))
+		return tsk->posix_cputimers.bases + clkidx;
+	else
+		return tsk->signal->posix_cputimers.bases + clkidx;
+}
+
+/*
+ * Force recalculating the base earliest expiration on the next tick.
+ * This will also re-evaluate the need to keep around the process wide
+ * cputime counter and tick dependency and eventually shut these down
+ * if necessary.
+ */
+static void trigger_base_recalc_expires(struct k_itimer *timer,
+					struct task_struct *tsk)
+{
+	struct posix_cputimer_base *base =3D timer_base(timer, tsk);
+
+	base->nextevt =3D 0;
+}
+
+/*
+ * Dequeue the timer and reset the base if it was its earliest expiration.
+ * It makes sure the next tick recalculates the base next expiration so we
+ * don't keep the costly process wide cputime counter around for a random
+ * amount of time, along with the tick dependency.
+ *
+ * If another timer gets queued between this and the next tick, its
+ * expiration will update the base next event if necessary on the next
+ * tick.
+ */
+static void disarm_timer(struct k_itimer *timer, struct task_struct *p)
+{
+	struct cpu_timer *ctmr =3D &timer->it.cpu;
+	struct posix_cputimer_base *base;
+
+	if (!cpu_timer_dequeue(ctmr))
+		return;
+
+	base =3D timer_base(timer, p);
+	if (cpu_timer_getexpires(ctmr) =3D=3D base->nextevt)
+		trigger_base_recalc_expires(timer, p);
+}
+
+
 /*
  * Clean up a CPU-clock timer that is about to be destroyed.
  * This is called from timer deletion with the timer already locked.
@@ -439,7 +490,7 @@ static int posix_cpu_timer_del(struct k_itimer *timer)
 		if (timer->it.cpu.firing)
 			ret =3D TIMER_RETRY;
 		else
-			cpu_timer_dequeue(ctmr);
+			disarm_timer(timer, p);
=20
 		unlock_task_sighand(p, &flags);
 	}
@@ -498,15 +549,9 @@ void posix_cpu_timers_exit_group(struct task_struct *tsk)
  */
 static void arm_timer(struct k_itimer *timer, struct task_struct *p)
 {
-	int clkidx =3D CPUCLOCK_WHICH(timer->it_clock);
+	struct posix_cputimer_base *base =3D timer_base(timer, p);
 	struct cpu_timer *ctmr =3D &timer->it.cpu;
 	u64 newexp =3D cpu_timer_getexpires(ctmr);
-	struct posix_cputimer_base *base;
-
-	if (CPUCLOCK_PERTHREAD(timer->it_clock))
-		base =3D p->posix_cputimers.bases + clkidx;
-	else
-		base =3D p->signal->posix_cputimers.bases + clkidx;
=20
 	if (!cpu_timer_enqueue(&base->tqhead, ctmr))
 		return;
@@ -703,16 +748,29 @@ static int posix_cpu_timer_set(struct k_itimer *timer, =
int timer_flags,
 	timer->it_overrun_last =3D 0;
 	timer->it_overrun =3D -1;
=20
-	if (new_expires !=3D 0 && !(val < new_expires)) {
+	if (val >=3D new_expires) {
+		if (new_expires !=3D 0) {
+			/*
+			 * The designated time already passed, so we notify
+			 * immediately, even if the thread never runs to
+			 * accumulate more time on this clock.
+			 */
+			cpu_timer_fire(timer);
+		}
+
 		/*
-		 * The designated time already passed, so we notify
-		 * immediately, even if the thread never runs to
-		 * accumulate more time on this clock.
+		 * Make sure we don't keep around the process wide cputime
+		 * counter or the tick dependency if they are not necessary.
 		 */
-		cpu_timer_fire(timer);
-	}
+		sighand =3D lock_task_sighand(p, &flags);
+		if (!sighand)
+			goto out;
+
+		if (!cpu_timer_queued(ctmr))
+			trigger_base_recalc_expires(timer, p);
=20
-	ret =3D 0;
+		unlock_task_sighand(p, &flags);
+	}
  out:
 	rcu_read_unlock();
 	if (old)
@@ -1346,8 +1404,6 @@ void set_process_cpu_timer(struct task_struct *tsk, uns=
igned int clkid,
 			}
 		}
=20
-		if (!*newval)
-			return;
 		*newval +=3D now;
 	}
=20
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index dd5697d7347b..3913222e7bcf 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -336,7 +336,7 @@ void posixtimer_rearm(struct kernel_siginfo *info)
 int posix_timer_event(struct k_itimer *timr, int si_private)
 {
 	enum pid_type type;
-	int ret =3D -1;
+	int ret;
 	/*
 	 * FIXME: if ->sigq is queued we can race with
 	 * dequeue_signal()->posixtimer_rearm().
diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index d663249652ef..46789356f856 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -470,6 +470,13 @@ void tick_resume_local(void)
 		else
 			tick_resume_oneshot();
 	}
+
+	/*
+	 * Ensure that hrtimers are up to date and the clockevents device
+	 * is reprogrammed correctly when high resolution timers are
+	 * enabled.
+	 */
+	hrtimers_resume_local();
 }
=20
 /**
diff --git a/kernel/time/tick-internal.h b/kernel/time/tick-internal.h
index 6a742a29e545..649f2b48e8f0 100644
--- a/kernel/time/tick-internal.h
+++ b/kernel/time/tick-internal.h
@@ -165,3 +165,35 @@ DECLARE_PER_CPU(struct hrtimer_cpu_base, hrtimer_bases);
=20
 extern u64 get_next_timer_interrupt(unsigned long basej, u64 basem);
 void timer_clear_idle(void);
+
+#define CLOCK_SET_WALL							\
+	(BIT(HRTIMER_BASE_REALTIME) | BIT(HRTIMER_BASE_REALTIME_SOFT) |	\
+	 BIT(HRTIMER_BASE_TAI) | BIT(HRTIMER_BASE_TAI_SOFT))
+
+#define CLOCK_SET_BOOT							\
+	(BIT(HRTIMER_BASE_BOOTTIME) | BIT(HRTIMER_BASE_BOOTTIME_SOFT))
+
+void clock_was_set(unsigned int bases);
+void clock_was_set_delayed(void);
+
+void hrtimers_resume_local(void);
+
+/* Since jiffies uses a simple TICK_NSEC multiplier
+ * conversion, the .shift value could be zero. However
+ * this would make NTP adjustments impossible as they are
+ * in units of 1/2^.shift. Thus we use JIFFIES_SHIFT to
+ * shift both the nominator and denominator the same
+ * amount, and give ntp adjustments in units of 1/2^8
+ *
+ * The value 8 is somewhat carefully chosen, as anything
+ * larger can result in overflows. TICK_NSEC grows as HZ
+ * shrinks, so values greater than 8 overflow 32bits when
+ * HZ=3D100.
+ */
+#if HZ < 34
+#define JIFFIES_SHIFT	6
+#elif HZ < 67
+#define JIFFIES_SHIFT	7
+#else
+#define JIFFIES_SHIFT	8
+#endif
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 8a364aa9881a..b348749a9fc6 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1323,8 +1323,8 @@ int do_settimeofday64(const struct timespec64 *ts)
 	write_seqcount_end(&tk_core.seq);
 	raw_spin_unlock_irqrestore(&timekeeper_lock, flags);
=20
-	/* signal hrtimers about time change */
-	clock_was_set();
+	/* Signal hrtimers about time change */
+	clock_was_set(CLOCK_SET_WALL);
=20
 	if (!ret)
 		audit_tk_injoffset(ts_delta);
@@ -1371,8 +1371,8 @@ static int timekeeping_inject_offset(const struct times=
pec64 *ts)
 	write_seqcount_end(&tk_core.seq);
 	raw_spin_unlock_irqrestore(&timekeeper_lock, flags);
=20
-	/* signal hrtimers about time change */
-	clock_was_set();
+	/* Signal hrtimers about time change */
+	clock_was_set(CLOCK_SET_WALL);
=20
 	return ret;
 }
@@ -1746,8 +1746,8 @@ void timekeeping_inject_sleeptime64(const struct timesp=
ec64 *delta)
 	write_seqcount_end(&tk_core.seq);
 	raw_spin_unlock_irqrestore(&timekeeper_lock, flags);
=20
-	/* signal hrtimers about time change */
-	clock_was_set();
+	/* Signal hrtimers about time change */
+	clock_was_set(CLOCK_SET_WALL | CLOCK_SET_BOOT);
 }
 #endif
=20
@@ -1810,8 +1810,10 @@ void timekeeping_resume(void)
=20
 	touch_softlockup_watchdog();
=20
+	/* Resume the clockevent device(s) and hrtimers */
 	tick_resume();
-	hrtimers_resume();
+	/* Notify timerfd as resume is equivalent to clock_was_set() */
+	timerfd_resume();
 }
=20
 int timekeeping_suspend(void)
@@ -2125,7 +2127,7 @@ static u64 logarithmic_accumulation(struct timekeeper *=
tk, u64 offset,
  * timekeeping_advance - Updates the timekeeper to the current time and
  * current NTP tick length
  */
-static void timekeeping_advance(enum timekeeping_adv_mode mode)
+static bool timekeeping_advance(enum timekeeping_adv_mode mode)
 {
 	struct timekeeper *real_tk =3D &tk_core.timekeeper;
 	struct timekeeper *tk =3D &shadow_timekeeper;
@@ -2196,9 +2198,8 @@ static void timekeeping_advance(enum timekeeping_adv_mo=
de mode)
 	write_seqcount_end(&tk_core.seq);
 out:
 	raw_spin_unlock_irqrestore(&timekeeper_lock, flags);
-	if (clock_set)
-		/* Have to call _delayed version, since in irq context*/
-		clock_was_set_delayed();
+
+	return !!clock_set;
 }
=20
 /**
@@ -2207,7 +2208,8 @@ static void timekeeping_advance(enum timekeeping_adv_mo=
de mode)
  */
 void update_wall_time(void)
 {
-	timekeeping_advance(TK_ADV_TICK);
+	if (timekeeping_advance(TK_ADV_TICK))
+		clock_was_set_delayed();
 }
=20
 /**
@@ -2387,8 +2389,9 @@ int do_adjtimex(struct __kernel_timex *txc)
 {
 	struct timekeeper *tk =3D &tk_core.timekeeper;
 	struct audit_ntp_data ad;
-	unsigned long flags;
+	bool clock_set =3D false;
 	struct timespec64 ts;
+	unsigned long flags;
 	s32 orig_tai, tai;
 	int ret;
=20
@@ -2423,6 +2426,7 @@ int do_adjtimex(struct __kernel_timex *txc)
 	if (tai !=3D orig_tai) {
 		__timekeeping_set_tai_offset(tk, tai);
 		timekeeping_update(tk, TK_MIRROR | TK_CLOCK_WAS_SET);
+		clock_set =3D true;
 	}
 	tk_update_leap_state(tk);
=20
@@ -2433,10 +2437,10 @@ int do_adjtimex(struct __kernel_timex *txc)
=20
 	/* Update the multiplier immediately if frequency was set directly */
 	if (txc->modes & (ADJ_FREQUENCY | ADJ_TICK))
-		timekeeping_advance(TK_ADV_FREQ);
+		clock_set |=3D timekeeping_advance(TK_ADV_FREQ);
=20
-	if (tai !=3D orig_tai)
-		clock_was_set();
+	if (clock_set)
+		clock_was_set(CLOCK_REALTIME);
=20
 	ntp_notify_cmos_timer();
=20

