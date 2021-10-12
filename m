Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86CAD42A70B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 16:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237268AbhJLOUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 10:20:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:55198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237248AbhJLOUm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 10:20:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0D4E560EFE;
        Tue, 12 Oct 2021 14:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634048320;
        bh=7fvG1qwOsQbbh48aDMK9Imgg95CjCCaeJfTcDCkFPqk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=W7a5X2f1XjAD3IZvefCwbMGY529p2jXc61NYvsA1O6NIn3rjYC6qMGamPymdaNUyE
         mPPiNJhzLSc4QvcM38dcbpIAVJL1JUTps5ZSW2JChoHBkr+q5uQpDyWzvb9iSrZNcs
         no3AGukJynB6lCaWi4aVy3ufdKU20p/CdKpkEnfVRRfQeIkUPoZsIm6T0WX6g3itrY
         YBF6lsFDYacrClAu0w1Q9FbNXUC0mSQL3+FFs9vG1WaOLM/5sxFhpXcyetCy39RmGx
         agWesXqiVUbATsvKe+MgTy2DBQmpZKMZCKL9kUQ7KocWdWeE+UKLnDCh8iTDaqqQjQ
         WbwAYqLw/c3vA==
Date:   Tue, 12 Oct 2021 23:18:35 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ananth N Mavinakayanahalli <ananth@linux.ibm.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        Sven Schnelle <svens@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Nathan Huckleberry <nhuck@google.com>
Subject: Re: [PATCH 6/8] ARM: clang: Do not relay on lr register for
 stacktrace
Message-Id: <20211012231835.522ac7ba366e5019192c1a5a@kernel.org>
In-Reply-To: <CAKwvOdkdPHN0Y5GwTPUeaZyjtBttWrfoeLvQJFaJrfOHAtxkHg@mail.gmail.com>
References: <163369609308.636038.15295764725220907794.stgit@devnote2>
        <163369614818.636038.5019945597127474028.stgit@devnote2>
        <CAKwvOdkdPHN0Y5GwTPUeaZyjtBttWrfoeLvQJFaJrfOHAtxkHg@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

On Mon, 11 Oct 2021 11:45:22 -0700
Nick Desaulniers <ndesaulniers@google.com> wrote:

> On Fri, Oct 8, 2021 at 5:29 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > Currently the stacktrace on clang compiled arm kernel uses the 'lr'
> > register to find the first frame address from pt_regs. However, that
> > is wrong after calling another function, because the 'lr' register
> > is used by 'bl' instruction and never be recovered.
> >
> > As same as gcc arm kernel, directly use the frame pointer (x11) of
> > the pt_regs to find the first frame address.
> 
> Hi Masami,
> Thanks for the patch. Testing with ARCH=arm defconfig (multi_v7_defconfig)
> 
> Before this patch:
> 
> $ mount -t proc /proc
> $ echo 0 > /proc/sys/kernel/kptr_restrict
> $ cat /proc/self/stack
> [<0>] proc_single_show+0x4c/0xb8
> [<0>] seq_read_iter+0x174/0x4d8
> [<0>] seq_read+0x134/0x158
> [<0>] vfs_read+0xcc/0x2f8
> [<0>] ksys_read+0x74/0xd0
> [<0>] __entry_text_start+0x14/0x14
> [<0>] 0xbea38cc0
> 
> After this patch:
> $ mount -t proc /proc
> $ echo 0 > /proc/sys/kernel/kptr_restrict
> $ cat /proc/self/stack
> [<0>] proc_single_show+0x4c/0xb8
> [<0>] seq_read_iter+0x174/0x4d8
> [<0>] seq_read+0x134/0x158
> [<0>] vfs_read+0xcc/0x2f8
> [<0>] ksys_read+0x74/0xd0
> [<0>] __entry_text_start+0x14/0x14
> [<0>] 0xbeb55cc0
> 
> Is there a different way to test/verify this patch? (I'm pretty sure
> we had verified the WARN_ONCE functionality with this, too.)

Hmm, I found this bug while testing my kretprobe-stacktrace test
([2/8] in this series), so if you apply this series and revert
this patch and enable CONFIG_KPROBES_SANITY_TEST, you'll see that
the tests failures as below.

[    4.062056]     ok 4 - test_kretprobes
[    4.069944]     # test_stacktrace_on_kretprobe: EXPECTATION FAILED at kernel/test_kprobes.c:235
[    4.069944]     Expected i != ret, but
[    4.069944]         i == 10
[    4.069944]         ret == 10
[    4.072692]     not ok 5 - test_stacktrace_on_kretprobe
[    4.088171]     # test_stacktrace_on_nested_kretprobe: EXPECTATION FAILED at kernel/test_kprobes.c:235
[    4.088171]     Expected i != ret, but
[    4.088171]         i == 10
[    4.088171]         ret == 10
[    4.091265]     not ok 6 - test_stacktrace_on_nested_kretprobe

This means the test failed to find the correct return address from
the stacktrace.
Applying this patch,

[    4.283953]     ok 4 - test_kretprobes
[    4.290206]     ok 5 - test_stacktrace_on_kretprobe
[    4.300429]     ok 6 - test_stacktrace_on_nested_kretprobe
[    4.301743] # kprobes_test: pass:6 fail:0 skip:0 total:6


> 
> If I change from CONFIG_UNWINDER_ARM=y to
> CONFIG_UNWINDER_FRAME_POINTER=y, before:
> 
> # cat /proc/self/stack
> [<0>] stack_trace_save_tsk+0x50/0x6c
> [<0>] proc_pid_stack+0xa0/0xf8
> [<0>] proc_single_show+0x50/0xbc
> [<0>] seq_read_iter+0x178/0x4ec
> [<0>] seq_read+0x138/0x15c
> [<0>] vfs_read+0xd0/0x304
> [<0>] ksys_read+0x78/0xd4
> [<0>] sys_read+0xc/0x10
> 
> after:
> # cat /proc/self/stack
> [<0>] proc_pid_stack+0xa0/0xf8
> [<0>] proc_single_show+0x50/0xbc
> [<0>] seq_read_iter+0x178/0x4ec
> [<0>] seq_read+0x138/0x15c
> [<0>] vfs_read+0xd0/0x304
> [<0>] ksys_read+0x78/0xd4
> [<0>] sys_read+0xc/0x10
> [<0>] __entry_text_start+0x14/0x14
> [<0>] 0xffffffff
> 
> So I guess this helps the CONFIG_UNWINDER_FRAME_POINTER=y case? (That
> final frame address looks wrong, but is potentially yet another bug;
> perhaps for clang we need to manually store the previous frame's pc at
> a different offset before jumping to __entry_text_start).

Ah, yes. I didn't touch the UNWINDER_ARM. As you may know the
unwind_frame()@arch/arm/kernel/stacktrace.c is compiled only
CONFIG_UNWINDER_FRAME_POINTER=y.

> 
> Also, I'm curious about CONFIG_THUMB2_KERNEL (forces CONFIG_UNWINDER_ARM=y).
> 
> before:
> # cat /proc/self/stack
> [<0>] proc_single_show+0x31/0x86
> [<0>] seq_read_iter+0xff/0x326
> [<0>] seq_read+0xd7/0xf2
> [<0>] vfs_read+0x93/0x20e
> [<0>] ksys_read+0x53/0x92
> [<0>] ret_fast_syscall+0x1/0x52
> [<0>] 0xbe9a9cc0
> 
> after:
> # cat /proc/self/stack
> [<0>] proc_single_show+0x31/0x86
> [<0>] seq_read_iter+0xff/0x326
> [<0>] seq_read+0xd7/0xf2
> [<0>] vfs_read+0x93/0x20e
> [<0>] ksys_read+0x53/0x92
> [<0>] ret_fast_syscall+0x1/0x52
> [<0>] 0xbec08cc0
> 
> Tested-by: Nick Desaulniers <ndesaulniers@google.com>
> 
> so likely this fixes/improves CONFIG_UNWINDER_FRAME_POINTER=y? Is that correct?

Yes, that is correct.

Thank you!

> 
> >
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > ---
> >  arch/arm/kernel/stacktrace.c |    3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/arch/arm/kernel/stacktrace.c b/arch/arm/kernel/stacktrace.c
> > index 76ea4178a55c..db798eac7431 100644
> > --- a/arch/arm/kernel/stacktrace.c
> > +++ b/arch/arm/kernel/stacktrace.c
> > @@ -54,8 +54,7 @@ int notrace unwind_frame(struct stackframe *frame)
> >
> >         frame->sp = frame->fp;
> >         frame->fp = *(unsigned long *)(fp);
> > -       frame->pc = frame->lr;
> > -       frame->lr = *(unsigned long *)(fp + 4);
> > +       frame->pc = *(unsigned long *)(fp + 4);
> >  #else
> >         /* check current frame pointer is within bounds */
> >         if (fp < low + 12 || fp > high - 4)
> >
> 
> -- 
> Thanks,
> ~Nick Desaulniers


-- 
Masami Hiramatsu <mhiramat@kernel.org>
