Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE13E315CEC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 03:10:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235316AbhBJCJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 21:09:46 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55338 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234372AbhBJAyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 19:54:21 -0500
Message-Id: <20210210002513.068033456@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612918417;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=5rHFKGl8PWp0exRTePQ/qiz/fy3OHOS1QeSQqVAuYiM=;
        b=CYU+Lj51OvrS/HfbLNbTu/XsYbb1x62h5JkpzhgPGt6dqaKa4lyDzOTvN8JNVwShoSMz5O
        lJFkWHoLUV0veN5F0JKQWk5wlui17tqxSCcrueQUtUF4bSuWxzzhMpnQq+ZPL+ydC0uevP
        1ID+R9BETM81R86oJI0mIW+B6F/p5CpPBy1N8bZtzlXcpSMTKXmBu4A8X1v60W85YXo3AE
        hDOKnNwoi42VuBUBO/hX5ervv98gBzjq1E88OWAi7hwHbnItkml2VOrN3pEsggU/SA2x4u
        37w2Uu9L0iUAKGYKbQY4zfsx1OVAkB452sjcqczPXXg05BwbYPqK1JESvNyBWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612918417;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=5rHFKGl8PWp0exRTePQ/qiz/fy3OHOS1QeSQqVAuYiM=;
        b=645j80mu6LpkVXlG1A89OQGmUtR0aNS9Y/GLJ0xMYAi1Wc4kS4LiKcWfUUVAXmY0e/VJ3Q
        /PMnf5NSYmLSzgBA==
Date:   Wed, 10 Feb 2021 00:40:51 +0100
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
Subject: [patch V2 10/13] x86: Select CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK
References: <20210209234041.127454039@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Now that all invocations of irq_exit_rcu() happen on the irq stack, turn on
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK which causes the core code to invoke
__do_softirq() directly without going through do_softirq_own_stack().

That means do_softirq_own_stack() is only invoked from task context which
means it can't be on the irq stack. Remove the conditional from
run_softirq_on_irqstack_cond() and rename the function accordingly.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kees Cook <keescook@chromium.org>

---
 arch/x86/Kconfig                 |    1 +
 arch/x86/include/asm/irq_stack.h |   19 ++++++++-----------
 arch/x86/kernel/irq_64.c         |    2 +-
 3 files changed, 10 insertions(+), 12 deletions(-)

--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -187,6 +187,7 @@ config X86
 	select HAVE_HW_BREAKPOINT
 	select HAVE_IDE
 	select HAVE_IOREMAP_PROT
+	select HAVE_IRQ_EXIT_ON_IRQ_STACK	if X86_64
 	select HAVE_IRQ_TIME_ACCOUNTING
 	select HAVE_KERNEL_BZIP2
 	select HAVE_KERNEL_GZIP
--- a/arch/x86/include/asm/irq_stack.h
+++ b/arch/x86/include/asm/irq_stack.h
@@ -189,19 +189,16 @@
 	"call %P[__func]				\n"
 
 /*
- * Macro to invoke __do_softirq on the irq stack. Contrary to the above
- * the only check which is necessary is whether the interrupt stack is
- * in use already.
+ * Macro to invoke __do_softirq on the irq stack. This is only called from
+ * task context when bottom halfs are about to be reenabled and soft
+ * interrupts are pending to be processed. The interrupt stack cannot be in
+ * use here.
  */
-#define run_softirq_on_irqstack_cond()					\
+#define run_softirq_on_irqstack()					\
 {									\
-	if (__this_cpu_read(hardirq_stack_inuse)) {			\
-		__do_softirq();						\
-	} else {							\
-		__this_cpu_write(hardirq_stack_inuse, true);		\
-		call_on_irqstack(__do_softirq, ASM_CALL_SOFTIRQ);	\
-		__this_cpu_write(hardirq_stack_inuse, false);		\
-	}								\
+	__this_cpu_write(hardirq_stack_inuse, true);			\
+	call_on_irqstack(__do_softirq, ASM_CALL_SOFTIRQ);		\
+	__this_cpu_write(hardirq_stack_inuse, false);			\
 }
 
 #else /* CONFIG_X86_64 */
--- a/arch/x86/kernel/irq_64.c
+++ b/arch/x86/kernel/irq_64.c
@@ -76,5 +76,5 @@ int irq_init_percpu_irqstack(unsigned in
 
 void do_softirq_own_stack(void)
 {
-	run_softirq_on_irqstack_cond();
+	run_softirq_on_irqstack();
 }

