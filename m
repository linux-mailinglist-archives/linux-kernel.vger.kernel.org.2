Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 475DC319E74
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 13:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbhBLMbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 07:31:33 -0500
Received: from foss.arm.com ([217.140.110.172]:36470 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230396AbhBLMbV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 07:31:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC7491063;
        Fri, 12 Feb 2021 04:30:35 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0FD9B3F719;
        Fri, 12 Feb 2021 04:30:33 -0800 (PST)
Date:   Fri, 12 Feb 2021 12:30:29 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Branislav Rankov <Branislav.Rankov@arm.com>,
        Marco Elver <elver@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v13 6/7] arm64: mte: Report async tag faults before
 suspend
Message-ID: <20210212123029.GA19585@e121166-lin.cambridge.arm.com>
References: <20210211153353.29094-1-vincenzo.frascino@arm.com>
 <20210211153353.29094-7-vincenzo.frascino@arm.com>
 <20210212120015.GA18281@e121166-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210212120015.GA18281@e121166-lin.cambridge.arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 12, 2021 at 12:00:15PM +0000, Lorenzo Pieralisi wrote:
> On Thu, Feb 11, 2021 at 03:33:52PM +0000, Vincenzo Frascino wrote:
> > When MTE async mode is enabled TFSR_EL1 contains the accumulative
> > asynchronous tag check faults for EL1 and EL0.
> > 
> > During the suspend/resume operations the firmware might perform some
> > operations that could change the state of the register resulting in
> > a spurious tag check fault report.
> > 
> > Report asynchronous tag faults before suspend and clear the TFSR_EL1
> > register after resume to prevent this to happen.
> > 
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> > ---
> >  arch/arm64/include/asm/mte.h |  4 ++++
> >  arch/arm64/kernel/mte.c      | 20 ++++++++++++++++++++
> >  arch/arm64/kernel/suspend.c  |  3 +++
> >  3 files changed, 27 insertions(+)
> > 
> > diff --git a/arch/arm64/include/asm/mte.h b/arch/arm64/include/asm/mte.h
> > index 43169b978cd3..33e88a470357 100644
> > --- a/arch/arm64/include/asm/mte.h
> > +++ b/arch/arm64/include/asm/mte.h
> > @@ -41,6 +41,7 @@ void mte_sync_tags(pte_t *ptep, pte_t pte);
> >  void mte_copy_page_tags(void *kto, const void *kfrom);
> >  void flush_mte_state(void);
> >  void mte_thread_switch(struct task_struct *next);
> > +void mte_suspend_enter(void);
> >  void mte_suspend_exit(void);
> >  long set_mte_ctrl(struct task_struct *task, unsigned long arg);
> >  long get_mte_ctrl(struct task_struct *task);
> > @@ -66,6 +67,9 @@ static inline void flush_mte_state(void)
> >  static inline void mte_thread_switch(struct task_struct *next)
> >  {
> >  }
> > +static inline void mte_suspend_enter(void)
> > +{
> > +}
> >  static inline void mte_suspend_exit(void)
> >  {
> >  }
> > diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
> > index f5aa5bea6dfe..de905102245a 100644
> > --- a/arch/arm64/kernel/mte.c
> > +++ b/arch/arm64/kernel/mte.c
> > @@ -258,12 +258,32 @@ void mte_thread_switch(struct task_struct *next)
> >  	mte_check_tfsr_el1();
> >  }
> >  
> > +void mte_suspend_enter(void)
> > +{
> > +	if (!system_supports_mte())
> > +		return;
> > +
> > +	/*
> > +	 * The barriers are required to guarantee that the indirect writes
> > +	 * to TFSR_EL1 are synchronized before we report the state.
> > +	 */
> > +	dsb(nsh);
> > +	isb();
> > +
> > +	/* Report SYS_TFSR_EL1 before suspend entry */
> > +	mte_check_tfsr_el1();
> > +}
> > +
> >  void mte_suspend_exit(void)
> >  {
> >  	if (!system_supports_mte())
> >  		return;
> >  
> >  	update_gcr_el1_excl(gcr_kernel_excl);
> > +
> > +	/* Clear SYS_TFSR_EL1 after suspend exit */
> > +	write_sysreg_s(0, SYS_TFSR_EL1);
> 
> AFAICS it is not needed, it is done already in __cpu_setup() (that is
> called by cpu_resume on return from cpu_suspend() from firmware).
> 
> However, I have a question. We are relying on context switch to set
> sctlr_el1_tfc0 right ? If that's the case, till the thread resuming from
> low power switches context we are running with SCTLR_EL1_TCF0 not
> reflecting the actual value.

Forget this, we obviously restore sctlr_el1 on resume (cpu_do_resume()).

With the line above removed:

Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

> Just making sure that I understand it correctly, I need to check the
> resume from suspend-to-RAM path, it is something that came up with perf
> save/restore already in the past.
> 
> Lorenzo
> 
> > +
> >  }
> >  
> >  long set_mte_ctrl(struct task_struct *task, unsigned long arg)
> > diff --git a/arch/arm64/kernel/suspend.c b/arch/arm64/kernel/suspend.c
> > index a67b37a7a47e..25a02926ad88 100644
> > --- a/arch/arm64/kernel/suspend.c
> > +++ b/arch/arm64/kernel/suspend.c
> > @@ -91,6 +91,9 @@ int cpu_suspend(unsigned long arg, int (*fn)(unsigned long))
> >  	unsigned long flags;
> >  	struct sleep_stack_data state;
> >  
> > +	/* Report any MTE async fault before going to suspend */
> > +	mte_suspend_enter();
> > +
> >  	/*
> >  	 * From this point debug exceptions are disabled to prevent
> >  	 * updates to mdscr register (saved and restored along with
> > -- 
> > 2.30.0
> > 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
