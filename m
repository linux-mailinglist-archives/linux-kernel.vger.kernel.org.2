Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D032C3D5A60
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 15:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233656AbhGZMvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 08:51:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26558 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233438AbhGZMvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 08:51:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627306326;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/N7UQ4xvbrbXhWTB1cwJS8BzzUUQf+w6nZzC3vwhxFo=;
        b=fYE2UhE5bwHpt8toDeWvY+YwkHEE5juhgrKajfOPSuq1E/nXPt38oOUfGimdIZJugoI49+
        LKBaa27MsQfnxadkAqBTBfFkFTiB0s83L8fV/TwsE54ZURkvi6R0vznil5M1hSPU8GxMnd
        3IX710+N1LBvzUUU1mthzSrHUzuEJHM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-55-jo4PTNxUMG-Qcp7iC72FyQ-1; Mon, 26 Jul 2021 09:32:05 -0400
X-MC-Unique: jo4PTNxUMG-Qcp7iC72FyQ-1
Received: by mail-ed1-f71.google.com with SMTP id i89-20020a50b0620000b02903b8906e05b4so4698335edd.19
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 06:32:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/N7UQ4xvbrbXhWTB1cwJS8BzzUUQf+w6nZzC3vwhxFo=;
        b=aWBSePzqe0siIT2GmTaXkldGFuMwnlch0HBphNrYQUVkbxyNba83EFJmTa2BjEW6z8
         QBZI2X2aKIGyh7JqHoZWhhniLzJKii6b+l1+nfgwOO6EfnzFLpy+a67EKNwPDSsFf0I4
         e6JOgRxhUGhOmFyGg3YjG9IT4FlefeCQA8ZtA7UNcDhW93hnSTTPECymjZKod9f6mzVl
         YgYPWAjy4rYNvxfgQrBwhwoJjhVEJ/cVKYwFAsZWh6wZwMe3ZclinzPcp5/XbJ8ghzH8
         oFnGr+JHj9YmvsGlK4F4n/hpazxdFugweBRNmuh8yUwQ1m4HVslMjUTWgoCrTRaaTobe
         D+iA==
X-Gm-Message-State: AOAM5302UlhedX/vEzBUBywDQUV3oX6d6bELfSzdr4/t8dymYbhK4t7y
        r6QvFhgZewAvoG347Iqcacqepsv+HA/f9piu0q4y+9EyQEm1HJO1EM1Ugf1Zm5KJz2Nul/b+Ktx
        2ouvYHxLj+Ma2DiAeRLs6QMyc
X-Received: by 2002:a17:906:404:: with SMTP id d4mr16887821eja.449.1627306323087;
        Mon, 26 Jul 2021 06:32:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy0US1SK14QjigE6NLkW/KuQ5SUKqgoDPxh/T4h3zvGiNCTsgFKeTsN0nJPm2ccW0IXFCHIrg==
X-Received: by 2002:a17:906:404:: with SMTP id d4mr16887795eja.449.1627306322888;
        Mon, 26 Jul 2021 06:32:02 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id b13sm10449925ede.49.2021.07.26.06.32.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jul 2021 06:32:02 -0700 (PDT)
Subject: Re: [PATCH 4/6] x86/kvm: introduce per cpu vcpu masks
To:     Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, kvm@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20210701154105.23215-1-jgross@suse.com>
 <20210701154105.23215-5-jgross@suse.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <98cb06ed-acd2-a954-9c85-3c9847631106@redhat.com>
Date:   Mon, 26 Jul 2021 15:32:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210701154105.23215-5-jgross@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/07/21 17:41, Juergen Gross wrote:
> In order to support high vcpu numbers per guest don't use on stack
> vcpu bitmasks. As all those currently used bitmasks are not used in
> functions subject to recursion it is fairly easy to replace them with
> percpu bitmasks.
> 
> Disable preemption while such a bitmask is being used in order to
> avoid double usage in case we'd switch cpus.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>

Please use a local_lock instead of disabling preemption.

Paolo

> ---
>   arch/x86/include/asm/kvm_host.h |  7 +++++++
>   arch/x86/kvm/hyperv.c           | 25 ++++++++++++++++++-------
>   arch/x86/kvm/irq_comm.c         |  9 +++++++--
>   arch/x86/kvm/x86.c              | 20 +++++++++++++++++++-
>   4 files changed, 51 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 88b1ff898fb9..79138c91f83d 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1514,6 +1514,13 @@ extern u64  kvm_default_tsc_scaling_ratio;
>   extern bool kvm_has_bus_lock_exit;
>   /* maximum vcpu-id */
>   extern unsigned int max_vcpu_id;
> +/* per cpu vcpu bitmasks (disable preemption during usage) */
> +extern unsigned long __percpu *kvm_pcpu_vcpu_mask;
> +#define KVM_VCPU_MASK_SZ	\
> +	(sizeof(*kvm_pcpu_vcpu_mask) * BITS_TO_LONGS(KVM_MAX_VCPUS))
> +extern u64 __percpu *kvm_hv_vp_bitmap;
> +#define KVM_HV_MAX_SPARSE_VCPU_SET_BITS DIV_ROUND_UP(KVM_MAX_VCPUS, 64)
> +#define KVM_HV_VPMAP_SZ		(sizeof(u64) * KVM_HV_MAX_SPARSE_VCPU_SET_BITS)
>   
>   extern u64 kvm_mce_cap_supported;
>   
> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> index f00830e5202f..32d31a7334fa 100644
> --- a/arch/x86/kvm/hyperv.c
> +++ b/arch/x86/kvm/hyperv.c
> @@ -40,7 +40,7 @@
>   /* "Hv#1" signature */
>   #define HYPERV_CPUID_SIGNATURE_EAX 0x31237648
>   
> -#define KVM_HV_MAX_SPARSE_VCPU_SET_BITS DIV_ROUND_UP(KVM_MAX_VCPUS, 64)
> +u64 __percpu *kvm_hv_vp_bitmap;
>   
>   static void stimer_mark_pending(struct kvm_vcpu_hv_stimer *stimer,
>   				bool vcpu_kick);
> @@ -1612,8 +1612,7 @@ static __always_inline unsigned long *sparse_set_to_vcpu_mask(
>   	struct kvm_vcpu *vcpu;
>   	int i, bank, sbank = 0;
>   
> -	memset(vp_bitmap, 0,
> -	       KVM_HV_MAX_SPARSE_VCPU_SET_BITS * sizeof(*vp_bitmap));
> +	memset(vp_bitmap, 0, KVM_HV_VPMAP_SZ);
>   	for_each_set_bit(bank, (unsigned long *)&valid_bank_mask,
>   			 KVM_HV_MAX_SPARSE_VCPU_SET_BITS)
>   		vp_bitmap[bank] = sparse_banks[sbank++];
> @@ -1637,8 +1636,8 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, u64 ingpa, u16 rep_cnt, bool
>   	struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);
>   	struct hv_tlb_flush_ex flush_ex;
>   	struct hv_tlb_flush flush;
> -	u64 vp_bitmap[KVM_HV_MAX_SPARSE_VCPU_SET_BITS];
> -	DECLARE_BITMAP(vcpu_bitmap, KVM_MAX_VCPUS);
> +	u64 *vp_bitmap;
> +	unsigned long *vcpu_bitmap;
>   	unsigned long *vcpu_mask;
>   	u64 valid_bank_mask;
>   	u64 sparse_banks[64];
> @@ -1696,6 +1695,10 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, u64 ingpa, u16 rep_cnt, bool
>   
>   	cpumask_clear(&hv_vcpu->tlb_flush);
>   
> +	preempt_disable();
> +	vcpu_bitmap = this_cpu_ptr(kvm_pcpu_vcpu_mask);
> +	vp_bitmap = this_cpu_ptr(kvm_hv_vp_bitmap);
> +
>   	vcpu_mask = all_cpus ? NULL :
>   		sparse_set_to_vcpu_mask(kvm, sparse_banks, valid_bank_mask,
>   					vp_bitmap, vcpu_bitmap);
> @@ -1707,6 +1710,8 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, u64 ingpa, u16 rep_cnt, bool
>   	kvm_make_vcpus_request_mask(kvm, KVM_REQ_HV_TLB_FLUSH,
>   				    NULL, vcpu_mask, &hv_vcpu->tlb_flush);
>   
> +	preempt_enable();
> +
>   ret_success:
>   	/* We always do full TLB flush, set rep_done = rep_cnt. */
>   	return (u64)HV_STATUS_SUCCESS |
> @@ -1738,8 +1743,8 @@ static u64 kvm_hv_send_ipi(struct kvm_vcpu *vcpu, u64 ingpa, u64 outgpa,
>   	struct kvm *kvm = vcpu->kvm;
>   	struct hv_send_ipi_ex send_ipi_ex;
>   	struct hv_send_ipi send_ipi;
> -	u64 vp_bitmap[KVM_HV_MAX_SPARSE_VCPU_SET_BITS];
> -	DECLARE_BITMAP(vcpu_bitmap, KVM_MAX_VCPUS);
> +	u64 *vp_bitmap;
> +	unsigned long *vcpu_bitmap;
>   	unsigned long *vcpu_mask;
>   	unsigned long valid_bank_mask;
>   	u64 sparse_banks[64];
> @@ -1796,12 +1801,18 @@ static u64 kvm_hv_send_ipi(struct kvm_vcpu *vcpu, u64 ingpa, u64 outgpa,
>   	if ((vector < HV_IPI_LOW_VECTOR) || (vector > HV_IPI_HIGH_VECTOR))
>   		return HV_STATUS_INVALID_HYPERCALL_INPUT;
>   
> +	preempt_disable();
> +	vcpu_bitmap = this_cpu_ptr(kvm_pcpu_vcpu_mask);
> +	vp_bitmap = this_cpu_ptr(kvm_hv_vp_bitmap);
> +
>   	vcpu_mask = all_cpus ? NULL :
>   		sparse_set_to_vcpu_mask(kvm, sparse_banks, valid_bank_mask,
>   					vp_bitmap, vcpu_bitmap);
>   
>   	kvm_send_ipi_to_many(kvm, vector, vcpu_mask);
>   
> +	preempt_enable();
> +
>   ret_success:
>   	return HV_STATUS_SUCCESS;
>   }
> diff --git a/arch/x86/kvm/irq_comm.c b/arch/x86/kvm/irq_comm.c
> index d5b72a08e566..be4424ddcd8f 100644
> --- a/arch/x86/kvm/irq_comm.c
> +++ b/arch/x86/kvm/irq_comm.c
> @@ -47,7 +47,7 @@ int kvm_irq_delivery_to_apic(struct kvm *kvm, struct kvm_lapic *src,
>   {
>   	int i, r = -1;
>   	struct kvm_vcpu *vcpu, *lowest = NULL;
> -	unsigned long dest_vcpu_bitmap[BITS_TO_LONGS(KVM_MAX_VCPUS)];
> +	unsigned long *dest_vcpu_bitmap;
>   	unsigned int dest_vcpus = 0;
>   
>   	if (kvm_irq_delivery_to_apic_fast(kvm, src, irq, &r, dest_map))
> @@ -59,7 +59,10 @@ int kvm_irq_delivery_to_apic(struct kvm *kvm, struct kvm_lapic *src,
>   		irq->delivery_mode = APIC_DM_FIXED;
>   	}
>   
> -	memset(dest_vcpu_bitmap, 0, sizeof(dest_vcpu_bitmap));
> +	preempt_disable();
> +	dest_vcpu_bitmap = this_cpu_ptr(kvm_pcpu_vcpu_mask);
> +
> +	memset(dest_vcpu_bitmap, 0, KVM_VCPU_MASK_SZ);
>   
>   	kvm_for_each_vcpu(i, vcpu, kvm) {
>   		if (!kvm_apic_present(vcpu))
> @@ -93,6 +96,8 @@ int kvm_irq_delivery_to_apic(struct kvm *kvm, struct kvm_lapic *src,
>   		lowest = kvm_get_vcpu(kvm, idx);
>   	}
>   
> +	preempt_enable();
> +
>   	if (lowest)
>   		r = kvm_apic_set_irq(lowest, irq, dest_map);
>   
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 0390d90fd360..3af398ef1fc9 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -180,6 +180,8 @@ module_param(pi_inject_timer, bint, S_IRUGO | S_IWUSR);
>   unsigned int __read_mostly max_vcpu_id = KVM_DEFAULT_MAX_VCPU_ID;
>   module_param(max_vcpu_id, uint, S_IRUGO);
>   
> +unsigned long __percpu *kvm_pcpu_vcpu_mask;
> +
>   /*
>    * Restoring the host value for MSRs that are only consumed when running in
>    * usermode, e.g. SYSCALL MSRs and TSC_AUX, can be deferred until the CPU
> @@ -10646,9 +10648,18 @@ int kvm_arch_hardware_setup(void *opaque)
>   	if (boot_cpu_has(X86_FEATURE_XSAVES))
>   		rdmsrl(MSR_IA32_XSS, host_xss);
>   
> +	kvm_pcpu_vcpu_mask = __alloc_percpu(KVM_VCPU_MASK_SZ,
> +					    sizeof(unsigned long));
> +	kvm_hv_vp_bitmap = __alloc_percpu(KVM_HV_VPMAP_SZ, sizeof(u64));
> +
> +	if (!kvm_pcpu_vcpu_mask || !kvm_hv_vp_bitmap) {
> +		r = -ENOMEM;
> +		goto err;
> +	}
> +
>   	r = ops->hardware_setup();
>   	if (r != 0)
> -		return r;
> +		goto err;
>   
>   	memcpy(&kvm_x86_ops, ops->runtime_ops, sizeof(kvm_x86_ops));
>   	kvm_ops_static_call_update();
> @@ -10676,11 +10687,18 @@ int kvm_arch_hardware_setup(void *opaque)
>   
>   	kvm_init_msr_list();
>   	return 0;
> +
> + err:
> +	free_percpu(kvm_pcpu_vcpu_mask);
> +	free_percpu(kvm_hv_vp_bitmap);
> +	return r;
>   }
>   
>   void kvm_arch_hardware_unsetup(void)
>   {
>   	static_call(kvm_x86_hardware_unsetup)();
> +	free_percpu(kvm_pcpu_vcpu_mask);
> +	free_percpu(kvm_hv_vp_bitmap);
>   }
>   
>   int kvm_arch_check_processor_compat(void *opaque)
> 

