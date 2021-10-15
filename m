Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E29342F176
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 14:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239228AbhJOMyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 08:54:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:54116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239201AbhJOMyY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 08:54:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 50A1160ED4;
        Fri, 15 Oct 2021 12:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634302337;
        bh=EyoCpAJO1kfofsL3gEQly+uRiLZYa9weOYK4M4P9yI0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eAwTenk213ykTtTC152Z1rE9becZKfqIURox5GSsXUTQhD8h83iNO+T5nThet9reh
         QRLUogxGqTC9Dr3s0HsmsidnW9eAQkF4PP6iFymRVXDNj6vreQ87Y5UFuRE5Dbwr47
         yP7HJbxtwDjv/Nvxsz05dDwUP+iBHKdbxyfYpcwkO7vgqYI+iLWYPm9umo8u/jSv9t
         zytO/2EcwDoKtZLtBiSuP4B03ByfGsoOrpWH0vlm9rwKr6jU4oppKH8Hwkm1EmaWYm
         uGpWLDTyK3sotdAP9mQ2HyunkIeKdOZ/Am6238FRT7OmRS4O/9Xo49TRmCAXAiDoCC
         ZCxjqLHWdxd+Q==
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
Subject: [PATCH 10/10] [RFC] arm64: kprobes: Detect error of kretprobe return address fixup
Date:   Fri, 15 Oct 2021 21:52:14 +0900
Message-Id: <163430233451.459050.14342207133770952671.stgit@devnote2>
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

Add kretprobe_next_ret_addr() which can detect errors in
the given parameter or the kretprobe_instance list, and call
it from arm64 stacktrace.

This kretprobe_next_ret_addr() will return following errors
when it detects;

 - -EINVAL if @cur is NULL (caller issue)
 - -ENOENT if there is no next correct return address
   (either kprobes or caller issue)
 - -EILSEQ if the next currect return address is there
   but doesn't match the framepointer (maybe caller issue)

Thus the caller must check the error and handle it. On arm64,
this tries to handle the errors and show it on the log.

Suggested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/arm64/kernel/stacktrace.c |   10 +++++++-
 include/linux/kprobes.h        |    2 ++
 kernel/kprobes.c               |   49 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 59 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index c30624fff6ac..e2f9f479da99 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -133,8 +133,14 @@ int notrace unwind_frame(struct task_struct *tsk, struct stackframe *frame)
 	}
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
 #ifdef CONFIG_KRETPROBES
-	if (is_kretprobe_trampoline(frame->pc))
-		frame->pc = kretprobe_find_ret_addr(tsk, (void *)frame->fp, &frame->kr_cur);
+	if (is_kretprobe_trampoline(frame->pc)) {
+		void *ret = kretprobe_next_ret_addr(tsk, (void *)frame->fp, &frame->kr_cur);
+		/* There must be a bug in this unwinder or kretprobe. */
+		if (WARN_ON_ONCE(IS_ERR(ret)))
+			pr_err("Kretprobe_trampoline recovery failed (%d)\n", PTR_ERR(ret));
+		else
+			frame->pc = (unsigned long)ret;
+	}
 #endif
 
 	frame->pc = ptrauth_strip_insn_pac(frame->pc);
diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index e974caf39d3e..8133455c3522 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -516,6 +516,8 @@ static nokprobe_inline bool is_kretprobe_trampoline(unsigned long addr)
 
 unsigned long kretprobe_find_ret_addr(struct task_struct *tsk, void *fp,
 				      struct llist_node **cur);
+kprobe_opcode_t *kretprobe_next_ret_addr(struct task_struct *tsk, void *fp,
+					 struct llist_node **cur);
 #else
 static nokprobe_inline bool is_kretprobe_trampoline(unsigned long addr)
 {
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 4676627cb066..c57168753467 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1922,6 +1922,55 @@ unsigned long kretprobe_find_ret_addr(struct task_struct *tsk, void *fp,
 }
 NOKPROBE_SYMBOL(kretprobe_find_ret_addr);
 
+/**
+ * kretprobe_next_ret_addr -- Find next correct return address from @cur
+ * @tsk: Target task
+ * @fp: A framepointer to verify
+ * @cur: a storage and the base point of the loop cursor.
+ *
+ * Find the next correct return address modified by a kretprobe on @tsk from
+ * the entry which points *@cur. If it finds the next currect return address
+ * whose framepointer matches @fp, returns the return address.
+ * If the next current return address's framepointer doesn't match @fp, this
+ * returns ERR_PTR(-EILSEQ). If the *@cur is the end of the kretprobe_instance
+ * list, returns ERR_PTR(-ENOENT). If the @cur is NULL, returns ERR_PTR(-EINVAL).
+ * The @tsk must be 'current' or a task which is not running. @fp is used for
+ * verifying the framepointer which recorded with the correct return address
+ * (kretprobe_instance::fp field.)
+ * The @cur is a loop cursor for searching the kretprobe return addresses on
+ * the @tsk. If *@cur is NULL, this returns the top entry of the correct return
+ * address.
+ */
+kprobe_opcode_t *kretprobe_next_ret_addr(struct task_struct *tsk, void *fp,
+					 struct llist_node **cur)
+{
+	struct kretprobe_instance *ri = NULL;
+	kprobe_opcode_t *ret;
+
+	if (WARN_ON_ONCE(!cur))
+		return ERR_PTR(-EINVAL);
+
+	if (*cur) {
+		/* This returns the next correct return address */
+		ret = __kretprobe_find_ret_addr(tsk, cur);
+		if (!ret)
+			return ERR_PTR(-ENOENT);
+		ri = container_of(*cur, struct kretprobe_instance, llist);
+		return ri->fp == fp ? ret : ERR_PTR(-EILSEQ);
+	}
+
+	/* If this is the first try, find the FP-matched entry */
+	do {
+		ret = __kretprobe_find_ret_addr(tsk, cur);
+		if (!ret)
+			return ERR_PTR(-ENOENT);
+		ri = container_of(*cur, struct kretprobe_instance, llist);
+	} while (ri->fp != fp);
+
+	return ret;
+}
+NOKPROBE_SYMBOL(kretprobe_next_ret_addr);
+
 void __weak arch_kretprobe_fixup_return(struct pt_regs *regs,
 					kprobe_opcode_t *correct_ret_addr)
 {

