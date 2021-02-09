Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26929315CFC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 03:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235348AbhBJCMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 21:12:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234717AbhBJA44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 19:56:56 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D14C061794
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 16:53:43 -0800 (PST)
Message-Id: <20210210002513.382806685@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612918421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=D23ic3BaNnGldICy/Rvj1vt2CAADFX+q7tl1/gXyEhg=;
        b=Tje4rabqZnBBwT1c1/Z10BNq2oe8ZbyEz5gBtMgZnw8yb6lmZLe/LpyfbFUgUk6JA0Mkuv
        vwIR51UqB0sPJ2AiZULMbuCZqh/bcr3v/Qem+znTCuRw/coQCsOiOwyZ6j+W7+1YzIUPFo
        cZ6XgpuZyw6f++l7lopp7vVYycEzHTq/eWEfcKHVhVeOjaf/Q+JIHoSmY1qYAj2+RuxMoU
        CN4rCeKsqZUufS1ozHcOlgNIoD5siERnvSdvJTViIWrATxh8GFh+PULC35u70vvNl4B+Lr
        PPGJUmcqTVzFBQXLB1gTcJ9NwpDVQdA8716Quzbv0HX9U4DoD2L+7fOP7qq1mg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612918421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=D23ic3BaNnGldICy/Rvj1vt2CAADFX+q7tl1/gXyEhg=;
        b=usgLHCGGUGkzgp0JeYciR1lOfYYUBQz3sVy2hVrfjY9zkWzixfPf1MC562dN54qdZKBg24
        C+DM6FKi57Z9FdBQ==
Date:   Wed, 10 Feb 2021 00:40:54 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Helge Deller <deller@gmx.de>,
        "David S. Miller" <davem@davemloft.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Rich Felker <dalias@libc.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Lai Jiangshan <jiangshanlai+lkml@gmail.com>
Subject: [patch V2 13/13] x86/softirq/64: Inline do_softirq_own_stack()
References: <20210209234041.127454039@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

There is no reason to have this as a seperate function for a single caller.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
V2: Adopt to the new header file.
---
 arch/x86/include/asm/irq_stack.h     |    3 +--
 arch/x86/include/asm/softirq_stack.h |   11 +++++++++++
 arch/x86/kernel/irq_64.c             |    5 -----
 3 files changed, 12 insertions(+), 7 deletions(-)

--- a/arch/x86/include/asm/irq_stack.h
+++ b/arch/x86/include/asm/irq_stack.h
@@ -194,7 +194,7 @@
  * interrupts are pending to be processed. The interrupt stack cannot be in
  * use here.
  */
-#define run_softirq_on_irqstack()					\
+#define do_softirq_own_stack()						\
 {									\
 	__this_cpu_write(hardirq_stack_inuse, true);			\
 	call_on_irqstack(__do_softirq, ASM_CALL_SOFTIRQ);		\
@@ -202,7 +202,6 @@
 }
 
 #else /* CONFIG_X86_64 */
-
 /* System vector handlers always run on the stack they interrupted. */
 #define run_sysvec_on_irqstack_cond(func, regs)				\
 {									\
--- /dev/null
+++ b/arch/x86/include/asm/softirq_stack.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_SOFTIRQ_STACK_H
+#define _ASM_X86_SOFTIRQ_STACK_H
+
+#ifdef CONFIG_X86_64
+# include <asm/irq_stack.h>
+#else
+# include <asm-generic/softirq_stack.h>
+#endif
+
+#endif
--- a/arch/x86/kernel/irq_64.c
+++ b/arch/x86/kernel/irq_64.c
@@ -74,8 +74,3 @@ int irq_init_percpu_irqstack(unsigned in
 		return 0;
 	return map_irq_stack(cpu);
 }
-
-void do_softirq_own_stack(void)
-{
-	run_softirq_on_irqstack();
-}

