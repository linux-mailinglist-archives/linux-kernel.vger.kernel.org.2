Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5265439FE4E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 19:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234000AbhFHSA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 14:00:56 -0400
Received: from foss.arm.com ([217.140.110.172]:36724 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233983AbhFHSAv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 14:00:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A908FD6E;
        Tue,  8 Jun 2021 10:58:57 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8B18A3F694;
        Tue,  8 Jun 2021 10:58:56 -0700 (PDT)
Date:   Tue, 8 Jun 2021 18:58:47 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, sudeep.holla@arm.com
Subject: Re: [RFC PATCH v2 00/10] irqchip/irq-gic: Optimize masking by
 leveraging EOImode=1
Message-ID: <20210608175840.GA15997@lpieralisi>
References: <20210525173255.620606-1-valentin.schneider@arm.com>
 <87zgwgs9x0.wl-maz@kernel.org>
 <87tumhg9vm.mognet@arm.com>
 <87a6o0z86t.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a6o0z86t.wl-maz@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+Sudeep]

On Tue, Jun 08, 2021 at 04:29:14PM +0100, Marc Zyngier wrote:
> [+Mark, since we discussed about this on IRC]
> 
> Hi Valentin,
> 
> On Tue, 01 Jun 2021 11:25:01 +0100,
> Valentin Schneider <valentin.schneider@arm.com> wrote:
> > 
> > On 27/05/21 12:17, Marc Zyngier wrote:
> > > On Tue, 25 May 2021 18:32:45 +0100,
> > > Valentin Schneider <valentin.schneider@arm.com> wrote:
> > >> I've tested this on my Ampere eMAG, which uncovered "fun" interactions with
> > >> the MSI domains. Did the same trick as the Juno with the pl011.
> > >>
> > >> pNMIs cause said eMAG to freeze, but that's true even without my patches. I
> > >> did try them out under QEMU+KVM and that looked fine, although that means I
> > >> only got to test EOImode=0. I'll try to dig into this when I get some more
> > >> cycles.
> > >
> > > That's interesting/worrying. As far as I remember, this machine uses
> > > GIC500, which is a well known quantity. If pNMIs are causing issues,
> > > that'd probably be a CPU interface problem. Can you elaborate on how
> > > you tried to test that part? Just using the below benchmark?
> > >
> > 
> > Not even that, it would hang somewhere at boot. Julien suggested offline
> > that it might be a problem with the secondaries' PMR initial value, but I
> > really never got to do dig into it.
> 
> I just hit a similar problem on an Altra box, which seems to be
> related to using PSCI for idle. PSCI has no idea about priority
> masking, and enters CPU suspend with interrupt masked at the PMR
> level. Good luck waking up from that.

Gah. If we can manage to understand which path in
psci_cpu_suspend_enter() is causing this problem that'd
be great too (it can be both, for different reasons):

if (!psci_power_state_loses_context(state))
(1)	ret = psci_ops.cpu_suspend(state, 0);
else
(2)	ret = cpu_suspend(state, psci_suspend_finisher);

I'd like to understand if the problem is on idle entry or
exit (or both depending on the state we are entering).

On (1) we would return from the call with the CPU state
retained on (2) with CPU context restored (but it rebooted
from reset - so the PMR value is gone).

I am asking about (2) because I am trying to understand what
the power controller does wrt PMR and wake-up IRQs (ie and
whether the PMR plays a role in that). Reworded: trying to
understand how the PMR behaviour is playing with the power
controller wake-up capabilities.

Thoughts appreciated.

I am sorry that you had to debug this, thank you for that.

Lorenzo

> I've pushed a test branch at [1]. It'd be really good if you could
> have a quick look and let me know if that helps in your case (it
> certainly does on the box I have access to).
> 
> Thanks,
> 
> 	M.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/log/?h=arm64/nmi-idle
> 
> -- 
> Without deviation from the norm, progress is not possible.
