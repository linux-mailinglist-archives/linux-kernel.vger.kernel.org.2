Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E75B234B9E8
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 23:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbhC0WUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 18:20:53 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34902 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbhC0WU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 18:20:29 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616883627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FlQQBMnnP/oY7YaWuWl6wKHl/QvLMioKgOuHapxDvv8=;
        b=FUGmc27I4NDHxhWUWkGZbMcmJ6glRHVajdOKtcNvOsHySqD97RLqBeNbn8TzUVghXqLl4B
        y4jtQ8nZB8ZTiaQ1RIvsm0wuHUBJuQTGcvFaiQhTgRPELkihkv4IIuNvio7Z2ZPAJW20Zj
        cSO5+tOx3ra3zXPEXEzenef/iBB/ViGUa3q21o8mhmoWseGC7R4c4u0+68HUTFhd/YGqzk
        blLb+nuvRsmkXLKZlnqg53wXWR6V17rPtlp2SIzzlhNQJd3QhePGL6YdJW6M7dV3H+NJaP
        ybC/NpvtHvnVj3+vb3zNNC2fol8RpXDfts91lp5opN8kzR5/rlK81XgFZmREzQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616883627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FlQQBMnnP/oY7YaWuWl6wKHl/QvLMioKgOuHapxDvv8=;
        b=kHMNeOF6/3uHvLE2E7N3FecPfJgBq2lGEgHOppKS9ECBjnmizUeflMpPkvoD4klSo7EblB
        RFZUU8ZqwwBEACCA==
To:     Len Brown <lenb@kernel.org>, Andy Lutomirski <luto@kernel.org>
Cc:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@kernel.org>,
        X86 ML <x86@kernel.org>, "Brown\, Len" <len.brown@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Liu\, Jing2" <jing2.liu@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Documentation List <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v4 22/22] x86/fpu/xstate: Introduce boot-parameters to control state component support
In-Reply-To: <CAJvTdKmdMfD4BddMJs4iwvHWRSv4PV7Dh2vxjM57UJ3pw5UJDQ@mail.gmail.com>
References: <20210221185637.19281-1-chang.seok.bae@intel.com> <20210221185637.19281-23-chang.seok.bae@intel.com> <871rc9bl3v.fsf@nanos.tec.linutronix.de> <CAJvTdKkOKOgnmvAiPS6mWVoyAggbOB6hBOqb_tcHYDe8+-X+FQ@mail.gmail.com> <CALCETrWOc7wwW=KY2dGJGy9k5Ag=KhkdGGTDZMvgRHgyQ5fDjQ@mail.gmail.com> <CAJvTdK=OGALDso0H+asjgkjD_VaPNZzm+LpV+msM_i5aVUm_qw@mail.gmail.com> <CALCETrXky0RuA5WeQ0Mxjs+e4ywk1A7vmpBxqCo=PTSBzUsz-g@mail.gmail.com> <CAJvTdK=_G11phL6=9Ri41fJQvhRNopok_oktgvRjTM0v6ojcbg@mail.gmail.com> <CALCETrX-34QqeVLjX39ZAD+4Y6XkZ3=bPEtEPxTi0YHvLgBKig@mail.gmail.com> <CAJvTdKmdMfD4BddMJs4iwvHWRSv4PV7Dh2vxjM57UJ3pw5UJDQ@mail.gmail.com>
Date:   Sat, 27 Mar 2021 23:20:27 +0100
Message-ID: <87r1k0ck7o.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Len,

On Sat, Mar 27 2021 at 00:53, Len Brown wrote:
>> 3.3 RECOMMENDATIONS FOR SYSTEM SOFTWARE
>>
>> System software may disable use of Intel AMX by clearing XCR0[18:17],
>> by clearing CR4.OSXSAVE, or by setting
>> IA32_XFD[18]. It is recommended that system software initialize AMX
>> state (e.g., by executing TILERELEASE)
>> before doing so. This is because maintaining AMX state in a
>> non-initialized state may have negative power and
>> performance implications.
>
> I agree that the wording here about disabling AMX is ominous.

Which is what I pointed out 7 days ago already, but that got lost in the
ABI and command line noise... Thanks Andy for bringing it back!

> The hardware initializes with AMX disabled.
> The kernel probes AMX, enables it in XCR0, and keeps it enabled.
>
> Initially, XFD is "armed" for all tasks.
> When a task accesses AMX state, #NM fires, we allocate a context
> switch buffer, and we "disarm" XFD for that task.
> As we have that buffer in-hand for the lifetime of the task, we never
> "arm" XFD for that task again.
>
> XFD is context switched, and so the next time it is set, is when we
> are restoring some other task's state.
>
> n.b. I'm describing the Linux flow.  The VMM scenario is a little different.
>
>> Since you reviewed the patch set, I assume you are familiar with how
>> Linux manages XSTATE.  Linux does *not* eagerly load XSTATE on context
>> switch.  Instead, Linux loads XSTATE when the kernel needs it loaded
>> or before executing user code.  This means that the kernel can (and
>> does, and it's a performance win) execute kernel thread code and/or go
>> idle, *including long-term deep idle*, with user XSTATE loaded.
>
> Yes, this scenario is clear.
>
> There are several cases.
>
> 1. Since TMM registers are volatile, a routine using TMM that wants
> them to persist across a call must save them,
>     and will TILERELEASE before invoking that call.  That is the
> calling convention,
>     and I expect that if it is not followed, debugging (of tools) will
> occur until it is.
>
>     The only way for a user program's XSTATE to be present during the
> kernel's call to idle
>     is if it sleep via a system call when no other task wants to run
> on that CPU.
>
>     Since system calls are calls, in this case, AMX INIT=1 during
>     idle.

What is the guarantee for that? A calling convention?

That's uninteresting because that's only the recommended and desired
state and not the guaranteed state.

>     All deep C-state are enabled, the idle CPU is able to contribute
> it's maximum turbo buget to its peers.
>
> 2. A correct program with live TMM registers takes an interrupt, and
> we enter the kernel AMX INIT=0.
>     Yes, we will enter the syscall at the frequency of the app (like
> we always do).

That's about interrupts not syscalls and I assume this should be all
s/syscall/interrupt/ for the whole #2 including 2a

>     Yes, turbo frequency may be limited by the activity of this
> processor and its peers (like it always is)
>
>    2a. If we return to the same program, then depending on how long
> the syscall runs, we may execute
>          the program and the system call code at a frequency lower
> than we might if AMX INIT=1 at time of interrupt.

So the frequency effect is relevant for the duration of the interrupt
and the eventually appended soft interrupt, right?

The program state is uninteresting because even if the kernel would
do XSAVES, TILERELEASE on interrupt entry then it would restore the
state before returning and then the program would have the same
conditions as before the interrupt.

>    2b. If we context switch to a task that has AMX INIT=1, then any
> AMX-imposed limits on turbo
>          are immediately gone.

Immediately on context switch? Definitely not.

      switch_to(prev, next)
        XSAVES(prev)
        eventually set XFD[18]

The point where AMX INIT=1 of 'next' becomes relevant is on return to
user space where XRSTORS happens. Up to that point AMX INIT=0 stays in
effect.

Now what guarantees that 'next' is returning to user space immediately?

Nothing.

If it's a user task this can be a wakeup for whatever which might cause
another wait depending on the callchain that task is in. It can be
preempted before reaching XRSTORS which is the point that matters to
flip the AMX INIT state back to 1.

It can be a kernel task or a chain of kernel tasks with arbitrary
runtime.

As a consequence the scheduler might migrate 'prev' from CPU_A to CPU_L
and what happens to that state on CPU_A? Does it magically move along
with 'prev' to CPU_L? I can't see how, but what do I know about magic.

So now the chain of kernel tasks finishes and there is nothing to do,
CPU_A goes idle with AMX INIT=0, which prevents the CPU from going deep,
drains power, can't contribute to the turbo state or whatever undesired
side effects that has.

You can get the same effect not only by device interrupts but also by
regular task migration, ptrace, breakpoints, any form of traps,
exception the task triggers in user space, user space freezing, kill -9
and .....

> 3. A buggy or purposely bogus program is fully empowered to violate
> the programming conventions.
>     Say such a program called a long sleep, and nothing else wanted to
> run on that CPU, so the kernel
>     went idle with AMX INIT=0.  Indeed, this could retard the core
> from getting into the deepest available
>     C-state, which could impact the turbo budget of neighboring cores.
> However, if that were some kind
>     of DOS, it would be simpler and more effective to simply hog a CPU
> by running code.  Also, as soon
>     as another thread switches in with INIT=1, there is no concept of
> AMX frequency caps. (see note for 2b)

It's irrelevant whether this is intentionally buggy or not. It's equally
irrelevant whether this is a stupid attempt of DOS or not.

What's relevant is that this has undesired side effects of various
sorts.

> I do not see a situation where the kernel needs to issue TILERELEASE
> (though a VMM likely would).

So #3 does not qualify for you? Interesting POV.

> What did I miss?

See #2.b

What's the actual downside of issuing TILERELEASE conditionally
depending on prev->AMX INIT=0? Is it slooooow or what's the real
problem here?

Thanks,

        tglx
