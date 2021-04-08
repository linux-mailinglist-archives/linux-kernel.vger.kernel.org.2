Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CEB53587CC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 17:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbhDHPGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 11:06:47 -0400
Received: from foss.arm.com ([217.140.110.172]:50700 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231990AbhDHPGq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 11:06:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD7CAD6E;
        Thu,  8 Apr 2021 08:06:34 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.24.62])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 21EBB3F694;
        Thu,  8 Apr 2021 08:06:32 -0700 (PDT)
Date:   Thu, 8 Apr 2021 16:06:23 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH] arm64: mte: Move MTE TCF0 check in entry-common
Message-ID: <20210408150612.GA37165@C02TD0UTHF1T.local>
References: <20210408143723.13024-1-vincenzo.frascino@arm.com>
 <20210408145604.GB18211@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210408145604.GB18211@willie-the-truck>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2021 at 03:56:04PM +0100, Will Deacon wrote:
> On Thu, Apr 08, 2021 at 03:37:23PM +0100, Vincenzo Frascino wrote:
> > The check_mte_async_tcf macro sets the TIF flag non-atomically. This can
> > race with another CPU doing a set_tsk_thread_flag() and the flag can be
> > lost in the process.
> 
> Actually, it's all the *other* flags that get lost!
> 
> > Move the tcf0 check to enter_from_user_mode() and clear tcf0 in
> > exit_to_user_mode() to address the problem.
> > 
> > Note: Moving the check in entry-common allows to use set_thread_flag()
> > which is safe.
> > 
> > Fixes: 637ec831ea4f ("arm64: mte: Handle synchronous and asynchronous
> > tag check faults")
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Reported-by: Will Deacon <will@kernel.org>
> > Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> > ---
> >  arch/arm64/include/asm/mte.h     |  8 ++++++++
> >  arch/arm64/kernel/entry-common.c |  6 ++++++
> >  arch/arm64/kernel/entry.S        | 30 ------------------------------
> >  arch/arm64/kernel/mte.c          | 25 +++++++++++++++++++++++--
> >  4 files changed, 37 insertions(+), 32 deletions(-)
> > 
> > diff --git a/arch/arm64/include/asm/mte.h b/arch/arm64/include/asm/mte.h
> > index 9b557a457f24..188f778c6f7b 100644
> > --- a/arch/arm64/include/asm/mte.h
> > +++ b/arch/arm64/include/asm/mte.h
> > @@ -31,6 +31,8 @@ void mte_invalidate_tags(int type, pgoff_t offset);
> >  void mte_invalidate_tags_area(int type);
> >  void *mte_allocate_tag_storage(void);
> >  void mte_free_tag_storage(char *storage);
> > +void check_mte_async_tcf0(void);
> > +void clear_mte_async_tcf0(void);
> >  
> >  #ifdef CONFIG_ARM64_MTE
> >  
> > @@ -83,6 +85,12 @@ static inline int mte_ptrace_copy_tags(struct task_struct *child,
> >  {
> >  	return -EIO;
> >  }
> > +void check_mte_async_tcf0(void)
> > +{
> > +}
> > +void clear_mte_async_tcf0(void)
> > +{
> > +}
> >  
> >  static inline void mte_assign_mem_tag_range(void *addr, size_t size)
> >  {
> > diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
> > index 9d3588450473..837d3624a1d5 100644
> > --- a/arch/arm64/kernel/entry-common.c
> > +++ b/arch/arm64/kernel/entry-common.c
> > @@ -289,10 +289,16 @@ asmlinkage void noinstr enter_from_user_mode(void)
> >  	CT_WARN_ON(ct_state() != CONTEXT_USER);
> >  	user_exit_irqoff();
> >  	trace_hardirqs_off_finish();
> > +
> > +	/* Check for asynchronous tag check faults in user space */
> > +	check_mte_async_tcf0();
> >  }
> 
> Is enter_from_user_mode() always called when we enter the kernel from EL0?
> afaict, some paths (e.g. el0_irq()) only end up calling it if
> CONTEXT_TRACKING or TRACE_IRQFLAGS are enabled.

Currently everything that's in {enter,exit}_from_user_mode() only
matters when either CONTEXT_TRACKING or TRACE_IRQFLAGS is selected (and
expands to an empty stub otherwise).

We could drop the ifdeffery in user_{enter,exit}_irqoff() to have them
called regardless, or add CONFIG_MTE to the list.

> >  asmlinkage void noinstr exit_to_user_mode(void)
> >  {
> > +	/* Ignore asynchronous tag check faults in the uaccess routines */
> > +	clear_mte_async_tcf0();
> > +
> 
> and this one seems to be called even less often.

This is always done in ret_to_user, so (modulo ifdeferry above) all
returns to EL0 call this.

Thanks,
Mark.
