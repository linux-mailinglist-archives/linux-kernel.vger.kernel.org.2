Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4238330ACD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 11:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbhCHKFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 05:05:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32506 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231139AbhCHKFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 05:05:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615197916;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iycTxim9qfjVXR9+Sz28jZGAfApvnNVANpqFpW/kN+o=;
        b=KfVQH+tWE8D6X39oJM8pbKba9zD5kR5o5Ke+GMz+sOpHF2PVWiAu2GZZTLSQx/HWIp6pgS
        Z0l1X2w24vKxoQYGFKNvfgEgVQFp6DcpIm/dWpIdVw/hadGgm2Gx1o/iLpY+hM5Q/6YXrv
        5HSk/EEb1mwgqA+yStX9IW2BJB5eZ4E=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-yBvp0lXPMCuy9x9H8jjTFA-1; Mon, 08 Mar 2021 05:05:14 -0500
X-MC-Unique: yBvp0lXPMCuy9x9H8jjTFA-1
Received: by mail-ed1-f70.google.com with SMTP id o15so4773998edv.7
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 02:05:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=iycTxim9qfjVXR9+Sz28jZGAfApvnNVANpqFpW/kN+o=;
        b=PWHrhYMyk8fVL+f7Tz1pTh+LYKMIOBq8xF4IdRNu3YYIXhtPI8nhAW0uwo3H2wtk4p
         SiQEtAEr+uaaSscw+aOAWGmRNUgLbZFdKMwyQ8CoxPljxpRELZM4JtrR6V1IALWgxQUu
         GDB9heCsvs1a0B5dK1Zwl3ENchaDdocWeQX0KJKxUIoKveRt4mhP6tSBxKuGxww3PS25
         BdNp5LQ2y/a5Mh7gkX9oUkKzNQJYl+xHet9U95RACCntrEWtZEhx32Xu4P7fTFbCdlVO
         QjsDrxj/Z5Afy87RacxlTv8qlmb6KLuoSUzn7e2RuIiLdqEhLHsNoO246UjDcWlD1QR1
         O4nw==
X-Gm-Message-State: AOAM533xuR+k+vzkzq1paN+z7JPswwZweKYDHnHKYPoLvGxxviwoM8j9
        fS2X5egJR+TnsgLGTC0EYUgyNGZwxp+bjmXXDM29+R+co9cFyMP73LP8FkOrMOSovyo4H1YQtwF
        ybCCDl1QQYKWJUHmZ/cKAhrOX7eJmCt0QavL3mcptuaZ1QlZ40mq1WscfcrzBKHTs0W6VMOuZRy
        fe
X-Received: by 2002:a17:907:20c7:: with SMTP id qq7mr13759991ejb.528.1615197913593;
        Mon, 08 Mar 2021 02:05:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyHH99R9tg3PUIS3Kyq3nn3ZkIh1WQBKJ4FWYfihudS2SPpfL2/A80tfoWeMBxjHtIEz/29gg==
X-Received: by 2002:a17:907:20c7:: with SMTP id qq7mr13759953ejb.528.1615197913212;
        Mon, 08 Mar 2021 02:05:13 -0800 (PST)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id gr16sm6391230ejb.44.2021.03.08.02.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 02:05:12 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 01/11] KVM: x86: Get active PCID only when writing a
 CR3 value
In-Reply-To: <20210305183123.3978098-2-seanjc@google.com>
References: <20210305183123.3978098-1-seanjc@google.com>
 <20210305183123.3978098-2-seanjc@google.com>
Date:   Mon, 08 Mar 2021 11:05:12 +0100
Message-ID: <87im62arl3.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> From: Sean Christopherson <sean.j.christopherson@intel.com>
>
> Retrieve the active PCID only when writing a guest CR3 value, i.e. don't
> get the PCID when using EPT or NPT.  The PCID is especially problematic
> for EPT as the bits have different meaning, and so the PCID and must be
> manually stripped, which is annoying and unnecessary.  And on VMX,
> getting the active PCID also involves reading the guest's CR3 and
> CR4.PCIDE, i.e. may add pointless VMREADs.
>
> Opportunistically rename the pgd/pgd_level params to root_hpa and
> root_level to better reflect their new roles.  Keep the function names,
> as "load the guest PGD" is still accurate/correct.
>
> Last, and probably least, pass root_hpa as a hpa_t/u64 instead of an
> unsigned long.  The EPTP holds a 64-bit value, even in 32-bit mode, so
> in theory EPT could support HIGHMEM for 32-bit KVM.  Never mind that
> doing so would require changing the MMU page allocators and reworking
> the MMU to use kmap().
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/include/asm/kvm_host.h |  4 ++--
>  arch/x86/kvm/mmu.h              |  4 ++--
>  arch/x86/kvm/svm/svm.c          | 10 ++++++----
>  arch/x86/kvm/vmx/vmx.c          | 13 ++++++-------
>  arch/x86/kvm/vmx/vmx.h          |  3 +--
>  5 files changed, 17 insertions(+), 17 deletions(-)
>
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 2da6c9f5935a..51725e994451 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1245,8 +1245,8 @@ struct kvm_x86_ops {
>  	int (*set_identity_map_addr)(struct kvm *kvm, u64 ident_addr);
>  	u64 (*get_mt_mask)(struct kvm_vcpu *vcpu, gfn_t gfn, bool is_mmio);
>  
> -	void (*load_mmu_pgd)(struct kvm_vcpu *vcpu, unsigned long pgd,
> -			     int pgd_level);
> +	void (*load_mmu_pgd)(struct kvm_vcpu *vcpu, hpa_t root_hpa,
> +			     int root_level);
>  
>  	bool (*has_wbinvd_exit)(void);
>  
> diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
> index 67e8c7c7a6ce..88d0ed5225a4 100644
> --- a/arch/x86/kvm/mmu.h
> +++ b/arch/x86/kvm/mmu.h
> @@ -107,8 +107,8 @@ static inline void kvm_mmu_load_pgd(struct kvm_vcpu *vcpu)
>  	if (!VALID_PAGE(root_hpa))
>  		return;
>  
> -	static_call(kvm_x86_load_mmu_pgd)(vcpu, root_hpa | kvm_get_active_pcid(vcpu),
> -				 vcpu->arch.mmu->shadow_root_level);
> +	static_call(kvm_x86_load_mmu_pgd)(vcpu, root_hpa,
> +					  vcpu->arch.mmu->shadow_root_level);
>  }
>  
>  int kvm_tdp_page_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index dfc8fe231e8b..c7a685bf6862 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -3902,14 +3902,14 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu)
>  	return svm_exit_handlers_fastpath(vcpu);
>  }
>  
> -static void svm_load_mmu_pgd(struct kvm_vcpu *vcpu, unsigned long root,
> +static void svm_load_mmu_pgd(struct kvm_vcpu *vcpu, hpa_t root_hpa,
>  			     int root_level)
>  {
>  	struct vcpu_svm *svm = to_svm(vcpu);
>  	unsigned long cr3;
>  
>  	if (npt_enabled) {
> -		svm->vmcb->control.nested_cr3 = __sme_set(root);
> +		svm->vmcb->control.nested_cr3 = __sme_set(root_hpa);
>  		vmcb_mark_dirty(svm->vmcb, VMCB_NPT);
>  
>  		/* Loading L2's CR3 is handled by enter_svm_guest_mode.  */
> @@ -3917,9 +3917,11 @@ static void svm_load_mmu_pgd(struct kvm_vcpu *vcpu, unsigned long root,
>  			return;
>  		cr3 = vcpu->arch.cr3;
>  	} else if (vcpu->arch.mmu->shadow_root_level >= PT64_ROOT_4LEVEL) {
> -		cr3 = __sme_set(root);
> +		cr3 = __sme_set(root_hpa) | kvm_get_active_pcid(vcpu);
>  	} else {
> -		cr3 = root;
> +		/* PCID in the guest should be impossible with a 32-bit MMU. */
> +		WARN_ON_ONCE(kvm_get_active_pcid(vcpu));
> +		cr3 = root_hpa;
>  	}
>  
>  	svm->vmcb->save.cr3 = cr3;
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 6d7e760fdfa0..dde2ebc7cf3a 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -3088,8 +3088,7 @@ static int vmx_get_max_tdp_level(void)
>  	return 4;
>  }
>  
> -u64 construct_eptp(struct kvm_vcpu *vcpu, unsigned long root_hpa,
> -		   int root_level)
> +u64 construct_eptp(struct kvm_vcpu *vcpu, hpa_t root_hpa, int root_level)
>  {
>  	u64 eptp = VMX_EPTP_MT_WB;
>  
> @@ -3098,13 +3097,13 @@ u64 construct_eptp(struct kvm_vcpu *vcpu, unsigned long root_hpa,
>  	if (enable_ept_ad_bits &&
>  	    (!is_guest_mode(vcpu) || nested_ept_ad_enabled(vcpu)))
>  		eptp |= VMX_EPTP_AD_ENABLE_BIT;
> -	eptp |= (root_hpa & PAGE_MASK);
> +	eptp |= root_hpa;
>  
>  	return eptp;
>  }
>  
> -static void vmx_load_mmu_pgd(struct kvm_vcpu *vcpu, unsigned long pgd,
> -			     int pgd_level)
> +static void vmx_load_mmu_pgd(struct kvm_vcpu *vcpu, hpa_t root_hpa,
> +			     int root_level)
>  {
>  	struct kvm *kvm = vcpu->kvm;
>  	bool update_guest_cr3 = true;
> @@ -3112,7 +3111,7 @@ static void vmx_load_mmu_pgd(struct kvm_vcpu *vcpu, unsigned long pgd,
>  	u64 eptp;
>  
>  	if (enable_ept) {
> -		eptp = construct_eptp(vcpu, pgd, pgd_level);
> +		eptp = construct_eptp(vcpu, root_hpa, root_level);
>  		vmcs_write64(EPT_POINTER, eptp);
>  
>  		if (kvm_x86_ops.tlb_remote_flush) {
> @@ -3131,7 +3130,7 @@ static void vmx_load_mmu_pgd(struct kvm_vcpu *vcpu, unsigned long pgd,
>  			update_guest_cr3 = false;
>  		vmx_ept_load_pdptrs(vcpu);
>  	} else {
> -		guest_cr3 = pgd;
> +		guest_cr3 = root_hpa | kvm_get_active_pcid(vcpu);
>  	}
>  
>  	if (update_guest_cr3)
> diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
> index 89da5e1251f1..4795955490cb 100644
> --- a/arch/x86/kvm/vmx/vmx.h
> +++ b/arch/x86/kvm/vmx/vmx.h
> @@ -376,8 +376,7 @@ void set_cr4_guest_host_mask(struct vcpu_vmx *vmx);
>  void ept_save_pdptrs(struct kvm_vcpu *vcpu);
>  void vmx_get_segment(struct kvm_vcpu *vcpu, struct kvm_segment *var, int seg);
>  void vmx_set_segment(struct kvm_vcpu *vcpu, struct kvm_segment *var, int seg);
> -u64 construct_eptp(struct kvm_vcpu *vcpu, unsigned long root_hpa,
> -		   int root_level);
> +u64 construct_eptp(struct kvm_vcpu *vcpu, hpa_t root_hpa, int root_level);
>  
>  void vmx_update_exception_bitmap(struct kvm_vcpu *vcpu);
>  void vmx_update_msr_bitmap(struct kvm_vcpu *vcpu);

The rest of the series carries my R-b so let's not make this patch feel
sad. Personally, I'd suggest we split this into 're-name/re-type' and
'PCID' patches but it's not a big deal.

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

