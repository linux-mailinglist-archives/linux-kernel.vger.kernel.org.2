Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA5840F6ED
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 13:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238527AbhIQL44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 07:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbhIQL4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 07:56:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3391AC061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 04:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EcLd2iiHo7XudB25BJo8MRT/PevxtqJt5Y440jTBX94=; b=fINZgDyslz6SRWvM7hOOF1NRsU
        CFyLRVSSEuylutA1qZwIdm4mWqtAGwMUGsIHCiCntikgU2tWtwDVnEIlVgX6FJOIfhJ8yzrFg2oIJ
        aRpQ8n2A3LWfcvi7BxDLD7HyDZOwyiscqLtHlabLAPdIqwmIyVbJth0UJy5bfjkqe5pyn6YP+iZrO
        8bwJj0pUWR0YzaoiUTrkUDv7/4msR6C52QBPuSnF1rtBGUQBll59Ius7zowyuiZEe7LreHHCnmLFG
        We58LT35JBybc06k2yfVChB4pI6/X7ZMAwVVNFWoN33JPl1v2d9S7I2t19CRhB2jlmtBmXGg9xuUV
        NImJepxg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mRCSE-000D27-9q; Fri, 17 Sep 2021 11:55:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 70D9230031A;
        Fri, 17 Sep 2021 13:54:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 55D312D80FB23; Fri, 17 Sep 2021 13:54:53 +0200 (CEST)
Date:   Fri, 17 Sep 2021 13:54:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ondrej Zary <linux@zary.sk>
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] x86/iopl: Fake iopl(3) CLI/STI usage
Message-ID: <YUSCDX5QwzTcCPFa@hirez.programming.kicks-ass.net>
References: <202109151423.43604.linux@zary.sk>
 <202109171011.31916.linux@zary.sk>
 <YURdxNpH8YNQZQT7@hirez.programming.kicks-ass.net>
 <202109171229.19289.linux@zary.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202109171229.19289.linux@zary.sk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2021 at 12:29:18PM +0200, Ondrej Zary wrote:
> On Friday 17 September 2021, Peter Zijlstra wrote:
> > On Fri, Sep 17, 2021 at 10:11:31AM +0200, Ondrej Zary wrote:
> > > Yeah, it works!
> > 
> > w00t!! I've added a pr_err() to make sure people take note their
> > 'software' is doing dodgy things.
> 
> It's a bit noisy:
> [    9.668952] process 'hp/hp-health/bin/hpasmd' started with executable stack
> [    9.741338] floppy0: no floppy controllers found
> [    9.866354] traps: hpasmd[360] attempts to use CLI/STI, pretending it's a NOP, ip:f7d9109b in mem[f7d91000+3000]
> [    9.866500] traps: hpasmd[360] attempts to use CLI/STI, pretending it's a NOP, ip:f7d921a2 in mem[f7d91000+3000]
> [   10.141846] traps: hpasmd[360] attempts to use CLI/STI, pretending it's a NOP, ip:80a5356
> [   10.142157] traps: hpasmd[360] attempts to use CLI/STI, pretending it's a NOP, ip:80a5356
> [   10.269408] traps: hpasmd[360] attempts to use CLI/STI, pretending it's a NOP, ip:80a538f
> [   10.269521] traps: hpasmd[360] attempts to use CLI/STI, pretending it's a NOP, ip:80a5356
> [   10.269754] traps: hpasmd[360] attempts to use CLI/STI, pretending it's a NOP, ip:80a5356
> [   10.273606] traps: hpasmd[360] attempts to use CLI/STI, pretending it's a NOP, ip:80a5356
> [   10.287503] traps: hpasmd[360] attempts to use CLI/STI, pretending it's a NOP, ip:80a5356
> [   10.301421] traps: hpasmd[360] attempts to use CLI/STI, pretending it's a NOP, ip:80a5356
> [   14.876824] fixup_iopl_exception: 333 callbacks suppressed
> [   14.876832] traps: hpasmd[360] attempts to use CLI/STI, pretending it's a NOP, ip:80a5356

I'd say...

Not sure it's really worth it, but something like the below might help.

--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -518,6 +518,7 @@ struct thread_struct {
 	 */
 	unsigned long		iopl_emul;
 
+	unsigned int		iopl_warn:1;
 	unsigned int		sig_on_uaccess_err:1;
 
 	/*
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -132,6 +132,7 @@ int copy_thread(unsigned long clone_flag
 	frame->ret_addr = (unsigned long) ret_from_fork;
 	p->thread.sp = (unsigned long) fork_frame;
 	p->thread.io_bitmap = NULL;
+	p->thread.iopl_warn = 0;
 	memset(p->thread.ptrace_bps, 0, sizeof(p->thread.ptrace_bps));
 
 #ifdef CONFIG_X86_64
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -552,11 +552,12 @@ bool fixup_iopl_exception(struct pt_regs
 	    insn.opcode.bytes[0] != 0xfb)
 		return false;
 
-	if (printk_ratelimit()) {
+	if (!t->iopl_warn && printk_ratelimit()) {
 		pr_err("%s[%d] attempts to use CLI/STI, pretending it's a NOP, ip:%lx",
 		       current->comm, task_pid_nr(current), regs->ip);
 		print_vma_addr(KERN_CONT " in ", regs->ip);
 		pr_cont("\n");
+		t->iopl_warn = 1;
 	}
 
 	regs->ip += 1;
