Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A966341C4AD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 14:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343808AbhI2M1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 08:27:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34894 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343656AbhI2M0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 08:26:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632918303;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=waQ4HTSs8qPq9K3TVNjz+sz8qTXsPiA0So8ONix0NBI=;
        b=OE3niwLvgKpzCWJ/N+2+8rvS9V2PcHDI5Gd3syKmbGA7l3YbD96uFFtls/FsYsKNodtXVG
        s2kYN1xbcNHnazYTDiMhezP8XAoP77uzkoqVAHJ4+4I/Z8V1KqAL9W24OkvFX9x0ml7qHH
        CL2R47PCh74wIk++TT0nDutp1bzLvhw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-OOP8TKc2NIq3blLUmGRerQ-1; Wed, 29 Sep 2021 08:25:02 -0400
X-MC-Unique: OOP8TKc2NIq3blLUmGRerQ-1
Received: by mail-wm1-f72.google.com with SMTP id v5-20020a1cac05000000b0030b85d2d479so1132497wme.9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 05:25:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=waQ4HTSs8qPq9K3TVNjz+sz8qTXsPiA0So8ONix0NBI=;
        b=luP9ssAVqjMjUB6VpDxSBRrDhCwzmj3Izp5dZGYknhefCDx2VQzdqfQmpPLjfz8ggw
         o7UhVjpOPIOcYcF8tQSxn1MAxvKDB2qNRzAu6y7be0zU/dOBsDQKuSlom42V6Lgv0Q1D
         ic6qIGDLJuZn3h908ClzYjwQepXhQC1HAYsijKc9BDPCrAt5itVt3qWyb+NuhrBPOzTn
         yJWZ+mAq1PE5oCQf9cHzYHHtwEZmYzmm3nTvH81za47Fz7Ogz35zGfr++WlhQg5ATE8e
         b6E8hOZj5/HxKI7o5qJzuUHBp99w5UBp95Dj+ffmGuZn7yBy5R3Qk4V9pxpEtTOkrJrw
         pjuw==
X-Gm-Message-State: AOAM531rcqo/23HMe1q9G9PCuEXbU29XlPEAv4b2N6paKmdQsNGL5XPO
        oUO3U62zu1cL9Ktnx091xoT88Fn15LWMThJlv1DtmiBKxno3mTylDvfGEdy0CBjiHN4WO74r/mm
        N1+36B9fQ0jH1f6j+rlFjgCJz
X-Received: by 2002:a1c:a78d:: with SMTP id q135mr10183675wme.36.1632918299926;
        Wed, 29 Sep 2021 05:24:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyuN07HZpQF+5EFnsByLLu6j846FqRf2eW0h8MjJcBxzkrJaUI5JIyYXuTYzLs4OoebKilRLA==
X-Received: by 2002:a1c:a78d:: with SMTP id q135mr10183645wme.36.1632918299729;
        Wed, 29 Sep 2021 05:24:59 -0700 (PDT)
Received: from work-vm (cpc109025-salf6-2-0-cust480.10-2.cable.virginm.net. [82.30.61.225])
        by smtp.gmail.com with ESMTPSA id y197sm1786287wmc.18.2021.09.29.05.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 05:24:56 -0700 (PDT)
Date:   Wed, 29 Sep 2021 13:24:53 +0100
From:   "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>, tony.luck@intel.com,
        marcorr@google.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH Part2 v5 41/45] KVM: SVM: Add support to handle the RMP
 nested page fault
Message-ID: <YVRbFVQlTHOM9iTX@work-vm>
References: <20210820155918.7518-1-brijesh.singh@amd.com>
 <20210820155918.7518-42-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210820155918.7518-42-brijesh.singh@amd.com>
User-Agent: Mutt/2.0.7 (2021-05-04)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Brijesh Singh (brijesh.singh@amd.com) wrote:
> When SEV-SNP is enabled in the guest, the hardware places restrictions on
> all memory accesses based on the contents of the RMP table. When hardware
> encounters RMP check failure caused by the guest memory access it raises
> the #NPF. The error code contains additional information on the access
> type. See the APM volume 2 for additional information.
> 
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  arch/x86/kvm/svm/sev.c | 76 ++++++++++++++++++++++++++++++++++++++++++
>  arch/x86/kvm/svm/svm.c | 14 +++++---
>  arch/x86/kvm/svm/svm.h |  1 +
>  3 files changed, 87 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 65b578463271..712e8907bc39 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -3651,3 +3651,79 @@ void sev_post_unmap_gfn(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn, int token)
>  
>  	srcu_read_unlock(&sev->psc_srcu, token);
>  }
> +
> +void handle_rmp_page_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u64 error_code)
> +{
> +	int rmp_level, npt_level, rc, assigned;
> +	struct kvm *kvm = vcpu->kvm;
> +	gfn_t gfn = gpa_to_gfn(gpa);
> +	bool need_psc = false;
> +	enum psc_op psc_op;
> +	kvm_pfn_t pfn;
> +	bool private;
> +
> +	write_lock(&kvm->mmu_lock);
> +
> +	if (unlikely(!kvm_mmu_get_tdp_walk(vcpu, gpa, &pfn, &npt_level)))
> +		goto unlock;
> +
> +	assigned = snp_lookup_rmpentry(pfn, &rmp_level);
> +	if (unlikely(assigned < 0))
> +		goto unlock;
> +
> +	private = !!(error_code & PFERR_GUEST_ENC_MASK);
> +
> +	/*
> +	 * If the fault was due to size mismatch, or NPT and RMP page level's
> +	 * are not in sync, then use PSMASH to split the RMP entry into 4K.
> +	 */
> +	if ((error_code & PFERR_GUEST_SIZEM_MASK) ||
> +	    (npt_level == PG_LEVEL_4K && rmp_level == PG_LEVEL_2M && private)) {
> +		rc = snp_rmptable_psmash(kvm, pfn);
> +		if (rc)
> +			pr_err_ratelimited("psmash failed, gpa 0x%llx pfn 0x%llx rc %d\n",
> +					   gpa, pfn, rc);
> +		goto out;
> +	}
> +
> +	/*
> +	 * If it's a private access, and the page is not assigned in the
> +	 * RMP table, create a new private RMP entry. This can happen if
> +	 * guest did not use the PSC VMGEXIT to transition the page state
> +	 * before the access.
> +	 */
> +	if (!assigned && private) {
> +		need_psc = 1;
> +		psc_op = SNP_PAGE_STATE_PRIVATE;
> +		goto out;
> +	}
> +
> +	/*
> +	 * If it's a shared access, but the page is private in the RMP table
> +	 * then make the page shared in the RMP table. This can happen if
> +	 * the guest did not use the PSC VMGEXIT to transition the page
> +	 * state before the access.
> +	 */
> +	if (assigned && !private) {
> +		need_psc = 1;
> +		psc_op = SNP_PAGE_STATE_SHARED;
> +	}
> +
> +out:
> +	write_unlock(&kvm->mmu_lock);
> +
> +	if (need_psc)
> +		rc = __snp_handle_page_state_change(vcpu, psc_op, gpa, PG_LEVEL_4K);

That 'rc' never goes anywhere - should it?

> +	/*
> +	 * The fault handler has updated the RMP pagesize, zap the existing
> +	 * rmaps for large entry ranges so that nested page table gets rebuilt
> +	 * with the updated RMP pagesize.
> +	 */
> +	gfn = gpa_to_gfn(gpa) & ~(KVM_PAGES_PER_HPAGE(PG_LEVEL_2M) - 1);
> +	kvm_zap_gfn_range(kvm, gfn, gfn + PTRS_PER_PMD);
> +	return;
> +
> +unlock:
> +	write_unlock(&kvm->mmu_lock);
> +}
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 3784d389247b..3ba62f21b113 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -1933,15 +1933,21 @@ static int pf_interception(struct kvm_vcpu *vcpu)
>  static int npf_interception(struct kvm_vcpu *vcpu)
>  {
>  	struct vcpu_svm *svm = to_svm(vcpu);
> +	int rc;
>  
>  	u64 fault_address = svm->vmcb->control.exit_info_2;
>  	u64 error_code = svm->vmcb->control.exit_info_1;
>  
>  	trace_kvm_page_fault(fault_address, error_code);
> -	return kvm_mmu_page_fault(vcpu, fault_address, error_code,
> -			static_cpu_has(X86_FEATURE_DECODEASSISTS) ?
> -			svm->vmcb->control.insn_bytes : NULL,
> -			svm->vmcb->control.insn_len);
> +	rc = kvm_mmu_page_fault(vcpu, fault_address, error_code,
> +				static_cpu_has(X86_FEATURE_DECODEASSISTS) ?
> +				svm->vmcb->control.insn_bytes : NULL,
> +				svm->vmcb->control.insn_len);

If kvm_mmu_page_fault failed, (rc!=0) do you still want to call your
handler?

Dave

> +	if (error_code & PFERR_GUEST_RMP_MASK)
> +		handle_rmp_page_fault(vcpu, fault_address, error_code);
> +
> +	return rc;
>  }
>  
>  static int db_interception(struct kvm_vcpu *vcpu)
> diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
> index ff91184f9b4a..280072995306 100644
> --- a/arch/x86/kvm/svm/svm.h
> +++ b/arch/x86/kvm/svm/svm.h
> @@ -626,6 +626,7 @@ struct page *snp_safe_alloc_page(struct kvm_vcpu *vcpu);
>  void sev_rmp_page_level_adjust(struct kvm *kvm, kvm_pfn_t pfn, int *level);
>  int sev_post_map_gfn(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn, int *token);
>  void sev_post_unmap_gfn(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn, int token);
> +void handle_rmp_page_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u64 error_code);
>  
>  /* vmenter.S */
>  
> -- 
> 2.17.1
> 
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

