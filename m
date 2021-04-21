Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F4035366F2C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 17:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240780AbhDUPaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 11:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238526AbhDUPay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 11:30:54 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D682C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 08:30:21 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id p16so17892886plf.12
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 08:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=66B2gxSRDO1UhRSlUXQqaq82UG5jc0B6v7Wq///8Fvg=;
        b=aKHS4AS8T9TbS2RDVl2a39inxJIvy5TRJQWJvYPBPe3iknI6pZaZRtS2/UEBRHKuRm
         4hknkmpa9H5yuBbSYa0dLPRJ7hmWXfIpHHN+QyLYNJBWtxpmtse2lKv4UpU9Rf36h0Pd
         X3qnS7WzG4fFtNmGnWPC91GqbCVAKzLwso5GASOHQe8O1u/CQo15Y/T7ao2nWW7nBd5h
         CcYrQlRFHGIsdFsXTOdrfFf8pCv67JVQSm0yxQjLPg2Kt9JSfQzeZWYk0JFK83Eij9DM
         7G/R+glTe0LNWf48jSNVMsFubwPSYHYPbHQuMeUg+bPVq3dcEKtOm5QAwgc3fWIaJezc
         vCog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=66B2gxSRDO1UhRSlUXQqaq82UG5jc0B6v7Wq///8Fvg=;
        b=ebyHCMc3dMgLuaM3/TIuN+2KEp4cp7yGN/HFAQ9mIDAsAOVIfgneR8ttGpCmcdpoH7
         cJvdKd0K+OTn4NkboonXoZOv2lklV9G6kQH241T3G10ar1+AWEreaREGm5G5SuCU+O+B
         1hpYE6TUQmnQENAuYpjzyI2T+B4qteBOVk8P3Mh6sbllgTbHSe3tcGktvlE2COk9vTRP
         jKb9wb9IoEEgK13tzo8NJ08hZtMcVQcqMcGkGp2NMiPWN5zLRRhHU37OWuJIEh3+9hI6
         lNtrYhror7uimc4vytcIfCvCGazb4vcpylnvwADO5ECygLqovHF3oMU1FtrXtlkaYuE2
         mypA==
X-Gm-Message-State: AOAM5307enZXh3gpKBy47xYCazoNCHlUek6PZBJfnWJGy+xXCrI4RGm1
        81pZfScdSPFot2ZeuAe3mWpDgw==
X-Google-Smtp-Source: ABdhPJyDNI2n/Q8rzImiJIJQHowgxYx0oRw1Z9pR/iEtIh+sPa2muf7qwv9b8lM1f5ZXD5+jucjhog==
X-Received: by 2002:a17:902:7689:b029:eb:3d5f:ae58 with SMTP id m9-20020a1709027689b02900eb3d5fae58mr34072360pll.39.1619019020641;
        Wed, 21 Apr 2021 08:30:20 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id 195sm2091418pfy.194.2021.04.21.08.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 08:30:19 -0700 (PDT)
Date:   Wed, 21 Apr 2021 15:30:16 +0000
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
Message-ID: <YIBFCOz9R966xAVZ@google.com>
References: <20210421021825.37872-1-like.xu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421021825.37872-1-like.xu@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021, Like Xu wrote:
> The Architecture LBR does not have MSR_LBR_TOS (0x000001c9).
> When ARCH_LBR we don't set lbr_tos, the failure from the
> check_msr() against MSR 0x000 will make x86_pmu.lbr_nr = 0,
> thereby preventing the initialization of the guest LBR.
> 
> Fixes: 47125db27e47 ("perf/x86/intel/lbr: Support Architectural LBR")
> Signed-off-by: Like Xu <like.xu@linux.intel.com>
> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  arch/x86/events/intel/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 5272f349dca2..5036496caa60 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -4751,10 +4751,10 @@ static bool check_msr(unsigned long msr, u64 mask)
>  	u64 val_old, val_new, val_tmp;
>  
>  	/*
> -	 * Disable the check for real HW, so we don't
> +	 * Disable the check for real HW or non-sense msr, so we don't

I think this should be "undefined MSR" or something along those lines.  MSR 0x0
is a "real" MSR, on Intel CPUs it's an alias for IA32_MC0_ADDR; at least it's
supposed to be, most/all Intel CPUs incorrectly alias it to IA32_MC0_CTL.

Anyways, my point is that if your definition of "nonsense" is any MSR that is
not a valid perf MSR, then this check is woefully incompletely.  If your
definition is a nonsensical value, then this comment is simply wrong.

What you're really looking for is precisely the case where the MSR was zero
initialized and never defined.

>  	 * mess with potentionaly enabled registers:
>  	 */
> -	if (!boot_cpu_has(X86_FEATURE_HYPERVISOR))
> +	if (!boot_cpu_has(X86_FEATURE_HYPERVISOR) || !msr)
>  		return true;
>  
>  	/*
> -- 
> 2.30.2
> 
