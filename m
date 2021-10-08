Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E93D426D17
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 16:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242689AbhJHO5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 10:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242095AbhJHO5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 10:57:09 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45730C061570
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 07:55:14 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id n11so5921678plf.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 07:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GeF+0vI0rh9A/hx4bcDYc4RXHOiVVShtqRc/PviWzXU=;
        b=N6J9J+qLWBLLsJaDk3tMfpbAa+OFjdGd1vDN5Y1SYhj7EANs6y0rlijkYdUXJRWadN
         Cv7nSjYK270t5yxF4bR9RWISLSNAgSKw4Em+ae99Sx7ot58b4H63c6WW5E5qBa/A8XjD
         6h9h4uZy7MkVRUW6HXobCGbuxMdiJx5Nts0Jtmr1eIwmHYFsHOBDam5V15goIsliFQw7
         upXxUqWpinL1COoe0U+mQH5kPdKNrOhPRlonqaEq0O4k9Ke56UjQqc8ejO5xKQflmXkK
         /NgJQRpIVsQIGZ1P0k5lbvjLSwBre6XUccWi5KYP4aaeMMh0IjGCXL/HAfN5tJM4cE5/
         dJTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GeF+0vI0rh9A/hx4bcDYc4RXHOiVVShtqRc/PviWzXU=;
        b=g8qtK+Dcy+VmabDRPNzj7MWXVFMieBJzS2AAPhh78NwrlEsfIwvxKV+0Q7xH9zHOoc
         QKz1CQfyUB5oCwzSLBMWpWWiYQA5DupgncGdvUVxsQW6v1XPAjOXYPQkeNK8jRoSolVk
         BnygJQfF4P9PJPwdzlHNa28DZRdlmWzSesnhjeNVNy8fqVkJGmo2R3UloPq4agS6SZq0
         0drtwqM+LedycOpzBeQl/rCItXM4GzYcDXCJNDtiZaLDFtGi9cMmA/5ibThH4Yi5wbXb
         yGNNg3stBU7JX3GHwXhIE0gq4583hdPTy5JjRDto+r34GZsRWacZApLz/gGxBL/Kr2Ag
         /0gQ==
X-Gm-Message-State: AOAM53152Tu82Ex0ltGLQCpD9pjjV099ZjT3cPuEi7E7akOrDz7fJOml
        h6FKPLCcsFqarVe+kttg3nzQFMLikA==
X-Google-Smtp-Source: ABdhPJxFR3Hp6+pyTjGQQKwAXtAEoKIIySxOvS9HPjgJPE57kUHbXBVsAUui7HhZM5ZYkdcB7WcJFQ==
X-Received: by 2002:a17:903:2303:b0:13f:e63:e27d with SMTP id d3-20020a170903230300b0013f0e63e27dmr6369513plh.84.1633704913761;
        Fri, 08 Oct 2021 07:55:13 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 4sm2556045pjb.21.2021.10.08.07.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 07:55:12 -0700 (PDT)
Date:   Fri, 8 Oct 2021 22:55:04 +0800
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
Message-ID: <YWBbyPJPpt5zgj+b@piliu.users.ipa.redhat.com>
References: <20210924132837.45994-1-kernelfans@gmail.com>
 <20210924132837.45994-2-kernelfans@gmail.com>
 <20210924175306.GB42068@C02TD0UTHF1T.local>
 <YU9Cy9kTew4ySeGZ@piliu.users.ipa.redhat.com>
 <20210930133257.GB18258@lakrids.cambridge.arm.com>
 <YV/ClUNWvMga3qud@piliu.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YV/ClUNWvMga3qud@piliu.users.ipa.redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 08, 2021 at 12:01:25PM +0800, Pingfan Liu wrote:
> Sorry that I missed this message and I am just back from a long
> festival.
> 
> Adding Paul for RCU guidance.
> 
> On Thu, Sep 30, 2021 at 02:32:57PM +0100, Mark Rutland wrote:
> > On Sat, Sep 25, 2021 at 11:39:55PM +0800, Pingfan Liu wrote:
> > > On Fri, Sep 24, 2021 at 06:53:06PM +0100, Mark Rutland wrote:
> > > > On Fri, Sep 24, 2021 at 09:28:33PM +0800, Pingfan Liu wrote:
> > > > > In enter_el1_irq_or_nmi(), it can be the case which NMI interrupts an
> > > > > irq, which makes the condition !interrupts_enabled(regs) fail to detect
> > > > > the NMI. This will cause a mistaken account for irq.
> > > > 
> > > Sorry about the confusing word "account", it should be "lockdep/rcu/.."
> > > 
> > > > Can you please explain this in more detail? It's not clear which
> > > > specific case you mean when you say "NMI interrupts an irq", as that
> > > > could mean a number of distinct scenarios.
> > > > 
> > > > AFAICT, if we're in an IRQ handler (with NMIs unmasked), and an NMI
> > > > causes a new exception we'll do the right thing. So either I'm missing a
> > > > subtlety or you're describing a different scenario..
> > > > 
> > > > Note that the entry code is only trying to distinguish between:
> > > > 
> > > > a) This exception is *definitely* an NMI (because regular interrupts
> > > >    were masked).
> > > > 
> > > > b) This exception is *either* and IRQ or an NMI (and this *cannot* be
> > > >    distinguished until we acknowledge the interrupt), so we treat it as
> > > >    an IRQ for now.
> > > > 
> > > b) is the aim.
> > > 
> > > At the entry, enter_el1_irq_or_nmi() -> enter_from_kernel_mode()->rcu_irq_enter()/rcu_irq_enter_check_tick() etc.
> > > While at irqchip level, gic_handle_irq()->gic_handle_nmi()->nmi_enter(),
> > > which does not call rcu_irq_enter_check_tick(). So it is not proper to
> > > "treat it as an IRQ for now"
> > 
> > I'm struggling to understand the problem here. What is "not proper", and
> > why?
> > 
> > Do you think there's a correctness problem, or that we're doing more
> > work than necessary? 
> > 
> I had thought it just did redundant accounting. But after revisiting RCU
> code, I think it confronts a real bug.
> 
> > If you could give a specific example of a problem, it would really help.
> > 
> Refer to rcu_nmi_enter(), which can be called by
> enter_from_kernel_mode():
> 
> ||noinstr void rcu_nmi_enter(void)
> ||{
> ||        ...
> ||        if (rcu_dynticks_curr_cpu_in_eqs()) {
> ||
> ||                if (!in_nmi())
> ||                        rcu_dynticks_task_exit();
> ||
> ||                // RCU is not watching here ...
> ||                rcu_dynticks_eqs_exit();
> ||                // ... but is watching here.
> ||
> ||                if (!in_nmi()) {
> ||                        instrumentation_begin();
> ||                        rcu_cleanup_after_idle();
> ||                        instrumentation_end();
> ||                }
> ||
> ||                instrumentation_begin();
> ||                // instrumentation for the noinstr rcu_dynticks_curr_cpu_in_eqs()
> ||                instrument_atomic_read(&rdp->dynticks, sizeof(rdp->dynticks));
> ||                // instrumentation for the noinstr rcu_dynticks_eqs_exit()
> ||                instrument_atomic_write(&rdp->dynticks, sizeof(rdp->dynticks));
> ||
> ||                incby = 1;
> ||        } else if (!in_nmi()) {
> ||                instrumentation_begin();
> ||                rcu_irq_enter_check_tick();
> ||        } else  {
> ||                instrumentation_begin();
> ||        }
> ||        ...
> ||}
> 

Forget to supplement the context for understanding the case:
  On arm64, at present, a pNMI (akin to NMI) may call rcu_nmi_enter()
  without calling "__preempt_count_add(NMI_OFFSET + HARDIRQ_OFFSET);".
  As a result it can be mistaken as an normal interrupt in
  rcu_nmi_enter().

And this may cause the following issue:
> There is 3 pieces of code put under the
> protection of if (!in_nmi()). At least the last one
> "rcu_irq_enter_check_tick()" can trigger a hard lock up bug. Because it
> is supposed to hold a spin lock with irqoff by
> "raw_spin_lock_rcu_node(rdp->mynode)", but pNMI can breach it. The same
> scenario in rcu_nmi_exit()->rcu_prepare_for_idle().
> 
> As for the first two "if (!in_nmi())", I have no idea of why, except
> breaching spin_lock_irq() by NMI. Hope Paul can give some guide.
> 
> 
> Thanks,
> 
> 	Pingfan
> 
> 
> > I'm aware that we do more work than strictly necessary when we take a
> > pNMI from a context with IRQs enabled, but that's how we'd intended this
> > to work, as it's vastly simpler to manage the state that way. Unless
> > there's a real problem with that approach I'd prefer to leave it as-is.
> > 
> > Thanks,
> > Mark.
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
