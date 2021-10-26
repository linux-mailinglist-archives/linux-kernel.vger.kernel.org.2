Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B381D43AF01
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 11:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234826AbhJZJ2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 05:28:16 -0400
Received: from foss.arm.com ([217.140.110.172]:55524 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234883AbhJZJ2G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 05:28:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 742FF101E;
        Tue, 26 Oct 2021 02:25:42 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C67953F70D;
        Tue, 26 Oct 2021 02:25:39 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     aou@eecs.berkeley.edu, catalin.marinas@arm.com,
        deanbo422@gmail.com, green.hu@gmail.com, guoren@kernel.org,
        jonas@southpole.se, kernelfans@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk,
        mark.rutland@arm.com, maz@kernel.org, nickhu@andestech.com,
        palmer@dabbelt.com, paul.walmsley@sifive.com, shorne@gmail.com,
        stefan.kristiansson@saunalahti.fi, tglx@linutronix.de,
        tsbogend@alpha.franken.de, vgupta@kernel.org,
        vladimir.murzin@arm.com, will@kernel.org
Subject: [PATCH v2 08/17] irq: arc: avoid CONFIG_HANDLE_DOMAIN_IRQ
Date:   Tue, 26 Oct 2021 10:24:55 +0100
Message-Id: <20211026092504.27071-9-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20211026092504.27071-1-mark.rutland@arm.com>
References: <20211026092504.27071-1-mark.rutland@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for removing HANDLE_DOMAIN_IRQ, have arch/arc perform all
the necessary IRQ entry accounting in its entry code.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vineet Gupta <vgupta@kernel.org>
---
 arch/arc/Kconfig      |  1 -
 arch/arc/kernel/irq.c | 10 +++++++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index 3a5a80f302e1..b4ae6058902a 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -40,7 +40,6 @@ config ARC
 	select HAVE_KRETPROBES
 	select HAVE_MOD_ARCH_SPECIFIC
 	select HAVE_PERF_EVENTS
-	select HANDLE_DOMAIN_IRQ
 	select IRQ_DOMAIN
 	select MODULES_USE_ELF_RELA
 	select OF
diff --git a/arch/arc/kernel/irq.c b/arch/arc/kernel/irq.c
index ef909dd4b40c..dd09b58ff82d 100644
--- a/arch/arc/kernel/irq.c
+++ b/arch/arc/kernel/irq.c
@@ -6,6 +6,8 @@
 #include <linux/interrupt.h>
 #include <linux/irqchip.h>
 #include <asm/mach_desc.h>
+
+#include <asm/irq_regs.h>
 #include <asm/smp.h>
 
 /*
@@ -39,5 +41,11 @@ void __init init_IRQ(void)
  */
 void arch_do_IRQ(unsigned int hwirq, struct pt_regs *regs)
 {
-	handle_domain_irq(NULL, hwirq, regs);
+	struct pt_regs *old_regs;
+
+	irq_enter();
+	old_regs = set_irq_regs(regs);
+	generic_handle_domain_irq(NULL, hwirq);
+	set_irq_regs(old_regs);
+	irq_exit();
 }
-- 
2.11.0

