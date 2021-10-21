Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5E234357FA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 02:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbhJUA5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 20:57:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:51402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231444AbhJUA5K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 20:57:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D4944611C7;
        Thu, 21 Oct 2021 00:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634777695;
        bh=EmhCA26E8wn4zdfBxKo6rHymp3Y5IgKibhi1RWKA/b4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W4eAlkXLYOF18YQ+vsSWYEFjnf2IBvP6jsNj78FwSMqbFHjpQf/seFu7gVgOyyhc1
         eueoOkuJg1dfKs9fQ+O0riQtDDP1At2LaDkx+li5/HZ+kWRDAvVKV+mTSUMPcZWvo4
         6kZ7UQ7RIZd9C8eyoV5NQqWbjQk286TyyL31QS3r8jXZcJUjF274x/060IQt6JgaQx
         XTLcD67/nunuG612knMSr1Z0xwSjwOzPbPvoLBKSSDiiV3n+bJ4nMspMdG8DVmWm63
         FzSenH7+D+LKTy92gCexmVshITAQDKHjHXbZsI09cZ1Hp+uNTqmF5syXWJDi04Amnf
         5lKdC5HGNraqw==
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
Subject: [PATCH v3 4/9] arm64: kprobes: Record frame pointer with kretprobe instance
Date:   Thu, 21 Oct 2021 09:54:51 +0900
Message-Id: <163477769080.264901.17354945239446513633.stgit@devnote2>
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

