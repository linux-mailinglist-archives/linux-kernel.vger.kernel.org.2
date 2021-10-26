Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 604EB43AFDD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 12:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235469AbhJZKTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 06:19:03 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60772 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235205AbhJZKSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 06:18:33 -0400
Date:   Tue, 26 Oct 2021 10:16:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635243369;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=V0bbGh+99Yt9EfS1JMBkaE7N8DizNnuCCaUQNqHSp/o=;
        b=exdgV9x1crqEMzPim6OSWOxltwAOyU8ZEODVvBMeQu+3plCAhFSOg+jq3D5I4ea7l2DF6y
        qWfRqQbWK1T7MK2jrQQb2ADCfurU3YV7Uf0547eQe5g6/pLzuyGWNiRhHmMilV/++UWNG8
        U/xUq1UDj1D5qVPvNehsniphqweVr5fMH83uswXQDbmNJvCU+tJCtXgmjPvEFLcoR4yEUr
        U5RAnz7Z1nA/9ejogo34xUSz9NPsW98vcXB+Jp5pz3lRX67+zhM5mOyIN32MnxosZ1XE9r
        rnm6LJXHGWL1bSTVN18k1zVl+aa7u5FBJjWodlQzzOgHeWakWxJ92NHdnEtU/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635243369;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=V0bbGh+99Yt9EfS1JMBkaE7N8DizNnuCCaUQNqHSp/o=;
        b=KkdFbgVgCNu7ADlAWZj5WvI0zTPiV34W/JNV04JeLpyR00+E38gEwd0j8mg9sr9JDEWCeB
        8TZbBfBxP5u1/lBQ==
From:   "irqchip-bot for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irq: mips: simplify do_domain_IRQ()
Cc:     Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>
MIME-Version: 1.0
Message-ID: <163524336834.626.3133187281059908061.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     4cb6f4df976b288aa02bbb658d38e73d34d8231f
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/4cb6f4df976b288aa02bbb658d38e73d34d8231f
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Wed, 20 Oct 2021 18:20:32 +01:00
Committer:     Mark Rutland <mark.rutland@arm.com>
CommitterDate: Mon, 25 Oct 2021 10:05:08 +01:00

irq: mips: simplify do_domain_IRQ()

There's no need fpr arch/mips's do_domain_IRQ() to open-code the NULL
check performed by handle_irq_desc(), nor the resolution of the desc
performed by generic_handle_domain_irq().

Use generic_handle_domain_irq() directly, as this is functioanlly
equivalent and clearer.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 arch/mips/kernel/irq.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/mips/kernel/irq.c b/arch/mips/kernel/irq.c
index d20e002..1fee96e 100644
--- a/arch/mips/kernel/irq.c
+++ b/arch/mips/kernel/irq.c
@@ -115,11 +115,7 @@ void __irq_entry do_domain_IRQ(struct irq_domain *domain, unsigned int hwirq)
 
 	irq_enter();
 	check_stack_overflow();
-
-	desc = irq_resolve_mapping(domain, hwirq);
-	if (likely(desc))
-		handle_irq_desc(desc);
-
+	generic_handle_domain_irq(domain, hwirq);
 	irq_exit();
 }
 #endif
