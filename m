Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2AA641EF2B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 16:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354175AbhJAOMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 10:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbhJAOMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 10:12:49 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09FEAC061775
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 07:11:05 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 133so9555911pgb.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 07:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=d2o0FjFopvFdwsziKDjoQ5s+SthIQq92m1QV/z5BumI=;
        b=j2OZ86E2ayMiEyIvA/YsR3EM5kUUa0lzdn8Q0E9EWyYlW50svMVqLS7u6M4dL+a0TY
         9I7XjSiFD03xC3wzliCK0YjkBGjhCeJ9ezcWBYBijnzl3DIztFiOziClQKFebub2tuxt
         IqjmQ1mrGgaot7NLgThaFPZfdtVThQ+jyPgxjSxkYfn4mlf0F+hM3Qf2JQilrPOkXsfQ
         bxpY/8HZPuc6OZdTcO+IqEWV5iGkLLe+KPh2/d1F8zinZnUWdPqjSTj7prw9Xt2H3C/n
         oGscZrXu5oPzmNtAIoA8Qe53qT3Es9hjQLjf1n1AlqljfpMsHJPUxWxdbkC/JpQ1rJzW
         2odA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d2o0FjFopvFdwsziKDjoQ5s+SthIQq92m1QV/z5BumI=;
        b=v3XGlATAr+PWqHUcON98BRc5TilrDgYVhSoKCuBtu3imO8cU3FKobeDL2tSs7cYl2y
         f79TpYMVqA+vT+5vrhM22nBJG1uXFhukdPEZ64EvC5R7ayuxjuQKh0js2plJDPv9yNYB
         uIADkEw58Cd0XYRXjLT+1kXHWgFlOfcx2XMuIo/rmZg0loS/VjPBYXFHMMz6xXZC4LKq
         ukISCsXbo4boGEmRuitw8iY2yHO9dyc/PZQ6hnnr6MUGknI/jrxYEJ5cD0oyaB8YCdDa
         9vLiGphSGfMRshcCqFHw66BXZTswFO1wbPDmlMz3oSzRNIrfiwWAaerE6l2yYrAzvfgq
         Hvjw==
X-Gm-Message-State: AOAM5338VJb1guU1DkbQ8X2QviH7vC1kuQ0UXisraIHe64khz+Aze4T6
        X75tZJTobOoNirEZJW5+OA==
X-Google-Smtp-Source: ABdhPJyyTpVxoy3Y26zMl+QXKKJKbV86jeo4hNDs5xDCVbZ5vADJPRpPlfNZqOFLM/TsLlX6wozJIw==
X-Received: by 2002:a62:5584:0:b0:44b:62ec:1ac1 with SMTP id j126-20020a625584000000b0044b62ec1ac1mr10482983pfb.2.1633097464561;
        Fri, 01 Oct 2021 07:11:04 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id m7sm6287061pgn.32.2021.10.01.07.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 07:11:03 -0700 (PDT)
Date:   Fri, 1 Oct 2021 22:10:57 +0800
From:   Pingfan Liu <kernelfans@gmail.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Joey Gouly <joey.gouly@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yuichi Ito <ito-yuichi@fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 3/3] arm64/entry-common: supplement irq accounting
Message-ID: <YVcW8aGUEQ249smu@piliu.users.ipa.redhat.com>
References: <20210930131708.35328-1-kernelfans@gmail.com>
 <20210930131708.35328-4-kernelfans@gmail.com>
 <20210930135314.GC18258@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210930135314.GC18258@lakrids.cambridge.arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2021 at 02:53:14PM +0100, Mark Rutland wrote:
> On Thu, Sep 30, 2021 at 09:17:08PM +0800, Pingfan Liu wrote:
> > At present, the irq entry/exit accounting, which is performed by
> > handle_domain_irq(), overlaps with arm64 exception entry code somehow.
> > 
> > By supplementing irq accounting on arm64 exception entry code, the
> > accounting in handle_domain_irq() can be dropped totally by selecting
> > the macro HAVE_ARCH_IRQENTRY.
> 
> I think we need to be more thorough and explain the specific problem and
> solution. How about we crib some wording from patch 1, and say:
> 
>   arm64: entry: avoid double-accounting IRQ RCU entry
> 
>   When an IRQ is taken, some accounting needs to be performed to enter
>   and exit IRQ context around the IRQ handler. On arm64 some of this
>   accounting is performed by both the architecture code and the IRQ
>   domain code, resulting in calling rcu_irq_enter() twice per exception
>   entry, violating the expectations of the core RCU code, and resulting
>   in failing to identify quiescent periods correctly (e.g. in
>   rcu_is_cpu_rrupt_from_idle()).
> 
>   To fix this, we must perform all the accounting from the architecture
>   code. We prevent the IRQ domain code from performing any accounting by
>   selecting HAVE_ARCH_IRQENTRY, and must call irq_enter_rcu() and
>   irq_exit_rcu() around invoking the root IRQ handler.
> 
>   When we take a pNMI from a context with IRQs disabled, we'll perform
>   the necessary accounting as part of arm64_enter_nmi() and
>   arm64_exit_nmi(), and should only call irq_enter_rcu() and
>   irq_exit_rcu() when we may have taken a regular interrupt.
> 
It is a wonderful and elaborated log.

> That way it's clear what specifically the overlap is and the problem(s)
> it results in. The bit at the end explains why we don't call
> irq_{enter,exit}_rcu() when we're certain we've taken a pNMI.
> 
I have learned much from the log you contribute to this series. I will keep
learning how to improve my ability of log. Thanks again!

> > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Marc Zyngier <maz@kernel.org>
> > Cc: Joey Gouly <joey.gouly@arm.com>
> > Cc: Sami Tolvanen <samitolvanen@google.com>
> > Cc: Julien Thierry <julien.thierry@arm.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Yuichi Ito <ito-yuichi@fujitsu.com>
> > Cc: linux-kernel@vger.kernel.org
> > To: linux-arm-kernel@lists.infradead.org
> > ---
> >  arch/arm64/Kconfig               | 1 +
> >  arch/arm64/kernel/entry-common.c | 4 ++++
> >  2 files changed, 5 insertions(+)
> > 
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index 5c7ae4c3954b..d29bae38a951 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -98,6 +98,7 @@ config ARM64
> >  	select ARCH_HAS_UBSAN_SANITIZE_ALL
> >  	select ARM_AMBA
> >  	select ARM_ARCH_TIMER
> > +	select HAVE_ARCH_IRQENTRY
> 
> Please put this with the other HAVE_ARCH_* entries in
> arch/arm64/Kconfig -- it should be between HAVE_ARCH_HUGE_VMAP and
> HAVE_ARCH_JUMP_LABEL to keep that in alphabetical order.
> 
OK, I will fix it in V4.

> With that and the title and commit message above:
> 
> Reviewed-by: Mark Rutland <mark.rutland@arm.com>
> 
Thanks,

	Pingfan
