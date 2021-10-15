Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85CC342F16C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 14:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239202AbhJOMxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 08:53:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:53224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239263AbhJOMxa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 08:53:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4DF116101E;
        Fri, 15 Oct 2021 12:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634302283;
        bh=EmhCA26E8wn4zdfBxKo6rHymp3Y5IgKibhi1RWKA/b4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pAPPkNGFdFCe5qUiVmxBp7YRi8CoeGwrGAqJ37ZOojicAKBUvLg0ddaMH96u8lzSN
         DPFDCctw8fwrLeuMtP7Gu23bKNhH1A4Z3W2TgEEfTjhOeAl7uitfFPmSQu1DrdnQLH
         kIOV1YBR7On3Wh8XyesbQve4ACDwIvQdfSTX451gLNaNzP2cXMHpySAUU++LGu2ny/
         tu1GCVhsnLo0r56zFGjK2JCbMlHX2dx2klko36zYxOnrWQpdf5ZBK4Y80q3s96/0TF
         Ri1o5J15QcCpOzTeqvFsp7od/YvOOnT/VQXLrCELBrM9kPFMgNsr5g2zWilQ/YrVQM
         RqvZnMwNzYRbA==
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
Subject: [PATCH 04/10] arm64: kprobes: Record frame pointer with kretprobe instance
Date:   Fri, 15 Oct 2021 21:51:19 +0900
Message-Id: <163430227946.459050.807047989088672925.stgit@devnote2>
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

Record the frame pointer instead of stack address with kretprobe
instance as the identifier on the instance list.
Since arm64 always enable CONFIG_FRAME_POINTER, we can use the
actual frame pointer (x29).

This will allow the stacktrace code to find the original return
address from the FP alone.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Acked-by: Will Deacon <will@kernel.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
---
 Changes in v2:
  - Update changelog according to Mark's comment.
---
 arch/arm64/kernel/probes/kprobes.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
index e7ad6da980e8..d9dfa82c1f18 100644
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@ -401,14 +401,14 @@ int __init arch_populate_kprobe_blacklist(void)
 
 void __kprobes __used *trampoline_probe_handler(struct pt_regs *regs)
 {
-	return (void *)kretprobe_trampoline_handler(regs, (void *)kernel_stack_pointer(regs));
+	return (void *)kretprobe_trampoline_handler(regs, (void *)regs->regs[29]);
 }
 
 void __kprobes arch_prepare_kretprobe(struct kretprobe_instance *ri,
 				      struct pt_regs *regs)
 {
 	ri->ret_addr = (kprobe_opcode_t *)regs->regs[30];
-	ri->fp = (void *)kernel_stack_pointer(regs);
+	ri->fp = (void *)regs->regs[29];
 
 	/* replace return addr (x30) with trampoline */
 	regs->regs[30] = (long)&__kretprobe_trampoline;

