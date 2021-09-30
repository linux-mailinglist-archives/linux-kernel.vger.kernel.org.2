Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67DD841D56C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 10:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349147AbhI3Icn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 04:32:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:41842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349139AbhI3Icn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 04:32:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A55BF615E5;
        Thu, 30 Sep 2021 08:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632990660;
        bh=vH2ZLBcLG3OGYHCzwdrV5+lanmT9yLOFiAXAjvEt90Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fuZHOHCj8fYF/uT23eYD0lRfs7cbRe1XIMAX8H1J4LOxv3k+iS5CObktZ0AVWst10
         uJohsuGI5g4jnfLyhtGyGKdmrl2J0Wxp8rRE1VXpqZPlorJAtLWcb1Gf4783FrEwP6
         r9zRHRCd+gWfeYw+pT/YdpPQkQpFXfQttCH3tctIgcD86ms3Zrj2GnhnmB+PcXnVlg
         RAthUb8+12LxwARZje4PyFMMscPvVO/I52HO6JEfhfcaitC2WgTdq0p8hluVgDeb6v
         RUdkX3GaMc6svJMSevRWiBHdzv6MgSkqh1hYjykH26n8G7t/JvUKwzFzBxAENBBe8a
         /jhWet4gM+6lg==
Date:   Thu, 30 Sep 2021 09:30:54 +0100
From:   Will Deacon <will@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Shier <pshier@google.com>,
        Raghavendra Rao Ananta <rananta@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Oliver Upton <oupton@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        kernel-team@android.com
Subject: Re: [PATCH v2 14/16] arm64: Add a capability for FEAT_ECV
Message-ID: <20210930083054.GA23389@willie-the-truck>
References: <20210922211941.2756270-1-maz@kernel.org>
 <20210922211941.2756270-15-maz@kernel.org>
 <20210929160329.GE22029@willie-the-truck>
 <87h7e2tsov.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h7e2tsov.wl-maz@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2021 at 08:42:56AM +0100, Marc Zyngier wrote:
> On Wed, 29 Sep 2021 17:03:30 +0100,
> Will Deacon <will@kernel.org> wrote:
> > 
> > On Wed, Sep 22, 2021 at 10:19:39PM +0100, Marc Zyngier wrote:
> > > Add a new capability to detect the Enhanced Counter Virtualization
> > > feature (FEAT_ECV).
> > > 
> > > Reviewed-by: Oliver Upton <oupton@google.com>
> > > Signed-off-by: Marc Zyngier <maz@kernel.org>
> > > ---
> > >  arch/arm64/kernel/cpufeature.c | 10 ++++++++++
> > >  arch/arm64/tools/cpucaps       |  1 +
> > >  2 files changed, 11 insertions(+)
> > > 
> > > diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> > > index f8a3067d10c6..26b11ce8fff6 100644
> > > --- a/arch/arm64/kernel/cpufeature.c
> > > +++ b/arch/arm64/kernel/cpufeature.c
> > > @@ -1926,6 +1926,16 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
> > >  		.sign = FTR_UNSIGNED,
> > >  		.min_field_value = 1,
> > >  	},
> > > +	{
> > > +		.desc = "Enhanced Counter Virtualization",
> > > +		.capability = ARM64_HAS_ECV,
> > > +		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
> > > +		.matches = has_cpuid_feature,
> > > +		.sys_reg = SYS_ID_AA64MMFR0_EL1,
> > > +		.field_pos = ID_AA64MMFR0_ECV_SHIFT,
> > > +		.sign = FTR_UNSIGNED,
> > > +		.min_field_value = 1,
> > > +	},
> > 
> > Could we add a HWCAP for this and change the field to FTR_VISIBLE, please? I
> > know most users of the counter are indirected via the vDSO, but there are
> > some users out there using the counter directly and it would save them
> > having to probe via SIGILL if there was a hwcap available.
> 
> Fair enough, I'll add that.

Thanks!

> The problem of the vdso remains though, and is by far the most common
> user of the feature. Any idea on how to handle it? Patching the vdso
> is ugly, and I'd rather avoid it.
> 
> I briefly looked at using ifunc, but it is likely that the indirection
> would add an extra cost. Are we OK with that?

The vDSO is still miles faster than a system call, so I'd be inclined to
leave it as-is for the time being. I suspect that use-cases which can't
stomach the cost of the ISB can't stomach the cost of the vDSO at all.

Will
