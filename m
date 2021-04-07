Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9234356C3F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 14:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352241AbhDGMiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 08:38:25 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36360 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245543AbhDGMiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 08:38:22 -0400
Date:   Wed, 07 Apr 2021 12:38:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617799092;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=efdvfaY3AysI9z/6L0cPw0T92lsbxdpsWkhAOEP1v30=;
        b=0pIp9eBepE30mxphqvwtn6OdcUOket5/y9nt9KVBILehtDzJTTrc3t1w3CPTYN4trRxkvf
        l45+30XOCAXCC6BHZK7IHRc6VgvDkM+DNN7rLFLb/G8PSRccZixRRydByWRmC+u9lBIEYT
        JAcQlhBlPutoAzV1eoT1C1dJw1nlz19EQP/cWTV9SpNXm9h++gz/r+4Hk+2pG89PwIZb7j
        x/mdPuwet3CZaDN2AVR5dYaGg7ywD4uVIMX+W6XJi4rVaFsUdTDs1X3OSdLe8INDI6iBGf
        Rg8RqDAjtSF402jEpajCRFcUFYBKmHUr1+a+f0W68RHHyWkmBpIJWvlDaEN6mg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617799092;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=efdvfaY3AysI9z/6L0cPw0T92lsbxdpsWkhAOEP1v30=;
        b=2S0Vx20IbG3fMLlm9xCGQJAECs6WQY3LELfpLnQnL8caBxnCptqslQauOyf82CsSh/bCHl
        IkPymNytyNJgh+AQ==
From:   irqchip-bot for Jonathan =?utf-8?q?Neusch=C3=A4fer?= 
        <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip: Add driver for WPCM450 interrupt
 controller
Cc:     j.neuschaefer@gmx.net, Marc Zyngier <maz@kernel.org>,
        tglx@linutronix.de
In-Reply-To: <20210406120921.2484986-7-j.neuschaefer@gmx.net>
References: <20210406120921.2484986-7-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Message-ID: <161779909191.29796.16364831906738905029.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqc=
hip:

Commit-ID:     fead4dd496631707549f414b4059afb86ea8fb80
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platfo=
rms/fead4dd496631707549f414b4059afb86ea8fb80
Author:        Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
AuthorDate:    Tue, 06 Apr 2021 14:09:17 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 07 Apr 2021 13:26:00 +01:00

irqchip: Add driver for WPCM450 interrupt controller

The WPCM450 AIC ("Advanced Interrupt Controller") is the interrupt
controller found in the Nuvoton WPCM450 SoC and other Winbond/Nuvoton
SoCs.

The list of registers if based on the AMI vendor kernel and the
Nuvoton W90N745 datasheet.

Although the hardware supports other interrupt modes, the driver only
supports high-level interrupts at the moment, because other modes could
not be tested so far.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20210406120921.2484986-7-j.neuschaefer@gmx.net
---
 drivers/irqchip/Kconfig           |   6 +-
 drivers/irqchip/Makefile          |   1 +-
 drivers/irqchip/irq-wpcm450-aic.c | 161 +++++++++++++++++++++++++++++-
 3 files changed, 168 insertions(+)
 create mode 100644 drivers/irqchip/irq-wpcm450-aic.c

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 15536e3..38ad9dc 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -577,4 +577,10 @@ config MST_IRQ
 	help
 	  Support MStar Interrupt Controller.
=20
+config WPCM450_AIC
+	bool "Nuvoton WPCM450 Advanced Interrupt Controller"
+	depends on ARCH_WPCM450 || COMPILE_TEST
+	help
+	  Support for the interrupt controller in the Nuvoton WPCM450 BMC SoC.
+
 endmenu
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index c59b95a..bef5793 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -113,3 +113,4 @@ obj-$(CONFIG_LOONGSON_PCH_MSI)		+=3D irq-loongson-pch-msi=
.o
 obj-$(CONFIG_MST_IRQ)			+=3D irq-mst-intc.o
 obj-$(CONFIG_SL28CPLD_INTC)		+=3D irq-sl28cpld.o
 obj-$(CONFIG_MACH_REALTEK_RTL)		+=3D irq-realtek-rtl.o
+obj-$(CONFIG_WPCM450_AIC)		+=3D irq-wpcm450-aic.o
diff --git a/drivers/irqchip/irq-wpcm450-aic.c b/drivers/irqchip/irq-wpcm450-=
aic.c
new file mode 100644
index 0000000..f3ac392
--- /dev/null
+++ b/drivers/irqchip/irq-wpcm450-aic.c
@@ -0,0 +1,161 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright 2021 Jonathan Neusch=C3=A4fer
+
+#include <linux/irqchip.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/printk.h>
+
+#include <asm/exception.h>
+
+#define AIC_SCR(x)	((x)*4)	/* Source control registers */
+#define AIC_GEN		0x84	/* Interrupt group enable control register */
+#define AIC_GRSR	0x88	/* Interrupt group raw status register */
+#define AIC_IRSR	0x100	/* Interrupt raw status register */
+#define AIC_IASR	0x104	/* Interrupt active status register */
+#define AIC_ISR		0x108	/* Interrupt status register */
+#define AIC_IPER	0x10c	/* Interrupt priority encoding register */
+#define AIC_ISNR	0x110	/* Interrupt source number register */
+#define AIC_IMR		0x114	/* Interrupt mask register */
+#define AIC_OISR	0x118	/* Output interrupt status register */
+#define AIC_MECR	0x120	/* Mask enable command register */
+#define AIC_MDCR	0x124	/* Mask disable command register */
+#define AIC_SSCR	0x128	/* Source set command register */
+#define AIC_SCCR	0x12c	/* Source clear command register */
+#define AIC_EOSCR	0x130	/* End of service command register */
+
+#define AIC_SCR_SRCTYPE_LOW_LEVEL	(0 << 6)
+#define AIC_SCR_SRCTYPE_HIGH_LEVEL	(1 << 6)
+#define AIC_SCR_SRCTYPE_NEG_EDGE	(2 << 6)
+#define AIC_SCR_SRCTYPE_POS_EDGE	(3 << 6)
+#define AIC_SCR_PRIORITY(x)		(x)
+#define AIC_SCR_PRIORITY_MASK		0x7
+
+#define AIC_NUM_IRQS		32
+
+struct wpcm450_aic {
+	void __iomem *regs;
+	struct irq_domain *domain;
+};
+
+static struct wpcm450_aic *aic;
+
+static void wpcm450_aic_init_hw(void)
+{
+	int i;
+
+	/* Disable (mask) all interrupts */
+	writel(0xffffffff, aic->regs + AIC_MDCR);
+
+	/*
+	 * Make sure the interrupt controller is ready to serve new interrupts.
+	 * Reading from IPER indicates that the nIRQ signal may be deasserted,
+	 * and writing to EOSCR indicates that interrupt handling has finished.
+	 */
+	readl(aic->regs + AIC_IPER);
+	writel(0, aic->regs + AIC_EOSCR);
+
+	/* Initialize trigger mode and priority of each interrupt source */
+	for (i =3D 0; i < AIC_NUM_IRQS; i++)
+		writel(AIC_SCR_SRCTYPE_HIGH_LEVEL | AIC_SCR_PRIORITY(7),
+		       aic->regs + AIC_SCR(i));
+}
+
+static void __exception_irq_entry wpcm450_aic_handle_irq(struct pt_regs *reg=
s)
+{
+	int hwirq;
+
+	/* Determine the interrupt source */
+	/* Read IPER to signal that nIRQ can be de-asserted */
+	hwirq =3D readl(aic->regs + AIC_IPER) / 4;
+
+	handle_domain_irq(aic->domain, hwirq, regs);
+}
+
+static void wpcm450_aic_eoi(struct irq_data *d)
+{
+	/* Signal end-of-service */
+	writel(0, aic->regs + AIC_EOSCR);
+}
+
+static void wpcm450_aic_mask(struct irq_data *d)
+{
+	unsigned int mask =3D BIT(d->hwirq);
+
+	/* Disable (mask) the interrupt */
+	writel(mask, aic->regs + AIC_MDCR);
+}
+
+static void wpcm450_aic_unmask(struct irq_data *d)
+{
+	unsigned int mask =3D BIT(d->hwirq);
+
+	/* Enable (unmask) the interrupt */
+	writel(mask, aic->regs + AIC_MECR);
+}
+
+static int wpcm450_aic_set_type(struct irq_data *d, unsigned int flow_type)
+{
+	/*
+	 * The hardware supports high/low level, as well as rising/falling edge
+	 * modes, and the DT binding accommodates for that, but as long as
+	 * other modes than high level mode are not used and can't be tested,
+	 * they are rejected in this driver.
+	 */
+	if ((flow_type & IRQ_TYPE_SENSE_MASK) !=3D IRQ_TYPE_LEVEL_HIGH)
+		return -EINVAL;
+
+	return 0;
+}
+
+static struct irq_chip wpcm450_aic_chip =3D {
+	.name =3D "wpcm450-aic",
+	.irq_eoi =3D wpcm450_aic_eoi,
+	.irq_mask =3D wpcm450_aic_mask,
+	.irq_unmask =3D wpcm450_aic_unmask,
+	.irq_set_type =3D wpcm450_aic_set_type,
+};
+
+static int wpcm450_aic_map(struct irq_domain *d, unsigned int irq, irq_hw_nu=
mber_t hwirq)
+{
+	if (hwirq >=3D AIC_NUM_IRQS)
+		return -EPERM;
+
+	irq_set_chip_and_handler(irq, &wpcm450_aic_chip, handle_fasteoi_irq);
+	irq_set_chip_data(irq, aic);
+	irq_set_probe(irq);
+
+	return 0;
+}
+
+static const struct irq_domain_ops wpcm450_aic_ops =3D {
+	.map =3D wpcm450_aic_map,
+	.xlate =3D irq_domain_xlate_twocell,
+};
+
+static int __init wpcm450_aic_of_init(struct device_node *node,
+				      struct device_node *parent)
+{
+	if (parent)
+		return -EINVAL;
+
+	aic =3D kzalloc(sizeof(*aic), GFP_KERNEL);
+	if (!aic)
+		return -ENOMEM;
+
+	aic->regs =3D of_iomap(node, 0);
+	if (!aic->regs) {
+		pr_err("Failed to map WPCM450 AIC registers\n");
+		return -ENOMEM;
+	}
+
+	wpcm450_aic_init_hw();
+
+	set_handle_irq(wpcm450_aic_handle_irq);
+
+	aic->domain =3D irq_domain_add_linear(node, AIC_NUM_IRQS, &wpcm450_aic_ops,=
 aic);
+
+	return 0;
+}
+
+IRQCHIP_DECLARE(wpcm450_aic, "nuvoton,wpcm450-aic", wpcm450_aic_of_init);
