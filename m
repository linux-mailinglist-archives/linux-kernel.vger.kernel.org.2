Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 172884163B4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 18:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242495AbhIWQ4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 12:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242352AbhIWQ40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 12:56:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B00FAC061762
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 09:54:43 -0700 (PDT)
Message-ID: <20210923165358.181022656@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632416082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=rY5V1ijmm1othC13rr9fDxuQC5dDCDgC05tEtb3gohk=;
        b=o7x1RUOfA0KoYW1JjX05D3g/XfV/IUX810SXu6awmmNPvNMKIPBwxV9QJI8e/wTxiFJmt0
        ybRy9VGZlMdvovac74G0f6zZTzFTGWHMryTWhnhDx78kElk7EpzW1FI6VVr54Q6Ka290X1
        n+Dh/Hxk0yenLN5QyHWH3ei0WvdNlnkW1972m1VUHjpcCXGguRjbeB/E7JG9PQDvih7Atv
        KzWi8zmfzOqvBTstu3DsQA7+YumzEGCdYMHF4PK9M4ZYmZ7//XDDQCB4sePWECklbS2e7w
        7W4+eYWG3GE3Laz+lH3Jln4J9KiBpDO4XZ3+jHttWdKgITqEmJBwyqrJ/FqZFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632416082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=rY5V1ijmm1othC13rr9fDxuQC5dDCDgC05tEtb3gohk=;
        b=io0zRfFdv4j9Pa7UZXNHwNFLaVDoi3dlAY/Gu2d7XdWgnmoZ/RvjNiNOuon7Ks3J2wahG3
        skpin4wEm6AsQ7Aw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Sebastian Siewior <bigeasy@linutronix.de>
Subject: [patch 5/8] sched: Make might_sleep() output less confusing
References: <20210923164145.466686140@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 23 Sep 2021 18:54:41 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

might_sleep() output is pretty informative, but can be confusing at times
especially with PREEMPT_RCU when the check triggers due to a voluntary
sleep inside a RCU read side critical section:

 BUG: sleeping function called from invalid context at kernel/test.c:110
 in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 415, name: kworker/u112:52
 Preemption disabled at: migrate_disable+0x33/0xa0

in_atomic() is 0, but it still tells that preemption was disabled at
migrate_disable(), which is completely useless because preemption is not
disabled. But the interesting information to decode the above, i.e. the RCU
nesting depth, is not printed.

That becomes even more confusing when might_sleep() is invoked from
cond_resched_lock() within a RCU read side critical section. Here the
expected preemption count is 1 and not 0.

 BUG: sleeping function called from invalid context at kernel/test.c:131
 in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 415, name: kworker/u112:52
 Preemption disabled at: test_cond_lock+0xf3/0x1c0

So in_atomic() is set, which is expected as the caller holds a spinlock,
but it's unclear why this is broken and the preempt disable IP is just
pointing at the correct place, i.e. spin_lock(), which is obviously not
helpful either.

Make that more useful in general:

 - Print preempt_count() and the expected value

and for the CONFIG_PREEMPT_RCU case:

 - Print the RCU read side critical section nesting depth

 - Print the preempt disable IP only when preempt count
   does not have the expected value.

So the might_sleep() dump from a within a preemptible RCU read side
critical section becomes:

 BUG: sleeping function called from invalid context at kernel/test.c:110
 in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 415, name: kworker/u112:52
 preempt_count: 0, expected: 0
 RCU nest depth: 1, expected: 0

and the cond_resched_lock() case becomes:

 BUG: sleeping function called from invalid context at kernel/test.c:141
 in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 415, name: kworker/u112:52
 preempt_count: 1, expected: 1
 RCU nest depth: 1, expected: 0

which makes is pretty obvious what's going on. For all other cases the
preempt disable IP is still printed as before:

 BUG: sleeping function called from invalid context at kernel/test.c: 156
 in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 1, name: swapper/0
 preempt_count: 1, expected: 0
 RCU nest depth: 0, expected: 0
 Preemption disabled at:
 [<ffffffff82b48326>] test_might_sleep+0xbe/0xf8

 BUG: sleeping function called from invalid context at kernel/test.c: 163
 in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 1, name: swapper/0
 preempt_count: 1, expected: 0
 RCU nest depth: 1, expected: 0
 Preemption disabled at:
 [<ffffffff82b48326>] test_might_sleep+0x1e4/0x280

This also prepares to provide a better debugging output for RT enabled
kernels and their spinlock substitutions.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/sched/core.c |   27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9450,6 +9450,18 @@ void __might_sleep(const char *file, int
 }
 EXPORT_SYMBOL(__might_sleep);
 
+static void print_preempt_disable_ip(int preempt_offset, unsigned long ip)
+{
+	if (!IS_ENABLED(CONFIG_DEBUG_PREEMPT))
+		return;
+
+	if (preempt_count() == preempt_offset)
+		return;
+
+	pr_err("Preemption disabled at:");
+	print_ip_sym(KERN_ERR, ip);
+}
+
 void __might_resched(const char *file, int line, int preempt_offset)
 {
 	/* Ratelimiting timestamp: */
@@ -9478,6 +9490,13 @@ void __might_resched(const char *file, i
 	pr_err("in_atomic(): %d, irqs_disabled(): %d, non_block: %d, pid: %d, name: %s\n",
 	       in_atomic(), irqs_disabled(), current->non_block_count,
 	       current->pid, current->comm);
+	pr_err("preempt_count: %x, expected: %x\n", preempt_count(),
+	       preempt_offset);
+
+	if (IS_ENABLED(CONFIG_PREEMPT_RCU)) {
+		pr_err("RCU nest depth: %d, expected: 0\n",
+		       rcu_preempt_depth());
+	}
 
 	if (task_stack_end_corrupted(current))
 		pr_emerg("Thread overran stack, or stack corrupted\n");
@@ -9485,11 +9504,9 @@ void __might_resched(const char *file, i
 	debug_show_held_locks(current);
 	if (irqs_disabled())
 		print_irqtrace_events(current);
-	if (IS_ENABLED(CONFIG_DEBUG_PREEMPT)
-	    && !preempt_count_equals(preempt_offset)) {
-		pr_err("Preemption disabled at:");
-		print_ip_sym(KERN_ERR, preempt_disable_ip);
-	}
+
+	print_preempt_disable_ip(preempt_offset, preempt_disable_ip);
+
 	dump_stack();
 	add_taint(TAINT_WARN, LOCKDEP_STILL_OK);
 }

