Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26B7F3A3191
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 18:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbhFJQ7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 12:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbhFJQ7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 12:59:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D0EC061574
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 09:57:51 -0700 (PDT)
Date:   Thu, 10 Jun 2021 16:57:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623344270;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZAnsUZBilhQeYN2bR/1xyooRu56/hvG3LZgLZSOZ7xs=;
        b=jGPmhPlEicuWRGNP0Yllahib7+OO6IeHNLoiORQLmZXREWtghSGV/KoHqPITEgrgByQerC
        9PLMScbdvAc08axZ3MR7milRjkYsG+0zQO6P1dx97ba1TU1MbMGQZdm4bHcGO/AZWyHa8E
        SkswmCBjpmRu/yof0rA0q4wwFuucs6WkWEkNrMc1BgJBiJQZ+hvjtmX2c0UEqaBK/Lhu1T
        NN5YZCtMfOd+fqQlaEPQTuJwdrDLPlvyE74VdYc3poa2B7JSdMLgJxMggaMBnd82vtGf+8
        Q07HfSIVtTsWM1p/JYTwI9k3hRWBTmmrIKsh3/x1QnVJ7fZz+LNKWNCnbf4Eow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623344270;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZAnsUZBilhQeYN2bR/1xyooRu56/hvG3LZgLZSOZ7xs=;
        b=6GF7Y93KEowfcdF7f+srBAlVCO/B5yxlv/3MdEnKBpmiqYMbmplBO3efwv+sgWxuaR+YeT
        0Xn1rDEY13cNH8Bw==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-fixes] irqchip/gic-v3: Workaround inconsistent
 PMR setting on NMI entry
Cc:     Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>,
        tglx@linutronix.de
In-Reply-To: <20210610145731.1350460-1-maz@kernel.org>
References: <20210610145731.1350460-1-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <162334426931.29796.11019839661838482909.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-fixes branch of irqchip:

Commit-ID:     382e6e177bc1c02473e56591fe5083ae1e4904f6
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/382e6e177bc1c02473e56591fe5083ae1e4904f6
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Thu, 10 Jun 2021 15:13:46 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 10 Jun 2021 17:54:34 +01:00

irqchip/gic-v3: Workaround inconsistent PMR setting on NMI entry

The arm64 entry code suffers from an annoying issue on taking
a NMI, as it sets PMR to a value that actually allows IRQs
to be acknowledged. This is done for consistency with other parts
of the code, and is in the process of being fixed. This shouldn't
be a problem, as we are not enabling interrupts whilst in NMI
context.

However, in the infortunate scenario that we took a spurious NMI
(retired before the read of IAR) *and* that there is an IRQ pending
at the same time, we'll ack the IRQ in NMI context. Too bad.

In order to avoid deadlocks while running something like perf,
teach the GICv3 driver about this situation: if we were in
a context where no interrupt should have fired, transiently
set PMR to a value that only allows NMIs before acking the pending
interrupt, and restore the original value after that.

This papers over the core issue for the time being, and makes
NMIs great again. Sort of.

Fixes: 4d6a38da8e79e94c ("arm64: entry: always set GIC_PRIO_PSR_I_SET during entry")
Co-developed-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Link: https://lore.kernel.org/lkml/20210610145731.1350460-1-maz@kernel.org
---
 drivers/irqchip/irq-gic-v3.c | 36 ++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 37a23aa..66d623f 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -642,11 +642,45 @@ static inline void gic_handle_nmi(u32 irqnr, struct pt_regs *regs)
 		nmi_exit();
 }
 
+static u32 do_read_iar(struct pt_regs *regs)
+{
+	u32 iar;
+
+	if (gic_supports_nmi() && unlikely(!interrupts_enabled(regs))) {
+		u64 pmr;
+
+		/*
+		 * We were in a context with IRQs disabled. However, the
+		 * entry code has set PMR to a value that allows any
+		 * interrupt to be acknowledged, and not just NMIs. This can
+		 * lead to surprising effects if the NMI has been retired in
+		 * the meantime, and that there is an IRQ pending. The IRQ
+		 * would then be taken in NMI context, something that nobody
+		 * wants to debug twice.
+		 *
+		 * Until we sort this, drop PMR again to a level that will
+		 * actually only allow NMIs before reading IAR, and then
+		 * restore it to what it was.
+		 */
+		pmr = gic_read_pmr();
+		gic_pmr_mask_irqs();
+		isb();
+
+		iar = gic_read_iar();
+
+		gic_write_pmr(pmr);
+	} else {
+		iar = gic_read_iar();
+	}
+
+	return iar;
+}
+
 static asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs)
 {
 	u32 irqnr;
 
-	irqnr = gic_read_iar();
+	irqnr = do_read_iar(regs);
 
 	/* Check for special IDs first */
 	if ((irqnr >= 1020 && irqnr <= 1023))
