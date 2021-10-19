Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB45432B0D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 02:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234121AbhJSALA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 20:11:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:50568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233660AbhJSAKw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 20:10:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D2A0A6134F;
        Tue, 19 Oct 2021 00:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634602120;
        bh=I+rVJpf+l1B5EnX9zpT8Iiz5pGuAum2s2T1xTvDidjg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PJFej3vJ3xwgg99D96oVDOMsuubw3nEVSaLWkdqkKwLgroKhsrzJdMYDpaULgVw6/
         WlrqVAG5yLoc34nxBEMzstj98Yf8TUrpD3sq1xfdeeB8E6ppploqYr+tmT7w4f3bed
         I/XmA+0xqy9iI09wEHwsiNmz5GB/psh3qyozRJ0gzbpQxYtoa7dyIK0FB+tnN0R/E1
         rqkAFYqxB0TUumsy/CEC/Td9TZ9O5s65CZo+3Mbw09PeYCKET/P8EzfA1C8lYht4a/
         shZ6jDoKh84JqlpkceIWTtlu3NJTFg/IZm2/zlIZ0Icqi97oE0ZSSV06kx4L8WNiHI
         cLXc0v3ZjGx/A==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 06/10] rcu/nocb: Use appropriate rcu_nocb_lock_irqsave()
Date:   Tue, 19 Oct 2021 02:08:12 +0200
Message-Id: <20211019000816.455375-7-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211019000816.455375-1-frederic@kernel.org>
References: <20211019000816.455375-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of hardcoding IRQ save and nocb lock, use the consolidated
API (and fix a comment as per Valentin Schneider's suggestion).

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Tested-by: Valentin Schneider <valentin.schneider@arm.com>
Tested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Uladzislau Rezki <urezki@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 27500981d4b1..eaa9c7ce91bb 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2488,12 +2488,11 @@ static void rcu_do_batch(struct rcu_data *rdp)
 	}
 
 	/*
-	 * Extract the list of ready callbacks, disabling to prevent
+	 * Extract the list of ready callbacks, disabling IRQs to prevent
 	 * races with call_rcu() from interrupt handlers.  Leave the
 	 * callback counts, as rcu_barrier() needs to be conservative.
 	 */
-	local_irq_save(flags);
-	rcu_nocb_lock(rdp);
+	rcu_nocb_lock_irqsave(rdp, flags);
 	WARN_ON_ONCE(cpu_is_offline(smp_processor_id()));
 	pending = rcu_segcblist_n_cbs(&rdp->cblist);
 	div = READ_ONCE(rcu_divisor);
@@ -2556,8 +2555,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
 		}
 	}
 
-	local_irq_save(flags);
-	rcu_nocb_lock(rdp);
+	rcu_nocb_lock_irqsave(rdp, flags);
 	rdp->n_cbs_invoked += count;
 	trace_rcu_batch_end(rcu_state.name, count, !!rcl.head, need_resched(),
 			    is_idle_task(current), rcu_is_callbacks_kthread());
-- 
2.25.1

