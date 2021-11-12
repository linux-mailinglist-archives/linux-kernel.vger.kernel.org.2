Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CEB944EB30
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 17:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235380AbhKLQR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 11:17:57 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:57472 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235256AbhKLQRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 11:17:53 -0500
Date:   Fri, 12 Nov 2021 16:15:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1636733701;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H4IexYcksaPPDD57PXmxvpsj8K+IfbPEum7f3FghIGo=;
        b=iMDUqj9oPGTaa4f4tm2Gfe4wfXmMV+NWtH+CSmkGE81LIUeD2GZlOQWBW/kcmwHkoS02d8
        4/YM7Kqi+Pe472KFkX70zkJGNTL5gLG2t12QpRd8KEUZ4LaDE2lHPU0+d1BN7RiSKJvY4/
        8n+PJaPh5NZAcWAx2Xs0pEJQAs/T79DPUPlhLTxeZ0O5t4O5cDVr+OiAsHJDa8aXAYa3pr
        TJi5Hw9vedCw7TAzK7qPQkWQng5+cFurRy1ZLxC/taDrAHAyOmrp04ZbK8rtW32Dc2vUSF
        volDqiolhNmsAgenJxlqnNPR4ZRv6XS2ZnPNN87XqM50owsJn+LzWGAuANScuw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1636733701;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H4IexYcksaPPDD57PXmxvpsj8K+IfbPEum7f3FghIGo=;
        b=h5nAmyPcGyCF6sTMKZ4FJHX5PbzRugocdNpC3EXcy8LXUtFx8ABhxvxz+sqIonUYsdqPAP
        JY9c1tFqfPMtKRCw==
From:   "irqchip-bot for Guo Ren" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-fixes] irqchip/csky-mpintc: Fixup mask/unmask
 implementation
Cc:     Guo Ren <guoren@linux.alibaba.com>, Marc Zyngier <maz@kernel.org>,
        tglx@linutronix.de
In-Reply-To: <20211101134534.3804542-1-guoren@kernel.org>
References: <20211101134534.3804542-1-guoren@kernel.org>
MIME-Version: 1.0
Message-ID: <163673370081.414.13388785651860452703.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-fixes branch of irqchip:

Commit-ID:     1cbb418b69ed28f3395c6208931843a53d3fbcbe
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/1cbb418b69ed28f3395c6208931843a53d3fbcbe
Author:        Guo Ren <guoren@linux.alibaba.com>
AuthorDate:    Mon, 01 Nov 2021 21:45:34 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 12 Nov 2021 16:09:50 

irqchip/csky-mpintc: Fixup mask/unmask implementation

The mask/unmask must be implemented, and enable/disable supplement
them if the HW requires something different at startup time. When
irq source is disabled by mask, mpintc could complete irq normally.

So drop enable/disable if favour of mask/unmask.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20211101134534.3804542-1-guoren@kernel.org
---
 drivers/irqchip/irq-csky-mpintc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-csky-mpintc.c b/drivers/irqchip/irq-csky-mpintc.c
index cb403c9..4aebd67 100644
--- a/drivers/irqchip/irq-csky-mpintc.c
+++ b/drivers/irqchip/irq-csky-mpintc.c
@@ -78,7 +78,7 @@ static void csky_mpintc_handler(struct pt_regs *regs)
 		readl_relaxed(reg_base + INTCL_RDYIR));
 }
 
-static void csky_mpintc_enable(struct irq_data *d)
+static void csky_mpintc_unmask(struct irq_data *d)
 {
 	void __iomem *reg_base = this_cpu_read(intcl_reg);
 
@@ -87,7 +87,7 @@ static void csky_mpintc_enable(struct irq_data *d)
 	writel_relaxed(d->hwirq, reg_base + INTCL_SENR);
 }
 
-static void csky_mpintc_disable(struct irq_data *d)
+static void csky_mpintc_mask(struct irq_data *d)
 {
 	void __iomem *reg_base = this_cpu_read(intcl_reg);
 
@@ -164,8 +164,8 @@ static int csky_irq_set_affinity(struct irq_data *d,
 static struct irq_chip csky_irq_chip = {
 	.name           = "C-SKY SMP Intc",
 	.irq_eoi	= csky_mpintc_eoi,
-	.irq_enable	= csky_mpintc_enable,
-	.irq_disable	= csky_mpintc_disable,
+	.irq_unmask	= csky_mpintc_unmask,
+	.irq_mask	= csky_mpintc_mask,
 	.irq_set_type	= csky_mpintc_set_type,
 #ifdef CONFIG_SMP
 	.irq_set_affinity = csky_irq_set_affinity,
