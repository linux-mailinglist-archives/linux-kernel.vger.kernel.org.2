Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69A9740F5ED
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 12:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242947AbhIQKar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 06:30:47 -0400
Received: from hosting.gsystem.sk ([212.5.213.30]:42542 "EHLO
        hosting.gsystem.sk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242860AbhIQKap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 06:30:45 -0400
Received: from [192.168.1.3] (ns.gsystem.sk [62.176.172.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 219E47A0421;
        Fri, 17 Sep 2021 12:29:22 +0200 (CEST)
From:   Ondrej Zary <linux@zary.sk>
To:     Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] x86/iopl: Fake iopl(3) CLI/STI usage
Date:   Fri, 17 Sep 2021 12:29:18 +0200
User-Agent: KMail/1.9.10
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <202109151423.43604.linux@zary.sk> <202109171011.31916.linux@zary.sk> <YURdxNpH8YNQZQT7@hirez.programming.kicks-ass.net>
In-Reply-To: <YURdxNpH8YNQZQT7@hirez.programming.kicks-ass.net>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="ansi_x3.4-1968"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202109171229.19289.linux@zary.sk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 17 September 2021, Peter Zijlstra wrote:
> On Fri, Sep 17, 2021 at 10:11:31AM +0200, Ondrej Zary wrote:
> > Yeah, it works!
> 
> w00t!! I've added a pr_err() to make sure people take note their
> 'software' is doing dodgy things.

It's a bit noisy:
[    9.668952] process 'hp/hp-health/bin/hpasmd' started with executable stack
[    9.741338] floppy0: no floppy controllers found
[    9.866354] traps: hpasmd[360] attempts to use CLI/STI, pretending it's a NOP, ip:f7d9109b in mem[f7d91000+3000]
[    9.866500] traps: hpasmd[360] attempts to use CLI/STI, pretending it's a NOP, ip:f7d921a2 in mem[f7d91000+3000]
[   10.141846] traps: hpasmd[360] attempts to use CLI/STI, pretending it's a NOP, ip:80a5356
[   10.142157] traps: hpasmd[360] attempts to use CLI/STI, pretending it's a NOP, ip:80a5356
[   10.269408] traps: hpasmd[360] attempts to use CLI/STI, pretending it's a NOP, ip:80a538f
[   10.269521] traps: hpasmd[360] attempts to use CLI/STI, pretending it's a NOP, ip:80a5356
[   10.269754] traps: hpasmd[360] attempts to use CLI/STI, pretending it's a NOP, ip:80a5356
[   10.273606] traps: hpasmd[360] attempts to use CLI/STI, pretending it's a NOP, ip:80a5356
[   10.287503] traps: hpasmd[360] attempts to use CLI/STI, pretending it's a NOP, ip:80a5356
[   10.301421] traps: hpasmd[360] attempts to use CLI/STI, pretending it's a NOP, ip:80a5356
[   14.876824] fixup_iopl_exception: 333 callbacks suppressed
[   14.876832] traps: hpasmd[360] attempts to use CLI/STI, pretending it's a NOP, ip:80a5356
[   14.890704] traps: hpasmd[360] attempts to use CLI/STI, pretending it's a NOP, ip:80a5356
[   14.904581] traps: hpasmd[360] attempts to use CLI/STI, pretending it's a NOP, ip:80a5356
[   14.918469] traps: hpasmd[360] attempts to use CLI/STI, pretending it's a NOP, ip:80a5356
[   14.932352] traps: hpasmd[360] attempts to use CLI/STI, pretending it's a NOP, ip:80a5356
[   14.946225] traps: hpasmd[360] attempts to use CLI/STI, pretending it's a NOP, ip:80a5356
[   14.960096] traps: hpasmd[360] attempts to use CLI/STI, pretending it's a NOP, ip:80a5356
[   14.973976] traps: hpasmd[360] attempts to use CLI/STI, pretending it's a NOP, ip:80a5356
[   14.987861] traps: hpasmd[360] attempts to use CLI/STI, pretending it's a NOP, ip:80a5356
[   15.001732] traps: hpasmd[360] attempts to use CLI/STI, pretending it's a NOP, ip:80a5356
[   15.688468] tg3 0000:03:01.0 enp3s1f0: Link is up at 1000 Mbps, full duplex
[   15.688492] tg3 0000:03:01.0 enp3s1f0: Flow control is on for TX and on for RX
[   15.688524] IPv6: ADDRCONF(NETDEV_CHANGE): enp3s1f0: link becomes ready
[   19.877230] fixup_iopl_exception: 355 callbacks suppressed
[   19.877238] traps: hpasmd[360] attempts to use CLI/STI, pretending it's a NOP, ip:80a5356
[   19.891103] traps: hpasmd[360] attempts to use CLI/STI, pretending it's a NOP, ip:80a5356
[   19.904971] traps: hpasmd[360] attempts to use CLI/STI, pretending it's a NOP, ip:80a5356
[   19.918817] traps: hpasmd[360] attempts to use CLI/STI, pretending it's a NOP, ip:80a5356
[   19.932677] traps: hpasmd[360] attempts to use CLI/STI, pretending it's a NOP, ip:80a5356
[   19.946550] traps: hpasmd[360] attempts to use CLI/STI, pretending it's a NOP, ip:80a5356
[   19.960422] traps: hpasmd[360] attempts to use CLI/STI, pretending it's a NOP, ip:80a5356
[   19.974292] traps: hpasmd[360] attempts to use CLI/STI, pretending it's a NOP, ip:80a5356
[   19.988158] traps: hpasmd[360] attempts to use CLI/STI, pretending it's a NOP, ip:80a5356
[   20.002029] traps: hpasmd[360] attempts to use CLI/STI, pretending it's a NOP, ip:80a5356
[   24.881216] fixup_iopl_exception: 357 callbacks suppressed
[   24.881222] traps: hpasmd[360] attempts to use CLI/STI, pretending it's a NOP, ip:80a5356
[   24.895109] traps: hpasmd[360] attempts to use CLI/STI, pretending it's a NOP, ip:80a5356
[   24.908983] traps: hpasmd[360] attempts to use CLI/STI, pretending it's a NOP, ip:80a5356
[   24.922846] traps: hpasmd[360] attempts to use CLI/STI, pretending it's a NOP, ip:80a5356
[   24.936717] traps: hpasmd[360] attempts to use CLI/STI, pretending it's a NOP, ip:80a5356
[   24.950576] traps: hpasmd[360] attempts to use CLI/STI, pretending it's a NOP, ip:80a5356
[   24.964452] traps: hpasmd[360] attempts to use CLI/STI, pretending it's a NOP, ip:80a5356
[   24.978324] traps: hpasmd[360] attempts to use CLI/STI, pretending it's a NOP, ip:80a5356
[   24.992196] traps: hpasmd[360] attempts to use CLI/STI, pretending it's a NOP, ip:80a5356
[   25.006066] traps: hpasmd[360] attempts to use CLI/STI, pretending it's a NOP, ip:80a5356
[   29.895371] fixup_iopl_exception: 356 callbacks suppressed
[   29.895377] traps: hpasmd[360] attempts to use CLI/STI, pretending it's a NOP, ip:80a5356
[   29.909245] traps: hpasmd[360] attempts to use CLI/STI, pretending it's a NOP, ip:80a5356
[   29.923114] traps: hpasmd[360] attempts to use CLI/STI, pretending it's a NOP, ip:80a5356
[   29.936984] traps: hpasmd[360] attempts to use CLI/STI, pretending it's a NOP, ip:80a5356
[   29.950863] traps: hpasmd[360] attempts to use CLI/STI, pretending it's a NOP, ip:80a5356
[   29.964755] traps: hpasmd[360] attempts to use CLI/STI, pretending it's a NOP, ip:80a5356
[   29.978637] traps: hpasmd[360] attempts to use CLI/STI, pretending it's a NOP, ip:80a5356
[   29.992515] traps: hpasmd[360] attempts to use CLI/STI, pretending it's a NOP, ip:80a5356
[   30.006400] traps: hpasmd[360] attempts to use CLI/STI, pretending it's a NOP, ip:80a5356
[   30.020268] traps: hpasmd[360] attempts to use CLI/STI, pretending it's a NOP, ip:80a5356

 
> ---
> Subject: x86/iopl: Fake iopl(3) CLI/STI usage
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Thu, 16 Sep 2021 23:05:09 +0200
> 
> Since commit c8137ace5638 ("x86/iopl: Restrict iopl() permission
> scope") it's possible to emulate iopl(3) using ioperm(), except for
> the CLI/STI usage.
> 
> Userspace CLI/STI usage is very dubious (read broken), since any
> exception taken during that window can lead to rescheduling anyway (or
> worse). The IOPL(2) manpage even states that usage of CLI/STI is highly
> discouraged and might even crash the system.
> 
> Of course, that won't stop people and HP has the dubious honour of
> being the first vendor to be found using this in their hp-health
> package.
> 
> In order to enable this 'software' to still 'work', have the #GP treat
> the CLI/STI instructions as NOPs when iopl(3). Warn the user that
> their program is doing dubious things.
> 
> Fixes: a24ca9976843 ("x86/iopl: Remove legacy IOPL option")
> Reported-by: Ondrej Zary <linux@zary.sk>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/kernel/traps.c |   38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -528,6 +528,41 @@ static enum kernel_gp_hint get_kernel_gp
>  
>  #define GPFSTR "general protection fault"
>  
> +bool fixup_iopl_exception(struct pt_regs *regs)
> +{
> +	struct thread_struct *t = &current->thread;
> +	unsigned char buf[MAX_INSN_SIZE];
> +	struct insn insn;
> +	int nr_copied;
> +
> +	if (!IS_ENABLED(CONFIG_X86_IOPL_IOPERM) || t->iopl_emul != 3 || !regs)
> +		return false;
> +
> +	nr_copied = insn_fetch_from_user(regs, buf);
> +	if (nr_copied <= 0)
> +		return false;
> +
> +	if (!insn_decode_from_regs(&insn, regs, buf, nr_copied))
> +		return false;
> +
> +	if (insn.length != 1)
> +		return false;
> +
> +	if (insn.opcode.bytes[0] != 0xfa &&
> +	    insn.opcode.bytes[0] != 0xfb)
> +		return false;
> +
> +	if (printk_ratelimit()) {
> +		pr_err("%s[%d] attempts to use CLI/STI, pretending it's a NOP, ip:%lx",
> +		       current->comm, task_pid_nr(current), regs->ip);
> +		print_vma_addr(KERN_CONT " in ", regs->ip);
> +		pr_cont("\n");
> +	}
> +
> +	regs->ip += 1;
> +	return true;
> +}
> +
>  DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
>  {
>  	char desc[sizeof(GPFSTR) + 50 + 2*sizeof(unsigned long) + 1] = GPFSTR;
> @@ -553,6 +588,9 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_pr
>  	tsk = current;
>  
>  	if (user_mode(regs)) {
> +		if (fixup_iopl_exception(regs))
> +			goto exit;
> +
>  		tsk->thread.error_code = error_code;
>  		tsk->thread.trap_nr = X86_TRAP_GP;
>  
> 



-- 
Ondrej Zary
