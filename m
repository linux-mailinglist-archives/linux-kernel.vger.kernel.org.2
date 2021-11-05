Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3C4C445D32
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 02:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231380AbhKEBMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 21:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbhKEBMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 21:12:37 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600F6C061203
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 18:09:58 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id y14-20020a17090a2b4e00b001a5824f4918so2177878pjc.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 18:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0+dEqVt+2ophPvZmp+KI9EcjQkXJrnBg/lM0XJ24f/c=;
        b=Gcu557BB2fXP4hU40swDUZve/9M9I6zPZd80V+FkO7Nj5VnjE+jP+1SRyU6wfJ2VNZ
         g0vliwxXUKXCtVcmhwSt/1wxCURGXj7jbWZHtm5gWxKW4IWewwuU6VSaOboh6kdvDHgI
         MmbUN75ZJbhaaOfoWUGHOmQxjFpGZZwcYFX1LOq+DOaKHsQyWjBZWTNcFhBMK7rcgXiT
         dW/g/ww8Av8diZ8bVMQs2xLLpm6UXJeDAYZE7gTtSDIvDTBpcQdD+lmSAvFGF9qalC0K
         RNc/XhL2Nik3XrtmpBZDVFkXibxB53ymU3bBq7CVIByW4NmiHZs+zs9t23mH0RvPzz2M
         e0CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0+dEqVt+2ophPvZmp+KI9EcjQkXJrnBg/lM0XJ24f/c=;
        b=AddT75nWU5MjW8gU3lvNDgpTURFL7FUDWfYlJsqzf1SvbLE1nACui7JtyitZFScdyk
         XtT7CUqbHP5fLlaQ3vVib+X8RrCk1F+S1j2v1zF5Tl2CofW2bJ+rhGnBkEyFtytJd5jT
         isZNfKQ2WyiG6qvoV0iTqJ1Z2zQxdG9ELXjpZKS5eepIJeqEzuNpyYvAzWUYKHdaneca
         4Sz4OSNYO6uW97mG5Vb2mrYaTY/7du2SYr7Rso8TYO/b40SQ4oRL/luWzuiCJfh99Q7X
         TKCDJukcpaaclLnNE6uJ8IC/8XE279QvXnUctJceXV5BK8Yp0tC/25heB/xPR+Zmfb4a
         Q6wg==
X-Gm-Message-State: AOAM532m3jvLYrqvf/3pRy2Wkqizo2721u0xRJuwR2mHYy7bk6YS9gkq
        hHjmeRjGjmzg0eH8zFyp2qbeTg==
X-Google-Smtp-Source: ABdhPJxTxkPdzYU2GUOkNhQ2SPI+4v7waKi0gk2h298C06UpJh1n/GknDTOgKVekkMuV0pW8v8CTHg==
X-Received: by 2002:a17:903:2045:b0:142:3d07:2866 with SMTP id q5-20020a170903204500b001423d072866mr4769841pla.17.1636074597722;
        Thu, 04 Nov 2021 18:09:57 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id g22sm3510733pfj.82.2021.11.04.18.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 18:09:57 -0700 (PDT)
Date:   Fri, 5 Nov 2021 01:09:53 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] KVM: nVMX: Implement Enlightened MSR Bitmap
 feature
Message-ID: <YYSEYY4h6NN7FGbR@google.com>
References: <20211013142258.1738415-1-vkuznets@redhat.com>
 <20211013142258.1738415-5-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013142258.1738415-5-vkuznets@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021, Vitaly Kuznetsov wrote:
> Updating MSR bitmap for L2 is not cheap and rearly needed. TLFS for Hyper-V
> offers 'Enlightened MSR Bitmap' feature which allows L1 hypervisor to
> inform L0 when it changes MSR bitmap, this eliminates the need to examine
> L1's MSR bitmap for L2 every time when 'real' MSR bitmap for L2 gets
> constructed.
> 
> Use 'vmx->nested.msr_bitmap_changed' flag to implement the feature.
> 
> Note, KVM already uses 'Enlightened MSR bitmap' feature when it runs as a
> nested hypervisor on top of Hyper-V. The newly introduced feature is going
> to be used by Hyper-V guests on KVM.
> 
> When the feature is enabled for Win10+WSL2, it shaves off around 700 CPU
> cycles from a nested vmexit cost (tight cpuid loop test).
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/kvm/hyperv.c     |  2 ++
>  arch/x86/kvm/vmx/nested.c | 20 ++++++++++++++++++--
>  2 files changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> index 6f11cda2bfa4..a00de1dbec57 100644
> --- a/arch/x86/kvm/hyperv.c
> +++ b/arch/x86/kvm/hyperv.c
> @@ -2516,6 +2516,8 @@ int kvm_get_hv_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid2 *cpuid,
>  
>  		case HYPERV_CPUID_NESTED_FEATURES:
>  			ent->eax = evmcs_ver;
> +			if (evmcs_ver)
> +				ent->eax |= HV_X64_NESTED_MSR_BITMAP;
>  
>  			break;
>  
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index bf4fa63ed371..7cd0c20d4557 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -608,15 +608,30 @@ static inline bool nested_vmx_prepare_msr_bitmap(struct kvm_vcpu *vcpu,
>  						 struct vmcs12 *vmcs12)
>  {
>  	int msr;
> +	struct vcpu_vmx *vmx = to_vmx(vcpu);
>  	unsigned long *msr_bitmap_l1;
> -	unsigned long *msr_bitmap_l0 = to_vmx(vcpu)->nested.vmcs02.msr_bitmap;
> -	struct kvm_host_map *map = &to_vmx(vcpu)->nested.msr_bitmap_map;
> +	unsigned long *msr_bitmap_l0 = vmx->nested.vmcs02.msr_bitmap;
> +	struct hv_enlightened_vmcs *evmcs = vmx->nested.hv_evmcs;
> +	struct kvm_host_map *map = &vmx->nested.msr_bitmap_map;

That reminds me, can my nested bitmap fixes get merged?  Superficial conflicts,
but still conflicts that I'd rather not have to resolve :-)

https://lkml.kernel.org/r/20210924204907.1111817-1-seanjc@google.com

>  
>  	/* Nothing to do if the MSR bitmap is not in use.  */
>  	if (!cpu_has_vmx_msr_bitmap() ||
>  	    !nested_cpu_has(vmcs12, CPU_BASED_USE_MSR_BITMAPS))
>  		return false;
>  
> +	/*
> +	 * MSR bitmap update can be skipped when:
> +	 * - MSR bitmap for L1 hasn't changed.
> +	 * - Nested hypervisor (L1) is attempting to launch the same L2 as
> +	 *   before.
> +	 * - Nested hypervisor (L1) has enabled 'Enlightened MSR Bitmap' feature
> +	 *   and tells KVM (L0) there were no changes in MSR bitmap for L2.
> +	 */
> +	if (!vmx->nested.msr_bitmap_force_recalc && evmcs &&
> +	    evmcs->hv_enlightenments_control.msr_bitmap &&
> +	    evmcs->hv_clean_fields & HV_VMX_ENLIGHTENED_CLEAN_FIELD_MSR_BITMAP)
> +		goto out_clear_msr_bitmap_force_recalc;

Huh?  Why clear it, it's already clear.  Any reason not to simply return true?

> +
>  	if (kvm_vcpu_map(vcpu, gpa_to_gfn(vmcs12->msr_bitmap), map))
>  		return false;
>  
> @@ -700,6 +715,7 @@ static inline bool nested_vmx_prepare_msr_bitmap(struct kvm_vcpu *vcpu,
>  
>  	kvm_vcpu_unmap(vcpu, &to_vmx(vcpu)->nested.msr_bitmap_map, false);
>  
> +out_clear_msr_bitmap_force_recalc:
>  	vmx->nested.msr_bitmap_force_recalc = false;
>  
>  	return true;
> -- 
> 2.31.1
> 
