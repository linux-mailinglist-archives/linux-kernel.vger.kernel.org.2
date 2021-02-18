Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96A0331EB1B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 15:50:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbhBROr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 09:47:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39471 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233287AbhBRMum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 07:50:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613652553;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5tqPiD4rA1ymxE9WMKgZ6Eo41+4cn7IrQqaS0meXyig=;
        b=ZJK3gmW6Vt1UPcJschkDl697lveueMxJ1PBv9ja1/zZhxx/GfRwBQsxMNY8UeY0y8glAT5
        EP+HIawWEhdStX350Q4neTLewLf2fx3yxVpFcZxqQ2Zbx6rB8XoOwp6qjWUynrbQ07DhWh
        nyNFLyM5y2/QF2IZVTWnBkuO41SehJw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-14-qshUZ-D9OwmD56zJto371Q-1; Thu, 18 Feb 2021 07:45:42 -0500
X-MC-Unique: qshUZ-D9OwmD56zJto371Q-1
Received: by mail-wr1-f69.google.com with SMTP id e12so925077wrw.14
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 04:45:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5tqPiD4rA1ymxE9WMKgZ6Eo41+4cn7IrQqaS0meXyig=;
        b=Y/I8wv0FHuDp7tK61jRgBJGJmVb8vpXMgtr2w9dYufws0UT+0lRPncYkB0qWoDfRdw
         xx3CJIe4Y/xuq9y1YgJqFy/YbQt/Q5aMfMV+KX7FiujN8A3mnqwrZoEDemhPNMn1nXKD
         D8PjhwTCEHOoa0bvu6IM3SYo5MKq2cIpkroC9ypqAqEe4ZO84VQ0CeRhnCZDTMQDoVRq
         qTmWnF+zHOzJvHNmvirJ3M6uwvru5dpwfzCvUMryzeMgNKl0MR/NgsRXYmHzZ/Ug73zs
         Y6sbQJ1jRV56YEtUrLQ5YbhQSoMKYaxkhf0yAMttpByUatpWN02ThoQdWE2HPqv7h/Ny
         m0XA==
X-Gm-Message-State: AOAM533wXS5WBZIMsGzdteuwSKIgx925sEiGeaEXHy8fKMKs4K41ZhCg
        2HKol5ZgN9zTdWMCN/hm1aLg+LRM+1QeW8SpE38OO7DZCYGi38Lh1PXrPZ6ia1Xc3T1lydyT8f4
        1FwAFsUd+GvBuNLul0BJ/CWrg
X-Received: by 2002:a7b:c353:: with SMTP id l19mr3526930wmj.147.1613652340189;
        Thu, 18 Feb 2021 04:45:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzbRXwAXw0ZghLddR/iDu3Xon4nUDZZpWGBM55XHhg/uCCMEccmKqxg+YpEEDbPnkg+zyDFrA==
X-Received: by 2002:a7b:c353:: with SMTP id l19mr3526911wmj.147.1613652339942;
        Thu, 18 Feb 2021 04:45:39 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id p9sm7636148wmc.1.2021.02.18.04.45.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Feb 2021 04:45:39 -0800 (PST)
Subject: Re: [PATCH 08/14] KVM: x86/mmu: Make dirty log size hook (PML) a
 value, not a function
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>,
        Makarand Sonare <makarandsonare@google.com>
References: <20210213005015.1651772-1-seanjc@google.com>
 <20210213005015.1651772-9-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9bb705c8-101d-5f20-bffd-ccd44cbaf663@redhat.com>
Date:   Thu, 18 Feb 2021 13:45:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210213005015.1651772-9-seanjc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/02/21 01:50, Sean Christopherson wrote:
> Store the vendor-specific dirty log size in a variable, there's no need
> to wrap it in a function since the value is constant after
> hardware_setup() runs.

For now... :)

Paolo

> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>   arch/x86/include/asm/kvm-x86-ops.h | 1 -
>   arch/x86/include/asm/kvm_host.h    | 2 +-
>   arch/x86/kvm/mmu/mmu.c             | 5 +----
>   arch/x86/kvm/vmx/vmx.c             | 9 ++-------
>   4 files changed, 4 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
> index 355a2ab8fc09..28c07cc01474 100644
> --- a/arch/x86/include/asm/kvm-x86-ops.h
> +++ b/arch/x86/include/asm/kvm-x86-ops.h
> @@ -97,7 +97,6 @@ KVM_X86_OP_NULL(slot_enable_log_dirty)
>   KVM_X86_OP_NULL(slot_disable_log_dirty)
>   KVM_X86_OP_NULL(flush_log_dirty)
>   KVM_X86_OP_NULL(enable_log_dirty_pt_masked)
> -KVM_X86_OP_NULL(cpu_dirty_log_size)
>   KVM_X86_OP_NULL(pre_block)
>   KVM_X86_OP_NULL(post_block)
>   KVM_X86_OP_NULL(vcpu_blocking)
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 84499aad01a4..fb59933610d9 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1294,7 +1294,7 @@ struct kvm_x86_ops {
>   	void (*enable_log_dirty_pt_masked)(struct kvm *kvm,
>   					   struct kvm_memory_slot *slot,
>   					   gfn_t offset, unsigned long mask);
> -	int (*cpu_dirty_log_size)(void);
> +	int cpu_dirty_log_size;
>   
>   	/* pmu operations of sub-arch */
>   	const struct kvm_pmu_ops *pmu_ops;
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index d5849a0e3de1..6c32e8e0f720 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -1294,10 +1294,7 @@ void kvm_arch_mmu_enable_log_dirty_pt_masked(struct kvm *kvm,
>   
>   int kvm_cpu_dirty_log_size(void)
>   {
> -	if (kvm_x86_ops.cpu_dirty_log_size)
> -		return static_call(kvm_x86_cpu_dirty_log_size)();
> -
> -	return 0;
> +	return kvm_x86_ops.cpu_dirty_log_size;
>   }
>   
>   bool kvm_mmu_slot_gfn_write_protect(struct kvm *kvm,
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index b47ed3f412ef..f843707dd7df 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -7650,11 +7650,6 @@ static bool vmx_check_apicv_inhibit_reasons(ulong bit)
>   	return supported & BIT(bit);
>   }
>   
> -static int vmx_cpu_dirty_log_size(void)
> -{
> -	return enable_pml ? PML_ENTITY_NUM : 0;
> -}
> -
>   static struct kvm_x86_ops vmx_x86_ops __initdata = {
>   	.hardware_unsetup = hardware_unsetup,
>   
> @@ -7758,6 +7753,7 @@ static struct kvm_x86_ops vmx_x86_ops __initdata = {
>   	.slot_disable_log_dirty = vmx_slot_disable_log_dirty,
>   	.flush_log_dirty = vmx_flush_log_dirty,
>   	.enable_log_dirty_pt_masked = vmx_enable_log_dirty_pt_masked,
> +	.cpu_dirty_log_size = PML_ENTITY_NUM,
>   
>   	.pre_block = vmx_pre_block,
>   	.post_block = vmx_post_block,
> @@ -7785,7 +7781,6 @@ static struct kvm_x86_ops vmx_x86_ops __initdata = {
>   
>   	.msr_filter_changed = vmx_msr_filter_changed,
>   	.complete_emulated_msr = kvm_complete_insn_gp,
> -	.cpu_dirty_log_size = vmx_cpu_dirty_log_size,
>   
>   	.vcpu_deliver_sipi_vector = kvm_vcpu_deliver_sipi_vector,
>   };
> @@ -7907,7 +7902,7 @@ static __init int hardware_setup(void)
>   		vmx_x86_ops.slot_disable_log_dirty = NULL;
>   		vmx_x86_ops.flush_log_dirty = NULL;
>   		vmx_x86_ops.enable_log_dirty_pt_masked = NULL;
> -		vmx_x86_ops.cpu_dirty_log_size = NULL;
> +		vmx_x86_ops.cpu_dirty_log_size = 0;
>   	}
>   
>   	if (!cpu_has_vmx_preemption_timer())
> 

