Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8B7C437F9F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 22:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234681AbhJVUwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 16:52:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:41098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234445AbhJVUvE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 16:51:04 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6245C613D5;
        Fri, 22 Oct 2021 20:48:46 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1me1T3-000QXW-HC;
        Fri, 22 Oct 2021 16:48:45 -0400
Message-ID: <20211022204845.369618142@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 22 Oct 2021 16:48:35 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [for-next][PATCH 39/40] ARM: kprobes: Make a frame pointer on __kretprobe_trampoline
References: <20211022204756.099054287@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Currently kretprobe on ARM just fills r0-r11 of pt_regs, but
that is not enough for the stacktrace. Moreover, from the user
kretprobe handler, stacktrace needs a frame pointer on the
__kretprobe_trampoline.

This adds a frame pointer on __kretprobe_trampoline for both gcc
and clang case. Those have different frame pointer so we need
different but similar stack on pt_regs.

Gcc makes the frame pointer (fp) to point the 'pc' address of
the {fp, ip (=sp), lr, pc}, this means {r11, r13, r14, r15}.
Thus if we save the r11 (fp) on pt_regs->r12, we can make this
set on the end of pt_regs.

On the other hand, Clang makes the frame pointer to point the
'fp' address of {fp, lr} on stack. Since the next to the
pt_regs->lr is pt_regs->sp, I reused the pair of pt_regs->fp
and pt_regs->ip.
So this stores the 'lr' on pt_regs->ip and make the fp to point
pt_regs->fp.

For both cases, saves __kretprobe_trampoline address to
pt_regs->lr, so that the stack tracer can identify this frame
pointer has been made by the __kretprobe_trampoline.

Note that if the CONFIG_FRAME_POINTER is not set, this keeps
fp as is.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 arch/arm/probes/kprobes/core.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/arch/arm/probes/kprobes/core.c b/arch/arm/probes/kprobes/core.c
index 95f23b47ba27..4848404ba51b 100644
--- a/arch/arm/probes/kprobes/core.c
+++ b/arch/arm/probes/kprobes/core.c
@@ -368,16 +368,36 @@ int __kprobes kprobe_exceptions_notify(struct notifier_block *self,
 /*
  * When a retprobed function returns, trampoline_handler() is called,
  * calling the kretprobe's handler. We construct a struct pt_regs to
- * give a view of registers r0-r11 to the user return-handler.  This is
- * not a complete pt_regs structure, but that should be plenty sufficient
- * for kretprobe handlers which should normally be interested in r0 only
- * anyway.
+ * give a view of registers r0-r11, sp, lr, and pc to the user
+ * return-handler. This is not a complete pt_regs structure, but that
+ * should be enough for stacktrace from the return handler with or
+ * without pt_regs.
  */
 void __naked __kprobes __kretprobe_trampoline(void)
 {
 	__asm__ __volatile__ (
+#ifdef CONFIG_FRAME_POINTER
+		"ldr	lr, =__kretprobe_trampoline	\n\t"
+	/* __kretprobe_trampoline makes a framepointer on pt_regs. */
+#ifdef CONFIG_CC_IS_CLANG
+		"stmdb	sp, {sp, lr, pc}	\n\t"
+		"sub	sp, sp, #12		\n\t"
+		/* In clang case, pt_regs->ip = lr. */
+		"stmdb	sp!, {r0 - r11, lr}	\n\t"
+		/* fp points regs->r11 (fp) */
+		"add	fp, sp,	#44		\n\t"
+#else /* !CONFIG_CC_IS_CLANG */
+		/* In gcc case, pt_regs->ip = fp. */
+		"stmdb	sp, {fp, sp, lr, pc}	\n\t"
 		"sub	sp, sp, #16		\n\t"
 		"stmdb	sp!, {r0 - r11}		\n\t"
+		/* fp points regs->r15 (pc) */
+		"add	fp, sp, #60		\n\t"
+#endif /* CONFIG_CC_IS_CLANG */
+#else /* !CONFIG_FRAME_POINTER */
+		"sub	sp, sp, #16		\n\t"
+		"stmdb	sp!, {r0 - r11}		\n\t"
+#endif /* CONFIG_FRAME_POINTER */
 		"mov	r0, sp			\n\t"
 		"bl	trampoline_handler	\n\t"
 		"mov	lr, r0			\n\t"
-- 
2.33.0
