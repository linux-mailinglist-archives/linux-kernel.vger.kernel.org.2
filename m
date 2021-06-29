Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 438833B747C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 16:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234551AbhF2OlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 10:41:20 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54718 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234515AbhF2OlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 10:41:15 -0400
Date:   Tue, 29 Jun 2021 14:35:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624977526;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=2S+ILeasHPxlORWUc7wU//J7hWZpTgu9lqe4dQSB8Wg=;
        b=j2T64SHQMDIswAo0DVsKHGT1eWz2fhxMMEHGyFYF3dXPCIzrmlC5PSAkqTYLmVa2rhFS4W
        o5mGOqroHAmNU/Wm8qd+x2W13tHci5VGRlfOhCC9+U6uZ9JfuohzUTk6O3DVzIaipuzLmx
        qbA+doz1ZaN6j6DSHgyw5+4D3OJoTysUwoeZUNCK+U1rdAIvRZ3FSZ964pt7tKpCWbw7NL
        huFXw0LWfMrGUZrqzAEzlrqCvg9RC/2lBHoKwryxUndUR1Fs5lbHZ+ZAEUPAGsFWMC9eCy
        w2SzlNC/D/4X75b3TDoMJ/WnXq/HUX/BrM4Z0VXZmResy2aY1HT84P03lNjsBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624977526;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=2S+ILeasHPxlORWUc7wU//J7hWZpTgu9lqe4dQSB8Wg=;
        b=d0hoCsSzeOwAuw6PbQMuHXLuzl49tmsMvyWvSJMpC6iCPCQ0OfbsHLVMg/oTZxgnDZvoI3
        Ft8zm3HVFNqJ+0BA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] irq/core for v5.14-rc1
Message-ID: <162497731214.6531.6083197571290189651.tglx@nanos>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest irq/core branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2021-06-29

up to:  3d2ce675aba7: Merge tag 'irqchip-5.14' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/core

Updates for the interrupt subsystem:

Core changes:

  - Cleanup and simplification of common code to invoke the low level
    interrupt flow handlers when this invocation requires irqdomain
    resolution. Add the necessary core infrastructure.

  - Provide a proper interface for modular PMU drivers to set the
    interrupt affinity.

  - Add a request flag which allows to exclude interrupts from spurious
    interrupt detection. Useful especially for IPI handlers which always
    return IRQ_HANDLED which turns the spurious interrupt detection into a
    pointless waste of CPU cycles.

Driver changes:

  - Bulk convert interrupt chip drivers to the new irqdomain low level flow
    handler invocation mechanism.

  - Add device tree bindings for the Renesas R-Car M3-W+ SoC

  - Enable modular build of the Qualcomm PDC driver

  - The usual small fixes and improvements.

Thanks,

	tglx

------------------>
Chunfeng Yun (1):
      irqchip: gic-pm: Remove redundant error log of clock bulk

Geert Uytterhoeven (1):
      dt-bindings: irqchip: renesas-irqc: Add R-Car M3-W+ support

Lad Prabhakar (1):
      dt-bindings: interrupt-controller: arm,gic-v3: Describe GICv3 optional properties

Marc Zyngier (26):
      nios2: Do not include linux/irqdomain.h from asm/irq.h
      staging: octeon-hcd: Directly include linux/of.h
      mfd: ioc3: Directly include linux/irqdomain.h
      watchdog/octeon-wdt: Directly include linux/irqdomain.h
      irqchip/mips-gic: Directly include linux/irqdomain.h
      MIPS: lantiq: Directly include linux/of.h in xway/dma.c
      MIPS: Add missing linux/irqdomain.h includes
      MIPS: Do not include linux/irqdomain.h from asm/irq.h
      powerpc: Add missing linux/{of.h,irqdomain.h} include directives
      scsi/ibmvscsi: Directly include linux/{of.h,irqdomain.h}
      powerpc: Convert irq_domain_add_legacy_isa use to irq_domain_add_legacy
      powerpc: Drop dependency between asm/irq.h and linux/irqdomain.h
      irqdomain: Kill irq_domain_add_legacy_isa
      irqdomain: Reimplement irq_linear_revmap() with irq_find_mapping()
      powerpc: Move the use of irq_domain_add_nomap() behind a config option
      irqdomain: Make normal and nomap irqdomains exclusive
      irqdomain: Use struct_size() helper when allocating irqdomain
      irqdomain: Cache irq_data instead of a virq number in the revmap
      irqdomain: Protect the linear revmap with RCU
      irqdomain: Introduce irq_resolve_mapping()
      genirq: Use irq_resolve_mapping() to implement __handle_domain_irq() and co
      irqdesc: Fix __handle_domain_irq() comment
      irqchip/nvic: Convert from handle_IRQ() to handle_domain_irq()
      genirq: Add generic_handle_domain_irq() helper
      genirq: Move non-irqdomain handle_domain_irq() handling into ARM's handle_IRQ()
      irqchip: Bulk conversion to generic_handle_domain_irq()

Saravana Kannan (1):
      irqchip/qcom-pdc: Switch to IRQCHIP_PLATFORM_DRIVER and allow as a module

Thomas Gleixner (2):
      genirq: Add a IRQF_NO_DEBUG flag
      genirq: Export affinity setter for modules

Yang Yingliang (1):
      irqchip/mbigen: Fix compile warning when CONFIG_ACPI is disabled

Zhen Lei (6):
      irqchip/exynos-combiner: Remove unnecessary oom message
      irqchip/gic-v2m: Remove unnecessary oom message
      irqchip/gic-v3-its: Remove unnecessary oom message
      irqchip/imgpdc: Remove unnecessary oom message
      irqchip/irq-imx-gpcv2: Remove unnecessary oom message
      irqchip/sun4i: Remove unnecessary oom message


 Documentation/core-api/irq/irq-domain.rst          |   1 -
 .../bindings/interrupt-controller/arm,gic-v3.yaml  |  13 +++
 .../interrupt-controller/renesas,irqc.yaml         |   1 +
 arch/arm/kernel/irq.c                              |  22 +++-
 arch/mips/include/asm/irq.h                        |   1 -
 arch/mips/lantiq/xway/dma.c                        |   1 +
 arch/mips/pci/pci-rt3883.c                         |   1 +
 arch/mips/pci/pci-xtalk-bridge.c                   |   1 +
 arch/mips/sgi-ip27/ip27-irq.c                      |   1 +
 arch/mips/sgi-ip30/ip30-irq.c                      |   1 +
 arch/nios2/include/asm/irq.h                       |   1 -
 arch/nios2/kernel/irq.c                            |   1 +
 arch/powerpc/include/asm/irq.h                     |   5 +-
 arch/powerpc/kernel/mce.c                          |   1 +
 arch/powerpc/kvm/book3s_hv_uvmem.c                 |   1 +
 arch/powerpc/kvm/book3s_xive.c                     |   1 +
 arch/powerpc/kvm/book3s_xive_native.c              |   1 +
 arch/powerpc/mm/book3s64/radix_pgtable.c           |   1 +
 arch/powerpc/platforms/cell/Kconfig                |   1 +
 arch/powerpc/platforms/cell/pmu.c                  |   1 +
 arch/powerpc/platforms/embedded6xx/flipper-pic.c   |   1 +
 arch/powerpc/platforms/powermac/Kconfig            |   1 +
 arch/powerpc/platforms/ps3/Kconfig                 |   1 +
 arch/powerpc/platforms/ps3/interrupt.c             |   5 +-
 arch/powerpc/platforms/pseries/ibmebus.c           |   1 +
 arch/powerpc/sysdev/ehv_pic.c                      |   1 +
 arch/powerpc/sysdev/fsl_mpic_err.c                 |   1 +
 arch/powerpc/sysdev/i8259.c                        |   3 +-
 arch/powerpc/sysdev/mpic.c                         |   2 +-
 arch/powerpc/sysdev/tsi108_pci.c                   |   3 +-
 arch/powerpc/sysdev/xics/icp-hv.c                  |   1 +
 arch/powerpc/sysdev/xics/icp-opal.c                |   1 +
 arch/powerpc/sysdev/xics/xics-common.c             |   2 +-
 arch/powerpc/sysdev/xive/Kconfig                   |   1 +
 drivers/irqchip/Kconfig                            |   2 +-
 drivers/irqchip/exynos-combiner.c                  |  14 +--
 drivers/irqchip/irq-al-fic.c                       |   7 +-
 drivers/irqchip/irq-armada-370-xp.c                |  19 ++--
 drivers/irqchip/irq-aspeed-i2c-ic.c                |   8 +-
 drivers/irqchip/irq-aspeed-scu-ic.c                |   6 +-
 drivers/irqchip/irq-ath79-misc.c                   |   2 +-
 drivers/irqchip/irq-bcm2835.c                      |   2 +-
 drivers/irqchip/irq-bcm2836.c                      |   2 +-
 drivers/irqchip/irq-bcm7038-l1.c                   |   6 +-
 drivers/irqchip/irq-bcm7120-l2.c                   |   6 +-
 drivers/irqchip/irq-brcmstb-l2.c                   |   2 +-
 drivers/irqchip/irq-dw-apb-ictl.c                  |   3 +-
 drivers/irqchip/irq-gic-pm.c                       |   4 +-
 drivers/irqchip/irq-gic-v2m.c                      |   4 +-
 drivers/irqchip/irq-gic-v3-its.c                   |   8 +-
 drivers/irqchip/irq-gic.c                          |  13 +--
 drivers/irqchip/irq-goldfish-pic.c                 |   5 +-
 drivers/irqchip/irq-i8259.c                        |   4 +-
 drivers/irqchip/irq-idt3243x.c                     |   6 +-
 drivers/irqchip/irq-imgpdc.c                       |  19 ++--
 drivers/irqchip/irq-imx-gpcv2.c                    |   4 +-
 drivers/irqchip/irq-imx-intmux.c                   |   9 +-
 drivers/irqchip/irq-imx-irqsteer.c                 |   9 +-
 drivers/irqchip/irq-ingenic-tcu.c                  |   2 +-
 drivers/irqchip/irq-ingenic.c                      |   3 +-
 drivers/irqchip/irq-keystone.c                     |  14 ++-
 drivers/irqchip/irq-loongson-htpic.c               |   2 +-
 drivers/irqchip/irq-loongson-htvec.c               |   4 +-
 drivers/irqchip/irq-loongson-liointc.c             |   2 +-
 drivers/irqchip/irq-lpc32xx.c                      |   2 +-
 drivers/irqchip/irq-ls-scfg-msi.c                  |   6 +-
 drivers/irqchip/irq-ls1x.c                         |   2 +-
 drivers/irqchip/irq-mbigen.c                       |  12 +--
 drivers/irqchip/irq-mips-gic.c                     |  21 ++--
 drivers/irqchip/irq-mscc-ocelot.c                  |   2 +-
 drivers/irqchip/irq-mvebu-pic.c                    |   7 +-
 drivers/irqchip/irq-mvebu-sei.c                    |  13 +--
 drivers/irqchip/irq-nvic.c                         |   4 +-
 drivers/irqchip/irq-orion.c                        |   2 +-
 drivers/irqchip/irq-partition-percpu.c             |   9 +-
 drivers/irqchip/irq-pruss-intc.c                   |   9 +-
 drivers/irqchip/irq-realtek-rtl.c                  |   2 +-
 drivers/irqchip/irq-renesas-irqc.c                 |   2 +-
 drivers/irqchip/irq-sifive-plic.c                  |   8 +-
 drivers/irqchip/irq-stm32-exti.c                   |  10 +-
 drivers/irqchip/irq-sun4i.c                        |   8 +-
 drivers/irqchip/irq-sunxi-nmi.c                    |   3 +-
 drivers/irqchip/irq-tb10x.c                        |   2 +-
 drivers/irqchip/irq-ti-sci-inta.c                  |   9 +-
 drivers/irqchip/irq-ts4800.c                       |   3 +-
 drivers/irqchip/irq-versatile-fpga.c               |   2 +-
 drivers/irqchip/irq-vic.c                          |   2 +-
 drivers/irqchip/irq-xilinx-intc.c                  |  23 +---
 drivers/irqchip/qcom-irq-combiner.c                |   6 +-
 drivers/irqchip/qcom-pdc.c                         |   8 +-
 drivers/mfd/ioc3.c                                 |   1 +
 drivers/scsi/ibmvscsi/ibmvfc.c                     |   1 +
 drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c           |   1 +
 drivers/staging/octeon-usb/octeon-hcd.c            |   2 +
 drivers/watchdog/octeon-wdt-main.c                 |   1 +
 include/linux/interrupt.h                          |  38 +------
 include/linux/irq.h                                |   2 +
 include/linux/irqdesc.h                            |  18 ++--
 include/linux/irqdomain.h                          |  65 ++++++-----
 kernel/irq/Kconfig                                 |   5 +
 kernel/irq/chip.c                                  |   2 +-
 kernel/irq/handle.c                                |   2 +-
 kernel/irq/irqdesc.c                               |  73 +++++++------
 kernel/irq/irqdomain.c                             | 120 ++++++++++++++-------
 kernel/irq/manage.c                                |  38 ++++++-
 kernel/irq/settings.h                              |  12 +++
 106 files changed, 442 insertions(+), 388 deletions(-)

diff --git a/Documentation/core-api/irq/irq-domain.rst b/Documentation/core-api/irq/irq-domain.rst
index 8214e215a8bf..53283b3729a1 100644
--- a/Documentation/core-api/irq/irq-domain.rst
+++ b/Documentation/core-api/irq/irq-domain.rst
@@ -146,7 +146,6 @@ Legacy
 
 	irq_domain_add_simple()
 	irq_domain_add_legacy()
-	irq_domain_add_legacy_isa()
 	irq_domain_create_simple()
 	irq_domain_create_legacy()
 
diff --git a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
index 1ecd1831cf02..c84f9fe7f254 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
@@ -145,6 +145,19 @@ properties:
         required:
           - affinity
 
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: aclk
+
+  power-domains:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
 dependencies:
   mbi-ranges: [ msi-controller ]
   msi-controller: [ mbi-ranges ]
diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.yaml b/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.yaml
index b67b8cbd33fc..abb22db3bb28 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.yaml
@@ -29,6 +29,7 @@ properties:
           - renesas,intc-ex-r8a774c0    # RZ/G2E
           - renesas,intc-ex-r8a7795     # R-Car H3
           - renesas,intc-ex-r8a7796     # R-Car M3-W
+          - renesas,intc-ex-r8a77961    # R-Car M3-W+
           - renesas,intc-ex-r8a77965    # R-Car M3-N
           - renesas,intc-ex-r8a77970    # R-Car V3M
           - renesas,intc-ex-r8a77980    # R-Car V3H
diff --git a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c
index 698b6f636156..20ab1e607522 100644
--- a/arch/arm/kernel/irq.c
+++ b/arch/arm/kernel/irq.c
@@ -63,7 +63,27 @@ int arch_show_interrupts(struct seq_file *p, int prec)
  */
 void handle_IRQ(unsigned int irq, struct pt_regs *regs)
 {
-	__handle_domain_irq(NULL, irq, false, regs);
+	struct pt_regs *old_regs = set_irq_regs(regs);
+	struct irq_desc *desc;
+
+	irq_enter();
+
+	/*
+	 * Some hardware gives randomly wrong interrupts.  Rather
+	 * than crashing, do something sensible.
+	 */
+	if (unlikely(!irq || irq >= nr_irqs))
+		desc = NULL;
+	else
+		desc = irq_to_desc(irq);
+
+	if (likely(desc))
+		handle_irq_desc(desc);
+	else
+		ack_bad_irq(irq);
+
+	irq_exit();
+	set_irq_regs(old_regs);
 }
 
 /*
diff --git a/arch/mips/include/asm/irq.h b/arch/mips/include/asm/irq.h
index f021de661c3a..d1477ecb1af9 100644
--- a/arch/mips/include/asm/irq.h
+++ b/arch/mips/include/asm/irq.h
@@ -11,7 +11,6 @@
 
 #include <linux/linkage.h>
 #include <linux/smp.h>
-#include <linux/irqdomain.h>
 
 #include <asm/mipsmtregs.h>
 
diff --git a/arch/mips/lantiq/xway/dma.c b/arch/mips/lantiq/xway/dma.c
index aeb1b989cd4e..63dccb2ed08b 100644
--- a/arch/mips/lantiq/xway/dma.c
+++ b/arch/mips/lantiq/xway/dma.c
@@ -12,6 +12,7 @@
 #include <linux/spinlock.h>
 #include <linux/clk.h>
 #include <linux/err.h>
+#include <linux/of.h>
 
 #include <lantiq_soc.h>
 #include <xway_dma.h>
diff --git a/arch/mips/pci/pci-rt3883.c b/arch/mips/pci/pci-rt3883.c
index aebd4964ea34..c48e23cf5b5e 100644
--- a/arch/mips/pci/pci-rt3883.c
+++ b/arch/mips/pci/pci-rt3883.c
@@ -13,6 +13,7 @@
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
+#include <linux/irqdomain.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
 #include <linux/of_pci.h>
diff --git a/arch/mips/pci/pci-xtalk-bridge.c b/arch/mips/pci/pci-xtalk-bridge.c
index d2216942af18..ab9bedb82b28 100644
--- a/arch/mips/pci/pci-xtalk-bridge.c
+++ b/arch/mips/pci/pci-xtalk-bridge.c
@@ -13,6 +13,7 @@
 #include <linux/platform_data/xtalk-bridge.h>
 #include <linux/nvmem-consumer.h>
 #include <linux/crc16.h>
+#include <linux/irqdomain.h>
 
 #include <asm/pci/bridge.h>
 #include <asm/paccess.h>
diff --git a/arch/mips/sgi-ip27/ip27-irq.c b/arch/mips/sgi-ip27/ip27-irq.c
index 42df9fafa943..95c1bff1ab9f 100644
--- a/arch/mips/sgi-ip27/ip27-irq.c
+++ b/arch/mips/sgi-ip27/ip27-irq.c
@@ -9,6 +9,7 @@
 
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/irqdomain.h>
 #include <linux/ioport.h>
 #include <linux/kernel.h>
 #include <linux/bitops.h>
diff --git a/arch/mips/sgi-ip30/ip30-irq.c b/arch/mips/sgi-ip30/ip30-irq.c
index e8374e4c705b..ba87704073c8 100644
--- a/arch/mips/sgi-ip30/ip30-irq.c
+++ b/arch/mips/sgi-ip30/ip30-irq.c
@@ -6,6 +6,7 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/irqdomain.h>
 #include <linux/percpu.h>
 #include <linux/spinlock.h>
 #include <linux/tick.h>
diff --git a/arch/nios2/include/asm/irq.h b/arch/nios2/include/asm/irq.h
index 13ce37272279..c52c94884e93 100644
--- a/arch/nios2/include/asm/irq.h
+++ b/arch/nios2/include/asm/irq.h
@@ -10,6 +10,5 @@
 #define NIOS2_CPU_NR_IRQS	32
 
 #include <asm-generic/irq.h>
-#include <linux/irqdomain.h>
 
 #endif
diff --git a/arch/nios2/kernel/irq.c b/arch/nios2/kernel/irq.c
index 5f3555ce4865..c6a1a9f6ac42 100644
--- a/arch/nios2/kernel/irq.c
+++ b/arch/nios2/kernel/irq.c
@@ -11,6 +11,7 @@
 
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/irqdomain.h>
 #include <linux/of.h>
 
 static u32 ienable;
diff --git a/arch/powerpc/include/asm/irq.h b/arch/powerpc/include/asm/irq.h
index b2bd58830430..4982f3711fc3 100644
--- a/arch/powerpc/include/asm/irq.h
+++ b/arch/powerpc/include/asm/irq.h
@@ -6,7 +6,6 @@
 /*
  */
 
-#include <linux/irqdomain.h>
 #include <linux/threads.h>
 #include <linux/list.h>
 #include <linux/radix-tree.h>
@@ -23,8 +22,8 @@ extern atomic_t ppc_n_lost_interrupts;
 /* Total number of virq in the platform */
 #define NR_IRQS		CONFIG_NR_IRQS
 
-/* Same thing, used by the generic IRQ code */
-#define NR_IRQS_LEGACY		NUM_ISA_INTERRUPTS
+/* Number of irqs reserved for a legacy isa controller */
+#define NR_IRQS_LEGACY		16
 
 extern irq_hw_number_t virq_to_hw(unsigned int virq);
 
diff --git a/arch/powerpc/kernel/mce.c b/arch/powerpc/kernel/mce.c
index 9a3c2a84a2ac..15e7b4900689 100644
--- a/arch/powerpc/kernel/mce.c
+++ b/arch/powerpc/kernel/mce.c
@@ -18,6 +18,7 @@
 #include <linux/extable.h>
 #include <linux/ftrace.h>
 #include <linux/memblock.h>
+#include <linux/of.h>
 
 #include <asm/interrupt.h>
 #include <asm/machdep.h>
diff --git a/arch/powerpc/kvm/book3s_hv_uvmem.c b/arch/powerpc/kvm/book3s_hv_uvmem.c
index 84e5a2dc8be5..b898a596db42 100644
--- a/arch/powerpc/kvm/book3s_hv_uvmem.c
+++ b/arch/powerpc/kvm/book3s_hv_uvmem.c
@@ -90,6 +90,7 @@
 #include <linux/migrate.h>
 #include <linux/kvm_host.h>
 #include <linux/ksm.h>
+#include <linux/of.h>
 #include <asm/ultravisor.h>
 #include <asm/mman.h>
 #include <asm/kvm_ppc.h>
diff --git a/arch/powerpc/kvm/book3s_xive.c b/arch/powerpc/kvm/book3s_xive.c
index e7219b6f5f9a..08910d44d2cb 100644
--- a/arch/powerpc/kvm/book3s_xive.c
+++ b/arch/powerpc/kvm/book3s_xive.c
@@ -14,6 +14,7 @@
 #include <linux/percpu.h>
 #include <linux/cpumask.h>
 #include <linux/uaccess.h>
+#include <linux/irqdomain.h>
 #include <asm/kvm_book3s.h>
 #include <asm/kvm_ppc.h>
 #include <asm/hvcall.h>
diff --git a/arch/powerpc/kvm/book3s_xive_native.c b/arch/powerpc/kvm/book3s_xive_native.c
index 76800c84f2a3..30bacf6dd53d 100644
--- a/arch/powerpc/kvm/book3s_xive_native.c
+++ b/arch/powerpc/kvm/book3s_xive_native.c
@@ -12,6 +12,7 @@
 #include <linux/spinlock.h>
 #include <linux/delay.h>
 #include <linux/file.h>
+#include <linux/irqdomain.h>
 #include <asm/uaccess.h>
 #include <asm/kvm_book3s.h>
 #include <asm/kvm_ppc.h>
diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
index 5fef8db3b463..edadb9e9c9c0 100644
--- a/arch/powerpc/mm/book3s64/radix_pgtable.c
+++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
@@ -11,6 +11,7 @@
 #include <linux/kernel.h>
 #include <linux/sched/mm.h>
 #include <linux/memblock.h>
+#include <linux/of.h>
 #include <linux/of_fdt.h>
 #include <linux/mm.h>
 #include <linux/hugetlb.h>
diff --git a/arch/powerpc/platforms/cell/Kconfig b/arch/powerpc/platforms/cell/Kconfig
index e7c976bcadff..cb70c5f25bc6 100644
--- a/arch/powerpc/platforms/cell/Kconfig
+++ b/arch/powerpc/platforms/cell/Kconfig
@@ -35,6 +35,7 @@ config PPC_IBM_CELL_BLADE
 config AXON_MSI
 	bool
 	depends on PPC_IBM_CELL_BLADE && PCI_MSI
+	select IRQ_DOMAIN_NOMAP
 	default y
 
 menu "Cell Broadband Engine options"
diff --git a/arch/powerpc/platforms/cell/pmu.c b/arch/powerpc/platforms/cell/pmu.c
index 35bbd15582af..b207a7f99be5 100644
--- a/arch/powerpc/platforms/cell/pmu.c
+++ b/arch/powerpc/platforms/cell/pmu.c
@@ -10,6 +10,7 @@
  */
 
 #include <linux/interrupt.h>
+#include <linux/irqdomain.h>
 #include <linux/types.h>
 #include <linux/export.h>
 #include <asm/io.h>
diff --git a/arch/powerpc/platforms/embedded6xx/flipper-pic.c b/arch/powerpc/platforms/embedded6xx/flipper-pic.c
index d39a9213a3e6..609bda2ad5dd 100644
--- a/arch/powerpc/platforms/embedded6xx/flipper-pic.c
+++ b/arch/powerpc/platforms/embedded6xx/flipper-pic.c
@@ -12,6 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/irq.h>
+#include <linux/irqdomain.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <asm/io.h>
diff --git a/arch/powerpc/platforms/powermac/Kconfig b/arch/powerpc/platforms/powermac/Kconfig
index c02d8c503b29..b97bf12801eb 100644
--- a/arch/powerpc/platforms/powermac/Kconfig
+++ b/arch/powerpc/platforms/powermac/Kconfig
@@ -24,6 +24,7 @@ config PPC_PMAC32_PSURGE
 	bool "Support for powersurge upgrade cards" if EXPERT
 	depends on SMP && PPC32 && PPC_PMAC
 	select PPC_SMP_MUXED_IPI
+	select IRQ_DOMAIN_NOMAP
 	default y
 	help
 	  The powersurge cpu boards can be used in the generation
diff --git a/arch/powerpc/platforms/ps3/Kconfig b/arch/powerpc/platforms/ps3/Kconfig
index e32406e918d0..4d0535cc7946 100644
--- a/arch/powerpc/platforms/ps3/Kconfig
+++ b/arch/powerpc/platforms/ps3/Kconfig
@@ -7,6 +7,7 @@ config PPC_PS3
 	select USB_OHCI_BIG_ENDIAN_MMIO
 	select USB_EHCI_BIG_ENDIAN_MMIO
 	select HAVE_PCI
+	select IRQ_DOMAIN_NOMAP
 	help
 	  This option enables support for the Sony PS3 game console
 	  and other platforms using the PS3 hypervisor.  Enabling this
diff --git a/arch/powerpc/platforms/ps3/interrupt.c b/arch/powerpc/platforms/ps3/interrupt.c
index 78f2339ed5cb..49871427f599 100644
--- a/arch/powerpc/platforms/ps3/interrupt.c
+++ b/arch/powerpc/platforms/ps3/interrupt.c
@@ -9,6 +9,7 @@
 #include <linux/kernel.h>
 #include <linux/export.h>
 #include <linux/irq.h>
+#include <linux/irqdomain.h>
 
 #include <asm/machdep.h>
 #include <asm/udbg.h>
@@ -45,7 +46,7 @@
  * implementation equates HV plug value to Linux virq value, constrains each
  * interrupt to have a system wide unique plug number, and limits the range
  * of the plug values to map into the first dword of the bitmaps.  This
- * gives a usable range of plug values of  {NUM_ISA_INTERRUPTS..63}.  Note
+ * gives a usable range of plug values of  {NR_IRQS_LEGACY..63}.  Note
  * that there is no constraint on how many in this set an individual thread
  * can acquire.
  *
@@ -721,7 +722,7 @@ static unsigned int ps3_get_irq(void)
 	}
 
 #if defined(DEBUG)
-	if (unlikely(plug < NUM_ISA_INTERRUPTS || plug > PS3_PLUG_MAX)) {
+	if (unlikely(plug < NR_IRQS_LEGACY || plug > PS3_PLUG_MAX)) {
 		dump_bmp(&per_cpu(ps3_private, 0));
 		dump_bmp(&per_cpu(ps3_private, 1));
 		BUG();
diff --git a/arch/powerpc/platforms/pseries/ibmebus.c b/arch/powerpc/platforms/pseries/ibmebus.c
index a15ab33646b3..c6c79ef55e13 100644
--- a/arch/powerpc/platforms/pseries/ibmebus.c
+++ b/arch/powerpc/platforms/pseries/ibmebus.c
@@ -42,6 +42,7 @@
 #include <linux/kobject.h>
 #include <linux/dma-map-ops.h>
 #include <linux/interrupt.h>
+#include <linux/irqdomain.h>
 #include <linux/of.h>
 #include <linux/slab.h>
 #include <linux/stat.h>
diff --git a/arch/powerpc/sysdev/ehv_pic.c b/arch/powerpc/sysdev/ehv_pic.c
index 48866e6c1efb..00705258ecf9 100644
--- a/arch/powerpc/sysdev/ehv_pic.c
+++ b/arch/powerpc/sysdev/ehv_pic.c
@@ -14,6 +14,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/irq.h>
+#include <linux/irqdomain.h>
 #include <linux/smp.h>
 #include <linux/interrupt.h>
 #include <linux/slab.h>
diff --git a/arch/powerpc/sysdev/fsl_mpic_err.c b/arch/powerpc/sysdev/fsl_mpic_err.c
index 13583bbc3e8e..5fa5fa215541 100644
--- a/arch/powerpc/sysdev/fsl_mpic_err.c
+++ b/arch/powerpc/sysdev/fsl_mpic_err.c
@@ -8,6 +8,7 @@
 #include <linux/irq.h>
 #include <linux/smp.h>
 #include <linux/interrupt.h>
+#include <linux/irqdomain.h>
 
 #include <asm/io.h>
 #include <asm/irq.h>
diff --git a/arch/powerpc/sysdev/i8259.c b/arch/powerpc/sysdev/i8259.c
index c1d76c344351..dc1a151c63d7 100644
--- a/arch/powerpc/sysdev/i8259.c
+++ b/arch/powerpc/sysdev/i8259.c
@@ -260,7 +260,8 @@ void i8259_init(struct device_node *node, unsigned long intack_addr)
 	raw_spin_unlock_irqrestore(&i8259_lock, flags);
 
 	/* create a legacy host */
-	i8259_host = irq_domain_add_legacy_isa(node, &i8259_host_ops, NULL);
+	i8259_host = irq_domain_add_legacy(node, NR_IRQS_LEGACY, 0, 0,
+					   &i8259_host_ops, NULL);
 	if (i8259_host == NULL) {
 		printk(KERN_ERR "i8259: failed to allocate irq host !\n");
 		return;
diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index b0426f28946a..995fb2ada507 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -602,7 +602,7 @@ static void __init mpic_scan_ht_pics(struct mpic *mpic)
 /* Find an mpic associated with a given linux interrupt */
 static struct mpic *mpic_find(unsigned int irq)
 {
-	if (irq < NUM_ISA_INTERRUPTS)
+	if (irq < NR_IRQS_LEGACY)
 		return NULL;
 
 	return irq_get_chip_data(irq);
diff --git a/arch/powerpc/sysdev/tsi108_pci.c b/arch/powerpc/sysdev/tsi108_pci.c
index 49f9541954f8..042bb38fa5c2 100644
--- a/arch/powerpc/sysdev/tsi108_pci.c
+++ b/arch/powerpc/sysdev/tsi108_pci.c
@@ -404,7 +404,8 @@ void __init tsi108_pci_int_init(struct device_node *node)
 {
 	DBG("Tsi108_pci_int_init: initializing PCI interrupts\n");
 
-	pci_irq_host = irq_domain_add_legacy_isa(node, &pci_irq_domain_ops, NULL);
+	pci_irq_host = irq_domain_add_legacy(node, NR_IRQS_LEGACY, 0, 0,
+					     &pci_irq_domain_ops, NULL);
 	if (pci_irq_host == NULL) {
 		printk(KERN_ERR "pci_irq_host: failed to allocate irq domain!\n");
 		return;
diff --git a/arch/powerpc/sysdev/xics/icp-hv.c b/arch/powerpc/sysdev/xics/icp-hv.c
index 21b9d1bf39ff..6765d9e264a3 100644
--- a/arch/powerpc/sysdev/xics/icp-hv.c
+++ b/arch/powerpc/sysdev/xics/icp-hv.c
@@ -7,6 +7,7 @@
 #include <linux/irq.h>
 #include <linux/smp.h>
 #include <linux/interrupt.h>
+#include <linux/irqdomain.h>
 #include <linux/cpu.h>
 #include <linux/of.h>
 
diff --git a/arch/powerpc/sysdev/xics/icp-opal.c b/arch/powerpc/sysdev/xics/icp-opal.c
index 68fd2540b093..675d708863d5 100644
--- a/arch/powerpc/sysdev/xics/icp-opal.c
+++ b/arch/powerpc/sysdev/xics/icp-opal.c
@@ -7,6 +7,7 @@
 #include <linux/irq.h>
 #include <linux/smp.h>
 #include <linux/interrupt.h>
+#include <linux/irqdomain.h>
 #include <linux/cpu.h>
 #include <linux/of.h>
 
diff --git a/arch/powerpc/sysdev/xics/xics-common.c b/arch/powerpc/sysdev/xics/xics-common.c
index 7e4305c01bac..fdf8db4444b6 100644
--- a/arch/powerpc/sysdev/xics/xics-common.c
+++ b/arch/powerpc/sysdev/xics/xics-common.c
@@ -201,7 +201,7 @@ void xics_migrate_irqs_away(void)
 		struct ics *ics;
 
 		/* We can't set affinity on ISA interrupts */
-		if (virq < NUM_ISA_INTERRUPTS)
+		if (virq < NR_IRQS_LEGACY)
 			continue;
 		/* We only need to migrate enabled IRQS */
 		if (!desc->action)
diff --git a/arch/powerpc/sysdev/xive/Kconfig b/arch/powerpc/sysdev/xive/Kconfig
index 785c292d104b..97796c6b63f0 100644
--- a/arch/powerpc/sysdev/xive/Kconfig
+++ b/arch/powerpc/sysdev/xive/Kconfig
@@ -3,6 +3,7 @@ config PPC_XIVE
 	bool
 	select PPC_SMP_MUXED_IPI
 	select HARDIRQS_SW_RESEND
+	select IRQ_DOMAIN_NOMAP
 
 config PPC_XIVE_NATIVE
 	bool
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 62543a4eccc0..4d5924e9f766 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -415,7 +415,7 @@ config GOLDFISH_PIC
          for Goldfish based virtual platforms.
 
 config QCOM_PDC
-	bool "QCOM PDC"
+	tristate "QCOM PDC"
 	depends on ARCH_QCOM
 	select IRQ_DOMAIN_HIERARCHY
 	help
diff --git a/drivers/irqchip/exynos-combiner.c b/drivers/irqchip/exynos-combiner.c
index 0b85d9a3fbff..552aa04ff063 100644
--- a/drivers/irqchip/exynos-combiner.c
+++ b/drivers/irqchip/exynos-combiner.c
@@ -66,8 +66,9 @@ static void combiner_handle_cascade_irq(struct irq_desc *desc)
 {
 	struct combiner_chip_data *chip_data = irq_desc_get_handler_data(desc);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
-	unsigned int cascade_irq, combiner_irq;
+	unsigned int combiner_irq;
 	unsigned long status;
+	int ret;
 
 	chained_irq_enter(chip, desc);
 
@@ -80,12 +81,9 @@ static void combiner_handle_cascade_irq(struct irq_desc *desc)
 		goto out;
 
 	combiner_irq = chip_data->hwirq_offset + __ffs(status);
-	cascade_irq = irq_find_mapping(combiner_irq_domain, combiner_irq);
-
-	if (unlikely(!cascade_irq))
+	ret = generic_handle_domain_irq(combiner_irq_domain, combiner_irq);
+	if (unlikely(ret))
 		handle_bad_irq(desc);
-	else
-		generic_handle_irq(cascade_irq);
 
  out:
 	chained_irq_exit(chip, desc);
@@ -179,10 +177,8 @@ static void __init combiner_init(void __iomem *combiner_base,
 	nr_irq = max_nr * IRQ_IN_COMBINER;
 
 	combiner_data = kcalloc(max_nr, sizeof (*combiner_data), GFP_KERNEL);
-	if (!combiner_data) {
-		pr_warn("%s: could not allocate combiner data\n", __func__);
+	if (!combiner_data)
 		return;
-	}
 
 	combiner_irq_domain = irq_domain_add_linear(np, nr_irq,
 				&combiner_irq_domain_ops, combiner_data);
diff --git a/drivers/irqchip/irq-al-fic.c b/drivers/irqchip/irq-al-fic.c
index 0b0a73739756..886de028a901 100644
--- a/drivers/irqchip/irq-al-fic.c
+++ b/drivers/irqchip/irq-al-fic.c
@@ -111,7 +111,6 @@ static void al_fic_irq_handler(struct irq_desc *desc)
 	struct irq_chip *irqchip = irq_desc_get_chip(desc);
 	struct irq_chip_generic *gc = irq_get_domain_generic_chip(domain, 0);
 	unsigned long pending;
-	unsigned int irq;
 	u32 hwirq;
 
 	chained_irq_enter(irqchip, desc);
@@ -119,10 +118,8 @@ static void al_fic_irq_handler(struct irq_desc *desc)
 	pending = readl_relaxed(fic->base + AL_FIC_CAUSE);
 	pending &= ~gc->mask_cache;
 
-	for_each_set_bit(hwirq, &pending, NR_FIC_IRQS) {
-		irq = irq_find_mapping(domain, hwirq);
-		generic_handle_irq(irq);
-	}
+	for_each_set_bit(hwirq, &pending, NR_FIC_IRQS)
+		generic_handle_domain_irq(domain, hwirq);
 
 	chained_irq_exit(irqchip, desc);
 }
diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
index 32938dfc0e46..7557ab551295 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -582,20 +582,19 @@ static void armada_370_xp_handle_msi_irq(struct pt_regs *regs, bool is_chained)
 
 	for (msinr = PCI_MSI_DOORBELL_START;
 	     msinr < PCI_MSI_DOORBELL_END; msinr++) {
-		int irq;
+		unsigned int irq;
 
 		if (!(msimask & BIT(msinr)))
 			continue;
 
-		if (is_chained) {
-			irq = irq_find_mapping(armada_370_xp_msi_inner_domain,
-					       msinr - PCI_MSI_DOORBELL_START);
-			generic_handle_irq(irq);
-		} else {
-			irq = msinr - PCI_MSI_DOORBELL_START;
+		irq = msinr - PCI_MSI_DOORBELL_START;
+
+		if (is_chained)
+			generic_handle_domain_irq(armada_370_xp_msi_inner_domain,
+						  irq);
+		else
 			handle_domain_irq(armada_370_xp_msi_inner_domain,
 					  irq, regs);
-		}
 	}
 }
 #else
@@ -606,7 +605,6 @@ static void armada_370_xp_mpic_handle_cascade_irq(struct irq_desc *desc)
 {
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	unsigned long irqmap, irqn, irqsrc, cpuid;
-	unsigned int cascade_irq;
 
 	chained_irq_enter(chip, desc);
 
@@ -628,8 +626,7 @@ static void armada_370_xp_mpic_handle_cascade_irq(struct irq_desc *desc)
 			continue;
 		}
 
-		cascade_irq = irq_find_mapping(armada_370_xp_mpic_domain, irqn);
-		generic_handle_irq(cascade_irq);
+		generic_handle_domain_irq(armada_370_xp_mpic_domain, irqn);
 	}
 
 	chained_irq_exit(chip, desc);
diff --git a/drivers/irqchip/irq-aspeed-i2c-ic.c b/drivers/irqchip/irq-aspeed-i2c-ic.c
index 8d591c179f81..a47db16ff960 100644
--- a/drivers/irqchip/irq-aspeed-i2c-ic.c
+++ b/drivers/irqchip/irq-aspeed-i2c-ic.c
@@ -34,14 +34,12 @@ static void aspeed_i2c_ic_irq_handler(struct irq_desc *desc)
 	struct aspeed_i2c_ic *i2c_ic = irq_desc_get_handler_data(desc);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	unsigned long bit, status;
-	unsigned int bus_irq;
 
 	chained_irq_enter(chip, desc);
 	status = readl(i2c_ic->base);
-	for_each_set_bit(bit, &status, ASPEED_I2C_IC_NUM_BUS) {
-		bus_irq = irq_find_mapping(i2c_ic->irq_domain, bit);
-		generic_handle_irq(bus_irq);
-	}
+	for_each_set_bit(bit, &status, ASPEED_I2C_IC_NUM_BUS)
+		generic_handle_domain_irq(i2c_ic->irq_domain, bit);
+
 	chained_irq_exit(chip, desc);
 }
 
diff --git a/drivers/irqchip/irq-aspeed-scu-ic.c b/drivers/irqchip/irq-aspeed-scu-ic.c
index c90a3346b985..f3c6855a4cef 100644
--- a/drivers/irqchip/irq-aspeed-scu-ic.c
+++ b/drivers/irqchip/irq-aspeed-scu-ic.c
@@ -44,7 +44,6 @@ struct aspeed_scu_ic {
 
 static void aspeed_scu_ic_irq_handler(struct irq_desc *desc)
 {
-	unsigned int irq;
 	unsigned int sts;
 	unsigned long bit;
 	unsigned long enabled;
@@ -74,9 +73,8 @@ static void aspeed_scu_ic_irq_handler(struct irq_desc *desc)
 	max = scu_ic->num_irqs + bit;
 
 	for_each_set_bit_from(bit, &status, max) {
-		irq = irq_find_mapping(scu_ic->irq_domain,
-				       bit - scu_ic->irq_shift);
-		generic_handle_irq(irq);
+		generic_handle_domain_irq(scu_ic->irq_domain,
+					  bit - scu_ic->irq_shift);
 
 		regmap_update_bits(scu_ic->scu, scu_ic->reg, mask,
 				   BIT(bit + ASPEED_SCU_IC_STATUS_SHIFT));
diff --git a/drivers/irqchip/irq-ath79-misc.c b/drivers/irqchip/irq-ath79-misc.c
index 3d641bb6f3f1..92f001a5ff8d 100644
--- a/drivers/irqchip/irq-ath79-misc.c
+++ b/drivers/irqchip/irq-ath79-misc.c
@@ -50,7 +50,7 @@ static void ath79_misc_irq_handler(struct irq_desc *desc)
 	while (pending) {
 		int bit = __ffs(pending);
 
-		generic_handle_irq(irq_linear_revmap(domain, bit));
+		generic_handle_domain_irq(domain, bit);
 		pending &= ~BIT(bit);
 	}
 
diff --git a/drivers/irqchip/irq-bcm2835.c b/drivers/irqchip/irq-bcm2835.c
index a1e004af23e7..adc1556ed332 100644
--- a/drivers/irqchip/irq-bcm2835.c
+++ b/drivers/irqchip/irq-bcm2835.c
@@ -254,7 +254,7 @@ static void bcm2836_chained_handle_irq(struct irq_desc *desc)
 	u32 hwirq;
 
 	while ((hwirq = get_next_armctrl_hwirq()) != ~0)
-		generic_handle_irq(irq_linear_revmap(intc.domain, hwirq));
+		generic_handle_domain_irq(intc.domain, hwirq);
 }
 
 IRQCHIP_DECLARE(bcm2835_armctrl_ic, "brcm,bcm2835-armctrl-ic",
diff --git a/drivers/irqchip/irq-bcm2836.c b/drivers/irqchip/irq-bcm2836.c
index 25c9a9c06e41..501facdb4570 100644
--- a/drivers/irqchip/irq-bcm2836.c
+++ b/drivers/irqchip/irq-bcm2836.c
@@ -161,7 +161,7 @@ static void bcm2836_arm_irqchip_handle_ipi(struct irq_desc *desc)
 	mbox_val = readl_relaxed(intc.base + LOCAL_MAILBOX0_CLR0 + 16 * cpu);
 	if (mbox_val) {
 		int hwirq = ffs(mbox_val) - 1;
-		generic_handle_irq(irq_find_mapping(ipi_domain, hwirq));
+		generic_handle_domain_irq(ipi_domain, hwirq);
 	}
 
 	chained_irq_exit(chip, desc);
diff --git a/drivers/irqchip/irq-bcm7038-l1.c b/drivers/irqchip/irq-bcm7038-l1.c
index 9dc9bf8cdcc4..a035c385ca7a 100644
--- a/drivers/irqchip/irq-bcm7038-l1.c
+++ b/drivers/irqchip/irq-bcm7038-l1.c
@@ -145,10 +145,8 @@ static void bcm7038_l1_irq_handle(struct irq_desc *desc)
 			  ~cpu->mask_cache[idx];
 		raw_spin_unlock_irqrestore(&intc->lock, flags);
 
-		for_each_set_bit(hwirq, &pending, IRQS_PER_WORD) {
-			generic_handle_irq(irq_find_mapping(intc->domain,
-							    base + hwirq));
-		}
+		for_each_set_bit(hwirq, &pending, IRQS_PER_WORD)
+			generic_handle_domain_irq(intc->domain, base + hwirq);
 	}
 
 	chained_irq_exit(chip, desc);
diff --git a/drivers/irqchip/irq-bcm7120-l2.c b/drivers/irqchip/irq-bcm7120-l2.c
index ad59656ccc28..f23d7651ea84 100644
--- a/drivers/irqchip/irq-bcm7120-l2.c
+++ b/drivers/irqchip/irq-bcm7120-l2.c
@@ -74,10 +74,8 @@ static void bcm7120_l2_intc_irq_handle(struct irq_desc *desc)
 					    data->irq_map_mask[idx];
 		irq_gc_unlock(gc);
 
-		for_each_set_bit(hwirq, &pending, IRQS_PER_WORD) {
-			generic_handle_irq(irq_find_mapping(b->domain,
-					   base + hwirq));
-		}
+		for_each_set_bit(hwirq, &pending, IRQS_PER_WORD)
+			generic_handle_domain_irq(b->domain, base + hwirq);
 	}
 
 	chained_irq_exit(chip, desc);
diff --git a/drivers/irqchip/irq-brcmstb-l2.c b/drivers/irqchip/irq-brcmstb-l2.c
index cdd6a42d4efa..8e0911561f2d 100644
--- a/drivers/irqchip/irq-brcmstb-l2.c
+++ b/drivers/irqchip/irq-brcmstb-l2.c
@@ -110,7 +110,7 @@ static void brcmstb_l2_intc_irq_handle(struct irq_desc *desc)
 	do {
 		irq = ffs(status) - 1;
 		status &= ~(1 << irq);
-		generic_handle_irq(irq_linear_revmap(b->domain, irq));
+		generic_handle_domain_irq(b->domain, irq);
 	} while (status);
 out:
 	chained_irq_exit(chip, desc);
diff --git a/drivers/irqchip/irq-dw-apb-ictl.c b/drivers/irqchip/irq-dw-apb-ictl.c
index 54b09d6c407c..a67266e44491 100644
--- a/drivers/irqchip/irq-dw-apb-ictl.c
+++ b/drivers/irqchip/irq-dw-apb-ictl.c
@@ -62,9 +62,8 @@ static void dw_apb_ictl_handle_irq_cascaded(struct irq_desc *desc)
 
 		while (stat) {
 			u32 hwirq = ffs(stat) - 1;
-			u32 virq = irq_find_mapping(d, gc->irq_base + hwirq);
+			generic_handle_domain_irq(d, gc->irq_base + hwirq);
 
-			generic_handle_irq(virq);
 			stat &= ~BIT(hwirq);
 		}
 	}
diff --git a/drivers/irqchip/irq-gic-pm.c b/drivers/irqchip/irq-gic-pm.c
index 1337ceceb59b..b60e1853593f 100644
--- a/drivers/irqchip/irq-gic-pm.c
+++ b/drivers/irqchip/irq-gic-pm.c
@@ -30,10 +30,8 @@ static int gic_runtime_resume(struct device *dev)
 	int ret;
 
 	ret = clk_bulk_prepare_enable(data->num_clocks, chip_pm->clks);
-	if (ret) {
-		dev_err(dev, "clk_enable failed: %d\n", ret);
+	if (ret)
 		return ret;
-	}
 
 	/*
 	 * On the very first resume, the pointer to chip_pm->chip_data
diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index 4116b48e60af..be9ea6fd6f8b 100644
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -323,10 +323,8 @@ static int __init gicv2m_init_one(struct fwnode_handle *fwnode,
 	struct v2m_data *v2m;
 
 	v2m = kzalloc(sizeof(struct v2m_data), GFP_KERNEL);
-	if (!v2m) {
-		pr_err("Failed to allocate struct v2m_data.\n");
+	if (!v2m)
 		return -ENOMEM;
-	}
 
 	INIT_LIST_HEAD(&v2m->entry);
 	v2m->fwnode = fwnode;
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 2e6923c2c8a8..ba39668c3e08 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -4895,10 +4895,8 @@ static int its_init_vpe_domain(void)
 	entries = roundup_pow_of_two(nr_cpu_ids);
 	vpe_proxy.vpes = kcalloc(entries, sizeof(*vpe_proxy.vpes),
 				 GFP_KERNEL);
-	if (!vpe_proxy.vpes) {
-		pr_err("ITS: Can't allocate GICv4 proxy device array\n");
+	if (!vpe_proxy.vpes)
 		return -ENOMEM;
-	}
 
 	/* Use the last possible DevID */
 	devid = GENMASK(device_ids(its) - 1, 0);
@@ -5314,10 +5312,8 @@ static void __init acpi_table_parse_srat_its(void)
 
 	its_srat_maps = kmalloc_array(count, sizeof(struct its_srat_map),
 				      GFP_KERNEL);
-	if (!its_srat_maps) {
-		pr_warn("SRAT: Failed to allocate memory for its_srat_maps!\n");
+	if (!its_srat_maps)
 		return;
-	}
 
 	acpi_table_parse_entries(ACPI_SIG_SRAT,
 			sizeof(struct acpi_table_srat),
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index b1d9c22caf2e..46c9c5fafdbc 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -375,8 +375,9 @@ static void gic_handle_cascade_irq(struct irq_desc *desc)
 {
 	struct gic_chip_data *chip_data = irq_desc_get_handler_data(desc);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
-	unsigned int cascade_irq, gic_irq;
+	unsigned int gic_irq;
 	unsigned long status;
+	int ret;
 
 	chained_irq_enter(chip, desc);
 
@@ -386,14 +387,10 @@ static void gic_handle_cascade_irq(struct irq_desc *desc)
 	if (gic_irq == GICC_INT_SPURIOUS)
 		goto out;
 
-	cascade_irq = irq_find_mapping(chip_data->domain, gic_irq);
-	if (unlikely(gic_irq < 32 || gic_irq > 1020)) {
+	isb();
+	ret = generic_handle_domain_irq(chip_data->domain, gic_irq);
+	if (unlikely(ret))
 		handle_bad_irq(desc);
-	} else {
-		isb();
-		generic_handle_irq(cascade_irq);
-	}
-
  out:
 	chained_irq_exit(chip, desc);
 }
diff --git a/drivers/irqchip/irq-goldfish-pic.c b/drivers/irqchip/irq-goldfish-pic.c
index 4f021530e7f3..513f6edbbe95 100644
--- a/drivers/irqchip/irq-goldfish-pic.c
+++ b/drivers/irqchip/irq-goldfish-pic.c
@@ -34,15 +34,14 @@ static void goldfish_pic_cascade(struct irq_desc *desc)
 {
 	struct goldfish_pic_data *gfpic = irq_desc_get_handler_data(desc);
 	struct irq_chip *host_chip = irq_desc_get_chip(desc);
-	u32 pending, hwirq, virq;
+	u32 pending, hwirq;
 
 	chained_irq_enter(host_chip, desc);
 
 	pending = readl(gfpic->base + GFPIC_REG_IRQ_PENDING);
 	while (pending) {
 		hwirq = __fls(pending);
-		virq = irq_linear_revmap(gfpic->irq_domain, hwirq);
-		generic_handle_irq(virq);
+		generic_handle_domain_irq(gfpic->irq_domain, hwirq);
 		pending &= ~(1 << hwirq);
 	}
 
diff --git a/drivers/irqchip/irq-i8259.c b/drivers/irqchip/irq-i8259.c
index b6f6aa7b2862..b70ce0d3c092 100644
--- a/drivers/irqchip/irq-i8259.c
+++ b/drivers/irqchip/irq-i8259.c
@@ -333,13 +333,11 @@ static void i8259_irq_dispatch(struct irq_desc *desc)
 {
 	struct irq_domain *domain = irq_desc_get_handler_data(desc);
 	int hwirq = i8259_poll();
-	unsigned int irq;
 
 	if (hwirq < 0)
 		return;
 
-	irq = irq_linear_revmap(domain, hwirq);
-	generic_handle_irq(irq);
+	generic_handle_domain_irq(domain, hwirq);
 }
 
 int __init i8259_of_init(struct device_node *node, struct device_node *parent)
diff --git a/drivers/irqchip/irq-idt3243x.c b/drivers/irqchip/irq-idt3243x.c
index f0996820077a..0732a0e9af62 100644
--- a/drivers/irqchip/irq-idt3243x.c
+++ b/drivers/irqchip/irq-idt3243x.c
@@ -28,7 +28,7 @@ static void idt_irq_dispatch(struct irq_desc *desc)
 {
 	struct idt_pic_data *idtpic = irq_desc_get_handler_data(desc);
 	struct irq_chip *host_chip = irq_desc_get_chip(desc);
-	u32 pending, hwirq, virq;
+	u32 pending, hwirq;
 
 	chained_irq_enter(host_chip, desc);
 
@@ -36,9 +36,7 @@ static void idt_irq_dispatch(struct irq_desc *desc)
 	pending &= ~idtpic->gc->mask_cache;
 	while (pending) {
 		hwirq = __fls(pending);
-		virq = irq_linear_revmap(idtpic->irq_domain, hwirq);
-		if (virq)
-			generic_handle_irq(virq);
+		generic_handle_domain_irq(idtpic->irq_domain, hwirq);
 		pending &= ~(1 << hwirq);
 	}
 
diff --git a/drivers/irqchip/irq-imgpdc.c b/drivers/irqchip/irq-imgpdc.c
index 698d07f48fed..5831be454673 100644
--- a/drivers/irqchip/irq-imgpdc.c
+++ b/drivers/irqchip/irq-imgpdc.c
@@ -223,7 +223,7 @@ static void pdc_intc_perip_isr(struct irq_desc *desc)
 {
 	unsigned int irq = irq_desc_get_irq(desc);
 	struct pdc_intc_priv *priv;
-	unsigned int i, irq_no;
+	unsigned int i;
 
 	priv = (struct pdc_intc_priv *)irq_desc_get_handler_data(desc);
 
@@ -237,14 +237,13 @@ static void pdc_intc_perip_isr(struct irq_desc *desc)
 found:
 
 	/* pass on the interrupt */
-	irq_no = irq_linear_revmap(priv->domain, i);
-	generic_handle_irq(irq_no);
+	generic_handle_domain_irq(priv->domain, i);
 }
 
 static void pdc_intc_syswake_isr(struct irq_desc *desc)
 {
 	struct pdc_intc_priv *priv;
-	unsigned int syswake, irq_no;
+	unsigned int syswake;
 	unsigned int status;
 
 	priv = (struct pdc_intc_priv *)irq_desc_get_handler_data(desc);
@@ -258,9 +257,7 @@ static void pdc_intc_syswake_isr(struct irq_desc *desc)
 		if (!(status & 1))
 			continue;
 
-		irq_no = irq_linear_revmap(priv->domain,
-					   syswake_to_hwirq(syswake));
-		generic_handle_irq(irq_no);
+		generic_handle_domain_irq(priv->domain, syswake_to_hwirq(syswake));
 	}
 }
 
@@ -316,10 +313,8 @@ static int pdc_intc_probe(struct platform_device *pdev)
 
 	/* Allocate driver data */
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv) {
-		dev_err(&pdev->dev, "cannot allocate device data\n");
+	if (!priv)
 		return -ENOMEM;
-	}
 	raw_spin_lock_init(&priv->lock);
 	platform_set_drvdata(pdev, priv);
 
@@ -356,10 +351,8 @@ static int pdc_intc_probe(struct platform_device *pdev)
 	/* Get peripheral IRQ numbers */
 	priv->perip_irqs = devm_kcalloc(&pdev->dev, 4, priv->nr_perips,
 					GFP_KERNEL);
-	if (!priv->perip_irqs) {
-		dev_err(&pdev->dev, "cannot allocate perip IRQ list\n");
+	if (!priv->perip_irqs)
 		return -ENOMEM;
-	}
 	for (i = 0; i < priv->nr_perips; ++i) {
 		irq = platform_get_irq(pdev, 1 + i);
 		if (irq < 0)
diff --git a/drivers/irqchip/irq-imx-gpcv2.c b/drivers/irqchip/irq-imx-gpcv2.c
index 7031ef44de4f..5b5a365dbd5e 100644
--- a/drivers/irqchip/irq-imx-gpcv2.c
+++ b/drivers/irqchip/irq-imx-gpcv2.c
@@ -228,10 +228,8 @@ static int __init imx_gpcv2_irqchip_init(struct device_node *node,
 	}
 
 	cd = kzalloc(sizeof(struct gpcv2_irqchip_data), GFP_KERNEL);
-	if (!cd) {
-		pr_err("%pOF: kzalloc failed!\n", node);
+	if (!cd)
 		return -ENOMEM;
-	}
 
 	raw_spin_lock_init(&cd->rlock);
 
diff --git a/drivers/irqchip/irq-imx-intmux.c b/drivers/irqchip/irq-imx-intmux.c
index 7709f9712cb3..e86ff743e98c 100644
--- a/drivers/irqchip/irq-imx-intmux.c
+++ b/drivers/irqchip/irq-imx-intmux.c
@@ -182,18 +182,15 @@ static void imx_intmux_irq_handler(struct irq_desc *desc)
 	struct intmux_data *data = container_of(irqchip_data, struct intmux_data,
 						irqchip_data[idx]);
 	unsigned long irqstat;
-	int pos, virq;
+	int pos;
 
 	chained_irq_enter(irq_desc_get_chip(desc), desc);
 
 	/* read the interrupt source pending status of this channel */
 	irqstat = readl_relaxed(data->regs + CHANIPR(idx));
 
-	for_each_set_bit(pos, &irqstat, 32) {
-		virq = irq_find_mapping(irqchip_data->domain, pos);
-		if (virq)
-			generic_handle_irq(virq);
-	}
+	for_each_set_bit(pos, &irqstat, 32)
+		generic_handle_domain_irq(irqchip_data->domain, pos);
 
 	chained_irq_exit(irq_desc_get_chip(desc), desc);
 }
diff --git a/drivers/irqchip/irq-imx-irqsteer.c b/drivers/irqchip/irq-imx-irqsteer.c
index 1edf7692a790..8d91a02593fc 100644
--- a/drivers/irqchip/irq-imx-irqsteer.c
+++ b/drivers/irqchip/irq-imx-irqsteer.c
@@ -122,7 +122,7 @@ static void imx_irqsteer_irq_handler(struct irq_desc *desc)
 	for (i = 0; i < 2; i++, hwirq += 32) {
 		int idx = imx_irqsteer_get_reg_index(data, hwirq);
 		unsigned long irqmap;
-		int pos, virq;
+		int pos;
 
 		if (hwirq >= data->reg_num * 32)
 			break;
@@ -130,11 +130,8 @@ static void imx_irqsteer_irq_handler(struct irq_desc *desc)
 		irqmap = readl_relaxed(data->regs +
 				       CHANSTATUS(idx, data->reg_num));
 
-		for_each_set_bit(pos, &irqmap, 32) {
-			virq = irq_find_mapping(data->domain, pos + hwirq);
-			if (virq)
-				generic_handle_irq(virq);
-		}
+		for_each_set_bit(pos, &irqmap, 32)
+			generic_handle_domain_irq(data->domain, pos + hwirq);
 	}
 
 	chained_irq_exit(irq_desc_get_chip(desc), desc);
diff --git a/drivers/irqchip/irq-ingenic-tcu.c b/drivers/irqchip/irq-ingenic-tcu.c
index b938d1d04d96..34a7d261b710 100644
--- a/drivers/irqchip/irq-ingenic-tcu.c
+++ b/drivers/irqchip/irq-ingenic-tcu.c
@@ -38,7 +38,7 @@ static void ingenic_tcu_intc_cascade(struct irq_desc *desc)
 	irq_reg &= ~irq_mask;
 
 	for_each_set_bit(i, (unsigned long *)&irq_reg, 32)
-		generic_handle_irq(irq_linear_revmap(domain, i));
+		generic_handle_domain_irq(domain, i);
 
 	chained_irq_exit(irq_chip, desc);
 }
diff --git a/drivers/irqchip/irq-ingenic.c b/drivers/irqchip/irq-ingenic.c
index ea36bb00be80..cee839ca627e 100644
--- a/drivers/irqchip/irq-ingenic.c
+++ b/drivers/irqchip/irq-ingenic.c
@@ -49,8 +49,7 @@ static irqreturn_t intc_cascade(int irq, void *data)
 		while (pending) {
 			int bit = __fls(pending);
 
-			irq = irq_linear_revmap(domain, bit + (i * 32));
-			generic_handle_irq(irq);
+			generic_handle_domain_irq(domain, bit + (i * 32));
 			pending &= ~BIT(bit);
 		}
 	}
diff --git a/drivers/irqchip/irq-keystone.c b/drivers/irqchip/irq-keystone.c
index 8118ebe80b09..d47c8041e5bc 100644
--- a/drivers/irqchip/irq-keystone.c
+++ b/drivers/irqchip/irq-keystone.c
@@ -89,7 +89,7 @@ static irqreturn_t keystone_irq_handler(int irq, void *keystone_irq)
 	struct keystone_irq_device *kirq = keystone_irq;
 	unsigned long wa_lock_flags;
 	unsigned long pending;
-	int src, virq;
+	int src, err;
 
 	dev_dbg(kirq->dev, "start irq %d\n", irq);
 
@@ -104,16 +104,14 @@ static irqreturn_t keystone_irq_handler(int irq, void *keystone_irq)
 
 	for (src = 0; src < KEYSTONE_N_IRQ; src++) {
 		if (BIT(src) & pending) {
-			virq = irq_find_mapping(kirq->irqd, src);
-			dev_dbg(kirq->dev, "dispatch bit %d, virq %d\n",
-				src, virq);
-			if (!virq)
-				dev_warn(kirq->dev, "spurious irq detected hwirq %d, virq %d\n",
-					 src, virq);
 			raw_spin_lock_irqsave(&kirq->wa_lock, wa_lock_flags);
-			generic_handle_irq(virq);
+			err = generic_handle_domain_irq(kirq->irqd, src);
 			raw_spin_unlock_irqrestore(&kirq->wa_lock,
 						   wa_lock_flags);
+
+			if (err)
+				dev_warn_ratelimited(kirq->dev, "spurious irq detected hwirq %d\n",
+						     src);
 		}
 	}
 
diff --git a/drivers/irqchip/irq-loongson-htpic.c b/drivers/irqchip/irq-loongson-htpic.c
index 1b801c4fb026..f4abdf156de7 100644
--- a/drivers/irqchip/irq-loongson-htpic.c
+++ b/drivers/irqchip/irq-loongson-htpic.c
@@ -48,7 +48,7 @@ static void htpic_irq_dispatch(struct irq_desc *desc)
 			break;
 		}
 
-		generic_handle_irq(irq_linear_revmap(priv->domain, bit));
+		generic_handle_domain_irq(priv->domain, bit);
 		pending &= ~BIT(bit);
 	}
 	chained_irq_exit(chip, desc);
diff --git a/drivers/irqchip/irq-loongson-htvec.c b/drivers/irqchip/irq-loongson-htvec.c
index 6392aafb9a63..60a335d7e64e 100644
--- a/drivers/irqchip/irq-loongson-htvec.c
+++ b/drivers/irqchip/irq-loongson-htvec.c
@@ -47,8 +47,8 @@ static void htvec_irq_dispatch(struct irq_desc *desc)
 		while (pending) {
 			int bit = __ffs(pending);
 
-			generic_handle_irq(irq_linear_revmap(priv->htvec_domain, bit +
-							     VEC_COUNT_PER_REG * i));
+			generic_handle_domain_irq(priv->htvec_domain,
+						  bit + VEC_COUNT_PER_REG * i);
 			pending &= ~BIT(bit);
 			handled = true;
 		}
diff --git a/drivers/irqchip/irq-loongson-liointc.c b/drivers/irqchip/irq-loongson-liointc.c
index 8ccb30421806..649c58391618 100644
--- a/drivers/irqchip/irq-loongson-liointc.c
+++ b/drivers/irqchip/irq-loongson-liointc.c
@@ -73,7 +73,7 @@ static void liointc_chained_handle_irq(struct irq_desc *desc)
 	while (pending) {
 		int bit = __ffs(pending);
 
-		generic_handle_irq(irq_find_mapping(gc->domain, bit));
+		generic_handle_domain_irq(gc->domain, bit);
 		pending &= ~BIT(bit);
 	}
 
diff --git a/drivers/irqchip/irq-lpc32xx.c b/drivers/irqchip/irq-lpc32xx.c
index 7d9b388afe64..5e6f6e25f2ae 100644
--- a/drivers/irqchip/irq-lpc32xx.c
+++ b/drivers/irqchip/irq-lpc32xx.c
@@ -141,7 +141,7 @@ static void lpc32xx_sic_handler(struct irq_desc *desc)
 	while (hwirq) {
 		irq = __ffs(hwirq);
 		hwirq &= ~BIT(irq);
-		generic_handle_irq(irq_find_mapping(ic->domain, irq));
+		generic_handle_domain_irq(ic->domain, irq);
 	}
 
 	chained_irq_exit(chip, desc);
diff --git a/drivers/irqchip/irq-ls-scfg-msi.c b/drivers/irqchip/irq-ls-scfg-msi.c
index 61dbfda08527..55322da51c56 100644
--- a/drivers/irqchip/irq-ls-scfg-msi.c
+++ b/drivers/irqchip/irq-ls-scfg-msi.c
@@ -194,7 +194,7 @@ static void ls_scfg_msi_irq_handler(struct irq_desc *desc)
 	struct ls_scfg_msir *msir = irq_desc_get_handler_data(desc);
 	struct ls_scfg_msi *msi_data = msir->msi_data;
 	unsigned long val;
-	int pos, size, virq, hwirq;
+	int pos, size, hwirq;
 
 	chained_irq_enter(irq_desc_get_chip(desc), desc);
 
@@ -206,9 +206,7 @@ static void ls_scfg_msi_irq_handler(struct irq_desc *desc)
 	for_each_set_bit_from(pos, &val, size) {
 		hwirq = ((msir->bit_end - pos) << msi_data->cfg->ibs_shift) |
 			msir->srs;
-		virq = irq_find_mapping(msi_data->parent, hwirq);
-		if (virq)
-			generic_handle_irq(virq);
+		generic_handle_domain_irq(msi_data->parent, hwirq);
 	}
 
 	chained_irq_exit(irq_desc_get_chip(desc), desc);
diff --git a/drivers/irqchip/irq-ls1x.c b/drivers/irqchip/irq-ls1x.c
index 353111a10413..77a3f7dfaaf0 100644
--- a/drivers/irqchip/irq-ls1x.c
+++ b/drivers/irqchip/irq-ls1x.c
@@ -50,7 +50,7 @@ static void ls1x_chained_handle_irq(struct irq_desc *desc)
 	while (pending) {
 		int bit = __ffs(pending);
 
-		generic_handle_irq(irq_find_mapping(priv->domain, bit));
+		generic_handle_domain_irq(priv->domain, bit);
 		pending &= ~BIT(bit);
 	}
 
diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
index 2cb45c6b8501..f565317a3da3 100644
--- a/drivers/irqchip/irq-mbigen.c
+++ b/drivers/irqchip/irq-mbigen.c
@@ -273,6 +273,12 @@ static int mbigen_of_create_domain(struct platform_device *pdev,
 }
 
 #ifdef CONFIG_ACPI
+static const struct acpi_device_id mbigen_acpi_match[] = {
+	{ "HISI0152", 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, mbigen_acpi_match);
+
 static int mbigen_acpi_create_domain(struct platform_device *pdev,
 				     struct mbigen_device *mgn_chip)
 {
@@ -369,12 +375,6 @@ static const struct of_device_id mbigen_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, mbigen_of_match);
 
-static const struct acpi_device_id mbigen_acpi_match[] = {
-	{ "HISI0152", 0 },
-	{}
-};
-MODULE_DEVICE_TABLE(acpi, mbigen_acpi_match);
-
 static struct platform_driver mbigen_platform_driver = {
 	.driver = {
 		.name		= "Hisilicon MBIGEN-V2",
diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index 215885962bb0..b146e069bf5b 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -16,6 +16,7 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/irqchip.h>
+#include <linux/irqdomain.h>
 #include <linux/of_address.h>
 #include <linux/percpu.h>
 #include <linux/sched.h>
@@ -147,7 +148,7 @@ int gic_get_c0_fdc_int(void)
 
 static void gic_handle_shared_int(bool chained)
 {
-	unsigned int intr, virq;
+	unsigned int intr;
 	unsigned long *pcpu_mask;
 	DECLARE_BITMAP(pending, GIC_MAX_INTRS);
 
@@ -164,12 +165,12 @@ static void gic_handle_shared_int(bool chained)
 	bitmap_and(pending, pending, pcpu_mask, gic_shared_intrs);
 
 	for_each_set_bit(intr, pending, gic_shared_intrs) {
-		virq = irq_linear_revmap(gic_irq_domain,
-					 GIC_SHARED_TO_HWIRQ(intr));
 		if (chained)
-			generic_handle_irq(virq);
+			generic_handle_domain_irq(gic_irq_domain,
+						  GIC_SHARED_TO_HWIRQ(intr));
 		else
-			do_IRQ(virq);
+			do_IRQ(irq_find_mapping(gic_irq_domain,
+						GIC_SHARED_TO_HWIRQ(intr)));
 	}
 }
 
@@ -307,7 +308,7 @@ static struct irq_chip gic_edge_irq_controller = {
 static void gic_handle_local_int(bool chained)
 {
 	unsigned long pending, masked;
-	unsigned int intr, virq;
+	unsigned int intr;
 
 	pending = read_gic_vl_pend();
 	masked = read_gic_vl_mask();
@@ -315,12 +316,12 @@ static void gic_handle_local_int(bool chained)
 	bitmap_and(&pending, &pending, &masked, GIC_NUM_LOCAL_INTRS);
 
 	for_each_set_bit(intr, &pending, GIC_NUM_LOCAL_INTRS) {
-		virq = irq_linear_revmap(gic_irq_domain,
-					 GIC_LOCAL_TO_HWIRQ(intr));
 		if (chained)
-			generic_handle_irq(virq);
+			generic_handle_domain_irq(gic_irq_domain,
+						  GIC_LOCAL_TO_HWIRQ(intr));
 		else
-			do_IRQ(virq);
+			do_IRQ(irq_find_mapping(gic_irq_domain,
+						GIC_LOCAL_TO_HWIRQ(intr)));
 	}
 }
 
diff --git a/drivers/irqchip/irq-mscc-ocelot.c b/drivers/irqchip/irq-mscc-ocelot.c
index 8235d98650c1..4d0c3532dbe7 100644
--- a/drivers/irqchip/irq-mscc-ocelot.c
+++ b/drivers/irqchip/irq-mscc-ocelot.c
@@ -107,7 +107,7 @@ static void ocelot_irq_handler(struct irq_desc *desc)
 	while (reg) {
 		u32 hwirq = __fls(reg);
 
-		generic_handle_irq(irq_find_mapping(d, hwirq));
+		generic_handle_domain_irq(d, hwirq);
 		reg &= ~(BIT(hwirq));
 	}
 
diff --git a/drivers/irqchip/irq-mvebu-pic.c b/drivers/irqchip/irq-mvebu-pic.c
index eec63951129a..dc1cee4b0fe1 100644
--- a/drivers/irqchip/irq-mvebu-pic.c
+++ b/drivers/irqchip/irq-mvebu-pic.c
@@ -91,15 +91,12 @@ static void mvebu_pic_handle_cascade_irq(struct irq_desc *desc)
 	struct mvebu_pic *pic = irq_desc_get_handler_data(desc);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	unsigned long irqmap, irqn;
-	unsigned int cascade_irq;
 
 	irqmap = readl_relaxed(pic->base + PIC_CAUSE);
 	chained_irq_enter(chip, desc);
 
-	for_each_set_bit(irqn, &irqmap, BITS_PER_LONG) {
-		cascade_irq = irq_find_mapping(pic->domain, irqn);
-		generic_handle_irq(cascade_irq);
-	}
+	for_each_set_bit(irqn, &irqmap, BITS_PER_LONG)
+		generic_handle_domain_irq(pic->domain, irqn);
 
 	chained_irq_exit(chip, desc);
 }
diff --git a/drivers/irqchip/irq-mvebu-sei.c b/drivers/irqchip/irq-mvebu-sei.c
index 3a7b7a7f20ca..4ecef6d83777 100644
--- a/drivers/irqchip/irq-mvebu-sei.c
+++ b/drivers/irqchip/irq-mvebu-sei.c
@@ -337,17 +337,12 @@ static void mvebu_sei_handle_cascade_irq(struct irq_desc *desc)
 		irqmap = readl_relaxed(sei->base + GICP_SECR(idx));
 		for_each_set_bit(bit, &irqmap, SEI_IRQ_COUNT_PER_REG) {
 			unsigned long hwirq;
-			unsigned int virq;
+			int err;
 
 			hwirq = idx * SEI_IRQ_COUNT_PER_REG + bit;
-			virq = irq_find_mapping(sei->sei_domain, hwirq);
-			if (likely(virq)) {
-				generic_handle_irq(virq);
-				continue;
-			}
-
-			dev_warn(sei->dev,
-				 "Spurious IRQ detected (hwirq %lu)\n", hwirq);
+			err = generic_handle_domain_irq(sei->sei_domain, hwirq);
+			if (unlikely(err))
+				dev_warn(sei->dev, "Spurious IRQ detected (hwirq %lu)\n", hwirq);
 		}
 	}
 
diff --git a/drivers/irqchip/irq-nvic.c b/drivers/irqchip/irq-nvic.c
index f747e2209ea9..b31c4cff4d3a 100644
--- a/drivers/irqchip/irq-nvic.c
+++ b/drivers/irqchip/irq-nvic.c
@@ -40,9 +40,7 @@ static struct irq_domain *nvic_irq_domain;
 asmlinkage void __exception_irq_entry
 nvic_handle_irq(irq_hw_number_t hwirq, struct pt_regs *regs)
 {
-	unsigned int irq = irq_linear_revmap(nvic_irq_domain, hwirq);
-
-	handle_IRQ(irq, regs);
+	handle_domain_irq(nvic_irq_domain, hwirq, regs);
 }
 
 static int nvic_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
diff --git a/drivers/irqchip/irq-orion.c b/drivers/irqchip/irq-orion.c
index c4b5ffb61954..b6868f7b805a 100644
--- a/drivers/irqchip/irq-orion.c
+++ b/drivers/irqchip/irq-orion.c
@@ -117,7 +117,7 @@ static void orion_bridge_irq_handler(struct irq_desc *desc)
 	while (stat) {
 		u32 hwirq = __fls(stat);
 
-		generic_handle_irq(irq_find_mapping(d, gc->irq_base + hwirq));
+		generic_handle_domain_irq(d, gc->irq_base + hwirq);
 		stat &= ~(1 << hwirq);
 	}
 }
diff --git a/drivers/irqchip/irq-partition-percpu.c b/drivers/irqchip/irq-partition-percpu.c
index 0c4c8ed7064e..89c23a1566dc 100644
--- a/drivers/irqchip/irq-partition-percpu.c
+++ b/drivers/irqchip/irq-partition-percpu.c
@@ -124,13 +124,10 @@ static void partition_handle_irq(struct irq_desc *desc)
 			break;
 	}
 
-	if (unlikely(hwirq == part->nr_parts)) {
+	if (unlikely(hwirq == part->nr_parts))
 		handle_bad_irq(desc);
-	} else {
-		unsigned int irq;
-		irq = irq_find_mapping(part->domain, hwirq);
-		generic_handle_irq(irq);
-	}
+	else
+		generic_handle_domain_irq(part->domain, hwirq);
 
 	chained_irq_exit(chip, desc);
 }
diff --git a/drivers/irqchip/irq-pruss-intc.c b/drivers/irqchip/irq-pruss-intc.c
index 92fb5780dc10..fa8d89b02ec0 100644
--- a/drivers/irqchip/irq-pruss-intc.c
+++ b/drivers/irqchip/irq-pruss-intc.c
@@ -488,8 +488,7 @@ static void pruss_intc_irq_handler(struct irq_desc *desc)
 
 	while (true) {
 		u32 hipir;
-		unsigned int virq;
-		int hwirq;
+		int hwirq, err;
 
 		/* get highest priority pending PRUSS system event */
 		hipir = pruss_intc_read_reg(intc, PRU_INTC_HIPIR(host_irq));
@@ -497,16 +496,14 @@ static void pruss_intc_irq_handler(struct irq_desc *desc)
 			break;
 
 		hwirq = hipir & GENMASK(9, 0);
-		virq = irq_find_mapping(intc->domain, hwirq);
+		err = generic_handle_domain_irq(intc->domain, hwirq);
 
 		/*
 		 * NOTE: manually ACK any system events that do not have a
 		 * handler mapped yet
 		 */
-		if (WARN_ON_ONCE(!virq))
+		if (WARN_ON_ONCE(err))
 			pruss_intc_write_reg(intc, PRU_INTC_SICR, hwirq);
-		else
-			generic_handle_irq(virq);
 	}
 
 	chained_irq_exit(chip, desc);
diff --git a/drivers/irqchip/irq-realtek-rtl.c b/drivers/irqchip/irq-realtek-rtl.c
index b57c67dfab5b..fd9f275592d2 100644
--- a/drivers/irqchip/irq-realtek-rtl.c
+++ b/drivers/irqchip/irq-realtek-rtl.c
@@ -85,7 +85,7 @@ static void realtek_irq_dispatch(struct irq_desc *desc)
 		goto out;
 	}
 	domain = irq_desc_get_handler_data(desc);
-	generic_handle_irq(irq_find_mapping(domain, __ffs(pending)));
+	generic_handle_domain_irq(domain, __ffs(pending));
 
 out:
 	chained_irq_exit(chip, desc);
diff --git a/drivers/irqchip/irq-renesas-irqc.c b/drivers/irqchip/irq-renesas-irqc.c
index 11abc09ef76c..07a6d8b42b63 100644
--- a/drivers/irqchip/irq-renesas-irqc.c
+++ b/drivers/irqchip/irq-renesas-irqc.c
@@ -115,7 +115,7 @@ static irqreturn_t irqc_irq_handler(int irq, void *dev_id)
 	if (ioread32(p->iomem + DETECT_STATUS) & bit) {
 		iowrite32(bit, p->iomem + DETECT_STATUS);
 		irqc_dbg(i, "demux2");
-		generic_handle_irq(irq_find_mapping(p->irq_domain, i->hw_irq));
+		generic_handle_domain_irq(p->irq_domain, i->hw_irq);
 		return IRQ_HANDLED;
 	}
 	return IRQ_NONE;
diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 97d4d04b0a80..cf74cfa82045 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -233,13 +233,11 @@ static void plic_handle_irq(struct irq_desc *desc)
 	chained_irq_enter(chip, desc);
 
 	while ((hwirq = readl(claim))) {
-		int irq = irq_find_mapping(handler->priv->irqdomain, hwirq);
-
-		if (unlikely(irq <= 0))
+		int err = generic_handle_domain_irq(handler->priv->irqdomain,
+						    hwirq);
+		if (unlikely(err))
 			pr_warn_ratelimited("can't find mapping for hwirq %lu\n",
 					hwirq);
-		else
-			generic_handle_irq(irq);
 	}
 
 	chained_irq_exit(chip, desc);
diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index 4704f2ee5797..33c76710f845 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -257,7 +257,7 @@ static void stm32_irq_handler(struct irq_desc *desc)
 {
 	struct irq_domain *domain = irq_desc_get_handler_data(desc);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
-	unsigned int virq, nbanks = domain->gc->num_chips;
+	unsigned int nbanks = domain->gc->num_chips;
 	struct irq_chip_generic *gc;
 	unsigned long pending;
 	int n, i, irq_base = 0;
@@ -268,11 +268,9 @@ static void stm32_irq_handler(struct irq_desc *desc)
 		gc = irq_get_domain_generic_chip(domain, irq_base);
 
 		while ((pending = stm32_exti_pending(gc))) {
-			for_each_set_bit(n, &pending, IRQS_PER_BANK) {
-				virq = irq_find_mapping(domain, irq_base + n);
-				generic_handle_irq(virq);
-			}
-		}
+			for_each_set_bit(n, &pending, IRQS_PER_BANK)
+				generic_handle_domain_irq(domain, irq_base + n);
+ 		}
 	}
 
 	chained_irq_exit(chip, desc);
diff --git a/drivers/irqchip/irq-sun4i.c b/drivers/irqchip/irq-sun4i.c
index 9ea94456b178..8a315d6a3399 100644
--- a/drivers/irqchip/irq-sun4i.c
+++ b/drivers/irqchip/irq-sun4i.c
@@ -147,10 +147,8 @@ static int __init sun4i_ic_of_init(struct device_node *node,
 				   struct device_node *parent)
 {
 	irq_ic_data = kzalloc(sizeof(struct sun4i_irq_chip_data), GFP_KERNEL);
-	if (!irq_ic_data) {
-		pr_err("kzalloc failed!\n");
+	if (!irq_ic_data)
 		return -ENOMEM;
-	}
 
 	irq_ic_data->enable_reg_offset = SUN4I_IRQ_ENABLE_REG_OFFSET;
 	irq_ic_data->mask_reg_offset = SUN4I_IRQ_MASK_REG_OFFSET;
@@ -164,10 +162,8 @@ static int __init suniv_ic_of_init(struct device_node *node,
 				   struct device_node *parent)
 {
 	irq_ic_data = kzalloc(sizeof(struct sun4i_irq_chip_data), GFP_KERNEL);
-	if (!irq_ic_data) {
-		pr_err("kzalloc failed!\n");
+	if (!irq_ic_data)
 		return -ENOMEM;
-	}
 
 	irq_ic_data->enable_reg_offset = SUNIV_IRQ_ENABLE_REG_OFFSET;
 	irq_ic_data->mask_reg_offset = SUNIV_IRQ_MASK_REG_OFFSET;
diff --git a/drivers/irqchip/irq-sunxi-nmi.c b/drivers/irqchip/irq-sunxi-nmi.c
index 9f2bd0c5d289..21d49791f855 100644
--- a/drivers/irqchip/irq-sunxi-nmi.c
+++ b/drivers/irqchip/irq-sunxi-nmi.c
@@ -88,10 +88,9 @@ static void sunxi_sc_nmi_handle_irq(struct irq_desc *desc)
 {
 	struct irq_domain *domain = irq_desc_get_handler_data(desc);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
-	unsigned int virq = irq_find_mapping(domain, 0);
 
 	chained_irq_enter(chip, desc);
-	generic_handle_irq(virq);
+	generic_handle_domain_irq(domain, 0);
 	chained_irq_exit(chip, desc);
 }
 
diff --git a/drivers/irqchip/irq-tb10x.c b/drivers/irqchip/irq-tb10x.c
index 9a63b02b8176..8a0e69298e83 100644
--- a/drivers/irqchip/irq-tb10x.c
+++ b/drivers/irqchip/irq-tb10x.c
@@ -91,7 +91,7 @@ static void tb10x_irq_cascade(struct irq_desc *desc)
 	struct irq_domain *domain = irq_desc_get_handler_data(desc);
 	unsigned int irq = irq_desc_get_irq(desc);
 
-	generic_handle_irq(irq_find_mapping(domain, irq));
+	generic_handle_domain_irq(domain, irq);
 }
 
 static int __init of_tb10x_init_irq(struct device_node *ictl,
diff --git a/drivers/irqchip/irq-ti-sci-inta.c b/drivers/irqchip/irq-ti-sci-inta.c
index ca1f593f4d13..97f454ec376b 100644
--- a/drivers/irqchip/irq-ti-sci-inta.c
+++ b/drivers/irqchip/irq-ti-sci-inta.c
@@ -147,7 +147,7 @@ static void ti_sci_inta_irq_handler(struct irq_desc *desc)
 	struct ti_sci_inta_vint_desc *vint_desc;
 	struct ti_sci_inta_irq_domain *inta;
 	struct irq_domain *domain;
-	unsigned int virq, bit;
+	unsigned int bit;
 	unsigned long val;
 
 	vint_desc = irq_desc_get_handler_data(desc);
@@ -159,11 +159,8 @@ static void ti_sci_inta_irq_handler(struct irq_desc *desc)
 	val = readq_relaxed(inta->base + vint_desc->vint_id * 0x1000 +
 			    VINT_STATUS_MASKED_OFFSET);
 
-	for_each_set_bit(bit, &val, MAX_EVENTS_PER_VINT) {
-		virq = irq_find_mapping(domain, vint_desc->events[bit].hwirq);
-		if (virq)
-			generic_handle_irq(virq);
-	}
+	for_each_set_bit(bit, &val, MAX_EVENTS_PER_VINT)
+		generic_handle_domain_irq(domain, vint_desc->events[bit].hwirq);
 
 	chained_irq_exit(irq_desc_get_chip(desc), desc);
 }
diff --git a/drivers/irqchip/irq-ts4800.c b/drivers/irqchip/irq-ts4800.c
index 2325fb3c482b..34337a61b1ef 100644
--- a/drivers/irqchip/irq-ts4800.c
+++ b/drivers/irqchip/irq-ts4800.c
@@ -79,10 +79,9 @@ static void ts4800_ic_chained_handle_irq(struct irq_desc *desc)
 
 	do {
 		unsigned int bit = __ffs(status);
-		int irq = irq_find_mapping(data->domain, bit);
 
+		generic_handle_domain_irq(data->domain, bit);
 		status &= ~(1 << bit);
-		generic_handle_irq(irq);
 	} while (status);
 
 out:
diff --git a/drivers/irqchip/irq-versatile-fpga.c b/drivers/irqchip/irq-versatile-fpga.c
index f1386733d3bc..75be350cf82f 100644
--- a/drivers/irqchip/irq-versatile-fpga.c
+++ b/drivers/irqchip/irq-versatile-fpga.c
@@ -85,7 +85,7 @@ static void fpga_irq_handle(struct irq_desc *desc)
 		unsigned int irq = ffs(status) - 1;
 
 		status &= ~(1 << irq);
-		generic_handle_irq(irq_find_mapping(f->domain, irq));
+		generic_handle_domain_irq(f->domain, irq);
 	} while (status);
 
 out:
diff --git a/drivers/irqchip/irq-vic.c b/drivers/irqchip/irq-vic.c
index 62f3d29f9042..1e1f2d115257 100644
--- a/drivers/irqchip/irq-vic.c
+++ b/drivers/irqchip/irq-vic.c
@@ -225,7 +225,7 @@ static void vic_handle_irq_cascaded(struct irq_desc *desc)
 
 	while ((stat = readl_relaxed(vic->base + VIC_IRQ_STATUS))) {
 		hwirq = ffs(stat) - 1;
-		generic_handle_irq(irq_find_mapping(vic->domain, hwirq));
+		generic_handle_domain_irq(vic->domain, hwirq);
 	}
 
 	chained_irq_exit(host_chip, desc);
diff --git a/drivers/irqchip/irq-xilinx-intc.c b/drivers/irqchip/irq-xilinx-intc.c
index 8cd1bfc73057..356a59755d63 100644
--- a/drivers/irqchip/irq-xilinx-intc.c
+++ b/drivers/irqchip/irq-xilinx-intc.c
@@ -110,20 +110,6 @@ static struct irq_chip intc_dev = {
 	.irq_mask_ack = intc_mask_ack,
 };
 
-static unsigned int xintc_get_irq_local(struct xintc_irq_chip *irqc)
-{
-	unsigned int irq = 0;
-	u32 hwirq;
-
-	hwirq = xintc_read(irqc, IVR);
-	if (hwirq != -1U)
-		irq = irq_find_mapping(irqc->root_domain, hwirq);
-
-	pr_debug("irq-xilinx: hwirq=%d, irq=%d\n", hwirq, irq);
-
-	return irq;
-}
-
 unsigned int xintc_get_irq(void)
 {
 	unsigned int irq = -1;
@@ -164,15 +150,16 @@ static void xil_intc_irq_handler(struct irq_desc *desc)
 {
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	struct xintc_irq_chip *irqc;
-	u32 pending;
 
 	irqc = irq_data_get_irq_handler_data(&desc->irq_data);
 	chained_irq_enter(chip, desc);
 	do {
-		pending = xintc_get_irq_local(irqc);
-		if (pending == 0)
+		u32 hwirq = xintc_read(irqc, IVR);
+
+		if (hwirq == -1U)
 			break;
-		generic_handle_irq(pending);
+
+		generic_handle_domain_irq(irqc->root_domain, hwirq);
 	} while (true);
 	chained_irq_exit(chip, desc);
 }
diff --git a/drivers/irqchip/qcom-irq-combiner.c b/drivers/irqchip/qcom-irq-combiner.c
index aa54bfcb0433..18e696dc7f4d 100644
--- a/drivers/irqchip/qcom-irq-combiner.c
+++ b/drivers/irqchip/qcom-irq-combiner.c
@@ -53,7 +53,6 @@ static void combiner_handle_irq(struct irq_desc *desc)
 	chained_irq_enter(chip, desc);
 
 	for (reg = 0; reg < combiner->nregs; reg++) {
-		int virq;
 		int hwirq;
 		u32 bit;
 		u32 status;
@@ -70,10 +69,7 @@ static void combiner_handle_irq(struct irq_desc *desc)
 			bit = __ffs(status);
 			status &= ~(1 << bit);
 			hwirq = irq_nr(reg, bit);
-			virq = irq_find_mapping(combiner->domain, hwirq);
-			if (virq > 0)
-				generic_handle_irq(virq);
-
+			generic_handle_domain_irq(combiner->domain, hwirq);
 		}
 	}
 
diff --git a/drivers/irqchip/qcom-pdc.c b/drivers/irqchip/qcom-pdc.c
index 5dc63c20b67e..32d59202d408 100644
--- a/drivers/irqchip/qcom-pdc.c
+++ b/drivers/irqchip/qcom-pdc.c
@@ -11,9 +11,11 @@
 #include <linux/irqdomain.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
+#include <linux/of_irq.h>
 #include <linux/soc/qcom/irq.h>
 #include <linux/spinlock.h>
 #include <linux/slab.h>
@@ -459,4 +461,8 @@ static int qcom_pdc_init(struct device_node *node, struct device_node *parent)
 	return ret;
 }
 
-IRQCHIP_DECLARE(qcom_pdc, "qcom,pdc", qcom_pdc_init);
+IRQCHIP_PLATFORM_DRIVER_BEGIN(qcom_pdc)
+IRQCHIP_MATCH("qcom,pdc", qcom_pdc_init)
+IRQCHIP_PLATFORM_DRIVER_END(qcom_pdc)
+MODULE_DESCRIPTION("Qualcomm Technologies, Inc. Power Domain Controller");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/mfd/ioc3.c b/drivers/mfd/ioc3.c
index c73ec78f255b..99b9c113f964 100644
--- a/drivers/mfd/ioc3.c
+++ b/drivers/mfd/ioc3.c
@@ -14,6 +14,7 @@
 #include <linux/delay.h>
 #include <linux/errno.h>
 #include <linux/interrupt.h>
+#include <linux/irqdomain.h>
 #include <linux/mfd/core.h>
 #include <linux/module.h>
 #include <linux/pci.h>
diff --git a/drivers/scsi/ibmvscsi/ibmvfc.c b/drivers/scsi/ibmvscsi/ibmvfc.c
index 6540d48eb0e8..715c34904e3e 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc.c
@@ -13,6 +13,7 @@
 #include <linux/dmapool.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
+#include <linux/irqdomain.h>
 #include <linux/kthread.h>
 #include <linux/slab.h>
 #include <linux/of.h>
diff --git a/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c b/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
index 41ac9477df7a..10b6c6daaacd 100644
--- a/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
+++ b/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
@@ -22,6 +22,7 @@
 #include <linux/list.h>
 #include <linux/string.h>
 #include <linux/delay.h>
+#include <linux/of.h>
 
 #include <target/target_core_base.h>
 #include <target/target_core_fabric.h>
diff --git a/drivers/staging/octeon-usb/octeon-hcd.c b/drivers/staging/octeon-usb/octeon-hcd.c
index f27f20a4aa2d..a1cd81d4a114 100644
--- a/drivers/staging/octeon-usb/octeon-hcd.c
+++ b/drivers/staging/octeon-usb/octeon-hcd.c
@@ -50,8 +50,10 @@
 #include <linux/module.h>
 #include <linux/usb/hcd.h>
 #include <linux/prefetch.h>
+#include <linux/irqdomain.h>
 #include <linux/dma-mapping.h>
 #include <linux/platform_device.h>
+#include <linux/of.h>
 
 #include <asm/octeon/octeon.h>
 
diff --git a/drivers/watchdog/octeon-wdt-main.c b/drivers/watchdog/octeon-wdt-main.c
index fde9e739b436..391c774a1f67 100644
--- a/drivers/watchdog/octeon-wdt-main.c
+++ b/drivers/watchdog/octeon-wdt-main.c
@@ -54,6 +54,7 @@
 #include <linux/delay.h>
 #include <linux/cpu.h>
 #include <linux/irq.h>
+#include <linux/irqdomain.h>
 
 #include <asm/mipsregs.h>
 #include <asm/uasm.h>
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 4777850a6dc7..2ed65b01c961 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -64,6 +64,8 @@
  * IRQF_NO_AUTOEN - Don't enable IRQ or NMI automatically when users request it.
  *                Users will enable it explicitly by enable_irq() or enable_nmi()
  *                later.
+ * IRQF_NO_DEBUG - Exclude from runnaway detection for IPI and similar handlers,
+ *		   depends on IRQF_PERCPU.
  */
 #define IRQF_SHARED		0x00000080
 #define IRQF_PROBE_SHARED	0x00000100
@@ -78,6 +80,7 @@
 #define IRQF_EARLY_RESUME	0x00020000
 #define IRQF_COND_SUSPEND	0x00040000
 #define IRQF_NO_AUTOEN		0x00080000
+#define IRQF_NO_DEBUG		0x00100000
 
 #define IRQF_TIMER		(__IRQF_TIMER | IRQF_NO_SUSPEND | IRQF_NO_THREAD)
 
@@ -319,39 +322,8 @@ struct irq_affinity_desc {
 
 extern cpumask_var_t irq_default_affinity;
 
-/* Internal implementation. Use the helpers below */
-extern int __irq_set_affinity(unsigned int irq, const struct cpumask *cpumask,
-			      bool force);
-
-/**
- * irq_set_affinity - Set the irq affinity of a given irq
- * @irq:	Interrupt to set affinity
- * @cpumask:	cpumask
- *
- * Fails if cpumask does not contain an online CPU
- */
-static inline int
-irq_set_affinity(unsigned int irq, const struct cpumask *cpumask)
-{
-	return __irq_set_affinity(irq, cpumask, false);
-}
-
-/**
- * irq_force_affinity - Force the irq affinity of a given irq
- * @irq:	Interrupt to set affinity
- * @cpumask:	cpumask
- *
- * Same as irq_set_affinity, but without checking the mask against
- * online cpus.
- *
- * Solely for low level cpu hotplug code, where we need to make per
- * cpu interrupts affine before the cpu becomes online.
- */
-static inline int
-irq_force_affinity(unsigned int irq, const struct cpumask *cpumask)
-{
-	return __irq_set_affinity(irq, cpumask, true);
-}
+extern int irq_set_affinity(unsigned int irq, const struct cpumask *cpumask);
+extern int irq_force_affinity(unsigned int irq, const struct cpumask *cpumask);
 
 extern int irq_can_set_affinity(unsigned int irq);
 extern int irq_select_affinity(unsigned int irq);
diff --git a/include/linux/irq.h b/include/linux/irq.h
index 31b347c9f8dd..8e9a9ae471a6 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -72,6 +72,7 @@ enum irqchip_irq_state;
  *				  mechanism and from core side polling.
  * IRQ_DISABLE_UNLAZY		- Disable lazy irq disable
  * IRQ_HIDDEN			- Don't show up in /proc/interrupts
+ * IRQ_NO_DEBUG			- Exclude from note_interrupt() debugging
  */
 enum {
 	IRQ_TYPE_NONE		= 0x00000000,
@@ -99,6 +100,7 @@ enum {
 	IRQ_IS_POLLED		= (1 << 18),
 	IRQ_DISABLE_UNLAZY	= (1 << 19),
 	IRQ_HIDDEN		= (1 << 20),
+	IRQ_NO_DEBUG		= (1 << 21),
 };
 
 #define IRQF_MODIFY_MASK	\
diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index df4651250785..59aea39785bf 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -158,25 +158,21 @@ static inline void generic_handle_irq_desc(struct irq_desc *desc)
 	desc->handle_irq(desc);
 }
 
+int handle_irq_desc(struct irq_desc *desc);
 int generic_handle_irq(unsigned int irq);
 
-#ifdef CONFIG_HANDLE_DOMAIN_IRQ
+#ifdef CONFIG_IRQ_DOMAIN
 /*
  * Convert a HW interrupt number to a logical one using a IRQ domain,
  * and handle the result interrupt number. Return -EINVAL if
- * conversion failed. Providing a NULL domain indicates that the
- * conversion has already been done.
+ * conversion failed.
  */
-int __handle_domain_irq(struct irq_domain *domain, unsigned int hwirq,
-			bool lookup, struct pt_regs *regs);
+int generic_handle_domain_irq(struct irq_domain *domain, unsigned int hwirq);
 
-static inline int handle_domain_irq(struct irq_domain *domain,
-				    unsigned int hwirq, struct pt_regs *regs)
-{
-	return __handle_domain_irq(domain, hwirq, true, regs);
-}
+#ifdef CONFIG_HANDLE_DOMAIN_IRQ
+int handle_domain_irq(struct irq_domain *domain,
+		      unsigned int hwirq, struct pt_regs *regs);
 
-#ifdef CONFIG_IRQ_DOMAIN
 int handle_domain_nmi(struct irq_domain *domain, unsigned int hwirq,
 		      struct pt_regs *regs);
 #endif
diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 62a8e3d23829..23e4ee523576 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -41,13 +41,11 @@ struct fwnode_handle;
 struct irq_domain;
 struct irq_chip;
 struct irq_data;
+struct irq_desc;
 struct cpumask;
 struct seq_file;
 struct irq_affinity_desc;
 
-/* Number of irqs reserved for a legacy isa controller */
-#define NUM_ISA_INTERRUPTS	16
-
 #define IRQ_DOMAIN_IRQ_SPEC_PARAMS 16
 
 /**
@@ -152,11 +150,10 @@ struct irq_domain_chip_generic;
  * @parent: Pointer to parent irq_domain to support hierarchy irq_domains
  *
  * Revmap data, used internally by irq_domain
- * @revmap_direct_max_irq: The largest hwirq that can be set for controllers that
- *                         support direct mapping
- * @revmap_size: Size of the linear map table @linear_revmap[]
+ * @revmap_size: Size of the linear map table @revmap[]
  * @revmap_tree: Radix map tree for hwirqs that don't fit in the linear map
- * @linear_revmap: Linear table of hwirq->virq reverse mappings
+ * @revmap_mutex: Lock for the revmap
+ * @revmap: Linear table of irq_data pointers
  */
 struct irq_domain {
 	struct list_head link;
@@ -176,11 +173,10 @@ struct irq_domain {
 
 	/* reverse map data. The linear map gets appended to the irq_domain */
 	irq_hw_number_t hwirq_max;
-	unsigned int revmap_direct_max_irq;
 	unsigned int revmap_size;
 	struct radix_tree_root revmap_tree;
-	struct mutex revmap_tree_mutex;
-	unsigned int linear_revmap[];
+	struct mutex revmap_mutex;
+	struct irq_data __rcu *revmap[];
 };
 
 /* Irq domain flags */
@@ -210,6 +206,9 @@ enum {
 	 */
 	IRQ_DOMAIN_MSI_NOMASK_QUIRK	= (1 << 6),
 
+	/* Irq domain doesn't translate anything */
+	IRQ_DOMAIN_FLAG_NO_MAP		= (1 << 7),
+
 	/*
 	 * Flags starting from IRQ_DOMAIN_FLAG_NONCORE are reserved
 	 * for implementation specific purposes and ignored by the
@@ -348,6 +347,8 @@ static inline struct irq_domain *irq_domain_add_linear(struct device_node *of_no
 {
 	return __irq_domain_add(of_node_to_fwnode(of_node), size, size, 0, ops, host_data);
 }
+
+#ifdef CONFIG_IRQ_DOMAIN_NOMAP
 static inline struct irq_domain *irq_domain_add_nomap(struct device_node *of_node,
 					 unsigned int max_irq,
 					 const struct irq_domain_ops *ops,
@@ -355,14 +356,10 @@ static inline struct irq_domain *irq_domain_add_nomap(struct device_node *of_nod
 {
 	return __irq_domain_add(of_node_to_fwnode(of_node), 0, max_irq, max_irq, ops, host_data);
 }
-static inline struct irq_domain *irq_domain_add_legacy_isa(
-				struct device_node *of_node,
-				const struct irq_domain_ops *ops,
-				void *host_data)
-{
-	return irq_domain_add_legacy(of_node, NUM_ISA_INTERRUPTS, 0, 0, ops,
-				     host_data);
-}
+
+extern unsigned int irq_create_direct_mapping(struct irq_domain *host);
+#endif
+
 static inline struct irq_domain *irq_domain_add_tree(struct device_node *of_node,
 					 const struct irq_domain_ops *ops,
 					 void *host_data)
@@ -405,25 +402,37 @@ static inline unsigned int irq_create_mapping(struct irq_domain *host,
 	return irq_create_mapping_affinity(host, hwirq, NULL);
 }
 
+extern struct irq_desc *__irq_resolve_mapping(struct irq_domain *domain,
+					      irq_hw_number_t hwirq,
+					      unsigned int *irq);
+
+static inline struct irq_desc *irq_resolve_mapping(struct irq_domain *domain,
+						   irq_hw_number_t hwirq)
+{
+	return __irq_resolve_mapping(domain, hwirq, NULL);
+}
 
 /**
- * irq_linear_revmap() - Find a linux irq from a hw irq number.
+ * irq_find_mapping() - Find a linux irq from a hw irq number.
  * @domain: domain owning this hardware interrupt
  * @hwirq: hardware irq number in that domain space
- *
- * This is a fast path alternative to irq_find_mapping() that can be
- * called directly by irq controller code to save a handful of
- * instructions. It is always safe to call, but won't find irqs mapped
- * using the radix tree.
  */
+static inline unsigned int irq_find_mapping(struct irq_domain *domain,
+					    irq_hw_number_t hwirq)
+{
+	unsigned int irq;
+
+	if (__irq_resolve_mapping(domain, hwirq, &irq))
+		return irq;
+
+	return 0;
+}
+
 static inline unsigned int irq_linear_revmap(struct irq_domain *domain,
 					     irq_hw_number_t hwirq)
 {
-	return hwirq < domain->revmap_size ? domain->linear_revmap[hwirq] : 0;
+	return irq_find_mapping(domain, hwirq);
 }
-extern unsigned int irq_find_mapping(struct irq_domain *host,
-				     irq_hw_number_t hwirq);
-extern unsigned int irq_create_direct_mapping(struct irq_domain *host);
 
 extern const struct irq_domain_ops irq_domain_simple_ops;
 
diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
index d79ef2493a28..fbc54c2a7f23 100644
--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -70,6 +70,11 @@ config IRQ_DOMAIN_HIERARCHY
 	bool
 	select IRQ_DOMAIN
 
+# Support for obsolete non-mapping irq domains
+config IRQ_DOMAIN_NOMAP
+	bool
+	select IRQ_DOMAIN
+
 # Support for hierarchical fasteoi+edge and fasteoi+level handlers
 config IRQ_FASTEOI_HIERARCHY_HANDLERS
 	bool
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 8cc8e5713287..7f04c7d8296e 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -481,7 +481,7 @@ void handle_nested_irq(unsigned int irq)
 	for_each_action_of_desc(desc, action)
 		action_ret |= action->thread_fn(action->irq, action->dev_id);
 
-	if (!noirqdebug)
+	if (!irq_settings_no_debug(desc))
 		note_interrupt(desc, action_ret);
 
 	raw_spin_lock_irq(&desc->lock);
diff --git a/kernel/irq/handle.c b/kernel/irq/handle.c
index 762a928e18f9..221d80c31e94 100644
--- a/kernel/irq/handle.c
+++ b/kernel/irq/handle.c
@@ -197,7 +197,7 @@ irqreturn_t handle_irq_event_percpu(struct irq_desc *desc)
 
 	add_interrupt_randomness(desc->irq_data.irq, flags);
 
-	if (!noirqdebug)
+	if (!irq_settings_no_debug(desc))
 		note_interrupt(desc, retval);
 	return retval;
 }
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 4a617d7312a4..f4dd5186858a 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -632,14 +632,8 @@ void irq_init_desc(unsigned int irq)
 
 #endif /* !CONFIG_SPARSE_IRQ */
 
-/**
- * generic_handle_irq - Invoke the handler for a particular irq
- * @irq:	The irq number to handle
- *
- */
-int generic_handle_irq(unsigned int irq)
+int handle_irq_desc(struct irq_desc *desc)
 {
-	struct irq_desc *desc = irq_to_desc(irq);
 	struct irq_data *data;
 
 	if (!desc)
@@ -652,11 +646,40 @@ int generic_handle_irq(unsigned int irq)
 	generic_handle_irq_desc(desc);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(handle_irq_desc);
+
+/**
+ * generic_handle_irq - Invoke the handler for a particular irq
+ * @irq:	The irq number to handle
+ *
+ */
+int generic_handle_irq(unsigned int irq)
+{
+	return handle_irq_desc(irq_to_desc(irq));
+}
 EXPORT_SYMBOL_GPL(generic_handle_irq);
 
+#ifdef CONFIG_IRQ_DOMAIN
+/**
+ * generic_handle_domain_irq - Invoke the handler for a HW irq belonging
+ *                             to a domain, usually for a non-root interrupt
+ *                             controller
+ * @domain:	The domain where to perform the lookup
+ * @hwirq:	The HW irq number to convert to a logical one
+ *
+ * Returns:	0 on success, or -EINVAL if conversion has failed
+ *
+ */
+int generic_handle_domain_irq(struct irq_domain *domain, unsigned int hwirq)
+{
+	return handle_irq_desc(irq_resolve_mapping(domain, hwirq));
+}
+EXPORT_SYMBOL_GPL(generic_handle_domain_irq);
+
 #ifdef CONFIG_HANDLE_DOMAIN_IRQ
 /**
- * __handle_domain_irq - Invoke the handler for a HW irq belonging to a domain
+ * handle_domain_irq - Invoke the handler for a HW irq belonging to a domain,
+ *                     usually for a root interrupt controller
  * @domain:	The domain where to perform the lookup
  * @hwirq:	The HW irq number to convert to a logical one
  * @lookup:	Whether to perform the domain lookup or not
@@ -664,37 +687,27 @@ EXPORT_SYMBOL_GPL(generic_handle_irq);
  *
  * Returns:	0 on success, or -EINVAL if conversion has failed
  */
-int __handle_domain_irq(struct irq_domain *domain, unsigned int hwirq,
-			bool lookup, struct pt_regs *regs)
+int handle_domain_irq(struct irq_domain *domain,
+		      unsigned int hwirq, struct pt_regs *regs)
 {
 	struct pt_regs *old_regs = set_irq_regs(regs);
-	unsigned int irq = hwirq;
+	struct irq_desc *desc;
 	int ret = 0;
 
 	irq_enter();
 
-#ifdef CONFIG_IRQ_DOMAIN
-	if (lookup)
-		irq = irq_find_mapping(domain, hwirq);
-#endif
-
-	/*
-	 * Some hardware gives randomly wrong interrupts.  Rather
-	 * than crashing, do something sensible.
-	 */
-	if (unlikely(!irq || irq >= nr_irqs)) {
-		ack_bad_irq(irq);
+	/* The irqdomain code provides boundary checks */
+	desc = irq_resolve_mapping(domain, hwirq);
+	if (likely(desc))
+		handle_irq_desc(desc);
+	else
 		ret = -EINVAL;
-	} else {
-		generic_handle_irq(irq);
-	}
 
 	irq_exit();
 	set_irq_regs(old_regs);
 	return ret;
 }
 
-#ifdef CONFIG_IRQ_DOMAIN
 /**
  * handle_domain_nmi - Invoke the handler for a HW irq belonging to a domain
  * @domain:	The domain where to perform the lookup
@@ -709,7 +722,7 @@ int handle_domain_nmi(struct irq_domain *domain, unsigned int hwirq,
 		      struct pt_regs *regs)
 {
 	struct pt_regs *old_regs = set_irq_regs(regs);
-	unsigned int irq;
+	struct irq_desc *desc;
 	int ret = 0;
 
 	/*
@@ -717,14 +730,14 @@ int handle_domain_nmi(struct irq_domain *domain, unsigned int hwirq,
 	 */
 	WARN_ON(!in_nmi());
 
-	irq = irq_find_mapping(domain, hwirq);
+	desc = irq_resolve_mapping(domain, hwirq);
 
 	/*
 	 * ack_bad_irq is not NMI-safe, just report
 	 * an invalid interrupt.
 	 */
-	if (likely(irq))
-		generic_handle_irq(irq);
+	if (likely(desc))
+		handle_irq_desc(desc);
 	else
 		ret = -EINVAL;
 
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 6284443b87ec..51c483ce2447 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -146,7 +146,11 @@ struct irq_domain *__irq_domain_add(struct fwnode_handle *fwnode, int size,
 
 	static atomic_t unknown_domains;
 
-	domain = kzalloc_node(sizeof(*domain) + (sizeof(unsigned int) * size),
+	if (WARN_ON((size && direct_max) ||
+		    (!IS_ENABLED(CONFIG_IRQ_DOMAIN_NOMAP) && direct_max)))
+		return NULL;
+
+	domain = kzalloc_node(struct_size(domain, revmap, size),
 			      GFP_KERNEL, of_node_to_nid(to_of_node(fwnode)));
 	if (!domain)
 		return NULL;
@@ -209,12 +213,18 @@ struct irq_domain *__irq_domain_add(struct fwnode_handle *fwnode, int size,
 
 	/* Fill structure */
 	INIT_RADIX_TREE(&domain->revmap_tree, GFP_KERNEL);
-	mutex_init(&domain->revmap_tree_mutex);
+	mutex_init(&domain->revmap_mutex);
 	domain->ops = ops;
 	domain->host_data = host_data;
 	domain->hwirq_max = hwirq_max;
+
+	if (direct_max) {
+		size = direct_max;
+		domain->flags |= IRQ_DOMAIN_FLAG_NO_MAP;
+	}
+
 	domain->revmap_size = size;
-	domain->revmap_direct_max_irq = direct_max;
+
 	irq_domain_check_hierarchy(domain);
 
 	mutex_lock(&irq_domain_mutex);
@@ -482,29 +492,39 @@ struct irq_domain *irq_get_default_host(void)
 	return irq_default_domain;
 }
 
+static bool irq_domain_is_nomap(struct irq_domain *domain)
+{
+	return IS_ENABLED(CONFIG_IRQ_DOMAIN_NOMAP) &&
+	       (domain->flags & IRQ_DOMAIN_FLAG_NO_MAP);
+}
+
 static void irq_domain_clear_mapping(struct irq_domain *domain,
 				     irq_hw_number_t hwirq)
 {
-	if (hwirq < domain->revmap_size) {
-		domain->linear_revmap[hwirq] = 0;
-	} else {
-		mutex_lock(&domain->revmap_tree_mutex);
+	if (irq_domain_is_nomap(domain))
+		return;
+
+	mutex_lock(&domain->revmap_mutex);
+	if (hwirq < domain->revmap_size)
+		rcu_assign_pointer(domain->revmap[hwirq], NULL);
+	else
 		radix_tree_delete(&domain->revmap_tree, hwirq);
-		mutex_unlock(&domain->revmap_tree_mutex);
-	}
+	mutex_unlock(&domain->revmap_mutex);
 }
 
 static void irq_domain_set_mapping(struct irq_domain *domain,
 				   irq_hw_number_t hwirq,
 				   struct irq_data *irq_data)
 {
-	if (hwirq < domain->revmap_size) {
-		domain->linear_revmap[hwirq] = irq_data->irq;
-	} else {
-		mutex_lock(&domain->revmap_tree_mutex);
+	if (irq_domain_is_nomap(domain))
+		return;
+
+	mutex_lock(&domain->revmap_mutex);
+	if (hwirq < domain->revmap_size)
+		rcu_assign_pointer(domain->revmap[hwirq], irq_data);
+	else
 		radix_tree_insert(&domain->revmap_tree, hwirq, irq_data);
-		mutex_unlock(&domain->revmap_tree_mutex);
-	}
+	mutex_unlock(&domain->revmap_mutex);
 }
 
 static void irq_domain_disassociate(struct irq_domain *domain, unsigned int irq)
@@ -604,6 +624,7 @@ void irq_domain_associate_many(struct irq_domain *domain, unsigned int irq_base,
 }
 EXPORT_SYMBOL_GPL(irq_domain_associate_many);
 
+#ifdef CONFIG_IRQ_DOMAIN_NOMAP
 /**
  * irq_create_direct_mapping() - Allocate an irq for direct mapping
  * @domain: domain to allocate the irq for or NULL for default domain
@@ -628,9 +649,9 @@ unsigned int irq_create_direct_mapping(struct irq_domain *domain)
 		pr_debug("create_direct virq allocation failed\n");
 		return 0;
 	}
-	if (virq >= domain->revmap_direct_max_irq) {
+	if (virq >= domain->revmap_size) {
 		pr_err("ERROR: no free irqs available below %i maximum\n",
-			domain->revmap_direct_max_irq);
+			domain->revmap_size);
 		irq_free_desc(virq);
 		return 0;
 	}
@@ -644,6 +665,7 @@ unsigned int irq_create_direct_mapping(struct irq_domain *domain)
 	return virq;
 }
 EXPORT_SYMBOL_GPL(irq_create_direct_mapping);
+#endif
 
 /**
  * irq_create_mapping_affinity() - Map a hardware interrupt into linux irq space
@@ -862,37 +884,53 @@ void irq_dispose_mapping(unsigned int virq)
 EXPORT_SYMBOL_GPL(irq_dispose_mapping);
 
 /**
- * irq_find_mapping() - Find a linux irq from a hw irq number.
+ * __irq_resolve_mapping() - Find a linux irq from a hw irq number.
  * @domain: domain owning this hardware interrupt
  * @hwirq: hardware irq number in that domain space
+ * @irq: optional pointer to return the Linux irq if required
+ *
+ * Returns the interrupt descriptor.
  */
-unsigned int irq_find_mapping(struct irq_domain *domain,
-			      irq_hw_number_t hwirq)
+struct irq_desc *__irq_resolve_mapping(struct irq_domain *domain,
+				       irq_hw_number_t hwirq,
+				       unsigned int *irq)
 {
+	struct irq_desc *desc = NULL;
 	struct irq_data *data;
 
 	/* Look for default domain if necessary */
 	if (domain == NULL)
 		domain = irq_default_domain;
 	if (domain == NULL)
-		return 0;
+		return desc;
+
+	if (irq_domain_is_nomap(domain)) {
+		if (hwirq < domain->revmap_size) {
+			data = irq_domain_get_irq_data(domain, hwirq);
+			if (data && data->hwirq == hwirq)
+				desc = irq_data_to_desc(data);
+		}
 
-	if (hwirq < domain->revmap_direct_max_irq) {
-		data = irq_domain_get_irq_data(domain, hwirq);
-		if (data && data->hwirq == hwirq)
-			return hwirq;
+		return desc;
 	}
 
+	rcu_read_lock();
 	/* Check if the hwirq is in the linear revmap. */
 	if (hwirq < domain->revmap_size)
-		return domain->linear_revmap[hwirq];
+		data = rcu_dereference(domain->revmap[hwirq]);
+	else
+		data = radix_tree_lookup(&domain->revmap_tree, hwirq);
+
+	if (likely(data)) {
+		desc = irq_data_to_desc(data);
+		if (irq)
+			*irq = data->irq;
+	}
 
-	rcu_read_lock();
-	data = radix_tree_lookup(&domain->revmap_tree, hwirq);
 	rcu_read_unlock();
-	return data ? data->irq : 0;
+	return desc;
 }
-EXPORT_SYMBOL_GPL(irq_find_mapping);
+EXPORT_SYMBOL_GPL(__irq_resolve_mapping);
 
 /**
  * irq_domain_xlate_onecell() - Generic xlate for direct one cell bindings
@@ -1468,15 +1506,20 @@ static void irq_domain_fix_revmap(struct irq_data *d)
 {
 	void __rcu **slot;
 
-	if (d->hwirq < d->domain->revmap_size)
-		return; /* Not using radix tree. */
+	if (irq_domain_is_nomap(d->domain))
+		return;
 
 	/* Fix up the revmap. */
-	mutex_lock(&d->domain->revmap_tree_mutex);
-	slot = radix_tree_lookup_slot(&d->domain->revmap_tree, d->hwirq);
-	if (slot)
-		radix_tree_replace_slot(&d->domain->revmap_tree, slot, d);
-	mutex_unlock(&d->domain->revmap_tree_mutex);
+	mutex_lock(&d->domain->revmap_mutex);
+	if (d->hwirq < d->domain->revmap_size) {
+		/* Not using radix tree */
+		rcu_assign_pointer(d->domain->revmap[d->hwirq], d);
+	} else {
+		slot = radix_tree_lookup_slot(&d->domain->revmap_tree, d->hwirq);
+		if (slot)
+			radix_tree_replace_slot(&d->domain->revmap_tree, slot, d);
+	}
+	mutex_unlock(&d->domain->revmap_mutex);
 }
 
 /**
@@ -1828,8 +1871,7 @@ static void
 irq_domain_debug_show_one(struct seq_file *m, struct irq_domain *d, int ind)
 {
 	seq_printf(m, "%*sname:   %s\n", ind, "", d->name);
-	seq_printf(m, "%*ssize:   %u\n", ind + 1, "",
-		   d->revmap_size + d->revmap_direct_max_irq);
+	seq_printf(m, "%*ssize:   %u\n", ind + 1, "", d->revmap_size);
 	seq_printf(m, "%*smapped: %u\n", ind + 1, "", d->mapcount);
 	seq_printf(m, "%*sflags:  0x%08x\n", ind +1 , "", d->flags);
 	if (d->ops && d->ops->debug_show)
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 4c14356543d9..ef30b4762947 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -441,7 +441,8 @@ int irq_update_affinity_desc(unsigned int irq,
 	return ret;
 }
 
-int __irq_set_affinity(unsigned int irq, const struct cpumask *mask, bool force)
+static int __irq_set_affinity(unsigned int irq, const struct cpumask *mask,
+			      bool force)
 {
 	struct irq_desc *desc = irq_to_desc(irq);
 	unsigned long flags;
@@ -456,6 +457,36 @@ int __irq_set_affinity(unsigned int irq, const struct cpumask *mask, bool force)
 	return ret;
 }
 
+/**
+ * irq_set_affinity - Set the irq affinity of a given irq
+ * @irq:	Interrupt to set affinity
+ * @cpumask:	cpumask
+ *
+ * Fails if cpumask does not contain an online CPU
+ */
+int irq_set_affinity(unsigned int irq, const struct cpumask *cpumask)
+{
+	return __irq_set_affinity(irq, cpumask, false);
+}
+EXPORT_SYMBOL_GPL(irq_set_affinity);
+
+/**
+ * irq_force_affinity - Force the irq affinity of a given irq
+ * @irq:	Interrupt to set affinity
+ * @cpumask:	cpumask
+ *
+ * Same as irq_set_affinity, but without checking the mask against
+ * online cpus.
+ *
+ * Solely for low level cpu hotplug code, where we need to make per
+ * cpu interrupts affine before the cpu becomes online.
+ */
+int irq_force_affinity(unsigned int irq, const struct cpumask *cpumask)
+{
+	return __irq_set_affinity(irq, cpumask, true);
+}
+EXPORT_SYMBOL_GPL(irq_force_affinity);
+
 int irq_set_affinity_hint(unsigned int irq, const struct cpumask *m)
 {
 	unsigned long flags;
@@ -1686,8 +1717,13 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
 		if (new->flags & IRQF_PERCPU) {
 			irqd_set(&desc->irq_data, IRQD_PER_CPU);
 			irq_settings_set_per_cpu(desc);
+			if (new->flags & IRQF_NO_DEBUG)
+				irq_settings_set_no_debug(desc);
 		}
 
+		if (noirqdebug)
+			irq_settings_set_no_debug(desc);
+
 		if (new->flags & IRQF_ONESHOT)
 			desc->istate |= IRQS_ONESHOT;
 
diff --git a/kernel/irq/settings.h b/kernel/irq/settings.h
index 403378b9947b..7b7efb1a114b 100644
--- a/kernel/irq/settings.h
+++ b/kernel/irq/settings.h
@@ -18,6 +18,7 @@ enum {
 	_IRQ_IS_POLLED		= IRQ_IS_POLLED,
 	_IRQ_DISABLE_UNLAZY	= IRQ_DISABLE_UNLAZY,
 	_IRQ_HIDDEN		= IRQ_HIDDEN,
+	_IRQ_NO_DEBUG		= IRQ_NO_DEBUG,
 	_IRQF_MODIFY_MASK	= IRQF_MODIFY_MASK,
 };
 
@@ -33,6 +34,7 @@ enum {
 #define IRQ_IS_POLLED		GOT_YOU_MORON
 #define IRQ_DISABLE_UNLAZY	GOT_YOU_MORON
 #define IRQ_HIDDEN		GOT_YOU_MORON
+#define IRQ_NO_DEBUG		GOT_YOU_MORON
 #undef IRQF_MODIFY_MASK
 #define IRQF_MODIFY_MASK	GOT_YOU_MORON
 
@@ -174,3 +176,13 @@ static inline bool irq_settings_is_hidden(struct irq_desc *desc)
 {
 	return desc->status_use_accessors & _IRQ_HIDDEN;
 }
+
+static inline void irq_settings_set_no_debug(struct irq_desc *desc)
+{
+	desc->status_use_accessors |= _IRQ_NO_DEBUG;
+}
+
+static inline bool irq_settings_no_debug(struct irq_desc *desc)
+{
+	return desc->status_use_accessors & _IRQ_NO_DEBUG;
+}

