Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A728F4369F6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 20:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232482AbhJUSFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 14:05:20 -0400
Received: from foss.arm.com ([217.140.110.172]:45914 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232420AbhJUSFQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 14:05:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 719691477;
        Thu, 21 Oct 2021 11:03:00 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 918193F70D;
        Thu, 21 Oct 2021 11:02:57 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     aou@eecs.berkeley.edu, catalin.marinas@arm.com,
        deanbo422@gmail.com, green.hu@gmail.com, guoren@kernel.org,
        jonas@southpole.se, kernelfans@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk,
        mark.rutland@arm.com, maz@kernel.org, nickhu@andestech.com,
        palmer@dabbelt.com, paulmck@kernel.org, paul.walmsley@sifive.com,
        peterz@infradead.org, shorne@gmail.com,
        stefan.kristiansson@saunalahti.fi, tglx@linutronix.de,
        torvalds@linux-foundation.org, tsbogend@alpha.franken.de,
        vgupta@kernel.org, will@kernel.org
Subject: [PATCH 04/15] irq: simplify handle_domain_{irq,nmi}()
Date:   Thu, 21 Oct 2021 19:02:25 +0100
Message-Id: <20211021180236.37428-5-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20211021180236.37428-1-mark.rutland@arm.com>
References: <20211021180236.37428-1-mark.rutland@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no need for handle_domain_{irq,nmi}() to open-code the NULL
check performed by handle_irq_desc(), nor the resolution of the desc
performed by generic_handle_domain_irq().

Use generic_handle_domain_irq() directly, as this is functioanlly
equivalent and clearer. At the same time, delete the stale comments,
which are no longer helpful.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/irq/irqdesc.c | 24 ++++--------------------
 1 file changed, 4 insertions(+), 20 deletions(-)

diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 4e3c29bb603c..b07d0e1552bc 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -690,17 +690,11 @@ int handle_domain_irq(struct irq_domain *domain,
 		      unsigned int hwirq, struct pt_regs *regs)
 {
 	struct pt_regs *old_regs = set_irq_regs(regs);
-	struct irq_desc *desc;
-	int ret = 0;
+	int ret;
 
 	irq_enter();
 
-	/* The irqdomain code provides boundary checks */
-	desc = irq_resolve_mapping(domain, hwirq);
-	if (likely(desc))
-		handle_irq_desc(desc);
-	else
-		ret = -EINVAL;
+	ret = generic_handle_domain_irq(domain, hwirq);
 
 	irq_exit();
 	set_irq_regs(old_regs);
@@ -721,24 +715,14 @@ int handle_domain_nmi(struct irq_domain *domain, unsigned int hwirq,
 		      struct pt_regs *regs)
 {
 	struct pt_regs *old_regs = set_irq_regs(regs);
-	struct irq_desc *desc;
-	int ret = 0;
+	int ret;
 
 	/*
 	 * NMI context needs to be setup earlier in order to deal with tracing.
 	 */
 	WARN_ON(!in_nmi());
 
-	desc = irq_resolve_mapping(domain, hwirq);
-
-	/*
-	 * ack_bad_irq is not NMI-safe, just report
-	 * an invalid interrupt.
-	 */
-	if (likely(desc))
-		handle_irq_desc(desc);
-	else
-		ret = -EINVAL;
+	ret = generic_handle_domain_irq(domain, hwirq);
 
 	set_irq_regs(old_regs);
 	return ret;
-- 
2.11.0

