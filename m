Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB8D4357FF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 02:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbhJUA5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 20:57:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:51818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231535AbhJUA5o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 20:57:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0F2FE6109F;
        Thu, 21 Oct 2021 00:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634777729;
        bh=f5jHlGWDUu2jM115NlKoD+47Oicte69WNpox78oxano=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gMqVTtS+DHshaegDYSPtuTW0B/DYyDMqHqpiTtq1BX/fgixCPBpFvHu1X/hkJEXxH
         vjXZfYNrL8FSbhpQ69pinyQLpTF2aG+ZVci8sYmVevJu8ZqjFWYGWS4cCqrZe+e70i
         vFhUciZhRLXK3Ne/owOTyA4/DJZv2YfQl6l+4eQgLbl1ePAwLWSfo+N9kANWi1X+DA
         K0fnGemHHWfIw4Hb7wdqeMMtN3dg41odF3HRkgJ9MfzMMC2JmUOm+hI9UScGflrFKf
         SbLNrmslf7ENXVP2NnTJU/y5FPbz/prd9u+nHQp2VnPFqBvmlSPBDy4fGbqNOKSFnE
         JnobIDBNLt9Fw==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ananth N Mavinakayanahalli <ananth@linux.ibm.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        mhiramat@kernel.org, Sven Schnelle <svens@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 8/9] ARM: kprobes: Make a frame pointer on __kretprobe_trampoline
Date:   Thu, 21 Oct 2021 09:55:26 +0900
Message-Id: <163477772593.264901.7405996794526239017.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <163477765570.264901.3851692300287671122.stgit@devnote2>
References: <163477765570.264901.3851692300287671122.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 Changes in v3:
  - Avoid using !sp when storing sp itself.
  - Unify stmdb register list.
  - Keep the current assembly code when CONFIG_FRAME_POINTER=n.
---
 arch/arm/probes/kprobes/core.c |   28 ++++++++++++++++++++++++----
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

