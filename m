Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB1B032C48E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441822AbhCDAPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 19:15:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:33266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353197AbhCDADm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 19:03:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 25E4764FD3;
        Thu,  4 Mar 2021 00:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614816023;
        bh=5jv1rclaj24AUph/4rIICx4KBCgni658+UJ/ISnjw0A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PztYxZ9UrYPpZGPQWHSAtL4/R9KNgYNw6M5x8a/JYRBaO+jx8C5mIzcffiKMtpZ5b
         7n/LAZM662hlNT4gj96FC6FoRR6b+j8F7W8cbyCn4qeymiI4JSfhNzzTggZOmUDaIY
         6oJlc6tTu3FvZw9cSfsBvs0SnUrA2JJ2nL5j7d7oeAoF77wx5izOtogz0BgOg4/Ea6
         nQAcv0Y0zY9nFjD//fArHh6Gm2cGLZUxPg4F7/pRnk6KwndpxXxBiL4mYP1oVwc0VG
         +QRndmqgzVTgD/8ZA3rUE7s943jbmkq38hlr61tsuYw7w+3nk+ciAtts7TNd3BqqB9
         7jCakm6cMFVdQ==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 07/10] rcu: Prevent dyntick-idle until ksoftirqd has been spawned
Date:   Wed,  3 Mar 2021 16:00:16 -0800
Message-Id: <20210304000019.22459-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210303235958.GA22373@paulmck-ThinkPad-P72>
References: <20210303235958.GA22373@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

After interrupts have enabled at boot but before some random point
in early_initcall() processing, softirq processing is unreliable.
If softirq sees a need to push softirq-handler invocation to ksoftirqd
during this time, then those handlers can be delayed until the ksoftirqd
kthreads have been spawned, which happens at some random point in the
early_initcall() processing.  In many cases, this delay is just fine.
However, if the boot sequence blocks waiting for a wakeup from a softirq
handler, this delay will result in a silent-hang deadlock.

This commit therefore prevents these hangs by ensuring that the tick
stays active until after the ksoftirqd kthreads have been spawned.
This change causes the tick to eventually drain the backlog of delayed
softirq handlers, breaking this deadlock.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 2d60377..36212de 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1255,6 +1255,11 @@ static void rcu_prepare_kthreads(int cpu)
  */
 int rcu_needs_cpu(u64 basemono, u64 *nextevt)
 {
+	/* Through early_initcall(), need tick for softirq handlers. */
+	if (!IS_ENABLED(CONFIG_HZ_PERIODIC) && !this_cpu_ksoftirqd()) {
+		*nextevt = 1;
+		return 1;
+	}
 	*nextevt = KTIME_MAX;
 	return !rcu_segcblist_empty(&this_cpu_ptr(&rcu_data)->cblist) &&
 	       !rcu_segcblist_is_offloaded(&this_cpu_ptr(&rcu_data)->cblist);
@@ -1350,6 +1355,12 @@ int rcu_needs_cpu(u64 basemono, u64 *nextevt)
 
 	lockdep_assert_irqs_disabled();
 
+	/* Through early_initcall(), need tick for softirq handlers. */
+	if (!IS_ENABLED(CONFIG_HZ_PERIODIC) && !this_cpu_ksoftirqd()) {
+		*nextevt = 1;
+		return 1;
+	}
+
 	/* If no non-offloaded callbacks, RCU doesn't need the CPU. */
 	if (rcu_segcblist_empty(&rdp->cblist) ||
 	    rcu_segcblist_is_offloaded(&this_cpu_ptr(&rcu_data)->cblist)) {
-- 
2.9.5

