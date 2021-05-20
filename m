Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7807638B4C4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 18:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234590AbhETRAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 13:00:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:56708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234578AbhETQ7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 12:59:02 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B8966139A;
        Thu, 20 May 2021 16:57:40 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1ljlgt-002d7b-OE; Thu, 20 May 2021 17:38:31 +0100
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
Subject: [PATCH 30/39] PCI: Bulk conversion to generic_handle_domain_irq()
Date:   Thu, 20 May 2021 17:37:42 +0100
Message-Id: <20210520163751.27325-31-maz@kernel.org>
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
 drivers/pci/controller/dwc/pci-dra7xx.c        | 14 +++++---------
 drivers/pci/controller/dwc/pci-keystone.c      |  5 ++---
 .../pci/controller/dwc/pcie-designware-host.c  |  9 ++++-----
 drivers/pci/controller/dwc/pcie-uniphier.c     |  6 ++----
 .../controller/mobiveil/pcie-mobiveil-host.c   | 15 ++++++---------
 drivers/pci/controller/pci-aardvark.c          |  5 ++---
 drivers/pci/controller/pci-ftpci100.c          |  2 +-
 drivers/pci/controller/pci-tegra.c             |  8 +++-----
 drivers/pci/controller/pci-xgene-msi.c         |  9 +++------
 drivers/pci/controller/pcie-altera-msi.c       | 10 ++++------
 drivers/pci/controller/pcie-altera.c           | 10 ++++------
 drivers/pci/controller/pcie-brcmstb.c          |  9 ++++-----
 drivers/pci/controller/pcie-iproc-msi.c        |  4 +---
 drivers/pci/controller/pcie-mediatek-gen3.c    | 13 ++++---------
 drivers/pci/controller/pcie-mediatek.c         | 12 ++++--------
 drivers/pci/controller/pcie-microchip-host.c   | 18 +++++++-----------
 drivers/pci/controller/pcie-rcar-host.c        |  8 +++-----
 drivers/pci/controller/pcie-rockchip-host.c    |  8 +++-----
 drivers/pci/controller/pcie-xilinx-cpm.c       |  4 ++--
 drivers/pci/controller/pcie-xilinx-nwl.c       | 13 +++----------
 drivers/pci/controller/pcie-xilinx.c           |  9 ++++-----
 21 files changed, 71 insertions(+), 120 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
index 047cfbdc1330..8f646c79bab9 100644
--- a/drivers/pci/controller/dwc/pci-dra7xx.c
+++ b/drivers/pci/controller/dwc/pci-dra7xx.c
@@ -204,7 +204,7 @@ static int dra7xx_pcie_handle_msi(struct pcie_port *pp, int index)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	unsigned long val;
-	int pos, irq;
+	int pos;
 
 	val = dw_pcie_readl_dbi(pci, PCIE_MSI_INTR0_STATUS +
 				   (index * MSI_REG_CTRL_BLOCK_SIZE));
@@ -213,9 +213,8 @@ static int dra7xx_pcie_handle_msi(struct pcie_port *pp, int index)
 
 	pos = find_next_bit(&val, MAX_MSI_IRQS_PER_CTRL, 0);
 	while (pos != MAX_MSI_IRQS_PER_CTRL) {
-		irq = irq_find_mapping(pp->irq_domain,
-				       (index * MAX_MSI_IRQS_PER_CTRL) + pos);
-		generic_handle_irq(irq);
+		generic_handle_domain_irq(pp->irq_domain,
+					  (index * MAX_MSI_IRQS_PER_CTRL) + pos);
 		pos++;
 		pos = find_next_bit(&val, MAX_MSI_IRQS_PER_CTRL, pos);
 	}
@@ -276,11 +275,8 @@ static void dra7xx_pcie_msi_irq_handler(struct irq_desc *desc)
 	case INTB:
 	case INTC:
 	case INTD:
-		for_each_set_bit(bit, &reg, PCI_NUM_INTX) {
-			virq = irq_find_mapping(dra7xx->irq_domain, bit);
-			if (virq)
-				generic_handle_irq(virq);
-		}
+		for_each_set_bit(bit, &reg, PCI_NUM_INTX)
+			generic_handle_domain_irq(dra7xx->irq_domain, bit);
 		break;
 	}
 
diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index bde3b2824e89..7f3f26643e33 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -264,9 +264,8 @@ static void ks_pcie_handle_legacy_irq(struct keystone_pcie *ks_pcie,
 	pending = ks_pcie_app_readl(ks_pcie, IRQ_STATUS(offset));
 
 	if (BIT(0) & pending) {
-		virq = irq_linear_revmap(ks_pcie->legacy_irq_domain, offset);
-		dev_dbg(dev, ": irq: irq_offset %d, virq %d\n", offset, virq);
-		generic_handle_irq(virq);
+		dev_dbg(dev, ": irq: irq_offset %d", offset);
+		generic_handle_domain_irq(ks_pcie->legacy_irq_domain, offset);
 	}
 
 	/* EOI the INTx interrupt */
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index a608ae1fad57..d1d9b8344ec9 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -55,7 +55,7 @@ static struct msi_domain_info dw_pcie_msi_domain_info = {
 /* MSI int handler */
 irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
 {
-	int i, pos, irq;
+	int i, pos;
 	unsigned long val;
 	u32 status, num_ctrls;
 	irqreturn_t ret = IRQ_NONE;
@@ -74,10 +74,9 @@ irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
 		pos = 0;
 		while ((pos = find_next_bit(&val, MAX_MSI_IRQS_PER_CTRL,
 					    pos)) != MAX_MSI_IRQS_PER_CTRL) {
-			irq = irq_find_mapping(pp->irq_domain,
-					       (i * MAX_MSI_IRQS_PER_CTRL) +
-					       pos);
-			generic_handle_irq(irq);
+			generic_handle_domain_irq(pp->irq_domain,
+						  (i * MAX_MSI_IRQS_PER_CTRL) +
+						  pos);
 			pos++;
 		}
 	}
diff --git a/drivers/pci/controller/dwc/pcie-uniphier.c b/drivers/pci/controller/dwc/pcie-uniphier.c
index 7e8bad326770..4be23e540c44 100644
--- a/drivers/pci/controller/dwc/pcie-uniphier.c
+++ b/drivers/pci/controller/dwc/pcie-uniphier.c
@@ -257,10 +257,8 @@ static void uniphier_pcie_irq_handler(struct irq_desc *desc)
 	val = readl(priv->base + PCL_RCV_INTX);
 	reg = FIELD_GET(PCL_RCV_INTX_ALL_STATUS, val);
 
-	for_each_set_bit(bit, &reg, PCI_NUM_INTX) {
-		virq = irq_linear_revmap(priv->legacy_irq_domain, bit);
-		generic_handle_irq(virq);
-	}
+	for_each_set_bit(bit, &reg, PCI_NUM_INTX)
+		generic_handle_domain_irq(priv->legacy_irq_domain, bit);
 
 	chained_irq_exit(chip, desc);
 }
diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
index c637de3a389b..f3547aa60140 100644
--- a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
@@ -92,7 +92,7 @@ static void mobiveil_pcie_isr(struct irq_desc *desc)
 	u32 msi_data, msi_addr_lo, msi_addr_hi;
 	u32 intr_status, msi_status;
 	unsigned long shifted_status;
-	u32 bit, virq, val, mask;
+	u32 bit, val, mask;
 
 	/*
 	 * The core provides a single interrupt for both INTx/MSI messages.
@@ -114,11 +114,10 @@ static void mobiveil_pcie_isr(struct irq_desc *desc)
 		shifted_status >>= PAB_INTX_START;
 		do {
 			for_each_set_bit(bit, &shifted_status, PCI_NUM_INTX) {
-				virq = irq_find_mapping(rp->intx_domain,
-							bit + 1);
-				if (virq)
-					generic_handle_irq(virq);
-				else
+				int ret;
+				ret = generic_handle_domain_irq(rp->intx_domain,
+								bit + 1);
+				if (ret)
 					dev_err_ratelimited(dev, "unexpected IRQ, INT%d\n",
 							    bit);
 
@@ -155,9 +154,7 @@ static void mobiveil_pcie_isr(struct irq_desc *desc)
 		dev_dbg(dev, "MSI registers, data: %08x, addr: %08x:%08x\n",
 			msi_data, msi_addr_hi, msi_addr_lo);
 
-		virq = irq_find_mapping(msi->dev_domain, msi_data);
-		if (virq)
-			generic_handle_irq(virq);
+		generic_handle_domain_irq(msi->dev_domain, msi_data);
 
 		msi_status = readl_relaxed(pcie->apb_csr_base +
 					   MSI_STATUS_OFFSET);
diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 051b48bd7985..82794d9aab37 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -1007,7 +1007,7 @@ static void advk_pcie_handle_int(struct advk_pcie *pcie)
 {
 	u32 isr0_val, isr0_mask, isr0_status;
 	u32 isr1_val, isr1_mask, isr1_status;
-	int i, virq;
+	int i;
 
 	isr0_val = advk_readl(pcie, PCIE_ISR0_REG);
 	isr0_mask = advk_readl(pcie, PCIE_ISR0_MASK_REG);
@@ -1035,8 +1035,7 @@ static void advk_pcie_handle_int(struct advk_pcie *pcie)
 		advk_writel(pcie, PCIE_ISR1_INTX_ASSERT(i),
 			    PCIE_ISR1_REG);
 
-		virq = irq_find_mapping(pcie->irq_domain, i);
-		generic_handle_irq(virq);
+		generic_handle_domain_irq(pcie->irq_domain, i);
 	}
 }
 
diff --git a/drivers/pci/controller/pci-ftpci100.c b/drivers/pci/controller/pci-ftpci100.c
index da3cd216da00..939478d3efcd 100644
--- a/drivers/pci/controller/pci-ftpci100.c
+++ b/drivers/pci/controller/pci-ftpci100.c
@@ -314,7 +314,7 @@ static void faraday_pci_irq_handler(struct irq_desc *desc)
 	for (i = 0; i < 4; i++) {
 		if ((irq_stat & BIT(i)) == 0)
 			continue;
-		generic_handle_irq(irq_find_mapping(p->irqdomain, i));
+		generic_handle_domain_irq(p->irqdomain, i);
 	}
 
 	chained_irq_exit(irqchip, desc);
diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index 8069bd9232d4..f8df16265d0f 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -1553,12 +1553,10 @@ static void tegra_pcie_msi_irq(struct irq_desc *desc)
 		while (reg) {
 			unsigned int offset = find_first_bit(&reg, 32);
 			unsigned int index = i * 32 + offset;
-			unsigned int irq;
+			int ret;
 
-			irq = irq_find_mapping(msi->domain->parent, index);
-			if (irq) {
-				generic_handle_irq(irq);
-			} else {
+			ret = generic_handle_domain_irq(msi->domain->parent, index);
+			if (ret) {
 				/*
 				 * that's weird who triggered this?
 				 * just clear it
diff --git a/drivers/pci/controller/pci-xgene-msi.c b/drivers/pci/controller/pci-xgene-msi.c
index 1c34c897a7e2..cf3832b905e8 100644
--- a/drivers/pci/controller/pci-xgene-msi.c
+++ b/drivers/pci/controller/pci-xgene-msi.c
@@ -291,8 +291,7 @@ static void xgene_msi_isr(struct irq_desc *desc)
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	struct xgene_msi_group *msi_groups;
 	struct xgene_msi *xgene_msi;
-	unsigned int virq;
-	int msir_index, msir_val, hw_irq;
+	int msir_index, msir_val, hw_irq, ret;
 	u32 intr_index, grp_select, msi_grp;
 
 	chained_irq_enter(chip, desc);
@@ -330,10 +329,8 @@ static void xgene_msi_isr(struct irq_desc *desc)
 			 * CPU0
 			 */
 			hw_irq = hwirq_to_canonical_hwirq(hw_irq);
-			virq = irq_find_mapping(xgene_msi->inner_domain, hw_irq);
-			WARN_ON(!virq);
-			if (virq != 0)
-				generic_handle_irq(virq);
+			ret = generic_handle_domain_irq(xgene_msi->inner_domain, hw_irq);
+			WARN_ON(ret);
 			msir_val &= ~(1 << intr_index);
 		}
 		grp_select &= ~(1 << msir_index);
diff --git a/drivers/pci/controller/pcie-altera-msi.c b/drivers/pci/controller/pcie-altera-msi.c
index 98aa1dccc6e6..7b1d3ebc34ec 100644
--- a/drivers/pci/controller/pcie-altera-msi.c
+++ b/drivers/pci/controller/pcie-altera-msi.c
@@ -55,7 +55,7 @@ static void altera_msi_isr(struct irq_desc *desc)
 	struct altera_msi *msi;
 	unsigned long status;
 	u32 bit;
-	u32 virq;
+	int ret;
 
 	chained_irq_enter(chip, desc);
 	msi = irq_desc_get_handler_data(desc);
@@ -65,11 +65,9 @@ static void altera_msi_isr(struct irq_desc *desc)
 			/* Dummy read from vector to clear the interrupt */
 			readl_relaxed(msi->vector_base + (bit * sizeof(u32)));
 
-			virq = irq_find_mapping(msi->inner_domain, bit);
-			if (virq)
-				generic_handle_irq(virq);
-			else
-				dev_err(&msi->pdev->dev, "unexpected MSI\n");
+			ret = generic_handle_domain_irq(msi->inner_domain, bit);
+			if (ret)
+				dev_err_ratelimited(&msi->pdev->dev, "unexpected MSI\n");
 		}
 	}
 
diff --git a/drivers/pci/controller/pcie-altera.c b/drivers/pci/controller/pcie-altera.c
index 523bd928b380..2513e9363236 100644
--- a/drivers/pci/controller/pcie-altera.c
+++ b/drivers/pci/controller/pcie-altera.c
@@ -646,7 +646,7 @@ static void altera_pcie_isr(struct irq_desc *desc)
 	struct device *dev;
 	unsigned long status;
 	u32 bit;
-	u32 virq;
+	int ret;
 
 	chained_irq_enter(chip, desc);
 	pcie = irq_desc_get_handler_data(desc);
@@ -658,11 +658,9 @@ static void altera_pcie_isr(struct irq_desc *desc)
 			/* clear interrupts */
 			cra_writel(pcie, 1 << bit, P2A_INT_STATUS);
 
-			virq = irq_find_mapping(pcie->irq_domain, bit);
-			if (virq)
-				generic_handle_irq(virq);
-			else
-				dev_err(dev, "unexpected IRQ, INT%d\n", bit);
+			ret = generic_handle_domain_irq(pcie->irq_domain, bit);
+			if (ret)
+				dev_err_ratelimited(dev, "unexpected IRQ, INT%d\n", bit);
 		}
 	}
 
diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 08bc788d9422..cc30215f5a43 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -476,7 +476,7 @@ static struct msi_domain_info brcm_msi_domain_info = {
 static void brcm_pcie_msi_isr(struct irq_desc *desc)
 {
 	struct irq_chip *chip = irq_desc_get_chip(desc);
-	unsigned long status, virq;
+	unsigned long status;
 	struct brcm_msi *msi;
 	struct device *dev;
 	u32 bit;
@@ -489,10 +489,9 @@ static void brcm_pcie_msi_isr(struct irq_desc *desc)
 	status >>= msi->legacy_shift;
 
 	for_each_set_bit(bit, &status, msi->nr) {
-		virq = irq_find_mapping(msi->inner_domain, bit);
-		if (virq)
-			generic_handle_irq(virq);
-		else
+		int ret;
+		ret = generic_handle_domain_irq(msi->inner_domain, bit);
+		if (ret)
 			dev_dbg(dev, "unexpected MSI\n");
 	}
 
diff --git a/drivers/pci/controller/pcie-iproc-msi.c b/drivers/pci/controller/pcie-iproc-msi.c
index eede4e8f3f75..da3db5c7c27a 100644
--- a/drivers/pci/controller/pcie-iproc-msi.c
+++ b/drivers/pci/controller/pcie-iproc-msi.c
@@ -322,7 +322,6 @@ static void iproc_msi_handler(struct irq_desc *desc)
 	struct iproc_msi *msi;
 	u32 eq, head, tail, nr_events;
 	unsigned long hwirq;
-	int virq;
 
 	chained_irq_enter(chip, desc);
 
@@ -358,8 +357,7 @@ static void iproc_msi_handler(struct irq_desc *desc)
 		/* process all outstanding events */
 		while (nr_events--) {
 			hwirq = decode_msi_hwirq(msi, eq, head);
-			virq = irq_find_mapping(msi->inner_domain, hwirq);
-			generic_handle_irq(virq);
+			generic_handle_domain_irq(msi->inner_domain, hwirq);
 
 			head++;
 			head %= EQ_LEN;
diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index 3c5b97716d40..c26abf66d4f8 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -645,7 +645,6 @@ static void mtk_pcie_msi_handler(struct mtk_pcie_port *port, int set_idx)
 {
 	struct mtk_msi_set *msi_set = &port->msi_sets[set_idx];
 	unsigned long msi_enable, msi_status;
-	unsigned int virq;
 	irq_hw_number_t bit, hwirq;
 
 	msi_enable = readl_relaxed(msi_set->base + PCIE_MSI_SET_ENABLE_OFFSET);
@@ -659,8 +658,7 @@ static void mtk_pcie_msi_handler(struct mtk_pcie_port *port, int set_idx)
 
 		for_each_set_bit(bit, &msi_status, PCIE_MSI_IRQS_PER_SET) {
 			hwirq = bit + set_idx * PCIE_MSI_IRQS_PER_SET;
-			virq = irq_find_mapping(port->msi_bottom_domain, hwirq);
-			generic_handle_irq(virq);
+			generic_handle_domain_irq(port->msi_bottom_domain, hwirq);
 		}
 	} while (true);
 }
@@ -670,18 +668,15 @@ static void mtk_pcie_irq_handler(struct irq_desc *desc)
 	struct mtk_pcie_port *port = irq_desc_get_handler_data(desc);
 	struct irq_chip *irqchip = irq_desc_get_chip(desc);
 	unsigned long status;
-	unsigned int virq;
 	irq_hw_number_t irq_bit = PCIE_INTX_SHIFT;
 
 	chained_irq_enter(irqchip, desc);
 
 	status = readl_relaxed(port->base + PCIE_INT_STATUS_REG);
 	for_each_set_bit_from(irq_bit, &status, PCI_NUM_INTX +
-			      PCIE_INTX_SHIFT) {
-		virq = irq_find_mapping(port->intx_domain,
-					irq_bit - PCIE_INTX_SHIFT);
-		generic_handle_irq(virq);
-	}
+			      PCIE_INTX_SHIFT)
+		generic_handle_domain_irq(port->intx_domain,
+					  irq_bit - PCIE_INTX_SHIFT);
 
 	irq_bit = PCIE_MSI_SHIFT;
 	for_each_set_bit_from(irq_bit, &status, PCIE_MSI_SET_NUM +
diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index 62a042e75d9a..ec8848a810f8 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -602,7 +602,6 @@ static void mtk_pcie_intr_handler(struct irq_desc *desc)
 	struct mtk_pcie_port *port = irq_desc_get_handler_data(desc);
 	struct irq_chip *irqchip = irq_desc_get_chip(desc);
 	unsigned long status;
-	u32 virq;
 	u32 bit = INTX_SHIFT;
 
 	chained_irq_enter(irqchip, desc);
@@ -612,9 +611,8 @@ static void mtk_pcie_intr_handler(struct irq_desc *desc)
 		for_each_set_bit_from(bit, &status, PCI_NUM_INTX + INTX_SHIFT) {
 			/* Clear the INTx */
 			writel(1 << bit, port->base + PCIE_INT_STATUS);
-			virq = irq_find_mapping(port->irq_domain,
-						bit - INTX_SHIFT);
-			generic_handle_irq(virq);
+			generic_handle_domain_irq(port->irq_domain,
+						  bit - INTX_SHIFT);
 		}
 	}
 
@@ -623,10 +621,8 @@ static void mtk_pcie_intr_handler(struct irq_desc *desc)
 			unsigned long imsi_status;
 
 			while ((imsi_status = readl(port->base + PCIE_IMSI_STATUS))) {
-				for_each_set_bit(bit, &imsi_status, MTK_MSI_IRQS_NUM) {
-					virq = irq_find_mapping(port->inner_domain, bit);
-					generic_handle_irq(virq);
-				}
+				for_each_set_bit(bit, &imsi_status, MTK_MSI_IRQS_NUM)
+					generic_handle_domain_irq(port->inner_domain, bit);
 			}
 			/* Clear MSI interrupt status */
 			writel(MSI_STATUS, port->base + PCIE_INT_STATUS);
diff --git a/drivers/pci/controller/pcie-microchip-host.c b/drivers/pci/controller/pcie-microchip-host.c
index 89c68c56d93b..f26a834a8e02 100644
--- a/drivers/pci/controller/pcie-microchip-host.c
+++ b/drivers/pci/controller/pcie-microchip-host.c
@@ -412,16 +412,14 @@ static void mc_handle_msi(struct irq_desc *desc)
 		port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
 	unsigned long status;
 	u32 bit;
-	u32 virq;
+	int ret;
 
 	status = readl_relaxed(bridge_base_addr + ISTATUS_LOCAL);
 	if (status & PM_MSI_INT_MSI_MASK) {
 		status = readl_relaxed(bridge_base_addr + ISTATUS_MSI);
 		for_each_set_bit(bit, &status, msi->num_vectors) {
-			virq = irq_find_mapping(msi->dev_domain, bit);
-			if (virq)
-				generic_handle_irq(virq);
-			else
+			ret = generic_handle_domain_irq(msi->dev_domain, bit);
+			if (ret)
 				dev_err_ratelimited(dev, "bad MSI IRQ %d\n",
 						    bit);
 		}
@@ -570,17 +568,15 @@ static void mc_handle_intx(struct irq_desc *desc)
 		port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
 	unsigned long status;
 	u32 bit;
-	u32 virq;
+	int ret;
 
 	status = readl_relaxed(bridge_base_addr + ISTATUS_LOCAL);
 	if (status & PM_MSI_INT_INTX_MASK) {
 		status &= PM_MSI_INT_INTX_MASK;
 		status >>= PM_MSI_INT_INTX_SHIFT;
 		for_each_set_bit(bit, &status, PCI_NUM_INTX) {
-			virq = irq_find_mapping(port->intx_domain, bit);
-			if (virq)
-				generic_handle_irq(virq);
-			else
+			ret = generic_handle_domain_irq(port->intx_domain, bit);
+			if (ret)
 				dev_err_ratelimited(dev, "bad INTx IRQ %d\n",
 						    bit);
 		}
@@ -745,7 +741,7 @@ static void mc_handle_event(struct irq_desc *desc)
 	events = get_events(port);
 
 	for_each_set_bit(bit, &events, NUM_EVENTS)
-		generic_handle_irq(irq_find_mapping(port->event_domain, bit));
+		generic_handle_domain_irq(port->event_domain, bit);
 
 	chained_irq_exit(chip, desc);
 }
diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
index 765cf2b45e24..00a8267eda14 100644
--- a/drivers/pci/controller/pcie-rcar-host.c
+++ b/drivers/pci/controller/pcie-rcar-host.c
@@ -486,12 +486,10 @@ static irqreturn_t rcar_pcie_msi_irq(int irq, void *data)
 
 	while (reg) {
 		unsigned int index = find_first_bit(&reg, 32);
-		unsigned int msi_irq;
+		int ret;
 
-		msi_irq = irq_find_mapping(msi->domain->parent, index);
-		if (msi_irq) {
-			generic_handle_irq(msi_irq);
-		} else {
+		ret = generic_handle_domain_irq(msi->domain->parent, index);
+		if (ret) {
 			/* Unknown MSI, just clear it */
 			dev_dbg(dev, "unexpected MSI\n");
 			rcar_pci_write_reg(pcie, BIT(index), PCIEMSIFR);
diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index f1d08a1b1591..24ba57c1e827 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -517,7 +517,7 @@ static void rockchip_pcie_legacy_int_handler(struct irq_desc *desc)
 	struct device *dev = rockchip->dev;
 	u32 reg;
 	u32 hwirq;
-	u32 virq;
+	int ret;
 
 	chained_irq_enter(chip, desc);
 
@@ -528,10 +528,8 @@ static void rockchip_pcie_legacy_int_handler(struct irq_desc *desc)
 		hwirq = ffs(reg) - 1;
 		reg &= ~BIT(hwirq);
 
-		virq = irq_find_mapping(rockchip->irq_domain, hwirq);
-		if (virq)
-			generic_handle_irq(virq);
-		else
+		ret = generic_handle_domain_irq(rockchip->irq_domain, hwirq);
+		if (ret)
 			dev_err(dev, "unexpected IRQ, INT%d\n", hwirq);
 	}
 
diff --git a/drivers/pci/controller/pcie-xilinx-cpm.c b/drivers/pci/controller/pcie-xilinx-cpm.c
index 67937facd90c..95426df03200 100644
--- a/drivers/pci/controller/pcie-xilinx-cpm.c
+++ b/drivers/pci/controller/pcie-xilinx-cpm.c
@@ -222,7 +222,7 @@ static void xilinx_cpm_pcie_intx_flow(struct irq_desc *desc)
 			pcie_read(port, XILINX_CPM_PCIE_REG_IDRN));
 
 	for_each_set_bit(i, &val, PCI_NUM_INTX)
-		generic_handle_irq(irq_find_mapping(port->intx_domain, i));
+		generic_handle_domain_irq(port->intx_domain, i);
 
 	chained_irq_exit(chip, desc);
 }
@@ -282,7 +282,7 @@ static void xilinx_cpm_pcie_event_flow(struct irq_desc *desc)
 	val =  pcie_read(port, XILINX_CPM_PCIE_REG_IDR);
 	val &= pcie_read(port, XILINX_CPM_PCIE_REG_IMR);
 	for_each_set_bit(i, &val, 32)
-		generic_handle_irq(irq_find_mapping(port->cpm_domain, i));
+		generic_handle_domain_irq(port->cpm_domain, i);
 	pcie_write(port, val, XILINX_CPM_PCIE_REG_IDR);
 
 	/*
diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
index 8689311c5ef6..3d178d5b652b 100644
--- a/drivers/pci/controller/pcie-xilinx-nwl.c
+++ b/drivers/pci/controller/pcie-xilinx-nwl.c
@@ -318,18 +318,14 @@ static void nwl_pcie_leg_handler(struct irq_desc *desc)
 	struct nwl_pcie *pcie;
 	unsigned long status;
 	u32 bit;
-	u32 virq;
 
 	chained_irq_enter(chip, desc);
 	pcie = irq_desc_get_handler_data(desc);
 
 	while ((status = nwl_bridge_readl(pcie, MSGF_LEG_STATUS) &
 				MSGF_LEG_SR_MASKALL) != 0) {
-		for_each_set_bit(bit, &status, PCI_NUM_INTX) {
-			virq = irq_find_mapping(pcie->legacy_irq_domain, bit);
-			if (virq)
-				generic_handle_irq(virq);
-		}
+		for_each_set_bit(bit, &status, PCI_NUM_INTX)
+			generic_handle_domain_irq(pcie->legacy_irq_domain, bit);
 	}
 
 	chained_irq_exit(chip, desc);
@@ -340,16 +336,13 @@ static void nwl_pcie_handle_msi_irq(struct nwl_pcie *pcie, u32 status_reg)
 	struct nwl_msi *msi;
 	unsigned long status;
 	u32 bit;
-	u32 virq;
 
 	msi = &pcie->msi;
 
 	while ((status = nwl_bridge_readl(pcie, status_reg)) != 0) {
 		for_each_set_bit(bit, &status, 32) {
 			nwl_bridge_writel(pcie, 1 << bit, status_reg);
-			virq = irq_find_mapping(msi->dev_domain, bit);
-			if (virq)
-				generic_handle_irq(virq);
+			generic_handle_domain_irq(msi->dev_domain, bit);
 		}
 	}
 }
diff --git a/drivers/pci/controller/pcie-xilinx.c b/drivers/pci/controller/pcie-xilinx.c
index 14001febf59a..aa9bdcebc838 100644
--- a/drivers/pci/controller/pcie-xilinx.c
+++ b/drivers/pci/controller/pcie-xilinx.c
@@ -385,7 +385,7 @@ static irqreturn_t xilinx_pcie_intr_handler(int irq, void *data)
 	}
 
 	if (status & (XILINX_PCIE_INTR_INTX | XILINX_PCIE_INTR_MSI)) {
-		unsigned int irq;
+		struct irq_domain *domain;
 
 		val = pcie_read(port, XILINX_PCIE_REG_RPIFR1);
 
@@ -399,19 +399,18 @@ static irqreturn_t xilinx_pcie_intr_handler(int irq, void *data)
 		if (val & XILINX_PCIE_RPIFR1_MSI_INTR) {
 			val = pcie_read(port, XILINX_PCIE_REG_RPIFR2) &
 				XILINX_PCIE_RPIFR2_MSG_DATA;
-			irq = irq_find_mapping(port->msi_domain->parent, val);
+			domain = port->msi_domain->parent;
 		} else {
 			val = (val & XILINX_PCIE_RPIFR1_INTR_MASK) >>
 				XILINX_PCIE_RPIFR1_INTR_SHIFT;
-			irq = irq_find_mapping(port->leg_domain, val);
+			domain = port->leg_domain;
 		}
 
 		/* Clear interrupt FIFO register 1 */
 		pcie_write(port, XILINX_PCIE_RPIFR1_ALL_MASK,
 			   XILINX_PCIE_REG_RPIFR1);
 
-		if (irq)
-			generic_handle_irq(irq);
+		generic_handle_domain_irq(domain, val);
 	}
 
 	if (status & XILINX_PCIE_INTR_SLV_UNSUPP)
-- 
2.30.2

