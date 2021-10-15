Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE7F42F170
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 14:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239210AbhJOMyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 08:54:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:53346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239308AbhJOMxr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 08:53:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C86E760ED4;
        Fri, 15 Oct 2021 12:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634302300;
        bh=nvZy1sVKYSK6zZvA82X0Qwm/erFQUaJsuPthlqjB5TY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XZm6dGWKFv/Q7OSnILPwjpJd1t8TNa2SBlAAQC4U0nri4Rcl2AZXSDhMVT/gSEK/w
         PoNq5LJCXkRttBGHN05+7Sy+hlfCHER5eou9y0L4yepzQXQqs1VB6sUvsMXVO7I5CU
         /TfKZTkBrz0xULe1iu8a4qwTTq+v7wlgpl6I41dW/uGDOrD9rzanrgnscUSgjyobTB
         JmIsrvOZ4xPpNDmTu59f2JIiE4WDmUNr3jZRLHv5S7FNifMwieQe4XyDaBd8pZjI3i
         TTcOawJlIBZbvrBdsQVFG4KrzMFblMpnOag/bycZxPDFuZ2jsXTVWbQOUN8kltKbGk
         mFX9Jcks6K/Bg==
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
Subject: [PATCH 06/10] arm64: Recover kretprobe modified return address in stacktrace
Date:   Fri, 15 Oct 2021 21:51:37 +0900
Message-Id: <163430229733.459050.8624118341048476904.stgit@devnote2>
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

Since the kretprobe replaces the function return address with
the kretprobe_trampoline on the stack, stack unwinder shows it
instead of the correct return address.

This checks whether the next return address is the
__kretprobe_trampoline(), and if so, try to find the correct
return address from the kretprobe instance list. For this purpose
this adds 'kr_cur' loop cursor to memorize the current kretprobe
instance.

With this fix, now arm64 can enable
CONFIG_ARCH_CORRECT_STACKTRACE_ON_KRETPROBE, and pass the
kprobe self tests.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Changes in v2:
  - Add comment for kr_cur.
  - Make the kretprobe related code depends on CONFIG_KRETPROBES.
  - Initialize "kr_cur" directly in start_backtrace() instead
    of clearing "frame" data structure by memset().
---
 arch/arm64/Kconfig                  |    1 +
 arch/arm64/include/asm/stacktrace.h |    4 ++++
 arch/arm64/kernel/stacktrace.c      |    7 +++++++
 3 files changed, 12 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 5c7ae4c3954b..edde5171ffb2 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -11,6 +11,7 @@ config ARM64
 	select ACPI_PPTT if ACPI
 	select ARCH_HAS_DEBUG_WX
 	select ARCH_BINFMT_ELF_STATE
+	select ARCH_CORRECT_STACKTRACE_ON_KRETPROBE
 	select ARCH_ENABLE_HUGEPAGE_MIGRATION if HUGETLB_PAGE && MIGRATION
 	select ARCH_ENABLE_MEMORY_HOTPLUG
 	select ARCH_ENABLE_MEMORY_HOTREMOVE
diff --git a/arch/arm64/include/asm/stacktrace.h b/arch/arm64/include/asm/stacktrace.h
index 8aebc00c1718..a4e046ef4568 100644
--- a/arch/arm64/include/asm/stacktrace.h
+++ b/arch/arm64/include/asm/stacktrace.h
@@ -9,6 +9,7 @@
 #include <linux/sched.h>
 #include <linux/sched/task_stack.h>
 #include <linux/types.h>
+#include <linux/llist.h>
 
 #include <asm/memory.h>
 #include <asm/ptrace.h>
@@ -59,6 +60,9 @@ struct stackframe {
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	int graph;
 #endif
+#ifdef CONFIG_KRETPROBES
+	struct llist_node *kr_cur;
+#endif
 };
 
 extern int unwind_frame(struct task_struct *tsk, struct stackframe *frame);
diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index 8982a2b78acf..c30624fff6ac 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -41,6 +41,9 @@ void start_backtrace(struct stackframe *frame, unsigned long fp,
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	frame->graph = 0;
 #endif
+#ifdef CONFIG_KRETPROBES
+	frame->kr_cur = NULL;
+#endif
 
 	/*
 	 * Prime the first unwind.
@@ -129,6 +132,10 @@ int notrace unwind_frame(struct task_struct *tsk, struct stackframe *frame)
 		frame->pc = ret_stack->ret;
 	}
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
+#ifdef CONFIG_KRETPROBES
+	if (is_kretprobe_trampoline(frame->pc))
+		frame->pc = kretprobe_find_ret_addr(tsk, (void *)frame->fp, &frame->kr_cur);
+#endif
 
 	frame->pc = ptrauth_strip_insn_pac(frame->pc);
 

