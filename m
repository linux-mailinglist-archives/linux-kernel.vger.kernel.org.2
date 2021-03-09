Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8FFF33216B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 09:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbhCII6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 03:58:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbhCII5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 03:57:42 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADEF4C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 00:57:42 -0800 (PST)
Message-Id: <20210309085726.983627589@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615280261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=crrIwHdUp5M7Eps2xi3CS3/8bja3Lpo5VaPQvRN81LI=;
        b=vRtxCuwI2AHFET5cqravUfD55jv8rjjGlJli3mOOBsYxtDTjPUBAkE6Mw+LA8rd6DGWzS/
        uOVIx97xtjQrsjXxE60l7RVdJXL7UZexxJ2eAlHQowSExCeDUYIc5PhID40toshRMeK3iL
        DQkD0SmnpmibJLBRFLLSup2mnmA0CI76OiQPGgkgxt5QBSVOPn5SNq2QvKufPXzGxTKxUK
        Ahfy0GNT+z0SQkh7LMlRaJrutGGl9ofQE9T/qCGqsfTMgqU0L1+CqypJEw3zMCsO1l4Kd8
        xD7R4wGUx7cMpKLACpBVue7LnStmHxE5yS9o1jDUYZW4gwWJuO/Z4WK2akmdAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615280261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=crrIwHdUp5M7Eps2xi3CS3/8bja3Lpo5VaPQvRN81LI=;
        b=5qBmIMCPYFhNqbfnMa8NUvTLGY8TYUOW0gPOFRB1KDARuwivcXqQEyjeRGGMWLmr6xZDdf
        e4H+hfm50xMDkfCA==
Date:   Tue, 09 Mar 2021 09:55:53 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [patch V3 1/6] softirq: Add RT specific softirq accounting
References: <20210309085552.815026890@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RT requires the softirq processing and local bottomhalf disabled regions to
be preemptible. Using the normal preempt count based serialization is
therefore not possible because this implicitely disables preemption.

RT kernels use a per CPU local lock to serialize bottomhalfs. As
local_bh_disable() can nest the lock can only be acquired on the outermost
invocation of local_bh_disable() and released when the nest count becomes
zero. Tasks which hold the local lock can be preempted so its required to
keep track of the nest count per task.

Add a RT only counter to task struct and adjust the relevant macros in
preempt.h.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/hardirq.h |    1 +
 include/linux/preempt.h |    6 +++++-
 include/linux/sched.h   |    3 +++
 3 files changed, 9 insertions(+), 1 deletion(-)

--- a/include/linux/hardirq.h
+++ b/include/linux/hardirq.h
@@ -6,6 +6,7 @@
 #include <linux/preempt.h>
 #include <linux/lockdep.h>
 #include <linux/ftrace_irq.h>
+#include <linux/sched.h>
 #include <linux/vtime.h>
 #include <asm/hardirq.h>
 
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -79,7 +79,11 @@
 
 #define nmi_count()	(preempt_count() & NMI_MASK)
 #define hardirq_count()	(preempt_count() & HARDIRQ_MASK)
-#define softirq_count()	(preempt_count() & SOFTIRQ_MASK)
+#ifdef CONFIG_PREEMPT_RT
+# define softirq_count()	(current->softirq_disable_cnt & SOFTIRQ_MASK)
+#else
+# define softirq_count()	(preempt_count() & SOFTIRQ_MASK)
+#endif
 #define irq_count()	(nmi_count() | hardirq_count() | softirq_count())
 
 /*
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1044,6 +1044,9 @@ struct task_struct {
 	int				softirq_context;
 	int				irq_config;
 #endif
+#ifdef CONFIG_PREEMPT_RT
+	int				softirq_disable_cnt;
+#endif
 
 #ifdef CONFIG_LOCKDEP
 # define MAX_LOCK_DEPTH			48UL

