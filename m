Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DBE541DB21
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 15:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350200AbhI3Nep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 09:34:45 -0400
Received: from foss.arm.com ([217.140.110.172]:54316 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349882AbhI3Nen (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 09:34:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B87B6101E;
        Thu, 30 Sep 2021 06:33:00 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4CDE73F793;
        Thu, 30 Sep 2021 06:32:59 -0700 (PDT)
Date:   Thu, 30 Sep 2021 14:32:57 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Pingfan Liu <kernelfans@gmail.com>
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
Message-ID: <20210930133257.GB18258@lakrids.cambridge.arm.com>
References: <20210924132837.45994-1-kernelfans@gmail.com>
 <20210924132837.45994-2-kernelfans@gmail.com>
 <20210924175306.GB42068@C02TD0UTHF1T.local>
 <YU9Cy9kTew4ySeGZ@piliu.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YU9Cy9kTew4ySeGZ@piliu.users.ipa.redhat.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 25, 2021 at 11:39:55PM +0800, Pingfan Liu wrote:
> On Fri, Sep 24, 2021 at 06:53:06PM +0100, Mark Rutland wrote:
> > On Fri, Sep 24, 2021 at 09:28:33PM +0800, Pingfan Liu wrote:
> > > In enter_el1_irq_or_nmi(), it can be the case which NMI interrupts an
> > > irq, which makes the condition !interrupts_enabled(regs) fail to detect
> > > the NMI. This will cause a mistaken account for irq.
> > 
> Sorry about the confusing word "account", it should be "lockdep/rcu/.."
> 
> > Can you please explain this in more detail? It's not clear which
> > specific case you mean when you say "NMI interrupts an irq", as that
> > could mean a number of distinct scenarios.
> > 
> > AFAICT, if we're in an IRQ handler (with NMIs unmasked), and an NMI
> > causes a new exception we'll do the right thing. So either I'm missing a
> > subtlety or you're describing a different scenario..
> > 
> > Note that the entry code is only trying to distinguish between:
> > 
> > a) This exception is *definitely* an NMI (because regular interrupts
> >    were masked).
> > 
> > b) This exception is *either* and IRQ or an NMI (and this *cannot* be
> >    distinguished until we acknowledge the interrupt), so we treat it as
> >    an IRQ for now.
> > 
> b) is the aim.
> 
> At the entry, enter_el1_irq_or_nmi() -> enter_from_kernel_mode()->rcu_irq_enter()/rcu_irq_enter_check_tick() etc.
> While at irqchip level, gic_handle_irq()->gic_handle_nmi()->nmi_enter(),
> which does not call rcu_irq_enter_check_tick(). So it is not proper to
> "treat it as an IRQ for now"

I'm struggling to understand the problem here. What is "not proper", and
why?

Do you think there's a correctness problem, or that we're doing more
work than necessary? 

If you could give a specific example of a problem, it would really help.

I'm aware that we do more work than strictly necessary when we take a
pNMI from a context with IRQs enabled, but that's how we'd intended this
to work, as it's vastly simpler to manage the state that way. Unless
there's a real problem with that approach I'd prefer to leave it as-is.

Thanks,
Mark.
