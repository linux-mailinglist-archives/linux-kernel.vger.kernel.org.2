Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2A334229DE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 16:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236259AbhJEODC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 10:03:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:40900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236006AbhJEOB7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 10:01:59 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F1D361872;
        Tue,  5 Oct 2021 13:58:28 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1mXkxf-0055j9-NB; Tue, 05 Oct 2021 09:58:27 -0400
Message-ID: <20211005135827.552262330@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 05 Oct 2021 09:57:44 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-linus][PATCH 11/27] kprobes: Use bool type for functions which returns boolean value
References: <20211005135733.485175654@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Use the 'bool' type instead of 'int' for the functions which
returns a boolean value, because this makes clear that those
functions don't return any error code.

Link: https://lkml.kernel.org/r/163163041649.489837.17311187321419747536.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/kprobes.h     |  8 ++++----
 kernel/kprobes.c            | 26 +++++++++++++-------------
 kernel/trace/trace_kprobe.c |  2 +-
 3 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 6a5995f334a0..0ba3f9e316d4 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -104,25 +104,25 @@ struct kprobe {
 #define KPROBE_FLAG_FTRACE	8 /* probe is using ftrace */
 
 /* Has this kprobe gone ? */
-static inline int kprobe_gone(struct kprobe *p)
+static inline bool kprobe_gone(struct kprobe *p)
 {
 	return p->flags & KPROBE_FLAG_GONE;
 }
 
 /* Is this kprobe disabled ? */
-static inline int kprobe_disabled(struct kprobe *p)
+static inline bool kprobe_disabled(struct kprobe *p)
 {
 	return p->flags & (KPROBE_FLAG_DISABLED | KPROBE_FLAG_GONE);
 }
 
 /* Is this kprobe really running optimized path ? */
-static inline int kprobe_optimized(struct kprobe *p)
+static inline bool kprobe_optimized(struct kprobe *p)
 {
 	return p->flags & KPROBE_FLAG_OPTIMIZED;
 }
 
 /* Is this kprobe uses ftrace ? */
-static inline int kprobe_ftrace(struct kprobe *p)
+static inline bool kprobe_ftrace(struct kprobe *p)
 {
 	return p->flags & KPROBE_FLAG_FTRACE;
 }
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index b6f1dcf4bff3..8021bccb7770 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -198,8 +198,8 @@ kprobe_opcode_t *__get_insn_slot(struct kprobe_insn_cache *c)
 	return slot;
 }
 
-/* Return 1 if all garbages are collected, otherwise 0. */
-static int collect_one_slot(struct kprobe_insn_page *kip, int idx)
+/* Return true if all garbages are collected, otherwise false. */
+static bool collect_one_slot(struct kprobe_insn_page *kip, int idx)
 {
 	kip->slot_used[idx] = SLOT_CLEAN;
 	kip->nused--;
@@ -223,9 +223,9 @@ static int collect_one_slot(struct kprobe_insn_page *kip, int idx)
 			kip->cache->free(kip->insns);
 			kfree(kip);
 		}
-		return 1;
+		return true;
 	}
-	return 0;
+	return false;
 }
 
 static int collect_garbage_slots(struct kprobe_insn_cache *c)
@@ -389,13 +389,13 @@ NOKPROBE_SYMBOL(get_kprobe);
 static int aggr_pre_handler(struct kprobe *p, struct pt_regs *regs);
 
 /* Return true if 'p' is an aggregator */
-static inline int kprobe_aggrprobe(struct kprobe *p)
+static inline bool kprobe_aggrprobe(struct kprobe *p)
 {
 	return p->pre_handler == aggr_pre_handler;
 }
 
 /* Return true if 'p' is unused */
-static inline int kprobe_unused(struct kprobe *p)
+static inline bool kprobe_unused(struct kprobe *p)
 {
 	return kprobe_aggrprobe(p) && kprobe_disabled(p) &&
 	       list_empty(&p->list);
@@ -455,7 +455,7 @@ static inline int kprobe_optready(struct kprobe *p)
 }
 
 /* Return true if the kprobe is disarmed. Note: p must be on hash list */
-static inline int kprobe_disarmed(struct kprobe *p)
+static inline bool kprobe_disarmed(struct kprobe *p)
 {
 	struct optimized_kprobe *op;
 
@@ -469,16 +469,16 @@ static inline int kprobe_disarmed(struct kprobe *p)
 }
 
 /* Return true if the probe is queued on (un)optimizing lists */
-static int kprobe_queued(struct kprobe *p)
+static bool kprobe_queued(struct kprobe *p)
 {
 	struct optimized_kprobe *op;
 
 	if (kprobe_aggrprobe(p)) {
 		op = container_of(p, struct optimized_kprobe, kp);
 		if (!list_empty(&op->list))
-			return 1;
+			return true;
 	}
-	return 0;
+	return false;
 }
 
 /*
@@ -1678,7 +1678,7 @@ int register_kprobe(struct kprobe *p)
 EXPORT_SYMBOL_GPL(register_kprobe);
 
 /* Check if all probes on the 'ap' are disabled. */
-static int aggr_kprobe_disabled(struct kprobe *ap)
+static bool aggr_kprobe_disabled(struct kprobe *ap)
 {
 	struct kprobe *kp;
 
@@ -1690,9 +1690,9 @@ static int aggr_kprobe_disabled(struct kprobe *ap)
 			 * Since there is an active probe on the list,
 			 * we can't disable this 'ap'.
 			 */
-			return 0;
+			return false;
 
-	return 1;
+	return true;
 }
 
 static struct kprobe *__disable_kprobe(struct kprobe *p)
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 3a64ba4bbad6..0e1e7ce5f7ed 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -97,7 +97,7 @@ static nokprobe_inline unsigned long trace_kprobe_offset(struct trace_kprobe *tk
 
 static nokprobe_inline bool trace_kprobe_has_gone(struct trace_kprobe *tk)
 {
-	return !!(kprobe_gone(&tk->rp.kp));
+	return kprobe_gone(&tk->rp.kp);
 }
 
 static nokprobe_inline bool trace_kprobe_within_module(struct trace_kprobe *tk,
-- 
2.32.0
