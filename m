Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2540141AEEB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 14:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240648AbhI1M0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 08:26:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35324 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240619AbhI1M0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 08:26:07 -0400
Message-ID: <20210928122411.482262764@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632831867;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=FiFcyuXwlg1sRelhiMfm8h3K/UTEYE2yHv+oeYRHe/o=;
        b=RcAnGRH7CCWnE8t5j1+ckNawEtbtxOnm5vJBgDXcIQESkMPclqtjC7ygr07/BAZVb1JoRl
        JY5xpORCEdk4JI1HZMAUQCG5UAWowZMybi7JsKpxanh7/FpKz8xQcuzbhpsuQhucrOq1mM
        J9wNaKnxJ3JPnG8iToecZzCHDMpTJJdxVEuASiA8vPLO9cZlIg+jNyWTkEJLZZpRTR1o9K
        49ZWHuy2NY0yBwRoUQZ/OQKEXhwWLvlyuczDjqEi7stvODIDJMwX4m5Z0bi9b8u6jB4WSN
        xR0tMLq3iQYAcOFRi3fJMBXb4SCEja8oiTxCL4T+1mseXxAWpj2hdXd8WpuOTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632831867;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=FiFcyuXwlg1sRelhiMfm8h3K/UTEYE2yHv+oeYRHe/o=;
        b=bbOC5zxYzWRXGdAXZ4GxLiiT+gxT7uwiAIAr8NLCJ7/c9fpoKysanELbqvxFhAKkX+qSRx
        c/GYkUL1sIFWgPAw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [patch 2/5] sched: Disable TTWU_QUEUE on RT
References: <20210928122339.502270600@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 28 Sep 2021 14:24:27 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The queued remote wakeup mechanism has turned out to be suboptimal for RT
enabled kernels. The maximum latencies go up by a factor of > 5x in certain
scenarious.

This is caused by either long wake lists or by a large number of TTWU IPIs
which are processed back to back.

Disable it for RT.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/sched/features.h |    5 +++++
 1 file changed, 5 insertions(+)
---
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -46,11 +46,16 @@ SCHED_FEAT(DOUBLE_TICK, false)
  */
 SCHED_FEAT(NONTASK_CAPACITY, true)
 
+#ifdef CONFIG_PREEMPT_RT
+SCHED_FEAT(TTWU_QUEUE, false)
+#else
+
 /*
  * Queue remote wakeups on the target CPU and process them
  * using the scheduler IPI. Reduces rq->lock contention/bounces.
  */
 SCHED_FEAT(TTWU_QUEUE, true)
+#endif
 
 /*
  * When doing wakeups, attempt to limit superfluous scans of the LLC domain.

