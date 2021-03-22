Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 360C2344CCC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 18:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbhCVRHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 13:07:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:42386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230258AbhCVRHR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 13:07:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F29736146D;
        Mon, 22 Mar 2021 17:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616432836;
        bh=peIWiBD6YyOiuy/e+6IZKWkYGqpzY2VbfDHlDQ1GKXk=;
        h=From:To:Cc:Subject:Date:From;
        b=IBLzoCdD1FBARnSXkOyUat3DHa/o56FIYaYwfHZn8ZI4jWDucXVaG/EPjCHs3hJ6F
         dZ0nROw0I3OrWbjmX6X9sOEf+V3gzesMghGF6FSkXKnH3z9kuLws8fTZboc59pt5wl
         U3ASX2jdp6my3fU276SLPxvmKrL1k1mFM4Zbp+aEk/HWnf3OeiuG0X7w+OQjI/s5KV
         5kptU59J/rAIKc6YlRw1nw/BLW5pdW/j7rVnTHslbQzKsMMoVM3H1FcW/j4XC/6Bl/
         lqcfg5W3Gyd8pO26DFZCIrgAY7t+jKiee6yDGoDaO1Oy4SVZ9yVwSma3I4EBkZmBuH
         VbpOYEIiErUZQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] static_call: fix function type mismatch
Date:   Mon, 22 Mar 2021 18:06:37 +0100
Message-Id: <20210322170711.1855115-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The __static_call_return0() function is declared to return a 'long',
while it aliases a couple of functions that all return 'int'. When
building with 'make W=1', gcc warns about this:

kernel/sched/core.c:5420:37: error: cast between incompatible function types from 'long int (*)(void)' to 'int (*)(void)' [-Werror=cast-function-type]
 5420 |   static_call_update(might_resched, (typeof(&__cond_resched)) __static_call_return0);

Change the function to return 'int' as well, but remove the cast to
ensure we get a warning if any of the types ever change.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/static_call.h | 6 +++---
 kernel/sched/core.c         | 6 +++---
 kernel/static_call.c        | 2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/static_call.h b/include/linux/static_call.h
index 85ecc789f4ff..3fc2975906ad 100644
--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -148,7 +148,7 @@ extern void __static_call_update(struct static_call_key *key, void *tramp, void
 extern int static_call_mod_init(struct module *mod);
 extern int static_call_text_reserved(void *start, void *end);
 
-extern long __static_call_return0(void);
+extern int __static_call_return0(void);
 
 #define __DEFINE_STATIC_CALL(name, _func, _func_init)			\
 	DECLARE_STATIC_CALL(name, _func);				\
@@ -221,7 +221,7 @@ static inline int static_call_text_reserved(void *start, void *end)
 	return 0;
 }
 
-static inline long __static_call_return0(void)
+static inline int __static_call_return0(void)
 {
 	return 0;
 }
@@ -247,7 +247,7 @@ struct static_call_key {
 	void *func;
 };
 
-static inline long __static_call_return0(void)
+static inline int __static_call_return0(void)
 {
 	return 0;
 }
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3a36f0b0742e..d22c609b9484 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5399,7 +5399,7 @@ static void sched_dynamic_update(int mode)
 	switch (mode) {
 	case preempt_dynamic_none:
 		static_call_update(cond_resched, __cond_resched);
-		static_call_update(might_resched, (typeof(&__cond_resched)) __static_call_return0);
+		static_call_update(might_resched, __static_call_return0);
 		static_call_update(preempt_schedule, (typeof(&preempt_schedule)) NULL);
 		static_call_update(preempt_schedule_notrace, (typeof(&preempt_schedule_notrace)) NULL);
 		static_call_update(irqentry_exit_cond_resched, (typeof(&irqentry_exit_cond_resched)) NULL);
@@ -5416,8 +5416,8 @@ static void sched_dynamic_update(int mode)
 		break;
 
 	case preempt_dynamic_full:
-		static_call_update(cond_resched, (typeof(&__cond_resched)) __static_call_return0);
-		static_call_update(might_resched, (typeof(&__cond_resched)) __static_call_return0);
+		static_call_update(cond_resched, __static_call_return0);
+		static_call_update(might_resched, __static_call_return0);
 		static_call_update(preempt_schedule, __preempt_schedule_func);
 		static_call_update(preempt_schedule_notrace, __preempt_schedule_notrace_func);
 		static_call_update(irqentry_exit_cond_resched, irqentry_exit_cond_resched);
diff --git a/kernel/static_call.c b/kernel/static_call.c
index 6906c6ec4c97..11aa4bcee315 100644
--- a/kernel/static_call.c
+++ b/kernel/static_call.c
@@ -489,7 +489,7 @@ int __init static_call_init(void)
 }
 early_initcall(static_call_init);
 
-long __static_call_return0(void)
+int __static_call_return0(void)
 {
 	return 0;
 }
-- 
2.29.2

