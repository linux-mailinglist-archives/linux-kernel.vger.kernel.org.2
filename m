Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A35530DF3A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 17:09:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234848AbhBCQJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 11:09:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:36046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234922AbhBCQHa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 11:07:30 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09FB564F93;
        Wed,  3 Feb 2021 16:05:51 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1l7Kf7-009J91-UX; Wed, 03 Feb 2021 11:05:49 -0500
Message-ID: <20210203160549.825691017@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 03 Feb 2021 11:05:25 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [for-next][PATCH 08/15] tracing: Use in_serving_softirq() to deduct softirq status.
References: <20210203160517.982448432@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

PREEMPT_RT does not report "serving softirq" because the tracing core
looks at the preemption counter while PREEMPT_RT does not update it
while processing softirqs in order to remain preemptible. The
information is stored somewhere else.
The in_serving_softirq() macro and the SOFTIRQ_OFFSET define are still
working but not on the preempt-counter.

Use in_serving_softirq() macro which works on PREEMPT_RT. On !PREEMPT_RT
the compiler (gcc-10 / clang-11) is smart enough to optimize the
in_serving_softirq() related read of the preemption counter away.
The only difference I noticed by using in_serving_softirq() on
!PREEMPT_RT is that gcc-10 implemented tracing_gen_ctx_flags() as
reading FLAG, jmp _tracing_gen_ctx_flags(). Without in_serving_softirq()
it inlined _tracing_gen_ctx_flags() into tracing_gen_ctx_flags().

Link: https://lkml.kernel.org/r/20210125194511.3924915-4-bigeasy@linutronix.de

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 584fa2a1304a..75620c29e904 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2590,8 +2590,7 @@ unsigned int tracing_gen_ctx_irq_test(unsigned int irqs_status)
 		trace_flags |= TRACE_FLAG_NMI;
 	if (pc & HARDIRQ_MASK)
 		trace_flags |= TRACE_FLAG_HARDIRQ;
-
-	if (pc & SOFTIRQ_OFFSET)
+	if (in_serving_softirq())
 		trace_flags |= TRACE_FLAG_SOFTIRQ;
 
 	if (tif_need_resched())
-- 
2.29.2


