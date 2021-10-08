Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AFF1426AD3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 14:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241806AbhJHMbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 08:31:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:32824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241537AbhJHMbP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 08:31:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A5AB560FC2;
        Fri,  8 Oct 2021 12:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633696160;
        bh=Qi1s9aqgTchdBwdimzOuyd5MFVP44LTQ1uLxIVsijjI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qyfPkEVtY/4eIEcXUxjc1v3+SMDXuElOdUttlOlyiSPVD6s4ObB75WabxTgdA/MR7
         jS2TJtTGTsJThusm6jVwz84PufO1AmrrXptJ36kq69mrfEfKWs13l2Hn3EvZYSACk6
         z/c41nEvZiiaus8aV/3L5Qyj6MlfK+Q31em7XMC/hHn/fZQp1QyyfATL0Ud6VKvOJg
         sYuW7fI1UrPRX2pTGEypN0f8CVrJMsdNGKOEG+jiGgvA7y/ls1tnT4nkuqWd86sX/C
         nE5MGii5toHcBSxPnxCpi84GTAgUmyGuaIhrxNNt4xVbqSC93xbVu59JHaiseaaiRh
         igfVvVYR3cc5Q==
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
Subject: [PATCH 7/8] ARM: kprobes: Make a frame pointer on __kretprobe_trampoline
Date:   Fri,  8 Oct 2021 21:29:17 +0900
Message-Id: <163369615714.636038.1154348556499203165.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <163369609308.636038.15295764725220907794.stgit@devnote2>
References: <163369609308.636038.15295764725220907794.stgit@devnote2>
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
---
 arch/arm/probes/kprobes/core.c |   29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/arch/arm/probes/kprobes/core.c b/arch/arm/probes/kprobes/core.c
index 95f23b47ba27..7cbd65a22769 100644
--- a/arch/arm/probes/kprobes/core.c
+++ b/arch/arm/probes/kprobes/core.c
@@ -368,16 +368,35 @@ int __kprobes kprobe_exceptions_notify(struct notifier_block *self,
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
-		"sub	sp, sp, #16		\n\t"
+		"ldr	lr, =__kretprobe_trampoline	\n\t"
+		"stmdb	sp!, {sp, lr, pc}	\n\t"
+#ifdef CONFIG_FRAME_POINTER
+	/* __kretprobe_trampoline makes a framepointer on pt_regs. */
+#ifdef CONFIG_CC_IS_CLANG
+		/* In clang case, pt_regs->ip = lr. */
+		"stmdb	sp!, {lr}		\n\t"
 		"stmdb	sp!, {r0 - r11}		\n\t"
+		/* fp points regs->r11 (fp) */
+		"add	fp, sp,	#44		\n\t"
+#else /* !CONFIG_CC_IS_CLANG */
+		/* In gcc case, pt_regs->ip = fp. */
+		"stmdb	sp!, {fp}		\n\t"
+		"stmdb	sp!, {r0 - r11}		\n\t"
+		/* fp points regs->r15 (pc) */
+		"add	fp, sp, #60		\n\t"
+#endif /* CONFIG_CC_IS_CLANG */
+#else /* !CONFIG_FRAME_POINTER */
+		"sub	sp, sp, #4		\n\t"
+		"stmdb	sp!, {r0 - r11}		\n\t"
+#endif /* CONFIG_FRAME_POINTER */
 		"mov	r0, sp			\n\t"
 		"bl	trampoline_handler	\n\t"
 		"mov	lr, r0			\n\t"

