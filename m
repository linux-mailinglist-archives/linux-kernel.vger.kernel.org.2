Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83ED233216D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 09:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbhCII6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 03:58:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbhCII5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 03:57:45 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF192C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 00:57:44 -0800 (PST)
Message-Id: <20210309085727.310118772@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615280263;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=2D+JXaHEikGzkK69qbFmULYEtgNzaxJDq1SOjtT7UVs=;
        b=cHFLcfe4Utwp+eShCTauyI+Y/8bGANRi8MGp68rmtmlDAtPuodc40s+UChgkXb1ejqCJh2
        sM5Rmi3kFk+n2El9ZV0ybyHlyATWnuczU+sPQVDeyQUBJZAVgzmB16/xMcx/I6iuOKEQDV
        DHjMIyTd/tPFIqoh4PIsaH7FqT7OOSIIZxIbAVcdEMLSwDxROqDcHD9o8mvctq1cMCxmTh
        x2Ttt7fsc0s2ALbrWZtJbRH1cXte2+RK1PumwzDChincICC7reTG30jcUdmmx8+OFUgQwB
        oeh1aRhTkbY4gWpGZ6fi040usA75hcsUIpXIT7ZIpC2J9HYnn8aolAR2JV/eCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615280263;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=2D+JXaHEikGzkK69qbFmULYEtgNzaxJDq1SOjtT7UVs=;
        b=Ki23T4Wt4uT202LpuoPnsDh5TEyXgD8wxHnjQgihLHTPs1oIYkqjd0/npX9428GuG2wv4k
        ZUAS49xnKESFb6CA==
Date:   Tue, 09 Mar 2021 09:55:55 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [patch V3 3/6] softirq: Move various protections into inline helpers
References: <20210309085552.815026890@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To allow reuse of the bulk of softirq processing code for RT and to avoid
#ifdeffery all over the place, split protections for various code sections
out into inline helpers so the RT variant can just replace them in one go.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/softirq.c |   39 ++++++++++++++++++++++++++++++++-------
 1 file changed, 32 insertions(+), 7 deletions(-)

--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -207,6 +207,32 @@ void __local_bh_enable_ip(unsigned long
 }
 EXPORT_SYMBOL(__local_bh_enable_ip);
 
+static inline void softirq_handle_begin(void)
+{
+	__local_bh_disable_ip(_RET_IP_, SOFTIRQ_OFFSET);
+}
+
+static inline void softirq_handle_end(void)
+{
+	__local_bh_enable(SOFTIRQ_OFFSET);
+	WARN_ON_ONCE(in_interrupt());
+}
+
+static inline void ksoftirqd_run_begin(void)
+{
+	local_irq_disable();
+}
+
+static inline void ksoftirqd_run_end(void)
+{
+	local_irq_enable();
+}
+
+static inline bool should_wake_ksoftirqd(void)
+{
+	return true;
+}
+
 static inline void invoke_softirq(void)
 {
 	if (ksoftirqd_running(local_softirq_pending()))
@@ -319,7 +345,7 @@ asmlinkage __visible void __softirq_entr
 
 	pending = local_softirq_pending();
 
-	__local_bh_disable_ip(_RET_IP_, SOFTIRQ_OFFSET);
+	softirq_handle_begin();
 	in_hardirq = lockdep_softirq_start();
 	account_softirq_enter(current);
 
@@ -370,8 +396,7 @@ asmlinkage __visible void __softirq_entr
 
 	account_softirq_exit(current);
 	lockdep_softirq_end(in_hardirq);
-	__local_bh_enable(SOFTIRQ_OFFSET);
-	WARN_ON_ONCE(in_interrupt());
+	softirq_handle_end();
 	current_restore_flags(old_flags, PF_MEMALLOC);
 }
 
@@ -466,7 +491,7 @@ inline void raise_softirq_irqoff(unsigne
 	 * Otherwise we wake up ksoftirqd to make sure we
 	 * schedule the softirq soon.
 	 */
-	if (!in_interrupt())
+	if (!in_interrupt() && should_wake_ksoftirqd())
 		wakeup_softirqd();
 }
 
@@ -694,18 +719,18 @@ static int ksoftirqd_should_run(unsigned
 
 static void run_ksoftirqd(unsigned int cpu)
 {
-	local_irq_disable();
+	ksoftirqd_run_begin();
 	if (local_softirq_pending()) {
 		/*
 		 * We can safely run softirq on inline stack, as we are not deep
 		 * in the task stack here.
 		 */
 		__do_softirq();
-		local_irq_enable();
+		ksoftirqd_run_end();
 		cond_resched();
 		return;
 	}
-	local_irq_enable();
+	ksoftirqd_run_end();
 }
 
 #ifdef CONFIG_HOTPLUG_CPU

