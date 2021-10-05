Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA50F4229D1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 16:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235934AbhJEOCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 10:02:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:39802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235870AbhJEOAR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 10:00:17 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22426619E7;
        Tue,  5 Oct 2021 13:58:27 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1mXkxe-0055ef-6M; Tue, 05 Oct 2021 09:58:26 -0400
Message-ID: <20211005135826.040229966@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 05 Oct 2021 09:57:36 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Punit Agrawal <punitagrawal@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-linus][PATCH 03/27] kprobe: Simplify prepare_kprobe() by dropping redundant version
References: <20211005135733.485175654@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Punit Agrawal <punitagrawal@gmail.com>

The function prepare_kprobe() is called during kprobe registration and
is responsible for ensuring any architecture related preparation for
the kprobe is done before returning.

One of two versions of prepare_kprobe() is chosen depending on the
availability of KPROBE_ON_FTRACE in the kernel configuration.

Simplify the code by dropping the version when KPROBE_ON_FTRACE is not
selected - instead relying on kprobe_ftrace() to return false when
KPROBE_ON_FTRACE is not set.

No functional change.

Link: https://lkml.kernel.org/r/163163033696.489837.9264661820279300788.stgit@devnote2

Signed-off-by: Punit Agrawal <punitagrawal@gmail.com>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/kprobes.h |  5 +++++
 kernel/kprobes.c        | 23 +++++++++--------------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index e4f3bfe08757..0b75549b2815 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -354,6 +354,11 @@ static inline void wait_for_kprobe_optimizer(void) { }
 extern void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
 				  struct ftrace_ops *ops, struct ftrace_regs *fregs);
 extern int arch_prepare_kprobe_ftrace(struct kprobe *p);
+#else
+static inline int arch_prepare_kprobe_ftrace(struct kprobe *p)
+{
+	return -EINVAL;
+}
 #endif
 
 int arch_check_ftrace_location(struct kprobe *p);
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 26fc9904c3b1..cfa9d3c263eb 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1033,15 +1033,6 @@ static struct ftrace_ops kprobe_ipmodify_ops __read_mostly = {
 static int kprobe_ipmodify_enabled;
 static int kprobe_ftrace_enabled;
 
-/* Must ensure p->addr is really on ftrace */
-static int prepare_kprobe(struct kprobe *p)
-{
-	if (!kprobe_ftrace(p))
-		return arch_prepare_kprobe(p);
-
-	return arch_prepare_kprobe_ftrace(p);
-}
-
 /* Caller must lock kprobe_mutex */
 static int __arm_kprobe_ftrace(struct kprobe *p, struct ftrace_ops *ops,
 			       int *cnt)
@@ -1113,11 +1104,6 @@ static int disarm_kprobe_ftrace(struct kprobe *p)
 		ipmodify ? &kprobe_ipmodify_enabled : &kprobe_ftrace_enabled);
 }
 #else	/* !CONFIG_KPROBES_ON_FTRACE */
-static inline int prepare_kprobe(struct kprobe *p)
-{
-	return arch_prepare_kprobe(p);
-}
-
 static inline int arm_kprobe_ftrace(struct kprobe *p)
 {
 	return -ENODEV;
@@ -1129,6 +1115,15 @@ static inline int disarm_kprobe_ftrace(struct kprobe *p)
 }
 #endif
 
+static int prepare_kprobe(struct kprobe *p)
+{
+	/* Must ensure p->addr is really on ftrace */
+	if (kprobe_ftrace(p))
+		return arch_prepare_kprobe_ftrace(p);
+
+	return arch_prepare_kprobe(p);
+}
+
 /* Arm a kprobe with text_mutex */
 static int arm_kprobe(struct kprobe *kp)
 {
-- 
2.32.0
