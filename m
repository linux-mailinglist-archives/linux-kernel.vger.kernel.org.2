Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B00613F6871
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 19:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240731AbhHXR4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 13:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240289AbhHXR4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 13:56:15 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE26C0ABD9A
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 10:27:00 -0700 (PDT)
Received: from zn.tnic (p200300ec2f114400ce3b938495d443bc.dip0.t-ipconnect.de [IPv6:2003:ec:2f11:4400:ce3b:9384:95d4:43bc])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 17BCA1EC01FC;
        Tue, 24 Aug 2021 19:26:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1629826015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=m61In6NJJn31NsQpmVUXM5HbwUlkskAyI7Dz3Lj2QTw=;
        b=IbGCV1OvgFa23xIkXbR7ruCZA/xy36MZdKWLHxG3oDsAwScCIIjwdGsXS52EhO8t79++f1
        rXhebmeu1m6dFGSWWy6Sw+tZKKHwwvbQ0nTvz5+frrsoTWrAV1IIKxONsCc4MOQDTM8WXM
        vMFAeVIByJXnGECTubyo6fNMtm/MTVE=
Date:   Tue, 24 Aug 2021 19:27:33 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter H Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 08/12] x86/tdx: Add HLT support for TDX guest
Message-ID: <YSUsBVx2DD7MCyn/@zn.tnic>
References: <20210804181329.2899708-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210804181329.2899708-9-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YSUaAQPiBUqubBHM@zn.tnic>
 <YSUnDQUrGYc8aY9j@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YSUnDQUrGYc8aY9j@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021 at 05:06:21PM +0000, Sean Christopherson wrote:
> On Tue, Aug 24, 2021, Borislav Petkov wrote:
> > On Wed, Aug 04, 2021 at 11:13:25AM -0700, Kuppuswamy Sathyanarayanan wrote:
> > > +static __cpuidle void tdg_safe_halt(void)
> > > +{
> > > +	u64 ret;
> > > +
> > > +	/*
> > > +	 * Enable interrupts next to the TDVMCALL to avoid
> > > +	 * performance degradation.
> > 
> > That comment needs some more love to say exactly what the problem is.
> 
> LOL, I guess hanging the vCPU counts as degraded performance.  But this comment
> can and should go away entirely...
> 
> > > +	 */
> > > +	local_irq_enable();
> 
> ...because this is broken.  It's also disturbing because it suggests that these
> patches are not being tested.

My complaint since '88.

> The STI _must_ immediately precede TDCALL, and it _must_ execute with interrupts
> disabled.  The whole point of the STI blocking shadow is to ensure interrupts are
> blocked until _after_ the HLT completes so that a wake event is not recongized
> before the HLT, in which case the vCPU will get stuck in HLT because its wake
> event alreadyfired.  Enabling IRQs well before the TDCALL defeats the purpose of
> the STI dance in __tdx_hypercall().

Wait, whaaaat?!

So tdg_halt() does that but tdg_safe_halt() goes to great lengths not to
do it. And it looks all legit and all, like it really wanted to do it
differently. WTF?

> There's even a massive comment in __tdx_hypercall() explaining all this...
> 
> > > +
> > > +	/* IRQ is enabled, So set R12 as 0 */
> 
> It would be helpful to use local variables to document what's up, e.g.
> 
>  	const bool irqs_enabled = true;
> 	const bool do_sti = true;
> 
> 	ret = _tdx_hypercall(EXIT_REASON_HLT, irqs_enabled0, 0, 0, do_sti, NULL);

Wait, is this do_sti thing supposed to be:

	 * ... But this
         * change is not required for all HLT cases. So use R15
         * register value to identify the case which needs sti. So,
         * if R11 is EXIT_REASON_HLT and R15 is 1, then call sti
         * before TDCALL instruction.

?


> > > +	ret = _tdx_hypercall(EXIT_REASON_HLT, 0, 0, 0, 1, NULL);
						      ^^^
Yeah, it must be it - the 1 there.

And what's with the irqs_enabled first parameter?

Is that used by the TDX module?

I think in the next version all those _tdx_hypercall() wrappers should
spell it out what the parameters they pass are used for.

Hohumm.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
