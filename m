Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E575B3EAD14
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 00:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238235AbhHLWWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 18:22:45 -0400
Received: from foss.arm.com ([217.140.110.172]:48570 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230089AbhHLWWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 18:22:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B5C481063;
        Thu, 12 Aug 2021 15:22:17 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CE9EF3F70D;
        Thu, 12 Aug 2021 15:22:16 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH irqchip-next] genirq: Let cond_unmask_eoi_irq() issue an EOI for non-masked IRQs
Date:   Thu, 12 Aug 2021 23:21:25 +0100
Message-Id: <20210812222125.2161112-1-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cond_unmask_eoi_irq() is invoked by the following flow handlers:

  handle_fasteoi_irq()
  handle_fasteoi_ack_irq()
  handle_fasteoi_mask_irq()
  handle_strict_flow_irq()

Unlike all the other handlers mentioned above, handle_strict_flow_irq()
is *not* guaranteed to have issued mask_irq() on a oneshot IRQ before
entering this function (it could be flow-masked instead).

If the primary handler of such an IRQ does not wake any threaded handler, we
will then fail to issue an EOI, which as per handle_strict_flow_irq() is a
big no-no.

Remove the check against irqd_irq_masked() in cond_unmask_eoi_irq(). The
handle_fasteoi_*() handlers remain unaffected as they unconditionally mask
oneshot IRQs, and handle_strict_flow_irq() will now issue an EOI for a
flow-masked IRQ which did not wake its thread.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
I was going through the stack again to refresh my memory when I found
this.

Force-threaded IRQs are unaffected as their primary handler is
irq_default_primary_handler() which unconditionally wakes the thread. Many
oneshot IRQs also have no primary handler, so they too get the
default. There *are* a handful out there with a primary handler that can
return something else than IRQ_WAKE_THREAD, so it does seem something we
wanna do.

If this needs a Fixes:, it would be:
32797fe1c8ee ("genirq: Don't mask IRQ within flow handler if IRQ is flow-masked")
---
 kernel/irq/chip.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 099bc7e13d1b..80d6291d355d 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -686,13 +686,11 @@ static void cond_unmask_eoi_irq(struct irq_desc *desc, struct irq_chip *chip)
 		return;
 	}
 	/*
-	 * We need to unmask in the following cases:
-	 * - Oneshot irq which did not wake the thread (caused by a
-	 *   spurious interrupt or a primary handler handling it
-	 *   completely).
+	 * We need to EOI and potentially unmask in case the oneshot irq did not
+	 * wake the thread (caused by a spurious interrupt or a primary handler
+	 * handling it completely).
 	 */
-	if (!irqd_irq_disabled(&desc->irq_data) &&
-	    irqd_irq_masked(&desc->irq_data) && !desc->threads_oneshot) {
+	if (!irqd_irq_disabled(&desc->irq_data) && !desc->threads_oneshot) {
 		eoi_irq(desc);
 		unmask_irq(desc);
 	} else if (!(chip->flags & IRQCHIP_EOI_THREADED)) {
-- 
2.25.1

