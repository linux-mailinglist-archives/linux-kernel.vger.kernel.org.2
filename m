Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2DDE426382
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 06:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbhJHEDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 00:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhJHED2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 00:03:28 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7402C061570
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 21:01:33 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id j15so5323158plh.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 21:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SomEx5XusWQ42Nf16wCBxoC4McfhQLMf756SsCxzDL4=;
        b=HnjR9oL3TUn8DsAAtidCku3sLXfqlwptYsgOtpvzTYG7dHQ2pJwALqZ5vSJuX6nPY2
         TRDLCPPQpLYCxDmqL/d4YrdhhkAWixMIFeysWBTjkH4nDdFvOlZwc/fMWDZYXzvyxGOL
         Xc2FM8SCszjB/+XFgrUcCyfllgWBTtEJE9mj4hw1f5qiWEAmk392O+6f7pdk2RZX3UGY
         LlRv5PJViZLzVdEQdjBBeBn/VXYe8vXTRmMHDL5fDRknsQ7pg+IEB18x+fOH311hg+Bw
         K1ZOcTmH7PefwWXpB57pjCg6pGMqQA6FJbcK5zdzgHg5QC19nPA0z3sWp7WIAOP/J40+
         w+vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SomEx5XusWQ42Nf16wCBxoC4McfhQLMf756SsCxzDL4=;
        b=rSa2RWVdvRoDOMmm57WFenfnQqV0k/g4kCU3oMiLRP5QaRIZ4u2H4Ol7ThnAD7S2jo
         ukkBK3G+xgSqDQbblwdmPEqfv1cNj6JKDLGnDbL8IrR0Rob3MaPZZKFXlHG8NPoYwr2v
         EHOpsxr+YeLSuDb8a64s8l4tm1AH7t1cKelK/rWLmM+D2s4I6sPri2I7bdcZTPPI0u3l
         /hx0UaDs3dnHSmzyWtndATd7tygLPTojWYwV3BelDKNt7RNcd/4jRUUDZjC0QRUjv/sW
         MuWMhbT7+UMCYybqGwQj/XWkcnOYIAePpo/Gsnm8cm/znAl6XYNFj8r/Xgm4rBZCg6te
         mozw==
X-Gm-Message-State: AOAM5317As512Sn46XchMtM/vFNDVCR5ckDuhM4G2VHc5+/NkfgD2K/n
        Hlj+0v40sigoV4wuNiwkfg==
X-Google-Smtp-Source: ABdhPJx59inE/oTwcAFKfp1STCMEIvfuXrdlIUmK2Y7J28TD1vn8K6RAOkYAzeKKZccdNKkPMWzycQ==
X-Received: by 2002:a17:902:b711:b029:11e:6480:258a with SMTP id d17-20020a170902b711b029011e6480258amr7292479pls.41.1633665693085;
        Thu, 07 Oct 2021 21:01:33 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 12sm832300pfz.133.2021.10.07.21.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 21:01:32 -0700 (PDT)
Date:   Fri, 8 Oct 2021 12:01:25 +0800
From:   Pingfan Liu <kernelfans@gmail.com>
To:     Mark Rutland <mark.rutland@arm.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Joey Gouly <joey.gouly@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yuichi Ito <ito-yuichi@fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 1/5] arm64/entry-common: push the judgement of nmi ahead
Message-ID: <YV/ClUNWvMga3qud@piliu.users.ipa.redhat.com>
References: <20210924132837.45994-1-kernelfans@gmail.com>
 <20210924132837.45994-2-kernelfans@gmail.com>
 <20210924175306.GB42068@C02TD0UTHF1T.local>
 <YU9Cy9kTew4ySeGZ@piliu.users.ipa.redhat.com>
 <20210930133257.GB18258@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210930133257.GB18258@lakrids.cambridge.arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry that I missed this message and I am just back from a long
festival.

Adding Paul for RCU guidance.

On Thu, Sep 30, 2021 at 02:32:57PM +0100, Mark Rutland wrote:
> On Sat, Sep 25, 2021 at 11:39:55PM +0800, Pingfan Liu wrote:
> > On Fri, Sep 24, 2021 at 06:53:06PM +0100, Mark Rutland wrote:
> > > On Fri, Sep 24, 2021 at 09:28:33PM +0800, Pingfan Liu wrote:
> > > > In enter_el1_irq_or_nmi(), it can be the case which NMI interrupts an
> > > > irq, which makes the condition !interrupts_enabled(regs) fail to detect
> > > > the NMI. This will cause a mistaken account for irq.
> > > 
> > Sorry about the confusing word "account", it should be "lockdep/rcu/.."
> > 
> > > Can you please explain this in more detail? It's not clear which
> > > specific case you mean when you say "NMI interrupts an irq", as that
> > > could mean a number of distinct scenarios.
> > > 
> > > AFAICT, if we're in an IRQ handler (with NMIs unmasked), and an NMI
> > > causes a new exception we'll do the right thing. So either I'm missing a
> > > subtlety or you're describing a different scenario..
> > > 
> > > Note that the entry code is only trying to distinguish between:
> > > 
> > > a) This exception is *definitely* an NMI (because regular interrupts
> > >    were masked).
> > > 
> > > b) This exception is *either* and IRQ or an NMI (and this *cannot* be
> > >    distinguished until we acknowledge the interrupt), so we treat it as
> > >    an IRQ for now.
> > > 
> > b) is the aim.
> > 
> > At the entry, enter_el1_irq_or_nmi() -> enter_from_kernel_mode()->rcu_irq_enter()/rcu_irq_enter_check_tick() etc.
> > While at irqchip level, gic_handle_irq()->gic_handle_nmi()->nmi_enter(),
> > which does not call rcu_irq_enter_check_tick(). So it is not proper to
> > "treat it as an IRQ for now"
> 
> I'm struggling to understand the problem here. What is "not proper", and
> why?
> 
> Do you think there's a correctness problem, or that we're doing more
> work than necessary? 
> 
I had thought it just did redundant accounting. But after revisiting RCU
code, I think it confronts a real bug.

> If you could give a specific example of a problem, it would really help.
> 
Refer to rcu_nmi_enter(), which can be called by
enter_from_kernel_mode():

||noinstr void rcu_nmi_enter(void)
||{
||        ...
||        if (rcu_dynticks_curr_cpu_in_eqs()) {
||
||                if (!in_nmi())
||                        rcu_dynticks_task_exit();
||
||                // RCU is not watching here ...
||                rcu_dynticks_eqs_exit();
||                // ... but is watching here.
||
||                if (!in_nmi()) {
||                        instrumentation_begin();
||                        rcu_cleanup_after_idle();
||                        instrumentation_end();
||                }
||
||                instrumentation_begin();
||                // instrumentation for the noinstr rcu_dynticks_curr_cpu_in_eqs()
||                instrument_atomic_read(&rdp->dynticks, sizeof(rdp->dynticks));
||                // instrumentation for the noinstr rcu_dynticks_eqs_exit()
||                instrument_atomic_write(&rdp->dynticks, sizeof(rdp->dynticks));
||
||                incby = 1;
||        } else if (!in_nmi()) {
||                instrumentation_begin();
||                rcu_irq_enter_check_tick();
||        } else  {
||                instrumentation_begin();
||        }
||        ...
||}

There is 3 pieces of code put under the
protection of if (!in_nmi()). At least the last one
"rcu_irq_enter_check_tick()" can trigger a hard lock up bug. Because it
is supposed to hold a spin lock with irqoff by
"raw_spin_lock_rcu_node(rdp->mynode)", but pNMI can breach it. The same
scenario in rcu_nmi_exit()->rcu_prepare_for_idle().

As for the first two "if (!in_nmi())", I have no idea of why, except
breaching spin_lock_irq() by NMI. Hope Paul can give some guide.


Thanks,

	Pingfan


> I'm aware that we do more work than strictly necessary when we take a
> pNMI from a context with IRQs enabled, but that's how we'd intended this
> to work, as it's vastly simpler to manage the state that way. Unless
> there's a real problem with that approach I'd prefer to leave it as-is.
> 
> Thanks,
> Mark.
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
