Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14E873687BE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 22:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237044AbhDVUNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 16:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236822AbhDVUNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 16:13:14 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB02CC061756
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 13:12:38 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id s14so17070230pjl.5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 13:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=onndBTWCVVtUsDToOgfozcoqZwBJW8v5a1nLj/MlTdU=;
        b=Lp/XUimHrDV1smviyim44MWKeseR6U7WQabJDh6sD9xlsNlv/0fB9L8V6EMjYNzw7w
         vyxpYaK+3qH3xvp+yEcl25iInDVcoBfBiKFe2L3FRmG3mamr62oTmcywH05lkp8MvvN6
         ok9IgNQz2R8qw6foKGFmA0hI87ZIOFaJLXi+eNKMxFCty7gKYjWVvCeeHEgrslQB4AD2
         1p+V1FnPj/XHA8OninWTtUiqe8Za04cnXc71Y0dDQhkTjALn8mrEve1IUUIhDlBAaVpi
         pRjXg5RiuNF9ajzozJW3xji9890Nf6AWX0L/X/yOUsFtfm8WR2Wqcvamve3zrxE+S0ut
         EnDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=onndBTWCVVtUsDToOgfozcoqZwBJW8v5a1nLj/MlTdU=;
        b=mjg/4ABtyXljLaEJNWA20whKb5jNAqpoZQwYRgdGhFT5Rg8s9c7db8CxTuSbU0NLcE
         s7K8DIwckOqpsmaISm07qYdrDuIlUx0d/zBYKSSxW7GJDmsOVCq7Wsmt+NldYvi+7g5a
         NEyPputIRZ66VHeh/Xm7h5KxSxLfZ2sVtg9ESfIlgdtwvk/AtlmkHJsMtwRkU+DPMz29
         RNVvXUvNCRHNzwB6z13/2DOCPwNizvEKNtePwX3IMdXkAdiJWCtmjem9bkD/KN4657sw
         8X3XNuVYQLifb4PwBkrQpM0rz1bM7e+veokkMPfdPRAh2V4c2b580E5PMz9XsbgkUMMQ
         VNzQ==
X-Gm-Message-State: AOAM531ROpFNejhSLXBjunXmqhwNloHQgKfdc+lfUFK+b4g0SUOBvzK5
        jZg64vzmQNGNX3zb+trfU0QFVw==
X-Google-Smtp-Source: ABdhPJzINFc4GDy8Bg6QYYNmfxXlfft7755s6vfx0y+WZI/Q/gBcOzBkOkXbGVOkYYpOcS0i5o8+fg==
X-Received: by 2002:a17:902:a582:b029:ec:d002:623b with SMTP id az2-20020a170902a582b02900ecd002623bmr563979plb.36.1619122358251;
        Thu, 22 Apr 2021 13:12:38 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id r14sm5719673pjz.43.2021.04.22.13.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 13:12:37 -0700 (PDT)
Date:   Thu, 22 Apr 2021 20:12:33 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Reiji Watanabe <reijiw@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v2] KVM: SVM: Delay restoration of host MSR_TSC_AUX until
 return to userspace
Message-ID: <YIHYsa1+psfnszcv@google.com>
References: <20210422001736.3255735-1-seanjc@google.com>
 <CAAeT=FxaRV+za7yk8_9p45k4ui3QJx90gN4b8k4egrxux=QWFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAeT=FxaRV+za7yk8_9p45k4ui3QJx90gN4b8k4egrxux=QWFA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Tom

On Thu, Apr 22, 2021, Reiji Watanabe wrote:
> @@ -2893,12 +2882,15 @@ static int svm_set_msr(struct kvm_vcpu *vcpu,
> struct msr_data *msr)
>                         return 1;
> 
>                 /*
> -                * This is rare, so we update the MSR here instead of using
> -                * direct_access_msrs.  Doing that would require a rdmsr in
> -                * svm_vcpu_put.
> +                * TSC_AUX is usually changed only during boot and never read
> +                * directly.  Intercept TSC_AUX instead of exposing it to the
> +                * guest via direct_acess_msrs, and switch it via user return.
>                  */
> 
> 'direct_acess_msrs' should be 'direct_access_msrs'.
> 
> 
>                 svm->tsc_aux = data;
> -               wrmsrl(MSR_TSC_AUX, svm->tsc_aux);
> +
> +               preempt_disable();
> +               kvm_set_user_return_msr(TSC_AUX_URET_SLOT, data, -1ull);
> +               preempt_enable();
>                 break;
> 
> One of the callers of svm_set_msr() is kvm_arch_vcpu_ioctl(KVM_SET_MSRS).
> Since calling kvm_set_user_return_msr() looks unnecessary for the ioctl
> case and makes extra things for the CPU to do when the CPU returns to
> userspace for the case, I'm wondering if it might be better to check
> svm->guest_state_loaded before calling kvm_set_user_return_msr() here.

Ugh.  AMD support for MSR_TSC_AUX is a train wreck.

Looking at VMX again, the reason it calls kvm_set_user_return_msr()
unconditionally is so that it can check the result of the WRMSR and inject #GP
into the guest if the WRMSR failed.

At first blush, that would appear to be unnecessary since host support for
MSR_TSC_AUX was already confirmed.  But on Intel, bits 63:32 of MSR_TSC_AUX are
actually "reserved", so in theory this code should not check guest_state_loaded,
but instead check the result and inject #GP as appropriate.

However, I put "reserved" in quotes because AMD CPUs apparently don't actually
do a reserved check.  Sadly, the APM doesn't say _anything_ about those bits in
the context of MSR access, the RDTSCP entry simply states that RCX contains bits
31:0 of the MSR, zero extended.  But even worse, the RDPID description implies
that it can consume all 64 bits of the MSR:

  RDPID reads the value of TSC_AUX MSR used by the RDTSCP instruction into the
  specified destination register. Normal operand size prefixes do not apply and
  the update is either 32 bit or 64 bit based on the current mode.

Intel has identical behavior for RDTSCP and RDPID, but because Intel CPUs
actually prevent software from writing bits 63:32, they haven't shot themselves
in the proverbial foot.

All that said, the AMD behavior of dropping the bits across the board actually
plays into KVM's favor because we can leverage it to support cross-vendor
migration.  I.e. explicitly drop svm->tsc_aux[63:32] on read (or clear on write),
that way userspace doesn't have to fudge the value itself when migrating an
adventurous guest from AMD to Intel.

Lastly, this flow is also missing a check on guest_cpuid_has().

All in all, I think we want this:

	case MSR_TSC_AUX:
		if (!boot_cpu_has(X86_FEATURE_RDTSCP))
			return 1;

		if (!msr_info->host_initiated &&
		    !guest_cpuid_has(vcpu, X86_FEATURE_RDTSCP))
			return 1;

		/*
		 * TSC_AUX is usually changed only during boot and never read
		 * directly.  Intercept TSC_AUX instead of exposing it to the
		 * guest via direct_access_msrs, and switch it via user return.
		 */
		preempt_disable();
		r = kvm_set_user_return_msr(TSC_AUX_URET_SLOT, data, -1ull);
		preempt_enable();
		if (r)
			return 1;

		/*
		 * Bits 63:32 are dropped by AMD CPUs, but are reserved on
		 * Intel CPUs.  AMD's APM has incomplete and conflicting info
		 * on the architectural behavior; emulate current hardware as
		 * doing so ensures migrating from AMD to Intel won't explode.
		 */
		svm->tsc_aux = (u32)data;
		break;
