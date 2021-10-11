Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F29D8429550
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 19:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233638AbhJKRMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 13:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233607AbhJKRMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 13:12:33 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B6AC06161C
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 10:10:33 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id s4-20020a4aad44000000b002b6aa5b6999so4031320oon.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 10:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fKMqalkFUbiAm52d74qp8NTlNfZl7kBDyT/H8w+a0iw=;
        b=EU2Lfffe6FmA4VmGIsStvWfrrs+yFD64w9Fk9jJtxd75swXyyym+/Mdr3uB/cLnDFG
         c8W0orZ8Cua9Dcf/oHoE3bZAPv33K4rK7stKl7W3P2a7kqFBXmP2Y2vwfDfEytF9rwrb
         JaIU/WwZzo7LRNr7HvltMWZI1B3VMc5wtlz3p6TINCpVG1RNC7/ylLW5aI3MkfGsfHTH
         l2+d0pXjNrM7RM8u2XRsH8CAOLn95zKeF5S9tItvncPoTCdvtQPuKaqHRhi9ANabL/ZY
         b0lyZ7Da2pVqDD2cUNNfkHPp1UhYtfRIq4RNtqzI/1d3wcDo/X8TSQ7O2AjlpnktZ0eu
         xvAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fKMqalkFUbiAm52d74qp8NTlNfZl7kBDyT/H8w+a0iw=;
        b=2fcTqnZ2rLzCkwmhzAbV3wF5SgExLk9nQCSjezZsVWundFvA7IP+bthTDkFrUGcUQa
         IuwhZi5E55OSXrICOQ3h4/ozVSkao2hudN36Y8DyZUwDRqb+FCvIW0O2sJYcVjB6sqp4
         SdPRT6BORVa9AmQBOgx38iTgvLVN9Mt6iLKVgcl4+uMyNbndQw0X/IcWl37q1nIX8wWc
         gvAUkLKgtnTy5Vi2BFFfWInxO33zxdwtkFMvRl+XFvI5iw7s99Hh7Isl0gK+mumYNhk7
         IgaHSAIaooXxh6IQyniK1WPUsnIfBq2HJJGVFsv22NOUPYzWgdFOHNIWqMaeQiqAvsl8
         Z+OA==
X-Gm-Message-State: AOAM533RQh2uUO5GY/ryL8KqN0q7Nw2nYT71BvOLIaZAaHiR/v6hvRZp
        V05jD5kufgA4K4i/HUv3kSlDo3lsP5OzgsfWnl7LmA==
X-Google-Smtp-Source: ABdhPJx+AHyjNZEcLaNOHt40wYewUZlhBAVymIRrG9fiU8KZ7xrvCxAnLEQgHR9u8oqgwGzLsVTavUT6WA7e/pLozZo=
X-Received: by 2002:a4a:a34d:: with SMTP id u13mr19960391ool.53.1633972232105;
 Mon, 11 Oct 2021 10:10:32 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000030293b05c39afd6f@google.com> <20210602230054.vyqama2q3koc4bpo@treble>
 <527ad07e-eec2-a211-03e7-afafe5196100@linux.intel.com> <YLjZYvXnuPnbXzOm@hirez.programming.kicks-ass.net>
 <20210603133914.j2aeadmvhncnlk5q@treble> <0b71d4f9-f707-3d39-c358-7c06c5689a9d@linux.intel.com>
 <YWQ3AzF+q2xeyQ/p@google.com> <20211011104319.7c6125cb@gandalf.local.home>
In-Reply-To: <20211011104319.7c6125cb@gandalf.local.home>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 11 Oct 2021 19:10:20 +0200
Message-ID: <CACT4Y+Zx77Oe8TOuFvXcqLPg-GKf9VqUoq_e72rvtJgh+cCS4g@mail.gmail.com>
Subject: Re: [syzbot] KASAN: stack-out-of-bounds Read in profile_pc
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Lee Jones <lee.jones@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        syzbot <syzbot+84fe685c02cd112a2ac3@syzkaller.appspotmail.com>,
        bp@alien8.de, hpa@zytor.com, inglorion@google.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        x86@kernel.org, Andy Lutomirski <luto@kernel.org>, tkjos@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Oct 2021 at 16:43, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Mon, 11 Oct 2021 14:07:15 +0100
> Lee Jones <lee.jones@linaro.org> wrote:
>
> > On Thu, 03 Jun 2021, Andi Kleen wrote:
> >
> > >
> > > > True, ftrace does have function profiling (function_profile_enabled).
> > > >
> > > > Steve, is there a way to enable that on the kernel cmdline?
> > >
> > > That's not really comparable. function profiling has a lot more overhead.
> > > Also there is various code which has ftrace instrumentation disabled.
> > >
> > > I don't think why you want to kill the old profiler. It's rarely used, but
> > > when you need it usually works. It's always good to have simple fall backs.
> > > And it's not that it's a lot of difficult code.
> >
> > sysbot is still sending out reports on this:
> >
> >   https://syzkaller.appspot.com/bug?id=00c965d957410afc0d40cac5343064e0a98b9ecd
> >
> > Are you guys still planning on sending out a fix?
> >
> > Is there anything I can do to help?
> >
>
> According to the above:
>
> ==================================================================
> BUG: KASAN: stack-out-of-bounds in profile_pc+0xa4/0xe0 arch/x86/kernel/time.c:42
> Read of size 8 at addr ffffc90001c0f7a0 by task systemd-udevd/12323
>
> CPU: 1 PID: 12323 Comm: systemd-udevd Not tainted 5.13.0-rc3-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  <IRQ>
>  __dump_stack lib/dump_stack.c:79 [inline]
>  dump_stack+0x202/0x31e lib/dump_stack.c:120
>  print_address_description+0x5f/0x3b0 mm/kasan/report.c:233
>  __kasan_report mm/kasan/report.c:419 [inline]
>  kasan_report+0x15c/0x200 mm/kasan/report.c:436
>  profile_pc+0xa4/0xe0 arch/x86/kernel/time.c:42
>  profile_tick+0xcd/0x120 kernel/profile.c:408
>  tick_sched_handle kernel/time/tick-sched.c:227 [inline]
>  tick_sched_timer+0x287/0x420 kernel/time/tick-sched.c:1373
>  __run_hrtimer kernel/time/hrtimer.c:1537 [inline]
>  __hrtimer_run_queues+0x4cb/0xa60 kernel/time/hrtimer.c:1601
>  hrtimer_interrupt+0x3b3/0x1040 kernel/time/hrtimer.c:1663
>  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1089 [inline]
>  __sysvec_apic_timer_interrupt+0xf9/0x270 arch/x86/kernel/apic/apic.c:1106
>  sysvec_apic_timer_interrupt+0x8c/0xb0 arch/x86/kernel/apic/apic.c:1100
>
> And the code has:
>
>  profile_pc+0xa4/0xe0 arch/x86/kernel/time.c:42
>
> unsigned long profile_pc(struct pt_regs *regs)
> {
>         unsigned long pc = instruction_pointer(regs);
>
>         if (!user_mode(regs) && in_lock_functions(pc)) {
> #ifdef CONFIG_FRAME_POINTER
>                 return *(unsigned long *)(regs->bp + sizeof(long));
> #else
>                 unsigned long *sp = (unsigned long *)regs->sp;
>                 /*
>                  * Return address is either directly at stack pointer
>                  * or above a saved flags. Eflags has bits 22-31 zero,
>                  * kernel addresses don't.
>                  */
>                 if (sp[0] >> 22)
>                         return sp[0];  <== line 42
>                 if (sp[1] >> 22)
>                         return sp[1];
> #endif
>         }
>         return pc;
> }
> EXPORT_SYMBOL(profile_pc);
>
>
> It looks to me that the profiler is doing a trick to read the contents of
> the stack when the interrupt went off, but this triggers the KASAN
> instrumentation to think it's a mistake when it's not. aka "false positive".
>
> How does one tell KASAN that it wants to go outside the stack, because it
> knows what its doing?
>
> Should that just be converted to a "copy_from_kernel_nofault()"? That is,
> does this fix it? (not even compiled tested)
>
> -- Steve
>
>
> diff --git a/arch/x86/kernel/time.c b/arch/x86/kernel/time.c
> index e42faa792c07..cc6ec29aa14d 100644
> --- a/arch/x86/kernel/time.c
> +++ b/arch/x86/kernel/time.c
> @@ -34,15 +34,18 @@ unsigned long profile_pc(struct pt_regs *regs)
>                 return *(unsigned long *)(regs->bp + sizeof(long));
>  #else
>                 unsigned long *sp = (unsigned long *)regs->sp;
> +               unsigned long retaddr;
>                 /*
>                  * Return address is either directly at stack pointer
>                  * or above a saved flags. Eflags has bits 22-31 zero,
>                  * kernel addresses don't.
>                  */
> -               if (sp[0] >> 22)
> -                       return sp[0];
> -               if (sp[1] >> 22)
> -                       return sp[1];
> +               if (!copy_from_kernel_nofault(&retaddr, sp, sizeof(long)) &&
> +                   retaddr >> 22)
> +                       return retaddr;
> +               if (!copy_from_kernel_nofault(&retaddr, sp + 1, sizeof(long)) &&
> +                   retaddr >> 22)
> +                       return retaddr;
>  #endif
>         }
>         return pc;



This looks like a fit for READ_ONCE_NOCHECK(). It's already used in a
number of similar places like unwinders:
E.g.:
https://elixir.bootlin.com/linux/v5.15-rc4/source/arch/x86/kernel/process.c#L984
https://elixir.bootlin.com/linux/v5.15-rc4/A/ident/READ_ONCE_NOCHECK
