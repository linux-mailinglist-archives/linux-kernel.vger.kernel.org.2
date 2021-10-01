Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBD3441EF84
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 16:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354139AbhJAOfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 10:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231679AbhJAOfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 10:35:15 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C78C061775
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 07:33:30 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id v19so6671197pjh.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 07:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=K6bdrW5XoTNbCZ8Y3lTAFsO0+u7qGnbAjtCOYBFB05Y=;
        b=AiFU1M2LcJHiomhxlBGqFJ7n2sKalQZc2fRuZQN1uEiRkm1inHkPTxsB3ntoWTjy1Y
         +p6HLCfW0nwMEvk50/hcySMzbeq3r5RI/zlmsKGtyUPsY1bvHK3x2yjQ07VKNFtR8blL
         qveh2UKlo2knoRKMuyfSwzKMPdgI4lFwhlST5cuz7tSmQuhqO37kqrX20Lo0h6OI/yW6
         qvtR7+K7TYIzEtzBeP2XqBrbA6LdJIYPA8j6cgmy+STO9drdnto2HcJrHQQEThlrWxnW
         /l2pTuais3nkopujnSUqoNiOYKfs+o6fA8z+mSh1X0eNXleKo9oThw9vLIChDByCA5uZ
         wO+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=K6bdrW5XoTNbCZ8Y3lTAFsO0+u7qGnbAjtCOYBFB05Y=;
        b=h1fDyvYWmwwBdqcY1BDrv8iSZFAD2RiXLhRi/o7QYRMtoV6ZQIG7bZNun2QgMHW7cz
         npxT0KiJOOUdmnkDl21w8nP/sMH42EYuGcwj6k4jfLVb2wsWTX1mqA+f2D9gJwXIzflo
         F4O9PR1LAqbHtsQDuxLEizzBwuFqYYY267ye4IFWv/Lh54qLb6rKd9vtFz2+DxXh76+Y
         ZWOKcW6J8p3XapCuu/CKQqn+Ye0Iap/tBvjYfeRn5OzRLuaP9MgizpCzsIwCY79FBo1O
         phygUMfjFKqFyQYHoAO+TOFKm9s12JoyTPRavgUat26bkrCgcxKRMHDaM8V6tvZQbeyk
         84lg==
X-Gm-Message-State: AOAM5319AVeEnIPZXA77E0zkUQ2SRdZa8U4HPylnhOe6hpxRMg7IrCYl
        +6NadZMAbsgz2QeUckUnUw==
X-Google-Smtp-Source: ABdhPJwg1gAthTPyUbT6um3Zi17pDErx0CVbMnwMjrO5y0xoDVke0Zyy1kTTTmFTB09BBQKFT26T5w==
X-Received: by 2002:a17:902:7613:b0:13d:b35f:b4d7 with SMTP id k19-20020a170902761300b0013db35fb4d7mr11418893pll.8.1633098809959;
        Fri, 01 Oct 2021 07:33:29 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id d19sm4678497pfl.67.2021.10.01.07.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 07:33:29 -0700 (PDT)
Date:   Fri, 1 Oct 2021 22:33:22 +0800
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
Subject: Re: [PATCHv3 1/3] kernel/irq: make irq_{enter, exit}() in
 handle_domain_irq() arch optional
Message-ID: <YVccMqMHLeRSCNAd@piliu.users.ipa.redhat.com>
References: <20210930131708.35328-1-kernelfans@gmail.com>
 <20210930131708.35328-2-kernelfans@gmail.com>
 <87sfxlrtqz.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sfxlrtqz.wl-maz@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 01, 2021 at 10:15:16AM +0100, Marc Zyngier wrote:
> On Thu, 30 Sep 2021 14:17:06 +0100,
> Pingfan Liu <kernelfans@gmail.com> wrote:
> > 
> > When an IRQ is taken, some accounting needs to be performed to enter and
> > exit IRQ context around the IRQ handler. Historically arch code would
> > leave this to the irqchip or core IRQ code, but these days we want this
> > to happen in exception entry code, and architectures such as arm64 do
> > this.
> > 
> > Currently handle_domain_irq() performs this entry/exit accounting, and
> > if used on an architecture where the entry code also does this, the
> > entry/exit accounting will be performed twice per IRQ. This is
> > problematic as core RCU code such as rcu_is_cpu_rrupt_from_idle()
> > depends on this happening once per IRQ, and will not detect quescent
> > periods correctly, leading to stall warnings.
> > 
> > As irqchip drivers which use handle_domain_irq() need to work on
> > architectures with or without their own entry/exit accounting, this
> > patch makes handle_domain_irq() conditionally perform the entry
> > accounting depending on a new HAVE_ARCH_IRQENTRY Kconfig symbol that
> > architectures can select if they perform this entry accounting
> > themselves.
> > 
> > For architectures which do not select the symbol. there should be no
> > functional change as a result of this patch.
> > 
> > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > Reviewed-by: Mark Rutland <mark.rutland@arm.com>
> > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Marc Zyngier <maz@kernel.org>
> > Cc: Joey Gouly <joey.gouly@arm.com>
> > Cc: Sami Tolvanen <samitolvanen@google.com>
> > Cc: Julien Thierry <julien.thierry@arm.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Yuichi Ito <ito-yuichi@fujitsu.com>
> > Cc: linux-kernel@vger.kernel.org
> > To: linux-arm-kernel@lists.infradead.org
> > ---
> >  kernel/irq/Kconfig   | 3 +++
> >  kernel/irq/irqdesc.c | 4 ++++
> >  2 files changed, 7 insertions(+)
> > 
> > diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
> > index fbc54c2a7f23..defa1db2d664 100644
> > --- a/kernel/irq/Kconfig
> > +++ b/kernel/irq/Kconfig
> > @@ -100,6 +100,9 @@ config IRQ_MSI_IOMMU
> >  config HANDLE_DOMAIN_IRQ
> >  	bool
> >  
> > +config HAVE_ARCH_IRQENTRY
> > +	bool
> > +
> >  config IRQ_TIMINGS
> >  	bool
> >  
> > diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
> > index 4e3c29bb603c..fd5dd9d278b5 100644
> > --- a/kernel/irq/irqdesc.c
> > +++ b/kernel/irq/irqdesc.c
> > @@ -693,7 +693,9 @@ int handle_domain_irq(struct irq_domain *domain,
> >  	struct irq_desc *desc;
> >  	int ret = 0;
> >  
> > +#ifndef CONFIG_HAVE_ARCH_IRQENTRY
> >  	irq_enter();
> > +#endif
> 
> nit: I tend to prefer the 'if (!IS_ENABLED(CONFIG_*))' approach.
> 
I check the irqdesc.c, the other macro conditional statements have the style
"#ifdef". So if using 'if (!IS_ENABLED(CONFIG_*))', the file looks a
little disharmony.

> >  
> >  	/* The irqdomain code provides boundary checks */
> >  	desc = irq_resolve_mapping(domain, hwirq);
> > @@ -702,7 +704,9 @@ int handle_domain_irq(struct irq_domain *domain,
> >  	else
> >  		ret = -EINVAL;
> >  
> > +#ifndef CONFIG_HAVE_ARCH_IRQENTRY
> >  	irq_exit();
> > +#endif
> >  	set_irq_regs(old_regs);
> >  	return ret;
> >  }
> 
> Apart from that:
> 
> Reviewed-by: Marc Zyngier <maz@kernel.org>
> 
I am not sure whether you agree with my opinion about the style of macro
and hesitate to include your Reviewed-by.

Could you kindly give your Reviewed-by to my V4, if it is OK for you?


Thanks

	Pingfan
