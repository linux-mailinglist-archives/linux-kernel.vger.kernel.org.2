Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 205B5437F8B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 22:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234503AbhJVUv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 16:51:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:40568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234391AbhJVUvA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 16:51:00 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7226761371;
        Fri, 22 Oct 2021 20:48:42 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1me1Sz-000QLf-JF;
        Fri, 22 Oct 2021 16:48:41 -0400
Message-ID: <20211022204841.429538248@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 22 Oct 2021 16:48:14 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [for-next][PATCH 18/40] tracing: Reuse logic from perfs get_recursion_context()
References: <20211022204756.099054287@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Instead of having branches that adds noise to the branch prediction, use
the addition logic to set the bit for the level of interrupt context that
the state is currently in. This copies the logic from perf's
get_recursion_context() function.

Link: https://lore.kernel.org/all/20211015161702.GF174703@worktop.programming.kicks-ass.net/

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/trace_recursion.h | 11 ++++++-----
 kernel/trace/ring_buffer.c      | 12 ++++++------
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/include/linux/trace_recursion.h b/include/linux/trace_recursion.h
index a9f9c5714e65..f6da7a03bff0 100644
--- a/include/linux/trace_recursion.h
+++ b/include/linux/trace_recursion.h
@@ -137,12 +137,13 @@ enum {
 static __always_inline int trace_get_context_bit(void)
 {
 	unsigned long pc = preempt_count();
+	unsigned char bit = 0;
 
-	if (!(pc & (NMI_MASK | HARDIRQ_MASK | SOFTIRQ_OFFSET)))
-		return TRACE_CTX_NORMAL;
-	else
-		return pc & NMI_MASK ? TRACE_CTX_NMI :
-			pc & HARDIRQ_MASK ? TRACE_CTX_IRQ : TRACE_CTX_SOFTIRQ;
+	bit += !!(pc & (NMI_MASK));
+	bit += !!(pc & (NMI_MASK | HARDIRQ_MASK));
+	bit += !!(pc & (NMI_MASK | HARDIRQ_MASK | SOFTIRQ_OFFSET));
+
+	return TRACE_CTX_NORMAL - bit;
 }
 
 #ifdef CONFIG_FTRACE_RECORD_RECURSION
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index c5a3fbf19617..15d4380006e3 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -3168,13 +3168,13 @@ trace_recursive_lock(struct ring_buffer_per_cpu *cpu_buffer)
 {
 	unsigned int val = cpu_buffer->current_context;
 	unsigned long pc = preempt_count();
-	int bit;
+	int bit = 0;
 
-	if (!(pc & (NMI_MASK | HARDIRQ_MASK | SOFTIRQ_OFFSET)))
-		bit = RB_CTX_NORMAL;
-	else
-		bit = pc & NMI_MASK ? RB_CTX_NMI :
-			pc & HARDIRQ_MASK ? RB_CTX_IRQ : RB_CTX_SOFTIRQ;
+	bit += !!(pc & (NMI_MASK));
+	bit += !!(pc & (NMI_MASK | HARDIRQ_MASK));
+	bit += !!(pc & (NMI_MASK | HARDIRQ_MASK | SOFTIRQ_OFFSET));
+
+	bit = RB_CTX_NORMAL - bit;
 
 	if (unlikely(val & (1 << (bit + cpu_buffer->nest)))) {
 		/*
-- 
2.33.0
