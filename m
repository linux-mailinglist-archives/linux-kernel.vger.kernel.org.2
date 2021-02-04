Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 750393101F9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 02:01:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbhBEBBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 20:01:10 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44170 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232419AbhBEA7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 19:59:15 -0500
Message-Id: <20210204211155.305801067@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612486683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=0UQXwmxLr+d5nTNP01N+SrJzGc9QSdB+ADgNfdzkynA=;
        b=i70H6BnE0nUAjhhwrCofBCtV7De6Mz90z/Th0lm75oIc4QIycikryUjAsMq4IhEORfLoce
        ECmcvWzxClLqrx9M3S1LzO46yko/mgr/obP8dXW6iwVtrzkKqcIhjNXPJrDT6eyQs5YFR2
        2LKF4M8maz0zlOVxfOpAwCbEm/WYwkQcysjXOxqZ1uys2n2zOO+l2AUYGTmZpYlY9DsqTW
        1BzOevjY4CJ/ycT+y177T2HVF6Znapkw5N+z0l6/57hLFivPyrW6A0K5wDnPbNlaPnziMb
        VNNzxCHeGAz6KVwdcwY1zqZYY12G/cNlaFhOTGG/rUebnWQwee8p2PnlSC4tDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612486683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=0UQXwmxLr+d5nTNP01N+SrJzGc9QSdB+ADgNfdzkynA=;
        b=s9VbjsYCopQvMRrFMKS45rnGsYNA+Yar1VWWyJiDYlBNLuoPH+duJ18rx+BoU+ejUy9dET
        JeW59hzYAzfR1jCg==
Date:   Thu, 04 Feb 2021 21:49:15 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@chromium.org>
Subject: [patch 12/12] x86/softirq/64: Inline do_softirq_own_stack()
References: <20210204204903.350275743@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no reason to have this as a seperate function for a single caller.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/irq.h       |    3 +++
 arch/x86/include/asm/irq_stack.h |    3 +--
 arch/x86/kernel/irq_64.c         |    5 -----
 3 files changed, 4 insertions(+), 7 deletions(-)

--- a/arch/x86/include/asm/irq.h
+++ b/arch/x86/include/asm/irq.h
@@ -26,6 +26,9 @@ static inline int irq_canonicalize(int i
 extern int irq_init_percpu_irqstack(unsigned int cpu);
 
 #define __ARCH_HAS_DO_SOFTIRQ
+#ifdef CONFIG_X86_64
+#define __ARCH_HAS_DO_SOFTIRQ_INLINE
+#endif
 
 struct irq_desc;
 
--- a/arch/x86/include/asm/irq_stack.h
+++ b/arch/x86/include/asm/irq_stack.h
@@ -200,7 +200,7 @@
  * interrupts are pending to be processed. The interrupt stack cannot be in
  * use here.
  */
-#define run_softirq_on_irqstack()					\
+#define do_softirq_own_stack()						\
 {									\
 	__this_cpu_write(hardirq_stack_inuse, true);			\
 	__call_on_irqstack(__do_softirq, ASM_CALL_SOFTIRQ);		\
@@ -208,7 +208,6 @@
 }
 
 #else /* CONFIG_X86_64 */
-
 /* System vector handlers always run on the stack they interrupted. */
 #define run_sysvec_on_irqstack_cond(func, regs)				\
 {									\
--- a/arch/x86/kernel/irq_64.c
+++ b/arch/x86/kernel/irq_64.c
@@ -73,8 +73,3 @@ int irq_init_percpu_irqstack(unsigned in
 		return 0;
 	return map_irq_stack(cpu);
 }
-
-void do_softirq_own_stack(void)
-{
-	run_softirq_on_irqstack();
-}

