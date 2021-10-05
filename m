Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 141844229FC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 16:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236911AbhJEODw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 10:03:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:40898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235481AbhJEOCi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 10:02:38 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 966C061A0C;
        Tue,  5 Oct 2021 13:58:29 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1mXkxg-0055lx-Lv; Tue, 05 Oct 2021 09:58:28 -0400
Message-ID: <20211005135828.513676729@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 05 Oct 2021 09:57:49 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [for-linus][PATCH 16/27] kprobes: Add kretprobe_find_ret_addr() for searching return address
References: <20211005135733.485175654@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Introduce kretprobe_find_ret_addr() and is_kretprobe_trampoline().
These APIs will be used by the ORC stack unwinder and ftrace, so that
they can check whether the given address points kretprobe trampoline
code and query the correct return address in that case.

Link: https://lkml.kernel.org/r/163163046461.489837.1044778356430293962.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Tested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/kprobes.h |  22 ++++++++
 kernel/kprobes.c        | 109 ++++++++++++++++++++++++++++++----------
 2 files changed, 105 insertions(+), 26 deletions(-)

diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index b6b2370f4a4c..6d47a9da1e0a 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -505,6 +505,28 @@ static inline bool is_kprobe_optinsn_slot(unsigned long addr)
 }
 #endif /* !CONFIG_OPTPROBES */
 
+#ifdef CONFIG_KRETPROBES
+static nokprobe_inline bool is_kretprobe_trampoline(unsigned long addr)
+{
+	return (void *)addr == kretprobe_trampoline_addr();
+}
+
+unsigned long kretprobe_find_ret_addr(struct task_struct *tsk, void *fp,
+				      struct llist_node **cur);
+#else
+static nokprobe_inline bool is_kretprobe_trampoline(unsigned long addr)
+{
+	return false;
+}
+
+static nokprobe_inline
+unsigned long kretprobe_find_ret_addr(struct task_struct *tsk, void *fp,
+				      struct llist_node **cur)
+{
+	return 0;
+}
+#endif
+
 /* Returns true if kprobes handled the fault */
 static nokprobe_inline bool kprobe_page_fault(struct pt_regs *regs,
 					      unsigned int trap)
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 6ed755111eea..833f07f33115 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1863,45 +1863,87 @@ static struct notifier_block kprobe_exceptions_nb = {
 
 #ifdef CONFIG_KRETPROBES
 
-unsigned long __kretprobe_trampoline_handler(struct pt_regs *regs,
-					     void *frame_pointer)
+/* This assumes the 'tsk' is the current task or the is not running. */
+static kprobe_opcode_t *__kretprobe_find_ret_addr(struct task_struct *tsk,
+						  struct llist_node **cur)
 {
-	kprobe_opcode_t *correct_ret_addr = NULL;
 	struct kretprobe_instance *ri = NULL;
-	struct llist_node *first, *node;
-	struct kretprobe *rp;
+	struct llist_node *node = *cur;
+
+	if (!node)
+		node = tsk->kretprobe_instances.first;
+	else
+		node = node->next;
 
-	/* Find all nodes for this frame. */
-	first = node = current->kretprobe_instances.first;
 	while (node) {
 		ri = container_of(node, struct kretprobe_instance, llist);
-
-		BUG_ON(ri->fp != frame_pointer);
-
 		if (ri->ret_addr != kretprobe_trampoline_addr()) {
-			correct_ret_addr = ri->ret_addr;
-			/*
-			 * This is the real return address. Any other
-			 * instances associated with this task are for
-			 * other calls deeper on the call stack
-			 */
-			goto found;
+			*cur = node;
+			return ri->ret_addr;
 		}
-
 		node = node->next;
 	}
-	pr_err("kretprobe: Return address not found, not execute handler. Maybe there is a bug in the kernel.\n");
-	BUG_ON(1);
+	return NULL;
+}
+NOKPROBE_SYMBOL(__kretprobe_find_ret_addr);
 
-found:
-	/* Unlink all nodes for this frame. */
-	current->kretprobe_instances.first = node->next;
-	node->next = NULL;
+/**
+ * kretprobe_find_ret_addr -- Find correct return address modified by kretprobe
+ * @tsk: Target task
+ * @fp: A frame pointer
+ * @cur: a storage of the loop cursor llist_node pointer for next call
+ *
+ * Find the correct return address modified by a kretprobe on @tsk in unsigned
+ * long type. If it finds the return address, this returns that address value,
+ * or this returns 0.
+ * The @tsk must be 'current' or a task which is not running. @fp is a hint
+ * to get the currect return address - which is compared with the
+ * kretprobe_instance::fp field. The @cur is a loop cursor for searching the
+ * kretprobe return addresses on the @tsk. The '*@cur' should be NULL at the
+ * first call, but '@cur' itself must NOT NULL.
+ */
+unsigned long kretprobe_find_ret_addr(struct task_struct *tsk, void *fp,
+				      struct llist_node **cur)
+{
+	struct kretprobe_instance *ri = NULL;
+	kprobe_opcode_t *ret;
+
+	if (WARN_ON_ONCE(!cur))
+		return 0;
+
+	do {
+		ret = __kretprobe_find_ret_addr(tsk, cur);
+		if (!ret)
+			break;
+		ri = container_of(*cur, struct kretprobe_instance, llist);
+	} while (ri->fp != fp);
 
-	/* Run them..  */
+	return (unsigned long)ret;
+}
+NOKPROBE_SYMBOL(kretprobe_find_ret_addr);
+
+unsigned long __kretprobe_trampoline_handler(struct pt_regs *regs,
+					     void *frame_pointer)
+{
+	kprobe_opcode_t *correct_ret_addr = NULL;
+	struct kretprobe_instance *ri = NULL;
+	struct llist_node *first, *node = NULL;
+	struct kretprobe *rp;
+
+	/* Find correct address and all nodes for this frame. */
+	correct_ret_addr = __kretprobe_find_ret_addr(current, &node);
+	if (!correct_ret_addr) {
+		pr_err("kretprobe: Return address not found, not execute handler. Maybe there is a bug in the kernel.\n");
+		BUG_ON(1);
+	}
+
+	/* Run the user handler of the nodes. */
+	first = current->kretprobe_instances.first;
 	while (first) {
 		ri = container_of(first, struct kretprobe_instance, llist);
-		first = first->next;
+
+		if (WARN_ON_ONCE(ri->fp != frame_pointer))
+			break;
 
 		rp = get_kretprobe(ri);
 		if (rp && rp->handler) {
@@ -1912,6 +1954,21 @@ unsigned long __kretprobe_trampoline_handler(struct pt_regs *regs,
 			rp->handler(ri, regs);
 			__this_cpu_write(current_kprobe, prev);
 		}
+		if (first == node)
+			break;
+
+		first = first->next;
+	}
+
+	/* Unlink all nodes for this frame. */
+	first = current->kretprobe_instances.first;
+	current->kretprobe_instances.first = node->next;
+	node->next = NULL;
+
+	/* Recycle free instances. */
+	while (first) {
+		ri = container_of(first, struct kretprobe_instance, llist);
+		first = first->next;
 
 		recycle_rp_inst(ri);
 	}
-- 
2.32.0
