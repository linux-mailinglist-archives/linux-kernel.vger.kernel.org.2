Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 334543AC60C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 10:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233483AbhFRI2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 04:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231818AbhFRI2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 04:28:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E7AC061574
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 01:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=K2lN+Kq/zK1Ac7cCD9hw1QtjHP7819cu9ufqwGW51Y8=; b=E4xvEaNuTkjxOQbe89LPiqq4KA
        J9eYGeBaVLCj8YNHkC7nFFueZh530ivPvWvnOXq9M0PQqd+ZgQotKz87OFiyaKHpyZW0/Ja6CDxCB
        1JgsDnwXfQ6fLgROVqHucnq2hQ+mfIVpfIMAx92sg4fV17mlN2oHL+AjgPeCAGkeo5xqpAlQfjHxR
        yqpiztpp1k5SjtysEax4d6Ot7Wclx9Bm4FXaCssaI4LAW0YaButpw5nDU/2EEwHtWoLGf8tbXqyjC
        Ohd55bD7y1N3TC1Siq8Ql6rsqIm2C0EuEQPjk6Jp33Wjo2wTD7DD8OnbYTFdii5GIjN+ijrZ8F3yv
        hoQZetUg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lu9ns-00A3pq-UP; Fri, 18 Jun 2021 08:25:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B97A7300252;
        Fri, 18 Jun 2021 10:24:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9EC5220D89365; Fri, 18 Jun 2021 10:24:39 +0200 (CEST)
Date:   Fri, 18 Jun 2021 10:24:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Paul McKenney <paulmck@kernel.org>, elver@google.com
Cc:     linux-kernel@vger.kernel.org
Subject: RCU vs data_race()
Message-ID: <YMxYR33XEfVg6AoD@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

Due to a merge conflict I had to look at some recent RCU code, and I saw
you went a little overboard with data_race(). How's something like the
below look to you?

The idea being that we fundamentally don't care about data races for
debug/error condition prints, so marking every single variable access is
just clutter.

---
diff --git a/include/linux/printk.h b/include/linux/printk.h
index f589b8b60806..8f21916c2fe2 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -315,7 +315,7 @@ extern int kptr_restrict;
  * generate the format string.
  */
 #define pr_emerg(fmt, ...) \
-	printk(KERN_EMERG pr_fmt(fmt), ##__VA_ARGS__)
+	data_race(printk(KERN_EMERG pr_fmt(fmt), ##__VA_ARGS__))
 /**
  * pr_alert - Print an alert-level message
  * @fmt: format string
@@ -325,7 +325,7 @@ extern int kptr_restrict;
  * generate the format string.
  */
 #define pr_alert(fmt, ...) \
-	printk(KERN_ALERT pr_fmt(fmt), ##__VA_ARGS__)
+	data_race(printk(KERN_ALERT pr_fmt(fmt), ##__VA_ARGS__))
 /**
  * pr_crit - Print a critical-level message
  * @fmt: format string
@@ -335,7 +335,7 @@ extern int kptr_restrict;
  * generate the format string.
  */
 #define pr_crit(fmt, ...) \
-	printk(KERN_CRIT pr_fmt(fmt), ##__VA_ARGS__)
+	data_race(printk(KERN_CRIT pr_fmt(fmt), ##__VA_ARGS__))
 /**
  * pr_err - Print an error-level message
  * @fmt: format string
@@ -345,7 +345,7 @@ extern int kptr_restrict;
  * generate the format string.
  */
 #define pr_err(fmt, ...) \
-	printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
+	data_race(printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__))
 /**
  * pr_warn - Print a warning-level message
  * @fmt: format string
@@ -355,7 +355,7 @@ extern int kptr_restrict;
  * to generate the format string.
  */
 #define pr_warn(fmt, ...) \
-	printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
+	data_race(printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__))
 /**
  * pr_notice - Print a notice-level message
  * @fmt: format string
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 6833d8887181..8bb4ec3c7e6e 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1353,8 +1353,10 @@ void srcu_torture_stats_print(struct srcu_struct *ssp, char *tt, char *tf)
 		struct srcu_data *sdp;
 
 		sdp = per_cpu_ptr(ssp->sda, cpu);
-		u0 = data_race(sdp->srcu_unlock_count[!idx]);
-		u1 = data_race(sdp->srcu_unlock_count[idx]);
+
+		data_race(
+		u0 = sdp->srcu_unlock_count[!idx];
+		u1 = sdp->srcu_unlock_count[idx];
 
 		/*
 		 * Make sure that a lock is always counted if the corresponding
@@ -1362,14 +1364,15 @@ void srcu_torture_stats_print(struct srcu_struct *ssp, char *tt, char *tf)
 		 */
 		smp_rmb();
 
-		l0 = data_race(sdp->srcu_lock_count[!idx]);
-		l1 = data_race(sdp->srcu_lock_count[idx]);
+		l0 = sdp->srcu_lock_count[!idx];
+		l1 = sdp->srcu_lock_count[idx];
 
 		c0 = l0 - u0;
 		c1 = l1 - u1;
 		pr_cont(" %d(%ld,%ld %c)",
 			cpu, c0, c1,
-			"C."[rcu_segcblist_empty(&sdp->srcu_cblist)]);
+			"C."[rcu_segcblist_empty(&sdp->srcu_cblist)]));
+
 		s0 += c0;
 		s1 += c1;
 	}
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 1cece5e9be9a..53080c3bede2 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -280,15 +280,15 @@ static void __init rcu_tasks_bootup_oddness(void)
 /* Dump out rcutorture-relevant state common to all RCU-tasks flavors. */
 static void show_rcu_tasks_generic_gp_kthread(struct rcu_tasks *rtp, char *s)
 {
+	data_race(
 	pr_info("%s: %s(%d) since %lu g:%lu i:%lu/%lu %c%c %s\n",
 		rtp->kname,
-		tasks_gp_state_getname(rtp), data_race(rtp->gp_state),
-		jiffies - data_race(rtp->gp_jiffies),
-		data_race(rtp->n_gps),
-		data_race(rtp->n_ipis_fails), data_race(rtp->n_ipis),
-		".k"[!!data_race(rtp->kthread_ptr)],
-		".C"[!!data_race(rtp->cbs_head)],
-		s);
+		tasks_gp_state_getname(rtp), rtp->gp_state,
+		jiffies - rtp->gp_jiffies,
+		rtp->n_gps, rtp->n_ipis_fails, rtp->n_ipis,
+		".k"[!!rtp->kthread_ptr],
+		".C"[!!rtp->cbs_head],
+		s));
 }
 #endif // #ifndef CONFIG_TINY_RCU
 
@@ -1291,10 +1291,11 @@ void show_rcu_tasks_trace_gp_kthread(void)
 {
 	char buf[64];
 
+	data_race(
 	sprintf(buf, "N%d h:%lu/%lu/%lu", atomic_read(&trc_n_readers_need_end),
-		data_race(n_heavy_reader_ofl_updates),
-		data_race(n_heavy_reader_updates),
-		data_race(n_heavy_reader_attempts));
+		n_heavy_reader_ofl_updates,
+		n_heavy_reader_updates,
+		n_heavy_reader_attempts));
 	show_rcu_tasks_generic_gp_kthread(&rcu_tasks_trace, buf);
 }
 EXPORT_SYMBOL_GPL(show_rcu_tasks_trace_gp_kthread);
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 24065f1acb8b..1e392beabbba 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -448,7 +448,7 @@ static void print_cpu_stall_info(int cpu)
 	       rcu_dynticks_snap(rdp) & 0xfff,
 	       rdp->dynticks_nesting, rdp->dynticks_nmi_nesting,
 	       rdp->softirq_snap, kstat_softirqs_cpu(RCU_SOFTIRQ, cpu),
-	       data_race(rcu_state.n_force_qs) - rcu_state.n_force_qs_gpstart,
+	       rcu_state.n_force_qs - rcu_state.n_force_qs_gpstart,
 	       fast_no_hz,
 	       falsepositive ? " (false positive?)" : "");
 }
@@ -465,10 +465,10 @@ static void rcu_check_gp_kthread_starvation(void)
 		pr_err("%s kthread starved for %ld jiffies! g%ld f%#x %s(%d) ->state=%#lx ->cpu=%d\n",
 		       rcu_state.name, j,
 		       (long)rcu_seq_current(&rcu_state.gp_seq),
-		       data_race(READ_ONCE(rcu_state.gp_flags)),
+		       READ_ONCE(rcu_state.gp_flags),
 		       gp_state_getname(rcu_state.gp_state),
-		       data_race(READ_ONCE(rcu_state.gp_state)),
-		       gpk ? data_race(READ_ONCE(gpk->state)) : ~0, cpu);
+		       READ_ONCE(rcu_state.gp_state),
+		       gpk ? READ_ONCE(gpk->state) : ~0, cpu);
 		if (gpk) {
 			pr_err("\tUnless %s kthread gets sufficient CPU time, OOM is now expected behavior.\n", rcu_state.name);
 			pr_err("RCU grace-period kthread stack dump:\n");
@@ -509,9 +509,9 @@ static void rcu_check_gp_kthread_expired_fqs_timer(void)
 		pr_err("%s kthread timer wakeup didn't happen for %ld jiffies! g%ld f%#x %s(%d) ->state=%#lx\n",
 		       rcu_state.name, (jiffies - jiffies_fqs),
 		       (long)rcu_seq_current(&rcu_state.gp_seq),
-		       data_race(rcu_state.gp_flags),
+		       rcu_state.gp_flags,
 		       gp_state_getname(RCU_GP_WAIT_FQS), RCU_GP_WAIT_FQS,
-		       data_race(READ_ONCE(gpk->state)));
+		       READ_ONCE(gpk->state));
 		pr_err("\tPossible timer handling issue on cpu=%d timer-softirq=%u\n",
 		       cpu, kstat_softirqs_cpu(TIMER_SOFTIRQ, cpu));
 	}
@@ -573,8 +573,8 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
 			gpa = data_race(READ_ONCE(rcu_state.gp_activity));
 			pr_err("All QSes seen, last %s kthread activity %ld (%ld-%ld), jiffies_till_next_fqs=%ld, root ->qsmask %#lx\n",
 			       rcu_state.name, j - gpa, j, gpa,
-			       data_race(READ_ONCE(jiffies_till_next_fqs)),
-			       data_race(READ_ONCE(rcu_get_root()->qsmask)));
+			       READ_ONCE(jiffies_till_next_fqs),
+			       READ_ONCE(rcu_get_root()->qsmask));
 		}
 	}
 	/* Rewrite if needed in case of slow consoles. */
@@ -815,37 +815,43 @@ void show_rcu_gp_kthreads(void)
 	struct rcu_node *rnp;
 	struct task_struct *t = READ_ONCE(rcu_state.gp_kthread);
 
+	kcsan_disable_current();
+
 	j = jiffies;
-	ja = j - data_race(READ_ONCE(rcu_state.gp_activity));
-	jr = j - data_race(READ_ONCE(rcu_state.gp_req_activity));
-	js = j - data_race(READ_ONCE(rcu_state.gp_start));
-	jw = j - data_race(READ_ONCE(rcu_state.gp_wake_time));
+	ja = j - READ_ONCE(rcu_state.gp_activity);
+	jr = j - READ_ONCE(rcu_state.gp_req_activity);
+	js = j - READ_ONCE(rcu_state.gp_start);
+	jw = j - READ_ONCE(rcu_state.gp_wake_time);
 	pr_info("%s: wait state: %s(%d) ->state: %#lx ->rt_priority %u delta ->gp_start %lu ->gp_activity %lu ->gp_req_activity %lu ->gp_wake_time %lu ->gp_wake_seq %ld ->gp_seq %ld ->gp_seq_needed %ld ->gp_max %lu ->gp_flags %#x\n",
 		rcu_state.name, gp_state_getname(rcu_state.gp_state),
-		data_race(READ_ONCE(rcu_state.gp_state)),
-		t ? data_race(READ_ONCE(t->state)) : 0x1ffffL, t ? t->rt_priority : 0xffU,
-		js, ja, jr, jw, (long)data_race(READ_ONCE(rcu_state.gp_wake_seq)),
-		(long)data_race(READ_ONCE(rcu_state.gp_seq)),
-		(long)data_race(READ_ONCE(rcu_get_root()->gp_seq_needed)),
-		data_race(READ_ONCE(rcu_state.gp_max)),
-		data_race(READ_ONCE(rcu_state.gp_flags)));
+		READ_ONCE(rcu_state.gp_state),
+		t ? READ_ONCE(t->state) : 0x1ffffL, t ? t->rt_priority : 0xffU,
+		js, ja, jr, jw, (long)READ_ONCE(rcu_state.gp_wake_seq),
+		(long)READ_ONCE(rcu_state.gp_seq),
+		(long)READ_ONCE(rcu_get_root()->gp_seq_needed),
+		READ_ONCE(rcu_state.gp_max),
+		READ_ONCE(rcu_state.gp_flags));
+
 	rcu_for_each_node_breadth_first(rnp) {
 		if (ULONG_CMP_GE(READ_ONCE(rcu_state.gp_seq), READ_ONCE(rnp->gp_seq_needed)) &&
-		    !data_race(READ_ONCE(rnp->qsmask)) && !data_race(READ_ONCE(rnp->boost_tasks)) &&
-		    !data_race(READ_ONCE(rnp->exp_tasks)) && !data_race(READ_ONCE(rnp->gp_tasks)))
+		    !READ_ONCE(rnp->qsmask) && !READ_ONCE(rnp->boost_tasks) &&
+		    !READ_ONCE(rnp->exp_tasks) && !READ_ONCE(rnp->gp_tasks))
 			continue;
+
 		pr_info("\trcu_node %d:%d ->gp_seq %ld ->gp_seq_needed %ld ->qsmask %#lx %c%c%c%c ->n_boosts %ld\n",
 			rnp->grplo, rnp->grphi,
-			(long)data_race(READ_ONCE(rnp->gp_seq)),
-			(long)data_race(READ_ONCE(rnp->gp_seq_needed)),
-			data_race(READ_ONCE(rnp->qsmask)),
-			".b"[!!data_race(READ_ONCE(rnp->boost_kthread_task))],
-			".B"[!!data_race(READ_ONCE(rnp->boost_tasks))],
-			".E"[!!data_race(READ_ONCE(rnp->exp_tasks))],
-			".G"[!!data_race(READ_ONCE(rnp->gp_tasks))],
-			data_race(READ_ONCE(rnp->n_boosts)));
+			(long)READ_ONCE(rnp->gp_seq),
+			(long)READ_ONCE(rnp->gp_seq_needed),
+			READ_ONCE(rnp->qsmask),
+			".b"[!!READ_ONCE(rnp->boost_kthread_task)],
+			".B"[!!READ_ONCE(rnp->boost_tasks)],
+			".E"[!!READ_ONCE(rnp->exp_tasks)],
+			".G"[!!READ_ONCE(rnp->gp_tasks)],
+			READ_ONCE(rnp->n_boosts));
+
 		if (!rcu_is_leaf_node(rnp))
 			continue;
+
 		for_each_leaf_node_possible_cpu(rnp, cpu) {
 			rdp = per_cpu_ptr(&rcu_data, cpu);
 			if (READ_ONCE(rdp->gpwrap) ||
@@ -853,17 +859,19 @@ void show_rcu_gp_kthreads(void)
 					 READ_ONCE(rdp->gp_seq_needed)))
 				continue;
 			pr_info("\tcpu %d ->gp_seq_needed %ld\n",
-				cpu, (long)data_race(READ_ONCE(rdp->gp_seq_needed)));
+				cpu, (long)READ_ONCE(rdp->gp_seq_needed));
 		}
 	}
 	for_each_possible_cpu(cpu) {
 		rdp = per_cpu_ptr(&rcu_data, cpu);
-		cbs += data_race(READ_ONCE(rdp->n_cbs_invoked));
+		cbs += READ_ONCE(rdp->n_cbs_invoked);
 		if (rcu_segcblist_is_offloaded(&rdp->cblist))
 			show_rcu_nocb_state(rdp);
 	}
 	pr_info("RCU callbacks invoked since boot: %lu\n", cbs);
 	show_rcu_tasks_gp_kthreads();
+
+	kcsan_enable_current();
 }
 EXPORT_SYMBOL_GPL(show_rcu_gp_kthreads);
 
