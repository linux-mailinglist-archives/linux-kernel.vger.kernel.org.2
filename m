Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24B9B3B2D64
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 13:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232347AbhFXLOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 07:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232440AbhFXLOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 07:14:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C582C061574
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 04:11:53 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624533111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1w6rpiEgwhZVgRsqWlcOzTrH9OZ5OS60CHHCp1sLrGw=;
        b=a/59reuU0xNSh80RZTtDjZ7kG6CSlaNlIwTSYebhlAncWEZMSUUiciiFCjGBVtzaYp2wRf
        avS3EwA7k5vulItoEgAP7VFxY48kbZFNcBLSxxecXpNmeAUPntLjDY+9yVQq09oIwb8c1U
        HKHg969b2lEDGwYqNHtDh4dIvQ3BtNDUoi0vg2GE/N3RE50FH7/a/nbVzB1/eZWEWqTXDd
        6GcWyBXDfP+Q+Etg1YtdKqhbm98FpaqvliB+yOR/FwPICQJ29DtHWnrDFFZOo/kgw5yx/F
        fYlNQ7v7wOMo2RPY14tlGC8OY61oSoaLv3rE0Ef0vvPpGbZoyDuu706Pg2li2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624533111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1w6rpiEgwhZVgRsqWlcOzTrH9OZ5OS60CHHCp1sLrGw=;
        b=pfZ3OpGuG59GBQCXX5cSXH9ubMmhLeJkhw94xtJInYHKrzr0AdOR306fJLgDRRR9fs4sz+
        c+BtjlWhKhPbonAg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Ingo Molnar <mingo@redhat.com>, Marc Zyngier <maz@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pekka Enberg <penberg@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        "Wolfram Sang (Renesas)" <wsa+renesas@sang-engineering.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Nick Terrell <terrelln@fb.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Vlastimil Babka <vbabka@suse.cz>,
        linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH printk v3 4/6] printk: remove NMI tracking
Date:   Thu, 24 Jun 2021 13:17:46 +0206
Message-Id: <20210624111148.5190-5-john.ogness@linutronix.de>
In-Reply-To: <20210624111148.5190-1-john.ogness@linutronix.de>
References: <20210624111148.5190-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All NMI contexts are handled the same as the safe context: store the
message and defer printing. There is no need to have special NMI
context tracking for this. Using in_nmi() is enough.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 arch/arm/kernel/smp.c       |  2 --
 arch/powerpc/kexec/crash.c  |  3 ---
 include/linux/hardirq.h     |  2 --
 include/linux/printk.h      | 12 ------------
 init/Kconfig                |  5 -----
 kernel/printk/internal.h    |  6 ------
 kernel/printk/printk_safe.c | 37 +------------------------------------
 kernel/trace/trace.c        |  2 --
 8 files changed, 1 insertion(+), 68 deletions(-)

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 74679240a9d8..0dd2d733ad62 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -668,9 +668,7 @@ static void do_handle_IPI(int ipinr)
 		break;
 
 	case IPI_CPU_BACKTRACE:
-		printk_nmi_enter();
 		nmi_cpu_backtrace(get_irq_regs());
-		printk_nmi_exit();
 		break;
 
 	default:
diff --git a/arch/powerpc/kexec/crash.c b/arch/powerpc/kexec/crash.c
index c9a889880214..d488311efab1 100644
--- a/arch/powerpc/kexec/crash.c
+++ b/arch/powerpc/kexec/crash.c
@@ -311,9 +311,6 @@ void default_machine_crash_shutdown(struct pt_regs *regs)
 	unsigned int i;
 	int (*old_handler)(struct pt_regs *regs);
 
-	/* Avoid hardlocking with irresponsive CPU holding logbuf_lock */
-	printk_nmi_enter();
-
 	/*
 	 * This function is only called after the system
 	 * has panicked or is otherwise in a critical state.
diff --git a/include/linux/hardirq.h b/include/linux/hardirq.h
index 69bc86ea382c..76878b357ffa 100644
--- a/include/linux/hardirq.h
+++ b/include/linux/hardirq.h
@@ -116,7 +116,6 @@ extern void rcu_nmi_exit(void);
 	do {							\
 		lockdep_off();					\
 		arch_nmi_enter();				\
-		printk_nmi_enter();				\
 		BUG_ON(in_nmi() == NMI_MASK);			\
 		__preempt_count_add(NMI_OFFSET + HARDIRQ_OFFSET);	\
 	} while (0)
@@ -135,7 +134,6 @@ extern void rcu_nmi_exit(void);
 	do {							\
 		BUG_ON(!in_nmi());				\
 		__preempt_count_sub(NMI_OFFSET + HARDIRQ_OFFSET);	\
-		printk_nmi_exit();				\
 		arch_nmi_exit();				\
 		lockdep_on();					\
 	} while (0)
diff --git a/include/linux/printk.h b/include/linux/printk.h
index 664612f75dac..14a18fa15c92 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -149,18 +149,6 @@ static inline __printf(1, 2) __cold
 void early_printk(const char *s, ...) { }
 #endif
 
-#ifdef CONFIG_PRINTK_NMI
-extern void printk_nmi_enter(void);
-extern void printk_nmi_exit(void);
-extern void printk_nmi_direct_enter(void);
-extern void printk_nmi_direct_exit(void);
-#else
-static inline void printk_nmi_enter(void) { }
-static inline void printk_nmi_exit(void) { }
-static inline void printk_nmi_direct_enter(void) { }
-static inline void printk_nmi_direct_exit(void) { }
-#endif /* PRINTK_NMI */
-
 struct dev_printk_info;
 
 #ifdef CONFIG_PRINTK
diff --git a/init/Kconfig b/init/Kconfig
index 5babea38e346..4053588db7a0 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1488,11 +1488,6 @@ config PRINTK
 	  very difficult to diagnose system problems, saying N here is
 	  strongly discouraged.
 
-config PRINTK_NMI
-	def_bool y
-	depends on PRINTK
-	depends on HAVE_NMI
-
 config BUG
 	bool "BUG() support" if EXPERT
 	default y
diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 6cc35c5de890..ff890ae3ee6a 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -6,12 +6,6 @@
 
 #ifdef CONFIG_PRINTK
 
-#define PRINTK_SAFE_CONTEXT_MASK	0x007ffffff
-#define PRINTK_NMI_DIRECT_CONTEXT_MASK	0x008000000
-#define PRINTK_NMI_CONTEXT_MASK		0xff0000000
-
-#define PRINTK_NMI_CONTEXT_OFFSET	0x010000000
-
 __printf(4, 0)
 int vprintk_store(int facility, int level,
 		  const struct dev_printk_info *dev_info,
diff --git a/kernel/printk/printk_safe.c b/kernel/printk/printk_safe.c
index 0456cd48d01c..47d961149a06 100644
--- a/kernel/printk/printk_safe.c
+++ b/kernel/printk/printk_safe.c
@@ -4,12 +4,9 @@
  */
 
 #include <linux/preempt.h>
-#include <linux/spinlock.h>
-#include <linux/debug_locks.h>
 #include <linux/kdb.h>
 #include <linux/smp.h>
 #include <linux/cpumask.h>
-#include <linux/irq_work.h>
 #include <linux/printk.h>
 #include <linux/kprobes.h>
 
@@ -17,35 +14,6 @@
 
 static DEFINE_PER_CPU(int, printk_context);
 
-#ifdef CONFIG_PRINTK_NMI
-void noinstr printk_nmi_enter(void)
-{
-	this_cpu_add(printk_context, PRINTK_NMI_CONTEXT_OFFSET);
-}
-
-void noinstr printk_nmi_exit(void)
-{
-	this_cpu_sub(printk_context, PRINTK_NMI_CONTEXT_OFFSET);
-}
-
-/*
- * Marks a code that might produce many messages in NMI context
- * and the risk of losing them is more critical than eventual
- * reordering.
- */
-void printk_nmi_direct_enter(void)
-{
-	if (this_cpu_read(printk_context) & PRINTK_NMI_CONTEXT_MASK)
-		this_cpu_or(printk_context, PRINTK_NMI_DIRECT_CONTEXT_MASK);
-}
-
-void printk_nmi_direct_exit(void)
-{
-	this_cpu_and(printk_context, ~PRINTK_NMI_DIRECT_CONTEXT_MASK);
-}
-
-#endif /* CONFIG_PRINTK_NMI */
-
 /* Can be preempted by NMI. */
 void __printk_safe_enter(void)
 {
@@ -70,10 +38,7 @@ asmlinkage int vprintk(const char *fmt, va_list args)
 	 * Use the main logbuf even in NMI. But avoid calling console
 	 * drivers that might have their own locks.
 	 */
-	if (this_cpu_read(printk_context) &
-	    (PRINTK_NMI_DIRECT_CONTEXT_MASK |
-	     PRINTK_NMI_CONTEXT_MASK |
-	     PRINTK_SAFE_CONTEXT_MASK)) {
+	if (this_cpu_read(printk_context) || in_nmi()) {
 		unsigned long flags;
 		int len;
 
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 915fe8790f04..6ac254f7a04c 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -9409,7 +9409,6 @@ void ftrace_dump(enum ftrace_dump_mode oops_dump_mode)
 	tracing_off();
 
 	local_irq_save(flags);
-	printk_nmi_direct_enter();
 
 	/* Simulate the iterator */
 	trace_init_global_iter(&iter);
@@ -9491,7 +9490,6 @@ void ftrace_dump(enum ftrace_dump_mode oops_dump_mode)
 		atomic_dec(&per_cpu_ptr(iter.array_buffer->data, cpu)->disabled);
 	}
 	atomic_dec(&dump_running);
-	printk_nmi_direct_exit();
 	local_irq_restore(flags);
 }
 EXPORT_SYMBOL_GPL(ftrace_dump);
-- 
2.20.1

