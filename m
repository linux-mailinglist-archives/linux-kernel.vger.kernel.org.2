Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86E7F40F4C4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 11:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343638AbhIQJ2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 05:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343549AbhIQJZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 05:25:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED63FC0617AF
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 02:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0dGXYmyzoIM5CMvgq2aoWe2tZhgpBR+TbRNYbbOH1so=; b=CQrfLhKZPcXzKUvzh8fzki6FKH
        GrGS3ePvU1IBd+pGjm8MSDDDlx6ZnGeOdmtIbfO0S4TA+I3GpRCyWhnTqQzlPncmAVOHKG08H1jTC
        dDlxkjdvtDPQviOfBuKwaA5rEQkH3K5FQF9ByEJFO+gMCCyMrnSEJeJcKMcHNHx4jNlxKGZeru6rQ
        Owoy2Zz01k82/9iDURPq7PSNOWmGt25n5IjXMPpzNL4mF5+bQ0+wcD4bkNOeJB9AfYS7zk73g6EmA
        AKFrjUXB1V2KuRMAfrEYrAVvRCxctOgXvzri6vtj+vPONGk0bo9plJTkJD1tFE7/5rYtA1IB0vrDC
        zhrAUPjw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mRA2P-0006Jl-DA; Fri, 17 Sep 2021 09:20:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BD2C5300260;
        Fri, 17 Sep 2021 11:20:04 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9DB3A2083B10F; Fri, 17 Sep 2021 11:20:04 +0200 (CEST)
Date:   Fri, 17 Sep 2021 11:20:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ondrej Zary <linux@zary.sk>
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] x86/iopl: Fake iopl(3) CLI/STI usage
Message-ID: <YURdxNpH8YNQZQT7@hirez.programming.kicks-ass.net>
References: <202109151423.43604.linux@zary.sk>
 <202109162227.17415.linux@zary.sk>
 <20210916210509.GG4323@worktop.programming.kicks-ass.net>
 <202109171011.31916.linux@zary.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202109171011.31916.linux@zary.sk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2021 at 10:11:31AM +0200, Ondrej Zary wrote:
> Yeah, it works!

w00t!! I've added a pr_err() to make sure people take note their
'software' is doing dodgy things.

---
Subject: x86/iopl: Fake iopl(3) CLI/STI usage
From: Peter Zijlstra <peterz@infradead.org>
Date: Thu, 16 Sep 2021 23:05:09 +0200

Since commit c8137ace5638 ("x86/iopl: Restrict iopl() permission
scope") it's possible to emulate iopl(3) using ioperm(), except for
the CLI/STI usage.

Userspace CLI/STI usage is very dubious (read broken), since any
exception taken during that window can lead to rescheduling anyway (or
worse). The IOPL(2) manpage even states that usage of CLI/STI is highly
discouraged and might even crash the system.

Of course, that won't stop people and HP has the dubious honour of
being the first vendor to be found using this in their hp-health
package.

In order to enable this 'software' to still 'work', have the #GP treat
the CLI/STI instructions as NOPs when iopl(3). Warn the user that
their program is doing dubious things.

Fixes: a24ca9976843 ("x86/iopl: Remove legacy IOPL option")
Reported-by: Ondrej Zary <linux@zary.sk>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/traps.c |   38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -528,6 +528,41 @@ static enum kernel_gp_hint get_kernel_gp
 
 #define GPFSTR "general protection fault"
 
+bool fixup_iopl_exception(struct pt_regs *regs)
+{
+	struct thread_struct *t = &current->thread;
+	unsigned char buf[MAX_INSN_SIZE];
+	struct insn insn;
+	int nr_copied;
+
+	if (!IS_ENABLED(CONFIG_X86_IOPL_IOPERM) || t->iopl_emul != 3 || !regs)
+		return false;
+
+	nr_copied = insn_fetch_from_user(regs, buf);
+	if (nr_copied <= 0)
+		return false;
+
+	if (!insn_decode_from_regs(&insn, regs, buf, nr_copied))
+		return false;
+
+	if (insn.length != 1)
+		return false;
+
+	if (insn.opcode.bytes[0] != 0xfa &&
+	    insn.opcode.bytes[0] != 0xfb)
+		return false;
+
+	if (printk_ratelimit()) {
+		pr_err("%s[%d] attempts to use CLI/STI, pretending it's a NOP, ip:%lx",
+		       current->comm, task_pid_nr(current), regs->ip);
+		print_vma_addr(KERN_CONT " in ", regs->ip);
+		pr_cont("\n");
+	}
+
+	regs->ip += 1;
+	return true;
+}
+
 DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
 {
 	char desc[sizeof(GPFSTR) + 50 + 2*sizeof(unsigned long) + 1] = GPFSTR;
@@ -553,6 +588,9 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_pr
 	tsk = current;
 
 	if (user_mode(regs)) {
+		if (fixup_iopl_exception(regs))
+			goto exit;
+
 		tsk->thread.error_code = error_code;
 		tsk->thread.trap_nr = X86_TRAP_GP;
 
