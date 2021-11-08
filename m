Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 055B8447E06
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 11:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238142AbhKHKdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 05:33:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36945 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237988AbhKHKdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 05:33:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636367421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UTOWGBeFrM7I0KtBcuEUsJcLZOyCey6HdtxIt6FVUjI=;
        b=BHJBQ4fpMTI+oo/SAdavwQl6zkUJGMu3tU7FxbY0voNOnzyf0kFovTgfYwe2+gLX2MUW6z
        3dhVXUmMs5jUOOnuecLxCb3cQKb6FHYHAfqejKS455OIHfveTnzb9aYXwld8jXWaX89SmH
        XRAGmZSO8MabKJh5eaL3/KYyR5wI9Dk=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-5aQ6UmBINfGGNiRoc3OQ2Q-1; Mon, 08 Nov 2021 05:30:20 -0500
X-MC-Unique: 5aQ6UmBINfGGNiRoc3OQ2Q-1
Received: by mail-ed1-f69.google.com with SMTP id t20-20020a056402525400b003e2ad6b5ee7so14476528edd.8
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 02:30:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UTOWGBeFrM7I0KtBcuEUsJcLZOyCey6HdtxIt6FVUjI=;
        b=vlTd/LcWE49PI+CbHuiTYedESlele/ZfahbYw/eNv2iDP0gqT6esZXjv0SYwhp0fTs
         oHlARKfNSqKVCBGt1ZMLUXRmIEWIrZZtQE886LQjIqk64BeMoI2hs7tTaHFGUvxl/z5x
         BJgo6lnjxTUKxiN4vIevpH97PHYHMx+gDkqpNbHpdQcPrzmGCKNLLtxx+bZpXn/Z6hqZ
         rSkG7gR9MM3lh+twEbwbp6JuIigPdEUnr38RZ6iWfDPBbJK2dGj0C2gRBb8m1HyACea5
         wKjy/kbkSRKjkN+eDidsy4pPXkXi85rjvTCOYVA0rArFBPwPW4btIUPXqIyCIl7qOFTl
         AtRA==
X-Gm-Message-State: AOAM531L3xOpCiBnZe54CPEdnNuZ+SUO80TBR679Cgqy5aMGeyci7Atw
        RItaBT0abzkqLIz9bOyu7FLa2HFPSgdh7HqXFgh6BhPUSukEKr63rQc4HjvFHVWGlgXeM1/vcqJ
        7wejLykR6BlguyyIGCuszYB8h
X-Received: by 2002:a50:e044:: with SMTP id g4mr103906397edl.46.1636367418777;
        Mon, 08 Nov 2021 02:30:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzNodBr0jtjZltJOpJKHWQguNnzX7MHbaZkMC7xRq1C2nf1twaD8mSDEwDxgMa8L7hXebJEfA==
X-Received: by 2002:a50:e044:: with SMTP id g4mr103906353edl.46.1636367418557;
        Mon, 08 Nov 2021 02:30:18 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id t23sm9035962edc.95.2021.11.08.02.30.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Nov 2021 02:30:17 -0800 (PST)
Message-ID: <a991bbb4-b507-a2f6-ec0f-fce23d4379ce@redhat.com>
Date:   Mon, 8 Nov 2021 11:30:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RFC] KVM: x86: SVM: don't expose PV_SEND_IPI feature with AVIC
Content-Language: en-US
To:     Kele Huang <huangkele@bytedance.com>
Cc:     chaiwen.cc@bytedance.com, xieyongji@bytedance.com,
        dengliang.1214@bytedance.com, pizhenwei@bytedance.com,
        wanpengli@tencent.com, seanjc@google.com,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211108095931.618865-1-huangkele@bytedance.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20211108095931.618865-1-huangkele@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/8/21 10:59, Kele Huang wrote:
> Currently, AVIC is disabled if x2apic feature is exposed to guest
> or in-kernel PIT is in re-injection mode.
> 
> We can enable AVIC with options:
> 
>    Kmod args:
>    modprobe kvm_amd avic=1 nested=0 npt=1
>    QEMU args:
>    ... -cpu host,-x2apic -global kvm-pit.lost_tick_policy=discard ...
> 
> When LAPIC works in xapic mode, both AVIC and PV_SEND_IPI feature
> can accelerate IPI operations for guest. However, the relationship
> between AVIC and PV_SEND_IPI feature is not sorted out.
> 
> In logical, AVIC accelerates most of frequently IPI operations
> without VMM intervention, while the re-hooking of apic->send_IPI_xxx
> from PV_SEND_IPI feature masks out it. People can get confused
> if AVIC is enabled while getting lots of hypercall kvm_exits
> from IPI.
> 
> In performance, benchmark tool
> https://lore.kernel.org/kvm/20171219085010.4081-1-ynorov@caviumnetworks.com/
> shows below results:
> 
>    Test env:
>    CPU: AMD EPYC 7742 64-Core Processor
>    2 vCPUs pinned 1:1
>    idle=poll
> 
>    Test result (average ns per IPI of lots of running):
>    PV_SEND_IPI 	: 1860
>    AVIC 		: 1390
> 
> Besides, disscussions in https://lkml.org/lkml/2021/10/20/423
> do have some solid performance test results to this.
> 
> This patch fixes this by masking out PV_SEND_IPI feature when
> AVIC is enabled in setting up of guest vCPUs' CPUID.
> 
> Signed-off-by: Kele Huang <huangkele@bytedance.com>

AVIC can change across migration.  I think we should instead use a new 
KVM_HINTS_* bit (KVM_HINTS_ACCELERATED_LAPIC or something like that). 
The KVM_HINTS_* bits are intended to be changeable across migration, 
even though we don't have for now anything equivalent to the Hyper-V 
reenlightenment interrupt.

Paolo

> ---
>   arch/x86/kvm/cpuid.c   |  4 ++--
>   arch/x86/kvm/svm/svm.c | 13 +++++++++++++
>   2 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 2d70edb0f323..cc22975e2ac5 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -194,8 +194,6 @@ static void kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
>   		best->ecx |= XFEATURE_MASK_FPSSE;
>   	}
>   
> -	kvm_update_pv_runtime(vcpu);
> -
>   	vcpu->arch.maxphyaddr = cpuid_query_maxphyaddr(vcpu);
>   	vcpu->arch.reserved_gpa_bits = kvm_vcpu_reserved_gpa_bits_raw(vcpu);
>   
> @@ -208,6 +206,8 @@ static void kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
>   	/* Invoke the vendor callback only after the above state is updated. */
>   	static_call(kvm_x86_vcpu_after_set_cpuid)(vcpu);
>   
> +	kvm_update_pv_runtime(vcpu);
> +
>   	/*
>   	 * Except for the MMU, which needs to do its thing any vendor specific
>   	 * adjustments to the reserved GPA bits.
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index b36ca4e476c2..b13bcfb2617c 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -4114,6 +4114,19 @@ static void svm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
>   		if (nested && guest_cpuid_has(vcpu, X86_FEATURE_SVM))
>   			kvm_request_apicv_update(vcpu->kvm, false,
>   						 APICV_INHIBIT_REASON_NESTED);
> +
> +		if (!guest_cpuid_has(vcpu, X86_FEATURE_X2APIC) &&
> +				!(nested && guest_cpuid_has(vcpu, X86_FEATURE_SVM))) {
> +			/*
> +			 * PV_SEND_IPI feature masks out AVIC acceleration to IPI.
> +			 * So, we do not expose PV_SEND_IPI feature to guest when
> +			 * AVIC is enabled.
> +			 */
> +			best = kvm_find_cpuid_entry(vcpu, KVM_CPUID_FEATURES, 0);
> +			if (best && enable_apicv &&
> +					(best->eax & (1 << KVM_FEATURE_PV_SEND_IPI)))
> +				best->eax &= ~(1 << KVM_FEATURE_PV_SEND_IPI);
> +		}
>   	}
>   	init_vmcb_after_set_cpuid(vcpu);
>   }
> 

