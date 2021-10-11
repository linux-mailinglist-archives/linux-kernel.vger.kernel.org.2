Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8FF428B04
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 12:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235966AbhJKKtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 06:49:36 -0400
Received: from foss.arm.com ([217.140.110.172]:44616 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231240AbhJKKte (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 06:49:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C65FBED1;
        Mon, 11 Oct 2021 03:47:34 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.22.9])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B56E43F66F;
        Mon, 11 Oct 2021 03:47:32 -0700 (PDT)
Date:   Mon, 11 Oct 2021 11:47:29 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [GIT PULL] arm64 fixes for 5.15-rc5
Message-ID: <20211011104729.GB1421@C02TD0UTHF1T.local>
References: <YWCPyK+xotTgUMy/@arm.com>
 <CAHk-=whWZ4OxfKQwKVrRc-E9=w-ygKdVFn_HcAMW-DW8SgranQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whWZ4OxfKQwKVrRc-E9=w-ygKdVFn_HcAMW-DW8SgranQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

[adding Paul and Peter, just in case we need to discuss the RCU and
accounting bits further]

On Fri, Oct 08, 2021 at 01:25:51PM -0700, Linus Torvalds wrote:
> On Fri, Oct 8, 2021 at 11:37 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
> >
> > Pingfan Liu (2):
> >       kernel/irq: make irq_{enter,exit}() in handle_domain_irq() arch optional
> >       arm64: entry: avoid double-accounting IRQ RCU entry
> 
> Ugh. This is *really* ugly. And it seems to be going exactly the wrong way.
> 
> I read the commit descriptions, and it still doesn't answer the
> fundamental question of why arm64 needs to do the accounting in
> arch-specific code, and disable the generic code.
> 
> It says
> 
>     To fix this, we must perform all the accounting from the architecture
>     code. We prevent the IRQ domain code from performing any accounting by
>     selecting HAVE_ARCH_IRQENTRY, and must call irq_enter_rcu() and
>     irq_exit_rcu() around invoking the root IRQ handler.
> 
> but at no point does it actually explain *why* all the accounting
> needs to be done by the architecture code.

Sorry; I agree that commit messages don't explain this thoroughly. I can
go and rework the commit messages to clarify things, if you'd like?

The TL;DR is that a bunch of constraints conspire such that we can't
defer accounting things to the irqdomain or irqchip code without making
this even more complicated/fragile, and many architectures get this
subtly wrong today -- it's not that arm64 is necessarily much different
from other architectures using this code, just that we're trying to
solve this first.

More specifically, the problem here is the combination of:

* During entry, rcu_irq_enter() must be called *before*
  trace_hardirqs_off_finish(), because the latter needs RCU to be
  watching, but we need to have informed lockdep before poking RCU or
  lockdep will complain withing the RCU code. To handle that,
  kernel/entry/common.c and arch/arm64/kernel/entry-common.c have the
  sequence:

  lockdep_hardirqs_off(CALLER_ADDR0);
  rcu_irq_enter(): // or rcu_irq_enter_check_tick();
  trace_hardirqs_off_finish();

  ... and since we don't want something to come in the middle of the
  sequence, we want those sandwiched together in a noinstr function
  called before we invoke the root irqchip's handler function.

  A bunch of architectures don't follow this sequence, and are
  potentially subtly broken today in some configurations.

  Note: the plan is to move arm64 over to the generic entry code, but
  that has no effect on this specific issue.

* rcu_irq_enter() must be called *precisely once* upon taking an
  interrupt exception, or we can end up mis-accounting quiescent periods
  as non-quiescent (since this maintains a nesting count in
  rcu_data::dynticks_nmi_nesting, checked by
  rcu_is_cpu_rrupt_from_idle()).

* Prior to these patches, we call rcu_irq_enter() at least twice on
  arm64, because the architectural entry code must call rcu_irq_enter()
  for the lockdep bits, then when we invoke the irqchip (e.g. GICv3), we
  do:

  gic_handle_irq()
    handle_domain_irq()
      irq_enter()
        rcu_irq_enter()
	irq_enter_rcu()

  ... and so if we take a sched clock IRQ and call
  rcu_sched_clock_irq(), rcu_is_cpu_rrupt_from_idle() may return false
  when it should return true(), and we don't decide to preempt the task,
  leading to stalls.

  Note that since irqchips can be chained (e.g. there can be a second
  interrupt controller fed into the GIC), handle_domain_irq() can be
  nested, so even if we somehow removed the accounting from arch code
  we'd need to handle the nested calls to handle_domain_irq() somehow.

  AFAICT it's far simpler to do that *once* outside of the irqchip code
  than it is to try to handle that nesting.

  Note that x86 doesn't use handle_domain_irq(), and just maps the raw
  irqnrs itself, and just calls irq_enter_rcu() when transitioning to
  the IRQ stack.

> Yes, yes, I read the previous paragraph. But why isn't the fix to just
> stop doing the double accounting in the arm64 specific code?

As above, that'd require moving *some* of the low-level entry logic into
the irqchip/irqdomain code, and handling nesting, which is *more*
fragile.

FWIW, we do need to fix the other architectures too, but that involves
more substantial rework to each of those (e.g. moving to generic entry),
since there are a bunch of problems today. The thinking was that this
gave a way to fix each of those on its own, then remove the old
behaviour.

Does that all make sense to you?

Thanks,
Mark.
