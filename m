Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75487332170
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 09:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbhCII6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 03:58:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbhCII5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 03:57:48 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89108C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 00:57:48 -0800 (PST)
Message-Id: <20210309085727.626304079@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615280267;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=3rMEmDO24EzcVsDgyInXVCeqbWXPh9IEQiv/IkNsRp4=;
        b=oT1sA0Fk7BNAVSyyG42A9jiat8M3sEX71FcYhiapbpXtkF3azMGODUmyLQCk4Y9uXX7lgQ
        1SVKQ5x3VqZShbZXzH8BoXPJZ9foRraXS7t30xCMFjTT4kr5/jIVjITlgrjqBbm1Uh+IdU
        hhBIe9BJzdugl8+jEv2pKJCVPmCKBDsBNVAgQTB6GY39pUAqZff8APiBHGfH//b7N60bZ1
        wyefTw9qYq+rsx4Et7Q9WesXFrDnJzpXPaxecFPfxb9As6TehgVHmPcyCINtFTehegUZPm
        1xjlFIwCCsDTSrH/t743ixDt0afkEXmM9qebooDSjFOrOGU9LKRoliCUD0ZMyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615280267;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=3rMEmDO24EzcVsDgyInXVCeqbWXPh9IEQiv/IkNsRp4=;
        b=R7+cXyLdiK81ohfBOBTUmItNg9XObzmusl6xfWQcMVgvRRo8ECK4oQc7ylZ29c3xkI4T77
        sWBzpJCYO3ckqvAg==
Date:   Tue, 09 Mar 2021 09:55:58 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [patch V3 6/6] rcu: Prevent false positive softirq warning on RT
References: <20210309085552.815026890@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Soft interrupt disabled sections can legitimately be preempted or schedule
out when blocking on a lock on RT enabled kernels so the RCU preempt check
warning has to be disabled for RT kernels.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcupdate.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -334,7 +334,8 @@ static inline void rcu_preempt_sleep_che
 #define rcu_sleep_check()						\
 	do {								\
 		rcu_preempt_sleep_check();				\
-		RCU_LOCKDEP_WARN(lock_is_held(&rcu_bh_lock_map),	\
+		if (!IS_ENABLED(CONFIG_PREEMPT_RT))			\
+		    RCU_LOCKDEP_WARN(lock_is_held(&rcu_bh_lock_map),	\
 				 "Illegal context switch in RCU-bh read-side critical section"); \
 		RCU_LOCKDEP_WARN(lock_is_held(&rcu_sched_lock_map),	\
 				 "Illegal context switch in RCU-sched read-side critical section"); \

