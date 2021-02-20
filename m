Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B17A8320654
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 18:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbhBTRA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Feb 2021 12:00:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:38854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229803AbhBTRA4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Feb 2021 12:00:56 -0500
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 713C764D9A;
        Sat, 20 Feb 2021 17:00:15 +0000 (UTC)
Date:   Sat, 20 Feb 2021 12:00:13 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [for-next][PATCH] kprobes: Fix to delay the kprobes jump
 optimization
Message-ID: <20210220120013.59c07876@oasis.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Masami Hiramatsu (1):
      kprobes: Fix to delay the kprobes jump optimization

----
 kernel/kprobes.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)
---------------------------
commit c85c9a2c6e368dc94907e63babb18a9788e5c9b6
Author: Masami Hiramatsu <mhiramat@kernel.org>
Date:   Thu Feb 18 23:29:23 2021 +0900

    kprobes: Fix to delay the kprobes jump optimization
    
    Commit 36dadef23fcc ("kprobes: Init kprobes in early_initcall")
    moved the kprobe setup in early_initcall(), which includes kprobe
    jump optimization.
    The kprobes jump optimizer involves synchronize_rcu_tasks() which
    depends on the ksoftirqd and rcu_spawn_tasks_*(). However, since
    those are setup in core_initcall(), kprobes jump optimizer can not
    run at the early_initcall().
    
    To avoid this issue, make the kprobe optimization disabled in the
    early_initcall() and enables it in subsys_initcall().
    
    Note that non-optimized kprobes is still available after
    early_initcall(). Only jump optimization is delayed.
    
    Link: https://lkml.kernel.org/r/161365856280.719838.12423085451287256713.stgit@devnote2
    
    Fixes: 36dadef23fcc ("kprobes: Init kprobes in early_initcall")
    Cc: Ingo Molnar <mingo@kernel.org>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: Thomas Gleixner <tglx@linutronix.de>
    Cc: RCU <rcu@vger.kernel.org>
    Cc: Michael Ellerman <mpe@ellerman.id.au>
    Cc: Andrew Morton <akpm@linux-foundation.org>
    Cc: Daniel Axtens <dja@axtens.net>
    Cc: Frederic Weisbecker <frederic@kernel.org>
    Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
    Cc: Joel Fernandes <joel@joelfernandes.org>
    Cc: Michal Hocko <mhocko@suse.com>
    Cc: "Theodore Y . Ts'o" <tytso@mit.edu>
    Cc: Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
    Cc: stable@vger.kernel.org
    Reported-by: Paul E. McKenney <paulmck@kernel.org>
    Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
    Reported-by: Uladzislau Rezki <urezki@gmail.com>
    Acked-by: Paul E. McKenney <paulmck@kernel.org>
    Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
    Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index dd1d027455c4..745f08fdd7a6 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -861,7 +861,6 @@ static void try_to_optimize_kprobe(struct kprobe *p)
 	cpus_read_unlock();
 }
 
-#ifdef CONFIG_SYSCTL
 static void optimize_all_kprobes(void)
 {
 	struct hlist_head *head;
@@ -887,6 +886,7 @@ static void optimize_all_kprobes(void)
 	mutex_unlock(&kprobe_mutex);
 }
 
+#ifdef CONFIG_SYSCTL
 static void unoptimize_all_kprobes(void)
 {
 	struct hlist_head *head;
@@ -2500,18 +2500,14 @@ static int __init init_kprobes(void)
 		}
 	}
 
-#if defined(CONFIG_OPTPROBES)
-#if defined(__ARCH_WANT_KPROBES_INSN_SLOT)
-	/* Init kprobe_optinsn_slots */
-	kprobe_optinsn_slots.insn_size = MAX_OPTINSN_SIZE;
-#endif
-	/* By default, kprobes can be optimized */
-	kprobes_allow_optimization = true;
-#endif
-
 	/* By default, kprobes are armed */
 	kprobes_all_disarmed = false;
 
+#if defined(CONFIG_OPTPROBES) && defined(__ARCH_WANT_KPROBES_INSN_SLOT)
+	/* Init kprobe_optinsn_slots for allocation */
+	kprobe_optinsn_slots.insn_size = MAX_OPTINSN_SIZE;
+#endif
+
 	err = arch_init_kprobes();
 	if (!err)
 		err = register_die_notifier(&kprobe_exceptions_nb);
@@ -2526,6 +2522,21 @@ static int __init init_kprobes(void)
 }
 early_initcall(init_kprobes);
 
+#if defined(CONFIG_OPTPROBES)
+static int __init init_optprobes(void)
+{
+	/*
+	 * Enable kprobe optimization - this kicks the optimizer which
+	 * depends on synchronize_rcu_tasks() and ksoftirqd, that is
+	 * not spawned in early initcall. So delay the optimization.
+	 */
+	optimize_all_kprobes();
+
+	return 0;
+}
+subsys_initcall(init_optprobes);
+#endif
+
 #ifdef CONFIG_DEBUG_FS
 static void report_probe(struct seq_file *pi, struct kprobe *p,
 		const char *sym, int offset, char *modname, struct kprobe *pp)
