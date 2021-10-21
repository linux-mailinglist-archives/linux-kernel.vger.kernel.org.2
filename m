Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 714204369F7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 20:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbhJUSFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 14:05:25 -0400
Received: from foss.arm.com ([217.140.110.172]:45950 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232481AbhJUSFU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 14:05:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11C74147A;
        Thu, 21 Oct 2021 11:03:04 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 34BDF3F70D;
        Thu, 21 Oct 2021 11:03:01 -0700 (PDT)
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
Subject: [PATCH 05/15] irq: add generic_handle_arch_irq()
Date:   Thu, 21 Oct 2021 19:02:26 +0100
Message-Id: <20211021180236.37428-6-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20211021180236.37428-1-mark.rutland@arm.com>
References: <20211021180236.37428-1-mark.rutland@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several architectures select GENERIC_IRQ_MULTI_HANDLER and branch to
handle_arch_irq() without performing any entry accounting.

Add a generic wrapper to handle the commoon irqentry work when invoking
handle_arch_irq(). Where an architecture needs to perform some entry
accounting itself, it will need to invoke handle_arch_irq() itself.

In subsequent patches it will become the responsibilty of the entry code
to set the irq regs when entering an IRQ (rather than deferring this to
an irqchip handler), so generic_handle_arch_irq() is made to set the irq
regs now. This can be redundant in some cases, but is never harmful as
saving/restoring the old regs nests safely.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/irq/handle.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/kernel/irq/handle.c b/kernel/irq/handle.c
index 221d80c31e94..27182003b879 100644
--- a/kernel/irq/handle.c
+++ b/kernel/irq/handle.c
@@ -14,6 +14,8 @@
 #include <linux/interrupt.h>
 #include <linux/kernel_stat.h>
 
+#include <asm/irq_regs.h>
+
 #include <trace/events/irq.h>
 
 #include "internals.h"
@@ -226,4 +228,20 @@ int __init set_handle_irq(void (*handle_irq)(struct pt_regs *))
 	handle_arch_irq = handle_irq;
 	return 0;
 }
+
+/**
+ * generic_handle_arch_irq - root irq handler for architectures which do no
+ *                           entry accounting themselves
+ * @regs:	Register file coming from the low-level handling code
+ */
+asmlinkage void noinstr generic_handle_arch_irq(struct pt_regs *regs)
+{
+	struct pt_regs *old_regs;
+
+	irq_enter();
+	old_regs = set_irq_regs(regs);
+	handle_arch_irq(regs);
+	set_irq_regs(old_regs);
+	irq_exit();
+}
 #endif
-- 
2.11.0

