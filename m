Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6A6444DFD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 05:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbhKDEpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 00:45:42 -0400
Received: from mga05.intel.com ([192.55.52.43]:51231 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229477AbhKDEpl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 00:45:41 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10157"; a="317850208"
X-IronPort-AV: E=Sophos;i="5.87,207,1631602800"; 
   d="scan'208";a="317850208"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2021 21:43:03 -0700
X-IronPort-AV: E=Sophos;i="5.87,207,1631602800"; 
   d="scan'208";a="667765567"
Received: from rabentle-desk1.amr.corp.intel.com ([10.255.230.52])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2021 21:42:59 -0700
Message-ID: <ed17c104b55646d5ffd367a56317ab8e85771ee4.camel@linux.intel.com>
Subject: Re: [STACK DUMP][5.16-rc?] from (cpufreq: intel_pstate: Process HWP
 Guaranteed change notification)
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, pablomh@gmail.com,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Date:   Wed, 03 Nov 2021 21:42:54 -0700
In-Reply-To: <CAHk-=wi63LDzMV1sSiPuH8q38tMZ0_b+w9bUVW=P_O1+rkW28A@mail.gmail.com>
References: <20211103163340.435ba5b1@gandalf.local.home>
         <CAHk-=wi63LDzMV1sSiPuH8q38tMZ0_b+w9bUVW=P_O1+rkW28A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-11-03 at 14:58 -0700, Linus Torvalds wrote:
> On Wed, Nov 3, 2021 at 1:33 PM Steven Rostedt <rostedt@goodmis.org>
> wrote:
> > 
> > The RIP of cpuidle_enter_state+0xd6/0x3a0 gives me in gdb:
> 
> That's not actually the error address - it's not an oops. That's just
> the register data at the interrupt entry.
> 
> The error was that triggered this was that
> 
>     unchecked MSR access error:
>         WRMSR to 0x773 (tried to write 0x0000000000000000)
>         at rIP: 0xffffffffab06e824 (native_write_msr+0x4/0x20)
> 

MSR 773 access must be protected by a CPUID flag. Sorry I missed this
check during offline path.

diff --git a/drivers/cpufreq/intel_pstate.c
b/drivers/cpufreq/intel_pstate.c
index 349ddbaef796..4184073be2c4 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1621,7 +1621,8 @@ static void
intel_pstate_disable_hwp_interrupt(struct cpudata *cpudata)
        unsigned long flags;
 
        /* wrmsrl_on_cpu has to be outside spinlock as this can result
in IPC */
-       wrmsrl_on_cpu(cpudata->cpu, MSR_HWP_INTERRUPT, 0x00);
+       if (boot_cpu_has(X86_FEATURE_HWP_NOTIFY))
+               wrmsrl_on_cpu(cpudata->cpu, MSR_HWP_INTERRUPT, 0x00);
 
        spin_lock_irqsave(&hwp_notify_lock, flags);
        if (cpumask_test_and_clear_cpu(cpudata->cpu,
&hwp_intr_enable_mask))


I will submit a patch to fix this.

Thanks,
Srinivas

> and then it prints the stack frame - because we shouldn't be doing
> random MSR writes.
> 
> And part of printing the stack frame is printing the register state
> at
> kernel entries when switching to an interrupt or exception stack.
> 
> So that RIP you point to is not really interesting, and it looks like
> it's an entirely random harmless instruction, it's just that it is
> preceded by that
> 
>         sti
>         nopw
> 
> so it's not surprising that it's an interrupt point, because it's
> exactly one instruction after interrupts were enabled on that CPU
> (the
> one instruction being the sti shadow that itself doesn't take
> interrupts).
> 
> So cpuidle_enter_state() itself is entirely harmless, and you see
> that
> in the call chain presumably simply because the CPU was idle when the
> interrupt happened. Again, that's a very reasonable place for an
> interrupt to happen.
> 
> End result: all of this is simply due to an unexpected MSR write, and
> the real issue is that interrupt from an IPI that caused the WRMSR
> write on another CPU:
> 
>     __wrmsr_on_cpu+0x33/0x40
>     flush_smp_call_function_queue+0x122/0x1a0
>     __sysvec_call_function_single+0x29/0xc0
>     sysvec_call_function_single+0x9d/0xd0
> 
> and the rest of the call chain is just noise from "whatever that CPU
> happened to do when it got the IPI".
> 
> You don't get the call chain of whatever actually did the IPI, I'm
> afraid. That's the actual _cause_ of all this, but that happens on
> another CPU entirely.
> 
> > I bisected it down to:
> > 
> >  57577c996d73 ("cpufreq: intel_pstate: Process HWP Guaranteed
> > change notification")
> > 
> > Removing the commit makes the issue go away. Adding it back brings
> > it back'
> 
> That commit does various odd things.
> 
> The code seems to depend on the 'hwp_notify_lock' spinlock, but then
> it does some work outside that locked region (exactly because that
> work triggers an interrupt that needs that lock):
> 
>       wrmsrl_on_cpu(cpudata->cpu, MSR_HWP_INTERRUPT, 0x00);
> 
> and that's exactly what will then warn because that MSR hasn't been
> enabled on that CPU.
> 
> But it also does randomly do some READ_ONCE/WRITE_ONCE magic that all
> seems entirely bogus. Those values should be protected by the lock.
> 
> The way it cancels delayed work is also very questionable: it does
> 
>         spin_lock_irqsave(&hwp_notify_lock, flags);
>         if (cpumask_test_and_clear_cpu(cpudata->cpu,
> &hwp_intr_enable_mask))
>                 cancel_delayed_work(&cpudata->hwp_notify_work);
>         spin_unlock_irqrestore(&hwp_notify_lock, flags);
> 
> but if the delayed work was already started on that cpu, then it will
> continue running concurrently, even if the caller now thinks it's all
> disabled.
> 
> You need the "sync" version to make sure the work is also waited on,
> but you can't do that under the spinlock that the work in question
> may
> need, of course.
> 
> > So I'm guessing that this commit calls some code that does not
> > expect to be
> > called on powering off, at least in debug mode, and is triggering
> > this
> > stack dump. Probably because there was some static call or
> > something that
> > isn't shutdown properly.
> 
> It actually looks more direct than that to me: the code literally
> seems to do that wrmsrl_on_cpu() that triggers the IPI that actually
> causes the unchecked MSR write.
> 
> I don't know this hardware, and I don't know that code, but there are
> certainly a few red flags here.
> 
> Srinivas?
> 

>               Linus


