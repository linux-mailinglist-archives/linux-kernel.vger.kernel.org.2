Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 986133676E5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 03:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233957AbhDVBji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 21:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbhDVBjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 21:39:36 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F80EC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 18:39:02 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id f29so31669668pgm.8
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 18:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lDybqHzK/y1yZn9qxvSa709b8RB7R+WkFygDl36Yj78=;
        b=POndHXhhhdG4A4Iw/RN/PvqTsI2BwJLwLCst7FAczxc2onIIcGIqe3p+nsn/zy3Zgl
         DJkW8YlEqXKWYo8s6dPFgh94FRQmASkCSUrvykku2a+g3142IAfNxQ1pp9sZQx1ZKI4h
         do9lYfo6ntmVT/Nr8xcGUFzq6xFOHVEsMP6+bC9UuJCeMUhugReiGoZpMhy0CTyMiJA/
         qnoBcQFiWhqtNQlJZ9PotPnUojyEbx0/M7dcU0UH1NNTSVfPTkwj3CN/X6uP3ex8Qhvz
         dEoYOYxbyjuOKVkfkgSARFK4yY4Jeh0OIrBa7rZSNQQBUo30gNOcHzCEnWc9ABPpILG1
         5ttg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lDybqHzK/y1yZn9qxvSa709b8RB7R+WkFygDl36Yj78=;
        b=Ryzx05Gk25I6BTNjUhBXAE1FeJRcicJNI0nrjXBPo69FwgSPzvRB+CadI5KOnj+QDs
         utlDnHpyKTj5e6M1AOxiOBsxqzPDI976tyMWNDcT0MyBgRLlJ25jiXPqyqkG6zy5SDT4
         JtX+ZKJ+FOk71wy/d/mm4cNr+W1GjYHPcSWV9b8aQSJOSW7S6Wne5JnqV2OcyL/cDRjD
         PmuFo8iGxGfK20IWVRYdllqNoU2SugCknichrm4246NoPB/Wzp205XSAYegiqOQwLq/d
         RnXr33twla9yVikLZVXRPsUfjApPcTwdZg0z1fhdzdiF02PT7fsPYem04SXAVogrYUc7
         eKuw==
X-Gm-Message-State: AOAM533VNCFEnjnEYMAauAx6VKka+eRpvpLKx8g7R5ZsCDFD+G7FkuEo
        GxWeffmn+V8XSW1yL9NHXA2Upw==
X-Google-Smtp-Source: ABdhPJyHgDu1qcvMrtdOCrx4FXzU2PTqmcpHcb22EYzr0geSl2LrSLeEgL+gyW//YBqXnpW0VFwkOw==
X-Received: by 2002:a63:f4e:: with SMTP id 14mr1038224pgp.236.1619055541467;
        Wed, 21 Apr 2021 18:39:01 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id t19sm6189077pjs.1.2021.04.21.18.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 18:39:00 -0700 (PDT)
Date:   Thu, 22 Apr 2021 01:38:56 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Like Xu <like.xu@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 1/2] perf/x86: Skip checking MSR for MSR 0x0
Message-ID: <YIDTsMnSA8J5YwHJ@google.com>
References: <20210421021825.37872-1-like.xu@linux.intel.com>
 <YIBFCOz9R966xAVZ@google.com>
 <8b799e26-f8b0-adeb-b8a6-331087c0d4be@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b799e26-f8b0-adeb-b8a6-331087c0d4be@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021, Like Xu wrote:
> On 2021/4/21 23:30, Sean Christopherson wrote:
> > On Wed, Apr 21, 2021, Like Xu wrote:
> > > The Architecture LBR does not have MSR_LBR_TOS (0x000001c9).
> > > When ARCH_LBR we don't set lbr_tos, the failure from the
> > > check_msr() against MSR 0x000 will make x86_pmu.lbr_nr = 0,
> > > thereby preventing the initialization of the guest LBR.
> > > 
> > > Fixes: 47125db27e47 ("perf/x86/intel/lbr: Support Architectural LBR")
> > > Signed-off-by: Like Xu <like.xu@linux.intel.com>
> > > Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
> > > ---
> > >   arch/x86/events/intel/core.c | 4 ++--
> > >   1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> > > index 5272f349dca2..5036496caa60 100644
> > > --- a/arch/x86/events/intel/core.c
> > > +++ b/arch/x86/events/intel/core.c
> > > @@ -4751,10 +4751,10 @@ static bool check_msr(unsigned long msr, u64 mask)
> > >   	u64 val_old, val_new, val_tmp;
> > >   	/*
> > > -	 * Disable the check for real HW, so we don't
> > > +	 * Disable the check for real HW or non-sense msr, so we don't
> > 
> > I think this should be "undefined MSR" or something along those lines.  MSR 0x0
> > is a "real" MSR, on Intel CPUs it's an alias for IA32_MC0_ADDR; at least it's
> > supposed to be, most/all Intel CPUs incorrectly alias it to IA32_MC0_CTL.
> 
> Thank you, Sean.
> 
> <idle>-0       [000] dN.. 38980.032347: read_msr: 0, value fff
> 
> Do we have a historic story or specification for this kind of alias ?

It's kinda documented in the SDM under "2.1 ARCHITECTURAL MSRS"

  0H 0 IA32_P5_MC_ADDR (P5_MC_ADDR)  Pentium Processor (05_01H)
  1H 1 IA32_P5_MC_TYPE (P5_MC_TYPE)  DF_DM = 05_01H

The history is that very early machine check support only had a single "bank",
with MSR 0x0 holding the address and MSR 0x1 holding the type.  When the MSRs were
relocated to the 0x400 range, presumably to have room to grow the list, the MSRs
were aliased to maintain backwards compatibility (again, an assumption).

Unfortunately, that backwards compatibility apparently didn't get tested, and MSR
0x0 ended up aliased to 0x400 instead of 0x402.

The only reason I'm aware of all this because SGX is soft disabled by ucode if
any of the machine check banks are disabled by writing MCn_CTL.  Some folks found
out the hard way way doing WRMSR with an uninitialized index, i.e. WRMSR(0),
would disable SGX.

If you want a good giggle, you can verify on pretty much any Intel silicon:

  $ rdmsr 0x400
  ff
  $ wrmsr 0x0 0
  $ rdmsr 0x400
  0

> #define MSR_IA32_MC0_ADDR               0x00000402
> #define MSR_IA32_MC0_CTL                0x00000400
