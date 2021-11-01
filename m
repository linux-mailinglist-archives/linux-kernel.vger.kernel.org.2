Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1B14411C3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 02:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbhKABSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Oct 2021 21:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbhKABSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Oct 2021 21:18:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2488C061714
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 18:16:02 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635729358;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=T//ATmO/O4QLmAmGdmTNellFhicYbZum+P4BaVRXmGY=;
        b=XWE4HmN/V8B9bgDgSH/3oqirqwco8FNmDIKtSsSDTDc2WltYDMIh/ONFXFci95p+EfofkI
        bAhR/bA3fKggQF4GfnFxT0VhmcHQsmrpJxUkuRbnmCLzAZyDtAF0fTwUiwXp5PI+dxcnl9
        MTb97HRUbLfvd0AykLkbkqf88d5Ryx/dnj/W/KpV6HTahYFG43STOhQUVWVRn5j86Lu82N
        Dajsu6nRbt72NkrsFpfVI9JzxrN0QT2fuVYExlsYzESlwkZeTUUUyvpRFVJiM0s2sCWyEO
        MJzWYYu/LGURQgWo4wPL8yrMnd4LpgAUCDFLbAZhBGkpnD65/Xey/+dO+gM2Kg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635729358;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=T//ATmO/O4QLmAmGdmTNellFhicYbZum+P4BaVRXmGY=;
        b=JMnBBK1Be8/SfTohP53HwmytxQM7PIvlQcb2zdFq9E/0XXTwRIPrOWcX8VUeL1KAW2mDJa
        /Acq61oHfD4aLkDQ==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] irq/core for v5.16-rc1
Message-ID: <163572864256.3357115.931779940195622047.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Mon,  1 Nov 2021 02:15:57 +0100 (CET)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest irq/core branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2021-10=
-31

up to:  2258a6fc33d5: Merge tag 'irqchip-5.16' into irq/core

Updates for the interrupt subsystem:

 Core changes:

  - Prevent a potential deadlock when initial priority is assigned to a
    newly created interrupt thread. A recent change to plug a race between
    cpuset and __sched_setscheduler() introduced a new lock dependency
    which is now triggered. Break the lock dependency chain by moving the
    priority assignment to the thread function.

  - A couple of small updates to make the irq core RT safe.

  - Confine the irq_cpu_online/offline() API to the only left unfixable
    user Cavium Octeon so that it does not grow new usage.

  - A small documentation update =20

 Driver changes:

  - A large cross architecture rework to move irq_enter/exit() into the
    architecture code to make addressing the NOHZ_FULL/RCU issues simpler.

  - The obligatory new irq chip driver for Microchip EIC

  - Modularize a few irq chip drivers

  - Expand usage of devm_*() helpers throughout the driver code

  - The usual small fixes and improvements all over the place

Thanks,

	tglx

------------------>
Arnd Bergmann (1):
      irqchip: Fix compile-testing without CONFIG_OF

Cai Huoqing (5):
      irqchip/irq-mvebu-icu: Make use of the helper function devm_platform_io=
remap_resource()
      irqchip/irq-mvebu-pic: Make use of the helper function devm_platform_io=
remap_resource()
      irqchip/irq-ts4800: Make use of the helper function devm_platform_iorem=
ap_resource()
      irqchip/stm32: Make use of the helper function devm_platform_ioremap_re=
source()
      irqchip/ti-sci-inta: Make use of the helper function devm_platform_iore=
map_resource()

Claudiu Beznea (2):
      dt-bindings: microchip,eic: Add bindings for the Microchip EIC
      irqchip/mchp-eic: Add support for the Microchip EIC

Florian Fainelli (13):
      irqchip/irq-bcm7038-l1: Remove .irq_cpu_offline()
      irqchip/irq-bcm7038-l1: Use irq_get_irq_data()
      MIPS: BMIPS: Remove use of irq_cpu_offline
      irqchip/irq-bcm7038-l1: Gate use of CPU logical map to MIPS
      irqchip/irq-bcm7038-l1: Restrict affinity setting to MIPS
      irqchip/irq-bcm7038-l1: Switch to IRQCHIP_PLATFORM_DRIVER
      genirq: Export irq_gc_{unmask_enable,mask_disable}_reg
      irqchip/irq-brcmstb-l2: Switch to IRQCHIP_PLATFORM_DRIVER
      genirq: Export irq_gc_noop()
      irqchip/irq-bcm7120-l2: Switch to IRQCHIP_PLATFORM_DRIVER
      arm64: broadcom: Removed forced select of interrupt controllers
      ARM: bcm: Removed forced select of interrupt controllers
      irqchip: Fix kernel-doc parameter typo for IRQCHIP_DECLARE

Ingo Molnar (1):
      genirq: Disable irqfixup/poll on PREEMPT_RT.

Josh Cartwright (1):
      genirq: Update irq_set_irqchip_state documentation

Marc Zyngier (5):
      irqchip: Provide stronger type checking for IRQCHIP_MATCH/IRQCHIP_DECLA=
RE
      MIPS: loongson64: Drop call to irq_cpu_offline()
      irqchip/mips-gic: Get rid of the reliance on irq_cpu_online()
      genirq: Hide irq_cpu_{on,off}line() behind a deprecated option
      h8300: Fix linux/irqchip.h include mess

Marian-Cristian Rotariu (1):
      dt-bindings: irqchip: renesas-irqc: Document r8a774e1 bindings

Mark Rutland (17):
      irq: mips: avoid nested irq_enter()
      irq: mips: simplify bcm6345_l1_irq_handle()
      irq: mips: stop (ab)using handle_domain_irq()
      irq: mips: simplify do_domain_IRQ()
      irq: simplify handle_domain_{irq,nmi}()
      irq: unexport handle_irq_desc()
      irq: add generic_handle_arch_irq()
      irq: arc: avoid CONFIG_HANDLE_DOMAIN_IRQ
      irq: nds32: avoid CONFIG_HANDLE_DOMAIN_IRQ
      irq: add a (temporary) CONFIG_HANDLE_DOMAIN_IRQ_IRQENTRY
      irq: arm: perform irqentry in entry code
      irq: arm64: perform irqentry in entry code
      irq: csky: perform irqentry in entry code
      irq: openrisc: perform irqentry in entry code
      irq: riscv: perform irqentry in entry code
      irq: remove CONFIG_HANDLE_DOMAIN_IRQ_IRQENTRY
      irq: remove handle_domain_{irq,nmi}()

Mauro Carvalho Chehab (1):
      MAINTAINERS: update arm,vic.yaml reference

Neil Armstrong (2):
      irqchip/meson-gpio: Make it possible to build as a module
      arm64: meson: remove MESON_IRQ_GPIO selection

Thomas Gleixner (2):
      genirq: Move prio assignment into the newly created thread
      x86/softirq: Disable softirq stacks on PREEMPT_RT

Yang Yingliang (1):
      irqchip/mchp-eic: Fix return value check in mchp_eic_init()

Yanteng Si (1):
      MIPS: irq: Avoid an unused-variable error


 Documentation/core-api/irq/irq-domain.rst          |   3 -
 .../interrupt-controller/microchip,eic.yaml        |  73 ++++++
 .../interrupt-controller/renesas,irqc.yaml         |   1 +
 MAINTAINERS                                        |   8 +-
 arch/arc/Kconfig                                   |   1 -
 arch/arc/kernel/irq.c                              |  10 +-
 arch/arm/Kconfig                                   |   1 -
 arch/arm/kernel/entry-armv.S                       |   5 +-
 arch/arm/kernel/irq.c                              |  14 +-
 arch/arm/mach-bcm/Kconfig                          |   4 -
 arch/arm/mach-imx/avic.c                           |   2 +-
 arch/arm/mach-imx/tzic.c                           |   2 +-
 arch/arm/mach-omap1/irq.c                          |   2 +-
 arch/arm/mach-s3c/irq-s3c24xx.c                    |   2 +-
 arch/arm64/Kconfig                                 |   1 -
 arch/arm64/Kconfig.platforms                       |   4 -
 arch/arm64/kernel/entry-common.c                   |  52 ++--
 arch/csky/Kconfig                                  |   1 -
 arch/csky/kernel/entry.S                           |   2 +-
 arch/csky/kernel/irq.c                             |   5 -
 arch/h8300/include/asm/irq.h                       |   2 -
 arch/h8300/kernel/irq.c                            |   1 +
 arch/mips/Kconfig                                  |   2 +-
 arch/mips/cavium-octeon/octeon-irq.c               |   5 +-
 arch/mips/kernel/irq.c                             |   8 +-
 arch/mips/kernel/smp-bmips.c                       |   3 +-
 arch/mips/loongson64/smp.c                         |   1 -
 arch/nds32/Kconfig                                 |   1 -
 arch/openrisc/Kconfig                              |   1 -
 arch/openrisc/kernel/entry.S                       |   4 +-
 arch/openrisc/kernel/irq.c                         |   5 -
 arch/riscv/Kconfig                                 |   1 -
 arch/riscv/kernel/entry.S                          |   3 +-
 arch/riscv/kernel/smp.c                            |   9 +-
 arch/x86/include/asm/irq_stack.h                   |   3 +
 arch/x86/kernel/irq_32.c                           |   2 +
 drivers/irqchip/Kconfig                            |  25 +-
 drivers/irqchip/Makefile                           |   1 +
 drivers/irqchip/irq-apple-aic.c                    |  20 +-
 drivers/irqchip/irq-armada-370-xp.c                |  13 +-
 drivers/irqchip/irq-aspeed-vic.c                   |   2 +-
 drivers/irqchip/irq-ativic32.c                     |  22 +-
 drivers/irqchip/irq-atmel-aic.c                    |   2 +-
 drivers/irqchip/irq-atmel-aic5.c                   |   2 +-
 drivers/irqchip/irq-bcm2835.c                      |   2 +-
 drivers/irqchip/irq-bcm2836.c                      |   2 +-
 drivers/irqchip/irq-bcm6345-l1.c                   |   6 +-
 drivers/irqchip/irq-bcm7038-l1.c                   |  47 +---
 drivers/irqchip/irq-bcm7120-l2.c                   |  21 +-
 drivers/irqchip/irq-brcmstb-l2.c                   |  16 +-
 drivers/irqchip/irq-clps711x.c                     |   8 +-
 drivers/irqchip/irq-csky-apb-intc.c                |   2 +-
 drivers/irqchip/irq-csky-mpintc.c                  |   4 +-
 drivers/irqchip/irq-davinci-aintc.c                |   2 +-
 drivers/irqchip/irq-davinci-cp-intc.c              |   2 +-
 drivers/irqchip/irq-digicolor.c                    |   2 +-
 drivers/irqchip/irq-dw-apb-ictl.c                  |   2 +-
 drivers/irqchip/irq-ftintc010.c                    |   2 +-
 drivers/irqchip/irq-gic-v3.c                       |   4 +-
 drivers/irqchip/irq-gic.c                          |   2 +-
 drivers/irqchip/irq-hip04.c                        |   2 +-
 drivers/irqchip/irq-ixp4xx.c                       |   4 +-
 drivers/irqchip/irq-lpc32xx.c                      |   2 +-
 drivers/irqchip/irq-mchp-eic.c                     | 280 +++++++++++++++++++=
++
 drivers/irqchip/irq-meson-gpio.c                   |  15 +-
 drivers/irqchip/irq-mips-gic.c                     |  37 ++-
 drivers/irqchip/irq-mmp.c                          |   4 +-
 drivers/irqchip/irq-mvebu-icu.c                    |   4 +-
 drivers/irqchip/irq-mvebu-pic.c                    |   4 +-
 drivers/irqchip/irq-mxs.c                          |   2 +-
 drivers/irqchip/irq-nvic.c                         |  17 +-
 drivers/irqchip/irq-omap-intc.c                    |   2 +-
 drivers/irqchip/irq-or1k-pic.c                     |   2 +-
 drivers/irqchip/irq-orion.c                        |   4 +-
 drivers/irqchip/irq-rda-intc.c                     |   2 +-
 drivers/irqchip/irq-riscv-intc.c                   |   2 +-
 drivers/irqchip/irq-sa11x0.c                       |   4 +-
 drivers/irqchip/irq-stm32-exti.c                   |   4 +-
 drivers/irqchip/irq-sun4i.c                        |   2 +-
 drivers/irqchip/irq-ti-sci-inta.c                  |   4 +-
 drivers/irqchip/irq-ts4800.c                       |   4 +-
 drivers/irqchip/irq-versatile-fpga.c               |   2 +-
 drivers/irqchip/irq-vic.c                          |   2 +-
 drivers/irqchip/irq-vt8500.c                       |   2 +-
 drivers/irqchip/irq-wpcm450-aic.c                  |   2 +-
 drivers/irqchip/irq-zevio.c                        |   2 +-
 include/linux/irq.h                                |   6 +-
 include/linux/irqchip.h                            |  20 +-
 include/linux/irqdesc.h                            |   9 +-
 kernel/irq/Kconfig                                 |  10 +-
 kernel/irq/chip.c                                  |   2 +
 kernel/irq/generic-chip.c                          |   3 +
 kernel/irq/handle.c                                |  18 ++
 kernel/irq/irqdesc.c                               |  81 ++----
 kernel/irq/manage.c                                |   6 +-
 kernel/irq/spurious.c                              |   8 +
 96 files changed, 700 insertions(+), 329 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/mi=
crochip,eic.yaml
 create mode 100644 drivers/irqchip/irq-mchp-eic.c

diff --git a/Documentation/core-api/irq/irq-domain.rst b/Documentation/core-a=
pi/irq/irq-domain.rst
index 9c0e8758037a..d30b4d0a9769 100644
--- a/Documentation/core-api/irq/irq-domain.rst
+++ b/Documentation/core-api/irq/irq-domain.rst
@@ -67,9 +67,6 @@ variety of methods:
   deprecated
 - generic_handle_domain_irq() handles an interrupt described by a
   domain and a hwirq number
-- handle_domain_irq() does the same thing for root interrupt
-  controllers and deals with the set_irq_reg()/irq_enter() sequences
-  that most architecture requires
=20
 Note that irq domain lookups must happen in contexts that are
 compatible with a RCU read-side critical section.
diff --git a/Documentation/devicetree/bindings/interrupt-controller/microchip=
,eic.yaml b/Documentation/devicetree/bindings/interrupt-controller/microchip,=
eic.yaml
new file mode 100644
index 000000000000..50003880ee6f
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/microchip,eic.ya=
ml
@@ -0,0 +1,73 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/microchip,eic.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip External Interrupt Controller
+
+maintainers:
+  - Claudiu Beznea <claudiu.beznea@microchip.com>
+
+description:
+  This interrupt controller is found in Microchip SoCs (SAMA7G5) and provides
+  support for handling up to 2 external interrupt lines.
+
+properties:
+  compatible:
+    enum:
+      - microchip,sama7g5-eic
+
+  reg:
+    maxItems: 1
+
+  interrupt-controller: true
+
+  '#interrupt-cells':
+    const: 2
+    description:
+      The first cell is the input IRQ number (between 0 and 1), the second c=
ell
+      is the trigger type as defined in interrupt.txt present in this direct=
ory.
+
+  interrupts:
+    description: |
+      Contains the GIC SPI IRQs mapped to the external interrupt lines. They
+      should be specified sequentially from output 0 to output 1.
+    minItems: 2
+    maxItems: 2
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: pclk
+
+required:
+  - compatible
+  - reg
+  - interrupt-controller
+  - '#interrupt-cells'
+  - interrupts
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/at91.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    eic: interrupt-controller@e1628000 {
+      compatible =3D "microchip,sama7g5-eic";
+      reg =3D <0xe1628000 0x100>;
+      interrupt-parent =3D <&gic>;
+      interrupt-controller;
+      #interrupt-cells =3D <2>;
+      interrupts =3D <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>;
+      clocks =3D <&pmc PMC_TYPE_PERIPHERAL 37>;
+      clock-names =3D "pclk";
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,i=
rqc.yaml b/Documentation/devicetree/bindings/interrupt-controller/renesas,irq=
c.yaml
index abb22db3bb28..79d0358e2f61 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.yaml
@@ -27,6 +27,7 @@ properties:
           - renesas,intc-ex-r8a774a1    # RZ/G2M
           - renesas,intc-ex-r8a774b1    # RZ/G2N
           - renesas,intc-ex-r8a774c0    # RZ/G2E
+          - renesas,intc-ex-r8a774e1    # RZ/G2H
           - renesas,intc-ex-r8a7795     # R-Car H3
           - renesas,intc-ex-r8a7796     # R-Car M3-W
           - renesas,intc-ex-r8a77961    # R-Car M3-W+
diff --git a/MAINTAINERS b/MAINTAINERS
index abdcbcfef73d..eed7668a5dd0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1551,7 +1551,7 @@ ARM PRIMECELL VIC PL190/PL192 DRIVER
 M:	Linus Walleij <linus.walleij@linaro.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-F:	Documentation/devicetree/bindings/interrupt-controller/arm,vic.txt
+F:	Documentation/devicetree/bindings/interrupt-controller/arm,vic.yaml
 F:	drivers/irqchip/irq-vic.c
=20
 ARM SMC WATCHDOG DRIVER
@@ -12254,6 +12254,12 @@ L:	linux-crypto@vger.kernel.org
 S:	Maintained
 F:	drivers/crypto/atmel-ecc.*
=20
+MICROCHIP EIC DRIVER
+M:	Claudiu Beznea <claudiu.beznea@microchip.com>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Supported
+F:	drivers/irqchip/irq-mchp-eic.c
+
 MICROCHIP I2C DRIVER
 M:	Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
 L:	linux-i2c@vger.kernel.org
diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index 3a5a80f302e1..b4ae6058902a 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -40,7 +40,6 @@ config ARC
 	select HAVE_KRETPROBES
 	select HAVE_MOD_ARCH_SPECIFIC
 	select HAVE_PERF_EVENTS
-	select HANDLE_DOMAIN_IRQ
 	select IRQ_DOMAIN
 	select MODULES_USE_ELF_RELA
 	select OF
diff --git a/arch/arc/kernel/irq.c b/arch/arc/kernel/irq.c
index ef909dd4b40c..dd09b58ff82d 100644
--- a/arch/arc/kernel/irq.c
+++ b/arch/arc/kernel/irq.c
@@ -6,6 +6,8 @@
 #include <linux/interrupt.h>
 #include <linux/irqchip.h>
 #include <asm/mach_desc.h>
+
+#include <asm/irq_regs.h>
 #include <asm/smp.h>
=20
 /*
@@ -39,5 +41,11 @@ void __init init_IRQ(void)
  */
 void arch_do_IRQ(unsigned int hwirq, struct pt_regs *regs)
 {
-	handle_domain_irq(NULL, hwirq, regs);
+	struct pt_regs *old_regs;
+
+	irq_enter();
+	old_regs =3D set_irq_regs(regs);
+	generic_handle_domain_irq(NULL, hwirq);
+	set_irq_regs(old_regs);
+	irq_exit();
 }
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index fc196421b2ce..3361a6c29ee9 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -64,7 +64,6 @@ config ARM
 	select GENERIC_PCI_IOMAP
 	select GENERIC_SCHED_CLOCK
 	select GENERIC_SMP_IDLE_THREAD
-	select HANDLE_DOMAIN_IRQ
 	select HARDIRQS_SW_RESEND
 	select HAVE_ARCH_AUDITSYSCALL if AEABI && !OABI_COMPAT
 	select HAVE_ARCH_BITREVERSE if (CPU_32v7M || CPU_32v7) && !CPU_32v6
diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index 241b73d64df7..3d0b6169ab86 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -38,14 +38,11 @@
  */
 	.macro	irq_handler
 #ifdef CONFIG_GENERIC_IRQ_MULTI_HANDLER
-	ldr	r1, =3Dhandle_arch_irq
 	mov	r0, sp
-	badr	lr, 9997f
-	ldr	pc, [r1]
+	bl	generic_handle_arch_irq
 #else
 	arch_irq_handler_default
 #endif
-9997:
 	.endm
=20
 	.macro	pabt_helper
diff --git a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c
index 20ab1e607522..b79975bd988c 100644
--- a/arch/arm/kernel/irq.c
+++ b/arch/arm/kernel/irq.c
@@ -63,11 +63,8 @@ int arch_show_interrupts(struct seq_file *p, int prec)
  */
 void handle_IRQ(unsigned int irq, struct pt_regs *regs)
 {
-	struct pt_regs *old_regs =3D set_irq_regs(regs);
 	struct irq_desc *desc;
=20
-	irq_enter();
-
 	/*
 	 * Some hardware gives randomly wrong interrupts.  Rather
 	 * than crashing, do something sensible.
@@ -81,9 +78,6 @@ void handle_IRQ(unsigned int irq, struct pt_regs *regs)
 		handle_irq_desc(desc);
 	else
 		ack_bad_irq(irq);
-
-	irq_exit();
-	set_irq_regs(old_regs);
 }
=20
 /*
@@ -92,7 +86,15 @@ void handle_IRQ(unsigned int irq, struct pt_regs *regs)
 asmlinkage void __exception_irq_entry
 asm_do_IRQ(unsigned int irq, struct pt_regs *regs)
 {
+	struct pt_regs *old_regs;
+
+	irq_enter();
+	old_regs =3D set_irq_regs(regs);
+
 	handle_IRQ(irq, regs);
+
+	set_irq_regs(old_regs);
+	irq_exit();
 }
=20
 void __init init_IRQ(void)
diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
index 2890e61b2b46..bd3f82788ebc 100644
--- a/arch/arm/mach-bcm/Kconfig
+++ b/arch/arm/mach-bcm/Kconfig
@@ -161,7 +161,6 @@ config ARCH_BCM2835
 	select ARM_TIMER_SP804
 	select HAVE_ARM_ARCH_TIMER if ARCH_MULTI_V7
 	select BCM2835_TIMER
-	select BRCMSTB_L2_IRQ
 	select PINCTRL
 	select PINCTRL_BCM2835
 	select MFD_CORE
@@ -209,9 +208,6 @@ config ARCH_BRCMSTB
 	select ARM_GIC
 	select ARM_ERRATA_798181 if SMP
 	select HAVE_ARM_ARCH_TIMER
-	select BCM7038_L1_IRQ
-	select BRCMSTB_L2_IRQ
-	select BCM7120_L2_IRQ
 	select ZONE_DMA if ARM_LPAE
 	select SOC_BRCMSTB
 	select SOC_BUS
diff --git a/arch/arm/mach-imx/avic.c b/arch/arm/mach-imx/avic.c
index 21bce4049cec..cf6546ddc7a3 100644
--- a/arch/arm/mach-imx/avic.c
+++ b/arch/arm/mach-imx/avic.c
@@ -154,7 +154,7 @@ static void __exception_irq_entry avic_handle_irq(struct =
pt_regs *regs)
 		if (nivector =3D=3D 0xffff)
 			break;
=20
-		handle_domain_irq(domain, nivector, regs);
+		generic_handle_domain_irq(domain, nivector);
 	} while (1);
 }
=20
diff --git a/arch/arm/mach-imx/tzic.c b/arch/arm/mach-imx/tzic.c
index 479a01bdac56..8b3d98d288d9 100644
--- a/arch/arm/mach-imx/tzic.c
+++ b/arch/arm/mach-imx/tzic.c
@@ -134,7 +134,7 @@ static void __exception_irq_entry tzic_handle_irq(struct =
pt_regs *regs)
 			while (stat) {
 				handled =3D 1;
 				irqofs =3D fls(stat) - 1;
-				handle_domain_irq(domain, irqofs + i * 32, regs);
+				generic_handle_domain_irq(domain, irqofs + i * 32);
 				stat &=3D ~(1 << irqofs);
 			}
 		}
diff --git a/arch/arm/mach-omap1/irq.c b/arch/arm/mach-omap1/irq.c
index b11edc8a46f0..ee6a93083154 100644
--- a/arch/arm/mach-omap1/irq.c
+++ b/arch/arm/mach-omap1/irq.c
@@ -165,7 +165,7 @@ asmlinkage void __exception_irq_entry omap1_handle_irq(st=
ruct pt_regs *regs)
 		}
 irq:
 		if (irqnr)
-			handle_domain_irq(domain, irqnr, regs);
+			generic_handle_domain_irq(domain, irqnr);
 		else
 			break;
 	} while (irqnr);
diff --git a/arch/arm/mach-s3c/irq-s3c24xx.c b/arch/arm/mach-s3c/irq-s3c24xx.c
index 3edc5f614eef..45dfd546e6fa 100644
--- a/arch/arm/mach-s3c/irq-s3c24xx.c
+++ b/arch/arm/mach-s3c/irq-s3c24xx.c
@@ -354,7 +354,7 @@ static inline int s3c24xx_handle_intc(struct s3c_irq_intc=
 *intc,
 	if (!(pnd & (1 << offset)))
 		offset =3D  __ffs(pnd);
=20
-	handle_domain_irq(intc->domain, intc_offset + offset, regs);
+	generic_handle_domain_irq(intc->domain, intc_offset + offset);
 	return true;
 }
=20
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 5c7ae4c3954b..e6593a03ea27 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -133,7 +133,6 @@ config ARM64
 	select GENERIC_TIME_VSYSCALL
 	select GENERIC_GETTIMEOFDAY
 	select GENERIC_VDSO_TIME_NS
-	select HANDLE_DOMAIN_IRQ
 	select HARDIRQS_SW_RESEND
 	select HAVE_MOVE_PMD
 	select HAVE_MOVE_PUD
diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index b0ce18d4cc98..96a81967c3bf 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -44,7 +44,6 @@ config ARCH_BCM2835
 	select ARM_AMBA
 	select ARM_GIC
 	select ARM_TIMER_SP804
-	select BRCMSTB_L2_IRQ
 	help
 	  This enables support for the Broadcom BCM2837 and BCM2711 SoC.
 	  These SoCs are used in the Raspberry Pi 3 and 4 devices.
@@ -82,8 +81,6 @@ config ARCH_BITMAIN
 config ARCH_BRCMSTB
 	bool "Broadcom Set-Top-Box SoCs"
 	select ARCH_HAS_RESET_CONTROLLER
-	select BCM7038_L1_IRQ
-	select BRCMSTB_L2_IRQ
 	select GENERIC_IRQ_CHIP
 	select PINCTRL
 	help
@@ -167,7 +164,6 @@ config ARCH_MEDIATEK
 config ARCH_MESON
 	bool "Amlogic Platforms"
 	select COMMON_CLK
-	select MESON_IRQ_GPIO
 	help
 	  This enables support for the arm64 based Amlogic SoCs
 	  such as the s905, S905X/D, S912, A113X/D or S905X/D2
diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-commo=
n.c
index 32f9796c4ffe..f7408edf8571 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -17,6 +17,7 @@
 #include <asm/daifflags.h>
 #include <asm/esr.h>
 #include <asm/exception.h>
+#include <asm/irq_regs.h>
 #include <asm/kprobes.h>
 #include <asm/mmu.h>
 #include <asm/processor.h>
@@ -219,22 +220,6 @@ static void noinstr arm64_exit_el1_dbg(struct pt_regs *r=
egs)
 		lockdep_hardirqs_on(CALLER_ADDR0);
 }
=20
-static void noinstr enter_el1_irq_or_nmi(struct pt_regs *regs)
-{
-	if (IS_ENABLED(CONFIG_ARM64_PSEUDO_NMI) && !interrupts_enabled(regs))
-		arm64_enter_nmi(regs);
-	else
-		enter_from_kernel_mode(regs);
-}
-
-static void noinstr exit_el1_irq_or_nmi(struct pt_regs *regs)
-{
-	if (IS_ENABLED(CONFIG_ARM64_PSEUDO_NMI) && !interrupts_enabled(regs))
-		arm64_exit_nmi(regs);
-	else
-		exit_to_kernel_mode(regs);
-}
-
 static void __sched arm64_preempt_schedule_irq(void)
 {
 	lockdep_assert_irqs_disabled();
@@ -263,10 +248,14 @@ static void __sched arm64_preempt_schedule_irq(void)
 static void do_interrupt_handler(struct pt_regs *regs,
 				 void (*handler)(struct pt_regs *))
 {
+	struct pt_regs *old_regs =3D set_irq_regs(regs);
+
 	if (on_thread_stack())
 		call_on_irq_stack(regs, handler);
 	else
 		handler(regs);
+
+	set_irq_regs(old_regs);
 }
=20
 extern void (*handle_arch_irq)(struct pt_regs *);
@@ -432,13 +421,22 @@ asmlinkage void noinstr el1h_64_sync_handler(struct pt_=
regs *regs)
 	}
 }
=20
-static void noinstr el1_interrupt(struct pt_regs *regs,
-				  void (*handler)(struct pt_regs *))
+static __always_inline void __el1_pnmi(struct pt_regs *regs,
+				       void (*handler)(struct pt_regs *))
 {
-	write_sysreg(DAIF_PROCCTX_NOIRQ, daif);
+	arm64_enter_nmi(regs);
+	do_interrupt_handler(regs, handler);
+	arm64_exit_nmi(regs);
+}
+
+static __always_inline void __el1_irq(struct pt_regs *regs,
+				      void (*handler)(struct pt_regs *))
+{
+	enter_from_kernel_mode(regs);
=20
-	enter_el1_irq_or_nmi(regs);
+	irq_enter_rcu();
 	do_interrupt_handler(regs, handler);
+	irq_exit_rcu();
=20
 	/*
 	 * Note: thread_info::preempt_count includes both thread_info::count
@@ -449,7 +447,17 @@ static void noinstr el1_interrupt(struct pt_regs *regs,
 	    READ_ONCE(current_thread_info()->preempt_count) =3D=3D 0)
 		arm64_preempt_schedule_irq();
=20
-	exit_el1_irq_or_nmi(regs);
+	exit_to_kernel_mode(regs);
+}
+static void noinstr el1_interrupt(struct pt_regs *regs,
+				  void (*handler)(struct pt_regs *))
+{
+	write_sysreg(DAIF_PROCCTX_NOIRQ, daif);
+
+	if (IS_ENABLED(CONFIG_ARM64_PSEUDO_NMI) && !interrupts_enabled(regs))
+		__el1_pnmi(regs, handler);
+	else
+		__el1_irq(regs, handler);
 }
=20
 asmlinkage void noinstr el1h_64_irq_handler(struct pt_regs *regs)
@@ -667,7 +675,9 @@ static void noinstr el0_interrupt(struct pt_regs *regs,
 	if (regs->pc & BIT(55))
 		arm64_apply_bp_hardening();
=20
+	irq_enter_rcu();
 	do_interrupt_handler(regs, handler);
+	irq_exit_rcu();
=20
 	exit_to_user_mode(regs);
 }
diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 9d4d898df76b..e0bd71b9e23f 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -17,7 +17,6 @@ config CSKY
 	select CSKY_APB_INTC
 	select DMA_DIRECT_REMAP
 	select IRQ_DOMAIN
-	select HANDLE_DOMAIN_IRQ
 	select DW_APB_TIMER_OF
 	select GENERIC_IOREMAP
 	select GENERIC_LIB_ASHLDI3
diff --git a/arch/csky/kernel/entry.S b/arch/csky/kernel/entry.S
index 00e3c8ebf9b8..a4ababf25e24 100644
--- a/arch/csky/kernel/entry.S
+++ b/arch/csky/kernel/entry.S
@@ -249,7 +249,7 @@ ENTRY(csky_irq)
=20
=20
 	mov	a0, sp
-	jbsr	csky_do_IRQ
+	jbsr	generic_handle_arch_irq
=20
 	jmpi	ret_from_exception
=20
diff --git a/arch/csky/kernel/irq.c b/arch/csky/kernel/irq.c
index 03a1930f1cbb..fcdaf3156286 100644
--- a/arch/csky/kernel/irq.c
+++ b/arch/csky/kernel/irq.c
@@ -15,8 +15,3 @@ void __init init_IRQ(void)
 	setup_smp_ipi();
 #endif
 }
-
-asmlinkage void __irq_entry csky_do_IRQ(struct pt_regs *regs)
-{
-	handle_arch_irq(regs);
-}
diff --git a/arch/h8300/include/asm/irq.h b/arch/h8300/include/asm/irq.h
index 5fc5b436dde9..776cf06d7a59 100644
--- a/arch/h8300/include/asm/irq.h
+++ b/arch/h8300/include/asm/irq.h
@@ -2,8 +2,6 @@
 #ifndef _H8300_IRQ_H_
 #define _H8300_IRQ_H_
=20
-#include <linux/irqchip.h>
-
 #if defined(CONFIG_CPU_H8300H)
 #define NR_IRQS 64
 #define IRQ_CHIP h8300h_irq_chip
diff --git a/arch/h8300/kernel/irq.c b/arch/h8300/kernel/irq.c
index 834e4d7b1bcf..8ad6d702cd0b 100644
--- a/arch/h8300/kernel/irq.c
+++ b/arch/h8300/kernel/irq.c
@@ -8,6 +8,7 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/irqchip.h>
 #include <linux/irqdomain.h>
 #include <linux/of_irq.h>
 #include <asm/traps.h>
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 771ca53af06d..bf172aeaa2c0 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -47,7 +47,6 @@ config MIPS
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_TIME_VSYSCALL
 	select GUP_GET_PTE_LOW_HIGH if CPU_MIPS32 && PHYS_ADDR_T_64BIT
-	select HANDLE_DOMAIN_IRQ
 	select HAVE_ARCH_COMPILER_H
 	select HAVE_ARCH_JUMP_LABEL
 	select HAVE_ARCH_KGDB if MIPS_FP_SUPPORT
@@ -1782,6 +1781,7 @@ config CPU_BMIPS
 	select CPU_HAS_PREFETCH
 	select CPU_SUPPORTS_CPUFREQ
 	select MIPS_EXTERNAL_TIMER
+	select GENERIC_IRQ_MIGRATION if HOTPLUG_CPU
 	help
 	  Support for BMIPS32/3300/4350/4380 and BMIPS5000 processors.
=20
diff --git a/arch/mips/cavium-octeon/octeon-irq.c b/arch/mips/cavium-octeon/o=
cteon-irq.c
index be5d4afcd30f..844f882096e6 100644
--- a/arch/mips/cavium-octeon/octeon-irq.c
+++ b/arch/mips/cavium-octeon/octeon-irq.c
@@ -2609,7 +2609,10 @@ static void octeon_irq_ciu3_ip2(void)
 		else
 			hw =3D intsn;
=20
-		ret =3D handle_domain_irq(domain, hw, NULL);
+		irq_enter();
+		ret =3D generic_handle_domain_irq(domain, hw);
+		irq_exit();
+
 		if (ret < 0) {
 			union cvmx_ciu3_iscx_w1c isc_w1c;
 			u64 isc_w1c_addr =3D ciu3_addr + CIU3_ISC_W1C(intsn);
diff --git a/arch/mips/kernel/irq.c b/arch/mips/kernel/irq.c
index d20e002b3246..5e11582fe308 100644
--- a/arch/mips/kernel/irq.c
+++ b/arch/mips/kernel/irq.c
@@ -111,15 +111,9 @@ void __irq_entry do_IRQ(unsigned int irq)
 #ifdef CONFIG_IRQ_DOMAIN
 void __irq_entry do_domain_IRQ(struct irq_domain *domain, unsigned int hwirq)
 {
-	struct irq_desc *desc;
-
 	irq_enter();
 	check_stack_overflow();
-
-	desc =3D irq_resolve_mapping(domain, hwirq);
-	if (likely(desc))
-		handle_irq_desc(desc);
-
+	generic_handle_domain_irq(domain, hwirq);
 	irq_exit();
 }
 #endif
diff --git a/arch/mips/kernel/smp-bmips.c b/arch/mips/kernel/smp-bmips.c
index b6ef5f7312cf..f5d7bfa3472a 100644
--- a/arch/mips/kernel/smp-bmips.c
+++ b/arch/mips/kernel/smp-bmips.c
@@ -26,6 +26,7 @@
 #include <linux/bug.h>
 #include <linux/kernel.h>
 #include <linux/kexec.h>
+#include <linux/irq.h>
=20
 #include <asm/time.h>
 #include <asm/processor.h>
@@ -373,7 +374,7 @@ static int bmips_cpu_disable(void)
=20
 	set_cpu_online(cpu, false);
 	calculate_cpu_foreign_map();
-	irq_cpu_offline();
+	irq_migrate_all_off_this_cpu();
 	clear_c0_status(IE_IRQ5);
=20
 	local_flush_tlb_all();
diff --git a/arch/mips/loongson64/smp.c b/arch/mips/loongson64/smp.c
index 09ebe84a17fe..660e1de4412a 100644
--- a/arch/mips/loongson64/smp.c
+++ b/arch/mips/loongson64/smp.c
@@ -550,7 +550,6 @@ static int loongson3_cpu_disable(void)
 	set_cpu_online(cpu, false);
 	calculate_cpu_foreign_map();
 	local_irq_save(flags);
-	irq_cpu_offline();
 	clear_c0_status(ST0_IM);
 	local_irq_restore(flags);
 	local_flush_tlb_all();
diff --git a/arch/nds32/Kconfig b/arch/nds32/Kconfig
index aea26e739543..4d1421b18734 100644
--- a/arch/nds32/Kconfig
+++ b/arch/nds32/Kconfig
@@ -27,7 +27,6 @@ config NDS32
 	select GENERIC_LIB_MULDI3
 	select GENERIC_LIB_UCMPDI2
 	select GENERIC_TIME_VSYSCALL
-	select HANDLE_DOMAIN_IRQ
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_EXIT_THREAD
diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index e804026b4797..c2491b295d60 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -13,7 +13,6 @@ config OPENRISC
 	select OF
 	select OF_EARLY_FLATTREE
 	select IRQ_DOMAIN
-	select HANDLE_DOMAIN_IRQ
 	select GPIOLIB
 	select HAVE_ARCH_TRACEHOOK
 	select SPARSE_IRQ
diff --git a/arch/openrisc/kernel/entry.S b/arch/openrisc/kernel/entry.S
index edaa775a648e..59c6d3aa7081 100644
--- a/arch/openrisc/kernel/entry.S
+++ b/arch/openrisc/kernel/entry.S
@@ -569,8 +569,8 @@ EXCEPTION_ENTRY(_external_irq_handler)
 #endif
 	CLEAR_LWA_FLAG(r3)
 	l.addi	r3,r1,0
-	l.movhi	r8,hi(do_IRQ)
-	l.ori	r8,r8,lo(do_IRQ)
+	l.movhi	r8,hi(generic_handle_arch_irq)
+	l.ori	r8,r8,lo(generic_handle_arch_irq)
 	l.jalr r8
 	l.nop
 	l.j    _ret_from_intr
diff --git a/arch/openrisc/kernel/irq.c b/arch/openrisc/kernel/irq.c
index c38fa863afa8..f38e10962a84 100644
--- a/arch/openrisc/kernel/irq.c
+++ b/arch/openrisc/kernel/irq.c
@@ -36,8 +36,3 @@ void __init init_IRQ(void)
 {
 	irqchip_init();
 }
-
-void __irq_entry do_IRQ(struct pt_regs *regs)
-{
-	handle_arch_irq(regs);
-}
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 301a54233c7e..353e28f5f849 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -62,7 +62,6 @@ config RISCV
 	select GENERIC_SCHED_CLOCK
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_TIME_VSYSCALL if MMU && 64BIT
-	select HANDLE_DOMAIN_IRQ
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL
 	select HAVE_ARCH_JUMP_LABEL_RELATIVE if !XIP_KERNEL
diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 98f502654edd..64236f7efde5 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -130,8 +130,7 @@ skip_context_tracking:
=20
 	/* Handle interrupts */
 	move a0, sp /* pt_regs */
-	la a1, handle_arch_irq
-	REG_L a1, (a1)
+	la a1, generic_handle_arch_irq
 	jr a1
 1:
 	/*
diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
index 921d9d7df400..2f6da845c9ae 100644
--- a/arch/riscv/kernel/smp.c
+++ b/arch/riscv/kernel/smp.c
@@ -140,12 +140,9 @@ void arch_irq_work_raise(void)
=20
 void handle_IPI(struct pt_regs *regs)
 {
-	struct pt_regs *old_regs =3D set_irq_regs(regs);
 	unsigned long *pending_ipis =3D &ipi_data[smp_processor_id()].bits;
 	unsigned long *stats =3D ipi_data[smp_processor_id()].stats;
=20
-	irq_enter();
-
 	riscv_clear_ipi();
=20
 	while (true) {
@@ -156,7 +153,7 @@ void handle_IPI(struct pt_regs *regs)
=20
 		ops =3D xchg(pending_ipis, 0);
 		if (ops =3D=3D 0)
-			goto done;
+			return;
=20
 		if (ops & (1 << IPI_RESCHEDULE)) {
 			stats[IPI_RESCHEDULE]++;
@@ -189,10 +186,6 @@ void handle_IPI(struct pt_regs *regs)
 		/* Order data access and bit testing. */
 		mb();
 	}
-
-done:
-	irq_exit();
-	set_irq_regs(old_regs);
 }
=20
 static const char * const ipi_names[] =3D {
diff --git a/arch/x86/include/asm/irq_stack.h b/arch/x86/include/asm/irq_stac=
k.h
index 562854c60808..ea0c5ab31da4 100644
--- a/arch/x86/include/asm/irq_stack.h
+++ b/arch/x86/include/asm/irq_stack.h
@@ -185,6 +185,7 @@
 			      IRQ_CONSTRAINTS, regs, vector);		\
 }
=20
+#ifndef CONFIG_PREEMPT_RT
 #define ASM_CALL_SOFTIRQ						\
 	"call %P[__func]				\n"
=20
@@ -201,6 +202,8 @@
 	__this_cpu_write(hardirq_stack_inuse, false);			\
 }
=20
+#endif
+
 #else /* CONFIG_X86_64 */
 /* System vector handlers always run on the stack they interrupted. */
 #define run_sysvec_on_irqstack_cond(func, regs)				\
diff --git a/arch/x86/kernel/irq_32.c b/arch/x86/kernel/irq_32.c
index 044902d5a3c4..e5dd6da78713 100644
--- a/arch/x86/kernel/irq_32.c
+++ b/arch/x86/kernel/irq_32.c
@@ -132,6 +132,7 @@ int irq_init_percpu_irqstack(unsigned int cpu)
 	return 0;
 }
=20
+#ifndef CONFIG_PREEMPT_RT
 void do_softirq_own_stack(void)
 {
 	struct irq_stack *irqstk;
@@ -148,6 +149,7 @@ void do_softirq_own_stack(void)
=20
 	call_on_stack(__do_softirq, isp);
 }
+#endif
=20
 void __handle_irq(struct irq_desc *desc, struct pt_regs *regs)
 {
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index aca7b595c4c7..7038957f4a77 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -115,18 +115,24 @@ config BCM6345_L1_IRQ
 	select GENERIC_IRQ_EFFECTIVE_AFF_MASK
=20
 config BCM7038_L1_IRQ
-	bool
+	tristate "Broadcom STB 7038-style L1/L2 interrupt controller driver"
+	depends on ARCH_BRCMSTB || BMIPS_GENERIC
+	default ARCH_BRCMSTB || BMIPS_GENERIC
 	select GENERIC_IRQ_CHIP
 	select IRQ_DOMAIN
 	select GENERIC_IRQ_EFFECTIVE_AFF_MASK
=20
 config BCM7120_L2_IRQ
-	bool
+	tristate "Broadcom STB 7120-style L2 interrupt controller driver"
+	depends on ARCH_BRCMSTB || BMIPS_GENERIC
+	default ARCH_BRCMSTB || BMIPS_GENERIC
 	select GENERIC_IRQ_CHIP
 	select IRQ_DOMAIN
=20
 config BRCMSTB_L2_IRQ
-	bool
+	tristate "Broadcom STB generic L2 interrupt controller driver"
+	depends on ARCH_BCM2835 || ARCH_BRCMSTB || BMIPS_GENERIC
+	default ARCH_BCM2835 || ARCH_BRCMSTB || BMIPS_GENERIC
 	select GENERIC_IRQ_CHIP
 	select IRQ_DOMAIN
=20
@@ -400,8 +406,9 @@ config IRQ_UNIPHIER_AIDET
 	  Support for the UniPhier AIDET (ARM Interrupt Detector).
=20
 config MESON_IRQ_GPIO
-       bool "Meson GPIO Interrupt Multiplexer"
-       depends on ARCH_MESON
+       tristate "Meson GPIO Interrupt Multiplexer"
+       depends on ARCH_MESON || COMPILE_TEST
+       default ARCH_MESON
        select IRQ_DOMAIN_HIERARCHY
        help
          Support Meson SoC Family GPIO Interrupt Multiplexer
@@ -602,4 +609,12 @@ config APPLE_AIC
 	  Support for the Apple Interrupt Controller found on Apple Silicon SoCs,
 	  such as the M1.
=20
+config MCHP_EIC
+	bool "Microchip External Interrupt Controller"
+	depends on ARCH_AT91 || COMPILE_TEST
+	select IRQ_DOMAIN
+	select IRQ_DOMAIN_HIERARCHY
+	help
+	  Support for Microchip External Interrupt Controller.
+
 endmenu
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index f88cbf36a9d2..c1f611cbfbf8 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -116,3 +116,4 @@ obj-$(CONFIG_MACH_REALTEK_RTL)		+=3D irq-realtek-rtl.o
 obj-$(CONFIG_WPCM450_AIC)		+=3D irq-wpcm450-aic.o
 obj-$(CONFIG_IRQ_IDT3243X)		+=3D irq-idt3243x.o
 obj-$(CONFIG_APPLE_AIC)			+=3D irq-apple-aic.o
+obj-$(CONFIG_MCHP_EIC)			+=3D irq-mchp-eic.o
diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-aic.c
index 6fc145aacaf0..3759dc36cc8f 100644
--- a/drivers/irqchip/irq-apple-aic.c
+++ b/drivers/irqchip/irq-apple-aic.c
@@ -245,7 +245,7 @@ static void __exception_irq_entry aic_handle_irq(struct p=
t_regs *regs)
 		irq =3D FIELD_GET(AIC_EVENT_NUM, event);
=20
 		if (type =3D=3D AIC_EVENT_TYPE_HW)
-			handle_domain_irq(aic_irqc->hw_domain, irq, regs);
+			generic_handle_domain_irq(aic_irqc->hw_domain, irq);
 		else if (type =3D=3D AIC_EVENT_TYPE_IPI && irq =3D=3D 1)
 			aic_handle_ipi(regs);
 		else if (event !=3D 0)
@@ -392,25 +392,25 @@ static void __exception_irq_entry aic_handle_fiq(struct=
 pt_regs *regs)
 	}
=20
 	if (TIMER_FIRING(read_sysreg(cntp_ctl_el0)))
-		handle_domain_irq(aic_irqc->hw_domain,
-				  aic_irqc->nr_hw + AIC_TMR_EL0_PHYS, regs);
+		generic_handle_domain_irq(aic_irqc->hw_domain,
+					  aic_irqc->nr_hw + AIC_TMR_EL0_PHYS);
=20
 	if (TIMER_FIRING(read_sysreg(cntv_ctl_el0)))
-		handle_domain_irq(aic_irqc->hw_domain,
-				  aic_irqc->nr_hw + AIC_TMR_EL0_VIRT, regs);
+		generic_handle_domain_irq(aic_irqc->hw_domain,
+					  aic_irqc->nr_hw + AIC_TMR_EL0_VIRT);
=20
 	if (is_kernel_in_hyp_mode()) {
 		uint64_t enabled =3D read_sysreg_s(SYS_IMP_APL_VM_TMR_FIQ_ENA_EL2);
=20
 		if ((enabled & VM_TMR_FIQ_ENABLE_P) &&
 		    TIMER_FIRING(read_sysreg_s(SYS_CNTP_CTL_EL02)))
-			handle_domain_irq(aic_irqc->hw_domain,
-					  aic_irqc->nr_hw + AIC_TMR_EL02_PHYS, regs);
+			generic_handle_domain_irq(aic_irqc->hw_domain,
+						  aic_irqc->nr_hw + AIC_TMR_EL02_PHYS);
=20
 		if ((enabled & VM_TMR_FIQ_ENABLE_V) &&
 		    TIMER_FIRING(read_sysreg_s(SYS_CNTV_CTL_EL02)))
-			handle_domain_irq(aic_irqc->hw_domain,
-					  aic_irqc->nr_hw + AIC_TMR_EL02_VIRT, regs);
+			generic_handle_domain_irq(aic_irqc->hw_domain,
+						  aic_irqc->nr_hw + AIC_TMR_EL02_VIRT);
 	}
=20
 	if ((read_sysreg_s(SYS_IMP_APL_PMCR0_EL1) & (PMCR0_IMODE | PMCR0_IACT)) =3D=
=3D
@@ -674,7 +674,7 @@ static void aic_handle_ipi(struct pt_regs *regs)
 	firing =3D atomic_fetch_andnot(enabled, this_cpu_ptr(&aic_vipi_flag)) & ena=
bled;
=20
 	for_each_set_bit(i, &firing, AIC_NR_SWIPI)
-		handle_domain_irq(aic_irqc->ipi_domain, i, regs);
+		generic_handle_domain_irq(aic_irqc->ipi_domain, i);
=20
 	/*
 	 * No ordering needed here; at worst this just changes the timing of
diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada=
-370-xp.c
index 53e0fb0562c1..80906bfec845 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -589,12 +589,7 @@ static void armada_370_xp_handle_msi_irq(struct pt_regs =
*regs, bool is_chained)
=20
 		irq =3D msinr - PCI_MSI_DOORBELL_START;
=20
-		if (is_chained)
-			generic_handle_domain_irq(armada_370_xp_msi_inner_domain,
-						  irq);
-		else
-			handle_domain_irq(armada_370_xp_msi_inner_domain,
-					  irq, regs);
+		generic_handle_domain_irq(armada_370_xp_msi_inner_domain, irq);
 	}
 }
 #else
@@ -646,8 +641,8 @@ armada_370_xp_handle_irq(struct pt_regs *regs)
 			break;
=20
 		if (irqnr > 1) {
-			handle_domain_irq(armada_370_xp_mpic_domain,
-					  irqnr, regs);
+			generic_handle_domain_irq(armada_370_xp_mpic_domain,
+						  irqnr);
 			continue;
 		}
=20
@@ -666,7 +661,7 @@ armada_370_xp_handle_irq(struct pt_regs *regs)
 				& IPI_DOORBELL_MASK;
=20
 			for_each_set_bit(ipi, &ipimask, IPI_DOORBELL_END)
-				handle_domain_irq(ipi_domain, ipi, regs);
+				generic_handle_domain_irq(ipi_domain, ipi);
 		}
 #endif
=20
diff --git a/drivers/irqchip/irq-aspeed-vic.c b/drivers/irqchip/irq-aspeed-vi=
c.c
index 58717cd44f99..62ccf2c0c414 100644
--- a/drivers/irqchip/irq-aspeed-vic.c
+++ b/drivers/irqchip/irq-aspeed-vic.c
@@ -100,7 +100,7 @@ static void __exception_irq_entry avic_handle_irq(struct =
pt_regs *regs)
 		if (stat =3D=3D 0)
 			break;
 		irq +=3D ffs(stat) - 1;
-		handle_domain_irq(vic->dom, irq, regs);
+		generic_handle_domain_irq(vic->dom, irq);
 	}
 }
=20
diff --git a/drivers/irqchip/irq-ativic32.c b/drivers/irqchip/irq-ativic32.c
index 476d6024aaf2..223dd2f97d28 100644
--- a/drivers/irqchip/irq-ativic32.c
+++ b/drivers/irqchip/irq-ativic32.c
@@ -5,11 +5,14 @@
 #include <linux/of.h>
 #include <linux/of_irq.h>
 #include <linux/of_address.h>
+#include <linux/hardirq.h>
 #include <linux/interrupt.h>
 #include <linux/irqdomain.h>
 #include <linux/irqchip.h>
 #include <nds32_intrinsic.h>
=20
+#include <asm/irq_regs.h>
+
 unsigned long wake_mask;
=20
 static void ativic32_ack_irq(struct irq_data *data)
@@ -103,10 +106,25 @@ static irq_hw_number_t get_intr_src(void)
 		- NDS32_VECTOR_offINTERRUPT;
 }
=20
-asmlinkage void asm_do_IRQ(struct pt_regs *regs)
+static void ativic32_handle_irq(struct pt_regs *regs)
 {
 	irq_hw_number_t hwirq =3D get_intr_src();
-	handle_domain_irq(root_domain, hwirq, regs);
+	generic_handle_domain_irq(root_domain, hwirq);
+}
+
+/*
+ * TODO: convert nds32 to GENERIC_IRQ_MULTI_HANDLER so that this entry logic
+ * can live in arch code.
+ */
+asmlinkage void asm_do_IRQ(struct pt_regs *regs)
+{
+	struct pt_regs *old_regs;
+
+	irq_enter();
+	old_regs =3D set_irq_regs(regs);
+	ativic32_handle_irq(regs);
+	set_irq_regs(old_regs);
+	irq_exit();
 }
=20
 int __init ativic32_init_irq(struct device_node *node, struct device_node *p=
arent)
diff --git a/drivers/irqchip/irq-atmel-aic.c b/drivers/irqchip/irq-atmel-aic.c
index 2c999dc310c1..4631f6847953 100644
--- a/drivers/irqchip/irq-atmel-aic.c
+++ b/drivers/irqchip/irq-atmel-aic.c
@@ -71,7 +71,7 @@ aic_handle(struct pt_regs *regs)
 	if (!irqstat)
 		irq_reg_writel(gc, 0, AT91_AIC_EOICR);
 	else
-		handle_domain_irq(aic_domain, irqnr, regs);
+		generic_handle_domain_irq(aic_domain, irqnr);
 }
=20
 static int aic_retrigger(struct irq_data *d)
diff --git a/drivers/irqchip/irq-atmel-aic5.c b/drivers/irqchip/irq-atmel-aic=
5.c
index fb4ad2aaa727..145535bd7560 100644
--- a/drivers/irqchip/irq-atmel-aic5.c
+++ b/drivers/irqchip/irq-atmel-aic5.c
@@ -80,7 +80,7 @@ aic5_handle(struct pt_regs *regs)
 	if (!irqstat)
 		irq_reg_writel(bgc, 0, AT91_AIC5_EOICR);
 	else
-		handle_domain_irq(aic5_domain, irqnr, regs);
+		generic_handle_domain_irq(aic5_domain, irqnr);
 }
=20
 static void aic5_mask(struct irq_data *d)
diff --git a/drivers/irqchip/irq-bcm2835.c b/drivers/irqchip/irq-bcm2835.c
index adc1556ed332..e94e2882286c 100644
--- a/drivers/irqchip/irq-bcm2835.c
+++ b/drivers/irqchip/irq-bcm2835.c
@@ -246,7 +246,7 @@ static void __exception_irq_entry bcm2835_handle_irq(
 	u32 hwirq;
=20
 	while ((hwirq =3D get_next_armctrl_hwirq()) !=3D ~0)
-		handle_domain_irq(intc.domain, hwirq, regs);
+		generic_handle_domain_irq(intc.domain, hwirq);
 }
=20
 static void bcm2836_chained_handle_irq(struct irq_desc *desc)
diff --git a/drivers/irqchip/irq-bcm2836.c b/drivers/irqchip/irq-bcm2836.c
index 501facdb4570..51491c3c6fdd 100644
--- a/drivers/irqchip/irq-bcm2836.c
+++ b/drivers/irqchip/irq-bcm2836.c
@@ -143,7 +143,7 @@ __exception_irq_entry bcm2836_arm_irqchip_handle_irq(stru=
ct pt_regs *regs)
 	if (stat) {
 		u32 hwirq =3D ffs(stat) - 1;
=20
-		handle_domain_irq(intc.domain, hwirq, regs);
+		generic_handle_domain_irq(intc.domain, hwirq);
 	}
 }
=20
diff --git a/drivers/irqchip/irq-bcm6345-l1.c b/drivers/irqchip/irq-bcm6345-l=
1.c
index e3483789f4df..fd079215c17f 100644
--- a/drivers/irqchip/irq-bcm6345-l1.c
+++ b/drivers/irqchip/irq-bcm6345-l1.c
@@ -132,16 +132,12 @@ static void bcm6345_l1_irq_handle(struct irq_desc *desc)
 		int base =3D idx * IRQS_PER_WORD;
 		unsigned long pending;
 		irq_hw_number_t hwirq;
-		unsigned int irq;
=20
 		pending =3D __raw_readl(cpu->map_base + reg_status(intc, idx));
 		pending &=3D __raw_readl(cpu->map_base + reg_enable(intc, idx));
=20
 		for_each_set_bit(hwirq, &pending, IRQS_PER_WORD) {
-			irq =3D irq_linear_revmap(intc->domain, base + hwirq);
-			if (irq)
-				do_IRQ(irq);
-			else
+			if (generic_handle_domain_irq(intc->domain, base + hwirq))
 				spurious_interrupt();
 		}
 	}
diff --git a/drivers/irqchip/irq-bcm7038-l1.c b/drivers/irqchip/irq-bcm7038-l=
1.c
index a035c385ca7a..a62b96237b82 100644
--- a/drivers/irqchip/irq-bcm7038-l1.c
+++ b/drivers/irqchip/irq-bcm7038-l1.c
@@ -28,9 +28,6 @@
 #include <linux/irqchip.h>
 #include <linux/irqchip/chained_irq.h>
 #include <linux/syscore_ops.h>
-#ifdef CONFIG_ARM
-#include <asm/smp_plat.h>
-#endif
=20
 #define IRQS_PER_WORD		32
 #define REG_BYTES_PER_IRQ_WORD	(sizeof(u32) * 4)
@@ -127,7 +124,7 @@ static void bcm7038_l1_irq_handle(struct irq_desc *desc)
 	struct irq_chip *chip =3D irq_desc_get_chip(desc);
 	unsigned int idx;
=20
-#ifdef CONFIG_SMP
+#if defined(CONFIG_SMP) && defined(CONFIG_MIPS)
 	cpu =3D intc->cpus[cpu_logical_map(smp_processor_id())];
 #else
 	cpu =3D intc->cpus[0];
@@ -194,6 +191,7 @@ static void bcm7038_l1_mask(struct irq_data *d)
 	raw_spin_unlock_irqrestore(&intc->lock, flags);
 }
=20
+#if defined(CONFIG_MIPS) && defined(CONFIG_SMP)
 static int bcm7038_l1_set_affinity(struct irq_data *d,
 				   const struct cpumask *dest,
 				   bool force)
@@ -220,32 +218,6 @@ static int bcm7038_l1_set_affinity(struct irq_data *d,
=20
 	return 0;
 }
-
-#ifdef CONFIG_SMP
-static void bcm7038_l1_cpu_offline(struct irq_data *d)
-{
-	struct cpumask *mask =3D irq_data_get_affinity_mask(d);
-	int cpu =3D smp_processor_id();
-	cpumask_t new_affinity;
-
-	/* This CPU was not on the affinity mask */
-	if (!cpumask_test_cpu(cpu, mask))
-		return;
-
-	if (cpumask_weight(mask) > 1) {
-		/*
-		 * Multiple CPU affinity, remove this CPU from the affinity
-		 * mask
-		 */
-		cpumask_copy(&new_affinity, mask);
-		cpumask_clear_cpu(cpu, &new_affinity);
-	} else {
-		/* Only CPU, put on the lowest online CPU */
-		cpumask_clear(&new_affinity);
-		cpumask_set_cpu(cpumask_first(cpu_online_mask), &new_affinity);
-	}
-	irq_set_affinity_locked(d, &new_affinity, false);
-}
 #endif
=20
 static int __init bcm7038_l1_init_one(struct device_node *dn,
@@ -328,7 +300,7 @@ static int bcm7038_l1_suspend(void)
 	u32 val;
=20
 	/* Wakeup interrupt should only come from the boot cpu */
-#ifdef CONFIG_SMP
+#if defined(CONFIG_SMP) && defined(CONFIG_MIPS)
 	boot_cpu =3D cpu_logical_map(0);
 #else
 	boot_cpu =3D 0;
@@ -352,7 +324,7 @@ static void bcm7038_l1_resume(void)
 	struct bcm7038_l1_chip *intc;
 	int boot_cpu, word;
=20
-#ifdef CONFIG_SMP
+#if defined(CONFIG_SMP) && defined(CONFIG_MIPS)
 	boot_cpu =3D cpu_logical_map(0);
 #else
 	boot_cpu =3D 0;
@@ -395,9 +367,8 @@ static struct irq_chip bcm7038_l1_irq_chip =3D {
 	.name			=3D "bcm7038-l1",
 	.irq_mask		=3D bcm7038_l1_mask,
 	.irq_unmask		=3D bcm7038_l1_unmask,
+#if defined(CONFIG_SMP) && defined(CONFIG_MIPS)
 	.irq_set_affinity	=3D bcm7038_l1_set_affinity,
-#ifdef CONFIG_SMP
-	.irq_cpu_offline	=3D bcm7038_l1_cpu_offline,
 #endif
 #ifdef CONFIG_PM_SLEEP
 	.irq_set_wake		=3D bcm7038_l1_set_wake,
@@ -416,7 +387,7 @@ static int bcm7038_l1_map(struct irq_domain *d, unsigned =
int virq,
=20
 	irq_set_chip_and_handler(virq, &bcm7038_l1_irq_chip, handle_level_irq);
 	irq_set_chip_data(virq, d->host_data);
-	irqd_set_single_target(irq_desc_get_irq_data(irq_to_desc(virq)));
+	irqd_set_single_target(irq_get_irq_data(virq));
 	return 0;
 }
=20
@@ -484,4 +455,8 @@ static int __init bcm7038_l1_of_init(struct device_node *=
dn,
 	return ret;
 }
=20
-IRQCHIP_DECLARE(bcm7038_l1, "brcm,bcm7038-l1-intc", bcm7038_l1_of_init);
+IRQCHIP_PLATFORM_DRIVER_BEGIN(bcm7038_l1)
+IRQCHIP_MATCH("brcm,bcm7038-l1-intc", bcm7038_l1_of_init)
+IRQCHIP_PLATFORM_DRIVER_END(bcm7038_l1)
+MODULE_DESCRIPTION("Broadcom STB 7038-style L1/L2 interrupt controller");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/irqchip/irq-bcm7120-l2.c b/drivers/irqchip/irq-bcm7120-l=
2.c
index f23d7651ea84..d80e67a6aad2 100644
--- a/drivers/irqchip/irq-bcm7120-l2.c
+++ b/drivers/irqchip/irq-bcm7120-l2.c
@@ -220,6 +220,7 @@ static int __init bcm7120_l2_intc_probe(struct device_nod=
e *dn,
 {
 	unsigned int clr =3D IRQ_NOREQUEST | IRQ_NOPROBE | IRQ_NOAUTOEN;
 	struct bcm7120_l2_intc_data *data;
+	struct platform_device *pdev;
 	struct irq_chip_generic *gc;
 	struct irq_chip_type *ct;
 	int ret =3D 0;
@@ -230,7 +231,13 @@ static int __init bcm7120_l2_intc_probe(struct device_no=
de *dn,
 	if (!data)
 		return -ENOMEM;
=20
-	data->num_parent_irqs =3D of_irq_count(dn);
+	pdev =3D of_find_device_by_node(dn);
+	if (!pdev) {
+		ret =3D -ENODEV;
+		goto out_free_data;
+	}
+
+	data->num_parent_irqs =3D platform_irq_count(pdev);
 	if (data->num_parent_irqs <=3D 0) {
 		pr_err("invalid number of parent interrupts\n");
 		ret =3D -ENOMEM;
@@ -329,6 +336,7 @@ static int __init bcm7120_l2_intc_probe(struct device_nod=
e *dn,
 		if (data->map_base[idx])
 			iounmap(data->map_base[idx]);
 	}
+out_free_data:
 	kfree(data);
 	return ret;
 }
@@ -347,8 +355,9 @@ static int __init bcm7120_l2_intc_probe_3380(struct devic=
e_node *dn,
 				     "BCM3380 L2");
 }
=20
-IRQCHIP_DECLARE(bcm7120_l2_intc, "brcm,bcm7120-l2-intc",
-		bcm7120_l2_intc_probe_7120);
-
-IRQCHIP_DECLARE(bcm3380_l2_intc, "brcm,bcm3380-l2-intc",
-		bcm7120_l2_intc_probe_3380);
+IRQCHIP_PLATFORM_DRIVER_BEGIN(bcm7120_l2)
+IRQCHIP_MATCH("brcm,bcm7120-l2-intc", bcm7120_l2_intc_probe_7120)
+IRQCHIP_MATCH("brcm,bcm3380-l2-intc", bcm7120_l2_intc_probe_3380)
+IRQCHIP_PLATFORM_DRIVER_END(bcm7120_l2)
+MODULE_DESCRIPTION("Broadcom STB 7120-style L2 interrupt controller driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/irqchip/irq-brcmstb-l2.c b/drivers/irqchip/irq-brcmstb-l=
2.c
index 8e0911561f2d..e4efc08ac594 100644
--- a/drivers/irqchip/irq-brcmstb-l2.c
+++ b/drivers/irqchip/irq-brcmstb-l2.c
@@ -275,16 +275,18 @@ static int __init brcmstb_l2_edge_intc_of_init(struct d=
evice_node *np,
 {
 	return brcmstb_l2_intc_of_init(np, parent, &l2_edge_intc_init);
 }
-IRQCHIP_DECLARE(brcmstb_l2_intc, "brcm,l2-intc", brcmstb_l2_edge_intc_of_ini=
t);
-IRQCHIP_DECLARE(brcmstb_hif_spi_l2_intc, "brcm,hif-spi-l2-intc",
-		brcmstb_l2_edge_intc_of_init);
-IRQCHIP_DECLARE(brcmstb_upg_aux_aon_l2_intc, "brcm,upg-aux-aon-l2-intc",
-		brcmstb_l2_edge_intc_of_init);
=20
 static int __init brcmstb_l2_lvl_intc_of_init(struct device_node *np,
 	struct device_node *parent)
 {
 	return brcmstb_l2_intc_of_init(np, parent, &l2_lvl_intc_init);
 }
-IRQCHIP_DECLARE(bcm7271_l2_intc, "brcm,bcm7271-l2-intc",
-	brcmstb_l2_lvl_intc_of_init);
+
+IRQCHIP_PLATFORM_DRIVER_BEGIN(brcmstb_l2)
+IRQCHIP_MATCH("brcm,l2-intc", brcmstb_l2_edge_intc_of_init)
+IRQCHIP_MATCH("brcm,hif-spi-l2-intc", brcmstb_l2_edge_intc_of_init)
+IRQCHIP_MATCH("brcm,upg-aux-aon-l2-intc", brcmstb_l2_edge_intc_of_init)
+IRQCHIP_MATCH("brcm,bcm7271-l2-intc", brcmstb_l2_lvl_intc_of_init)
+IRQCHIP_PLATFORM_DRIVER_END(brcmstb_l2)
+MODULE_DESCRIPTION("Broadcom STB generic L2 interrupt controller");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/irqchip/irq-clps711x.c b/drivers/irqchip/irq-clps711x.c
index d0da29aeedc8..77ebe7e47e0e 100644
--- a/drivers/irqchip/irq-clps711x.c
+++ b/drivers/irqchip/irq-clps711x.c
@@ -77,14 +77,14 @@ static asmlinkage void __exception_irq_entry clps711x_irq=
h(struct pt_regs *regs)
 		irqstat =3D readw_relaxed(clps711x_intc->intmr[0]) &
 			  readw_relaxed(clps711x_intc->intsr[0]);
 		if (irqstat)
-			handle_domain_irq(clps711x_intc->domain,
-					  fls(irqstat) - 1, regs);
+			generic_handle_domain_irq(clps711x_intc->domain,
+						  fls(irqstat) - 1);
=20
 		irqstat =3D readw_relaxed(clps711x_intc->intmr[1]) &
 			  readw_relaxed(clps711x_intc->intsr[1]);
 		if (irqstat)
-			handle_domain_irq(clps711x_intc->domain,
-					  fls(irqstat) - 1 + 16, regs);
+			generic_handle_domain_irq(clps711x_intc->domain,
+						  fls(irqstat) - 1 + 16);
 	} while (irqstat);
 }
=20
diff --git a/drivers/irqchip/irq-csky-apb-intc.c b/drivers/irqchip/irq-csky-a=
pb-intc.c
index ab91afa86755..d36f536506ba 100644
--- a/drivers/irqchip/irq-csky-apb-intc.c
+++ b/drivers/irqchip/irq-csky-apb-intc.c
@@ -138,7 +138,7 @@ static inline bool handle_irq_perbit(struct pt_regs *regs=
, u32 hwirq,
 	if (hwirq =3D=3D 0)
 		return 0;
=20
-	handle_domain_irq(root_domain, irq_base + __fls(hwirq), regs);
+	generic_handle_domain_irq(root_domain, irq_base + __fls(hwirq));
=20
 	return 1;
 }
diff --git a/drivers/irqchip/irq-csky-mpintc.c b/drivers/irqchip/irq-csky-mpi=
ntc.c
index a1534edef7fa..cb403c960ac0 100644
--- a/drivers/irqchip/irq-csky-mpintc.c
+++ b/drivers/irqchip/irq-csky-mpintc.c
@@ -74,8 +74,8 @@ static void csky_mpintc_handler(struct pt_regs *regs)
 {
 	void __iomem *reg_base =3D this_cpu_read(intcl_reg);
=20
-	handle_domain_irq(root_domain,
-		readl_relaxed(reg_base + INTCL_RDYIR), regs);
+	generic_handle_domain_irq(root_domain,
+		readl_relaxed(reg_base + INTCL_RDYIR));
 }
=20
 static void csky_mpintc_enable(struct irq_data *d)
diff --git a/drivers/irqchip/irq-davinci-aintc.c b/drivers/irqchip/irq-davinc=
i-aintc.c
index 810ccc4fe476..123eb7bfc117 100644
--- a/drivers/irqchip/irq-davinci-aintc.c
+++ b/drivers/irqchip/irq-davinci-aintc.c
@@ -73,7 +73,7 @@ davinci_aintc_handle_irq(struct pt_regs *regs)
 	irqnr >>=3D 2;
 	irqnr -=3D 1;
=20
-	handle_domain_irq(davinci_aintc_irq_domain, irqnr, regs);
+	generic_handle_domain_irq(davinci_aintc_irq_domain, irqnr);
 }
=20
 /* ARM Interrupt Controller Initialization */
diff --git a/drivers/irqchip/irq-davinci-cp-intc.c b/drivers/irqchip/irq-davi=
nci-cp-intc.c
index 276da2772e7f..7482c8ed34b2 100644
--- a/drivers/irqchip/irq-davinci-cp-intc.c
+++ b/drivers/irqchip/irq-davinci-cp-intc.c
@@ -135,7 +135,7 @@ davinci_cp_intc_handle_irq(struct pt_regs *regs)
 		return;
 	}
=20
-	handle_domain_irq(davinci_cp_intc_irq_domain, irqnr, regs);
+	generic_handle_domain_irq(davinci_cp_intc_irq_domain, irqnr);
 }
=20
 static int davinci_cp_intc_host_map(struct irq_domain *h, unsigned int virq,
diff --git a/drivers/irqchip/irq-digicolor.c b/drivers/irqchip/irq-digicolor.c
index fc38d2da11b9..3b0d78aac13b 100644
--- a/drivers/irqchip/irq-digicolor.c
+++ b/drivers/irqchip/irq-digicolor.c
@@ -50,7 +50,7 @@ static void __exception_irq_entry digicolor_handle_irq(stru=
ct pt_regs *regs)
 				return;
 		}
=20
-		handle_domain_irq(digicolor_irq_domain, hwirq, regs);
+		generic_handle_domain_irq(digicolor_irq_domain, hwirq);
 	} while (1);
 }
=20
diff --git a/drivers/irqchip/irq-dw-apb-ictl.c b/drivers/irqchip/irq-dw-apb-i=
ctl.c
index a67266e44491..d5c1c750c8d2 100644
--- a/drivers/irqchip/irq-dw-apb-ictl.c
+++ b/drivers/irqchip/irq-dw-apb-ictl.c
@@ -42,7 +42,7 @@ static void __irq_entry dw_apb_ictl_handle_irq(struct pt_re=
gs *regs)
 		while (stat) {
 			u32 hwirq =3D ffs(stat) - 1;
=20
-			handle_domain_irq(d, hwirq, regs);
+			generic_handle_domain_irq(d, hwirq);
 			stat &=3D ~BIT(hwirq);
 		}
 	}
diff --git a/drivers/irqchip/irq-ftintc010.c b/drivers/irqchip/irq-ftintc010.c
index 0bf98425dca5..5cc268880f8e 100644
--- a/drivers/irqchip/irq-ftintc010.c
+++ b/drivers/irqchip/irq-ftintc010.c
@@ -134,7 +134,7 @@ asmlinkage void __exception_irq_entry ft010_irqchip_handl=
e_irq(struct pt_regs *r
=20
 	while ((status =3D readl(FT010_IRQ_STATUS(f->base)))) {
 		irq =3D ffs(status) - 1;
-		handle_domain_irq(f->domain, irq, regs);
+		generic_handle_domain_irq(f->domain, irq);
 	}
 }
=20
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index fd4e9a37fea6..daec3309b014 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -660,7 +660,7 @@ static inline void gic_handle_nmi(u32 irqnr, struct pt_re=
gs *regs)
 	 * PSR.I will be restored when we ERET to the
 	 * interrupted context.
 	 */
-	err =3D handle_domain_nmi(gic_data.domain, irqnr, regs);
+	err =3D generic_handle_domain_nmi(gic_data.domain, irqnr);
 	if (err)
 		gic_deactivate_unhandled(irqnr);
=20
@@ -728,7 +728,7 @@ static asmlinkage void __exception_irq_entry gic_handle_i=
rq(struct pt_regs *regs
 	else
 		isb();
=20
-	if (handle_domain_irq(gic_data.domain, irqnr, regs)) {
+	if (generic_handle_domain_irq(gic_data.domain, irqnr)) {
 		WARN_ONCE(true, "Unexpected interrupt received!\n");
 		gic_deactivate_unhandled(irqnr);
 	}
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 5f22c9d65e57..b8bb46c65a97 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -369,7 +369,7 @@ static void __exception_irq_entry gic_handle_irq(struct p=
t_regs *regs)
 			this_cpu_write(sgi_intid, irqstat);
 		}
=20
-		handle_domain_irq(gic->domain, irqnr, regs);
+		generic_handle_domain_irq(gic->domain, irqnr);
 	} while (1);
 }
=20
diff --git a/drivers/irqchip/irq-hip04.c b/drivers/irqchip/irq-hip04.c
index 058ebaebe2c4..46161f6ff289 100644
--- a/drivers/irqchip/irq-hip04.c
+++ b/drivers/irqchip/irq-hip04.c
@@ -206,7 +206,7 @@ static void __exception_irq_entry hip04_handle_irq(struct=
 pt_regs *regs)
 		irqnr =3D irqstat & GICC_IAR_INT_ID_MASK;
=20
 		if (irqnr <=3D HIP04_MAX_IRQS)
-			handle_domain_irq(hip04_data.domain, irqnr, regs);
+			generic_handle_domain_irq(hip04_data.domain, irqnr);
 	} while (irqnr > HIP04_MAX_IRQS);
 }
=20
diff --git a/drivers/irqchip/irq-ixp4xx.c b/drivers/irqchip/irq-ixp4xx.c
index 37e0749215c7..fb68f8c59fbb 100644
--- a/drivers/irqchip/irq-ixp4xx.c
+++ b/drivers/irqchip/irq-ixp4xx.c
@@ -114,7 +114,7 @@ asmlinkage void __exception_irq_entry ixp4xx_handle_irq(s=
truct pt_regs *regs)
=20
 	status =3D __raw_readl(ixi->irqbase + IXP4XX_ICIP);
 	for_each_set_bit(i, &status, 32)
-		handle_domain_irq(ixi->domain, i, regs);
+		generic_handle_domain_irq(ixi->domain, i);
=20
 	/*
 	 * IXP465/IXP435 has an upper IRQ status register
@@ -122,7 +122,7 @@ asmlinkage void __exception_irq_entry ixp4xx_handle_irq(s=
truct pt_regs *regs)
 	if (ixi->is_356) {
 		status =3D __raw_readl(ixi->irqbase + IXP4XX_ICIP2);
 		for_each_set_bit(i, &status, 32)
-			handle_domain_irq(ixi->domain, i + 32, regs);
+			generic_handle_domain_irq(ixi->domain, i + 32);
 	}
 }
=20
diff --git a/drivers/irqchip/irq-lpc32xx.c b/drivers/irqchip/irq-lpc32xx.c
index 5e6f6e25f2ae..a29357f39450 100644
--- a/drivers/irqchip/irq-lpc32xx.c
+++ b/drivers/irqchip/irq-lpc32xx.c
@@ -126,7 +126,7 @@ static void __exception_irq_entry lpc32xx_handle_irq(stru=
ct pt_regs *regs)
 	while (hwirq) {
 		irq =3D __ffs(hwirq);
 		hwirq &=3D ~BIT(irq);
-		handle_domain_irq(lpc32xx_mic_irqc->domain, irq, regs);
+		generic_handle_domain_irq(lpc32xx_mic_irqc->domain, irq);
 	}
 }
=20
diff --git a/drivers/irqchip/irq-mchp-eic.c b/drivers/irqchip/irq-mchp-eic.c
new file mode 100644
index 000000000000..c726a19837d2
--- /dev/null
+++ b/drivers/irqchip/irq-mchp-eic.c
@@ -0,0 +1,280 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Microchip External Interrupt Controller driver
+ *
+ * Copyright (C) 2021 Microchip Technology Inc. and its subsidiaries
+ *
+ * Author: Claudiu Beznea <claudiu.beznea@microchip.com>
+ */
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/irqchip.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/syscore_ops.h>
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+#define MCHP_EIC_GFCS			(0x0)
+#define MCHP_EIC_SCFG(x)		(0x4 + (x) * 0x4)
+#define MCHP_EIC_SCFG_EN		BIT(16)
+#define MCHP_EIC_SCFG_LVL		BIT(9)
+#define MCHP_EIC_SCFG_POL		BIT(8)
+
+#define MCHP_EIC_NIRQ			(2)
+
+/*
+ * struct mchp_eic - EIC private data structure
+ * @base: base address
+ * @clk: peripheral clock
+ * @domain: irq domain
+ * @irqs: irqs b/w eic and gic
+ * @scfg: backup for scfg registers (necessary for backup and self-refresh m=
ode)
+ * @wakeup_source: wakeup source mask
+ */
+struct mchp_eic {
+	void __iomem *base;
+	struct clk *clk;
+	struct irq_domain *domain;
+	u32 irqs[MCHP_EIC_NIRQ];
+	u32 scfg[MCHP_EIC_NIRQ];
+	u32 wakeup_source;
+};
+
+static struct mchp_eic *eic;
+
+static void mchp_eic_irq_mask(struct irq_data *d)
+{
+	unsigned int tmp;
+
+	tmp =3D readl_relaxed(eic->base + MCHP_EIC_SCFG(d->hwirq));
+	tmp &=3D ~MCHP_EIC_SCFG_EN;
+	writel_relaxed(tmp, eic->base + MCHP_EIC_SCFG(d->hwirq));
+
+	irq_chip_mask_parent(d);
+}
+
+static void mchp_eic_irq_unmask(struct irq_data *d)
+{
+	unsigned int tmp;
+
+	tmp =3D readl_relaxed(eic->base + MCHP_EIC_SCFG(d->hwirq));
+	tmp |=3D MCHP_EIC_SCFG_EN;
+	writel_relaxed(tmp, eic->base + MCHP_EIC_SCFG(d->hwirq));
+
+	irq_chip_unmask_parent(d);
+}
+
+static int mchp_eic_irq_set_type(struct irq_data *d, unsigned int type)
+{
+	unsigned int parent_irq_type;
+	unsigned int tmp;
+
+	tmp =3D readl_relaxed(eic->base + MCHP_EIC_SCFG(d->hwirq));
+	tmp &=3D ~(MCHP_EIC_SCFG_POL | MCHP_EIC_SCFG_LVL);
+	switch (type) {
+	case IRQ_TYPE_LEVEL_HIGH:
+		tmp |=3D MCHP_EIC_SCFG_POL | MCHP_EIC_SCFG_LVL;
+		parent_irq_type =3D IRQ_TYPE_LEVEL_HIGH;
+		break;
+	case IRQ_TYPE_LEVEL_LOW:
+		tmp |=3D MCHP_EIC_SCFG_LVL;
+		parent_irq_type =3D IRQ_TYPE_LEVEL_HIGH;
+		break;
+	case IRQ_TYPE_EDGE_RISING:
+		parent_irq_type =3D IRQ_TYPE_EDGE_RISING;
+		break;
+	case IRQ_TYPE_EDGE_FALLING:
+		tmp |=3D MCHP_EIC_SCFG_POL;
+		parent_irq_type =3D IRQ_TYPE_EDGE_RISING;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	writel_relaxed(tmp, eic->base + MCHP_EIC_SCFG(d->hwirq));
+
+	return irq_chip_set_type_parent(d, parent_irq_type);
+}
+
+static int mchp_eic_irq_set_wake(struct irq_data *d, unsigned int on)
+{
+	irq_set_irq_wake(eic->irqs[d->hwirq], on);
+	if (on)
+		eic->wakeup_source |=3D BIT(d->hwirq);
+	else
+		eic->wakeup_source &=3D ~BIT(d->hwirq);
+
+	return 0;
+}
+
+static int mchp_eic_irq_suspend(void)
+{
+	unsigned int hwirq;
+
+	for (hwirq =3D 0; hwirq < MCHP_EIC_NIRQ; hwirq++)
+		eic->scfg[hwirq] =3D readl_relaxed(eic->base +
+						 MCHP_EIC_SCFG(hwirq));
+
+	if (!eic->wakeup_source)
+		clk_disable_unprepare(eic->clk);
+
+	return 0;
+}
+
+static void mchp_eic_irq_resume(void)
+{
+	unsigned int hwirq;
+
+	if (!eic->wakeup_source)
+		clk_prepare_enable(eic->clk);
+
+	for (hwirq =3D 0; hwirq < MCHP_EIC_NIRQ; hwirq++)
+		writel_relaxed(eic->scfg[hwirq], eic->base +
+			       MCHP_EIC_SCFG(hwirq));
+}
+
+static struct syscore_ops mchp_eic_syscore_ops =3D {
+	.suspend =3D mchp_eic_irq_suspend,
+	.resume =3D mchp_eic_irq_resume,
+};
+
+static struct irq_chip mchp_eic_chip =3D {
+	.name		=3D "eic",
+	.flags		=3D IRQCHIP_MASK_ON_SUSPEND | IRQCHIP_SET_TYPE_MASKED,
+	.irq_mask	=3D mchp_eic_irq_mask,
+	.irq_unmask	=3D mchp_eic_irq_unmask,
+	.irq_set_type	=3D mchp_eic_irq_set_type,
+	.irq_ack	=3D irq_chip_ack_parent,
+	.irq_eoi	=3D irq_chip_eoi_parent,
+	.irq_retrigger	=3D irq_chip_retrigger_hierarchy,
+	.irq_set_wake	=3D mchp_eic_irq_set_wake,
+};
+
+static int mchp_eic_domain_alloc(struct irq_domain *domain, unsigned int vir=
q,
+				 unsigned int nr_irqs, void *data)
+{
+	struct irq_fwspec *fwspec =3D data;
+	struct irq_fwspec parent_fwspec;
+	irq_hw_number_t hwirq;
+	unsigned int type;
+	int ret;
+
+	if (WARN_ON(nr_irqs !=3D 1))
+		return -EINVAL;
+
+	ret =3D irq_domain_translate_twocell(domain, fwspec, &hwirq, &type);
+	if (ret || hwirq >=3D MCHP_EIC_NIRQ)
+		return ret;
+
+	switch (type) {
+	case IRQ_TYPE_EDGE_RISING:
+	case IRQ_TYPE_LEVEL_HIGH:
+		break;
+	case IRQ_TYPE_EDGE_FALLING:
+		type =3D IRQ_TYPE_EDGE_RISING;
+		break;
+	case IRQ_TYPE_LEVEL_LOW:
+		type =3D IRQ_TYPE_LEVEL_HIGH;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	irq_domain_set_hwirq_and_chip(domain, virq, hwirq, &mchp_eic_chip, eic);
+
+	parent_fwspec.fwnode =3D domain->parent->fwnode;
+	parent_fwspec.param_count =3D 3;
+	parent_fwspec.param[0] =3D GIC_SPI;
+	parent_fwspec.param[1] =3D eic->irqs[hwirq];
+	parent_fwspec.param[2] =3D type;
+
+	return irq_domain_alloc_irqs_parent(domain, virq, 1, &parent_fwspec);
+}
+
+static const struct irq_domain_ops mchp_eic_domain_ops =3D {
+	.translate	=3D irq_domain_translate_twocell,
+	.alloc		=3D mchp_eic_domain_alloc,
+	.free		=3D irq_domain_free_irqs_common,
+};
+
+static int mchp_eic_init(struct device_node *node, struct device_node *paren=
t)
+{
+	struct irq_domain *parent_domain =3D NULL;
+	int ret, i;
+
+	eic =3D kzalloc(sizeof(*eic), GFP_KERNEL);
+	if (!eic)
+		return -ENOMEM;
+
+	eic->base =3D of_iomap(node, 0);
+	if (!eic->base) {
+		ret =3D -ENOMEM;
+		goto free;
+	}
+
+	parent_domain =3D irq_find_host(parent);
+	if (!parent_domain) {
+		ret =3D -ENODEV;
+		goto unmap;
+	}
+
+	eic->clk =3D of_clk_get_by_name(node, "pclk");
+	if (IS_ERR(eic->clk)) {
+		ret =3D PTR_ERR(eic->clk);
+		goto unmap;
+	}
+
+	ret =3D clk_prepare_enable(eic->clk);
+	if (ret)
+		goto unmap;
+
+	for (i =3D 0; i < MCHP_EIC_NIRQ; i++) {
+		struct of_phandle_args irq;
+
+		/* Disable it, if any. */
+		writel_relaxed(0UL, eic->base + MCHP_EIC_SCFG(i));
+
+		ret =3D of_irq_parse_one(node, i, &irq);
+		if (ret)
+			goto clk_unprepare;
+
+		if (WARN_ON(irq.args_count !=3D 3)) {
+			ret =3D -EINVAL;
+			goto clk_unprepare;
+		}
+
+		eic->irqs[i] =3D irq.args[1];
+	}
+
+	eic->domain =3D irq_domain_add_hierarchy(parent_domain, 0, MCHP_EIC_NIRQ,
+					       node, &mchp_eic_domain_ops, eic);
+	if (!eic->domain) {
+		pr_err("%pOF: Failed to add domain\n", node);
+		ret =3D -ENODEV;
+		goto clk_unprepare;
+	}
+
+	register_syscore_ops(&mchp_eic_syscore_ops);
+
+	pr_info("%pOF: EIC registered, nr_irqs %u\n", node, MCHP_EIC_NIRQ);
+
+	return 0;
+
+clk_unprepare:
+	clk_disable_unprepare(eic->clk);
+unmap:
+	iounmap(eic->base);
+free:
+	kfree(eic);
+	return ret;
+}
+
+IRQCHIP_PLATFORM_DRIVER_BEGIN(mchp_eic)
+IRQCHIP_MATCH("microchip,sama7g5-eic", mchp_eic_init)
+IRQCHIP_PLATFORM_DRIVER_END(mchp_eic)
+
+MODULE_DESCRIPTION("Microchip External Interrupt Controller");
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Claudiu Beznea <claudiu.beznea@microchip.com>");
diff --git a/drivers/irqchip/irq-meson-gpio.c b/drivers/irqchip/irq-meson-gpi=
o.c
index e50676ce2ec8..d90ff0b92480 100644
--- a/drivers/irqchip/irq-meson-gpio.c
+++ b/drivers/irqchip/irq-meson-gpio.c
@@ -436,8 +436,7 @@ static const struct irq_domain_ops meson_gpio_irq_domain_=
ops =3D {
 	.translate	=3D meson_gpio_irq_domain_translate,
 };
=20
-static int __init meson_gpio_irq_parse_dt(struct device_node *node,
-					  struct meson_gpio_irq_controller *ctl)
+static int meson_gpio_irq_parse_dt(struct device_node *node, struct meson_gp=
io_irq_controller *ctl)
 {
 	const struct of_device_id *match;
 	int ret;
@@ -463,8 +462,7 @@ static int __init meson_gpio_irq_parse_dt(struct device_n=
ode *node,
 	return 0;
 }
=20
-static int __init meson_gpio_irq_of_init(struct device_node *node,
-					 struct device_node *parent)
+static int meson_gpio_irq_of_init(struct device_node *node, struct device_no=
de *parent)
 {
 	struct irq_domain *domain, *parent_domain;
 	struct meson_gpio_irq_controller *ctl;
@@ -521,5 +519,10 @@ static int __init meson_gpio_irq_of_init(struct device_n=
ode *node,
 	return ret;
 }
=20
-IRQCHIP_DECLARE(meson_gpio_intc, "amlogic,meson-gpio-intc",
-		meson_gpio_irq_of_init);
+IRQCHIP_PLATFORM_DRIVER_BEGIN(meson_gpio_intc)
+IRQCHIP_MATCH("amlogic,meson-gpio-intc", meson_gpio_irq_of_init)
+IRQCHIP_PLATFORM_DRIVER_END(meson_gpio_intc)
+
+MODULE_AUTHOR("Jerome Brunet <jbrunet@baylibre.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:meson-gpio-intc");
diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index 54c7092cc61d..d02b05a067d9 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -381,24 +381,35 @@ static void gic_unmask_local_irq_all_vpes(struct irq_da=
ta *d)
 	spin_unlock_irqrestore(&gic_lock, flags);
 }
=20
-static void gic_all_vpes_irq_cpu_online(struct irq_data *d)
+static void gic_all_vpes_irq_cpu_online(void)
 {
-	struct gic_all_vpes_chip_data *cd;
-	unsigned int intr;
+	static const unsigned int local_intrs[] =3D {
+		GIC_LOCAL_INT_TIMER,
+		GIC_LOCAL_INT_PERFCTR,
+		GIC_LOCAL_INT_FDC,
+	};
+	unsigned long flags;
+	int i;
=20
-	intr =3D GIC_HWIRQ_TO_LOCAL(d->hwirq);
-	cd =3D irq_data_get_irq_chip_data(d);
+	spin_lock_irqsave(&gic_lock, flags);
=20
-	write_gic_vl_map(mips_gic_vx_map_reg(intr), cd->map);
-	if (cd->mask)
-		write_gic_vl_smask(BIT(intr));
+	for (i =3D 0; i < ARRAY_SIZE(local_intrs); i++) {
+		unsigned int intr =3D local_intrs[i];
+		struct gic_all_vpes_chip_data *cd;
+
+		cd =3D &gic_all_vpes_chip_data[intr];
+		write_gic_vl_map(mips_gic_vx_map_reg(intr), cd->map);
+		if (cd->mask)
+			write_gic_vl_smask(BIT(intr));
+	}
+
+	spin_unlock_irqrestore(&gic_lock, flags);
 }
=20
 static struct irq_chip gic_all_vpes_local_irq_controller =3D {
 	.name			=3D "MIPS GIC Local",
 	.irq_mask		=3D gic_mask_local_irq_all_vpes,
 	.irq_unmask		=3D gic_unmask_local_irq_all_vpes,
-	.irq_cpu_online		=3D gic_all_vpes_irq_cpu_online,
 };
=20
 static void __gic_irq_dispatch(void)
@@ -477,6 +488,10 @@ static int gic_irq_domain_map(struct irq_domain *d, unsi=
gned int virq,
 	intr =3D GIC_HWIRQ_TO_LOCAL(hwirq);
 	map =3D GIC_MAP_PIN_MAP_TO_PIN | gic_cpu_pin;
=20
+	/*
+	 * If adding support for more per-cpu interrupts, keep the the
+	 * array in gic_all_vpes_irq_cpu_online() in sync.
+	 */
 	switch (intr) {
 	case GIC_LOCAL_INT_TIMER:
 		/* CONFIG_MIPS_CMP workaround (see __gic_init) */
@@ -663,8 +678,8 @@ static int gic_cpu_startup(unsigned int cpu)
 	/* Clear all local IRQ masks (ie. disable all local interrupts) */
 	write_gic_vl_rmask(~0);
=20
-	/* Invoke irq_cpu_online callbacks to enable desired interrupts */
-	irq_cpu_online();
+	/* Enable desired interrupts */
+	gic_all_vpes_irq_cpu_online();
=20
 	return 0;
 }
diff --git a/drivers/irqchip/irq-mmp.c b/drivers/irqchip/irq-mmp.c
index 4a74ac7b7c42..83455ca72439 100644
--- a/drivers/irqchip/irq-mmp.c
+++ b/drivers/irqchip/irq-mmp.c
@@ -230,7 +230,7 @@ static void __exception_irq_entry mmp_handle_irq(struct p=
t_regs *regs)
 	if (!(hwirq & SEL_INT_PENDING))
 		return;
 	hwirq &=3D SEL_INT_NUM_MASK;
-	handle_domain_irq(icu_data[0].domain, hwirq, regs);
+	generic_handle_domain_irq(icu_data[0].domain, hwirq);
 }
=20
 static void __exception_irq_entry mmp2_handle_irq(struct pt_regs *regs)
@@ -241,7 +241,7 @@ static void __exception_irq_entry mmp2_handle_irq(struct =
pt_regs *regs)
 	if (!(hwirq & SEL_INT_PENDING))
 		return;
 	hwirq &=3D SEL_INT_NUM_MASK;
-	handle_domain_irq(icu_data[0].domain, hwirq, regs);
+	generic_handle_domain_irq(icu_data[0].domain, hwirq);
 }
=20
 /* MMP (ARMv5) */
diff --git a/drivers/irqchip/irq-mvebu-icu.c b/drivers/irqchip/irq-mvebu-icu.c
index 090bc3f4f7d8..3e7297fc5948 100644
--- a/drivers/irqchip/irq-mvebu-icu.c
+++ b/drivers/irqchip/irq-mvebu-icu.c
@@ -347,7 +347,6 @@ builtin_platform_driver(mvebu_icu_subset_driver);
 static int mvebu_icu_probe(struct platform_device *pdev)
 {
 	struct mvebu_icu *icu;
-	struct resource *res;
 	int i;
=20
 	icu =3D devm_kzalloc(&pdev->dev, sizeof(struct mvebu_icu),
@@ -357,8 +356,7 @@ static int mvebu_icu_probe(struct platform_device *pdev)
=20
 	icu->dev =3D &pdev->dev;
=20
-	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	icu->base =3D devm_ioremap_resource(&pdev->dev, res);
+	icu->base =3D devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(icu->base))
 		return PTR_ERR(icu->base);
=20
diff --git a/drivers/irqchip/irq-mvebu-pic.c b/drivers/irqchip/irq-mvebu-pic.c
index dc1cee4b0fe1..870f9866b8da 100644
--- a/drivers/irqchip/irq-mvebu-pic.c
+++ b/drivers/irqchip/irq-mvebu-pic.c
@@ -121,14 +121,12 @@ static int mvebu_pic_probe(struct platform_device *pdev)
 	struct device_node *node =3D pdev->dev.of_node;
 	struct mvebu_pic *pic;
 	struct irq_chip *irq_chip;
-	struct resource *res;
=20
 	pic =3D devm_kzalloc(&pdev->dev, sizeof(struct mvebu_pic), GFP_KERNEL);
 	if (!pic)
 		return -ENOMEM;
=20
-	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	pic->base =3D devm_ioremap_resource(&pdev->dev, res);
+	pic->base =3D devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pic->base))
 		return PTR_ERR(pic->base);
=20
diff --git a/drivers/irqchip/irq-mxs.c b/drivers/irqchip/irq-mxs.c
index d1f5740cd575..55cb6b5a686e 100644
--- a/drivers/irqchip/irq-mxs.c
+++ b/drivers/irqchip/irq-mxs.c
@@ -136,7 +136,7 @@ asmlinkage void __exception_irq_entry icoll_handle_irq(st=
ruct pt_regs *regs)
=20
 	irqnr =3D __raw_readl(icoll_priv.stat);
 	__raw_writel(irqnr, icoll_priv.vector);
-	handle_domain_irq(icoll_domain, irqnr, regs);
+	generic_handle_domain_irq(icoll_domain, irqnr);
 }
=20
 static int icoll_irq_domain_map(struct irq_domain *d, unsigned int virq,
diff --git a/drivers/irqchip/irq-nvic.c b/drivers/irqchip/irq-nvic.c
index b31c4cff4d3a..63bac3f78863 100644
--- a/drivers/irqchip/irq-nvic.c
+++ b/drivers/irqchip/irq-nvic.c
@@ -37,10 +37,25 @@
=20
 static struct irq_domain *nvic_irq_domain;
=20
+static void __nvic_handle_irq(irq_hw_number_t hwirq)
+{
+	generic_handle_domain_irq(nvic_irq_domain, hwirq);
+}
+
+/*
+ * TODO: restructure the ARMv7M entry logic so that this entry logic can live
+ * in arch code.
+ */
 asmlinkage void __exception_irq_entry
 nvic_handle_irq(irq_hw_number_t hwirq, struct pt_regs *regs)
 {
-	handle_domain_irq(nvic_irq_domain, hwirq, regs);
+	struct pt_regs *old_regs;
+
+	irq_enter();
+	old_regs =3D set_irq_regs(regs);
+	__nvic_handle_irq(hwirq);
+	set_irq_regs(old_regs);
+	irq_exit();
 }
=20
 static int nvic_irq_domain_alloc(struct irq_domain *domain, unsigned int vir=
q,
diff --git a/drivers/irqchip/irq-omap-intc.c b/drivers/irqchip/irq-omap-intc.c
index d360a6eddd6d..dc82162ba763 100644
--- a/drivers/irqchip/irq-omap-intc.c
+++ b/drivers/irqchip/irq-omap-intc.c
@@ -357,7 +357,7 @@ omap_intc_handle_irq(struct pt_regs *regs)
 	}
=20
 	irqnr &=3D ACTIVEIRQ_MASK;
-	handle_domain_irq(domain, irqnr, regs);
+	generic_handle_domain_irq(domain, irqnr);
 }
=20
 static int __init intc_of_init(struct device_node *node,
diff --git a/drivers/irqchip/irq-or1k-pic.c b/drivers/irqchip/irq-or1k-pic.c
index 03d2366118dd..49b47e787644 100644
--- a/drivers/irqchip/irq-or1k-pic.c
+++ b/drivers/irqchip/irq-or1k-pic.c
@@ -116,7 +116,7 @@ static void or1k_pic_handle_irq(struct pt_regs *regs)
 	int irq =3D -1;
=20
 	while ((irq =3D pic_get_irq(irq + 1)) !=3D NO_IRQ)
-		handle_domain_irq(root_domain, irq, regs);
+		generic_handle_domain_irq(root_domain, irq);
 }
=20
 static int or1k_map(struct irq_domain *d, unsigned int irq, irq_hw_number_t =
hw)
diff --git a/drivers/irqchip/irq-orion.c b/drivers/irqchip/irq-orion.c
index b6868f7b805a..17c2c7a07f10 100644
--- a/drivers/irqchip/irq-orion.c
+++ b/drivers/irqchip/irq-orion.c
@@ -42,8 +42,8 @@ __exception_irq_entry orion_handle_irq(struct pt_regs *regs)
 			gc->mask_cache;
 		while (stat) {
 			u32 hwirq =3D __fls(stat);
-			handle_domain_irq(orion_irq_domain,
-					  gc->irq_base + hwirq, regs);
+			generic_handle_domain_irq(orion_irq_domain,
+						  gc->irq_base + hwirq);
 			stat &=3D ~(1 << hwirq);
 		}
 	}
diff --git a/drivers/irqchip/irq-rda-intc.c b/drivers/irqchip/irq-rda-intc.c
index 960168303b73..9f0144a73777 100644
--- a/drivers/irqchip/irq-rda-intc.c
+++ b/drivers/irqchip/irq-rda-intc.c
@@ -53,7 +53,7 @@ static void __exception_irq_entry rda_handle_irq(struct pt_=
regs *regs)
=20
 	while (stat) {
 		hwirq =3D __fls(stat);
-		handle_domain_irq(rda_irq_domain, hwirq, regs);
+		generic_handle_domain_irq(rda_irq_domain, hwirq);
 		stat &=3D ~BIT(hwirq);
 	}
 }
diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-int=
c.c
index 8017f6d32d52..b65bd8878d4f 100644
--- a/drivers/irqchip/irq-riscv-intc.c
+++ b/drivers/irqchip/irq-riscv-intc.c
@@ -37,7 +37,7 @@ static asmlinkage void riscv_intc_irq(struct pt_regs *regs)
 		break;
 #endif
 	default:
-		handle_domain_irq(intc_domain, cause, regs);
+		generic_handle_domain_irq(intc_domain, cause);
 		break;
 	}
 }
diff --git a/drivers/irqchip/irq-sa11x0.c b/drivers/irqchip/irq-sa11x0.c
index dbccc7dafbf8..31c202a1ae62 100644
--- a/drivers/irqchip/irq-sa11x0.c
+++ b/drivers/irqchip/irq-sa11x0.c
@@ -140,8 +140,8 @@ sa1100_handle_irq(struct pt_regs *regs)
 		if (mask =3D=3D 0)
 			break;
=20
-		handle_domain_irq(sa1100_normal_irqdomain,
-				ffs(mask) - 1, regs);
+		generic_handle_domain_irq(sa1100_normal_irqdomain,
+					  ffs(mask) - 1);
 	} while (1);
 }
=20
diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-ext=
i.c
index 33c76710f845..b7cb2da71888 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -850,7 +850,6 @@ static int stm32_exti_probe(struct platform_device *pdev)
 	struct irq_domain *parent_domain, *domain;
 	struct stm32_exti_host_data *host_data;
 	const struct stm32_exti_drv_data *drv_data;
-	struct resource *res;
=20
 	host_data =3D devm_kzalloc(dev, sizeof(*host_data), GFP_KERNEL);
 	if (!host_data)
@@ -888,8 +887,7 @@ static int stm32_exti_probe(struct platform_device *pdev)
 	if (!host_data->chips_data)
 		return -ENOMEM;
=20
-	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	host_data->base =3D devm_ioremap_resource(dev, res);
+	host_data->base =3D devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(host_data->base))
 		return PTR_ERR(host_data->base);
=20
diff --git a/drivers/irqchip/irq-sun4i.c b/drivers/irqchip/irq-sun4i.c
index 8a315d6a3399..dd506ebfdacb 100644
--- a/drivers/irqchip/irq-sun4i.c
+++ b/drivers/irqchip/irq-sun4i.c
@@ -195,7 +195,7 @@ static void __exception_irq_entry sun4i_handle_irq(struct=
 pt_regs *regs)
 		return;
=20
 	do {
-		handle_domain_irq(irq_ic_data->irq_domain, hwirq, regs);
+		generic_handle_domain_irq(irq_ic_data->irq_domain, hwirq);
 		hwirq =3D readl(irq_ic_data->irq_base +
 				SUN4I_IRQ_VECTOR_REG) >> 2;
 	} while (hwirq !=3D 0);
diff --git a/drivers/irqchip/irq-ti-sci-inta.c b/drivers/irqchip/irq-ti-sci-i=
nta.c
index 97f454ec376b..8eba08db33b2 100644
--- a/drivers/irqchip/irq-ti-sci-inta.c
+++ b/drivers/irqchip/irq-ti-sci-inta.c
@@ -650,7 +650,6 @@ static int ti_sci_inta_irq_domain_probe(struct platform_d=
evice *pdev)
 	struct device_node *parent_node, *node;
 	struct ti_sci_inta_irq_domain *inta;
 	struct device *dev =3D &pdev->dev;
-	struct resource *res;
 	int ret;
=20
 	node =3D dev_of_node(dev);
@@ -694,8 +693,7 @@ static int ti_sci_inta_irq_domain_probe(struct platform_d=
evice *pdev)
 		return PTR_ERR(inta->global_event);
 	}
=20
-	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	inta->base =3D devm_ioremap_resource(dev, res);
+	inta->base =3D devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(inta->base))
 		return PTR_ERR(inta->base);
=20
diff --git a/drivers/irqchip/irq-ts4800.c b/drivers/irqchip/irq-ts4800.c
index 34337a61b1ef..f032db23b30f 100644
--- a/drivers/irqchip/irq-ts4800.c
+++ b/drivers/irqchip/irq-ts4800.c
@@ -93,15 +93,13 @@ static int ts4800_ic_probe(struct platform_device *pdev)
 	struct device_node *node =3D pdev->dev.of_node;
 	struct ts4800_irq_data *data;
 	struct irq_chip *irq_chip;
-	struct resource *res;
 	int parent_irq;
=20
 	data =3D devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
=20
-	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	data->base =3D devm_ioremap_resource(&pdev->dev, res);
+	data->base =3D devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(data->base))
 		return PTR_ERR(data->base);
=20
diff --git a/drivers/irqchip/irq-versatile-fpga.c b/drivers/irqchip/irq-versa=
tile-fpga.c
index 75be350cf82f..f2757b6aecc8 100644
--- a/drivers/irqchip/irq-versatile-fpga.c
+++ b/drivers/irqchip/irq-versatile-fpga.c
@@ -105,7 +105,7 @@ static int handle_one_fpga(struct fpga_irq_data *f, struc=
t pt_regs *regs)
=20
 	while ((status  =3D readl(f->base + IRQ_STATUS))) {
 		irq =3D ffs(status) - 1;
-		handle_domain_irq(f->domain, irq, regs);
+		generic_handle_domain_irq(f->domain, irq);
 		handled =3D 1;
 	}
=20
diff --git a/drivers/irqchip/irq-vic.c b/drivers/irqchip/irq-vic.c
index 1e1f2d115257..9e3d5561e04e 100644
--- a/drivers/irqchip/irq-vic.c
+++ b/drivers/irqchip/irq-vic.c
@@ -208,7 +208,7 @@ static int handle_one_vic(struct vic_device *vic, struct =
pt_regs *regs)
=20
 	while ((stat =3D readl_relaxed(vic->base + VIC_IRQ_STATUS))) {
 		irq =3D ffs(stat) - 1;
-		handle_domain_irq(vic->domain, irq, regs);
+		generic_handle_domain_irq(vic->domain, irq);
 		handled =3D 1;
 	}
=20
diff --git a/drivers/irqchip/irq-vt8500.c b/drivers/irqchip/irq-vt8500.c
index 5bce936af5d9..e17dd3a8c2d5 100644
--- a/drivers/irqchip/irq-vt8500.c
+++ b/drivers/irqchip/irq-vt8500.c
@@ -183,7 +183,7 @@ static void __exception_irq_entry vt8500_handle_irq(struc=
t pt_regs *regs)
 				continue;
 		}
=20
-		handle_domain_irq(intc[i].domain, irqnr, regs);
+		generic_handle_domain_irq(intc[i].domain, irqnr);
 	}
 }
=20
diff --git a/drivers/irqchip/irq-wpcm450-aic.c b/drivers/irqchip/irq-wpcm450-=
aic.c
index f3ac392d5bc8..0dcbeb1a05a1 100644
--- a/drivers/irqchip/irq-wpcm450-aic.c
+++ b/drivers/irqchip/irq-wpcm450-aic.c
@@ -69,7 +69,7 @@ static void __exception_irq_entry wpcm450_aic_handle_irq(st=
ruct pt_regs *regs)
 	/* Read IPER to signal that nIRQ can be de-asserted */
 	hwirq =3D readl(aic->regs + AIC_IPER) / 4;
=20
-	handle_domain_irq(aic->domain, hwirq, regs);
+	generic_handle_domain_irq(aic->domain, hwirq);
 }
=20
 static void wpcm450_aic_eoi(struct irq_data *d)
diff --git a/drivers/irqchip/irq-zevio.c b/drivers/irqchip/irq-zevio.c
index 84163f1ebfcf..7a72620fc478 100644
--- a/drivers/irqchip/irq-zevio.c
+++ b/drivers/irqchip/irq-zevio.c
@@ -50,7 +50,7 @@ static void __exception_irq_entry zevio_handle_irq(struct p=
t_regs *regs)
=20
 	while (readl(zevio_irq_io + IO_STATUS)) {
 		irqnr =3D readl(zevio_irq_io + IO_CURRENT);
-		handle_domain_irq(zevio_irq_domain, irqnr, regs);
+		generic_handle_domain_irq(zevio_irq_domain, irqnr);
 	}
 }
=20
diff --git a/include/linux/irq.h b/include/linux/irq.h
index c8293c817646..848e1e12c5c6 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -524,9 +524,10 @@ struct irq_chip {
 	void		(*irq_bus_lock)(struct irq_data *data);
 	void		(*irq_bus_sync_unlock)(struct irq_data *data);
=20
+#ifdef CONFIG_DEPRECATED_IRQ_CPU_ONOFFLINE
 	void		(*irq_cpu_online)(struct irq_data *data);
 	void		(*irq_cpu_offline)(struct irq_data *data);
-
+#endif
 	void		(*irq_suspend)(struct irq_data *data);
 	void		(*irq_resume)(struct irq_data *data);
 	void		(*irq_pm_shutdown)(struct irq_data *data);
@@ -606,8 +607,10 @@ struct irqaction;
 extern int setup_percpu_irq(unsigned int irq, struct irqaction *new);
 extern void remove_percpu_irq(unsigned int irq, struct irqaction *act);
=20
+#ifdef CONFIG_DEPRECATED_IRQ_CPU_ONOFFLINE
 extern void irq_cpu_online(void);
 extern void irq_cpu_offline(void);
+#endif
 extern int irq_set_affinity_locked(struct irq_data *data,
 				   const struct cpumask *cpumask, bool force);
 extern int irq_set_vcpu_affinity(unsigned int irq, void *vcpu_info);
@@ -1261,6 +1264,7 @@ int __init set_handle_irq(void (*handle_irq)(struct pt_=
regs *));
  * top-level IRQ handler.
  */
 extern void (*handle_arch_irq)(struct pt_regs *) __ro_after_init;
+asmlinkage void generic_handle_arch_irq(struct pt_regs *regs);
 #else
 #ifndef set_handle_irq
 #define set_handle_irq(handle_irq)		\
diff --git a/include/linux/irqchip.h b/include/linux/irqchip.h
index 67351aac65ef..3a091d0710ae 100644
--- a/include/linux/irqchip.h
+++ b/include/linux/irqchip.h
@@ -14,8 +14,15 @@
 #include <linux/acpi.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_irq.h>
 #include <linux/platform_device.h>
=20
+/* Undefined on purpose */
+extern of_irq_init_cb_t typecheck_irq_init_cb;
+
+#define typecheck_irq_init_cb(fn)					\
+	(__typecheck(typecheck_irq_init_cb, &fn) ? fn : fn)
+
 /*
  * This macro must be used by the different irqchip drivers to declare
  * the association between their DT compatible string and their
@@ -23,24 +30,27 @@
  *
  * @name: name that must be unique across all IRQCHIP_DECLARE of the
  * same file.
- * @compstr: compatible string of the irqchip driver
+ * @compat: compatible string of the irqchip driver
  * @fn: initialization function
  */
-#define IRQCHIP_DECLARE(name, compat, fn) OF_DECLARE_2(irqchip, name, compat=
, fn)
+#define IRQCHIP_DECLARE(name, compat, fn)	\
+	OF_DECLARE_2(irqchip, name, compat, typecheck_irq_init_cb(fn))
=20
 extern int platform_irqchip_probe(struct platform_device *pdev);
=20
 #define IRQCHIP_PLATFORM_DRIVER_BEGIN(drv_name) \
 static const struct of_device_id drv_name##_irqchip_match_table[] =3D {
=20
-#define IRQCHIP_MATCH(compat, fn) { .compatible =3D compat, .data =3D fn },
+#define IRQCHIP_MATCH(compat, fn) { .compatible =3D compat,		\
+				    .data =3D typecheck_irq_init_cb(fn), },
=20
 #define IRQCHIP_PLATFORM_DRIVER_END(drv_name)				\
 	{},								\
 };									\
 MODULE_DEVICE_TABLE(of, drv_name##_irqchip_match_table);		\
-static struct platform_driver drv_name##_driver =3D {		\
-	.probe  =3D platform_irqchip_probe,				\
+static struct platform_driver drv_name##_driver =3D {			\
+	.probe  =3D IS_ENABLED(CONFIG_IRQCHIP) ? 				\
+			platform_irqchip_probe : NULL,			\
 	.driver =3D {							\
 		.name =3D #drv_name,					\
 		.owner =3D THIS_MODULE,					\
diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index 59aea39785bf..93d270ca0c56 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -168,14 +168,7 @@ int generic_handle_irq(unsigned int irq);
  * conversion failed.
  */
 int generic_handle_domain_irq(struct irq_domain *domain, unsigned int hwirq);
-
-#ifdef CONFIG_HANDLE_DOMAIN_IRQ
-int handle_domain_irq(struct irq_domain *domain,
-		      unsigned int hwirq, struct pt_regs *regs);
-
-int handle_domain_nmi(struct irq_domain *domain, unsigned int hwirq,
-		      struct pt_regs *regs);
-#endif
+int generic_handle_domain_nmi(struct irq_domain *domain, unsigned int hwirq);
 #endif
=20
 /* Test to see if a driver has successfully requested an irq */
diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
index fbc54c2a7f23..10929eda9825 100644
--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -97,9 +97,6 @@ config GENERIC_MSI_IRQ_DOMAIN
 config IRQ_MSI_IOMMU
 	bool
=20
-config HANDLE_DOMAIN_IRQ
-	bool
-
 config IRQ_TIMINGS
 	bool
=20
@@ -144,3 +141,10 @@ config GENERIC_IRQ_MULTI_HANDLER
 	bool
 	help
 	  Allow to specify the low level IRQ handler at run time.
+
+# Cavium Octeon is the last system to use this deprecated option
+# Do not even think of enabling this on any new platform
+config DEPRECATED_IRQ_CPU_ONOFFLINE
+	bool
+	depends on CAVIUM_OCTEON_SOC
+	default CAVIUM_OCTEON_SOC
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index a98bcfc4be7b..f895265d7548 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -1122,6 +1122,7 @@ void irq_modify_status(unsigned int irq, unsigned long =
clr, unsigned long set)
 }
 EXPORT_SYMBOL_GPL(irq_modify_status);
=20
+#ifdef CONFIG_DEPRECATED_IRQ_CPU_ONOFFLINE
 /**
  *	irq_cpu_online - Invoke all irq_cpu_online functions.
  *
@@ -1181,6 +1182,7 @@ void irq_cpu_offline(void)
 		raw_spin_unlock_irqrestore(&desc->lock, flags);
 	}
 }
+#endif
=20
 #ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
=20
diff --git a/kernel/irq/generic-chip.c b/kernel/irq/generic-chip.c
index cc7cdd26e23e..6f29bf4c8515 100644
--- a/kernel/irq/generic-chip.c
+++ b/kernel/irq/generic-chip.c
@@ -25,6 +25,7 @@ static DEFINE_RAW_SPINLOCK(gc_lock);
 void irq_gc_noop(struct irq_data *d)
 {
 }
+EXPORT_SYMBOL_GPL(irq_gc_noop);
=20
 /**
  * irq_gc_mask_disable_reg - Mask chip via disable register
@@ -44,6 +45,7 @@ void irq_gc_mask_disable_reg(struct irq_data *d)
 	*ct->mask_cache &=3D ~mask;
 	irq_gc_unlock(gc);
 }
+EXPORT_SYMBOL_GPL(irq_gc_mask_disable_reg);
=20
 /**
  * irq_gc_mask_set_bit - Mask chip via setting bit in mask register
@@ -103,6 +105,7 @@ void irq_gc_unmask_enable_reg(struct irq_data *d)
 	*ct->mask_cache |=3D mask;
 	irq_gc_unlock(gc);
 }
+EXPORT_SYMBOL_GPL(irq_gc_unmask_enable_reg);
=20
 /**
  * irq_gc_ack_set_bit - Ack pending interrupt via setting bit
diff --git a/kernel/irq/handle.c b/kernel/irq/handle.c
index 221d80c31e94..27182003b879 100644
--- a/kernel/irq/handle.c
+++ b/kernel/irq/handle.c
@@ -14,6 +14,8 @@
 #include <linux/interrupt.h>
 #include <linux/kernel_stat.h>
=20
+#include <asm/irq_regs.h>
+
 #include <trace/events/irq.h>
=20
 #include "internals.h"
@@ -226,4 +228,20 @@ int __init set_handle_irq(void (*handle_irq)(struct pt_r=
egs *))
 	handle_arch_irq =3D handle_irq;
 	return 0;
 }
+
+/**
+ * generic_handle_arch_irq - root irq handler for architectures which do no
+ *                           entry accounting themselves
+ * @regs:	Register file coming from the low-level handling code
+ */
+asmlinkage void noinstr generic_handle_arch_irq(struct pt_regs *regs)
+{
+	struct pt_regs *old_regs;
+
+	irq_enter();
+	old_regs =3D set_irq_regs(regs);
+	handle_arch_irq(regs);
+	set_irq_regs(old_regs);
+	irq_exit();
+}
 #endif
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 4e3c29bb603c..2267e6527db3 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -646,13 +646,16 @@ int handle_irq_desc(struct irq_desc *desc)
 	generic_handle_irq_desc(desc);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(handle_irq_desc);
=20
 /**
  * generic_handle_irq - Invoke the handler for a particular irq
  * @irq:	The irq number to handle
  *
- */
+ * Returns:	0 on success, or -EINVAL if conversion has failed
+ *
+ * 		This function must be called from an IRQ context with irq regs
+ * 		initialized.
+  */
 int generic_handle_irq(unsigned int irq)
 {
 	return handle_irq_desc(irq_to_desc(irq));
@@ -662,89 +665,39 @@ EXPORT_SYMBOL_GPL(generic_handle_irq);
 #ifdef CONFIG_IRQ_DOMAIN
 /**
  * generic_handle_domain_irq - Invoke the handler for a HW irq belonging
- *                             to a domain, usually for a non-root interrupt
- *                             controller
+ *                             to a domain.
  * @domain:	The domain where to perform the lookup
  * @hwirq:	The HW irq number to convert to a logical one
  *
  * Returns:	0 on success, or -EINVAL if conversion has failed
  *
+ * 		This function must be called from an IRQ context with irq regs
+ * 		initialized.
  */
 int generic_handle_domain_irq(struct irq_domain *domain, unsigned int hwirq)
 {
+	WARN_ON_ONCE(!in_irq());
 	return handle_irq_desc(irq_resolve_mapping(domain, hwirq));
 }
 EXPORT_SYMBOL_GPL(generic_handle_domain_irq);
=20
-#ifdef CONFIG_HANDLE_DOMAIN_IRQ
 /**
- * handle_domain_irq - Invoke the handler for a HW irq belonging to a domain,
- *                     usually for a root interrupt controller
+ * generic_handle_domain_nmi - Invoke the handler for a HW nmi belonging
+ *                             to a domain.
  * @domain:	The domain where to perform the lookup
  * @hwirq:	The HW irq number to convert to a logical one
- * @regs:	Register file coming from the low-level handling code
  *
  * Returns:	0 on success, or -EINVAL if conversion has failed
- */
-int handle_domain_irq(struct irq_domain *domain,
-		      unsigned int hwirq, struct pt_regs *regs)
-{
-	struct pt_regs *old_regs =3D set_irq_regs(regs);
-	struct irq_desc *desc;
-	int ret =3D 0;
-
-	irq_enter();
-
-	/* The irqdomain code provides boundary checks */
-	desc =3D irq_resolve_mapping(domain, hwirq);
-	if (likely(desc))
-		handle_irq_desc(desc);
-	else
-		ret =3D -EINVAL;
-
-	irq_exit();
-	set_irq_regs(old_regs);
-	return ret;
-}
-
-/**
- * handle_domain_nmi - Invoke the handler for a HW irq belonging to a domain
- * @domain:	The domain where to perform the lookup
- * @hwirq:	The HW irq number to convert to a logical one
- * @regs:	Register file coming from the low-level handling code
  *
- *		This function must be called from an NMI context.
- *
- * Returns:	0 on success, or -EINVAL if conversion has failed
- */
-int handle_domain_nmi(struct irq_domain *domain, unsigned int hwirq,
-		      struct pt_regs *regs)
+ * 		This function must be called from an NMI context with irq regs
+ * 		initialized.
+ **/
+int generic_handle_domain_nmi(struct irq_domain *domain, unsigned int hwirq)
 {
-	struct pt_regs *old_regs =3D set_irq_regs(regs);
-	struct irq_desc *desc;
-	int ret =3D 0;
-
-	/*
-	 * NMI context needs to be setup earlier in order to deal with tracing.
-	 */
-	WARN_ON(!in_nmi());
-
-	desc =3D irq_resolve_mapping(domain, hwirq);
-
-	/*
-	 * ack_bad_irq is not NMI-safe, just report
-	 * an invalid interrupt.
-	 */
-	if (likely(desc))
-		handle_irq_desc(desc);
-	else
-		ret =3D -EINVAL;
-
-	set_irq_regs(old_regs);
-	return ret;
+	WARN_ON_ONCE(!in_nmi());
+	return handle_irq_desc(irq_resolve_mapping(domain, hwirq));
 }
 #endif
-#endif
=20
 /* Dynamic interrupt handling */
=20
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 27667e82ecc9..7405e384e5ed 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1259,6 +1259,8 @@ static int irq_thread(void *data)
 	irqreturn_t (*handler_fn)(struct irq_desc *desc,
 			struct irqaction *action);
=20
+	sched_set_fifo(current);
+
 	if (force_irqthreads() && test_bit(IRQTF_FORCED_THREAD,
 					   &action->thread_flags))
 		handler_fn =3D irq_forced_thread_fn;
@@ -1424,8 +1426,6 @@ setup_irq_thread(struct irqaction *new, unsigned int ir=
q, bool secondary)
 	if (IS_ERR(t))
 		return PTR_ERR(t);
=20
-	sched_set_fifo(t);
-
 	/*
 	 * We keep the reference to the task struct even if
 	 * the thread dies to avoid that the interrupt code
@@ -2827,7 +2827,7 @@ EXPORT_SYMBOL_GPL(irq_get_irqchip_state);
  *	This call sets the internal irqchip state of an interrupt,
  *	depending on the value of @which.
  *
- *	This function should be called with preemption disabled if the
+ *	This function should be called with migration disabled if the
  *	interrupt controller has per-cpu registers.
  */
 int irq_set_irqchip_state(unsigned int irq, enum irqchip_irq_state which,
diff --git a/kernel/irq/spurious.c b/kernel/irq/spurious.c
index c481d8458325..02b2daf07441 100644
--- a/kernel/irq/spurious.c
+++ b/kernel/irq/spurious.c
@@ -447,6 +447,10 @@ MODULE_PARM_DESC(noirqdebug, "Disable irq lockup detecti=
on when true");
=20
 static int __init irqfixup_setup(char *str)
 {
+	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
+		pr_warn("irqfixup boot option not supported with PREEMPT_RT\n");
+		return 1;
+	}
 	irqfixup =3D 1;
 	printk(KERN_WARNING "Misrouted IRQ fixup support enabled.\n");
 	printk(KERN_WARNING "This may impact system performance.\n");
@@ -459,6 +463,10 @@ module_param(irqfixup, int, 0644);
=20
 static int __init irqpoll_setup(char *str)
 {
+	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
+		pr_warn("irqpoll boot option not supported with PREEMPT_RT\n");
+		return 1;
+	}
 	irqfixup =3D 2;
 	printk(KERN_WARNING "Misrouted IRQ fixup and polling support "
 				"enabled\n");

