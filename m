Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C734B446E4E
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Nov 2021 15:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234349AbhKFO3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Nov 2021 10:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233927AbhKFO3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Nov 2021 10:29:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98551C061570
        for <linux-kernel@vger.kernel.org>; Sat,  6 Nov 2021 07:27:02 -0700 (PDT)
Date:   Sat, 06 Nov 2021 14:26:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1636208819;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2KBl8MA34EMRRPbDlCKsc2Begwi1HaRYh28Ldm6UI6s=;
        b=OFKB9PPsvm07Mg2l8X/CxrO9pfV6VdOXAyYcGdQZI23F7Hnf4kD4y7aR3PgPVEEi7ejIMx
        ho8NJZHtM/4DBxJ4/zPW3WVG/AnZeTVQG1bg3VlpVlj8+mIosWGz6LEtZXrW5JZ+v1ALPp
        Ns+FcKRw5Xy4oq6AQwEojJWDh0hoxGaP1GtTPPULnw35EHa2hMQRWd1nnz9pddj16caid1
        WyApLwdbdJAm07PBYppynneoqZ050UWJhkX4G2l53PTq9JB0IpfP8wDVpUxyBvObnTFFfV
        T27uzimqV//IInrOrUfNLvz4sEWJJVYkmVMQb0UUZci0aZE8uLW6HxoZpGqgFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1636208819;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2KBl8MA34EMRRPbDlCKsc2Begwi1HaRYh28Ldm6UI6s=;
        b=P5B+2lS4+IuueR0H5K0v0TgSk3OGsXdfDkkMBquWIf51ptJSrc81HqKLlvAY2mkul6hP9T
        83qN8mt4Noi+nGCg==
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
Message-ID: <163620881894.626.3664800589245836687.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-fixes branch of irqchip:

Commit-ID:     e5f041b6867f2990e55adb47482efc3653674de5
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/e5f041b6867f2990e55adb47482efc3653674de5
Author:        Guo Ren <guoren@linux.alibaba.com>
AuthorDate:    Mon, 01 Nov 2021 21:45:34 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sat, 06 Nov 2021 14:24:04 

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
