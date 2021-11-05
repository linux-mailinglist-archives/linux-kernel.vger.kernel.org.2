Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC2E244632B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 13:09:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232931AbhKEMLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 08:11:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44019 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232328AbhKEMLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 08:11:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636114136;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z96ltttEMI7xDMFWWKjBYprOf7tFQRkGV8p2r4IJRn8=;
        b=CNyGI3HuzEVcZFMXNzKc2RQK551FSq4GeQ3PMpC/q6tXBnd9TCBsj4McHGaQzayrWRtZ08
        Ah9Xy+LuUjRiua4UeMZPBPRyqcCHM5zt3ATTbyq8aNpF1YTQ7PFSfem1vGNJPMCoDjriga
        GNjlzRT4AMuTbnVEyk8t/kYA1Bp9+ao=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-93-5hUsQqvlNRWu5jd4iwRYnQ-1; Fri, 05 Nov 2021 08:08:55 -0400
X-MC-Unique: 5hUsQqvlNRWu5jd4iwRYnQ-1
Received: by mail-wm1-f71.google.com with SMTP id v10-20020a1cf70a000000b00318203a6bd1so3183927wmh.6
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 05:08:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Z96ltttEMI7xDMFWWKjBYprOf7tFQRkGV8p2r4IJRn8=;
        b=wkcP1tn5z7BhtuCWQ8wVWeHFdW074pmZDUGbwnRirKO0oW6k5Xayz9bHNbaGxQKskc
         9kPNu7FOjx8eO8PgWxlm4AysqKDOnXsF4Rk1XmoaRb/cMr1mrhJCSI/EOYtAvTVfhn+v
         Bm1o5cltaBUdpdEZgoFNHvim4UufFtH33uBFtwc8ZH+6sHDu+b6Oyvgt/kTdvakajgzk
         uqw0PVN5zY92S8ErLs9oMkUPkGZeD9rP0K6xXlt0Qk4k0fwnKVwTqLtKyA07pO7wiZ8/
         EW5H8mfnU4AeLCLldKOc6h0YJAX24w2IAPSn05JUTSESMdx0+fMWQ3f/H+WsicXFdpSi
         WrnA==
X-Gm-Message-State: AOAM5313OJZMQAKMEM2HWZpMDPJ0RWIt5XfRbWtNaiLT5dfOPgc2iVyo
        j+a/yc6XW1gY76LQsXyk8yWvwah25vvNkLNbSJQdD6Plbh128BYAuHyWVVCPGFGkNuY5WSPeFH0
        6zpuos9ZDOgD8VeP3v6UKWkTI7A439QQAKxhSEmm5+sXbPKq1qkWaVjZfT1rB1k32rqAJ3wPF1n
        Yz
X-Received: by 2002:a7b:ca4c:: with SMTP id m12mr27584697wml.119.1636114134362;
        Fri, 05 Nov 2021 05:08:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwiI8uK5l1z6MEdD2zH8CJe0sZv403aDV4qAB5NUTSetjGcYY165o55UgPye3ySTHuKBhLE2Q==
X-Received: by 2002:a7b:ca4c:: with SMTP id m12mr27584466wml.119.1636114132643;
        Fri, 05 Nov 2021 05:08:52 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id f18sm7751308wre.7.2021.11.05.05.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 05:08:52 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] KVM: nVMX: Implement Enlightened MSR Bitmap feature
In-Reply-To: <YYSEYY4h6NN7FGbR@google.com>
References: <20211013142258.1738415-1-vkuznets@redhat.com>
 <20211013142258.1738415-5-vkuznets@redhat.com>
 <YYSEYY4h6NN7FGbR@google.com>
Date:   Fri, 05 Nov 2021 13:08:51 +0100
Message-ID: <8735oals8c.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> On Wed, Oct 13, 2021, Vitaly Kuznetsov wrote:
>> Updating MSR bitmap for L2 is not cheap and rearly needed. TLFS for Hyper-V
>> offers 'Enlightened MSR Bitmap' feature which allows L1 hypervisor to
>> inform L0 when it changes MSR bitmap, this eliminates the need to examine
>> L1's MSR bitmap for L2 every time when 'real' MSR bitmap for L2 gets
>> constructed.
>> 
>> Use 'vmx->nested.msr_bitmap_changed' flag to implement the feature.
>> 
>> Note, KVM already uses 'Enlightened MSR bitmap' feature when it runs as a
>> nested hypervisor on top of Hyper-V. The newly introduced feature is going
>> to be used by Hyper-V guests on KVM.
>> 
>> When the feature is enabled for Win10+WSL2, it shaves off around 700 CPU
>> cycles from a nested vmexit cost (tight cpuid loop test).
>> 
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>>  arch/x86/kvm/hyperv.c     |  2 ++
>>  arch/x86/kvm/vmx/nested.c | 20 ++++++++++++++++++--
>>  2 files changed, 20 insertions(+), 2 deletions(-)
>> 
>> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
>> index 6f11cda2bfa4..a00de1dbec57 100644
>> --- a/arch/x86/kvm/hyperv.c
>> +++ b/arch/x86/kvm/hyperv.c
>> @@ -2516,6 +2516,8 @@ int kvm_get_hv_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid2 *cpuid,
>>  
>>  		case HYPERV_CPUID_NESTED_FEATURES:
>>  			ent->eax = evmcs_ver;
>> +			if (evmcs_ver)
>> +				ent->eax |= HV_X64_NESTED_MSR_BITMAP;
>>  
>>  			break;
>>  
>> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
>> index bf4fa63ed371..7cd0c20d4557 100644
>> --- a/arch/x86/kvm/vmx/nested.c
>> +++ b/arch/x86/kvm/vmx/nested.c
>> @@ -608,15 +608,30 @@ static inline bool nested_vmx_prepare_msr_bitmap(struct kvm_vcpu *vcpu,
>>  						 struct vmcs12 *vmcs12)
>>  {
>>  	int msr;
>> +	struct vcpu_vmx *vmx = to_vmx(vcpu);
>>  	unsigned long *msr_bitmap_l1;
>> -	unsigned long *msr_bitmap_l0 = to_vmx(vcpu)->nested.vmcs02.msr_bitmap;
>> -	struct kvm_host_map *map = &to_vmx(vcpu)->nested.msr_bitmap_map;
>> +	unsigned long *msr_bitmap_l0 = vmx->nested.vmcs02.msr_bitmap;
>> +	struct hv_enlightened_vmcs *evmcs = vmx->nested.hv_evmcs;
>> +	struct kvm_host_map *map = &vmx->nested.msr_bitmap_map;
>
> That reminds me, can my nested bitmap fixes get merged?  Superficial conflicts,
> but still conflicts that I'd rather not have to resolve :-)
>
> https://lkml.kernel.org/r/20210924204907.1111817-1-seanjc@google.com
>

From my side I can suggest to combine these two series in v4)

>>  
>>  	/* Nothing to do if the MSR bitmap is not in use.  */
>>  	if (!cpu_has_vmx_msr_bitmap() ||
>>  	    !nested_cpu_has(vmcs12, CPU_BASED_USE_MSR_BITMAPS))
>>  		return false;
>>  
>> +	/*
>> +	 * MSR bitmap update can be skipped when:
>> +	 * - MSR bitmap for L1 hasn't changed.
>> +	 * - Nested hypervisor (L1) is attempting to launch the same L2 as
>> +	 *   before.
>> +	 * - Nested hypervisor (L1) has enabled 'Enlightened MSR Bitmap' feature
>> +	 *   and tells KVM (L0) there were no changes in MSR bitmap for L2.
>> +	 */
>> +	if (!vmx->nested.msr_bitmap_force_recalc && evmcs &&
>> +	    evmcs->hv_enlightenments_control.msr_bitmap &&
>> +	    evmcs->hv_clean_fields & HV_VMX_ENLIGHTENED_CLEAN_FIELD_MSR_BITMAP)
>> +		goto out_clear_msr_bitmap_force_recalc;
>
> Huh?  Why clear it, it's already clear.  Any reason not to simply return true?
>

No need indeed, will drop in v4.

>> +
>>  	if (kvm_vcpu_map(vcpu, gpa_to_gfn(vmcs12->msr_bitmap), map))
>>  		return false;
>>  
>> @@ -700,6 +715,7 @@ static inline bool nested_vmx_prepare_msr_bitmap(struct kvm_vcpu *vcpu,
>>  
>>  	kvm_vcpu_unmap(vcpu, &to_vmx(vcpu)->nested.msr_bitmap_map, false);
>>  
>> +out_clear_msr_bitmap_force_recalc:
>>  	vmx->nested.msr_bitmap_force_recalc = false;
>>  
>>  	return true;
>> -- 
>> 2.31.1
>> 
>

-- 
Vitaly

