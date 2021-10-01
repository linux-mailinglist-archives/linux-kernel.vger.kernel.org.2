Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE0541EF2F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 16:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354199AbhJAOOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 10:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353676AbhJAOOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 10:14:36 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52CA8C061775
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 07:12:52 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id s11so9519397pgr.11
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 07:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BxBacXbcJ5I7c3S8YgU3IIQMGJegOvOW0G9N2XqLc3U=;
        b=ScRSqq9G//k9yo7kY0og/uCjLoFXL25JB3awzW/qGDT7d5zrKhXZo6nRbMYhksx+A3
         xN4UzDDWdjb2wCo2STDw4jhOS+E/iK89NWuongWmQx4dX9Xh8IXQVkD27yremTX8SL2q
         IaOPsnbfI95d5gZgmJEAS1axQQhLyHXUHpfplGaLXDyptnfxcC4Sd5Q60gxq60rPy2LQ
         7/WZzCusgYspPFVzmr84Sr0dnxyolI9oOAg7LMqVH32HPrlXLyMAHxVhU8Eyixyq6YAm
         omSUFqVDOKqMrLfRYF45cgJ40WtV7eqRqzGDW0HfOutDRH5Nfi3dw3HJ6nQY5IvYPyGx
         aSpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BxBacXbcJ5I7c3S8YgU3IIQMGJegOvOW0G9N2XqLc3U=;
        b=ZE/6KCKN+0fLzQpnnzHipGlMJKG9Tu9X9hz8SZt+9tO3SRbaJs8AqYOV5wZtX1QdLc
         ke1Wt/PyxqrGfIT19zKUYW/AJXanS1FinkYfdFUHFiLxzXqsA9uugkCXzI3L4Ivgsvfu
         SLLIZf8XT/fTlhytJ8cN2fsyAS+FussuDkFC4DjpykH2REoLTrQPqPR871ENvUn6R46I
         Lg1F2sxT7nFPu1m5/TJNBZi8INiHpEFIQ824irexm49h7mrWEEoPNfEsfPhvPw2yzmF3
         CE0bQZ4ITqdALBl+/wA4WFQuj7MUSpUU4wGmmLEsj98tfIoDYoiF9Y1IXQC0SP0zMhYD
         Tlug==
X-Gm-Message-State: AOAM5318KSSVq0pkLfJe5v9GGzO09rFrLEQX3MGU14R2w2OBiHGcb8ta
        XNbST3wloACUkHY293xJdw==
X-Google-Smtp-Source: ABdhPJw0O3c1bFGHj55zS03g8tfiLrdncSxfxK52QgAMVpmO/0ipU5TfqMLCkk64PhhnLVw8ruzWGw==
X-Received: by 2002:a63:a504:: with SMTP id n4mr7228982pgf.264.1633097571908;
        Fri, 01 Oct 2021 07:12:51 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id b3sm7354551pfv.191.2021.10.01.07.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 07:12:51 -0700 (PDT)
Date:   Fri, 1 Oct 2021 22:12:44 +0800
From:   Pingfan Liu <kernelfans@gmail.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yuichi Ito <ito-yuichi@fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 2/3] arm64: entry: refactor EL1 interrupt entry logic
Message-ID: <YVcXXCsRy0Nqz/AM@piliu.users.ipa.redhat.com>
References: <20210930131708.35328-1-kernelfans@gmail.com>
 <20210930131708.35328-3-kernelfans@gmail.com>
 <87r1d5rth9.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r1d5rth9.wl-maz@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 01, 2021 at 10:21:06AM +0100, Marc Zyngier wrote:
> On Thu, 30 Sep 2021 14:17:07 +0100,
> Pingfan Liu <kernelfans@gmail.com> wrote:
> > 
> > From: Mark Rutland <mark.rutland@arm.com>
> > 
> > Currently we distinguish IRQ and definitely-PNMI at entry/exit time
> > via the enter_el1_irq_or_nmi() and enter_el1_irq_or_nmi() helpers. In
> > subsequent patches we'll need to handle the two cases more distinctly
> > in the body of the exception handler.
> > 
> > To make this possible, this patch refactors el1_interrupt to be a
> > top-level dispatcher to separate handlers for the IRQ and PNMI cases,
> > removing the need for the enter_el1_irq_or_nmi() and
> > exit_el1_irq_or_nmi() helpers.
> > 
> > Note that since arm64_enter_nmi() calls __nmi_enter(), which
> > increments the preemt_count, we could never preempt when handling a
> > PNMI. We now only check for preemption in the IRQ case, which makes
> > this clearer.
> > 
> > There should be no functional change as a result of this patch.
> > 
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Marc Zyngier <maz@kernel.org>
> > Cc: Joey Gouly <joey.gouly@arm.com>
> > Cc: Sami Tolvanen <samitolvanen@google.com>
> > Cc: Julien Thierry <julien.thierry@arm.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Yuichi Ito <ito-yuichi@fujitsu.com>
> > Cc: Pingfan Liu <kernelfans@gmail.com>
> > Cc: linux-kernel@vger.kernel.org
> > To: linux-arm-kernel@lists.infradead.org
> > ---
> >  arch/arm64/kernel/entry-common.c | 44 ++++++++++++++++----------------
> >  1 file changed, 22 insertions(+), 22 deletions(-)
> > 
> > diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
> > index 32f9796c4ffe..5f1473319fb0 100644
> > --- a/arch/arm64/kernel/entry-common.c
> > +++ b/arch/arm64/kernel/entry-common.c
> > @@ -219,22 +219,6 @@ static void noinstr arm64_exit_el1_dbg(struct pt_regs *regs)
> >  		lockdep_hardirqs_on(CALLER_ADDR0);
> >  }
> >  
> > -static void noinstr enter_el1_irq_or_nmi(struct pt_regs *regs)
> > -{
> > -	if (IS_ENABLED(CONFIG_ARM64_PSEUDO_NMI) && !interrupts_enabled(regs))
> > -		arm64_enter_nmi(regs);
> > -	else
> > -		enter_from_kernel_mode(regs);
> > -}
> > -
> > -static void noinstr exit_el1_irq_or_nmi(struct pt_regs *regs)
> > -{
> > -	if (IS_ENABLED(CONFIG_ARM64_PSEUDO_NMI) && !interrupts_enabled(regs))
> > -		arm64_exit_nmi(regs);
> > -	else
> > -		exit_to_kernel_mode(regs);
> > -}
> > -
> >  static void __sched arm64_preempt_schedule_irq(void)
> >  {
> >  	lockdep_assert_irqs_disabled();
> > @@ -432,14 +416,19 @@ asmlinkage void noinstr el1h_64_sync_handler(struct pt_regs *regs)
> >  	}
> >  }
> >  
> > -static void noinstr el1_interrupt(struct pt_regs *regs,
> > -				  void (*handler)(struct pt_regs *))
> > +static __always_inline void
> > +__el1_pnmi(struct pt_regs *regs, void (*handler)(struct pt_regs *))
> >  {
> > -	write_sysreg(DAIF_PROCCTX_NOIRQ, daif);
> > -
> > -	enter_el1_irq_or_nmi(regs);
> > +	arm64_enter_nmi(regs);
> >  	do_interrupt_handler(regs, handler);
> > +	arm64_exit_nmi(regs);
> > +}
> >  
> > +static __always_inline void
> > +__el1_interrupt(struct pt_regs *regs, void (*handler)(struct pt_regs *))
> > +{
> > +	enter_from_kernel_mode(regs);
> > +	do_interrupt_handler(regs, handler);
> >  	/*
> >  	 * Note: thread_info::preempt_count includes both thread_info::count
> >  	 * and thread_info::need_resched, and is not equivalent to
> > @@ -448,8 +437,19 @@ static void noinstr el1_interrupt(struct pt_regs *regs,
> >  	if (IS_ENABLED(CONFIG_PREEMPTION) &&
> >  	    READ_ONCE(current_thread_info()->preempt_count) == 0)
> >  		arm64_preempt_schedule_irq();
> > +	exit_to_kernel_mode(regs);
> > +}
> > +
> > +static void noinstr el1_interrupt(struct pt_regs *regs,
> > +				  void (*handler)(struct pt_regs *))
> > +{
> > +	write_sysreg(DAIF_PROCCTX_NOIRQ, daif);
> > +
> > +	if (IS_ENABLED(CONFIG_ARM64_PSEUDO_NMI) && !interrupts_enabled(regs))
> > +		__el1_pnmi(regs, handler);
> > +	else
> > +		__el1_interrupt(regs, handler);
> >  
> > -	exit_el1_irq_or_nmi(regs);
> 
> nit: spurious blank line.
> 
OK, I will fix it.

> >  }
> >  
> >  asmlinkage void noinstr el1h_64_irq_handler(struct pt_regs *regs)
> 
> With Mark's remark addressed,
> 
> Reviewed-by: Marc Zyngier <maz@kernel.org>
> 
Thanks,

	Pingfan
