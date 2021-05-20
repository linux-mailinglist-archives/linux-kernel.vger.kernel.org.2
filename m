Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B04B738B4D6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 19:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239271AbhETRBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 13:01:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:56536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234417AbhETQ67 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 12:58:59 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAC60613B5;
        Thu, 20 May 2021 16:57:34 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1ljlh7-002d7b-RD; Thu, 20 May 2021 17:38:46 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King <linux@armlinux.org.uk>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        kernel-team@android.com
Subject: [PATCH 39/39] powerpc: Bulk conversion to generic_handle_domain_irq()
Date:   Thu, 20 May 2021 17:37:51 +0100
Message-Id: <20210520163751.27325-40-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210520163751.27325-1-maz@kernel.org>
References: <20210520163751.27325-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, tglx@linutronix.de, mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org, ley.foon.tan@intel.com, chris@zankel.net, jcmvbkbc@gmail.com, vgupta@synopsys.com, tsbogend@alpha.franken.de, robert.jarzmik@free.fr, linux@armlinux.org.uk, krzysztof.kozlowski@canonical.com, ysato@users.sourceforge.jp, dalias@libc.org, geert@linux-m68k.org, alexander.deucher@amd.com, christian.koenig@amd.com, airlied@linux.ie, daniel@ffwll.ch, robdclark@gmail.com, linus.walleij@linaro.org, lee.jones@linaro.org, lorenzo.pieralisi@arm.com, robh@kernel.org, bhelgaas@google.com, bgolaszewski@baylibre.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wherever possible, replace constructs that match either
generic_handle_irq(irq_find_mapping()) or
generic_handle_irq(irq_linear_revmap()) to a single call to
generic_handle_domain_irq().

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/powerpc/platforms/4xx/uic.c              |  4 +---
 .../powerpc/platforms/512x/mpc5121_ads_cpld.c | 23 ++++++++-----------
 arch/powerpc/platforms/52xx/media5200.c       |  9 ++++----
 arch/powerpc/platforms/52xx/mpc52xx_gpt.c     |  7 ++----
 arch/powerpc/platforms/82xx/pq2ads-pci-pic.c  |  6 ++---
 arch/powerpc/platforms/cell/interrupt.c       |  8 ++-----
 arch/powerpc/platforms/cell/spider-pic.c      | 11 +++------
 arch/powerpc/platforms/embedded6xx/hlwd-pic.c | 15 ++++++------
 arch/powerpc/platforms/powernv/opal-irqchip.c | 11 ++++-----
 arch/powerpc/sysdev/fsl_mpic_err.c            | 11 ++++-----
 arch/powerpc/sysdev/fsl_msi.c                 |  8 +++----
 11 files changed, 43 insertions(+), 70 deletions(-)

diff --git a/arch/powerpc/platforms/4xx/uic.c b/arch/powerpc/platforms/4xx/uic.c
index 36fb66ce54cf..89e2587b1a59 100644
--- a/arch/powerpc/platforms/4xx/uic.c
+++ b/arch/powerpc/platforms/4xx/uic.c
@@ -198,7 +198,6 @@ static void uic_irq_cascade(struct irq_desc *desc)
 	struct uic *uic = irq_desc_get_handler_data(desc);
 	u32 msr;
 	int src;
-	int subvirq;
 
 	raw_spin_lock(&desc->lock);
 	if (irqd_is_level_type(idata))
@@ -213,8 +212,7 @@ static void uic_irq_cascade(struct irq_desc *desc)
 
 	src = 32 - ffs(msr);
 
-	subvirq = irq_linear_revmap(uic->irqhost, src);
-	generic_handle_irq(subvirq);
+	generic_handle_domain_irq(uic->irqhost, src);
 
 uic_irq_ret:
 	raw_spin_lock(&desc->lock);
diff --git a/arch/powerpc/platforms/512x/mpc5121_ads_cpld.c b/arch/powerpc/platforms/512x/mpc5121_ads_cpld.c
index b2981634f1f8..ea46870e5d6e 100644
--- a/arch/powerpc/platforms/512x/mpc5121_ads_cpld.c
+++ b/arch/powerpc/platforms/512x/mpc5121_ads_cpld.c
@@ -81,11 +81,10 @@ static struct irq_chip cpld_pic = {
 	.irq_unmask = cpld_unmask_irq,
 };
 
-static int
+static unsigned int
 cpld_pic_get_irq(int offset, u8 ignore, u8 __iomem *statusp,
 			    u8 __iomem *maskp)
 {
-	int cpld_irq;
 	u8 status = in_8(statusp);
 	u8 mask = in_8(maskp);
 
@@ -93,28 +92,26 @@ cpld_pic_get_irq(int offset, u8 ignore, u8 __iomem *statusp,
 	status |= (ignore | mask);
 
 	if (status == 0xff)
-		return 0;
-
-	cpld_irq = ffz(status) + offset;
+		return ~0;
 
-	return irq_linear_revmap(cpld_pic_host, cpld_irq);
+	return ffz(status) + offset;
 }
 
 static void cpld_pic_cascade(struct irq_desc *desc)
 {
-	unsigned int irq;
+	unsigned int hwirq;
 
-	irq = cpld_pic_get_irq(0, PCI_IGNORE, &cpld_regs->pci_status,
+	hwirq = cpld_pic_get_irq(0, PCI_IGNORE, &cpld_regs->pci_status,
 		&cpld_regs->pci_mask);
-	if (irq) {
-		generic_handle_irq(irq);
+	if (hwirq != ~0) {
+		generic_handle_domain_irq(cpld_pic_host, hwirq);
 		return;
 	}
 
-	irq = cpld_pic_get_irq(8, MISC_IGNORE, &cpld_regs->misc_status,
+	hwirq = cpld_pic_get_irq(8, MISC_IGNORE, &cpld_regs->misc_status,
 		&cpld_regs->misc_mask);
-	if (irq) {
-		generic_handle_irq(irq);
+	if (hwirq != ~0) {
+		generic_handle_domain_irq(cpld_pic_host, hwirq);
 		return;
 	}
 }
diff --git a/arch/powerpc/platforms/52xx/media5200.c b/arch/powerpc/platforms/52xx/media5200.c
index efb8bdecbcc7..110c444f4bc7 100644
--- a/arch/powerpc/platforms/52xx/media5200.c
+++ b/arch/powerpc/platforms/52xx/media5200.c
@@ -78,7 +78,7 @@ static struct irq_chip media5200_irq_chip = {
 static void media5200_irq_cascade(struct irq_desc *desc)
 {
 	struct irq_chip *chip = irq_desc_get_chip(desc);
-	int sub_virq, val;
+	int val;
 	u32 status, enable;
 
 	/* Mask off the cascaded IRQ */
@@ -92,11 +92,10 @@ static void media5200_irq_cascade(struct irq_desc *desc)
 	enable = in_be32(media5200_irq.regs + MEDIA5200_IRQ_STATUS);
 	val = ffs((status & enable) >> MEDIA5200_IRQ_SHIFT);
 	if (val) {
-		sub_virq = irq_linear_revmap(media5200_irq.irqhost, val - 1);
-		/* pr_debug("%s: virq=%i s=%.8x e=%.8x hwirq=%i subvirq=%i\n",
-		 *          __func__, virq, status, enable, val - 1, sub_virq);
+		generic_handle_domain_irq(media5200_irq.irqhost, val - 1);
+		/* pr_debug("%s: virq=%i s=%.8x e=%.8x hwirq=%i\n",
+		 *          __func__, virq, status, enable, val - 1);
 		 */
-		generic_handle_irq(sub_virq);
 	}
 
 	/* Processing done; can reenable the cascade now */
diff --git a/arch/powerpc/platforms/52xx/mpc52xx_gpt.c b/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
index 8c0d324f657e..acc211ceb719 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
@@ -190,14 +190,11 @@ static struct irq_chip mpc52xx_gpt_irq_chip = {
 static void mpc52xx_gpt_irq_cascade(struct irq_desc *desc)
 {
 	struct mpc52xx_gpt_priv *gpt = irq_desc_get_handler_data(desc);
-	int sub_virq;
 	u32 status;
 
 	status = in_be32(&gpt->regs->status) & MPC52xx_GPT_STATUS_IRQMASK;
-	if (status) {
-		sub_virq = irq_linear_revmap(gpt->irqhost, 0);
-		generic_handle_irq(sub_virq);
-	}
+	if (status)
+		generic_handle_domain_irq(gpt->irqhost, 0);
 }
 
 static int mpc52xx_gpt_irq_map(struct irq_domain *h, unsigned int virq,
diff --git a/arch/powerpc/platforms/82xx/pq2ads-pci-pic.c b/arch/powerpc/platforms/82xx/pq2ads-pci-pic.c
index f82f75a6085c..285bfe19b798 100644
--- a/arch/powerpc/platforms/82xx/pq2ads-pci-pic.c
+++ b/arch/powerpc/platforms/82xx/pq2ads-pci-pic.c
@@ -91,10 +91,8 @@ static void pq2ads_pci_irq_demux(struct irq_desc *desc)
 			break;
 
 		for (bit = 0; pend != 0; ++bit, pend <<= 1) {
-			if (pend & 0x80000000) {
-				int virq = irq_linear_revmap(priv->host, bit);
-				generic_handle_irq(virq);
-			}
+			if (pend & 0x80000000)
+				generic_handle_domain_irq(priv->host, bit);
 		}
 	}
 }
diff --git a/arch/powerpc/platforms/cell/interrupt.c b/arch/powerpc/platforms/cell/interrupt.c
index c0ab62ba6f16..0873a7a20271 100644
--- a/arch/powerpc/platforms/cell/interrupt.c
+++ b/arch/powerpc/platforms/cell/interrupt.c
@@ -106,13 +106,9 @@ static void iic_ioexc_cascade(struct irq_desc *desc)
 			out_be64(&node_iic->iic_is, ack);
 		/* handle them */
 		for (cascade = 63; cascade >= 0; cascade--)
-			if (bits & (0x8000000000000000UL >> cascade)) {
-				unsigned int cirq =
-					irq_linear_revmap(iic_host,
+			if (bits & (0x8000000000000000UL >> cascade))
+				generic_handle_domain_irq(iic_host,
 							  base | cascade);
-				if (cirq)
-					generic_handle_irq(cirq);
-			}
 		/* post-ack level interrupts */
 		ack = bits & ~IIC_ISR_EDGE_MASK;
 		if (ack)
diff --git a/arch/powerpc/platforms/cell/spider-pic.c b/arch/powerpc/platforms/cell/spider-pic.c
index 210785f59271..1bffccbe9772 100644
--- a/arch/powerpc/platforms/cell/spider-pic.c
+++ b/arch/powerpc/platforms/cell/spider-pic.c
@@ -190,16 +190,11 @@ static void spider_irq_cascade(struct irq_desc *desc)
 {
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	struct spider_pic *pic = irq_desc_get_handler_data(desc);
-	unsigned int cs, virq;
+	unsigned int cs;
 
 	cs = in_be32(pic->regs + TIR_CS) >> 24;
-	if (cs == SPIDER_IRQ_INVALID)
-		virq = 0;
-	else
-		virq = irq_linear_revmap(pic->host, cs);
-
-	if (virq)
-		generic_handle_irq(virq);
+	if (cs != SPIDER_IRQ_INVALID)
+		generic_handle_domain_irq((pic->host, cs);
 
 	chip->irq_eoi(&desc->irq_data);
 }
diff --git a/arch/powerpc/platforms/embedded6xx/hlwd-pic.c b/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
index a1b7f79a8a15..15396333a90b 100644
--- a/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
+++ b/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
@@ -108,7 +108,6 @@ static const struct irq_domain_ops hlwd_irq_domain_ops = {
 static unsigned int __hlwd_pic_get_irq(struct irq_domain *h)
 {
 	void __iomem *io_base = h->host_data;
-	int irq;
 	u32 irq_status;
 
 	irq_status = in_be32(io_base + HW_BROADWAY_ICR) &
@@ -116,23 +115,22 @@ static unsigned int __hlwd_pic_get_irq(struct irq_domain *h)
 	if (irq_status == 0)
 		return 0;	/* no more IRQs pending */
 
-	irq = __ffs(irq_status);
-	return irq_linear_revmap(h, irq);
+	return __ffs(irq_status);
 }
 
 static void hlwd_pic_irq_cascade(struct irq_desc *desc)
 {
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	struct irq_domain *irq_domain = irq_desc_get_handler_data(desc);
-	unsigned int virq;
+	unsigned int hwirq;
 
 	raw_spin_lock(&desc->lock);
 	chip->irq_mask(&desc->irq_data); /* IRQ_LEVEL */
 	raw_spin_unlock(&desc->lock);
 
-	virq = __hlwd_pic_get_irq(irq_domain);
-	if (virq)
-		generic_handle_irq(virq);
+	hwirq = __hlwd_pic_get_irq(irq_domain);
+	if (hwirq)
+		generic_handle_domain_irq(irq_domain, hwirq);
 	else
 		pr_err("spurious interrupt!\n");
 
@@ -190,7 +188,8 @@ static struct irq_domain *hlwd_pic_init(struct device_node *np)
 
 unsigned int hlwd_pic_get_irq(void)
 {
-	return __hlwd_pic_get_irq(hlwd_irq_host);
+	unsigned int hwirq = __hlwd_pic_get_irq(hlwd_irq_host);
+	return hwirq ? irq_linear_revmap(hlwd_irq_host, hwirq) : 0;
 }
 
 /*
diff --git a/arch/powerpc/platforms/powernv/opal-irqchip.c b/arch/powerpc/platforms/powernv/opal-irqchip.c
index c164419e254d..d55652b5f6fa 100644
--- a/arch/powerpc/platforms/powernv/opal-irqchip.c
+++ b/arch/powerpc/platforms/powernv/opal-irqchip.c
@@ -46,18 +46,15 @@ void opal_handle_events(void)
 	e = READ_ONCE(last_outstanding_events) & opal_event_irqchip.mask;
 again:
 	while (e) {
-		int virq, hwirq;
+		int hwirq;
 
 		hwirq = fls64(e) - 1;
 		e &= ~BIT_ULL(hwirq);
 
 		local_irq_disable();
-		virq = irq_find_mapping(opal_event_irqchip.domain, hwirq);
-		if (virq) {
-			irq_enter();
-			generic_handle_irq(virq);
-			irq_exit();
-		}
+		irq_enter();
+		generic_handle_domain_irq(opal_event_irqchip.domain, hwirq);
+		irq_exit();
 		local_irq_enable();
 
 		cond_resched();
diff --git a/arch/powerpc/sysdev/fsl_mpic_err.c b/arch/powerpc/sysdev/fsl_mpic_err.c
index 5fa5fa215541..9a98bb212922 100644
--- a/arch/powerpc/sysdev/fsl_mpic_err.c
+++ b/arch/powerpc/sysdev/fsl_mpic_err.c
@@ -99,7 +99,6 @@ static irqreturn_t fsl_error_int_handler(int irq, void *data)
 	struct mpic *mpic = (struct mpic *) data;
 	u32 eisr, eimr;
 	int errint;
-	unsigned int cascade_irq;
 
 	eisr = mpic_fsl_err_read(mpic->err_regs, MPIC_ERR_INT_EISR);
 	eimr = mpic_fsl_err_read(mpic->err_regs, MPIC_ERR_INT_EIMR);
@@ -108,13 +107,11 @@ static irqreturn_t fsl_error_int_handler(int irq, void *data)
 		return IRQ_NONE;
 
 	while (eisr) {
+		int ret;
 		errint = __builtin_clz(eisr);
-		cascade_irq = irq_linear_revmap(mpic->irqhost,
-				 mpic->err_int_vecs[errint]);
-		WARN_ON(!cascade_irq);
-		if (cascade_irq) {
-			generic_handle_irq(cascade_irq);
-		} else {
+		ret = generic_handle_domain_irq(mpic->irqhost,
+						mpic->err_int_vecs[errint]);
+		if (WARN_ON(ret)) {
 			eimr |=  1 << (31 - errint);
 			mpic_fsl_err_write(mpic->err_regs, eimr);
 		}
diff --git a/arch/powerpc/sysdev/fsl_msi.c b/arch/powerpc/sysdev/fsl_msi.c
index 808e7118abfc..e9c4aa211f04 100644
--- a/arch/powerpc/sysdev/fsl_msi.c
+++ b/arch/powerpc/sysdev/fsl_msi.c
@@ -305,15 +305,15 @@ static irqreturn_t fsl_msi_cascade(int irq, void *data)
 	}
 
 	while (msir_value) {
+		int err;
 		intr_index = ffs(msir_value) - 1;
 
-		cascade_irq = irq_linear_revmap(msi_data->irqhost,
+		err = generic_handle_domain_irq(msi_data->irqhost,
 				msi_hwirq(msi_data, msir_index,
 					  intr_index + have_shift));
-		if (cascade_irq) {
-			generic_handle_irq(cascade_irq);
+		if (!err)
 			ret = IRQ_HANDLED;
-		}
+
 		have_shift += intr_index + 1;
 		msir_value = msir_value >> (intr_index + 1);
 	}
-- 
2.30.2

