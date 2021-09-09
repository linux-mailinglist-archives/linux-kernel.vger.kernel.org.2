Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 331074048E0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 13:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235353AbhIILFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 07:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234529AbhIILFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 07:05:12 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2BCCC061757
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 04:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=ATz4siT0o3VGtkfHcBx1PQAhUyM05lFC1JfA+ffa6YI=; b=p08T1AaBet5a7QG8Sv1nNPLiUK
        8z8D5UOxMEPSSveLXDDNN072CGg8M7EriohF95CG9VH6HpByIL0TK1UHQ19y19Fo4HvyMqgFYkgOH
        RJTlYOqBfqvrE30+/6ZfXUNV7Np9sT4YiZZNwehYN7qVvEhvNl3tdyi2NUOe4HySRyEJdXw8dTYlz
        YAs7Nx0hUJhfBWv9vaszjrO3yT0TtejxmcIas1n53tdcYyZgWsBxjhywF0ByQmyXbWwKiVMsq9bRP
        M/nHUGlGk+J+Og/XithLLh/ruJJRbnX4x0J7u7cYZDJCtr9ofBAvQLFKH+UQw52HghnXGhUxOHhn6
        Ty/GGiNg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mOHqF-001rBB-La; Thu, 09 Sep 2021 11:03:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CDD9F3000D5;
        Thu,  9 Sep 2021 13:03:37 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id B06A7213976A2; Thu,  9 Sep 2021 13:03:37 +0200 (CEST)
Message-ID: <20210909110203.767330253@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 09 Sep 2021 12:59:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mike Galbraith <efault@gmx.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [PATCH 1/4] sched/wakeup: Strengthen current_save_and_set_rtlock_wait_state()
References: <20210909105915.757320973@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While looking at current_save_and_set_rtlock_wait_state() I'm thinking
it really ought to use smp_store_mb(), because something like:

	current_save_and_set_rtlock_wait_state();
	for (;;) {
		if (try_lock())
			break;

		raw_spin_unlock_irq(&lock->wait_lock);
		schedule();
		raw_spin_lock_irq(&lock->wait_lock);

		set_current_state(TASK_RTLOCK_WAIT);
	}
	current_restore_rtlock_saved_state();

which is the advertised usage in the comment, is actually broken,
since trylock() will only need a load-acquire in general and that
could be re-ordered against the state store, which could lead to a
missed wakeup -> BAD (tm).

While there, make them consistent with the IRQ usage in
set_special_state().

Fixes: 5f220be21418 ("sched/wakeup: Prepare for RT sleeping spin/rwlocks")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/sched.h |   19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -245,7 +245,8 @@ struct task_group;
  *		if (try_lock())
  *			break;
  *		raw_spin_unlock_irq(&lock->wait_lock);
- *		schedule_rtlock();
+ *		if (!cond)
+ *			schedule_rtlock();
  *		raw_spin_lock_irq(&lock->wait_lock);
  *		set_current_state(TASK_RTLOCK_WAIT);
  *	}
@@ -253,22 +254,24 @@ struct task_group;
  */
 #define current_save_and_set_rtlock_wait_state()			\
 	do {								\
-		lockdep_assert_irqs_disabled();				\
-		raw_spin_lock(&current->pi_lock);			\
+		unsigned long flags; /* may shadow */			\
+									\
+		raw_spin_lock_irqsave(&current->pi_lock, flags);	\
 		current->saved_state = current->__state;		\
 		debug_rtlock_wait_set_state();				\
-		WRITE_ONCE(current->__state, TASK_RTLOCK_WAIT);		\
-		raw_spin_unlock(&current->pi_lock);			\
+		smp_store_mb(current->__state, TASK_RTLOCK_WAIT);	\
+		raw_spin_unlock_irqrestore(&current->pi_lock, flags);	\
 	} while (0);
 
 #define current_restore_rtlock_saved_state()				\
 	do {								\
-		lockdep_assert_irqs_disabled();				\
-		raw_spin_lock(&current->pi_lock);			\
+		unsigned long flags; /* may shadow */			\
+									\
+		raw_spin_lock_irqsave(&current->pi_lock, flags);	\
 		debug_rtlock_wait_restore_state();			\
 		WRITE_ONCE(current->__state, current->saved_state);	\
 		current->saved_state = TASK_RUNNING;			\
-		raw_spin_unlock(&current->pi_lock);			\
+		raw_spin_unlock_irqrestore(&current->pi_lock, flags);	\
 	} while (0);
 
 #define get_current_state()	READ_ONCE(current->__state)


