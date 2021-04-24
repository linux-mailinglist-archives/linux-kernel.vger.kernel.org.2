Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C599369FF1
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 09:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbhDXHUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 03:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbhDXHUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 03:20:16 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87620C06174A
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 00:19:38 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id w10so306146pgh.5
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 00:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hn51PY3pPm3kGtoDtPX4jjQp72j/PPh9WRN9t50CmqE=;
        b=kSJvGQDYFGHgB0/HnxoNSOhSHoQguJz14XtPApVtLtOyyYDK0iZb9ylkgJK3ubHNde
         A30YOMdL9iF/EfqRxzzEhQC1l1JaQzhPB/f/7dErvYGPAIu5NVWqU6UmGY1uGFJkpBlr
         /1K++6qvqqt7r4UDg88MPbW/73BldH9u//UKplas1k14WgxE+Oue93gUyOmGBNIL0wvr
         a3ldCCij0Zs/GvDka8qbSZ5Nlx8GXcwzOWaRSMCda/2gpeCaDeiSq2xALrL+RO9II7eX
         1jkuzUY5hfzNtpFZdYmCHMxmJ193/p5OYCjxwlFiECL98mocQmYtT+NbTJxfBm2QxIdk
         fK9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hn51PY3pPm3kGtoDtPX4jjQp72j/PPh9WRN9t50CmqE=;
        b=FtmWe4oDFWg7JI8BKdDFnZywaSU1es2pmPpIa4ASLx3e3FsRjClJ0aXk5rPkKNaizx
         LDe1H07ZqjrgwApAm8TyZjgCwh4FI0ZGSCvirfC2drd4/M5eAaeXuAQ5eqTgJ/ahqPzp
         LVRXgjbFcCQri7Uvd+NaAETducXSA1Jv9RVDF0WJfEKf+mcUEqjUPxNUhsEJ1tFe3stV
         TETuOdRuEzkPomT0YhuU4AjYoCkhSEHVQMktapKSYZ37XHErltJo3Kpc0rHmBOE01ThM
         d6wv26X7AogFKYqkrWq8LqhHQidoHPbKyzlHcpgbunyDeO7iRRcgJAVKH9xCi/XNZuO+
         A3zA==
X-Gm-Message-State: AOAM532umBYar5qOmSneqJQVd9vDHP2TfhS/ZddDJPSavdrH7KHMxZFK
        huKmD4972czVssTRLRX3+asWUPbAGmKbbplm8ONWfA==
X-Google-Smtp-Source: ABdhPJwxgoUJMtmz8jI1rLJsBnHJOS6IoMNPMyg2Bsm6KR3jRbbWp6mUrsGinx0hcYto5eFPQ6cclf/7+19x9xGh2SY=
X-Received: by 2002:a05:6a00:15cb:b029:25c:a742:d34d with SMTP id
 o11-20020a056a0015cbb029025ca742d34dmr7330299pfu.25.1619248777694; Sat, 24
 Apr 2021 00:19:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210423223404.3860547-1-seanjc@google.com> <20210423223404.3860547-4-seanjc@google.com>
In-Reply-To: <20210423223404.3860547-4-seanjc@google.com>
From:   Reiji Watanabe <reijiw@google.com>
Date:   Sat, 24 Apr 2021 00:19:21 -0700
Message-ID: <CAAeT=FxhkRhwysd4mQa=iqEaje7R5nHew8ougtoyDEhL2sYxGA@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] KVM: x86: Tie Intel and AMD behavior for
 MSR_TSC_AUX to guest CPU model
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -1610,6 +1610,29 @@ static int __kvm_set_msr(struct kvm_vcpu *vcpu, u32 index, u64 data,
>                  * invokes 64-bit SYSENTER.
>                  */
>                 data = get_canonical(data, vcpu_virt_addr_bits(vcpu));
> +               break;
> +       case MSR_TSC_AUX:
> +               if (!kvm_cpu_cap_has(X86_FEATURE_RDTSCP))
> +                       return 1;
> +
> +               if (!host_initiated &&
> +                   !guest_cpuid_has(vcpu, X86_FEATURE_RDTSCP))
> +                       return 1;
> +
> +               /*
> +                * Per Intel's SDM, bits 63:32 are reserved, but AMD's APM has
> +                * incomplete and conflicting architectural behavior.  Current
> +                * AMD CPUs completely ignore bits 63:32, i.e. they aren't
> +                * reserved and always read as zeros.  Enforce Intel's reserved
> +                * bits check if and only if the guest CPU is Intel, and clear
> +                * the bits in all other cases.  This ensures cross-vendor
> +                * migration will provide consistent behavior for the guest.
> +                */
> +               if (guest_cpuid_is_intel(vcpu) && (data >> 32) != 0)
> +                       return 1;
> +
> +               data = (u32)data;
> +               break;
>         }
>
>         msr.data = data;
> @@ -1646,6 +1669,17 @@ int __kvm_get_msr(struct kvm_vcpu *vcpu, u32 index, u64 *data,
>         if (!host_initiated && !kvm_msr_allowed(vcpu, index, KVM_MSR_FILTER_READ))
>                 return KVM_MSR_RET_FILTERED;
>
> +       switch (index) {
> +       case MSR_TSC_AUX:
> +               if (!kvm_cpu_cap_has(X86_FEATURE_RDTSCP))
> +                       return 1;
> +
> +               if (!host_initiated &&
> +                   !guest_cpuid_has(vcpu, X86_FEATURE_RDTSCP))
> +                       return 1;


It looks Table 2-2 of the Intel SDM Vol4 (April 2021) says
TSC_AUX is supported:

   If CPUID.80000001H:EDX[27] = 1 or CPUID.(EAX=7,ECX=0):ECX[22] = 1

Should we also check X86_FEATURE_RDPID before returning 1
due to no RDTSCP support ?
There doesn't seem to be a similar description in the APM though.

Thanks,
Reiji
