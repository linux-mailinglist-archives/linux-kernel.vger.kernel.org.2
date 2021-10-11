Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8586429266
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 16:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244291AbhJKOpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 10:45:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:57594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244168AbhJKOpX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 10:45:23 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8BEF160BD3;
        Mon, 11 Oct 2021 14:43:21 +0000 (UTC)
Date:   Mon, 11 Oct 2021 10:43:19 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        syzbot <syzbot+84fe685c02cd112a2ac3@syzkaller.appspotmail.com>,
        bp@alien8.de, hpa@zytor.com, inglorion@google.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        x86@kernel.org, Andy Lutomirski <luto@kernel.org>, tkjos@google.com
Subject: Re: [syzbot] KASAN: stack-out-of-bounds Read in profile_pc
Message-ID: <20211011104319.7c6125cb@gandalf.local.home>
In-Reply-To: <YWQ3AzF+q2xeyQ/p@google.com>
References: <00000000000030293b05c39afd6f@google.com>
        <20210602230054.vyqama2q3koc4bpo@treble>
        <527ad07e-eec2-a211-03e7-afafe5196100@linux.intel.com>
        <YLjZYvXnuPnbXzOm@hirez.programming.kicks-ass.net>
        <20210603133914.j2aeadmvhncnlk5q@treble>
        <0b71d4f9-f707-3d39-c358-7c06c5689a9d@linux.intel.com>
        <YWQ3AzF+q2xeyQ/p@google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Oct 2021 14:07:15 +0100
Lee Jones <lee.jones@linaro.org> wrote:

> On Thu, 03 Jun 2021, Andi Kleen wrote:
> 
> >   
> > > True, ftrace does have function profiling (function_profile_enabled).
> > > 
> > > Steve, is there a way to enable that on the kernel cmdline?  
> > 
> > That's not really comparable. function profiling has a lot more overhead.
> > Also there is various code which has ftrace instrumentation disabled.
> > 
> > I don't think why you want to kill the old profiler. It's rarely used, but
> > when you need it usually works. It's always good to have simple fall backs.
> > And it's not that it's a lot of difficult code.  
> 
> sysbot is still sending out reports on this:
> 
>   https://syzkaller.appspot.com/bug?id=00c965d957410afc0d40cac5343064e0a98b9ecd
> 
> Are you guys still planning on sending out a fix?
> 
> Is there anything I can do to help?
> 

According to the above:

==================================================================
BUG: KASAN: stack-out-of-bounds in profile_pc+0xa4/0xe0 arch/x86/kernel/time.c:42
Read of size 8 at addr ffffc90001c0f7a0 by task systemd-udevd/12323

CPU: 1 PID: 12323 Comm: systemd-udevd Not tainted 5.13.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x202/0x31e lib/dump_stack.c:120
 print_address_description+0x5f/0x3b0 mm/kasan/report.c:233
 __kasan_report mm/kasan/report.c:419 [inline]
 kasan_report+0x15c/0x200 mm/kasan/report.c:436
 profile_pc+0xa4/0xe0 arch/x86/kernel/time.c:42
 profile_tick+0xcd/0x120 kernel/profile.c:408
 tick_sched_handle kernel/time/tick-sched.c:227 [inline]
 tick_sched_timer+0x287/0x420 kernel/time/tick-sched.c:1373
 __run_hrtimer kernel/time/hrtimer.c:1537 [inline]
 __hrtimer_run_queues+0x4cb/0xa60 kernel/time/hrtimer.c:1601
 hrtimer_interrupt+0x3b3/0x1040 kernel/time/hrtimer.c:1663
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1089 [inline]
 __sysvec_apic_timer_interrupt+0xf9/0x270 arch/x86/kernel/apic/apic.c:1106
 sysvec_apic_timer_interrupt+0x8c/0xb0 arch/x86/kernel/apic/apic.c:1100

And the code has:

 profile_pc+0xa4/0xe0 arch/x86/kernel/time.c:42

unsigned long profile_pc(struct pt_regs *regs)
{
	unsigned long pc = instruction_pointer(regs);

	if (!user_mode(regs) && in_lock_functions(pc)) {
#ifdef CONFIG_FRAME_POINTER
		return *(unsigned long *)(regs->bp + sizeof(long));
#else
		unsigned long *sp = (unsigned long *)regs->sp;
		/*
		 * Return address is either directly at stack pointer
		 * or above a saved flags. Eflags has bits 22-31 zero,
		 * kernel addresses don't.
		 */
		if (sp[0] >> 22)
			return sp[0];  <== line 42
		if (sp[1] >> 22)
			return sp[1];
#endif
	}
	return pc;
}
EXPORT_SYMBOL(profile_pc);


It looks to me that the profiler is doing a trick to read the contents of
the stack when the interrupt went off, but this triggers the KASAN
instrumentation to think it's a mistake when it's not. aka "false positive".

How does one tell KASAN that it wants to go outside the stack, because it
knows what its doing?

Should that just be converted to a "copy_from_kernel_nofault()"? That is,
does this fix it? (not even compiled tested)

-- Steve


diff --git a/arch/x86/kernel/time.c b/arch/x86/kernel/time.c
index e42faa792c07..cc6ec29aa14d 100644
--- a/arch/x86/kernel/time.c
+++ b/arch/x86/kernel/time.c
@@ -34,15 +34,18 @@ unsigned long profile_pc(struct pt_regs *regs)
 		return *(unsigned long *)(regs->bp + sizeof(long));
 #else
 		unsigned long *sp = (unsigned long *)regs->sp;
+		unsigned long retaddr;
 		/*
 		 * Return address is either directly at stack pointer
 		 * or above a saved flags. Eflags has bits 22-31 zero,
 		 * kernel addresses don't.
 		 */
-		if (sp[0] >> 22)
-			return sp[0];
-		if (sp[1] >> 22)
-			return sp[1];
+		if (!copy_from_kernel_nofault(&retaddr, sp, sizeof(long)) &&
+		    retaddr >> 22)
+			return retaddr;
+		if (!copy_from_kernel_nofault(&retaddr, sp + 1, sizeof(long)) &&
+		    retaddr >> 22)
+			return retaddr;
 #endif
 	}
 	return pc;
