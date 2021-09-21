Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1FC413C19
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 23:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234886AbhIUVOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 17:14:24 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51190 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232386AbhIUVOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 17:14:21 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632258771;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B/d9ecYh2L4gIWFi5kh23O8/tmeJ+Zy/cOZw1iVbWJ0=;
        b=aoWeT3TAKrBIFSeky1ZLElvf7XtWUfLAzGXcrkiNVE+lzLHwt49Ll0ytAV2q8aPLgCLmhI
        qdBtJ3KoCjGNkY//0RlUBSXaGUBGohFQU3Iha3XJtzuCQ4d0qKRVuMiDMhpq7xN697cRFG
        mdX6yPlwppfpjOdcB2HHKO5XtS5tLrJZiQ5pcQA3xQ24QgpIhqQFtdsjTMKiTHUpmEiWRe
        SXbvvsm4QuK7Bxr5XCA2hSrEDCQK+STSKIASSH1XXzfVLyMPBWA94am2gt4URR0GApSkBP
        CLvAgPpxGyNm2bZP1+d2XFkUc+iVy+4JRW0jAj+f89oBvDkQOXuSDwOeV4Q8Vw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632258771;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B/d9ecYh2L4gIWFi5kh23O8/tmeJ+Zy/cOZw1iVbWJ0=;
        b=3jjc+7PBcS4ow3JDn4taHqXHsmytqlFtKQZlG67nicGebcHU638avfYfsznAktpZ4wte6s
        t6czxYYgRKS6L4Dw==
To:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        rcu@vger.kernel.org, linux-rt-users@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Steven Price <steven.price@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mike Galbraith <efault@gmx.de>
Subject: rcu/tree: Protect rcu_rdp_is_offloaded() invocations on RT
In-Reply-To: <874kae6n3g.ffs@tglx>
References: <20210811201354.1976839-1-valentin.schneider@arm.com>
 <20210811201354.1976839-4-valentin.schneider@arm.com>
 <874kae6n3g.ffs@tglx>
Date:   Tue, 21 Sep 2021 23:12:50 +0200
Message-ID: <87pmt163al.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Valentin reported warnings about suspicious RCU usage on RT kernels. Those
happen when offloading of RCU callbacks is enabled:

  WARNING: suspicious RCU usage
  5.13.0-rt1 #20 Not tainted
  -----------------------------
  kernel/rcu/tree_plugin.h:69 Unsafe read of RCU_NOCB offloaded state!

  rcu_rdp_is_offloaded (kernel/rcu/tree_plugin.h:69 kernel/rcu/tree_plugin.h:58)
  rcu_core (kernel/rcu/tree.c:2332 kernel/rcu/tree.c:2398 kernel/rcu/tree.c:2777)
  rcu_cpu_kthread (./include/linux/bottom_half.h:32 kernel/rcu/tree.c:2876)

The reason is that rcu_rdp_is_offloaded() is invoked without one of the
required protections on RT enabled kernels because local_bh_disable() does
not disable preemption on RT.

Valentin proposed to add a local lock to the code in question, but that's
suboptimal in several aspects:

  1) local locks add extra code to !RT kernels for no value.

  2) All possible callsites have to audited and amended when affected
     possible at an outer function level due to lock nesting issues.

  3) As the local lock has to be taken at the outer functions it's required
     to release and reacquire them in the inner code sections which might
     voluntary schedule, e.g. rcu_do_batch().

Both callsites of rcu_rdp_is_offloaded() which trigger this check invoke
rcu_rdp_is_offloaded() in the variable declaration section right at the top
of the functions. But the actual usage of the result is either within a
section which provides the required protections or after such a section.

So the obvious solution is to move the invocation into the code sections
which provide the proper protections, which solves the problem for RT and
does not have any impact on !RT kernels.

Reported-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/rcu/tree.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2278,13 +2278,13 @@ rcu_report_qs_rdp(struct rcu_data *rdp)
 {
 	unsigned long flags;
 	unsigned long mask;
-	bool needwake = false;
-	const bool offloaded = rcu_rdp_is_offloaded(rdp);
+	bool offloaded, needwake = false;
 	struct rcu_node *rnp;
 
 	WARN_ON_ONCE(rdp->cpu != smp_processor_id());
 	rnp = rdp->mynode;
 	raw_spin_lock_irqsave_rcu_node(rnp, flags);
+	offloaded = rcu_rdp_is_offloaded(rdp);
 	if (rdp->cpu_no_qs.b.norm || rdp->gp_seq != rnp->gp_seq ||
 	    rdp->gpwrap) {
 
@@ -2446,7 +2446,7 @@ static void rcu_do_batch(struct rcu_data
 	int div;
 	bool __maybe_unused empty;
 	unsigned long flags;
-	const bool offloaded = rcu_rdp_is_offloaded(rdp);
+	bool offloaded;
 	struct rcu_head *rhp;
 	struct rcu_cblist rcl = RCU_CBLIST_INITIALIZER(rcl);
 	long bl, count = 0;
@@ -2472,6 +2472,7 @@ static void rcu_do_batch(struct rcu_data
 	rcu_nocb_lock(rdp);
 	WARN_ON_ONCE(cpu_is_offline(smp_processor_id()));
 	pending = rcu_segcblist_n_cbs(&rdp->cblist);
+	offloaded = rcu_rdp_is_offloaded(rdp);
 	div = READ_ONCE(rcu_divisor);
 	div = div < 0 ? 7 : div > sizeof(long) * 8 - 2 ? sizeof(long) * 8 - 2 : div;
 	bl = max(rdp->blimit, pending >> div);
