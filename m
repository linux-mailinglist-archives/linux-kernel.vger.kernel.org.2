Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE35B437F9E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 22:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234682AbhJVUwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 16:52:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:40584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234439AbhJVUvE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 16:51:04 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7640761401;
        Fri, 22 Oct 2021 20:48:45 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1me1T2-000QUh-Js;
        Fri, 22 Oct 2021 16:48:44 -0400
Message-ID: <20211022204844.458068984@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 22 Oct 2021 16:48:30 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 34/40] x86/unwind: Compile kretprobe fixup code only if CONFIG_KRETPROBES=y
References: <20211022204756.099054287@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Compile kretprobe related stacktrace entry recovery code and
unwind_state::kr_cur field only when CONFIG_KRETPROBES=y.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 arch/x86/include/asm/unwind.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/include/asm/unwind.h b/arch/x86/include/asm/unwind.h
index fca2e783e3ce..2a1f8734416d 100644
--- a/arch/x86/include/asm/unwind.h
+++ b/arch/x86/include/asm/unwind.h
@@ -16,7 +16,9 @@ struct unwind_state {
 	unsigned long stack_mask;
 	struct task_struct *task;
 	int graph_idx;
+#ifdef CONFIG_KRETPROBES
 	struct llist_node *kr_cur;
+#endif
 	bool error;
 #if defined(CONFIG_UNWINDER_ORC)
 	bool signal, full_regs;
@@ -105,9 +107,13 @@ static inline
 unsigned long unwind_recover_kretprobe(struct unwind_state *state,
 				       unsigned long addr, unsigned long *addr_p)
 {
+#ifdef CONFIG_KRETPROBES
 	return is_kretprobe_trampoline(addr) ?
 		kretprobe_find_ret_addr(state->task, addr_p, &state->kr_cur) :
 		addr;
+#else
+	return addr;
+#endif
 }
 
 /* Recover the return address modified by kretprobe and ftrace_graph. */
-- 
2.33.0
