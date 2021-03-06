Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 035FD32FAF6
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 14:57:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbhCFN43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 08:56:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48025 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230259AbhCFN4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 08:56:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615038977;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FeqUTRA8uP0WljeVKQJ0UhmWA2YO3SuLjYpwE2Mi2Yo=;
        b=T9O62cydISz+OURScgcXzMVVDU2tRiRwRYXyxF09MgbWWkNN02w+P/v35HIo+MFg9OcQ4p
        blYlwrm25LtwQVfiBxQx+oEvKaUAol55Dmv076i+hgjvqAzSdVmeXoSwIXmbEhCt1PbIxB
        a2k4t4g/jryZynPTjwC/TSdpmJfQIYY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-538-mQ9ro7PDMgS__vTFE_ulqw-1; Sat, 06 Mar 2021 08:56:15 -0500
X-MC-Unique: mQ9ro7PDMgS__vTFE_ulqw-1
Received: by mail-wr1-f72.google.com with SMTP id h5so2528901wrr.17
        for <linux-kernel@vger.kernel.org>; Sat, 06 Mar 2021 05:56:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FeqUTRA8uP0WljeVKQJ0UhmWA2YO3SuLjYpwE2Mi2Yo=;
        b=Mui3k2a0eF3rS6IMrQz+wl5oChNj9EbCa5jwKlWlivHvyvy3MxnuXkJbD4qQhtZubM
         I+vZxJmrs3AG/ljKa8tQfDWQLlHHTEJqBNzPozGI28OO9G8/GjAlp3cCfutYSJyaem83
         V5PVmhH2k/80QjBqjNBg1UtTmOFK88gBfrmrGMQVfmynSwOF/1HYTz+7zPrHtmaWckBV
         bxl11sMJv1T1dL8IZRzk2B+xaOE3kyOg/FH0Udxrs6YKs/ELYn5TNKKpiGRJUG2usE2f
         fH9WhmcCT9vhomGthzYZ0Y66BuZPdcJM435wDsz/AbFTPLF1VMhaiDR8aF2SilZVQ2dg
         f9Tg==
X-Gm-Message-State: AOAM532dr1QFFg9CEOypnu/xDRPBnsZyPmDniLktfcIsDeP8TnulJ1BR
        HRSWf1ZdmPDgVZ0mWQwCbaLOl8C3ow0cp69uZKbaNLNRiqwd1rXHUCs9NYqAHQOmSZ993uHaxxj
        fiw40JFA1jRgsa89nwM1gp+XL
X-Received: by 2002:adf:8b0d:: with SMTP id n13mr14482373wra.94.1615038973853;
        Sat, 06 Mar 2021 05:56:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx0gXaw4vyThiyxnIVYScgpR0Sj+FLwy7oYfzFJuKCwugx3XAqCs2vWgS8/jgzo0gmGY4nw6Q==
X-Received: by 2002:adf:8b0d:: with SMTP id n13mr14482362wra.94.1615038973700;
        Sat, 06 Mar 2021 05:56:13 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id g202sm8781763wme.20.2021.03.06.05.56.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Mar 2021 05:56:13 -0800 (PST)
Subject: Re: [PATCH 1/1] KVM: x86: to track if L1 is running L2 VM
To:     Dongli Zhang <dongli.zhang@oracle.com>, x86@kernel.org,
        kvm@vger.kernel.org
Cc:     seanjc@google.com, vkuznets@redhat.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        linux-kernel@vger.kernel.org, joe.jin@oracle.com
References: <20210305225747.7682-1-dongli.zhang@oracle.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cebd5f51-12e8-44e5-7568-8890343ca36e@redhat.com>
Date:   Sat, 6 Mar 2021 14:56:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210305225747.7682-1-dongli.zhang@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/03/21 23:57, Dongli Zhang wrote:
> The new per-cpu stat 'nested_run' is introduced in order to track if L1 VM
> is running or used to run L2 VM.
> 
> An example of the usage of 'nested_run' is to help the host administrator
> to easily track if any L1 VM is used to run L2 VM. Suppose there is issue
> that may happen with nested virtualization, the administrator will be able
> to easily narrow down and confirm if the issue is due to nested
> virtualization via 'nested_run'. For example, whether the fix like
> commit 88dddc11a8d6 ("KVM: nVMX: do not use dangling shadow VMCS after
> guest reset") is required.
> 
> Cc: Joe Jin <joe.jin@oracle.com>
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---
>   arch/x86/include/asm/kvm_host.h | 1 +
>   arch/x86/kvm/svm/nested.c       | 2 ++
>   arch/x86/kvm/vmx/nested.c       | 2 ++
>   arch/x86/kvm/x86.c              | 1 +
>   4 files changed, 6 insertions(+)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 877a4025d8da..7669215426ac 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1125,6 +1125,7 @@ struct kvm_vcpu_stat {
>   	u64 req_event;
>   	u64 halt_poll_success_ns;
>   	u64 halt_poll_fail_ns;
> +	u64 nested_run;
>   };
>   
>   struct x86_instruction_info;
> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index 35891d9a1099..18c02e958a09 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -494,6 +494,8 @@ int nested_svm_vmrun(struct vcpu_svm *svm)
>   	struct kvm_host_map map;
>   	u64 vmcb12_gpa;
>   
> +	++svm->vcpu.stat.nested_run;
> +
>   	if (is_smm(&svm->vcpu)) {
>   		kvm_queue_exception(&svm->vcpu, UD_VECTOR);
>   		return 1;
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index bcca0b80e0d0..bd1343a0896e 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -3453,6 +3453,8 @@ static int nested_vmx_run(struct kvm_vcpu *vcpu, bool launch)
>   	u32 interrupt_shadow = vmx_get_interrupt_shadow(vcpu);
>   	enum nested_evmptrld_status evmptrld_status;
>   
> +	++vcpu->stat.nested_run;
> +
>   	if (!nested_vmx_check_permission(vcpu))
>   		return 1;
>   
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 2a20ce60152e..f296febb0485 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -245,6 +245,7 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
>   	VCPU_STAT("l1d_flush", l1d_flush),
>   	VCPU_STAT("halt_poll_success_ns", halt_poll_success_ns),
>   	VCPU_STAT("halt_poll_fail_ns", halt_poll_fail_ns),
> +	VCPU_STAT("nested_run", nested_run),
>   	VM_STAT("mmu_shadow_zapped", mmu_shadow_zapped),
>   	VM_STAT("mmu_pte_write", mmu_pte_write),
>   	VM_STAT("mmu_pde_zapped", mmu_pde_zapped),
> 

Queued, thanks.

Paolo

