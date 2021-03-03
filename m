Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 569BC32C13B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1837079AbhCCSsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:48:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1835543AbhCCSEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 13:04:02 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC93C06175F
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 10:03:21 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id s23so4845076pji.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 10:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EZB5FybRq8qQJzZjsg9RL1K43u6gdJrGvoqJbzpIOAc=;
        b=GANJnuzl+xBpfT33zHPOMsOvR4RJflbUT9Y3LNZuctKjFTjUKxQA6YNZvB4c6Xne5G
         vkxjkIekkM16DqdyPX/NsuPeYd7KifCT2H+A8XrcrhCFNsqHdknBoF4WZ+WNk4Iu3Xu5
         bBHePIEy5bQJCY3cJRWdCR/TVHQ2pScActYFZkMeddBokyRgcMrmVt4DCIyWSpil43qd
         y0q86WeM6INR09Nb9hJZO8a2htWJdfz96mcoMAT7a9zfikwQy3sU3/bxnhqDEifKo2Xk
         W6VGP9eoc6QaQiD1qVmJzQD5UHb7mnGLuG/4Fr8FEO62N0qZaLK6y7GqpR/gffalUEc/
         Ql3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EZB5FybRq8qQJzZjsg9RL1K43u6gdJrGvoqJbzpIOAc=;
        b=kiTsybP0/f0Y3JXWngWY6AnaHi3CRS+D4ReRoYhQYTpfh5oVek+lxEdxfVlGVCpL0U
         k9hDPbdBgc40YRe72UR/TMMmhDyc1HPM65Y7rZZZfdKu3P8H0VSfHGU8d6yj3GgfPSqf
         swt3Ondl/0cTK3nQGsOJG8Rq3lW+668B5XBZc0yBKHteLUFrMI3VF3zwIs+jcUPtyCg1
         fq+eWz2M1IaQvqCMktFm1DItpZV+5kwpfcb/POdLurEVSnmQ9f53D2h1Napj8+lHGa09
         mTfdRHBh+a9MMwsUvJlZ74MU8O3z0Jw79gukFrbZS2qaBd7vzWk2Hbl13kFORfAyZNQH
         kk7A==
X-Gm-Message-State: AOAM53221eb7IFdsJGumupedk2nOjKJBT4ot+2TT1NbQcSGjEw8SxE4u
        aJiIsV4iYBij7lTfB2Ul4aGiCQ==
X-Google-Smtp-Source: ABdhPJxHiz9ohG6+W8dNXmMiMy9EY9e2DVip+EPXLXe1/ag47U0Nhl3U7ARwSbOllz5+QQBx4mIOyw==
X-Received: by 2002:a17:90b:4b0e:: with SMTP id lx14mr290874pjb.147.1614794601004;
        Wed, 03 Mar 2021 10:03:21 -0800 (PST)
Received: from google.com ([2620:15c:f:10:805d:6324:3372:6183])
        by smtp.gmail.com with ESMTPSA id v14sm1438168pju.19.2021.03.03.10.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 10:03:20 -0800 (PST)
Date:   Wed, 3 Mar 2021 10:03:14 -0800
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
Subject: Re: [PATCH v3 9/9] KVM: x86: Add XSAVE Support for Architectural LBRs
Message-ID: <YD/PYp0DtZaw2HYh@google.com>
References: <20210303135756.1546253-1-like.xu@linux.intel.com>
 <20210303135756.1546253-10-like.xu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210303135756.1546253-10-like.xu@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2021, Like Xu wrote:
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 034708a3df20..ec4593e0ee6d 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -7268,6 +7268,8 @@ static __init void vmx_set_cpu_caps(void)
>  	supported_xss = 0;
>  	if (!cpu_has_vmx_xsaves())
>  		kvm_cpu_cap_clear(X86_FEATURE_XSAVES);
> +	else if (kvm_cpu_cap_has(X86_FEATURE_ARCH_LBR))
> +		supported_xss |= XFEATURE_MASK_LBR;
>  
>  	/* CPUID 0x80000001 */
>  	if (!cpu_has_vmx_rdtscp())
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index d773836ceb7a..bca2e318ff24 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -10433,6 +10433,8 @@ int kvm_arch_hardware_setup(void *opaque)
>  
>  	if (!kvm_cpu_cap_has(X86_FEATURE_XSAVES))
>  		supported_xss = 0;
> +	else
> +		supported_xss &= host_xss;

Not your fault by any means, but I would prefer to have matching logic for XSS
and XCR0.  The existing clearing of supported_xss here is pointless.  E.g. I'd
prefer something like the following, though Paolo may have a different opinion.

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 6d7e760fdfa0..c781034463e5 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7244,12 +7244,15 @@ static __init void vmx_set_cpu_caps(void)
                kvm_cpu_cap_clear(X86_FEATURE_INVPCID);
        if (vmx_pt_mode_is_host_guest())
                kvm_cpu_cap_check_and_set(X86_FEATURE_INTEL_PT);
+       if (!cpu_has_vmx_arch_lbr()) {
+               kvm_cpu_cap_clear(X86_FEATURE_ARCH_LBR);
+               supported_xss &= ~XFEATURE_MASK_LBR;
+       }

        if (vmx_umip_emulated())
                kvm_cpu_cap_set(X86_FEATURE_UMIP);

        /* CPUID 0xD.1 */
-       supported_xss = 0;
        if (!cpu_has_vmx_xsaves())
                kvm_cpu_cap_clear(X86_FEATURE_XSAVES);

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 7b0adebec1ef..5f9eb1f5b840 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -205,6 +205,8 @@ static struct kvm_user_return_msrs __percpu *user_return_msrs;
                                | XFEATURE_MASK_BNDCSR | XFEATURE_MASK_AVX512 \
                                | XFEATURE_MASK_PKRU)

+#define KVM_SUPPORTED_XSS      XFEATURE_MASK_LBR
+
 u64 __read_mostly host_efer;
 EXPORT_SYMBOL_GPL(host_efer);

@@ -8037,6 +8039,11 @@ int kvm_arch_init(void *opaque)
                supported_xcr0 = host_xcr0 & KVM_SUPPORTED_XCR0;
        }

+       if (boot_cpu_has(X86_FEATURE_XSAVES))
+               rdmsrl(MSR_IA32_XSS, host_xss);
+               supported_xss = host_xss & KVM_SUPPORTED_XSS;
+       }
+
        if (pi_inject_timer == -1)
                pi_inject_timer = housekeeping_enabled(HK_FLAG_TIMER);
 #ifdef CONFIG_X86_64
@@ -10412,9 +10419,6 @@ int kvm_arch_hardware_setup(void *opaque)

        rdmsrl_safe(MSR_EFER, &host_efer);

-       if (boot_cpu_has(X86_FEATURE_XSAVES))
-               rdmsrl(MSR_IA32_XSS, host_xss);
-
        r = ops->hardware_setup();
        if (r != 0)
                return r;
@@ -10422,9 +10426,6 @@ int kvm_arch_hardware_setup(void *opaque)
        memcpy(&kvm_x86_ops, ops->runtime_ops, sizeof(kvm_x86_ops));
        kvm_ops_static_call_update();

-       if (!kvm_cpu_cap_has(X86_FEATURE_XSAVES))
-               supported_xss = 0;
-
 #define __kvm_cpu_cap_has(UNUSED_, f) kvm_cpu_cap_has(f)
        cr4_reserved_bits = __cr4_reserved_bits(__kvm_cpu_cap_has, UNUSED_);
 #undef __kvm_cpu_cap_has

