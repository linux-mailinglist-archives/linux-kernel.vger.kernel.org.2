Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A71FE365EA0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 19:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233453AbhDTRbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 13:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233410AbhDTRbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 13:31:44 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B37C06138B
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 10:31:13 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id e8-20020a17090a7288b029014e51f5a6baso15728860pjg.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 10:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+cZwMLVh428J9ba7XrLjwfORQpUM04LO/nF0EZ5hFTM=;
        b=r3IoxZ9jZlolZSo+i+0Vq2IufeBoUFpDuDR0L20PtvSGfrMJCT1GOYZYxupM2WgI4k
         TAXWysLXlofqhYqa9y//84RLacBcIRCRd7KGhjVQtf1Ww3ni4EVqn/qhXTdAKt/i2fX8
         D/H8XkRVTeApI4Us7+5ZyslL5n8+XX5CPeFCOqRi4/f6L9y9/y2zEuzHLERFXqpKW/Zp
         Nlmf9nWy0TDPNTvtTAkBOSep6FqmYLRFo+M1QfCkmA4sBRTtaM5BVlHu2+8NPAgObC9/
         bNoO3f27ONNmN+Tkm2cYq7s/dXEAcBqIM5o+DyxYQspQDSzk1UGJA5kf7kFpnxAmKA2z
         /ZUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+cZwMLVh428J9ba7XrLjwfORQpUM04LO/nF0EZ5hFTM=;
        b=oizVX/wzld6tEp+XCPFlRdRuLFFRotKMXt9D1oyYelnVVjswiretSawLLbypXBwG4O
         T7HLpzi+aHLkjS0sCHUaji1BrNoHDxvSJhi4nZw1Z8kLmoMPZh9IT7i/S9L1JwQDVaHz
         TMw9dmMBs1CpaVIZ3Q1rbKFpM2Vs9M1ETPQTacL6lNDid2QxCdc2l4vxBlgEUHqhxmIe
         1+DV7xtFDCXNMkPE+9fXMRa2DWFTTczitji5RoqI8BGll6XtG5hzJVNgXGlVtBpDcKlx
         PsCM7GyPwitsV4WH1T8L5MeRd5xF+U36ciY0BKhmTtU/FCfA0pLKoceQB3RGIzNPmmTG
         emYg==
X-Gm-Message-State: AOAM532VUTHi382z5FUtLlN94+99yLbUDtXyApiRid5P/f7sTh301YLs
        3ES0WovcC/OctTxj6c+tQF4ygg==
X-Google-Smtp-Source: ABdhPJwrZR8nItfvVcawfuMxX3jUZ9FHCHMKKeXULvPy9U5vVnTz853le/MVQhnw6J6XjwZz8CeD/g==
X-Received: by 2002:a17:90a:7566:: with SMTP id q93mr6024441pjk.103.1618939872429;
        Tue, 20 Apr 2021 10:31:12 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id x18sm8007016pfp.57.2021.04.20.10.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 10:31:11 -0700 (PDT)
Date:   Tue, 20 Apr 2021 17:31:07 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        srutherford@google.com, joro@8bytes.org, brijesh.singh@amd.com,
        thomas.lendacky@amd.com, venu.busireddy@oracle.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, Ashish Kalra <ashish.kalra@amd.com>
Subject: Re: [PATCH 0/3] KVM: x86: guest interface for SEV live migration
Message-ID: <YH8P26OibEfxvJAu@google.com>
References: <20210420112006.741541-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210420112006.741541-1-pbonzini@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20, 2021, Paolo Bonzini wrote:
> From ef78673f78e3f2eedc498c1fbf9271146caa83cb Mon Sep 17 00:00:00 2001
> From: Ashish Kalra <ashish.kalra@amd.com>
> Date: Thu, 15 Apr 2021 15:57:02 +0000
> Subject: [PATCH 2/3] KVM: X86: Introduce KVM_HC_PAGE_ENC_STATUS hypercall
> 
> This hypercall is used by the SEV guest to notify a change in the page
> encryption status to the hypervisor. The hypercall should be invoked
> only when the encryption attribute is changed from encrypted -> decrypted
> and vice versa. By default all guest pages are considered encrypted.
> 
> The hypercall exits to userspace to manage the guest shared regions and
> integrate with the userspace VMM's migration code.

...

> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index fd4a84911355..2bc353d1f356 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -6766,3 +6766,14 @@ they will get passed on to user space. So user space still has to have
>  an implementation for these despite the in kernel acceleration.
>  
>  This capability is always enabled.
> +
> +8.32 KVM_CAP_EXIT_HYPERCALL
> +---------------------------
> +
> +:Capability: KVM_CAP_EXIT_HYPERCALL
> +:Architectures: x86
> +:Type: vm
> +
> +This capability, if enabled, will cause KVM to exit to userspace
> +with KVM_EXIT_HYPERCALL exit reason to process some hypercalls.
> +Right now, the only such hypercall is KVM_HC_PAGE_ENC_STATUS.
> diff --git a/Documentation/virt/kvm/cpuid.rst b/Documentation/virt/kvm/cpuid.rst
> index cf62162d4be2..c9378d163b5a 100644
> --- a/Documentation/virt/kvm/cpuid.rst
> +++ b/Documentation/virt/kvm/cpuid.rst
> @@ -96,6 +96,11 @@ KVM_FEATURE_MSI_EXT_DEST_ID        15          guest checks this feature bit
>                                                 before using extended destination
>                                                 ID bits in MSI address bits 11-5.
>  
> +KVM_FEATURE_HC_PAGE_ENC_STATUS     16          guest checks this feature bit before
> +                                               using the page encryption state
> +                                               hypercall to notify the page state
> +                                               change

...

>  int kvm_emulate_hypercall(struct kvm_vcpu *vcpu)
>  {
>  	unsigned long nr, a0, a1, a2, a3, ret;
> @@ -8334,6 +8346,28 @@ int kvm_emulate_hypercall(struct kvm_vcpu *vcpu)
>  		kvm_sched_yield(vcpu, a0);
>  		ret = 0;
>  		break;
> +	case KVM_HC_PAGE_ENC_STATUS: {
> +		u64 gpa = a0, npages = a1, enc = a2;
> +
> +		ret = -KVM_ENOSYS;
> +		if (!vcpu->kvm->arch.hypercall_exit_enabled)

I don't follow, why does the hypercall need to be gated by a capability?  What
would break if this were changed to?

		if (!guest_pv_has(vcpu, KVM_FEATURE_HC_PAGE_ENC_STATUS))

> +			break;
> +
> +		if (!PAGE_ALIGNED(gpa) || !npages ||
> +		    gpa_to_gfn(gpa) + npages <= gpa_to_gfn(gpa)) {
> +			ret = -EINVAL;
> +			break;
> +		}
> +
> +		vcpu->run->exit_reason        = KVM_EXIT_HYPERCALL;
> +		vcpu->run->hypercall.nr       = KVM_HC_PAGE_ENC_STATUS;
> +		vcpu->run->hypercall.args[0]  = gpa;
> +		vcpu->run->hypercall.args[1]  = npages;
> +		vcpu->run->hypercall.args[2]  = enc;
> +		vcpu->run->hypercall.longmode = op_64_bit;
> +		vcpu->arch.complete_userspace_io = complete_hypercall_exit;
> +		return 0;
> +	}
>  	default:
>  		ret = -KVM_ENOSYS;
>  		break;

...

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 590cc811c99a..d696a9f13e33 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -3258,6 +3258,14 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  		vcpu->arch.msr_kvm_poll_control = data;
>  		break;
>  
> +	case MSR_KVM_MIGRATION_CONTROL:
> +		if (data & ~KVM_PAGE_ENC_STATUS_UPTODATE)
> +			return 1;
> +
> +		if (data && !guest_pv_has(vcpu, KVM_FEATURE_HC_PAGE_ENC_STATUS))

Why let the guest write '0'?  Letting the guest do WRMSR but not RDMSR is
bizarre.

> +			return 1;
> +		break;
> +
>  	case MSR_IA32_MCG_CTL:
>  	case MSR_IA32_MCG_STATUS:
>  	case MSR_IA32_MC0_CTL ... MSR_IA32_MCx_CTL(KVM_MAX_MCE_BANKS) - 1:
> @@ -3549,6 +3557,12 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  		if (!guest_pv_has(vcpu, KVM_FEATURE_ASYNC_PF))
>  			return 1;
>  
> +		msr_info->data = 0;
> +		break;
> +	case MSR_KVM_MIGRATION_CONTROL:
> +		if (!guest_pv_has(vcpu, KVM_FEATURE_HC_PAGE_ENC_STATUS))
> +			return 1;
> +
>  		msr_info->data = 0;
>  		break;
>  	case MSR_KVM_STEAL_TIME:
> -- 
> 2.26.2
> 
