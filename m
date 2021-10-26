Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 024BC43AFCE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 12:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235184AbhJZKSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 06:18:23 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60674 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbhJZKSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 06:18:22 -0400
Date:   Tue, 26 Oct 2021 10:15:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635243357;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=+7XjB4o8Vgjk+AsYDXm7hpC3ycr2GMjRKR5jUu7vq7c=;
        b=WEzq6IoUSt8vLepMS8anEugyt+mOpxRwHfmr+0rjumoEPerktqWdJcdBBG17HXc67LK81r
        0nbuV7OuH3Yj6OLu9eZm0R2+gUWopPcMhkRjIunOnFcJNogM6ZUWdAmv83Z7pxT3ld+B2Q
        hhECGwyZwAWb+EHT7PbBjw5UdoWgUCeIhRleBuQzF5J+y7EKMusL3cKW3IDgPHKGtYr2+R
        uSgxYF0QdPGT9HRZr9J6bzV/ygDSX4QW9kSzdrehR+MuJr2KsGvrPTNkvMLyX+lFO6mz2g
        rMLpUD0E7heXORCxSbkKO67SxBGAiOu1sGXL/xT4qDDGje4dI9bpT6P+N6Bkog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635243357;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=+7XjB4o8Vgjk+AsYDXm7hpC3ycr2GMjRKR5jUu7vq7c=;
        b=uuWboeSsZoVlmC87ey4apQqDJVqS7nH9vh4hRxpIbR0ottg7Zo6Q3pKY8rSmhG5nnDVM3C
        WViLArz3XMtY1uCA==
From:   "irqchip-bot for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irq: remove handle_domain_{irq,nmi}()
Cc:     Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
MIME-Version: 1.0
Message-ID: <163524335658.626.5386672519532743658.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     0953fb263714e1c8c1c3d395036d9a14310081dd
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/0953fb263714e1c8c1c3d395036d9a14310081dd
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Wed, 20 Oct 2021 20:23:09 +01:00
Committer:     Mark Rutland <mark.rutland@arm.com>
CommitterDate: Tue, 26 Oct 2021 10:13:31 +01:00

irq: remove handle_domain_{irq,nmi}()

Now that entry code handles IRQ entry (including setting the IRQ regs)
before calling irqchip code, irqchip code can safely call
generic_handle_domain_irq(), and there's no functional reason for it to
call handle_domain_irq().

Let's cement this split of responsibility and remove handle_domain_irq()
entirely, updating irqchip drivers to call generic_handle_domain_irq().

For consistency, handle_domain_nmi() is similarly removed and replaced
with a generic_handle_domain_nmi() function which also does not perform
any entry logic.

Previously handle_domain_{irq,nmi}() had a WARN_ON() which would fire
when they were called in an inappropriate context. So that we can
identify similar issues going forward, similar WARN_ON_ONCE() logic is
added to the generic_handle_*() functions, and comments are updated for
clarity and consistency.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 Documentation/core-api/irq/irq-domain.rst |  3 +-
 arch/arm/Kconfig                          |  1 +-
 arch/arm/mach-imx/avic.c                  |  2 +-
 arch/arm/mach-imx/tzic.c                  |  2 +-
 arch/arm/mach-omap1/irq.c                 |  2 +-
 arch/arm/mach-s3c/irq-s3c24xx.c           |  2 +-
 arch/arm64/Kconfig                        |  1 +-
 arch/csky/Kconfig                         |  1 +-
 arch/openrisc/Kconfig                     |  1 +-
 arch/riscv/Kconfig                        |  1 +-
 drivers/irqchip/irq-apple-aic.c           | 20 +++---
 drivers/irqchip/irq-armada-370-xp.c       | 13 +---
 drivers/irqchip/irq-aspeed-vic.c          |  2 +-
 drivers/irqchip/irq-atmel-aic.c           |  2 +-
 drivers/irqchip/irq-atmel-aic5.c          |  2 +-
 drivers/irqchip/irq-bcm2835.c             |  2 +-
 drivers/irqchip/irq-bcm2836.c             |  2 +-
 drivers/irqchip/irq-clps711x.c            |  8 +--
 drivers/irqchip/irq-csky-apb-intc.c       |  2 +-
 drivers/irqchip/irq-csky-mpintc.c         |  4 +-
 drivers/irqchip/irq-davinci-aintc.c       |  2 +-
 drivers/irqchip/irq-davinci-cp-intc.c     |  2 +-
 drivers/irqchip/irq-digicolor.c           |  2 +-
 drivers/irqchip/irq-dw-apb-ictl.c         |  2 +-
 drivers/irqchip/irq-ftintc010.c           |  2 +-
 drivers/irqchip/irq-gic-v3.c              |  4 +-
 drivers/irqchip/irq-gic.c                 |  2 +-
 drivers/irqchip/irq-hip04.c               |  2 +-
 drivers/irqchip/irq-ixp4xx.c              |  4 +-
 drivers/irqchip/irq-lpc32xx.c             |  2 +-
 drivers/irqchip/irq-mmp.c                 |  4 +-
 drivers/irqchip/irq-mxs.c                 |  2 +-
 drivers/irqchip/irq-nvic.c                |  6 +-
 drivers/irqchip/irq-omap-intc.c           |  2 +-
 drivers/irqchip/irq-or1k-pic.c            |  2 +-
 drivers/irqchip/irq-orion.c               |  4 +-
 drivers/irqchip/irq-rda-intc.c            |  2 +-
 drivers/irqchip/irq-riscv-intc.c          |  2 +-
 drivers/irqchip/irq-sa11x0.c              |  4 +-
 drivers/irqchip/irq-sun4i.c               |  2 +-
 drivers/irqchip/irq-versatile-fpga.c      |  2 +-
 drivers/irqchip/irq-vic.c                 |  2 +-
 drivers/irqchip/irq-vt8500.c              |  2 +-
 drivers/irqchip/irq-wpcm450-aic.c         |  2 +-
 drivers/irqchip/irq-zevio.c               |  2 +-
 include/linux/irqdesc.h                   |  9 +---
 kernel/irq/Kconfig                        |  7 +--
 kernel/irq/irqdesc.c                      | 68 +++++-----------------
 48 files changed, 80 insertions(+), 141 deletions(-)

diff --git a/Documentation/core-api/irq/irq-domain.rst b/Documentation/core-api/irq/irq-domain.rst
index 9c0e875..d30b4d0 100644
--- a/Documentation/core-api/irq/irq-domain.rst
+++ b/Documentation/core-api/irq/irq-domain.rst
@@ -67,9 +67,6 @@ variety of methods:
   deprecated
 - generic_handle_domain_irq() handles an interrupt described by a
   domain and a hwirq number
-- handle_domain_irq() does the same thing for root interrupt
-  controllers and deals with the set_irq_reg()/irq_enter() sequences
-  that most architecture requires
 
 Note that irq domain lookups must happen in contexts that are
 compatible with a RCU read-side critical section.
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index fc19642..3361a6c 100644
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
diff --git a/arch/arm/mach-imx/avic.c b/arch/arm/mach-imx/avic.c
index 21bce40..cf6546d 100644
--- a/arch/arm/mach-imx/avic.c
+++ b/arch/arm/mach-imx/avic.c
@@ -154,7 +154,7 @@ static void __exception_irq_entry avic_handle_irq(struct pt_regs *regs)
 		if (nivector == 0xffff)
 			break;
 
-		handle_domain_irq(domain, nivector, regs);
+		generic_handle_domain_irq(domain, nivector);
 	} while (1);
 }
 
diff --git a/arch/arm/mach-imx/tzic.c b/arch/arm/mach-imx/tzic.c
index 479a01b..8b3d98d 100644
--- a/arch/arm/mach-imx/tzic.c
+++ b/arch/arm/mach-imx/tzic.c
@@ -134,7 +134,7 @@ static void __exception_irq_entry tzic_handle_irq(struct pt_regs *regs)
 			while (stat) {
 				handled = 1;
 				irqofs = fls(stat) - 1;
-				handle_domain_irq(domain, irqofs + i * 32, regs);
+				generic_handle_domain_irq(domain, irqofs + i * 32);
 				stat &= ~(1 << irqofs);
 			}
 		}
diff --git a/arch/arm/mach-omap1/irq.c b/arch/arm/mach-omap1/irq.c
index b11edc8..ee6a930 100644
--- a/arch/arm/mach-omap1/irq.c
+++ b/arch/arm/mach-omap1/irq.c
@@ -165,7 +165,7 @@ asmlinkage void __exception_irq_entry omap1_handle_irq(struct pt_regs *regs)
 		}
 irq:
 		if (irqnr)
-			handle_domain_irq(domain, irqnr, regs);
+			generic_handle_domain_irq(domain, irqnr);
 		else
 			break;
 	} while (irqnr);
diff --git a/arch/arm/mach-s3c/irq-s3c24xx.c b/arch/arm/mach-s3c/irq-s3c24xx.c
index 3edc5f6..45dfd54 100644
--- a/arch/arm/mach-s3c/irq-s3c24xx.c
+++ b/arch/arm/mach-s3c/irq-s3c24xx.c
@@ -354,7 +354,7 @@ static inline int s3c24xx_handle_intc(struct s3c_irq_intc *intc,
 	if (!(pnd & (1 << offset)))
 		offset =  __ffs(pnd);
 
-	handle_domain_irq(intc->domain, intc_offset + offset, regs);
+	generic_handle_domain_irq(intc->domain, intc_offset + offset);
 	return true;
 }
 
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 5c7ae4c..e6593a0 100644
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
diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 9d4d898..e0bd71b 100644
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
diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index e804026..c2491b2 100644
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
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 301a542..353e28f 100644
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
diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-aic.c
index 6fc145a..3759dc3 100644
--- a/drivers/irqchip/irq-apple-aic.c
+++ b/drivers/irqchip/irq-apple-aic.c
@@ -245,7 +245,7 @@ static void __exception_irq_entry aic_handle_irq(struct pt_regs *regs)
 		irq = FIELD_GET(AIC_EVENT_NUM, event);
 
 		if (type == AIC_EVENT_TYPE_HW)
-			handle_domain_irq(aic_irqc->hw_domain, irq, regs);
+			generic_handle_domain_irq(aic_irqc->hw_domain, irq);
 		else if (type == AIC_EVENT_TYPE_IPI && irq == 1)
 			aic_handle_ipi(regs);
 		else if (event != 0)
@@ -392,25 +392,25 @@ static void __exception_irq_entry aic_handle_fiq(struct pt_regs *regs)
 	}
 
 	if (TIMER_FIRING(read_sysreg(cntp_ctl_el0)))
-		handle_domain_irq(aic_irqc->hw_domain,
-				  aic_irqc->nr_hw + AIC_TMR_EL0_PHYS, regs);
+		generic_handle_domain_irq(aic_irqc->hw_domain,
+					  aic_irqc->nr_hw + AIC_TMR_EL0_PHYS);
 
 	if (TIMER_FIRING(read_sysreg(cntv_ctl_el0)))
-		handle_domain_irq(aic_irqc->hw_domain,
-				  aic_irqc->nr_hw + AIC_TMR_EL0_VIRT, regs);
+		generic_handle_domain_irq(aic_irqc->hw_domain,
+					  aic_irqc->nr_hw + AIC_TMR_EL0_VIRT);
 
 	if (is_kernel_in_hyp_mode()) {
 		uint64_t enabled = read_sysreg_s(SYS_IMP_APL_VM_TMR_FIQ_ENA_EL2);
 
 		if ((enabled & VM_TMR_FIQ_ENABLE_P) &&
 		    TIMER_FIRING(read_sysreg_s(SYS_CNTP_CTL_EL02)))
-			handle_domain_irq(aic_irqc->hw_domain,
-					  aic_irqc->nr_hw + AIC_TMR_EL02_PHYS, regs);
+			generic_handle_domain_irq(aic_irqc->hw_domain,
+						  aic_irqc->nr_hw + AIC_TMR_EL02_PHYS);
 
 		if ((enabled & VM_TMR_FIQ_ENABLE_V) &&
 		    TIMER_FIRING(read_sysreg_s(SYS_CNTV_CTL_EL02)))
-			handle_domain_irq(aic_irqc->hw_domain,
-					  aic_irqc->nr_hw + AIC_TMR_EL02_VIRT, regs);
+			generic_handle_domain_irq(aic_irqc->hw_domain,
+						  aic_irqc->nr_hw + AIC_TMR_EL02_VIRT);
 	}
 
 	if ((read_sysreg_s(SYS_IMP_APL_PMCR0_EL1) & (PMCR0_IMODE | PMCR0_IACT)) ==
@@ -674,7 +674,7 @@ static void aic_handle_ipi(struct pt_regs *regs)
 	firing = atomic_fetch_andnot(enabled, this_cpu_ptr(&aic_vipi_flag)) & enabled;
 
 	for_each_set_bit(i, &firing, AIC_NR_SWIPI)
-		handle_domain_irq(aic_irqc->ipi_domain, i, regs);
+		generic_handle_domain_irq(aic_irqc->ipi_domain, i);
 
 	/*
 	 * No ordering needed here; at worst this just changes the timing of
diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
index 53e0fb0..80906bf 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -589,12 +589,7 @@ static void armada_370_xp_handle_msi_irq(struct pt_regs *regs, bool is_chained)
 
 		irq = msinr - PCI_MSI_DOORBELL_START;
 
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
 
 		if (irqnr > 1) {
-			handle_domain_irq(armada_370_xp_mpic_domain,
-					  irqnr, regs);
+			generic_handle_domain_irq(armada_370_xp_mpic_domain,
+						  irqnr);
 			continue;
 		}
 
@@ -666,7 +661,7 @@ armada_370_xp_handle_irq(struct pt_regs *regs)
 				& IPI_DOORBELL_MASK;
 
 			for_each_set_bit(ipi, &ipimask, IPI_DOORBELL_END)
-				handle_domain_irq(ipi_domain, ipi, regs);
+				generic_handle_domain_irq(ipi_domain, ipi);
 		}
 #endif
 
diff --git a/drivers/irqchip/irq-aspeed-vic.c b/drivers/irqchip/irq-aspeed-vic.c
index 58717cd..62ccf2c 100644
--- a/drivers/irqchip/irq-aspeed-vic.c
+++ b/drivers/irqchip/irq-aspeed-vic.c
@@ -100,7 +100,7 @@ static void __exception_irq_entry avic_handle_irq(struct pt_regs *regs)
 		if (stat == 0)
 			break;
 		irq += ffs(stat) - 1;
-		handle_domain_irq(vic->dom, irq, regs);
+		generic_handle_domain_irq(vic->dom, irq);
 	}
 }
 
diff --git a/drivers/irqchip/irq-atmel-aic.c b/drivers/irqchip/irq-atmel-aic.c
index 2c999dc..4631f68 100644
--- a/drivers/irqchip/irq-atmel-aic.c
+++ b/drivers/irqchip/irq-atmel-aic.c
@@ -71,7 +71,7 @@ aic_handle(struct pt_regs *regs)
 	if (!irqstat)
 		irq_reg_writel(gc, 0, AT91_AIC_EOICR);
 	else
-		handle_domain_irq(aic_domain, irqnr, regs);
+		generic_handle_domain_irq(aic_domain, irqnr);
 }
 
 static int aic_retrigger(struct irq_data *d)
diff --git a/drivers/irqchip/irq-atmel-aic5.c b/drivers/irqchip/irq-atmel-aic5.c
index fb4ad2a..145535b 100644
--- a/drivers/irqchip/irq-atmel-aic5.c
+++ b/drivers/irqchip/irq-atmel-aic5.c
@@ -80,7 +80,7 @@ aic5_handle(struct pt_regs *regs)
 	if (!irqstat)
 		irq_reg_writel(bgc, 0, AT91_AIC5_EOICR);
 	else
-		handle_domain_irq(aic5_domain, irqnr, regs);
+		generic_handle_domain_irq(aic5_domain, irqnr);
 }
 
 static void aic5_mask(struct irq_data *d)
diff --git a/drivers/irqchip/irq-bcm2835.c b/drivers/irqchip/irq-bcm2835.c
index adc1556..e94e288 100644
--- a/drivers/irqchip/irq-bcm2835.c
+++ b/drivers/irqchip/irq-bcm2835.c
@@ -246,7 +246,7 @@ static void __exception_irq_entry bcm2835_handle_irq(
 	u32 hwirq;
 
 	while ((hwirq = get_next_armctrl_hwirq()) != ~0)
-		handle_domain_irq(intc.domain, hwirq, regs);
+		generic_handle_domain_irq(intc.domain, hwirq);
 }
 
 static void bcm2836_chained_handle_irq(struct irq_desc *desc)
diff --git a/drivers/irqchip/irq-bcm2836.c b/drivers/irqchip/irq-bcm2836.c
index 501facd..51491c3 100644
--- a/drivers/irqchip/irq-bcm2836.c
+++ b/drivers/irqchip/irq-bcm2836.c
@@ -143,7 +143,7 @@ __exception_irq_entry bcm2836_arm_irqchip_handle_irq(struct pt_regs *regs)
 	if (stat) {
 		u32 hwirq = ffs(stat) - 1;
 
-		handle_domain_irq(intc.domain, hwirq, regs);
+		generic_handle_domain_irq(intc.domain, hwirq);
 	}
 }
 
diff --git a/drivers/irqchip/irq-clps711x.c b/drivers/irqchip/irq-clps711x.c
index d0da29a..77ebe7e 100644
--- a/drivers/irqchip/irq-clps711x.c
+++ b/drivers/irqchip/irq-clps711x.c
@@ -77,14 +77,14 @@ static asmlinkage void __exception_irq_entry clps711x_irqh(struct pt_regs *regs)
 		irqstat = readw_relaxed(clps711x_intc->intmr[0]) &
 			  readw_relaxed(clps711x_intc->intsr[0]);
 		if (irqstat)
-			handle_domain_irq(clps711x_intc->domain,
-					  fls(irqstat) - 1, regs);
+			generic_handle_domain_irq(clps711x_intc->domain,
+						  fls(irqstat) - 1);
 
 		irqstat = readw_relaxed(clps711x_intc->intmr[1]) &
 			  readw_relaxed(clps711x_intc->intsr[1]);
 		if (irqstat)
-			handle_domain_irq(clps711x_intc->domain,
-					  fls(irqstat) - 1 + 16, regs);
+			generic_handle_domain_irq(clps711x_intc->domain,
+						  fls(irqstat) - 1 + 16);
 	} while (irqstat);
 }
 
diff --git a/drivers/irqchip/irq-csky-apb-intc.c b/drivers/irqchip/irq-csky-apb-intc.c
index ab91afa..d36f536 100644
--- a/drivers/irqchip/irq-csky-apb-intc.c
+++ b/drivers/irqchip/irq-csky-apb-intc.c
@@ -138,7 +138,7 @@ static inline bool handle_irq_perbit(struct pt_regs *regs, u32 hwirq,
 	if (hwirq == 0)
 		return 0;
 
-	handle_domain_irq(root_domain, irq_base + __fls(hwirq), regs);
+	generic_handle_domain_irq(root_domain, irq_base + __fls(hwirq));
 
 	return 1;
 }
diff --git a/drivers/irqchip/irq-csky-mpintc.c b/drivers/irqchip/irq-csky-mpintc.c
index a1534ed..cb403c9 100644
--- a/drivers/irqchip/irq-csky-mpintc.c
+++ b/drivers/irqchip/irq-csky-mpintc.c
@@ -74,8 +74,8 @@ static void csky_mpintc_handler(struct pt_regs *regs)
 {
 	void __iomem *reg_base = this_cpu_read(intcl_reg);
 
-	handle_domain_irq(root_domain,
-		readl_relaxed(reg_base + INTCL_RDYIR), regs);
+	generic_handle_domain_irq(root_domain,
+		readl_relaxed(reg_base + INTCL_RDYIR));
 }
 
 static void csky_mpintc_enable(struct irq_data *d)
diff --git a/drivers/irqchip/irq-davinci-aintc.c b/drivers/irqchip/irq-davinci-aintc.c
index 810ccc4..123eb7b 100644
--- a/drivers/irqchip/irq-davinci-aintc.c
+++ b/drivers/irqchip/irq-davinci-aintc.c
@@ -73,7 +73,7 @@ davinci_aintc_handle_irq(struct pt_regs *regs)
 	irqnr >>= 2;
 	irqnr -= 1;
 
-	handle_domain_irq(davinci_aintc_irq_domain, irqnr, regs);
+	generic_handle_domain_irq(davinci_aintc_irq_domain, irqnr);
 }
 
 /* ARM Interrupt Controller Initialization */
diff --git a/drivers/irqchip/irq-davinci-cp-intc.c b/drivers/irqchip/irq-davinci-cp-intc.c
index 276da27..7482c8e 100644
--- a/drivers/irqchip/irq-davinci-cp-intc.c
+++ b/drivers/irqchip/irq-davinci-cp-intc.c
@@ -135,7 +135,7 @@ davinci_cp_intc_handle_irq(struct pt_regs *regs)
 		return;
 	}
 
-	handle_domain_irq(davinci_cp_intc_irq_domain, irqnr, regs);
+	generic_handle_domain_irq(davinci_cp_intc_irq_domain, irqnr);
 }
 
 static int davinci_cp_intc_host_map(struct irq_domain *h, unsigned int virq,
diff --git a/drivers/irqchip/irq-digicolor.c b/drivers/irqchip/irq-digicolor.c
index fc38d2d..3b0d78a 100644
--- a/drivers/irqchip/irq-digicolor.c
+++ b/drivers/irqchip/irq-digicolor.c
@@ -50,7 +50,7 @@ static void __exception_irq_entry digicolor_handle_irq(struct pt_regs *regs)
 				return;
 		}
 
-		handle_domain_irq(digicolor_irq_domain, hwirq, regs);
+		generic_handle_domain_irq(digicolor_irq_domain, hwirq);
 	} while (1);
 }
 
diff --git a/drivers/irqchip/irq-dw-apb-ictl.c b/drivers/irqchip/irq-dw-apb-ictl.c
index a67266e..d5c1c75 100644
--- a/drivers/irqchip/irq-dw-apb-ictl.c
+++ b/drivers/irqchip/irq-dw-apb-ictl.c
@@ -42,7 +42,7 @@ static void __irq_entry dw_apb_ictl_handle_irq(struct pt_regs *regs)
 		while (stat) {
 			u32 hwirq = ffs(stat) - 1;
 
-			handle_domain_irq(d, hwirq, regs);
+			generic_handle_domain_irq(d, hwirq);
 			stat &= ~BIT(hwirq);
 		}
 	}
diff --git a/drivers/irqchip/irq-ftintc010.c b/drivers/irqchip/irq-ftintc010.c
index 0bf9842..5cc2688 100644
--- a/drivers/irqchip/irq-ftintc010.c
+++ b/drivers/irqchip/irq-ftintc010.c
@@ -134,7 +134,7 @@ asmlinkage void __exception_irq_entry ft010_irqchip_handle_irq(struct pt_regs *r
 
 	while ((status = readl(FT010_IRQ_STATUS(f->base)))) {
 		irq = ffs(status) - 1;
-		handle_domain_irq(f->domain, irq, regs);
+		generic_handle_domain_irq(f->domain, irq);
 	}
 }
 
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index fd4e9a3..daec330 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -660,7 +660,7 @@ static inline void gic_handle_nmi(u32 irqnr, struct pt_regs *regs)
 	 * PSR.I will be restored when we ERET to the
 	 * interrupted context.
 	 */
-	err = handle_domain_nmi(gic_data.domain, irqnr, regs);
+	err = generic_handle_domain_nmi(gic_data.domain, irqnr);
 	if (err)
 		gic_deactivate_unhandled(irqnr);
 
@@ -728,7 +728,7 @@ static asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs
 	else
 		isb();
 
-	if (handle_domain_irq(gic_data.domain, irqnr, regs)) {
+	if (generic_handle_domain_irq(gic_data.domain, irqnr)) {
 		WARN_ONCE(true, "Unexpected interrupt received!\n");
 		gic_deactivate_unhandled(irqnr);
 	}
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 5f22c9d..b8bb46c 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -369,7 +369,7 @@ static void __exception_irq_entry gic_handle_irq(struct pt_regs *regs)
 			this_cpu_write(sgi_intid, irqstat);
 		}
 
-		handle_domain_irq(gic->domain, irqnr, regs);
+		generic_handle_domain_irq(gic->domain, irqnr);
 	} while (1);
 }
 
diff --git a/drivers/irqchip/irq-hip04.c b/drivers/irqchip/irq-hip04.c
index 058ebae..46161f6 100644
--- a/drivers/irqchip/irq-hip04.c
+++ b/drivers/irqchip/irq-hip04.c
@@ -206,7 +206,7 @@ static void __exception_irq_entry hip04_handle_irq(struct pt_regs *regs)
 		irqnr = irqstat & GICC_IAR_INT_ID_MASK;
 
 		if (irqnr <= HIP04_MAX_IRQS)
-			handle_domain_irq(hip04_data.domain, irqnr, regs);
+			generic_handle_domain_irq(hip04_data.domain, irqnr);
 	} while (irqnr > HIP04_MAX_IRQS);
 }
 
diff --git a/drivers/irqchip/irq-ixp4xx.c b/drivers/irqchip/irq-ixp4xx.c
index 37e0749..fb68f8c 100644
--- a/drivers/irqchip/irq-ixp4xx.c
+++ b/drivers/irqchip/irq-ixp4xx.c
@@ -114,7 +114,7 @@ asmlinkage void __exception_irq_entry ixp4xx_handle_irq(struct pt_regs *regs)
 
 	status = __raw_readl(ixi->irqbase + IXP4XX_ICIP);
 	for_each_set_bit(i, &status, 32)
-		handle_domain_irq(ixi->domain, i, regs);
+		generic_handle_domain_irq(ixi->domain, i);
 
 	/*
 	 * IXP465/IXP435 has an upper IRQ status register
@@ -122,7 +122,7 @@ asmlinkage void __exception_irq_entry ixp4xx_handle_irq(struct pt_regs *regs)
 	if (ixi->is_356) {
 		status = __raw_readl(ixi->irqbase + IXP4XX_ICIP2);
 		for_each_set_bit(i, &status, 32)
-			handle_domain_irq(ixi->domain, i + 32, regs);
+			generic_handle_domain_irq(ixi->domain, i + 32);
 	}
 }
 
diff --git a/drivers/irqchip/irq-lpc32xx.c b/drivers/irqchip/irq-lpc32xx.c
index 5e6f6e2..a29357f 100644
--- a/drivers/irqchip/irq-lpc32xx.c
+++ b/drivers/irqchip/irq-lpc32xx.c
@@ -126,7 +126,7 @@ static void __exception_irq_entry lpc32xx_handle_irq(struct pt_regs *regs)
 	while (hwirq) {
 		irq = __ffs(hwirq);
 		hwirq &= ~BIT(irq);
-		handle_domain_irq(lpc32xx_mic_irqc->domain, irq, regs);
+		generic_handle_domain_irq(lpc32xx_mic_irqc->domain, irq);
 	}
 }
 
diff --git a/drivers/irqchip/irq-mmp.c b/drivers/irqchip/irq-mmp.c
index 4a74ac7..83455ca 100644
--- a/drivers/irqchip/irq-mmp.c
+++ b/drivers/irqchip/irq-mmp.c
@@ -230,7 +230,7 @@ static void __exception_irq_entry mmp_handle_irq(struct pt_regs *regs)
 	if (!(hwirq & SEL_INT_PENDING))
 		return;
 	hwirq &= SEL_INT_NUM_MASK;
-	handle_domain_irq(icu_data[0].domain, hwirq, regs);
+	generic_handle_domain_irq(icu_data[0].domain, hwirq);
 }
 
 static void __exception_irq_entry mmp2_handle_irq(struct pt_regs *regs)
@@ -241,7 +241,7 @@ static void __exception_irq_entry mmp2_handle_irq(struct pt_regs *regs)
 	if (!(hwirq & SEL_INT_PENDING))
 		return;
 	hwirq &= SEL_INT_NUM_MASK;
-	handle_domain_irq(icu_data[0].domain, hwirq, regs);
+	generic_handle_domain_irq(icu_data[0].domain, hwirq);
 }
 
 /* MMP (ARMv5) */
diff --git a/drivers/irqchip/irq-mxs.c b/drivers/irqchip/irq-mxs.c
index d1f5740..55cb6b5 100644
--- a/drivers/irqchip/irq-mxs.c
+++ b/drivers/irqchip/irq-mxs.c
@@ -136,7 +136,7 @@ asmlinkage void __exception_irq_entry icoll_handle_irq(struct pt_regs *regs)
 
 	irqnr = __raw_readl(icoll_priv.stat);
 	__raw_writel(irqnr, icoll_priv.vector);
-	handle_domain_irq(icoll_domain, irqnr, regs);
+	generic_handle_domain_irq(icoll_domain, irqnr);
 }
 
 static int icoll_irq_domain_map(struct irq_domain *d, unsigned int virq,
diff --git a/drivers/irqchip/irq-nvic.c b/drivers/irqchip/irq-nvic.c
index b2bd962..63bac3f 100644
--- a/drivers/irqchip/irq-nvic.c
+++ b/drivers/irqchip/irq-nvic.c
@@ -37,9 +37,9 @@
 
 static struct irq_domain *nvic_irq_domain;
 
-static void __nvic_handle_irq(irq_hw_number_t hwirq, struct pt_regs *regs)
+static void __nvic_handle_irq(irq_hw_number_t hwirq)
 {
-	handle_domain_irq(nvic_irq_domain, hwirq, regs);
+	generic_handle_domain_irq(nvic_irq_domain, hwirq);
 }
 
 /*
@@ -53,7 +53,7 @@ nvic_handle_irq(irq_hw_number_t hwirq, struct pt_regs *regs)
 
 	irq_enter();
 	old_regs = set_irq_regs(regs);
-	__nvic_handle_irq(hwirq, regs);
+	__nvic_handle_irq(hwirq);
 	set_irq_regs(old_regs);
 	irq_exit();
 }
diff --git a/drivers/irqchip/irq-omap-intc.c b/drivers/irqchip/irq-omap-intc.c
index d360a6e..dc82162 100644
--- a/drivers/irqchip/irq-omap-intc.c
+++ b/drivers/irqchip/irq-omap-intc.c
@@ -357,7 +357,7 @@ omap_intc_handle_irq(struct pt_regs *regs)
 	}
 
 	irqnr &= ACTIVEIRQ_MASK;
-	handle_domain_irq(domain, irqnr, regs);
+	generic_handle_domain_irq(domain, irqnr);
 }
 
 static int __init intc_of_init(struct device_node *node,
diff --git a/drivers/irqchip/irq-or1k-pic.c b/drivers/irqchip/irq-or1k-pic.c
index 03d2366..49b47e7 100644
--- a/drivers/irqchip/irq-or1k-pic.c
+++ b/drivers/irqchip/irq-or1k-pic.c
@@ -116,7 +116,7 @@ static void or1k_pic_handle_irq(struct pt_regs *regs)
 	int irq = -1;
 
 	while ((irq = pic_get_irq(irq + 1)) != NO_IRQ)
-		handle_domain_irq(root_domain, irq, regs);
+		generic_handle_domain_irq(root_domain, irq);
 }
 
 static int or1k_map(struct irq_domain *d, unsigned int irq, irq_hw_number_t hw)
diff --git a/drivers/irqchip/irq-orion.c b/drivers/irqchip/irq-orion.c
index b6868f7..17c2c7a 100644
--- a/drivers/irqchip/irq-orion.c
+++ b/drivers/irqchip/irq-orion.c
@@ -42,8 +42,8 @@ __exception_irq_entry orion_handle_irq(struct pt_regs *regs)
 			gc->mask_cache;
 		while (stat) {
 			u32 hwirq = __fls(stat);
-			handle_domain_irq(orion_irq_domain,
-					  gc->irq_base + hwirq, regs);
+			generic_handle_domain_irq(orion_irq_domain,
+						  gc->irq_base + hwirq);
 			stat &= ~(1 << hwirq);
 		}
 	}
diff --git a/drivers/irqchip/irq-rda-intc.c b/drivers/irqchip/irq-rda-intc.c
index 9601683..9f0144a 100644
--- a/drivers/irqchip/irq-rda-intc.c
+++ b/drivers/irqchip/irq-rda-intc.c
@@ -53,7 +53,7 @@ static void __exception_irq_entry rda_handle_irq(struct pt_regs *regs)
 
 	while (stat) {
 		hwirq = __fls(stat);
-		handle_domain_irq(rda_irq_domain, hwirq, regs);
+		generic_handle_domain_irq(rda_irq_domain, hwirq);
 		stat &= ~BIT(hwirq);
 	}
 }
diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
index 8017f6d..b65bd88 100644
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
index dbccc7d..31c202a 100644
--- a/drivers/irqchip/irq-sa11x0.c
+++ b/drivers/irqchip/irq-sa11x0.c
@@ -140,8 +140,8 @@ sa1100_handle_irq(struct pt_regs *regs)
 		if (mask == 0)
 			break;
 
-		handle_domain_irq(sa1100_normal_irqdomain,
-				ffs(mask) - 1, regs);
+		generic_handle_domain_irq(sa1100_normal_irqdomain,
+					  ffs(mask) - 1);
 	} while (1);
 }
 
diff --git a/drivers/irqchip/irq-sun4i.c b/drivers/irqchip/irq-sun4i.c
index 8a315d6..dd506eb 100644
--- a/drivers/irqchip/irq-sun4i.c
+++ b/drivers/irqchip/irq-sun4i.c
@@ -195,7 +195,7 @@ static void __exception_irq_entry sun4i_handle_irq(struct pt_regs *regs)
 		return;
 
 	do {
-		handle_domain_irq(irq_ic_data->irq_domain, hwirq, regs);
+		generic_handle_domain_irq(irq_ic_data->irq_domain, hwirq);
 		hwirq = readl(irq_ic_data->irq_base +
 				SUN4I_IRQ_VECTOR_REG) >> 2;
 	} while (hwirq != 0);
diff --git a/drivers/irqchip/irq-versatile-fpga.c b/drivers/irqchip/irq-versatile-fpga.c
index 75be350..f2757b6 100644
--- a/drivers/irqchip/irq-versatile-fpga.c
+++ b/drivers/irqchip/irq-versatile-fpga.c
@@ -105,7 +105,7 @@ static int handle_one_fpga(struct fpga_irq_data *f, struct pt_regs *regs)
 
 	while ((status  = readl(f->base + IRQ_STATUS))) {
 		irq = ffs(status) - 1;
-		handle_domain_irq(f->domain, irq, regs);
+		generic_handle_domain_irq(f->domain, irq);
 		handled = 1;
 	}
 
diff --git a/drivers/irqchip/irq-vic.c b/drivers/irqchip/irq-vic.c
index 1e1f2d1..9e3d556 100644
--- a/drivers/irqchip/irq-vic.c
+++ b/drivers/irqchip/irq-vic.c
@@ -208,7 +208,7 @@ static int handle_one_vic(struct vic_device *vic, struct pt_regs *regs)
 
 	while ((stat = readl_relaxed(vic->base + VIC_IRQ_STATUS))) {
 		irq = ffs(stat) - 1;
-		handle_domain_irq(vic->domain, irq, regs);
+		generic_handle_domain_irq(vic->domain, irq);
 		handled = 1;
 	}
 
diff --git a/drivers/irqchip/irq-vt8500.c b/drivers/irqchip/irq-vt8500.c
index 5bce936..e17dd3a 100644
--- a/drivers/irqchip/irq-vt8500.c
+++ b/drivers/irqchip/irq-vt8500.c
@@ -183,7 +183,7 @@ static void __exception_irq_entry vt8500_handle_irq(struct pt_regs *regs)
 				continue;
 		}
 
-		handle_domain_irq(intc[i].domain, irqnr, regs);
+		generic_handle_domain_irq(intc[i].domain, irqnr);
 	}
 }
 
diff --git a/drivers/irqchip/irq-wpcm450-aic.c b/drivers/irqchip/irq-wpcm450-aic.c
index f3ac392..0dcbeb1 100644
--- a/drivers/irqchip/irq-wpcm450-aic.c
+++ b/drivers/irqchip/irq-wpcm450-aic.c
@@ -69,7 +69,7 @@ static void __exception_irq_entry wpcm450_aic_handle_irq(struct pt_regs *regs)
 	/* Read IPER to signal that nIRQ can be de-asserted */
 	hwirq = readl(aic->regs + AIC_IPER) / 4;
 
-	handle_domain_irq(aic->domain, hwirq, regs);
+	generic_handle_domain_irq(aic->domain, hwirq);
 }
 
 static void wpcm450_aic_eoi(struct irq_data *d)
diff --git a/drivers/irqchip/irq-zevio.c b/drivers/irqchip/irq-zevio.c
index 84163f1..7a72620 100644
--- a/drivers/irqchip/irq-zevio.c
+++ b/drivers/irqchip/irq-zevio.c
@@ -50,7 +50,7 @@ static void __exception_irq_entry zevio_handle_irq(struct pt_regs *regs)
 
 	while (readl(zevio_irq_io + IO_STATUS)) {
 		irqnr = readl(zevio_irq_io + IO_CURRENT);
-		handle_domain_irq(zevio_irq_domain, irqnr, regs);
+		generic_handle_domain_irq(zevio_irq_domain, irqnr);
 	}
 }
 
diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index 59aea39..93d270c 100644
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
 
 /* Test to see if a driver has successfully requested an irq */
diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
index 897dfc5..1b41078 100644
--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -97,13 +97,6 @@ config GENERIC_MSI_IRQ_DOMAIN
 config IRQ_MSI_IOMMU
 	bool
 
-config HANDLE_DOMAIN_IRQ
-	bool
-
-# Legacy behaviour; architectures should call irq_{enter,exit}() themselves
-config HANDLE_DOMAIN_IRQ_IRQENTRY
-	bool
-
 config IRQ_TIMINGS
 	bool
 
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 7041698..2267e65 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -651,7 +651,11 @@ int handle_irq_desc(struct irq_desc *desc)
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
@@ -661,77 +665,39 @@ EXPORT_SYMBOL_GPL(generic_handle_irq);
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
 
-#ifdef CONFIG_HANDLE_DOMAIN_IRQ
 /**
- * handle_domain_irq - Invoke the handler for a HW irq belonging to a domain,
- *                     usually for a root interrupt controller
+ * generic_handle_domain_nmi - Invoke the handler for a HW nmi belonging
+ *                             to a domain.
  * @domain:	The domain where to perform the lookup
  * @hwirq:	The HW irq number to convert to a logical one
- * @regs:	Register file coming from the low-level handling code
- *
- * 		This function must be called from an IRQ context.
  *
  * Returns:	0 on success, or -EINVAL if conversion has failed
- */
-int handle_domain_irq(struct irq_domain *domain,
-		      unsigned int hwirq, struct pt_regs *regs)
-{
-	struct pt_regs *old_regs = set_irq_regs(regs);
-	int ret;
-
-	/*
-	 * IRQ context needs to be setup earlier.
-	 */
-	WARN_ON(!in_irq());
-
-	ret = generic_handle_domain_irq(domain, hwirq);
-
-	set_irq_regs(old_regs);
-	return ret;
-}
-
-/**
- * handle_domain_nmi - Invoke the handler for a HW irq belonging to a domain
- * @domain:	The domain where to perform the lookup
- * @hwirq:	The HW irq number to convert to a logical one
- * @regs:	Register file coming from the low-level handling code
- *
- *		This function must be called from an NMI context.
  *
- * Returns:	0 on success, or -EINVAL if conversion has failed
- */
-int handle_domain_nmi(struct irq_domain *domain, unsigned int hwirq,
-		      struct pt_regs *regs)
+ * 		This function must be called from an NMI context with irq regs
+ * 		initialized.
+ **/
+int generic_handle_domain_nmi(struct irq_domain *domain, unsigned int hwirq)
 {
-	struct pt_regs *old_regs = set_irq_regs(regs);
-	int ret;
-
-	/*
-	 * NMI context needs to be setup earlier in order to deal with tracing.
-	 */
-	WARN_ON(!in_nmi());
-
-	ret = generic_handle_domain_irq(domain, hwirq);
-
-	set_irq_regs(old_regs);
-	return ret;
+	WARN_ON_ONCE(!in_nmi());
+	return handle_irq_desc(irq_resolve_mapping(domain, hwirq));
 }
 #endif
-#endif
 
 /* Dynamic interrupt handling */
 
