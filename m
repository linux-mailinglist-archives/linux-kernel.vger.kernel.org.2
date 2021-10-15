Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1910842F172
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 14:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239241AbhJOMyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 08:54:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:53720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239258AbhJOMyF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 08:54:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A57886108E;
        Fri, 15 Oct 2021 12:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634302319;
        bh=lMfZZP/tcQBNE+YtsSJsSIaa1mi/f3aqAfbOhPMBTwU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VinROdbI2nOQEwbz1Bbr8uLxnMs6z2HkeNogB0M9aJsvxmpPXojOh/Ok3QcltLx4x
         rosRgtidldui2bVynfYGTcxW9L4QzOVkEilqPPC5v+upmHxl1/xQM7hJXhKa+mTAZv
         UBVeeaz9sAX6U4dq7C1QaqZYJ4TDOdMJPk2v/1PW8fYOtSgEpW5VoBLjLSRKfzdHXl
         LGdIWax8OFUtfaWi751ASKQ54ZlXB3oqBilFbaI/vSW/Ygi6ZFTxa4F8/8UQoh2O/4
         +telTfkMb0UeeKqxoBMikS+VqSGVz6jX5RJhmujoharUU4lXe+DLeh3MD/lF07giR+
         awEpdluZHPIZQ==
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
Subject: [PATCH 08/10] ARM: kprobes: Make a frame pointer on __kretprobe_trampoline
Date:   Fri, 15 Oct 2021 21:51:56 +0900
Message-Id: <163430231601.459050.8640625926942332950.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <163430224341.459050.2369208860773018092.stgit@devnote2>
References: <163430224341.459050.2369208860773018092.stgit@devnote2>
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

