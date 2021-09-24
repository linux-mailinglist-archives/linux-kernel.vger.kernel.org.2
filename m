Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DDE5417846
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 18:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347348AbhIXQOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 12:14:38 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42870 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347338AbhIXQOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 12:14:35 -0400
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632499980;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=4lapy/yC4f0UhAYwV/k1tU4YZt1iWY92d7YZyKJuqHw=;
        b=JbyC+OlidjI0bqR3NOw41YIYvpK0Kbd1bk5TZtNrYrDN+KfgnL/uEubVB1FEklkVfdiYxb
        +mxiqydzxMy87DCgfyT3muuQOD1u0z5VQ4lqlQY8FOYnmufpdHgvMN5/CRTzoSixWdrZqw
        E9SwqsO2Uut1IQ09Rs+/bF5Ak/3ee5YNrr3qAjrTiU+ING1LOGbAKuGQwQCZD1qUUxe4bt
        ozywP9ntFAbwhw5lzyqcWE56QDK5j8IqeZBxYRo66u9anYGm3wTluh07TH6dL3I/wiO6C/
        wi4dEv45ZfgJpNRNEMN7/xDEqF2p+wMDkVcigR53Qw1jbaPyRIZvl9mYVtiQbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632499980;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=4lapy/yC4f0UhAYwV/k1tU4YZt1iWY92d7YZyKJuqHw=;
        b=+Zu8diImx10D1c9u+hg/sTgnigU0c4fvG00m2XDG227ogJR4s382X0v3kAlHhvlV5WW+yb
        GC0478WQi5XCz4Dw==
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] x86/softirq: Disable softirq stacks on PREEMPT_RT
Date:   Fri, 24 Sep 2021 18:12:45 +0200
Message-Id: <20210924161245.2357247-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

PREEMPT_RT preempts softirqs and the current implementation avoids
do_softirq_own_stack() and only uses __do_softirq().

Disable the unused softirqs stacks on PREEMPT_RT to safe some memory and
ensure that do_softirq_own_stack() is not used which is not expected.

[bigeasy: commit description.]

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/x86/include/asm/irq_stack.h |    3 +++
 arch/x86/kernel/irq_32.c         |    2 ++
 2 files changed, 5 insertions(+)

--- a/arch/x86/include/asm/irq_stack.h
+++ b/arch/x86/include/asm/irq_stack.h
@@ -185,6 +185,7 @@
 			      IRQ_CONSTRAINTS, regs, vector);		\
 }
=20
+#ifndef CONFIG_PREEMPT_RT
 #define ASM_CALL_SOFTIRQ						\
 	"call %P[__func]				\n"
=20
@@ -201,6 +202,8 @@
 	__this_cpu_write(hardirq_stack_inuse, false);			\
 }
=20
+#endif
+
 #else /* CONFIG_X86_64 */
 /* System vector handlers always run on the stack they interrupted. */
 #define run_sysvec_on_irqstack_cond(func, regs)				\
--- a/arch/x86/kernel/irq_32.c
+++ b/arch/x86/kernel/irq_32.c
@@ -132,6 +132,7 @@ int irq_init_percpu_irqstack(unsigned in
 	return 0;
 }
=20
+#ifndef CONFIG_PREEMPT_RT
 void do_softirq_own_stack(void)
 {
 	struct irq_stack *irqstk;
@@ -148,6 +149,7 @@ void do_softirq_own_stack(void)
=20
 	call_on_stack(__do_softirq, isp);
 }
+#endif
=20
 void __handle_irq(struct irq_desc *desc, struct pt_regs *regs)
 {
