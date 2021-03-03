Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 614CE32C0E8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:01:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1576263AbhCCSq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:46:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1575632AbhCCRfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 12:35:20 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CFCEC06175F
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 09:34:38 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id q204so15693848pfq.10
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 09:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=L/B2jvf8QSlBNCpUJ5UwPXNQmrmiUh/OC9Akzgb/wwc=;
        b=OiA0h0nrfLULZ/6jMpZb4g4oooUevKrxoPa6XlifCg9w18hRef/Dyg8gqmJIPb9oEu
         RwCU4vyzTu0cMPlYwZ85Ahwo6pJ4nYDm8ITWOipC7Dov8oaDT9/k1XcYMdVxgDQsU/MU
         1ugS/SQgLyojmLNJojqu72z3tiBgox8FHadme2NYINvGGe8mM/bjFjQbFVJqW9SwPJh3
         kNS0BYP+D2PYpQv82wMH2lvrjCVONbJKeC3urqTIpDPm0+8VCMuGqtBCfXe5X8bVVd4n
         z4b3jzdKKn3goS/VhSnWo6/Cwh5F7XctW+8GX3jYYhJIq62czD6DZZFht9izQND9KXQ3
         020A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L/B2jvf8QSlBNCpUJ5UwPXNQmrmiUh/OC9Akzgb/wwc=;
        b=tToOzCaeuRiLp4Bv57QVymscLftH4K9Q95dZnktUr2pQGhdk0WcZYq0e7rDyoZp55c
         InIuCbMDZT8M2QAjKeZElgzUgePr1e4nFCwI5IMD6HH90et6JWnA7T/98PYyrVd+CJDE
         rLTv1mJqs1OpKJBpZlW5yZRijC2H1hKBSkQtZxuJoCk06slWcKt/RoAMyfczRnUIbj8c
         RCsXPQT73POsURjjcCU5KzYQc3OjoonjAYt4w2w5v0d9AuOwmDwUrVAyGhz1d4hLWkHu
         BcgSUYgDztykPVv4xkRR6eD2EM2iz2+zfCAafTpDWY4uU/LoUXvuDnhP2qyzLVkDPhZs
         Pc7g==
X-Gm-Message-State: AOAM531ONtu9LNGKjev3FNUe5OB6HOEWLs7NUY/NQcLkEpsgX25JjAqB
        6SwbLOMAE8vRfW+mL7cuiqinLw==
X-Google-Smtp-Source: ABdhPJycQrx3E7BugZgolqSWOyhFJsTwwEHSd2HKVQrSDV2U4EfTJHf02e+XPeu6aivb5Y3cpTiAyA==
X-Received: by 2002:aa7:8292:0:b029:1ed:d6e5:1333 with SMTP id s18-20020aa782920000b02901edd6e51333mr3975963pfm.55.1614792877604;
        Wed, 03 Mar 2021 09:34:37 -0800 (PST)
Received: from google.com ([2620:15c:f:10:805d:6324:3372:6183])
        by smtp.gmail.com with ESMTPSA id x6sm23878717pfd.12.2021.03.03.09.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 09:34:37 -0800 (PST)
Date:   Wed, 3 Mar 2021 09:34:30 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Like Xu <like.xu@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>, wei.w.wang@intel.com,
        Borislav Petkov <bp@alien8.de>, kvm@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 8/9] KVM: x86: Expose Architectural LBR CPUID leaf
Message-ID: <YD/IeTdqbK9kEDNp@google.com>
References: <20210303135756.1546253-1-like.xu@linux.intel.com>
 <20210303135756.1546253-9-like.xu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210303135756.1546253-9-like.xu@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2021, Like Xu wrote:
> If CPUID.(EAX=07H, ECX=0):EDX[19] is set to 1, then KVM supports Arch
> LBRs and CPUID leaf 01CH indicates details of the Arch LBRs capabilities.
> Currently, KVM only supports the current host LBR depth for guests,
> which is also the maximum supported depth on the host.
> 
> Signed-off-by: Like Xu <like.xu@linux.intel.com>
> ---
>  arch/x86/kvm/cpuid.c   | 25 ++++++++++++++++++++++++-
>  arch/x86/kvm/vmx/vmx.c |  2 ++
>  2 files changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index b4247f821277..4473324fe7be 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -450,7 +450,7 @@ void kvm_set_cpu_caps(void)
>  		F(AVX512_4VNNIW) | F(AVX512_4FMAPS) | F(SPEC_CTRL) |
>  		F(SPEC_CTRL_SSBD) | F(ARCH_CAPABILITIES) | F(INTEL_STIBP) |
>  		F(MD_CLEAR) | F(AVX512_VP2INTERSECT) | F(FSRM) |
> -		F(SERIALIZE) | F(TSXLDTRK) | F(AVX512_FP16)
> +		F(SERIALIZE) | F(TSXLDTRK) | F(AVX512_FP16) | F(ARCH_LBR)
>  	);
>  
>  	/* TSC_ADJUST and ARCH_CAPABILITIES are emulated in software. */

...

> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 2f307689a14b..034708a3df20 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -7258,6 +7258,8 @@ static __init void vmx_set_cpu_caps(void)
>  		kvm_cpu_cap_clear(X86_FEATURE_INVPCID);
>  	if (vmx_pt_mode_is_host_guest())
>  		kvm_cpu_cap_check_and_set(X86_FEATURE_INTEL_PT);
> +	if (cpu_has_vmx_arch_lbr())
> +		kvm_cpu_cap_check_and_set(X86_FEATURE_ARCH_LBR);

Using kvm_cpu_cap_check_and_set(), which queries boot_cpu_has(), is only
necessary if a feature is not exposed by default in kvm_set_cpu_caps().  That's
why INTEL_PT uses it.  ARCH_LBR on the other hand is set in the "enable by
default" mask.

That being said, it's probably a bad idea to advertise ARCH_LBR by default.  In
the unlikely case that AMD adds support for ARCH_LBR, enable-by-default means
guest will be able to use ARCH_LBR on old KVMs that presumably would lack support
for ARCH_LBR on SVM.

TL;DR: omit F(ARCH_LBR) or replace it with "0 /* ARCH_LBR */".

>  	if (vmx_umip_emulated())
>  		kvm_cpu_cap_set(X86_FEATURE_UMIP);
> -- 
> 2.29.2
> 
