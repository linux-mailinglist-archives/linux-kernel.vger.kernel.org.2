Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2887933216F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 09:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbhCII6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 03:58:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbhCII5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 03:57:47 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 621C0C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 00:57:47 -0800 (PST)
Message-Id: <20210309085727.527563866@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615280266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=0uc7kVfTlrt0LmTkkV2jfOmtbEBvXzRBEWuMAYFTxgU=;
        b=EkWkjJWJqTWitBSFAao4TLTp8f6gmOUU77ZUvkHx46vUgBbmhyuSnvPfx0KqFyxM3EDyUL
        Az64VwkuuvA4eH7HEHqxHqBIhha1gbOrcxabzcXHRs/mQaajxbefV5nZb8eBI5EIg7HAZ/
        ojUEOtzElEMoEaSSrGl9+hAsynh7kdYKq6Jn3VEdFv6hwLp31+VMp8nwQM02XSm0UxxAoh
        iWzbJA1s8Eap2SWwuSWXZJbsnybYxBPAwvZ8EUxeUkVaKtk16s6Cammi4a+IY6En2LCu2f
        dnbWEl9x9Ci8vp2C9nhkkPkKkWUcN31Qa7w8+AHUROj2hESXwrkG+eDBEFKBog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615280266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=0uc7kVfTlrt0LmTkkV2jfOmtbEBvXzRBEWuMAYFTxgU=;
        b=zeMGUW10UziSQnRkm0+8dC0CZDSFMoNKiQkbvpUnYdsmKAB84im3aw+6z3nITx3SE/ZMNI
        oehXbQYzV/Mj1XAg==
Date:   Tue, 09 Mar 2021 09:55:57 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [patch V3 5/6] tick/sched: Prevent false positive softirq pending
 warnings on RT
References: <20210309085552.815026890@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On RT a task which has soft interrupts disabled can block on a lock and
schedule out to idle while soft interrupts are pending. This triggers the
warning in the NOHZ idle code which complains about going idle with pending
soft interrupts. But as the task is blocked soft interrupt processing is
temporarily blocked as well which means that such a warning is a false
positive.

To prevent that check the per CPU state which indicates that a scheduled
out task has soft interrupts disabled.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/bottom_half.h |    6 ++++++
 kernel/softirq.c            |   15 +++++++++++++++
 kernel/time/tick-sched.c    |    2 +-
 3 files changed, 22 insertions(+), 1 deletion(-)

--- a/include/linux/bottom_half.h
+++ b/include/linux/bottom_half.h
@@ -32,4 +32,10 @@ static inline void local_bh_enable(void)
 	__local_bh_enable_ip(_THIS_IP_, SOFTIRQ_DISABLE_OFFSET);
 }
 
+#ifdef CONFIG_PREEMPT_RT
+extern bool local_bh_blocked(void);
+#else
+static inline bool local_bh_blocked(void) { return false; }
+#endif
+
 #endif /* _LINUX_BH_H */
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -141,6 +141,21 @@ static DEFINE_PER_CPU(struct softirq_ctr
 	.lock	= INIT_LOCAL_LOCK(softirq_ctrl.lock),
 };
 
+/**
+ * local_bh_blocked() - Check for idle whether BH processing is blocked
+ *
+ * Returns false if the per CPU softirq::cnt is 0 otherwise true.
+ *
+ * This is invoked from the idle task to guard against false positive
+ * softirq pending warnings, which would happen when the task which holds
+ * softirq_ctrl::lock was the only running task on the CPU and blocks on
+ * some other lock.
+ */
+bool local_bh_blocked(void)
+{
+	return __this_cpu_read(softirq_ctrl.cnt) != 0;
+}
+
 void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
 {
 	unsigned long flags;
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -973,7 +973,7 @@ static bool can_stop_idle_tick(int cpu,
 	if (unlikely(local_softirq_pending())) {
 		static int ratelimit;
 
-		if (ratelimit < 10 &&
+		if (ratelimit < 10 && !local_bh_blocked() &&
 		    (local_softirq_pending() & SOFTIRQ_STOP_IDLE_MASK)) {
 			pr_warn("NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #%02x!!!\n",
 				(unsigned int) local_softirq_pending());

