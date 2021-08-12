Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D70673EA31C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 12:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236151AbhHLKtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 06:49:05 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57694 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236200AbhHLKr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 06:47:28 -0400
Date:   Thu, 12 Aug 2021 10:47:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628765223;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=NdLs7kg/VI6FTkG72OpCmDI4Zn2zsPZsRjGC764Nb8c=;
        b=NgpJOl+94fRArQLyGQv3F1oDptS2SCmtcYH7OBBNFXdCrBzLrF7vGSOtXl3DxXaQxGl4yV
        UPaXXX/IF3vlXWCjW9AFeyigO4ckctsdcrwf6eiCnULA119lUUuUzYgrwP81TQptm3LNsB
        hBzHMhwNWHeCv63aTWEJ4H4T07C0qfxXKjg4NQqCF4t/U4YdDaRAb/WEFx0iMh19koOF9A
        bjmJ56nNFeN0I8T4dQoq9H0UT91TA8wviLATF6n3CfkFp0Vm9EVRvX2k1kLGsFrqYbkt6h
        FuzZfWI6jjm6OnRVMvYrQyDqcpPwoD9mYafPevR9MOJmoKMZnqZtu7mGXI9c4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628765223;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=NdLs7kg/VI6FTkG72OpCmDI4Zn2zsPZsRjGC764Nb8c=;
        b=oblXAYj4Ih6rXLiEOccOfd4zOzk+ouikK/zsCN5rWBbB4cSpYCdPIN8PiNSbC9QzfZbwRQ
        jJ0MLAsdr12PDEDw==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] mfd: Bulk conversion to
 generic_handle_domain_irq()
Cc:     Lee Jones <lee.jones@linaro.org>, Marc Zyngier <maz@kernel.org>,
        tglx@linutronix.de
MIME-Version: 1.0
Message-ID: <162876522240.395.4624166854015969230.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     3b0cccef0574ef82da2d85180fcfcf9637f8154d
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/3b0cccef0574ef82da2d85180fcfcf9637f8154d
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Tue, 04 May 2021 17:42:18 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 12 Aug 2021 11:39:39 +01:00

mfd: Bulk conversion to generic_handle_domain_irq()

Wherever possible, replace constructs that match either
generic_handle_irq(irq_find_mapping()) or
generic_handle_irq(irq_linear_revmap()) to a single call to
generic_handle_domain_irq().

Acked-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/mfd/db8500-prcmu.c    |  2 +-
 drivers/mfd/fsl-imx25-tsadc.c |  4 ++--
 drivers/mfd/ioc3.c            | 10 +++-------
 drivers/mfd/qcom-pm8xxx.c     | 10 ++++------
 4 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/mfd/db8500-prcmu.c b/drivers/mfd/db8500-prcmu.c
index 3bde7fd..287da20 100644
--- a/drivers/mfd/db8500-prcmu.c
+++ b/drivers/mfd/db8500-prcmu.c
@@ -2364,7 +2364,7 @@ static bool read_mailbox_0(void)
 
 		for (n = 0; n < NUM_PRCMU_WAKEUPS; n++) {
 			if (ev & prcmu_irq_bit[n])
-				generic_handle_irq(irq_find_mapping(db8500_irq_domain, n));
+				generic_handle_domain_irq(db8500_irq_domain, n);
 		}
 		r = true;
 		break;
diff --git a/drivers/mfd/fsl-imx25-tsadc.c b/drivers/mfd/fsl-imx25-tsadc.c
index 5f6f0a8..37e5e02 100644
--- a/drivers/mfd/fsl-imx25-tsadc.c
+++ b/drivers/mfd/fsl-imx25-tsadc.c
@@ -35,10 +35,10 @@ static void mx25_tsadc_irq_handler(struct irq_desc *desc)
 	regmap_read(tsadc->regs, MX25_TSC_TGSR, &status);
 
 	if (status & MX25_TGSR_GCQ_INT)
-		generic_handle_irq(irq_find_mapping(tsadc->domain, 1));
+		generic_handle_domain_irq(tsadc->domain, 1);
 
 	if (status & MX25_TGSR_TCQ_INT)
-		generic_handle_irq(irq_find_mapping(tsadc->domain, 0));
+		generic_handle_domain_irq(tsadc->domain, 0);
 
 	chained_irq_exit(chip, desc);
 }
diff --git a/drivers/mfd/ioc3.c b/drivers/mfd/ioc3.c
index 99b9c11..5865683 100644
--- a/drivers/mfd/ioc3.c
+++ b/drivers/mfd/ioc3.c
@@ -105,19 +105,15 @@ static void ioc3_irq_handler(struct irq_desc *desc)
 	struct ioc3_priv_data *ipd = domain->host_data;
 	struct ioc3 __iomem *regs = ipd->regs;
 	u32 pending, mask;
-	unsigned int irq;
 
 	pending = readl(&regs->sio_ir);
 	mask = readl(&regs->sio_ies);
 	pending &= mask; /* Mask off not enabled interrupts */
 
-	if (pending) {
-		irq = irq_find_mapping(domain, __ffs(pending));
-		if (irq)
-			generic_handle_irq(irq);
-	} else  {
+	if (pending)
+		generic_handle_domain_irq(domain, __ffs(pending));
+	else
 		spurious_interrupt();
-	}
 }
 
 /*
diff --git a/drivers/mfd/qcom-pm8xxx.c b/drivers/mfd/qcom-pm8xxx.c
index acd172d..ec18a04 100644
--- a/drivers/mfd/qcom-pm8xxx.c
+++ b/drivers/mfd/qcom-pm8xxx.c
@@ -122,7 +122,7 @@ bail:
 
 static int pm8xxx_irq_block_handler(struct pm_irq_chip *chip, int block)
 {
-	int pmirq, irq, i, ret = 0;
+	int pmirq, i, ret = 0;
 	unsigned int bits;
 
 	ret = pm8xxx_read_block_irq(chip, block, &bits);
@@ -139,8 +139,7 @@ static int pm8xxx_irq_block_handler(struct pm_irq_chip *chip, int block)
 	for (i = 0; i < 8; i++) {
 		if (bits & (1 << i)) {
 			pmirq = block * 8 + i;
-			irq = irq_find_mapping(chip->irqdomain, pmirq);
-			generic_handle_irq(irq);
+			generic_handle_domain_irq(chip->irqdomain, pmirq);
 		}
 	}
 	return 0;
@@ -199,7 +198,7 @@ static void pm8xxx_irq_handler(struct irq_desc *desc)
 static void pm8821_irq_block_handler(struct pm_irq_chip *chip,
 				     int master, int block)
 {
-	int pmirq, irq, i, ret;
+	int pmirq, i, ret;
 	unsigned int bits;
 
 	ret = regmap_read(chip->regmap,
@@ -216,8 +215,7 @@ static void pm8821_irq_block_handler(struct pm_irq_chip *chip,
 	for (i = 0; i < 8; i++) {
 		if (bits & BIT(i)) {
 			pmirq = block * 8 + i;
-			irq = irq_find_mapping(chip->irqdomain, pmirq);
-			generic_handle_irq(irq);
+			generic_handle_domain_irq(chip->irqdomain, pmirq);
 		}
 	}
 }
