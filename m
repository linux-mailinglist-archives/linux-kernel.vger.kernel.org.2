Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 270953BD7F1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 15:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232098AbhGFNnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 09:43:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51328 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232053AbhGFNms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 09:42:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625578809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bz/Z0XAjDKKGyg6/MwuUYfWQxJEwhF8Ca1/XdJESgZU=;
        b=J5pjzjdaLvtR7qQerrceqovdpg2xC3U/w+mGLkRhunzhLDJSvP42OxU7FY+r2Lm058u2S6
        aB4oyhSIGdIQq2i3KoEO8an5TnEb62CyD8QQut+hQ2uugCOadyBYuzrfJflPF/kyjSDfdt
        e+BAPQp/oJyIXKFseM+CZhq6ocix/sM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-YfD9zOOfN_uPAfqwHFrrgQ-1; Tue, 06 Jul 2021 09:40:08 -0400
X-MC-Unique: YfD9zOOfN_uPAfqwHFrrgQ-1
Received: by mail-ej1-f71.google.com with SMTP id ia10-20020a170907a06ab02904baf8000951so4234685ejc.10
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jul 2021 06:40:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Bz/Z0XAjDKKGyg6/MwuUYfWQxJEwhF8Ca1/XdJESgZU=;
        b=Z57fj5Np5eiWz6pUcGDPZkDgRmSfdtWX95NNKLEQI1xCthJRBIRKCg8JpW0wH/BJnJ
         55myR/KwXNi+imkr+JgxML4M3iMq4zBSrruj3VcNd0PdyBLRMqd8+/H6bSQ49mAePWSB
         tnB4t7WZBkUS8FBmzUX6akfKogOhha/A8RcSTZcvo9dEMAzcH3JvcsrkS/YP76VpIko0
         bvGupOzecGelMJcNLYPPtKjKPu8hvOQKQLBYkNBrGDZiDAy+FuXNwP8870OHH5RNx4vX
         earHTHFnZqRo4sJ89DTeOulHr5x4srP69ppW3YDQ2I93byn+kxB503tG6QSY3nD3Cn/b
         lBQQ==
X-Gm-Message-State: AOAM5316S2uvldUOvRFeZpisc9tjqFi/CGhh+dSg/K5F7FLBfQiUlsR4
        hewKB6+vAKcgSMwPaqKcGZ1Yr7tGyee6V6c6R8dTR3cnQxv9O5Mlri3LkV+KRBKig6c5Yw9n9+g
        O5wKf07mlfs0U8uhDYnleyqUc
X-Received: by 2002:a17:906:919:: with SMTP id i25mr18181328ejd.171.1625578807587;
        Tue, 06 Jul 2021 06:40:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw677bBx7bD1apM2pWRn+flV9vCn/+UzCqnQ7O/O8K8s1sl//ZdCAuPurWjgurH4BCSJebkBw==
X-Received: by 2002:a17:906:919:: with SMTP id i25mr18181286ejd.171.1625578807363;
        Tue, 06 Jul 2021 06:40:07 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id k25sm5810195eds.77.2021.07.06.06.40.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jul 2021 06:40:06 -0700 (PDT)
Subject: Re: [RFC PATCH v2 14/69] KVM: x86: Split core of hypercall emulation
 to helper function
To:     isaku.yamahata@intel.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, erdemaktas@google.com,
        Connor Kuehl <ckuehl@redhat.com>,
        Sean Christopherson <seanjc@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     isaku.yamahata@gmail.com,
        Sean Christopherson <sean.j.christopherson@intel.com>
References: <cover.1625186503.git.isaku.yamahata@intel.com>
 <9e1e66787c50232391e20cb4b3d1c5b249e3f910.1625186503.git.isaku.yamahata@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6e1370ce-d8ed-28cd-799c-f7a9f69e04ef@redhat.com>
Date:   Tue, 6 Jul 2021 15:40:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <9e1e66787c50232391e20cb4b3d1c5b249e3f910.1625186503.git.isaku.yamahata@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/07/21 00:04, isaku.yamahata@intel.com wrote:
> From: Sean Christopherson <sean.j.christopherson@intel.com>
> 
> By necessity, TDX will use a different register ABI for hypercalls.
> Break out the core functionality so that it may be reused for TDX.
> 
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> ---
>   arch/x86/include/asm/kvm_host.h |  4 +++
>   arch/x86/kvm/x86.c              | 55 ++++++++++++++++++++-------------
>   2 files changed, 38 insertions(+), 21 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 9c7ced0e3171..80b943e4ab6d 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1667,6 +1667,10 @@ void kvm_vcpu_update_apicv(struct kvm_vcpu *vcpu);
>   void kvm_request_apicv_update(struct kvm *kvm, bool activate,
>   			      unsigned long bit);
>   
> +unsigned long __kvm_emulate_hypercall(struct kvm_vcpu *vcpu, unsigned long nr,
> +				      unsigned long a0, unsigned long a1,
> +				      unsigned long a2, unsigned long a3,
> +				      int op_64_bit);
>   int kvm_emulate_hypercall(struct kvm_vcpu *vcpu);
>   
>   int kvm_mmu_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa, u64 error_code,
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index d11cf87674f3..795f83a1cf9a 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -8406,26 +8406,15 @@ static void kvm_sched_yield(struct kvm_vcpu *vcpu, unsigned long dest_id)
>   	return;
>   }
>   
> -int kvm_emulate_hypercall(struct kvm_vcpu *vcpu)
> +unsigned long __kvm_emulate_hypercall(struct kvm_vcpu *vcpu, unsigned long nr,
> +				      unsigned long a0, unsigned long a1,
> +				      unsigned long a2, unsigned long a3,
> +				      int op_64_bit)
>   {
> -	unsigned long nr, a0, a1, a2, a3, ret;
> -	int op_64_bit;
> -
> -	if (kvm_xen_hypercall_enabled(vcpu->kvm))
> -		return kvm_xen_hypercall(vcpu);
> -
> -	if (kvm_hv_hypercall_enabled(vcpu))
> -		return kvm_hv_hypercall(vcpu);
> -
> -	nr = kvm_rax_read(vcpu);
> -	a0 = kvm_rbx_read(vcpu);
> -	a1 = kvm_rcx_read(vcpu);
> -	a2 = kvm_rdx_read(vcpu);
> -	a3 = kvm_rsi_read(vcpu);
> +	unsigned long ret;
>   
>   	trace_kvm_hypercall(nr, a0, a1, a2, a3);
>   
> -	op_64_bit = is_64_bit_mode(vcpu);
>   	if (!op_64_bit) {
>   		nr &= 0xFFFFFFFF;
>   		a0 &= 0xFFFFFFFF;
> @@ -8434,11 +8423,6 @@ int kvm_emulate_hypercall(struct kvm_vcpu *vcpu)
>   		a3 &= 0xFFFFFFFF;
>   	}
>   
> -	if (static_call(kvm_x86_get_cpl)(vcpu) != 0) {
> -		ret = -KVM_EPERM;
> -		goto out;
> -	}
> -
>   	ret = -KVM_ENOSYS;
>   
>   	switch (nr) {
> @@ -8475,6 +8459,35 @@ int kvm_emulate_hypercall(struct kvm_vcpu *vcpu)
>   		ret = -KVM_ENOSYS;
>   		break;
>   	}
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(__kvm_emulate_hypercall);
> +
> +int kvm_emulate_hypercall(struct kvm_vcpu *vcpu)
> +{
> +	unsigned long nr, a0, a1, a2, a3, ret;
> +	int op_64_bit;
> +
> +	if (kvm_xen_hypercall_enabled(vcpu->kvm))
> +		return kvm_xen_hypercall(vcpu);
> +
> +	if (kvm_hv_hypercall_enabled(vcpu))
> +		return kvm_hv_hypercall(vcpu);
> +
> +	nr = kvm_rax_read(vcpu);
> +	a0 = kvm_rbx_read(vcpu);
> +	a1 = kvm_rcx_read(vcpu);
> +	a2 = kvm_rdx_read(vcpu);
> +	a3 = kvm_rsi_read(vcpu);
> +
> +	op_64_bit = is_64_bit_mode(vcpu);
> +
> +	if (static_call(kvm_x86_get_cpl)(vcpu) != 0) {
> +		ret = -KVM_EPERM;
> +		goto out;
> +	}
> +
> +	ret = __kvm_emulate_hypercall(vcpu, nr, a0, a1, a2, a3, op_64_bit);
>   out:
>   	if (!op_64_bit)
>   		ret = (u32)ret;
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

