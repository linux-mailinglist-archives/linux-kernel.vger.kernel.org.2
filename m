Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18EE23A2ED3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 16:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbhFJO7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 10:59:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:41720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231565AbhFJO7q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 10:59:46 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2EB56610A7;
        Thu, 10 Jun 2021 14:57:50 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=hot-poop.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1lrM7w-006l3o-0w; Thu, 10 Jun 2021 15:57:48 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        valentin.schneider@arm.com, kernel-team@android.com
Subject: [PATCH] irqchip/gic-v3: Workaround inconsistent PMR setting on NMI entry
Date:   Thu, 10 Jun 2021 15:57:31 +0100
Message-Id: <20210610145731.1350460-1-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com, will@kernel.org, catalin.marinas@arm.com, alexandru.elisei@arm.com, tglx@linutronix.de, valentin.schneider@arm.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Co-developed-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v3.c | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 37a23aa6de37..3d3502efb807 100644
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
+		 * We were in a context with interrupt disabled. However,
+		 * the entry code has set PMR to a value that allows any
+		 * interrupt to be acknowledged, and not just NMIs. This can
+		 * lead to surprising effects if the NMI has been retired in
+		 * the meantime, and that there is an IRQ pending. The IRQ
+		 * would then be taken in NMI context, something that nobody
+		 * wants to debug a second time.
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
-- 
2.30.2

