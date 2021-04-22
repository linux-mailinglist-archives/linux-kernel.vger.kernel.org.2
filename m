Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6824367A28
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 08:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234963AbhDVGsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 02:48:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55458 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234877AbhDVGsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 02:48:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619074063;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H/ET1kgjZaDP9QqqrVOtr2KWqSYP34uoIbTEzMVDfWs=;
        b=XeNsM6SXirhocHOfc7SigLtyrW5DR9k30ghZnzDn+0HZHNJ8mYGHM5iAB+P8q+gmFhyhY+
        LLvsJZ9tp2G1R5S50vxGkyx25L3qkct78YFJ0OmjDbb8meB3qbKn4r8sTmboHZhWeMxZk6
        qLHe0TNmDi3rNmIzJUAZkvnUay6QME0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-588-mw3JQj-iMMq4OxDFqrLQ9w-1; Thu, 22 Apr 2021 02:47:39 -0400
X-MC-Unique: mw3JQj-iMMq4OxDFqrLQ9w-1
Received: by mail-ed1-f70.google.com with SMTP id r14-20020a50d68e0000b0290385504d6e4eso6278337edi.7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 23:47:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=H/ET1kgjZaDP9QqqrVOtr2KWqSYP34uoIbTEzMVDfWs=;
        b=AAW7kZhBXGKt5yJxxmAg/EP6EFOapM5tZlcoKfSupYGH8b6pvAUno1Uqz2pUlcnWFe
         lPZsxaHXOSlYOCZK0FP862KQjqYSeS4zb3k3y8vUfQ639j9htl5AnjIRc2UUMu+ReCTH
         H5d4lvlYnmCWB31Ai3mqt0jtzG5L3nRO6TutnAxTbKUfM7USz/jlURBgavz2EzBkvcJh
         xhlaZANQWr1WgGB0XHNxw5dFOHdEctyDX8ibhZe3cGVlvvHTUg/ZDpvMHUo5zw3fTYBQ
         Xtxi49rFOcA+KtOcYRFh9wy0cdWAeTZKQkKLMcFGjFuEpvWfm6tNyYBJYXZjcU3TVX2E
         zXTA==
X-Gm-Message-State: AOAM533/UGqdFsJHww7JCT7ZOersgztcDbmwPKst0pj4o6hbSHhFN78M
        U+T1ODtEMMluIRgfbCB7r99lWF42QMlFsU84dQ4FCX90uA8GMcLH8bsmCnox0Ra7GS7It2sHPL9
        qQDGmo/Awjd+SFvWnM9SvUFMy/yfieWyiDu8kTKzUiGuhBXsyq9T/uzhnWhuelVD8WSaNi1gfQ/
        /R
X-Received: by 2002:aa7:c78a:: with SMTP id n10mr1825579eds.239.1619074058489;
        Wed, 21 Apr 2021 23:47:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyoJOqKtEBxatEzxvvjy30R07QI7/KsZ8ywRC/exj0FTv9gLrgGET0BkO/O7mmUYWwGuAiJTQ==
X-Received: by 2002:aa7:c78a:: with SMTP id n10mr1825552eds.239.1619074058194;
        Wed, 21 Apr 2021 23:47:38 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id k9sm1244989eje.102.2021.04.21.23.47.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Apr 2021 23:47:37 -0700 (PDT)
Subject: Re: [PATCH] KVM: VMX: Intercept FS/GS_BASE MSR accesses for 32-bit
 KVM
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210422023831.3473491-1-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e38e22bd-933e-ff44-f398-63e0c3a6e25a@redhat.com>
Date:   Thu, 22 Apr 2021 08:47:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210422023831.3473491-1-seanjc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/04/21 04:38, Sean Christopherson wrote:
> Disable pass-through of the FS and GS base MSRs for 32-bit KVM.  Intel's
> SDM unequivocally states that the MSRs exist if and only if the CPU
> supports x86-64.  FS_BASE and GS_BASE are mostly a non-issue; a clever
> guest could opportunistically use the MSRs without issue.  KERNEL_GS_BASE
> is a bigger problem, as a clever guest would subtly be broken if it were
> migrated, as KVM disallows software access to the MSRs, and unlike the
> direct variants, KERNEL_GS_BASE needs to be explicitly migrated as it's
> not captured in the VMCS.
> 
> Fixes: 25c5f225beda ("KVM: VMX: Enable MSR Bitmap feature")
> Signed-off-by: Sean Christopherson <seanjc@google.com>

I added an explicit note that this is not for stable kernels.  The 
clever guest breaking after migration is the clever guest's problem.

> ---
> 
> Note, this breaks kvm-unit-tests on 32-bit KVM VMX due to the boot code
> using WRMSR(MSR_GS_BASE).  But, the tests are already broken on SVM, and
> have always been broken on SVM, which is honestly the main reason I
> didn't just turn a blind eye.  :-)  I post the fix shortly.

Fair enough.  Queued, thanks.

>   arch/x86/kvm/vmx/nested.c | 2 ++
>   arch/x86/kvm/vmx/vmx.c    | 4 ++++
>   2 files changed, 6 insertions(+)
> 
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index 8b111682fe5c..0f8c118ebc35 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -614,6 +614,7 @@ static inline bool nested_vmx_prepare_msr_bitmap(struct kvm_vcpu *vcpu,
>   	}
>   
>   	/* KVM unconditionally exposes the FS/GS base MSRs to L1. */
> +#ifdef CONFIG_X86_64
>   	nested_vmx_disable_intercept_for_msr(msr_bitmap_l1, msr_bitmap_l0,
>   					     MSR_FS_BASE, MSR_TYPE_RW);
>   
> @@ -622,6 +623,7 @@ static inline bool nested_vmx_prepare_msr_bitmap(struct kvm_vcpu *vcpu,
>   
>   	nested_vmx_disable_intercept_for_msr(msr_bitmap_l1, msr_bitmap_l0,
>   					     MSR_KERNEL_GS_BASE, MSR_TYPE_RW);
> +#endif
>   
>   	/*
>   	 * Checking the L0->L1 bitmap is trying to verify two things:
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 6501d66167b8..b58dc2d454f1 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -157,9 +157,11 @@ static u32 vmx_possible_passthrough_msrs[MAX_POSSIBLE_PASSTHROUGH_MSRS] = {
>   	MSR_IA32_SPEC_CTRL,
>   	MSR_IA32_PRED_CMD,
>   	MSR_IA32_TSC,
> +#ifdef CONFIG_X86_64
>   	MSR_FS_BASE,
>   	MSR_GS_BASE,
>   	MSR_KERNEL_GS_BASE,
> +#endif
>   	MSR_IA32_SYSENTER_CS,
>   	MSR_IA32_SYSENTER_ESP,
>   	MSR_IA32_SYSENTER_EIP,
> @@ -6969,9 +6971,11 @@ static int vmx_create_vcpu(struct kvm_vcpu *vcpu)
>   	bitmap_fill(vmx->shadow_msr_intercept.write, MAX_POSSIBLE_PASSTHROUGH_MSRS);
>   
>   	vmx_disable_intercept_for_msr(vcpu, MSR_IA32_TSC, MSR_TYPE_R);
> +#ifdef CONFIG_X86_64
>   	vmx_disable_intercept_for_msr(vcpu, MSR_FS_BASE, MSR_TYPE_RW);
>   	vmx_disable_intercept_for_msr(vcpu, MSR_GS_BASE, MSR_TYPE_RW);
>   	vmx_disable_intercept_for_msr(vcpu, MSR_KERNEL_GS_BASE, MSR_TYPE_RW);
> +#endif
>   	vmx_disable_intercept_for_msr(vcpu, MSR_IA32_SYSENTER_CS, MSR_TYPE_RW);
>   	vmx_disable_intercept_for_msr(vcpu, MSR_IA32_SYSENTER_ESP, MSR_TYPE_RW);
>   	vmx_disable_intercept_for_msr(vcpu, MSR_IA32_SYSENTER_EIP, MSR_TYPE_RW);
> 

