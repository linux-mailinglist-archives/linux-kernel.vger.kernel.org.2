Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD9F94411C6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 02:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbhKABSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Oct 2021 21:18:48 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39160 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbhKABSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Oct 2021 21:18:40 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635729367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=HLbWP8OP34ZoXRtYnemRPDUSlcmBvsivIYw1prn5+JI=;
        b=zUAL1jesF+SGx5hh4Ocdy9336UWsZKTa5p1DphxVz8RNlpTkWesoOSvBR266R0udRC/fIJ
        R3RA2wE7UJiFttdlRz4nQMIUOtu30oFXX4FNiO5sGIyxIfCsOYBfoBYtFDRNnAsCNorPCB
        wua9GYuCZv1LE2vcmnmmvcyDSy/pbhE82rfbRMxc/Yo3b6ji6e5dG42ZBBKDvDDmmLPlTj
        k6i5qTw4ID0x51KJPzWC3adAhokeuOtqD3h02LbBMe4EAhDCYVpqg280bPhCuSgh0TI7hg
        Iwb9xWql8HMOBabgBpgNb+5tHZZuwC2y5RaRJaROp8dVQj1EWCPl//Nlh06PCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635729367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=HLbWP8OP34ZoXRtYnemRPDUSlcmBvsivIYw1prn5+JI=;
        b=rSdJiEMnvuaGdA/lTCJQWHOCmEvVMBeKxrB+/oAoj5XdeqdOy5O8u442EJxhMcsY99HJGU
        AKlx0fmiOa+QPtCw==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] timers/core for v5.16-rc1
References: <163572864256.3357115.931779940195622047.tglx@xen13>
Message-ID: <163572865003.3357115.14627825438101527879.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Mon,  1 Nov 2021 02:16:06 +0100 (CET)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest timers/core branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2021=
-10-31

up to:  a8da61cee95e: Merge tag 'timers-v5.16-rc1' into timers/core


Time, timers and timekeeping updates:

  - No core updates

  - No new clocksource/event driver

  - A large rework of the ARM architected timer driver to prepare for the
    support of the upcoming ARMv8.6 support

  - Fix Kconfig options for Exynos MCT, Samsung PWM and TI DM timers

  - Address a namespace collison in the ARC sp804 timer driver

Thanks,

	tglx

------------------>
Kees Cook (1):
      clocksource/drivers/timer-ti-dm: Select TIMER_OF

Krzysztof Kozlowski (1):
      clocksource/drivers/exynosy: Depend on sub-architecture for Exynos MCT =
and Samsung PWM

Marc Zyngier (12):
      clocksource/arm_arch_timer: Add build-time guards for unhandled registe=
r accesses
      clocksource/drivers/arm_arch_timer: Drop CNT*_TVAL read accessors
      clocksource/drivers/arm_arch_timer: Extend write side of timer register=
 accessors to u64
      clocksource/drivers/arm_arch_timer: Move system register timer programm=
ing over to CVAL
      clocksource/drivers/arm_arch_timer: Move drop _tval from erratum functi=
on names
      clocksource/drivers/arm_arch_timer: Fix MMIO base address vs callback o=
rdering issue
      clocksource/drivers/arm_arch_timer: Move MMIO timer programming over to=
 CVAL
      clocksource/drivers/arm_arch_timer: Advertise 56bit timer to the core c=
ode
      clocksource/drivers/arm_arch_timer: Work around broken CVAL implementat=
ions
      clocksource/drivers/arm_arch_timer: Remove any trace of the TVAL progra=
mming interface
      clocksource/drivers/arm_arch_timer: Drop unnecessary ISB on CVAL progra=
mming
      clocksource/drivers/arch_arm_timer: Move workaround synchronisation aro=
und

Oliver Upton (1):
      clocksource/drivers/arm_arch_timer: Fix masking for high freq counters

Randy Dunlap (1):
      clocksource/drivers/arc_timer: Eliminate redefined macro error


 arch/arm/include/asm/arch_timer.h    |  37 +++---
 arch/arm64/include/asm/arch_timer.h  |  52 ++++----
 drivers/clocksource/Kconfig          |   3 +
 drivers/clocksource/arc_timer.c      |   6 +-
 drivers/clocksource/arm_arch_timer.c | 243 +++++++++++++++++++++------------=
--
 include/clocksource/arm_arch_timer.h |   2 +-
 include/soc/arc/timers.h             |   4 +-
 7 files changed, 201 insertions(+), 146 deletions(-)

diff --git a/arch/arm/include/asm/arch_timer.h b/arch/arm/include/asm/arch_ti=
mer.h
index 99175812d903..bb129b6d2366 100644
--- a/arch/arm/include/asm/arch_timer.h
+++ b/arch/arm/include/asm/arch_timer.h
@@ -7,6 +7,7 @@
 #include <asm/hwcap.h>
 #include <linux/clocksource.h>
 #include <linux/init.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/types.h>
=20
 #include <clocksource/arm_arch_timer.h>
@@ -24,29 +25,35 @@ int arch_timer_arch_init(void);
  * the code. At least it does so with a recent GCC (4.6.3).
  */
 static __always_inline
-void arch_timer_reg_write_cp15(int access, enum arch_timer_reg reg, u32 val)
+void arch_timer_reg_write_cp15(int access, enum arch_timer_reg reg, u64 val)
 {
 	if (access =3D=3D ARCH_TIMER_PHYS_ACCESS) {
 		switch (reg) {
 		case ARCH_TIMER_REG_CTRL:
-			asm volatile("mcr p15, 0, %0, c14, c2, 1" : : "r" (val));
+			asm volatile("mcr p15, 0, %0, c14, c2, 1" : : "r" ((u32)val));
+			isb();
 			break;
-		case ARCH_TIMER_REG_TVAL:
-			asm volatile("mcr p15, 0, %0, c14, c2, 0" : : "r" (val));
+		case ARCH_TIMER_REG_CVAL:
+			asm volatile("mcrr p15, 2, %Q0, %R0, c14" : : "r" (val));
 			break;
+		default:
+			BUILD_BUG();
 		}
 	} else if (access =3D=3D ARCH_TIMER_VIRT_ACCESS) {
 		switch (reg) {
 		case ARCH_TIMER_REG_CTRL:
-			asm volatile("mcr p15, 0, %0, c14, c3, 1" : : "r" (val));
+			asm volatile("mcr p15, 0, %0, c14, c3, 1" : : "r" ((u32)val));
+			isb();
 			break;
-		case ARCH_TIMER_REG_TVAL:
-			asm volatile("mcr p15, 0, %0, c14, c3, 0" : : "r" (val));
+		case ARCH_TIMER_REG_CVAL:
+			asm volatile("mcrr p15, 3, %Q0, %R0, c14" : : "r" (val));
 			break;
+		default:
+			BUILD_BUG();
 		}
+	} else {
+		BUILD_BUG();
 	}
-
-	isb();
 }
=20
 static __always_inline
@@ -59,19 +66,19 @@ u32 arch_timer_reg_read_cp15(int access, enum arch_timer_=
reg reg)
 		case ARCH_TIMER_REG_CTRL:
 			asm volatile("mrc p15, 0, %0, c14, c2, 1" : "=3Dr" (val));
 			break;
-		case ARCH_TIMER_REG_TVAL:
-			asm volatile("mrc p15, 0, %0, c14, c2, 0" : "=3Dr" (val));
-			break;
+		default:
+			BUILD_BUG();
 		}
 	} else if (access =3D=3D ARCH_TIMER_VIRT_ACCESS) {
 		switch (reg) {
 		case ARCH_TIMER_REG_CTRL:
 			asm volatile("mrc p15, 0, %0, c14, c3, 1" : "=3Dr" (val));
 			break;
-		case ARCH_TIMER_REG_TVAL:
-			asm volatile("mrc p15, 0, %0, c14, c3, 0" : "=3Dr" (val));
-			break;
+		default:
+			BUILD_BUG();
 		}
+	} else {
+		BUILD_BUG();
 	}
=20
 	return val;
diff --git a/arch/arm64/include/asm/arch_timer.h b/arch/arm64/include/asm/arc=
h_timer.h
index 88d20f04c64a..519ac1f7f859 100644
--- a/arch/arm64/include/asm/arch_timer.h
+++ b/arch/arm64/include/asm/arch_timer.h
@@ -32,7 +32,7 @@
 	({								\
 		const struct arch_timer_erratum_workaround *__wa;	\
 		__wa =3D __this_cpu_read(timer_unstable_counter_workaround); \
-		(__wa && __wa->h) ? __wa->h : arch_timer_##h;		\
+		(__wa && __wa->h) ? ({ isb(); __wa->h;}) : arch_timer_##h; \
 	})
=20
 #else
@@ -52,8 +52,6 @@ struct arch_timer_erratum_workaround {
 	enum arch_timer_erratum_match_type match_type;
 	const void *id;
 	const char *desc;
-	u32 (*read_cntp_tval_el0)(void);
-	u32 (*read_cntv_tval_el0)(void);
 	u64 (*read_cntpct_el0)(void);
 	u64 (*read_cntvct_el0)(void);
 	int (*set_next_event_phys)(unsigned long, struct clock_event_device *);
@@ -64,24 +62,15 @@ struct arch_timer_erratum_workaround {
 DECLARE_PER_CPU(const struct arch_timer_erratum_workaround *,
 		timer_unstable_counter_workaround);
=20
-/* inline sysreg accessors that make erratum_handler() work */
-static inline notrace u32 arch_timer_read_cntp_tval_el0(void)
-{
-	return read_sysreg(cntp_tval_el0);
-}
-
-static inline notrace u32 arch_timer_read_cntv_tval_el0(void)
-{
-	return read_sysreg(cntv_tval_el0);
-}
-
 static inline notrace u64 arch_timer_read_cntpct_el0(void)
 {
+	isb();
 	return read_sysreg(cntpct_el0);
 }
=20
 static inline notrace u64 arch_timer_read_cntvct_el0(void)
 {
+	isb();
 	return read_sysreg(cntvct_el0);
 }
=20
@@ -102,51 +91,58 @@ static inline notrace u64 arch_timer_read_cntvct_el0(voi=
d)
  * the code.
  */
 static __always_inline
-void arch_timer_reg_write_cp15(int access, enum arch_timer_reg reg, u32 val)
+void arch_timer_reg_write_cp15(int access, enum arch_timer_reg reg, u64 val)
 {
 	if (access =3D=3D ARCH_TIMER_PHYS_ACCESS) {
 		switch (reg) {
 		case ARCH_TIMER_REG_CTRL:
 			write_sysreg(val, cntp_ctl_el0);
+			isb();
 			break;
-		case ARCH_TIMER_REG_TVAL:
-			write_sysreg(val, cntp_tval_el0);
+		case ARCH_TIMER_REG_CVAL:
+			write_sysreg(val, cntp_cval_el0);
 			break;
+		default:
+			BUILD_BUG();
 		}
 	} else if (access =3D=3D ARCH_TIMER_VIRT_ACCESS) {
 		switch (reg) {
 		case ARCH_TIMER_REG_CTRL:
 			write_sysreg(val, cntv_ctl_el0);
+			isb();
 			break;
-		case ARCH_TIMER_REG_TVAL:
-			write_sysreg(val, cntv_tval_el0);
+		case ARCH_TIMER_REG_CVAL:
+			write_sysreg(val, cntv_cval_el0);
 			break;
+		default:
+			BUILD_BUG();
 		}
+	} else {
+		BUILD_BUG();
 	}
-
-	isb();
 }
=20
 static __always_inline
-u32 arch_timer_reg_read_cp15(int access, enum arch_timer_reg reg)
+u64 arch_timer_reg_read_cp15(int access, enum arch_timer_reg reg)
 {
 	if (access =3D=3D ARCH_TIMER_PHYS_ACCESS) {
 		switch (reg) {
 		case ARCH_TIMER_REG_CTRL:
 			return read_sysreg(cntp_ctl_el0);
-		case ARCH_TIMER_REG_TVAL:
-			return arch_timer_reg_read_stable(cntp_tval_el0);
+		default:
+			BUILD_BUG();
 		}
 	} else if (access =3D=3D ARCH_TIMER_VIRT_ACCESS) {
 		switch (reg) {
 		case ARCH_TIMER_REG_CTRL:
 			return read_sysreg(cntv_ctl_el0);
-		case ARCH_TIMER_REG_TVAL:
-			return arch_timer_reg_read_stable(cntv_tval_el0);
+		default:
+			BUILD_BUG();
 		}
 	}
=20
-	BUG();
+	BUILD_BUG();
+	unreachable();
 }
=20
 static inline u32 arch_timer_get_cntfrq(void)
@@ -169,7 +165,6 @@ static __always_inline u64 __arch_counter_get_cntpct_stab=
le(void)
 {
 	u64 cnt;
=20
-	isb();
 	cnt =3D arch_timer_reg_read_stable(cntpct_el0);
 	arch_counter_enforce_ordering(cnt);
 	return cnt;
@@ -189,7 +184,6 @@ static __always_inline u64 __arch_counter_get_cntvct_stab=
le(void)
 {
 	u64 cnt;
=20
-	isb();
 	cnt =3D arch_timer_reg_read_stable(cntvct_el0);
 	arch_counter_enforce_ordering(cnt);
 	return cnt;
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index eb661b539a3e..e71ac54b7896 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -24,6 +24,7 @@ config I8253_LOCK
=20
 config OMAP_DM_TIMER
 	bool
+	select TIMER_OF
=20
 config CLKBLD_I8253
 	def_bool y if CLKSRC_I8253 || CLKEVT_I8253 || I8253_LOCK
@@ -417,12 +418,14 @@ config ATMEL_TCB_CLKSRC
 config CLKSRC_EXYNOS_MCT
 	bool "Exynos multi core timer driver" if COMPILE_TEST
 	depends on ARM || ARM64
+	depends on ARCH_EXYNOS || COMPILE_TEST
 	help
 	  Support for Multi Core Timer controller on Exynos SoCs.
=20
 config CLKSRC_SAMSUNG_PWM
 	bool "PWM timer driver for Samsung S3C, S5P" if COMPILE_TEST
 	depends on HAS_IOMEM
+	depends on ARCH_EXYNOS || ARCH_S3C24XX || ARCH_S3C64XX || ARCH_S5PV210 || C=
OMPILE_TEST
 	help
 	  This is a new clocksource driver for the PWM timer found in
 	  Samsung S3C, S5P and Exynos SoCs, replacing an earlier driver
diff --git a/drivers/clocksource/arc_timer.c b/drivers/clocksource/arc_timer.c
index de93dd1a8c7b..cb18524cc13d 100644
--- a/drivers/clocksource/arc_timer.c
+++ b/drivers/clocksource/arc_timer.c
@@ -225,7 +225,7 @@ static int __init arc_cs_setup_timer1(struct device_node =
*node)
=20
 	write_aux_reg(ARC_REG_TIMER1_LIMIT, ARC_TIMERN_MAX);
 	write_aux_reg(ARC_REG_TIMER1_CNT, 0);
-	write_aux_reg(ARC_REG_TIMER1_CTRL, TIMER_CTRL_NH);
+	write_aux_reg(ARC_REG_TIMER1_CTRL, ARC_TIMER_CTRL_NH);
=20
 	sched_clock_register(arc_timer1_clock_read, 32, arc_timer_freq);
=20
@@ -245,7 +245,7 @@ static void arc_timer_event_setup(unsigned int cycles)
 	write_aux_reg(ARC_REG_TIMER0_LIMIT, cycles);
 	write_aux_reg(ARC_REG_TIMER0_CNT, 0);	/* start from 0 */
=20
-	write_aux_reg(ARC_REG_TIMER0_CTRL, TIMER_CTRL_IE | TIMER_CTRL_NH);
+	write_aux_reg(ARC_REG_TIMER0_CTRL, ARC_TIMER_CTRL_IE | ARC_TIMER_CTRL_NH);
 }
=20
=20
@@ -294,7 +294,7 @@ static irqreturn_t timer_irq_handler(int irq, void *dev_i=
d)
 	 *      explicitly clears IP bit
 	 * 2. Re-arm interrupt if periodic by writing to IE bit [0]
 	 */
-	write_aux_reg(ARC_REG_TIMER0_CTRL, irq_reenable | TIMER_CTRL_NH);
+	write_aux_reg(ARC_REG_TIMER0_CTRL, irq_reenable | ARC_TIMER_CTRL_NH);
=20
 	evt->event_handler(evt);
=20
diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_a=
rch_timer.c
index be6d741d404c..9a04eacc4412 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -44,23 +44,29 @@
 #define CNTACR_RWVT	BIT(4)
 #define CNTACR_RWPT	BIT(5)
=20
-#define CNTVCT_LO	0x08
-#define CNTVCT_HI	0x0c
+#define CNTVCT_LO	0x00
+#define CNTPCT_LO	0x08
 #define CNTFRQ		0x10
-#define CNTP_TVAL	0x28
+#define CNTP_CVAL_LO	0x20
 #define CNTP_CTL	0x2c
-#define CNTV_TVAL	0x38
+#define CNTV_CVAL_LO	0x30
 #define CNTV_CTL	0x3c
=20
-static unsigned arch_timers_present __initdata;
+/*
+ * The minimum amount of time a generic counter is guaranteed to not roll ov=
er
+ * (40 years)
+ */
+#define MIN_ROLLOVER_SECS	(40ULL * 365 * 24 * 3600)
=20
-static void __iomem *arch_counter_base __ro_after_init;
+static unsigned arch_timers_present __initdata;
=20
 struct arch_timer {
 	void __iomem *base;
 	struct clock_event_device evt;
 };
=20
+static struct arch_timer *arch_timer_mem __ro_after_init;
+
 #define to_arch_timer(e) container_of(e, struct arch_timer, evt)
=20
 static u32 arch_timer_rate __ro_after_init;
@@ -95,33 +101,58 @@ static int __init early_evtstrm_cfg(char *buf)
 }
 early_param("clocksource.arm_arch_timer.evtstrm", early_evtstrm_cfg);
=20
+/*
+ * Makes an educated guess at a valid counter width based on the Generic Tim=
er
+ * specification. Of note:
+ *   1) the system counter is at least 56 bits wide
+ *   2) a roll-over time of not less than 40 years
+ *
+ * See 'ARM DDI 0487G.a D11.1.2 ("The system counter")' for more details.
+ */
+static int arch_counter_get_width(void)
+{
+	u64 min_cycles =3D MIN_ROLLOVER_SECS * arch_timer_rate;
+
+	/* guarantee the returned width is within the valid range */
+	return clamp_val(ilog2(min_cycles - 1) + 1, 56, 64);
+}
+
 /*
  * Architected system timer support.
  */
=20
 static __always_inline
-void arch_timer_reg_write(int access, enum arch_timer_reg reg, u32 val,
+void arch_timer_reg_write(int access, enum arch_timer_reg reg, u64 val,
 			  struct clock_event_device *clk)
 {
 	if (access =3D=3D ARCH_TIMER_MEM_PHYS_ACCESS) {
 		struct arch_timer *timer =3D to_arch_timer(clk);
 		switch (reg) {
 		case ARCH_TIMER_REG_CTRL:
-			writel_relaxed(val, timer->base + CNTP_CTL);
+			writel_relaxed((u32)val, timer->base + CNTP_CTL);
 			break;
-		case ARCH_TIMER_REG_TVAL:
-			writel_relaxed(val, timer->base + CNTP_TVAL);
+		case ARCH_TIMER_REG_CVAL:
+			/*
+			 * Not guaranteed to be atomic, so the timer
+			 * must be disabled at this point.
+			 */
+			writeq_relaxed(val, timer->base + CNTP_CVAL_LO);
 			break;
+		default:
+			BUILD_BUG();
 		}
 	} else if (access =3D=3D ARCH_TIMER_MEM_VIRT_ACCESS) {
 		struct arch_timer *timer =3D to_arch_timer(clk);
 		switch (reg) {
 		case ARCH_TIMER_REG_CTRL:
-			writel_relaxed(val, timer->base + CNTV_CTL);
+			writel_relaxed((u32)val, timer->base + CNTV_CTL);
 			break;
-		case ARCH_TIMER_REG_TVAL:
-			writel_relaxed(val, timer->base + CNTV_TVAL);
+		case ARCH_TIMER_REG_CVAL:
+			/* Same restriction as above */
+			writeq_relaxed(val, timer->base + CNTV_CVAL_LO);
 			break;
+		default:
+			BUILD_BUG();
 		}
 	} else {
 		arch_timer_reg_write_cp15(access, reg, val);
@@ -140,9 +171,8 @@ u32 arch_timer_reg_read(int access, enum arch_timer_reg r=
eg,
 		case ARCH_TIMER_REG_CTRL:
 			val =3D readl_relaxed(timer->base + CNTP_CTL);
 			break;
-		case ARCH_TIMER_REG_TVAL:
-			val =3D readl_relaxed(timer->base + CNTP_TVAL);
-			break;
+		default:
+			BUILD_BUG();
 		}
 	} else if (access =3D=3D ARCH_TIMER_MEM_VIRT_ACCESS) {
 		struct arch_timer *timer =3D to_arch_timer(clk);
@@ -150,9 +180,8 @@ u32 arch_timer_reg_read(int access, enum arch_timer_reg r=
eg,
 		case ARCH_TIMER_REG_CTRL:
 			val =3D readl_relaxed(timer->base + CNTV_CTL);
 			break;
-		case ARCH_TIMER_REG_TVAL:
-			val =3D readl_relaxed(timer->base + CNTV_TVAL);
-			break;
+		default:
+			BUILD_BUG();
 		}
 	} else {
 		val =3D arch_timer_reg_read_cp15(access, reg);
@@ -205,13 +234,11 @@ static struct clocksource clocksource_counter =3D {
 	.id	=3D CSID_ARM_ARCH_COUNTER,
 	.rating	=3D 400,
 	.read	=3D arch_counter_read,
-	.mask	=3D CLOCKSOURCE_MASK(56),
 	.flags	=3D CLOCK_SOURCE_IS_CONTINUOUS,
 };
=20
 static struct cyclecounter cyclecounter __ro_after_init =3D {
 	.read	=3D arch_counter_read_cc,
-	.mask	=3D CLOCKSOURCE_MASK(56),
 };
=20
 struct ate_acpi_oem_info {
@@ -239,16 +266,6 @@ struct ate_acpi_oem_info {
 	_new;						\
 })
=20
-static u32 notrace fsl_a008585_read_cntp_tval_el0(void)
-{
-	return __fsl_a008585_read_reg(cntp_tval_el0);
-}
-
-static u32 notrace fsl_a008585_read_cntv_tval_el0(void)
-{
-	return __fsl_a008585_read_reg(cntv_tval_el0);
-}
-
 static u64 notrace fsl_a008585_read_cntpct_el0(void)
 {
 	return __fsl_a008585_read_reg(cntpct_el0);
@@ -285,16 +302,6 @@ static u64 notrace fsl_a008585_read_cntvct_el0(void)
 	_new;							\
 })
=20
-static u32 notrace hisi_161010101_read_cntp_tval_el0(void)
-{
-	return __hisi_161010101_read_reg(cntp_tval_el0);
-}
-
-static u32 notrace hisi_161010101_read_cntv_tval_el0(void)
-{
-	return __hisi_161010101_read_reg(cntv_tval_el0);
-}
-
 static u64 notrace hisi_161010101_read_cntpct_el0(void)
 {
 	return __hisi_161010101_read_reg(cntpct_el0);
@@ -379,16 +386,6 @@ static u64 notrace sun50i_a64_read_cntvct_el0(void)
 {
 	return __sun50i_a64_read_reg(cntvct_el0);
 }
-
-static u32 notrace sun50i_a64_read_cntp_tval_el0(void)
-{
-	return read_sysreg(cntp_cval_el0) - sun50i_a64_read_cntpct_el0();
-}
-
-static u32 notrace sun50i_a64_read_cntv_tval_el0(void)
-{
-	return read_sysreg(cntv_cval_el0) - sun50i_a64_read_cntvct_el0();
-}
 #endif
=20
 #ifdef CONFIG_ARM_ARCH_TIMER_OOL_WORKAROUND
@@ -397,7 +394,7 @@ EXPORT_SYMBOL_GPL(timer_unstable_counter_workaround);
=20
 static atomic_t timer_unstable_counter_workaround_in_use =3D ATOMIC_INIT(0);
=20
-static void erratum_set_next_event_tval_generic(const int access, unsigned l=
ong evt,
+static void erratum_set_next_event_generic(const int access, unsigned long e=
vt,
 						struct clock_event_device *clk)
 {
 	unsigned long ctrl;
@@ -418,17 +415,17 @@ static void erratum_set_next_event_tval_generic(const i=
nt access, unsigned long
 	arch_timer_reg_write(access, ARCH_TIMER_REG_CTRL, ctrl, clk);
 }
=20
-static __maybe_unused int erratum_set_next_event_tval_virt(unsigned long evt,
+static __maybe_unused int erratum_set_next_event_virt(unsigned long evt,
 					    struct clock_event_device *clk)
 {
-	erratum_set_next_event_tval_generic(ARCH_TIMER_VIRT_ACCESS, evt, clk);
+	erratum_set_next_event_generic(ARCH_TIMER_VIRT_ACCESS, evt, clk);
 	return 0;
 }
=20
-static __maybe_unused int erratum_set_next_event_tval_phys(unsigned long evt,
+static __maybe_unused int erratum_set_next_event_phys(unsigned long evt,
 					    struct clock_event_device *clk)
 {
-	erratum_set_next_event_tval_generic(ARCH_TIMER_PHYS_ACCESS, evt, clk);
+	erratum_set_next_event_generic(ARCH_TIMER_PHYS_ACCESS, evt, clk);
 	return 0;
 }
=20
@@ -438,12 +435,10 @@ static const struct arch_timer_erratum_workaround ool_w=
orkarounds[] =3D {
 		.match_type =3D ate_match_dt,
 		.id =3D "fsl,erratum-a008585",
 		.desc =3D "Freescale erratum a005858",
-		.read_cntp_tval_el0 =3D fsl_a008585_read_cntp_tval_el0,
-		.read_cntv_tval_el0 =3D fsl_a008585_read_cntv_tval_el0,
 		.read_cntpct_el0 =3D fsl_a008585_read_cntpct_el0,
 		.read_cntvct_el0 =3D fsl_a008585_read_cntvct_el0,
-		.set_next_event_phys =3D erratum_set_next_event_tval_phys,
-		.set_next_event_virt =3D erratum_set_next_event_tval_virt,
+		.set_next_event_phys =3D erratum_set_next_event_phys,
+		.set_next_event_virt =3D erratum_set_next_event_virt,
 	},
 #endif
 #ifdef CONFIG_HISILICON_ERRATUM_161010101
@@ -451,23 +446,19 @@ static const struct arch_timer_erratum_workaround ool_w=
orkarounds[] =3D {
 		.match_type =3D ate_match_dt,
 		.id =3D "hisilicon,erratum-161010101",
 		.desc =3D "HiSilicon erratum 161010101",
-		.read_cntp_tval_el0 =3D hisi_161010101_read_cntp_tval_el0,
-		.read_cntv_tval_el0 =3D hisi_161010101_read_cntv_tval_el0,
 		.read_cntpct_el0 =3D hisi_161010101_read_cntpct_el0,
 		.read_cntvct_el0 =3D hisi_161010101_read_cntvct_el0,
-		.set_next_event_phys =3D erratum_set_next_event_tval_phys,
-		.set_next_event_virt =3D erratum_set_next_event_tval_virt,
+		.set_next_event_phys =3D erratum_set_next_event_phys,
+		.set_next_event_virt =3D erratum_set_next_event_virt,
 	},
 	{
 		.match_type =3D ate_match_acpi_oem_info,
 		.id =3D hisi_161010101_oem_info,
 		.desc =3D "HiSilicon erratum 161010101",
-		.read_cntp_tval_el0 =3D hisi_161010101_read_cntp_tval_el0,
-		.read_cntv_tval_el0 =3D hisi_161010101_read_cntv_tval_el0,
 		.read_cntpct_el0 =3D hisi_161010101_read_cntpct_el0,
 		.read_cntvct_el0 =3D hisi_161010101_read_cntvct_el0,
-		.set_next_event_phys =3D erratum_set_next_event_tval_phys,
-		.set_next_event_virt =3D erratum_set_next_event_tval_virt,
+		.set_next_event_phys =3D erratum_set_next_event_phys,
+		.set_next_event_virt =3D erratum_set_next_event_virt,
 	},
 #endif
 #ifdef CONFIG_ARM64_ERRATUM_858921
@@ -484,12 +475,10 @@ static const struct arch_timer_erratum_workaround ool_w=
orkarounds[] =3D {
 		.match_type =3D ate_match_dt,
 		.id =3D "allwinner,erratum-unknown1",
 		.desc =3D "Allwinner erratum UNKNOWN1",
-		.read_cntp_tval_el0 =3D sun50i_a64_read_cntp_tval_el0,
-		.read_cntv_tval_el0 =3D sun50i_a64_read_cntv_tval_el0,
 		.read_cntpct_el0 =3D sun50i_a64_read_cntpct_el0,
 		.read_cntvct_el0 =3D sun50i_a64_read_cntvct_el0,
-		.set_next_event_phys =3D erratum_set_next_event_tval_phys,
-		.set_next_event_virt =3D erratum_set_next_event_tval_virt,
+		.set_next_event_phys =3D erratum_set_next_event_phys,
+		.set_next_event_virt =3D erratum_set_next_event_virt,
 	},
 #endif
 #ifdef CONFIG_ARM64_ERRATUM_1418040
@@ -727,10 +716,18 @@ static __always_inline void set_next_event(const int ac=
cess, unsigned long evt,
 					   struct clock_event_device *clk)
 {
 	unsigned long ctrl;
+	u64 cnt;
+
 	ctrl =3D arch_timer_reg_read(access, ARCH_TIMER_REG_CTRL, clk);
 	ctrl |=3D ARCH_TIMER_CTRL_ENABLE;
 	ctrl &=3D ~ARCH_TIMER_CTRL_IT_MASK;
-	arch_timer_reg_write(access, ARCH_TIMER_REG_TVAL, evt, clk);
+
+	if (access =3D=3D ARCH_TIMER_PHYS_ACCESS)
+		cnt =3D __arch_counter_get_cntpct();
+	else
+		cnt =3D __arch_counter_get_cntvct();
+
+	arch_timer_reg_write(access, ARCH_TIMER_REG_CVAL, evt + cnt, clk);
 	arch_timer_reg_write(access, ARCH_TIMER_REG_CTRL, ctrl, clk);
 }
=20
@@ -748,23 +745,79 @@ static int arch_timer_set_next_event_phys(unsigned long=
 evt,
 	return 0;
 }
=20
+static u64 arch_counter_get_cnt_mem(struct arch_timer *t, int offset_lo)
+{
+	u32 cnt_lo, cnt_hi, tmp_hi;
+
+	do {
+		cnt_hi =3D readl_relaxed(t->base + offset_lo + 4);
+		cnt_lo =3D readl_relaxed(t->base + offset_lo);
+		tmp_hi =3D readl_relaxed(t->base + offset_lo + 4);
+	} while (cnt_hi !=3D tmp_hi);
+
+	return ((u64) cnt_hi << 32) | cnt_lo;
+}
+
+static __always_inline void set_next_event_mem(const int access, unsigned lo=
ng evt,
+					   struct clock_event_device *clk)
+{
+	struct arch_timer *timer =3D to_arch_timer(clk);
+	unsigned long ctrl;
+	u64 cnt;
+
+	ctrl =3D arch_timer_reg_read(access, ARCH_TIMER_REG_CTRL, clk);
+	ctrl |=3D ARCH_TIMER_CTRL_ENABLE;
+	ctrl &=3D ~ARCH_TIMER_CTRL_IT_MASK;
+
+	if (access =3D=3D  ARCH_TIMER_MEM_VIRT_ACCESS)
+		cnt =3D arch_counter_get_cnt_mem(timer, CNTVCT_LO);
+	else
+		cnt =3D arch_counter_get_cnt_mem(timer, CNTPCT_LO);
+
+	arch_timer_reg_write(access, ARCH_TIMER_REG_CVAL, evt + cnt, clk);
+	arch_timer_reg_write(access, ARCH_TIMER_REG_CTRL, ctrl, clk);
+}
+
 static int arch_timer_set_next_event_virt_mem(unsigned long evt,
 					      struct clock_event_device *clk)
 {
-	set_next_event(ARCH_TIMER_MEM_VIRT_ACCESS, evt, clk);
+	set_next_event_mem(ARCH_TIMER_MEM_VIRT_ACCESS, evt, clk);
 	return 0;
 }
=20
 static int arch_timer_set_next_event_phys_mem(unsigned long evt,
 					      struct clock_event_device *clk)
 {
-	set_next_event(ARCH_TIMER_MEM_PHYS_ACCESS, evt, clk);
+	set_next_event_mem(ARCH_TIMER_MEM_PHYS_ACCESS, evt, clk);
 	return 0;
 }
=20
+static u64 __arch_timer_check_delta(void)
+{
+#ifdef CONFIG_ARM64
+	const struct midr_range broken_cval_midrs[] =3D {
+		/*
+		 * XGene-1 implements CVAL in terms of TVAL, meaning
+		 * that the maximum timer range is 32bit. Shame on them.
+		 */
+		MIDR_ALL_VERSIONS(MIDR_CPU_MODEL(ARM_CPU_IMP_APM,
+						 APM_CPU_PART_POTENZA)),
+		{},
+	};
+
+	if (is_midr_in_range_list(read_cpuid_id(), broken_cval_midrs)) {
+		pr_warn_once("Broken CNTx_CVAL_EL1, limiting width to 32bits");
+		return CLOCKSOURCE_MASK(32);
+	}
+#endif
+	return CLOCKSOURCE_MASK(arch_counter_get_width());
+}
+
 static void __arch_timer_setup(unsigned type,
 			       struct clock_event_device *clk)
 {
+	u64 max_delta;
+
 	clk->features =3D CLOCK_EVT_FEAT_ONESHOT;
=20
 	if (type =3D=3D ARCH_TIMER_TYPE_CP15) {
@@ -796,6 +849,7 @@ static void __arch_timer_setup(unsigned type,
 		}
=20
 		clk->set_next_event =3D sne;
+		max_delta =3D __arch_timer_check_delta();
 	} else {
 		clk->features |=3D CLOCK_EVT_FEAT_DYNIRQ;
 		clk->name =3D "arch_mem_timer";
@@ -812,11 +866,13 @@ static void __arch_timer_setup(unsigned type,
 			clk->set_next_event =3D
 				arch_timer_set_next_event_phys_mem;
 		}
+
+		max_delta =3D CLOCKSOURCE_MASK(56);
 	}
=20
 	clk->set_state_shutdown(clk);
=20
-	clockevents_config_and_register(clk, arch_timer_rate, 0xf, 0x7fffffff);
+	clockevents_config_and_register(clk, arch_timer_rate, 0xf, max_delta);
 }
=20
 static void arch_timer_evtstrm_enable(int divider)
@@ -986,15 +1042,7 @@ bool arch_timer_evtstrm_available(void)
=20
 static u64 arch_counter_get_cntvct_mem(void)
 {
-	u32 vct_lo, vct_hi, tmp_hi;
-
-	do {
-		vct_hi =3D readl_relaxed(arch_counter_base + CNTVCT_HI);
-		vct_lo =3D readl_relaxed(arch_counter_base + CNTVCT_LO);
-		tmp_hi =3D readl_relaxed(arch_counter_base + CNTVCT_HI);
-	} while (vct_hi !=3D tmp_hi);
-
-	return ((u64) vct_hi << 32) | vct_lo;
+	return arch_counter_get_cnt_mem(arch_timer_mem, CNTVCT_LO);
 }
=20
 static struct arch_timer_kvm_info arch_timer_kvm_info;
@@ -1007,6 +1055,7 @@ struct arch_timer_kvm_info *arch_timer_get_kvm_info(voi=
d)
 static void __init arch_counter_register(unsigned type)
 {
 	u64 start_count;
+	int width;
=20
 	/* Register the CP15 based counter if we have one */
 	if (type & ARCH_TIMER_TYPE_CP15) {
@@ -1031,6 +1080,10 @@ static void __init arch_counter_register(unsigned type)
 		arch_timer_read_counter =3D arch_counter_get_cntvct_mem;
 	}
=20
+	width =3D arch_counter_get_width();
+	clocksource_counter.mask =3D CLOCKSOURCE_MASK(width);
+	cyclecounter.mask =3D CLOCKSOURCE_MASK(width);
+
 	if (!arch_counter_suspend_stop)
 		clocksource_counter.flags |=3D CLOCK_SOURCE_SUSPEND_NONSTOP;
 	start_count =3D arch_timer_read_counter();
@@ -1040,8 +1093,7 @@ static void __init arch_counter_register(unsigned type)
 	timecounter_init(&arch_timer_kvm_info.timecounter,
 			 &cyclecounter, start_count);
=20
-	/* 56 bits minimum, so we assume worst case rollover */
-	sched_clock_register(arch_timer_read_counter, 56, arch_timer_rate);
+	sched_clock_register(arch_timer_read_counter, width, arch_timer_rate);
 }
=20
 static void arch_timer_stop(struct clock_event_device *clk)
@@ -1182,25 +1234,25 @@ static int __init arch_timer_mem_register(void __iome=
m *base, unsigned int irq)
 {
 	int ret;
 	irq_handler_t func;
-	struct arch_timer *t;
=20
-	t =3D kzalloc(sizeof(*t), GFP_KERNEL);
-	if (!t)
+	arch_timer_mem =3D kzalloc(sizeof(*arch_timer_mem), GFP_KERNEL);
+	if (!arch_timer_mem)
 		return -ENOMEM;
=20
-	t->base =3D base;
-	t->evt.irq =3D irq;
-	__arch_timer_setup(ARCH_TIMER_TYPE_MEM, &t->evt);
+	arch_timer_mem->base =3D base;
+	arch_timer_mem->evt.irq =3D irq;
+	__arch_timer_setup(ARCH_TIMER_TYPE_MEM, &arch_timer_mem->evt);
=20
 	if (arch_timer_mem_use_virtual)
 		func =3D arch_timer_handler_virt_mem;
 	else
 		func =3D arch_timer_handler_phys_mem;
=20
-	ret =3D request_irq(irq, func, IRQF_TIMER, "arch_mem_timer", &t->evt);
+	ret =3D request_irq(irq, func, IRQF_TIMER, "arch_mem_timer", &arch_timer_me=
m->evt);
 	if (ret) {
 		pr_err("Failed to request mem timer irq\n");
-		kfree(t);
+		kfree(arch_timer_mem);
+		arch_timer_mem =3D NULL;
 	}
=20
 	return ret;
@@ -1458,7 +1510,6 @@ arch_timer_mem_frame_register(struct arch_timer_mem_fra=
me *frame)
 		return ret;
 	}
=20
-	arch_counter_base =3D base;
 	arch_timers_present |=3D ARCH_TIMER_TYPE_MEM;
=20
 	return 0;
diff --git a/include/clocksource/arm_arch_timer.h b/include/clocksource/arm_a=
rch_timer.h
index 73c7139c866f..e715bdb720d5 100644
--- a/include/clocksource/arm_arch_timer.h
+++ b/include/clocksource/arm_arch_timer.h
@@ -24,7 +24,7 @@
=20
 enum arch_timer_reg {
 	ARCH_TIMER_REG_CTRL,
-	ARCH_TIMER_REG_TVAL,
+	ARCH_TIMER_REG_CVAL,
 };
=20
 enum arch_timer_ppi_nr {
diff --git a/include/soc/arc/timers.h b/include/soc/arc/timers.h
index 7ecde3b159c8..ae99d3e855f1 100644
--- a/include/soc/arc/timers.h
+++ b/include/soc/arc/timers.h
@@ -17,8 +17,8 @@
 #define ARC_REG_TIMER1_CNT	0x100	/* timer 1 count */
=20
 /* CTRL reg bits */
-#define TIMER_CTRL_IE	        (1 << 0) /* Interrupt when Count reaches limit=
 */
-#define TIMER_CTRL_NH	        (1 << 1) /* Count only when CPU NOT halted */
+#define ARC_TIMER_CTRL_IE	(1 << 0) /* Interrupt when Count reaches limit */
+#define ARC_TIMER_CTRL_NH	(1 << 1) /* Count only when CPU NOT halted */
=20
 #define ARC_TIMERN_MAX		0xFFFFFFFF
=20

