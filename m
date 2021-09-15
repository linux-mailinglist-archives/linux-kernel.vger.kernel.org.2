Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75D4A40D069
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 01:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233280AbhIOXrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 19:47:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:49356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233050AbhIOXrZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 19:47:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E8BA06113E;
        Wed, 15 Sep 2021 23:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631749566;
        bh=tBTLNxUFn/9oqHiZ5NMkB3NmIBVvganvnDawKOSirrc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Eq8iokSXtNaF+BFpuMKvzvgaXUSst67yc+I/ZEeKyMXX8Q9ZLjng+6rST+TTS10oy
         uTkNM2Nu9FFvzGogxydHrsd/19PM2ID1HYRahDnm3UwTHFzNcTCEvm3HpRruNkWyLj
         FZROKpBd6CXe6puUQPhqR3Vzj6/fmaRcI6aqE1oUdIW+C4mlLL88JxwVtHKTaFIE3A
         wD1t5qRRuvQNBHJsngztCViPB9FbVB9fKgCfDFw2Q5JD/CIcS7exN/8Oui/GidBXwn
         X6VeGE+sWSOSuw96GxmJhWByXEF0TityqwxAN93MiAnnxrbg7K+JKmoC5nhWuegyw4
         cCxR8u3DIRsAA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C452F5C08E8; Wed, 15 Sep 2021 16:46:05 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 04/13] rcu-tasks: Remove second argument of rcu_read_unlock_trace_special()
Date:   Wed, 15 Sep 2021 16:45:55 -0700
Message-Id: <20210915234604.3907802-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210915234538.GA3907674@paulmck-ThinkPad-P17-Gen-1>
References: <20210915234538.GA3907674@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The second argument of rcu_read_unlock_trace_special() is always zero.
When called from exit_tasks_rcu_finish_trace(), it is the constant
zero, and rcu_read_unlock_trace_special() doesn't get called from
rcu_read_unlock_trace() unless the value of local variable "nesting"
is zero because in that case the early return is taken instead.

This commit therefore removes the "nesting" argument from the
rcu_read_unlock_trace_special() function, substituting the constant
zero within that function.  This commit also adds a WARN_ON_ONCE()
to rcu_read_lock_trace_held() in case non-zeroness some day appears.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcupdate_trace.h | 5 +++--
 kernel/rcu/tasks.h             | 6 +++---
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/linux/rcupdate_trace.h b/include/linux/rcupdate_trace.h
index 86c8f6c98412..6f9c35817398 100644
--- a/include/linux/rcupdate_trace.h
+++ b/include/linux/rcupdate_trace.h
@@ -31,7 +31,7 @@ static inline int rcu_read_lock_trace_held(void)
 
 #ifdef CONFIG_TASKS_TRACE_RCU
 
-void rcu_read_unlock_trace_special(struct task_struct *t, int nesting);
+void rcu_read_unlock_trace_special(struct task_struct *t);
 
 /**
  * rcu_read_lock_trace - mark beginning of RCU-trace read-side critical section
@@ -80,7 +80,8 @@ static inline void rcu_read_unlock_trace(void)
 		WRITE_ONCE(t->trc_reader_nesting, nesting);
 		return;  // We assume shallow reader nesting.
 	}
-	rcu_read_unlock_trace_special(t, nesting);
+	WARN_ON_ONCE(nesting != 0);
+	rcu_read_unlock_trace_special(t);
 }
 
 void call_rcu_tasks_trace(struct rcu_head *rhp, rcu_callback_t func);
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 8387e70e6b00..a3f4f9bd8c67 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -848,7 +848,7 @@ static void rcu_read_unlock_iw(struct irq_work *iwp)
 static DEFINE_IRQ_WORK(rcu_tasks_trace_iw, rcu_read_unlock_iw);
 
 /* If we are the last reader, wake up the grace-period kthread. */
-void rcu_read_unlock_trace_special(struct task_struct *t, int nesting)
+void rcu_read_unlock_trace_special(struct task_struct *t)
 {
 	int nq = READ_ONCE(t->trc_reader_special.b.need_qs);
 
@@ -858,7 +858,7 @@ void rcu_read_unlock_trace_special(struct task_struct *t, int nesting)
 	// Update .need_qs before ->trc_reader_nesting for irq/NMI handlers.
 	if (nq)
 		WRITE_ONCE(t->trc_reader_special.b.need_qs, false);
-	WRITE_ONCE(t->trc_reader_nesting, nesting);
+	WRITE_ONCE(t->trc_reader_nesting, 0);
 	if (nq && atomic_dec_and_test(&trc_n_readers_need_end))
 		irq_work_queue(&rcu_tasks_trace_iw);
 }
@@ -1200,7 +1200,7 @@ static void exit_tasks_rcu_finish_trace(struct task_struct *t)
 	WARN_ON_ONCE(READ_ONCE(t->trc_reader_nesting));
 	WRITE_ONCE(t->trc_reader_nesting, 0);
 	if (WARN_ON_ONCE(READ_ONCE(t->trc_reader_special.b.need_qs)))
-		rcu_read_unlock_trace_special(t, 0);
+		rcu_read_unlock_trace_special(t);
 }
 
 /**
-- 
2.31.1.189.g2e36527f23

