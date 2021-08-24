Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04E2A3F6860
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 19:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241288AbhHXRsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 13:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240962AbhHXRsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 13:48:36 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 611F2C06122E
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 10:06:28 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id h1so8824472pjs.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 10:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MQ6pXiB5RbqFmCzc7qkdRUQBBhu9mgPy2yl/Odr1B+Q=;
        b=arNOw650gSkcbEsvJpHrW/uy+OQxY+AcLl5Euoqp5R6HG9rZbCmLJW2cKyaDzM/7uB
         Lhb0UrfOXBsXZAivsHGs71QGfyC/E9aTNBTFOGKbkZvQKnel45nvxEemnXHXdXsHQdUP
         8mSAMY6/PSbk9MU31fO9543Fdgd/ebGS1cXSQjZxMJnx+jODpRA6J73VXcmftH2uV3HT
         ejiiuYab3GUhMcrrSqvoSpRV8/uzEUaK8kqokVNOZbUWkTEKYMLYwfssey1Gl/aUC5WD
         zsqvlEbSB1QCgCX3E8LgaO2rdPydvsviTTJtjPBVjCnMAlVlF30GMVAKexwoGJFFJWA5
         zoNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MQ6pXiB5RbqFmCzc7qkdRUQBBhu9mgPy2yl/Odr1B+Q=;
        b=UN+xKXHlNrXcrVjSmDuB/56wqhuQawMk/ZqyMtVV2f+HZ8ld3otCUXCp21SxvcOnN3
         Ye/uZwHEa5L2QDzTNL7kMrUYFqb3LJ4ApF+J8RpQsjz/Vzkv48yA8bnexy7zYo19BHCC
         3ZO+Z3qMbGIMUorZjosE11+mOGvGEI2aZXhCKSYpV6H2Ep86W4aNmrq8a3GrujCqw8jg
         olULV+GAWZySMq/fSFqB2/qslfyWJBRlGwbyPnO+xO0MWAGX3wmYuu7jL+kUUoZikykh
         Cx9TT/SRcPzV7W1OPWrX3cM5cezdPdmefvFSvSBcUjfyahxD3+2rRdFahbZrhjFquKx5
         eY+g==
X-Gm-Message-State: AOAM533tMJWZuMk9ul5OANQs7cyrF/RiErY3Q57J4f0aTZ57eo358TwD
        J7EAevHZHYidJjmwWuhKqBdZzw==
X-Google-Smtp-Source: ABdhPJyFxc6Hoy1GTMwHqLR/xFLxZVSoMo+pFECFa9QC13JfcRcm8pcfAtzBvNqZTEFCklHijo83Xw==
X-Received: by 2002:a17:90a:8a84:: with SMTP id x4mr4605274pjn.72.1629824787648;
        Tue, 24 Aug 2021 10:06:27 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id t4sm9553131pfe.166.2021.08.24.10.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 10:06:27 -0700 (PDT)
Date:   Tue, 24 Aug 2021 17:06:21 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Borislav Petkov <bp@alien8.de>
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
Message-ID: <YSUnDQUrGYc8aY9j@google.com>
References: <20210804181329.2899708-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210804181329.2899708-9-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YSUaAQPiBUqubBHM@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSUaAQPiBUqubBHM@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021, Borislav Petkov wrote:
> On Wed, Aug 04, 2021 at 11:13:25AM -0700, Kuppuswamy Sathyanarayanan wrote:
> > +static __cpuidle void tdg_safe_halt(void)
> > +{
> > +	u64 ret;
> > +
> > +	/*
> > +	 * Enable interrupts next to the TDVMCALL to avoid
> > +	 * performance degradation.
> 
> That comment needs some more love to say exactly what the problem is.

LOL, I guess hanging the vCPU counts as degraded performance.  But this comment
can and should go away entirely...

> > +	 */
> > +	local_irq_enable();

...because this is broken.  It's also disturbing because it suggests that these
patches are not being tested.

The STI _must_ immediately precede TDCALL, and it _must_ execute with interrupts
disabled.  The whole point of the STI blocking shadow is to ensure interrupts are
blocked until _after_ the HLT completes so that a wake event is not recongized
before the HLT, in which case the vCPU will get stuck in HLT because its wake
event alreadyfired.  Enabling IRQs well before the TDCALL defeats the purpose of
the STI dance in __tdx_hypercall().

There's even a massive comment in __tdx_hypercall() explaining all this...

> > +
> > +	/* IRQ is enabled, So set R12 as 0 */

It would be helpful to use local variables to document what's up, e.g.

 	const bool irqs_enabled = true;
	const bool do_sti = true;

	ret = _tdx_hypercall(EXIT_REASON_HLT, irqs_enabled0, 0, 0, do_sti, NULL);
	
> > +	ret = _tdx_hypercall(EXIT_REASON_HLT, 0, 0, 0, 1, NULL);
> > +
> > +	/* It should never fail */
> > +	BUG_ON(ret);
> > +}
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
