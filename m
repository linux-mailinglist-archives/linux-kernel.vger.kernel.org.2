Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 567AB418313
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Sep 2021 17:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343677AbhIYPOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Sep 2021 11:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234173AbhIYPOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Sep 2021 11:14:43 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638D0C061570
        for <linux-kernel@vger.kernel.org>; Sat, 25 Sep 2021 08:13:08 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id s11so12904676pgr.11
        for <linux-kernel@vger.kernel.org>; Sat, 25 Sep 2021 08:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XEm0t7ryoVhJkdhQdSgea/DditBBxgJ9XTvsM+EhAlU=;
        b=BNWwsKUyLFJscWcAsXOpZORhYaoO2c/pVVryBCKJi5ZzRdP26aNOp32rEiVcfwprnK
         wNog7bcd7hL0dFmXCHDCEjJR/5gikbdmpnrSQ4tjhApl7b70+teMu+nAGrhCIR5dRMuu
         iduUVo+/zgoUQLFO4ESyAK7tCAI4Nae4z36HRP7luj1/SsrGzRi38EmZhOCngFm/gsh7
         Cx9KMWnpP+USH803Os7dmUg5wIqX4M71JGP5SwQvF+k6obQ9+RAk5Lo8fuZLaBRAUvNm
         qNBXXpXOm3i5i+w27qNnMQij1G7yhqv7IGFpMqx8Wet9LaQqncmRbtg9WI4cfvhA+wsl
         pEcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XEm0t7ryoVhJkdhQdSgea/DditBBxgJ9XTvsM+EhAlU=;
        b=MtLkFOojtTA1dV7U7JrWS4rf+WO49ZKXpTrw59GoxA5P8Gad5UpNz+UXgFJ2lw0d0+
         fSVIFAmaZDB3DzZMuWXGS6SCyNtULQ3owJUeKF8gM2sl7d/Js02H4G7AxE6cU7vlIbve
         H86Rp7uN+qAVE8rc1CzWcyR9GuCBTj2W71fHaYx0CJi1RKKH1vOrHXg2a6Aynco7TBQ3
         f8mHsbdPpSjC2KEH7uxWmZA4cexPT6BUmc1jMIFCwANBRLFMd56b9XtP1CVmC6E0HaW+
         Sc1C00XBwlb6f+RXEX962+SfUovyAMTr80WISsYPBo1EZYRnRSV0COzJAgUlgvIxrGIA
         EYTw==
X-Gm-Message-State: AOAM533pOdQVfdsWsbncz722/nUkAWchE5lmAiFsgXUOtAtLvVxBZymJ
        Y9wwKNR0GThBTUNnYker6oB0UUVC9g==
X-Google-Smtp-Source: ABdhPJzzNzdUnmRGWJE+VuLFDNiBzGvuoe+X1txlu8BHKPCyJPjRkor5c0KcwhhSdcZdKOvYUuaYMA==
X-Received: by 2002:a62:ddd8:0:b0:435:4de8:2652 with SMTP id w207-20020a62ddd8000000b004354de82652mr14616389pff.53.1632582787762;
        Sat, 25 Sep 2021 08:13:07 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id r29sm12391351pfq.74.2021.09.25.08.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Sep 2021 08:13:06 -0700 (PDT)
Date:   Sat, 25 Sep 2021 23:12:59 +0800
From:   Pingfan Liu <kernelfans@gmail.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Joey Gouly <joey.gouly@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Yuichi Ito <ito-yuichi@fujitsu.com>,
        linux-kernel@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCHv2 0/5] arm64/irqentry: remove duplicate housekeeping of
Message-ID: <YU88e19hxCV2T6Bl@piliu.users.ipa.redhat.com>
References: <20210924132837.45994-1-kernelfans@gmail.com>
 <20210924173615.GA42068@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210924173615.GA42068@C02TD0UTHF1T.local>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2021 at 06:36:15PM +0100, Mark Rutland wrote:
> [Adding Paul for RCU, s390 folk for entry code RCU semantics]
> 
> On Fri, Sep 24, 2021 at 09:28:32PM +0800, Pingfan Liu wrote:
> > After introducing arm64/kernel/entry_common.c which is akin to
> > kernel/entry/common.c , the housekeeping of rcu/trace are done twice as
> > the following:
> >     enter_from_kernel_mode()->rcu_irq_enter().
> > And
> >     gic_handle_irq()->...->handle_domain_irq()->irq_enter()->rcu_irq_enter()
> >
> > Besides redundance, based on code analysis, the redundance also raise
> > some mistake, e.g.  rcu_data->dynticks_nmi_nesting inc 2, which causes
> > rcu_is_cpu_rrupt_from_idle() unexpected.
> 
> Hmmm...
> 
> The fundamental questionss are:
> 
> 1) Who is supposed to be responsible for doing the rcu entry/exit?
> 
> 2) Is it supposed to matter if this happens multiple times?
> 
> For (1), I'd generally expect that this is supposed to happen in the
> arch/common entry code, since that itself (or the irqchip driver) could
> depend on RCU, and if that's the case thatn handle_domain_irq()
> shouldn't need to call rcu_irq_enter(). That would be consistent with
> the way we handle all other exceptions.
> 
In my humble opinion, it had better happen in arch/common entry code as
you said.  But for many arches which assures that before
handle_domain_irq(), no data is involved in rcu updater, it can be done
in handle_domain_irq().  And that is a cheap way to integrate with rcu
system (at least for the time being).

For the (2), it goes deeply into RCU core, hope guides from Paul and
Thomas.
But at least for the condition
  if ((user || rcu_is_cpu_rrupt_from_idle()) && rcu_nohz_full_cpu())
in rcu_pending(), it makes sense to tell the nested interrupt from a
first level interrupt.

Thanks,

	Pingfan
> For (2) I don't know whether the level of nesting is suppoosed to
> matter. I was under the impression it wasn't meant to matter in general,
> so I'm a little surprised that rcu_is_cpu_rrupt_from_idle() depends on a
> specific level of nesting.
> 
> From a glance it looks like this would cause rcu_sched_clock_irq() to
> skip setting TIF_NEED_RESCHED, and to not call invoke_rcu_core(), which
> doesn't sound right, at least...
> 
> Thomas, Paul, thoughts?
> 
> AFAICT, s390 will have a similar flow on its IRQ handling path, so if
> this is a real issue they'll be affected too.
> 
> Thanks,
> Mark.
> 
> > Nmi also faces duplicate accounts. This series aims to address these
> > duplicate issues.
> > [1-2/5]: address nmi account duplicate
> > [3-4/5]: address rcu housekeeping duplicate in irq
> > [5/5]: as a natural result of [3-4/5], address a history issue. [1]
> > 
> > 
> > History:
> > v1 -> v2:
> >     change the subject as the motivation varies.
> >     add the fix for nmi account duplicate
> > 
> > The subject of v1 is "[PATCH 1/3] kernel/irq: __handle_domain_irq()
> > makes irq_enter/exit arch optional". [2] It is brought up to fix [1].
> > 
> > There have been some tries to enable crash-stop-NMI on arm64, one by me,
> > the other by Yuichi's [4].  I hope after this series, they can advance,
> > as Marc said in [3] "No additional NMI patches will make it until we
> > have resolved the issues"
> > 
> > [1] https://lore.kernel.org/linux-arm-kernel/87lfewnmdz.fsf@nanos.tec.linutronix.de/
> > [2] https://lore.kernel.org/linux-arm-kernel/1607912752-12481-1-git-send-email-kernelfans@gmail.com
> > [3] https://lore.kernel.org/linux-arm-kernel/afd82be798cb55fd2f96940db7be78c0@kernel.org
> > [4] https://lore.kernel.org/linux-arm-kernel/20201104080539.3205889-1-ito-yuichi@fujitsu.com
> > 
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
> > 
> > 
> > Pingfan Liu (5):
> >   arm64/entry-common: push the judgement of nmi ahead
> >   irqchip/GICv3: expose handle_nmi() directly
> >   kernel/irq: make irq_{enter,exit}() in handle_domain_irq() arch
> >     optional
> >   irqchip/GICv3: let gic_handle_irq() utilize irqentry on arm64
> >   irqchip/GICv3: make reschedule-ipi light weight
> > 
> >  arch/arm64/Kconfig               |  1 +
> >  arch/arm64/include/asm/irq.h     |  7 ++++
> >  arch/arm64/kernel/entry-common.c | 45 +++++++++++++++-------
> >  arch/arm64/kernel/irq.c          | 29 ++++++++++++++
> >  drivers/irqchip/irq-gic-v3.c     | 66 ++++++++++++++++++++------------
> >  kernel/irq/Kconfig               |  3 ++
> >  kernel/irq/irqdesc.c             |  4 ++
> >  7 files changed, 116 insertions(+), 39 deletions(-)
> > 
> > -- 
> > 2.31.1
> > 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
