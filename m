Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6BB0427701
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 05:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244254AbhJIDvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 23:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbhJIDvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 23:51:51 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D78C061570
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 20:49:55 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id pi19-20020a17090b1e5300b0019fdd3557d3so9194949pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 20:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YsOo6uJpHFuwAQVn6OjX/o2BoeDbNko2xmVe2QMnXMU=;
        b=jB+fqNCISS9Dpu/l3tmqlCxrHSjotS0mWBWaYn1dhjl5Pq5AJ3I0csA17iVRNhsAfH
         M/ucWx8hzQBGsqktvMsGjrHWwL0GPNxApjbq+Lkww2RmLsz2S4orK49qYZy52YAoiBB+
         yfongPR4yguxoG76fp3l4EStXuKCuTfb5dRkpBPGphd8Jnd8CZf5aev38CbJQJW5dqmg
         bbSWgJ6D2pnt2KgHCdBFudgvZM3V73f0HpjNsBS9LwpYaH9S2Dqa/uO9k5V1c/ODgZ9F
         rh2WxFiSnohp1CxHcppL4uuBmFzQ0VWpfyuj/XStZ4v93a2dR/E7UA5q9OGORKT4NwN6
         F+bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YsOo6uJpHFuwAQVn6OjX/o2BoeDbNko2xmVe2QMnXMU=;
        b=W941egqQyzkiJe33B3nOoxCCfCZrUzzygOOawEL3i7weGQ9ZTWGM068wmJRAHx+jvf
         fjRFrptQxxTminvcafdHa1MIms9f+A+RUKEkQbk3pXTSoQk52R34vLLsrnzZIWNLd5Ck
         n9E86KdMYBEkNe+H00HWjBiT8Koe8ctbYq8Pa8sKFTaQVTqu2I/hXzVPojhDEp4cY+NE
         A1UzbFpSWyFiorIdtI7fyxwowEhNchuEXDldwrltp1030DaINYGzMXf4prIKZQ8uq2bO
         Es7t1dpBcrQEf9AdL1GvEaV2Ngl3HmcNtwN/MlLpi64w9fzxCijfy5ESrpi1T3ZmdSzC
         tmBA==
X-Gm-Message-State: AOAM533d7YGojhpZpl8wpv2AGEr+RglXvt34lmatc4iv6f7HKdb0zmwN
        5scFC3yz/hhF3VVAvXZNZg==
X-Google-Smtp-Source: ABdhPJxQZXlwH2PohsiZXf9412JVOod24wFAdxtPoy7iglEJeotIjVMAdw2Gy4ELeqU2x1whFg44Ug==
X-Received: by 2002:a17:902:7d89:b0:13c:a5e1:f0f1 with SMTP id a9-20020a1709027d8900b0013ca5e1f0f1mr12865501plm.24.1633751394201;
        Fri, 08 Oct 2021 20:49:54 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id l14sm12853915pjq.13.2021.10.08.20.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 20:49:53 -0700 (PDT)
Date:   Sat, 9 Oct 2021 11:49:47 +0800
From:   Pingfan Liu <kernelfans@gmail.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Joey Gouly <joey.gouly@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yuichi Ito <ito-yuichi@fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 1/5] arm64/entry-common: push the judgement of nmi ahead
Message-ID: <YWERWy5tMdbaEUU8@piliu.users.ipa.redhat.com>
References: <20210924132837.45994-1-kernelfans@gmail.com>
 <20210924132837.45994-2-kernelfans@gmail.com>
 <20210924175306.GB42068@C02TD0UTHF1T.local>
 <YU9Cy9kTew4ySeGZ@piliu.users.ipa.redhat.com>
 <20210930133257.GB18258@lakrids.cambridge.arm.com>
 <YV/ClUNWvMga3qud@piliu.users.ipa.redhat.com>
 <YWBbyPJPpt5zgj+b@piliu.users.ipa.redhat.com>
 <20211008172513.GD976@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211008172513.GD976@C02TD0UTHF1T.local>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 08, 2021 at 06:25:13PM +0100, Mark Rutland wrote:
> On Fri, Oct 08, 2021 at 10:55:04PM +0800, Pingfan Liu wrote:
> > On Fri, Oct 08, 2021 at 12:01:25PM +0800, Pingfan Liu wrote:
> > > Sorry that I missed this message and I am just back from a long
> > > festival.
> > > 
> > > Adding Paul for RCU guidance.
> > > 
> > > On Thu, Sep 30, 2021 at 02:32:57PM +0100, Mark Rutland wrote:
> > > > On Sat, Sep 25, 2021 at 11:39:55PM +0800, Pingfan Liu wrote:
> > > > > On Fri, Sep 24, 2021 at 06:53:06PM +0100, Mark Rutland wrote:
> > > > > > On Fri, Sep 24, 2021 at 09:28:33PM +0800, Pingfan Liu wrote:
> > > > > > > In enter_el1_irq_or_nmi(), it can be the case which NMI interrupts an
> > > > > > > irq, which makes the condition !interrupts_enabled(regs) fail to detect
> > > > > > > the NMI. This will cause a mistaken account for irq.
> > > > > > 
> > > > > Sorry about the confusing word "account", it should be "lockdep/rcu/.."
> > > > > 
> > > > > > Can you please explain this in more detail? It's not clear which
> > > > > > specific case you mean when you say "NMI interrupts an irq", as that
> > > > > > could mean a number of distinct scenarios.
> > > > > > 
> > > > > > AFAICT, if we're in an IRQ handler (with NMIs unmasked), and an NMI
> > > > > > causes a new exception we'll do the right thing. So either I'm missing a
> > > > > > subtlety or you're describing a different scenario..
> > > > > > 
> > > > > > Note that the entry code is only trying to distinguish between:
> > > > > > 
> > > > > > a) This exception is *definitely* an NMI (because regular interrupts
> > > > > >    were masked).
> > > > > > 
> > > > > > b) This exception is *either* and IRQ or an NMI (and this *cannot* be
> > > > > >    distinguished until we acknowledge the interrupt), so we treat it as
> > > > > >    an IRQ for now.
> > > > > > 
> > > > > b) is the aim.
> > > > > 
> > > > > At the entry, enter_el1_irq_or_nmi() -> enter_from_kernel_mode()->rcu_irq_enter()/rcu_irq_enter_check_tick() etc.
> > > > > While at irqchip level, gic_handle_irq()->gic_handle_nmi()->nmi_enter(),
> > > > > which does not call rcu_irq_enter_check_tick(). So it is not proper to
> > > > > "treat it as an IRQ for now"
> > > > 
> > > > I'm struggling to understand the problem here. What is "not proper", and
> > > > why?
> > > > 
> > > > Do you think there's a correctness problem, or that we're doing more
> > > > work than necessary? 
> > > > 
> > > I had thought it just did redundant accounting. But after revisiting RCU
> > > code, I think it confronts a real bug.
> > > 
> > > > If you could give a specific example of a problem, it would really help.
> > > > 
> > > Refer to rcu_nmi_enter(), which can be called by
> > > enter_from_kernel_mode():
> > > 
> > > ||noinstr void rcu_nmi_enter(void)
> > > ||{
> > > ||        ...
> > > ||        if (rcu_dynticks_curr_cpu_in_eqs()) {
> > > ||
> > > ||                if (!in_nmi())
> > > ||                        rcu_dynticks_task_exit();
> > > ||
> > > ||                // RCU is not watching here ...
> > > ||                rcu_dynticks_eqs_exit();
> > > ||                // ... but is watching here.
> > > ||
> > > ||                if (!in_nmi()) {
> > > ||                        instrumentation_begin();
> > > ||                        rcu_cleanup_after_idle();
> > > ||                        instrumentation_end();
> > > ||                }
> > > ||
> > > ||                instrumentation_begin();
> > > ||                // instrumentation for the noinstr rcu_dynticks_curr_cpu_in_eqs()
> > > ||                instrument_atomic_read(&rdp->dynticks, sizeof(rdp->dynticks));
> > > ||                // instrumentation for the noinstr rcu_dynticks_eqs_exit()
> > > ||                instrument_atomic_write(&rdp->dynticks, sizeof(rdp->dynticks));
> > > ||
> > > ||                incby = 1;
> > > ||        } else if (!in_nmi()) {
> > > ||                instrumentation_begin();
> > > ||                rcu_irq_enter_check_tick();
> > > ||        } else  {
> > > ||                instrumentation_begin();
> > > ||        }
> > > ||        ...
> > > ||}
> > > 
> > 
> > Forget to supplement the context for understanding the case:
> >   On arm64, at present, a pNMI (akin to NMI) may call rcu_nmi_enter()
> >   without calling "__preempt_count_add(NMI_OFFSET + HARDIRQ_OFFSET);".
> >   As a result it can be mistaken as an normal interrupt in
> >   rcu_nmi_enter().
> 
> I appreciate that there's a window where we treat the pNMI like an IRQ,
> but that's by design, and we account for this in gic_handle_irq() and
> gic_handle_nmi() where we "upgrade" to NMI context with
> nmi_enter()..nmi_exit().
> 
> The idea is that we have two cases: 
> 
> 1) If we take a pNMI from a context where IRQs were masked, we know it
>    must be a pNMI, and perform the NMI entry immediately to avoid
>    reentrancy problems. 
> 
>    I think we're all happy with this case.
> 
Right.

> 2) If we take a pNMI from a context where IRQs were unmasked, we don't know
>    whether the trigger was a pNMI/IRQ until we read from the GIC, and
>    since we *could* have taken an IRQ, this is equivalent to taking a
>    spurious IRQ, and while handling that, taking the NMI, e.g.
>    
>    < run with IRQs unmasked >
>      ~~~ take IRQ ~~~
>      < enter IRQ >
>        ~~~ take NMI exception ~~~
>        < enter NMI >
>        < handle NMI >
>        < exit NMI > 
>        ~~~ return from NMI exception ~~~
>      < handle IRQ / spurious / do-nothing >
>      < exit IRQ >
>      ~~~ return from IRQ exception ~~~
>    < continue running with IRQs unmasked >
> 
Yes, here I am on the same page. (I think I used a wrong example in
previous email, which caused the confusion)

>    ... except that we don't do the HW NMI exception entry/exit, just all
>    the necessary SW accounting.
> 
A little but important thing: local_irq_save() etc can not disable pNMI.

> 
> Note that case (2) can *never* nest within itself or within case (1).
> 
> Do you have a specific example of something that goes wrong with the
> above? e.g. something that's inconsistent with that rationale?
> 
Please see the following comment.

> > And this may cause the following issue:
> > > There is 3 pieces of code put under the
> > > protection of if (!in_nmi()). At least the last one
> > > "rcu_irq_enter_check_tick()" can trigger a hard lock up bug. Because it
> > > is supposed to hold a spin lock with irqoff by
> > > "raw_spin_lock_rcu_node(rdp->mynode)", but pNMI can breach it. The same
> > > scenario in rcu_nmi_exit()->rcu_prepare_for_idle().

Sorry that this should be an wrong example, since here it takes the case (1).

Concentrating on the spin lock rcu_node->lock, there are two operators:
  raw_spin_lock_rcu_node()
  raw_spin_trylock_rcu_node()

Then suppose the scenario for deadlock:
note_gp_changes() in non-irq-context
{
    local_irq_save(flags);
    ...
    raw_spin_trylock_rcu_node(rnp) // hold lock
    needwake = __note_gp_changes(rnp, rdp);        ------\
    raw_spin_unlock_irqrestore_rcu_node(rnp, flags);      \
}                                                          \
                                                            \---> pNMI breaks in due to local_irq_save() can not disable it.
                                                                 rcu_irq_enter() without __preempt_count_add(NMI_OFFSET + HARDIRQ_OFFSET)
								   ->rcu_nmi_enter()
								     {
								         else if (!in_nmi())
									     rcu_irq_enter_check_tick()
									       ->__rcu_irq_enter_check_tick()
									         {
										     ...
									             raw_spin_lock_rcu_node(rdp->mynode);

										     //Oops deadlock!
									         }
								     }


> > > 
> > > As for the first two "if (!in_nmi())", I have no idea of why, except
> > > breaching spin_lock_irq() by NMI. Hope Paul can give some guide.
> 
> That code (in enter_from_kernel_mode()) only runs in case 2, where it
> cannot be nested within a pNMI, so I struggle to see how this can
> deadlock. It it can, then I would expect the general case of a pNMI
> nesting within and IRQ would be broken?
> 
Sorry again for the previous misleading wrong example. Hope my new
example can help.

> Can you give a concrete example of a sequence that would lockup?
> Currently I can't see how that's possible.
> 

It seems the RCU subsystem has a strict semantic on NMI and normal
interrupt. Besides the deadlock example, there may be other supprise to
confront with (will trace it on another mail with Paul)

Thanks,

	Pingfan
