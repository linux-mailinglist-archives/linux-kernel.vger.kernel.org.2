Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA1C341054D
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 11:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238052AbhIRJIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 05:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233888AbhIRJIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 05:08:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB2DC061574
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 02:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JYTn75sieF/xEd3RYzyY8na3uOnXBuP2wa/mUNhtie4=; b=adFJFjj/N+LCgtIWFjN7mCHefo
        PHaP7vmrmkt6psoRVZnsJy9hd4Lu3FAaPnlgUM9OWvgkVpKT8LGXZmgUtwZpQbiYM8fg1BLMaAZTS
        vIJvZtDNpfW3nyRm+Byn4eoxDbUe0oP7cPepr6+MoprxwRVZWzfftUMvL79T8ceYyZuSkHLBLWmFO
        XSjeYA6HCtG+LYRKwB91pKNNiItsqD4D0m3PCbOQdBN9laI+w/XNS0vZ1rIZAUBr9n0G+k66JkQYA
        WTWFhWeHwUqtTy582Uq/sAkcUGHegXu75rFojuOT1v1RNZj1+q93ErsohtopBC8mpUALckPNqDHWB
        f0NM0Wyg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mRWJ0-00119x-6s; Sat, 18 Sep 2021 09:06:51 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 97E05986249; Sat, 18 Sep 2021 11:06:41 +0200 (CEST)
Date:   Sat, 18 Sep 2021 11:06:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ondrej Zary <linux@zary.sk>, Thomas Gleixner <tglx@linutronix.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/iopl: Fake iopl(3) CLI/STI usage
Message-ID: <20210918090641.GD5106@worktop.programming.kicks-ass.net>
References: <202109151423.43604.linux@zary.sk>
 <202109162227.17415.linux@zary.sk>
 <20210916210509.GG4323@worktop.programming.kicks-ass.net>
 <202109171011.31916.linux@zary.sk>
 <YURdxNpH8YNQZQT7@hirez.programming.kicks-ass.net>
 <CAHk-=wj_-bRjcJdXubdUUsTph+DH-5f77FmkbNCfFVYg=Td2zw@mail.gmail.com>
 <CAHk-=whsG4LfNJHjeprDn0iR=zRGBUBtSSgLep=MqbEb8yBuuA@mail.gmail.com>
 <YUWPuPyBxR9OVtXS@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUWPuPyBxR9OVtXS@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 18, 2021 at 09:05:28AM +0200, Peter Zijlstra wrote:
> On Fri, Sep 17, 2021 at 03:24:51PM -0700, Linus Torvalds wrote:
> > On Fri, Sep 17, 2021 at 3:23 PM Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > >
> > > I think the proper thing to do is perhaps something like
> > 
> > The alternative is to just ignore cs_abse entirely, and just use
> > "regs->ip", which makes this all even easier.
> > 
> > If somebody uses a code segment _and_ cli/sti, maybe they should just
> > get the SIGSEGV?
> 
> I did a hatched job on fixup_ump_exception() which is why it looks like
> it does, that said...
> 
> our case at hand mmap()'s BIOS code from /dev/mem and executes that, I
> don't think it does an LDT segment but it would be entirely in line with
> the level of hack we're looking at.
> 
> Let me frob at this after breakfast and see if I can make it better.

How's this then? I should probably look to see if I should be using this
insn_get_effective_ip() for perf_instruction_pointer() too. Although I
suspect we maybe took a shortcut there in favour of performance.

---
 arch/x86/include/asm/insn-eval.h |  1 +
 arch/x86/include/asm/processor.h |  1 +
 arch/x86/kernel/process.c        |  1 +
 arch/x86/kernel/traps.c          | 33 +++++++++++++++++++++++++++++++++
 arch/x86/lib/insn-eval.c         |  2 +-
 5 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/insn-eval.h b/arch/x86/include/asm/insn-eval.h
index 91d7182ad2d6..4ec3613551e3 100644
--- a/arch/x86/include/asm/insn-eval.h
+++ b/arch/x86/include/asm/insn-eval.h
@@ -21,6 +21,7 @@ int insn_get_modrm_rm_off(struct insn *insn, struct pt_regs *regs);
 int insn_get_modrm_reg_off(struct insn *insn, struct pt_regs *regs);
 unsigned long insn_get_seg_base(struct pt_regs *regs, int seg_reg_idx);
 int insn_get_code_seg_params(struct pt_regs *regs);
+int insn_get_effective_ip(struct pt_regs *regs, unsigned long *ip);
 int insn_fetch_from_user(struct pt_regs *regs,
 			 unsigned char buf[MAX_INSN_SIZE]);
 int insn_fetch_from_user_inatomic(struct pt_regs *regs,
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 9ad2acaaae9b..577f342dbfb2 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -518,6 +518,7 @@ struct thread_struct {
 	 */
 	unsigned long		iopl_emul;
 
+	unsigned int		iopl_warn:1;
 	unsigned int		sig_on_uaccess_err:1;
 
 	/*
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 1d9463e3096b..f2f733bcb2b9 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -132,6 +132,7 @@ int copy_thread(unsigned long clone_flags, unsigned long sp, unsigned long arg,
 	frame->ret_addr = (unsigned long) ret_from_fork;
 	p->thread.sp = (unsigned long) fork_frame;
 	p->thread.io_bitmap = NULL;
+	p->thread.iopl_warn = 0;
 	memset(p->thread.ptrace_bps, 0, sizeof(p->thread.ptrace_bps));
 
 #ifdef CONFIG_X86_64
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index a58800973aed..f3f3034b06f3 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -528,6 +528,36 @@ static enum kernel_gp_hint get_kernel_gp_address(struct pt_regs *regs,
 
 #define GPFSTR "general protection fault"
 
+static bool fixup_iopl_exception(struct pt_regs *regs)
+{
+	struct thread_struct *t = &current->thread;
+	unsigned char byte;
+	unsigned long ip;
+
+	if (!IS_ENABLED(CONFIG_X86_IOPL_IOPERM) || t->iopl_emul != 3)
+		return false;
+
+	if (insn_get_effective_ip(regs, &ip))
+		return false;
+
+	if (get_user(byte, (const char __user *)ip))
+		return false;
+
+	if (byte != 0xfa && byte != 0xfb) /* CLI, STI */
+		return false;
+
+	if (!t->iopl_warn && printk_ratelimit()) {
+		pr_err("%s[%d] attempts to use CLI/STI, pretending it's a NOP, ip:%lx",
+		       current->comm, task_pid_nr(current), ip);
+		print_vma_addr(KERN_CONT " in ", ip);
+		pr_cont("\n");
+		t->iopl_warn = 1;
+	}
+
+	regs->ip += 1;
+	return true;
+}
+
 DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
 {
 	char desc[sizeof(GPFSTR) + 50 + 2*sizeof(unsigned long) + 1] = GPFSTR;
@@ -553,6 +583,9 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
 	tsk = current;
 
 	if (user_mode(regs)) {
+		if (fixup_iopl_exception(regs))
+			goto exit;
+
 		tsk->thread.error_code = error_code;
 		tsk->thread.trap_nr = X86_TRAP_GP;
 
diff --git a/arch/x86/lib/insn-eval.c b/arch/x86/lib/insn-eval.c
index a1d24fdc07cf..eb3ccffb9b9d 100644
--- a/arch/x86/lib/insn-eval.c
+++ b/arch/x86/lib/insn-eval.c
@@ -1417,7 +1417,7 @@ void __user *insn_get_addr_ref(struct insn *insn, struct pt_regs *regs)
 	}
 }
 
-static int insn_get_effective_ip(struct pt_regs *regs, unsigned long *ip)
+int insn_get_effective_ip(struct pt_regs *regs, unsigned long *ip)
 {
 	unsigned long seg_base = 0;
 
