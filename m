Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A028737508D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 10:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233631AbhEFIJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 04:09:15 -0400
Received: from foss.arm.com ([217.140.110.172]:58868 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233340AbhEFIJO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 04:09:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ACEBF31B;
        Thu,  6 May 2021 01:08:16 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.31.158])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3D8AA3F718;
        Thu,  6 May 2021 01:08:13 -0700 (PDT)
Date:   Thu, 6 May 2021 09:08:04 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, wangkefeng.wang@huawei.com,
        akpm@linux-foundation.org, 0x7f454c46@gmail.com,
        rostedt@goodmis.org, chenhuang5@huawei.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        syzbot+0806291048161061627c@syzkaller.appspotmail.com,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH] RISC-V: Protect reads from other harts stack frames
Message-ID: <20210506080804.GA12883@C02TD0UTHF1T.local>
References: <20210506061352.340752-1-palmer@dabbelt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210506061352.340752-1-palmer@dabbelt.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 05, 2021 at 11:13:52PM -0700, Palmer Dabbelt wrote:
> From: Palmer Dabbelt <palmerdabbelt@google.com>
> 
> The stack walking code wasn't correctly decorated with READ_ONCE_NOCHECK
> when reading from other harts stack frames, which can trigger a kasan
> failure.  This may also manifest as a bug, as without the READ_ONCE we
> may get inconsistent results.
> 
> Reported-by: syzbot+0806291048161061627c@syzkaller.appspotmail.com
> Fixes: 5d8544e2d007 ("RISC-V: Generic library routines and assembly")
> Suggested-by: Dmitry Vyukov <dvyukov@google.com>
> Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
> 
> ---
> 
> I don't actually have a test for stack walking aside from just crashing
> the kernel and making sure things look roughly OK.  I haven't gotten
> around to that because this got lost in the merge window shuffle, but I
> thought I'd send this out in case someone has a better test for stack
> walking so I can start running that.

LKDTM has a CORRUPT_STACK test, but IIUC it doesn't have a cross-cpu variant.
Maybe Kees feels like adding one... ;)

It might be worth giving the CORRUPT_STACK test a spin regardless, since
that'll show whehtre your unwinder is generally robust to cases you might see
for racy unwinding.

To build that in, select CONFIG_LKDTM=y. You can get a list of the built-in
crash triggers with:

# cat /sys/kernel/debug/lkdtm/provoke-crash/DIRECT

... and to run the CORRUPT_STACK test specifically, run:

# echo CORRUPT_STACK > /sys/kernel/debug/lkdtm/provoke-crash/DIRECT

For comparison, on arm64 defconfig + LKDTM, that gives me the following:

| # echo CORRUPT_STACK > /sys/kernel/debug/provoke-crash/DIRECT 
| [   82.233662] lkdtm: Performing direct entry CORRUPT_STACK
| [   82.234771] lkdtm: Corrupting stack containing char array ...
| [   82.235927] Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: lkdtm_CORRUPT_STACK+0x48/0x58
| [   82.238031] CPU: 1 PID: 184 Comm: bash Not tainted 5.12.0-00001-gd387589d98cd-dirty #5
| [   82.239635] Hardware name: linux,dummy-virt (DT)
| [   82.240572] Call trace:
| [   82.241131]  dump_backtrace+0x0/0x1a0
| [   82.241895]  show_stack+0x18/0x70
| [   82.242579]  dump_stack+0xd0/0x12c
| [   82.243289]  panic+0x16c/0x334
| [   82.243919]  __stack_chk_fail+0x34/0x40
| [   82.244699]  lkdtm_CORRUPT_STACK+0x48/0x58
| [   82.245534]  lkdtm_do_action+0x24/0x30
| [   82.246346]  0xffffffffffffffff
| [   82.246994] SMP: stopping secondary CPUs
| [   82.247862] Kernel Offset: 0x5edcf4200000 from 0xffff800010000000
| [   82.249091] PHYS_OFFSET: 0xffffa3b4c0000000
| [   82.249959] CPU features: 0x00044002,63800038
| [   82.250918] Memory Limit: none
| [   82.251618] ---[ end Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: lkdtm_CORRUPT_STACK+0x48/0x58 ]---

... arm64 will stop when we hit the first bogus FP value as we check
that all frame records are within known stack bounds prior to
dereference. You might want to do similar on riscv.

Thanks,
Mark.

> ---
>  arch/riscv/kernel/stacktrace.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrace.c
> index 3f893c9d9d85..7f3914756915 100644
> --- a/arch/riscv/kernel/stacktrace.c
> +++ b/arch/riscv/kernel/stacktrace.c
> @@ -18,6 +18,9 @@ register const unsigned long sp_in_global __asm__("sp");
>  
>  #ifdef CONFIG_FRAME_POINTER
>  
> +#define READ_FRAME(frame, off)	\
> +	(READ_ONCE_NOCHECK(*(unsigned long *)(frame + offsetof(struct stackframe, off))))
> +
>  void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
>  			     bool (*fn)(void *, unsigned long), void *arg)
>  {
> @@ -40,7 +43,7 @@ void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
>  
>  	for (;;) {
>  		unsigned long low, high;
> -		struct stackframe *frame;
> +		unsigned long frame;
>  
>  		if (unlikely(!__kernel_text_address(pc) || !fn(arg, pc)))
>  			break;
> @@ -51,14 +54,14 @@ void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
>  		if (unlikely(fp < low || fp > high || fp & 0x7))
>  			break;
>  		/* Unwind stack frame */
> -		frame = (struct stackframe *)fp - 1;
> +		frame = fp - sizeof(struct stackframe);
>  		sp = fp;
> -		if (regs && (regs->epc == pc) && (frame->fp & 0x7)) {
> -			fp = frame->ra;
> +		if (regs && (regs->epc == pc) && (READ_FRAME(frame, fp) & 0x7)) {
> +			fp = READ_FRAME(frame, ra);
>  			pc = regs->ra;
>  		} else {
> -			fp = frame->fp;
> -			pc = ftrace_graph_ret_addr(current, NULL, frame->ra,
> +			fp = READ_FRAME(frame, fp);
> +			pc = ftrace_graph_ret_addr(current, NULL, READ_FRAME(frame, ra),
>  						   (unsigned long *)(fp - 8));
>  		}
>  
> -- 
> 2.31.1.527.g47e6f16901-goog
> 
