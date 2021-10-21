Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CEAC4369FF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 20:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232592AbhJUSGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 14:06:03 -0400
Received: from foss.arm.com ([217.140.110.172]:46156 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232492AbhJUSFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 14:05:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E42B7ED1;
        Thu, 21 Oct 2021 11:03:31 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 118EC3F70D;
        Thu, 21 Oct 2021 11:03:28 -0700 (PDT)
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
Subject: [PATCH 11/15] irq: csky: perform irqentry in entry code
Date:   Thu, 21 Oct 2021 19:02:32 +0100
Message-Id: <20211021180236.37428-12-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20211021180236.37428-1-mark.rutland@arm.com>
References: <20211021180236.37428-1-mark.rutland@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for removing HANDLE_DOMAIN_IRQ_IRQENTRY, have arch/csky
perform all the irqentry accounting in its entry code. As arch/csky uses
GENERIC_IRQ_MULTI_HANDLER, we can use generic_handle_arch_irq() to do
so.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Guo Ren <guoren@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 arch/csky/Kconfig        | 1 -
 arch/csky/kernel/entry.S | 2 +-
 arch/csky/kernel/irq.c   | 5 -----
 3 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 45f03f674a61..9d4d898df76b 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -18,7 +18,6 @@ config CSKY
 	select DMA_DIRECT_REMAP
 	select IRQ_DOMAIN
 	select HANDLE_DOMAIN_IRQ
-	select HANDLE_DOMAIN_IRQ_IRQENTRY
 	select DW_APB_TIMER_OF
 	select GENERIC_IOREMAP
 	select GENERIC_LIB_ASHLDI3
diff --git a/arch/csky/kernel/entry.S b/arch/csky/kernel/entry.S
index 00e3c8ebf9b8..a4ababf25e24 100644
--- a/arch/csky/kernel/entry.S
+++ b/arch/csky/kernel/entry.S
@@ -249,7 +249,7 @@ ENTRY(csky_irq)
 
 
 	mov	a0, sp
-	jbsr	csky_do_IRQ
+	jbsr	generic_handle_arch_irq
 
 	jmpi	ret_from_exception
 
diff --git a/arch/csky/kernel/irq.c b/arch/csky/kernel/irq.c
index 03a1930f1cbb..fcdaf3156286 100644
--- a/arch/csky/kernel/irq.c
+++ b/arch/csky/kernel/irq.c
@@ -15,8 +15,3 @@ void __init init_IRQ(void)
 	setup_smp_ipi();
 #endif
 }
-
-asmlinkage void __irq_entry csky_do_IRQ(struct pt_regs *regs)
-{
-	handle_arch_irq(regs);
-}
-- 
2.11.0

