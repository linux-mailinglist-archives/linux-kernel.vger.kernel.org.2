Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A88E3ABC49
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 21:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233042AbhFQTGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 15:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232837AbhFQTGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 15:06:06 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC43C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 12:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=dGLBRg3y6VoMMdqi5Foa3iTVY3ceuFT00AZcytCGht0=; b=lYnNIUcs6V2OqHCJznFu+ssFrp
        PrAfJWWnLnu9bXV6eQYt7Su9xvWsggRuYhqVbWkCRl5Ki/c30wR1qtPvUBOCi3l5bzMTP2DE36pK7
        Ky6TdJviQETRja1NKgrPh+/SCjb8Bq+fC0FzcMzXiMvop1+TPz42Ap52+qbqwDsFgEEsbXIjZB4xa
        HJwngTBN3HZqHbPpxBUmn9MunUt0tqjDs1gfkCXmYIKGSLFmiAFYqw5t13uXSAROFvkR0UAYpY+db
        /LUBz9AeBV6ebwR5LRVm2WvtL+G8ZjGQvrGToQA1J9Nx4n51gW16BrCtGbLvOueI6IdRYBk+Mw3fE
        ti6athCw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ltxIa-008uZZ-78; Thu, 17 Jun 2021 19:03:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 78F75300350;
        Thu, 17 Jun 2021 21:03:37 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 5D7D0202434C5; Thu, 17 Jun 2021 21:03:37 +0200 (CEST)
Message-ID: <20210617190313.384290291@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 17 Jun 2021 20:57:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@redhat.com, will@kernel.org, longman@redhat.com,
        boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        joro@8bytes.org, bp@alien8.de, tglx@linutronix.de,
        bigeasy@linutronix.de
Subject: [PATCH 3/3] lockdep/selftest: Remove wait-type RCU_CALLBACK tests
References: <20210617185717.486456641@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The problem is that rcu_callback_map doesn't have wait_types defined,
and doing so would make it indistinguishable from SOFTIRQ in any case.
Remove it.

Fixes: 9271a40d2a14 ("lockdep/selftest: Add wait context selftests")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 lib/locking-selftest.c |   17 -----------------
 1 file changed, 17 deletions(-)

--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -2492,16 +2492,6 @@ static void rcu_sched_exit(int *_)
 	int rcu_sched_guard_##name __guard(rcu_sched_exit);	\
 	rcu_read_lock_sched();
 
-static void rcu_callback_exit(int *_)
-{
-	rcu_lock_release(&rcu_callback_map);
-}
-
-#define RCU_CALLBACK_CONTEXT(name, ...)					\
-	int rcu_callback_guard_##name __guard(rcu_callback_exit);	\
-	rcu_lock_acquire(&rcu_callback_map);
-
-
 static void raw_spinlock_exit(raw_spinlock_t **lock)
 {
 	raw_spin_unlock(*lock);
@@ -2558,8 +2548,6 @@ static void __maybe_unused inner##_in_##
  * ---------------+-------+----------+------+-------
  * RCU_BH         |   o   |    o     |  o   |  x
  * ---------------+-------+----------+------+-------
- * RCU_CALLBACK   |   o   |    o     |  o   |  x
- * ---------------+-------+----------+------+-------
  * RCU_SCHED      |   o   |    o     |  x   |  x
  * ---------------+-------+----------+------+-------
  * RAW_SPIN       |   o   |    o     |  x   |  x
@@ -2576,7 +2564,6 @@ GENERATE_2_CONTEXT_TESTCASE(NOTTHREADED_
 GENERATE_2_CONTEXT_TESTCASE(SOFTIRQ, , inner, inner_lock)			\
 GENERATE_2_CONTEXT_TESTCASE(RCU, , inner, inner_lock)				\
 GENERATE_2_CONTEXT_TESTCASE(RCU_BH, , inner, inner_lock)			\
-GENERATE_2_CONTEXT_TESTCASE(RCU_CALLBACK, , inner, inner_lock)			\
 GENERATE_2_CONTEXT_TESTCASE(RCU_SCHED, , inner, inner_lock)			\
 GENERATE_2_CONTEXT_TESTCASE(RAW_SPINLOCK, raw_lock_A, inner, inner_lock)	\
 GENERATE_2_CONTEXT_TESTCASE(SPINLOCK, lock_A, inner, inner_lock)		\
@@ -2638,10 +2625,6 @@ static void wait_context_tests(void)
 	DO_CONTEXT_TESTCASE_OUTER_LIMITED_PREEMPTIBLE(RCU_BH);
 	pr_cont("\n");
 
-	print_testname("in RCU callback context");
-	DO_CONTEXT_TESTCASE_OUTER_LIMITED_PREEMPTIBLE(RCU_CALLBACK);
-	pr_cont("\n");
-
 	print_testname("in RCU-sched context");
 	DO_CONTEXT_TESTCASE_OUTER_NOT_PREEMPTIBLE(RCU_SCHED);
 	pr_cont("\n");


