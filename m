Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4638B4336BC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 15:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235823AbhJSNP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 09:15:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:55596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235735AbhJSNP6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 09:15:58 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD85A61372;
        Tue, 19 Oct 2021 13:13:45 +0000 (UTC)
Date:   Tue, 19 Oct 2021 09:13:44 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [GIT PULL] tracing: Fix to recursion protection for 5.15
Message-ID: <20211019091344.65629198@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Linus,

tracing recursion fix:

 - While cleaning up some of the tracing recursion protection logic,
   I discovered a scenario that the current design would miss, and
   would allow an infinite recursion. Removing an optimization trick
   that opened the hole, fixes the issue and cleans up the code as well.


Please pull the latest trace-v5.15-rc5 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.15-rc5

Tag SHA1: 643b4d78baa695d2c7d27a149c9dfa6fd70ee2df
Head SHA1: ed65df63a39a3f6ed04f7258de8b6789e5021c18


Steven Rostedt (VMware) (1):
      tracing: Have all levels of checks prevent recursion

----
 include/linux/trace_recursion.h | 49 ++++++++---------------------------------
 kernel/trace/ftrace.c           |  4 ++--
 2 files changed, 11 insertions(+), 42 deletions(-)
---------------------------
commit ed65df63a39a3f6ed04f7258de8b6789e5021c18
Author: Steven Rostedt (VMware) <rostedt@goodmis.org>
Date:   Mon Oct 18 15:44:12 2021 -0400

    tracing: Have all levels of checks prevent recursion
    
    While writing an email explaining the "bit = 0" logic for a discussion on
    making ftrace_test_recursion_trylock() disable preemption, I discovered a
    path that makes the "not do the logic if bit is zero" unsafe.
    
    The recursion logic is done in hot paths like the function tracer. Thus,
    any code executed causes noticeable overhead. Thus, tricks are done to try
    to limit the amount of code executed. This included the recursion testing
    logic.
    
    Having recursion testing is important, as there are many paths that can
    end up in an infinite recursion cycle when tracing every function in the
    kernel. Thus protection is needed to prevent that from happening.
    
    Because it is OK to recurse due to different running context levels (e.g.
    an interrupt preempts a trace, and then a trace occurs in the interrupt
    handler), a set of bits are used to know which context one is in (normal,
    softirq, irq and NMI). If a recursion occurs in the same level, it is
    prevented*.
    
    Then there are infrastructure levels of recursion as well. When more than
    one callback is attached to the same function to trace, it calls a loop
    function to iterate over all the callbacks. Both the callbacks and the
    loop function have recursion protection. The callbacks use the
    "ftrace_test_recursion_trylock()" which has a "function" set of context
    bits to test, and the loop function calls the internal
    trace_test_and_set_recursion() directly, with an "internal" set of bits.
    
    If an architecture does not implement all the features supported by ftrace
    then the callbacks are never called directly, and the loop function is
    called instead, which will implement the features of ftrace.
    
    Since both the loop function and the callbacks do recursion protection, it
    was seemed unnecessary to do it in both locations. Thus, a trick was made
    to have the internal set of recursion bits at a more significant bit
    location than the function bits. Then, if any of the higher bits were set,
    the logic of the function bits could be skipped, as any new recursion
    would first have to go through the loop function.
    
    This is true for architectures that do not support all the ftrace
    features, because all functions being traced must first go through the
    loop function before going to the callbacks. But this is not true for
    architectures that support all the ftrace features. That's because the
    loop function could be called due to two callbacks attached to the same
    function, but then a recursion function inside the callback could be
    called that does not share any other callback, and it will be called
    directly.
    
    i.e.
    
     traced_function_1: [ more than one callback tracing it ]
       call loop_func
    
     loop_func:
       trace_recursion set internal bit
       call callback
    
     callback:
       trace_recursion [ skipped because internal bit is set, return 0 ]
       call traced_function_2
    
     traced_function_2: [ only traced by above callback ]
       call callback
    
     callback:
       trace_recursion [ skipped because internal bit is set, return 0 ]
       call traced_function_2
    
     [ wash, rinse, repeat, BOOM! out of shampoo! ]
    
    Thus, the "bit == 0 skip" trick is not safe, unless the loop function is
    call for all functions.
    
    Since we want to encourage architectures to implement all ftrace features,
    having them slow down due to this extra logic may encourage the
    maintainers to update to the latest ftrace features. And because this
    logic is only safe for them, remove it completely.
    
     [*] There is on layer of recursion that is allowed, and that is to allow
         for the transition between interrupt context (normal -> softirq ->
         irq -> NMI), because a trace may occur before the context update is
         visible to the trace recursion logic.
    
    Link: https://lore.kernel.org/all/609b565a-ed6e-a1da-f025-166691b5d994@linux.alibaba.com/
    Link: https://lkml.kernel.org/r/20211018154412.09fcad3c@gandalf.local.home
    
    Cc: Linus Torvalds <torvalds@linux-foundation.org>
    Cc: Petr Mladek <pmladek@suse.com>
    Cc: Ingo Molnar <mingo@redhat.com>
    Cc: "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>
    Cc: Helge Deller <deller@gmx.de>
    Cc: Michael Ellerman <mpe@ellerman.id.au>
    Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
    Cc: Paul Mackerras <paulus@samba.org>
    Cc: Paul Walmsley <paul.walmsley@sifive.com>
    Cc: Palmer Dabbelt <palmer@dabbelt.com>
    Cc: Albert Ou <aou@eecs.berkeley.edu>
    Cc: Thomas Gleixner <tglx@linutronix.de>
    Cc: Borislav Petkov <bp@alien8.de>
    Cc: "H. Peter Anvin" <hpa@zytor.com>
    Cc: Josh Poimboeuf <jpoimboe@redhat.com>
    Cc: Jiri Kosina <jikos@kernel.org>
    Cc: Miroslav Benes <mbenes@suse.cz>
    Cc: Joe Lawrence <joe.lawrence@redhat.com>
    Cc: Colin Ian King <colin.king@canonical.com>
    Cc: Masami Hiramatsu <mhiramat@kernel.org>
    Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
    Cc: Nicholas Piggin <npiggin@gmail.com>
    Cc: Jisheng Zhang <jszhang@kernel.org>
    Cc: =?utf-8?b?546L6LSH?= <yun.wang@linux.alibaba.com>
    Cc: Guo Ren <guoren@kernel.org>
    Cc: stable@vger.kernel.org
    Fixes: edc15cafcbfa3 ("tracing: Avoid unnecessary multiple recursion checks")
    Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

diff --git a/include/linux/trace_recursion.h b/include/linux/trace_recursion.h
index a9f9c5714e65..fe95f0922526 100644
--- a/include/linux/trace_recursion.h
+++ b/include/linux/trace_recursion.h
@@ -16,23 +16,8 @@
  *  When function tracing occurs, the following steps are made:
  *   If arch does not support a ftrace feature:
  *    call internal function (uses INTERNAL bits) which calls...
- *   If callback is registered to the "global" list, the list
- *    function is called and recursion checks the GLOBAL bits.
- *    then this function calls...
  *   The function callback, which can use the FTRACE bits to
  *    check for recursion.
- *
- * Now if the arch does not support a feature, and it calls
- * the global list function which calls the ftrace callback
- * all three of these steps will do a recursion protection.
- * There's no reason to do one if the previous caller already
- * did. The recursion that we are protecting against will
- * go through the same steps again.
- *
- * To prevent the multiple recursion checks, if a recursion
- * bit is set that is higher than the MAX bit of the current
- * check, then we know that the check was made by the previous
- * caller, and we can skip the current check.
  */
 enum {
 	/* Function recursion bits */
@@ -40,12 +25,14 @@ enum {
 	TRACE_FTRACE_NMI_BIT,
 	TRACE_FTRACE_IRQ_BIT,
 	TRACE_FTRACE_SIRQ_BIT,
+	TRACE_FTRACE_TRANSITION_BIT,
 
-	/* INTERNAL_BITs must be greater than FTRACE_BITs */
+	/* Internal use recursion bits */
 	TRACE_INTERNAL_BIT,
 	TRACE_INTERNAL_NMI_BIT,
 	TRACE_INTERNAL_IRQ_BIT,
 	TRACE_INTERNAL_SIRQ_BIT,
+	TRACE_INTERNAL_TRANSITION_BIT,
 
 	TRACE_BRANCH_BIT,
 /*
@@ -86,12 +73,6 @@ enum {
 	 */
 	TRACE_GRAPH_NOTRACE_BIT,
 
-	/*
-	 * When transitioning between context, the preempt_count() may
-	 * not be correct. Allow for a single recursion to cover this case.
-	 */
-	TRACE_TRANSITION_BIT,
-
 	/* Used to prevent recursion recording from recursing. */
 	TRACE_RECORD_RECURSION_BIT,
 };
@@ -113,12 +94,10 @@ enum {
 #define TRACE_CONTEXT_BITS	4
 
 #define TRACE_FTRACE_START	TRACE_FTRACE_BIT
-#define TRACE_FTRACE_MAX	((1 << (TRACE_FTRACE_START + TRACE_CONTEXT_BITS)) - 1)
 
 #define TRACE_LIST_START	TRACE_INTERNAL_BIT
-#define TRACE_LIST_MAX		((1 << (TRACE_LIST_START + TRACE_CONTEXT_BITS)) - 1)
 
-#define TRACE_CONTEXT_MASK	TRACE_LIST_MAX
+#define TRACE_CONTEXT_MASK	((1 << (TRACE_LIST_START + TRACE_CONTEXT_BITS)) - 1)
 
 /*
  * Used for setting context
@@ -132,6 +111,7 @@ enum {
 	TRACE_CTX_IRQ,
 	TRACE_CTX_SOFTIRQ,
 	TRACE_CTX_NORMAL,
+	TRACE_CTX_TRANSITION,
 };
 
 static __always_inline int trace_get_context_bit(void)
@@ -160,45 +140,34 @@ extern void ftrace_record_recursion(unsigned long ip, unsigned long parent_ip);
 #endif
 
 static __always_inline int trace_test_and_set_recursion(unsigned long ip, unsigned long pip,
-							int start, int max)
+							int start)
 {
 	unsigned int val = READ_ONCE(current->trace_recursion);
 	int bit;
 
-	/* A previous recursion check was made */
-	if ((val & TRACE_CONTEXT_MASK) > max)
-		return 0;
-
 	bit = trace_get_context_bit() + start;
 	if (unlikely(val & (1 << bit))) {
 		/*
 		 * It could be that preempt_count has not been updated during
 		 * a switch between contexts. Allow for a single recursion.
 		 */
-		bit = TRACE_TRANSITION_BIT;
+		bit = TRACE_CTX_TRANSITION + start;
 		if (val & (1 << bit)) {
 			do_ftrace_record_recursion(ip, pip);
 			return -1;
 		}
-	} else {
-		/* Normal check passed, clear the transition to allow it again */
-		val &= ~(1 << TRACE_TRANSITION_BIT);
 	}
 
 	val |= 1 << bit;
 	current->trace_recursion = val;
 	barrier();
 
-	return bit + 1;
+	return bit;
 }
 
 static __always_inline void trace_clear_recursion(int bit)
 {
-	if (!bit)
-		return;
-
 	barrier();
-	bit--;
 	trace_recursion_clear(bit);
 }
 
@@ -214,7 +183,7 @@ static __always_inline void trace_clear_recursion(int bit)
 static __always_inline int ftrace_test_recursion_trylock(unsigned long ip,
 							 unsigned long parent_ip)
 {
-	return trace_test_and_set_recursion(ip, parent_ip, TRACE_FTRACE_START, TRACE_FTRACE_MAX);
+	return trace_test_and_set_recursion(ip, parent_ip, TRACE_FTRACE_START);
 }
 
 /**
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 7efbc8aaf7f6..635fbdc9d589 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6977,7 +6977,7 @@ __ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip,
 	struct ftrace_ops *op;
 	int bit;
 
-	bit = trace_test_and_set_recursion(ip, parent_ip, TRACE_LIST_START, TRACE_LIST_MAX);
+	bit = trace_test_and_set_recursion(ip, parent_ip, TRACE_LIST_START);
 	if (bit < 0)
 		return;
 
@@ -7052,7 +7052,7 @@ static void ftrace_ops_assist_func(unsigned long ip, unsigned long parent_ip,
 {
 	int bit;
 
-	bit = trace_test_and_set_recursion(ip, parent_ip, TRACE_LIST_START, TRACE_LIST_MAX);
+	bit = trace_test_and_set_recursion(ip, parent_ip, TRACE_LIST_START);
 	if (bit < 0)
 		return;
 
