Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 990193581B5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 13:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbhDHL0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 07:26:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58481 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231208AbhDHL0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 07:26:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617881158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2jICgiM8byXfzl2DmuXPIL46Kmc0bp/FkLK/0863SDw=;
        b=EDwMrh2BWqHIG2cm50cfY9Xfx3ziJrF0YWgjXpOlwz6xkcjTJVpaMbN3L1JCHRqy8/4O4V
        IFhZwlegC9qRwoVW1XsvV79pcHoPr7T41iKjDygpYYuexbDKek2Lq91Q3zgdHwzwhljvOM
        gUrDyr5VX8a+LU7viP7/1NbtwZ++FBY=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-113-dvXH7ezYMvqWnmzWBcgxBA-1; Thu, 08 Apr 2021 07:25:57 -0400
X-MC-Unique: dvXH7ezYMvqWnmzWBcgxBA-1
Received: by mail-ed1-f70.google.com with SMTP id q12so872585edv.9
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 04:25:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=2jICgiM8byXfzl2DmuXPIL46Kmc0bp/FkLK/0863SDw=;
        b=qtx1WPrzrj8fS4D5c3SwA4WLRsnBJ1+P1n03/D82lhjD1L2mA2mK4twkPCXiTYQgXu
         pGrM6DgZy4QPeEpTk9AzLN3i3EwmKAIabavs884591tLLJH8BJwExqORI4kJ85cH1PUB
         AgXpU6rfBQYWwLNrDZImDfBgVACZTIhpfOJ0q9pGlXeynJx7DzF6akN3r78OTVzOQrWM
         k861FdLuq7KH+sbsb215bG2WDDfvfUQGilOCfTRw6s/lev9tG1hzRBecCQHQSTMYVOKz
         eB3jUs4yMFuSGe/d0KcEDQNZKs3iEvo4cQXFCGmcz6ab3lAvQbqlYVZTiAd5/A6x5hvv
         ShaA==
X-Gm-Message-State: AOAM533+p1TKTlV2VygU6ZsrTlrOM4HX43eBVhbPNli6F7tYvmIxIoaD
        eG1uN9JWLwAEBNXuk5ILjRN8vYmkFNLdYbnAd9zINJI6yBr5+DaID2Aq4gC3ABLzBsqW58Cu05+
        ktBRt8Z4AJZX7mDV/B11n5w6L
X-Received: by 2002:a05:6402:1393:: with SMTP id b19mr10568105edv.333.1617881156262;
        Thu, 08 Apr 2021 04:25:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx09rHyopQMt1EoImDcbAYXR/I2RpWvBgSCq+KK5UGw+x8YGg8mg//eDYS0SwyhcaziP7aQgw==
X-Received: by 2002:a05:6402:1393:: with SMTP id b19mr10568085edv.333.1617881156118;
        Thu, 08 Apr 2021 04:25:56 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id y21sm1054224edr.38.2021.04.08.04.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 04:25:55 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Vineeth Pillai <viremana@linux.microsoft.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "K. Y. Srinivasan" <kys@microsoft.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org,
        Lan Tianyu <Tianyu.Lan@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, Wei Liu <wei.liu@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>
Subject: Re: [PATCH 7/7] KVM: SVM: hyper-v: Direct Virtual Flush support
In-Reply-To: <aa634c867aa395aa2d3eae950dfec137f59a62c6.1617804573.git.viremana@linux.microsoft.com>
References: <cover.1617804573.git.viremana@linux.microsoft.com>
 <aa634c867aa395aa2d3eae950dfec137f59a62c6.1617804573.git.viremana@linux.microsoft.com>
Date:   Thu, 08 Apr 2021 13:25:54 +0200
Message-ID: <87a6q9augt.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vineeth Pillai <viremana@linux.microsoft.com> writes:

> From Hyper-V TLFS:
>  "The hypervisor exposes hypercalls (HvFlushVirtualAddressSpace,
>   HvFlushVirtualAddressSpaceEx, HvFlushVirtualAddressList, and
>   HvFlushVirtualAddressListEx) that allow operating systems to more
>   efficiently manage the virtual TLB. The L1 hypervisor can choose to
>   allow its guest to use those hypercalls and delegate the responsibility
>   to handle them to the L0 hypervisor. This requires the use of a
>   partition assist page."
>
> Add the Direct Virtual Flush support for SVM.
>
> Related VMX changes:
> commit 6f6a657c9998 ("KVM/Hyper-V/VMX: Add direct tlb flush support")
>
> Signed-off-by: Vineeth Pillai <viremana@linux.microsoft.com>
> ---
>  arch/x86/kvm/svm/svm.c | 48 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
>
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 3562a247b7e8..c6d3f3a7c986 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -440,6 +440,32 @@ static void svm_init_osvw(struct kvm_vcpu *vcpu)
>  		vcpu->arch.osvw.status |= 1;
>  }
>  
> +#if IS_ENABLED(CONFIG_HYPERV)
> +static int hv_enable_direct_tlbflush(struct kvm_vcpu *vcpu)
> +{
> +	struct hv_enlightenments *hve;
> +	struct hv_partition_assist_pg **p_hv_pa_pg =
> +			&to_kvm_hv(vcpu->kvm)->hv_pa_pg;
> +
> +	if (!*p_hv_pa_pg)
> +		*p_hv_pa_pg = kzalloc(PAGE_SIZE, GFP_KERNEL);
> +
> +	if (!*p_hv_pa_pg)
> +		return -ENOMEM;
> +
> +	hve = (struct hv_enlightenments *)&to_svm(vcpu)->vmcb->hv_enlightenments;
> +
> +	hve->partition_assist_page = __pa(*p_hv_pa_pg);
> +	hve->hv_vm_id = (unsigned long)vcpu->kvm;
> +	if (!hve->hv_enlightenments_control.nested_flush_hypercall) {
> +		hve->hv_enlightenments_control.nested_flush_hypercall = 1;
> +		vmcb_mark_dirty(to_svm(vcpu)->vmcb, VMCB_HV_NESTED_ENLIGHTENMENTS);
> +	}
> +
> +	return 0;
> +}
> +#endif
> +
>  static int has_svm(void)
>  {
>  	const char *msg;
> @@ -1034,6 +1060,21 @@ static __init int svm_hardware_setup(void)
>  		svm_x86_ops.tlb_remote_flush_with_range =
>  				kvm_hv_remote_flush_tlb_with_range;
>  	}
> +
> +	if (ms_hyperv.nested_features & HV_X64_NESTED_DIRECT_FLUSH) {
> +		pr_info("kvm: Hyper-V Direct TLB Flush enabled\n");
> +		for_each_online_cpu(cpu) {
> +			struct hv_vp_assist_page *vp_ap =
> +				hv_get_vp_assist_page(cpu);
> +
> +			if (!vp_ap)
> +				continue;
> +
> +			vp_ap->nested_control.features.directhypercall = 1;
> +		}
> +		svm_x86_ops.enable_direct_tlbflush =
> +				hv_enable_direct_tlbflush;
> +	}
>  #endif
>  
>  	if (nrips) {
> @@ -3913,6 +3954,13 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu)
>  	}
>  	svm->vmcb->save.cr2 = vcpu->arch.cr2;
>  
> +#if IS_ENABLED(CONFIG_HYPERV)
> +	if (svm->vmcb->hv_enlightenments.hv_vp_id != to_hv_vcpu(vcpu)->vp_index) {

This looks wrong (see my previous comment about mixing KVM-on-Hyper-V
and Windows/Hyper-V-on-KVM). 'to_hv_vcpu(vcpu)->vp_index' is
'Windows/Hyper-V-on-KVM' thingy, it does not exist when we run without
any Hyper-V enlightenments exposed (e.g. when we run Linux as our
guest).

> +		svm->vmcb->hv_enlightenments.hv_vp_id = to_hv_vcpu(vcpu)->vp_index;
> +		vmcb_mark_dirty(svm->vmcb, VMCB_HV_NESTED_ENLIGHTENMENTS);
> +	}
> +#endif
> +
>  	/*
>  	 * Run with all-zero DR6 unless needed, so that we can get the exact cause
>  	 * of a #DB.

-- 
Vitaly

