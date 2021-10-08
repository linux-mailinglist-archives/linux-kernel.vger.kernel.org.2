Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35FEB426AD0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 14:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240784AbhJHMa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 08:30:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:60754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241493AbhJHMa6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 08:30:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1013860F48;
        Fri,  8 Oct 2021 12:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633696143;
        bh=/fT89EnJsGeXhhESlz3WvMkeVLw4KkN/f3I7P9dDp9Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sQ0r4b3lc0WUZghApOlyszzr1mHp8U+/0PurlKy1yL3QsbY6qY3jJRtxGpXKn0+Hf
         fx+Lpb9sX7qbZYiczfUldC6a/MSjtPahlpt3/bcjYAOUF/PZyxy8A/ELtS1yUwinwl
         bvA1x1pfD6ziohrg71hXn11V6ACK3lE5dLM5cKIlB3eFvNfOZlY5kvCDUdwLsIOhfl
         bbHDi9lbkBljlwqjkrPhYPQuywFkBY33xZ+ovZJqHexIF2FJ3jb7yoGLjsUDGenvzf
         l3iChYypnr6osJxYpCosymh+u38WfU6EIP7VKq3Xr2rOEWnoPL8AyYgYqRPpexnQbV
         I3Ka9JJWs3Yzw==
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
Subject: [PATCH 5/8] arm64: Recover kretprobe modified return address in stacktrace
Date:   Fri,  8 Oct 2021 21:28:58 +0900
Message-Id: <163369613866.636038.15240679956943005288.stgit@devnote2>
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

Since the kretprobe replaces the function return address with
the kretprobe_trampoline on the stack, stack unwinder shows it
instead of the correct return address.

This checks whether the next return address is the
__kretprobe_trampoline(), and if so, try to find the correct
return address from the kretprobe instance list.

With this fix, now arm64 can enable
CONFIG_ARCH_CORRECT_STACKTRACE_ON_KRETPROBE, and pass the
kprobe self tests.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/arm64/Kconfig                  |    1 +
 arch/arm64/include/asm/stacktrace.h |    2 ++
 arch/arm64/kernel/stacktrace.c      |    3 +++
 3 files changed, 6 insertions(+)

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
index 8aebc00c1718..8f997a602651 100644
--- a/arch/arm64/include/asm/stacktrace.h
+++ b/arch/arm64/include/asm/stacktrace.h
@@ -9,6 +9,7 @@
 #include <linux/sched.h>
 #include <linux/sched/task_stack.h>
 #include <linux/types.h>
+#include <linux/llist.h>
 
 #include <asm/memory.h>
 #include <asm/ptrace.h>
@@ -59,6 +60,7 @@ struct stackframe {
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	int graph;
 #endif
+	struct llist_node *kr_cur;
 };
 
 extern int unwind_frame(struct task_struct *tsk, struct stackframe *frame);
diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index 8982a2b78acf..f1eef5745542 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -129,6 +129,8 @@ int notrace unwind_frame(struct task_struct *tsk, struct stackframe *frame)
 		frame->pc = ret_stack->ret;
 	}
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
+	if (is_kretprobe_trampoline(frame->pc))
+		frame->pc = kretprobe_find_ret_addr(tsk, (void *)frame->fp, &frame->kr_cur);
 
 	frame->pc = ptrauth_strip_insn_pac(frame->pc);
 
@@ -224,6 +226,7 @@ noinline notrace void arch_stack_walk(stack_trace_consume_fn consume_entry,
 {
 	struct stackframe frame;
 
+	memset(&frame, 0, sizeof(frame));
 	if (regs)
 		start_backtrace(&frame, regs->regs[29], regs->pc);
 	else if (task == current)

