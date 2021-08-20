Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BFE13F2DA4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 16:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240712AbhHTOFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 10:05:52 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53758 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235032AbhHTOFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 10:05:49 -0400
Date:   Fri, 20 Aug 2021 14:05:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629468311;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TpcTjWZKzVRRtccsZRN5QtMYbe/0j5rAzzGCNx2W10M=;
        b=0cK4oa+7gwNtkSs4IlubpSyfRxQRyRtcOWAIllLfqJq0nmHeiR6LMRoYp6LguMsCO9C1c3
        oFV8rYWrP8skHo2ZHjhKsfCNWTEv+tp79ky6lBC24qdqF7YgvurKWr4z5+Kzg2QXYrbCHQ
        bCWQD+L+gifqx7DAmloPC/FFPHMLsz7VBkrqZtCZldEsGMn1wvfgz+BaIM5FGotWzR5LJP
        hP6lUFjHtVJ4z+tfPkr3lHuHlpqAy4drsNCMljk7lGhcXgyvo1svZfb2z5bMMFv5hvCZRm
        WC3eoV8dH7APRT8KFVPKAV6lUO17bIE7n5Jk/wQALZbkhN6YF83BWvvBtE6Nsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629468311;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TpcTjWZKzVRRtccsZRN5QtMYbe/0j5rAzzGCNx2W10M=;
        b=zQGiTykOsrfKTy0DEAAGlkEIA3b2QZX1jS3m3QD02JY09LSd2yTjqg2P27Rk9F06uklt+n
        IKNBmtwU368bN9DQ==
From:   "irqchip-bot for Chen-Yu Tsai" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/gic-v3: Fix priority comparison
 when non-secure priorities are used
Cc:     Alexandru Elisei <alexandru.elisei@arm.com>,
        "Chen-Yu Tsai" <wenst@chromium.org>, Marc Zyngier <maz@kernel.org>,
        tglx@linutronix.de
In-Reply-To: <20210811171505.1502090-1-wenst@chromium.org>
References: <20210811171505.1502090-1-wenst@chromium.org>
MIME-Version: 1.0
Message-ID: <162946831024.25758.4994395897895383919.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     8d474deaba2c4dd33a5e2f5be82e6798ffa6b8a5
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/8d474deaba2c4dd33a5e2f5be82e6798ffa6b8a5
Author:        Chen-Yu Tsai <wenst@chromium.org>
AuthorDate:    Thu, 12 Aug 2021 01:15:05 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 20 Aug 2021 15:03:01 +01:00

irqchip/gic-v3: Fix priority comparison when non-secure priorities are used

When non-secure priorities are used, compared to the raw priority set,
the value read back from RPR is also right-shifted by one and the
highest bit set.

Add a macro to do the modifications to the raw priority when doing the
comparison against the RPR value. This corrects the pseudo-NMI behavior
when non-secure priorities in the GIC are used. Tested on 5.10 with
the "IPI as pseudo-NMI" series [1] applied on MT8195.

[1] https://lore.kernel.org/linux-arm-kernel/1604317487-14543-1-git-send-email-sumit.garg@linaro.org/

Fixes: 336780590990 ("irqchip/gic-v3: Support pseudo-NMIs when SCR_EL3.FIQ == 0")
Reviewed-by: Alexandru Elisei <alexandru.elisei@arm.com>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
[maz: Added comment contributed by Alex]
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20210811171505.1502090-1-wenst@chromium.org
---
 drivers/irqchip/irq-gic-v3.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index e0f4deb..3e61210 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -100,6 +100,27 @@ EXPORT_SYMBOL(gic_pmr_sync);
 DEFINE_STATIC_KEY_FALSE(gic_nonsecure_priorities);
 EXPORT_SYMBOL(gic_nonsecure_priorities);
 
+/*
+ * When the Non-secure world has access to group 0 interrupts (as a
+ * consequence of SCR_EL3.FIQ == 0), reading the ICC_RPR_EL1 register will
+ * return the Distributor's view of the interrupt priority.
+ *
+ * When GIC security is enabled (GICD_CTLR.DS == 0), the interrupt priority
+ * written by software is moved to the Non-secure range by the Distributor.
+ *
+ * If both are true (which is when gic_nonsecure_priorities gets enabled),
+ * we need to shift down the priority programmed by software to match it
+ * against the value returned by ICC_RPR_EL1.
+ */
+#define GICD_INT_RPR_PRI(priority)					\
+	({								\
+		u32 __priority = (priority);				\
+		if (static_branch_unlikely(&gic_nonsecure_priorities))	\
+			__priority = 0x80 | (__priority >> 1);		\
+									\
+		__priority;						\
+	})
+
 /* ppi_nmi_refs[n] == number of cpus having ppi[n + 16] set as NMI */
 static refcount_t *ppi_nmi_refs;
 
@@ -687,7 +708,7 @@ static asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs
 		return;
 
 	if (gic_supports_nmi() &&
-	    unlikely(gic_read_rpr() == GICD_INT_NMI_PRI)) {
+	    unlikely(gic_read_rpr() == GICD_INT_RPR_PRI(GICD_INT_NMI_PRI))) {
 		gic_handle_nmi(irqnr, regs);
 		return;
 	}
