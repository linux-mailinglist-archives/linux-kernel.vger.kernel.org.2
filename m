Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 678F8436A02
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 20:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbhJUSGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 14:06:09 -0400
Received: from foss.arm.com ([217.140.110.172]:46186 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232524AbhJUSFv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 14:05:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 832861474;
        Thu, 21 Oct 2021 11:03:35 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A3FEA3F70D;
        Thu, 21 Oct 2021 11:03:32 -0700 (PDT)
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
Subject: [PATCH 12/15] irq: openrisc: perform irqentry in entry code
Date:   Thu, 21 Oct 2021 19:02:33 +0100
Message-Id: <20211021180236.37428-13-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20211021180236.37428-1-mark.rutland@arm.com>
References: <20211021180236.37428-1-mark.rutland@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for removing HANDLE_DOMAIN_IRQ_IRQENTRY, have
arch/openrisc perform all the irqentry accounting in its entry code. As
arch/openrisc uses GENERIC_IRQ_MULTI_HANDLER, we can use
generic_handle_arch_irq() to do so.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Jonas Bonn <jonas@southpole.se>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Stafford Horne <shorne@gmail.com>
Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 arch/openrisc/Kconfig        | 1 -
 arch/openrisc/kernel/entry.S | 4 ++--
 arch/openrisc/kernel/irq.c   | 5 -----
 3 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index ed783a67065e..e804026b4797 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -14,7 +14,6 @@ config OPENRISC
 	select OF_EARLY_FLATTREE
 	select IRQ_DOMAIN
 	select HANDLE_DOMAIN_IRQ
-	select HANDLE_DOMAIN_IRQ_IRQENTRY
 	select GPIOLIB
 	select HAVE_ARCH_TRACEHOOK
 	select SPARSE_IRQ
diff --git a/arch/openrisc/kernel/entry.S b/arch/openrisc/kernel/entry.S
index edaa775a648e..59c6d3aa7081 100644
--- a/arch/openrisc/kernel/entry.S
+++ b/arch/openrisc/kernel/entry.S
@@ -569,8 +569,8 @@ EXCEPTION_ENTRY(_external_irq_handler)
 #endif
 	CLEAR_LWA_FLAG(r3)
 	l.addi	r3,r1,0
-	l.movhi	r8,hi(do_IRQ)
-	l.ori	r8,r8,lo(do_IRQ)
+	l.movhi	r8,hi(generic_handle_arch_irq)
+	l.ori	r8,r8,lo(generic_handle_arch_irq)
 	l.jalr r8
 	l.nop
 	l.j    _ret_from_intr
diff --git a/arch/openrisc/kernel/irq.c b/arch/openrisc/kernel/irq.c
index c38fa863afa8..f38e10962a84 100644
--- a/arch/openrisc/kernel/irq.c
+++ b/arch/openrisc/kernel/irq.c
@@ -36,8 +36,3 @@ void __init init_IRQ(void)
 {
 	irqchip_init();
 }
-
-void __irq_entry do_IRQ(struct pt_regs *regs)
-{
-	handle_arch_irq(regs);
-}
-- 
2.11.0

