Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 523BA44D72C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 14:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233410AbhKKN1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 08:27:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49230 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233389AbhKKN1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 08:27:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636637082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n3WqyrBq2uTJR8bpD8MKc2sLqvPUK4BN0YHRdeMyR0k=;
        b=hJX6mF9TFKumWbxSQJ12XSCPEUmwY0qJcjoaWtaFPnpF14kfVTxIp3MO35kHlBmFWtzTmo
        +h3dazAcJo61vDrGothQWe8We8Z6r7YVcR0+1kABR9JfnE49ygBwr9IOAzrVIZqOrVg8h5
        yHt/4Pp6jEQW+wiIptM/yhDouVqAxjk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-8yj53UKwOSyHuPpjqmlSoA-1; Thu, 11 Nov 2021 08:24:39 -0500
X-MC-Unique: 8yj53UKwOSyHuPpjqmlSoA-1
Received: by mail-ed1-f70.google.com with SMTP id x13-20020a05640226cd00b003e2bf805a02so5347218edd.23
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 05:24:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=n3WqyrBq2uTJR8bpD8MKc2sLqvPUK4BN0YHRdeMyR0k=;
        b=1bK6v/oLGoNX8mtRXfJnPqqVRZXuJQsjHCdFuCpwS3wHLxrhIHXFxj/PH2K4/dXnUs
         Hw8Qk9bS8tLRoLhaO3efrOUqITvY6E87cNwMcHp0fIJpHX4wbaLxYcarYBwxG7ou3JIg
         k6vSjmy6xM8pXLFcx54CHzmv0LY/QogIgPFe95yK6BUBYzUuw3ykjUl7/N+b+mtH+wjX
         XLMWDiiC9NRnQzbFoO6pRo72QdrIew19uD98z4yVZrU/+VxBSU1EDtydIUbp9ia1sLJY
         jkeFziiUT98ohAz+DVJIRkuUOk5haatqIdskmlCSf21w1cUrTfci1KCS2LJgB+q06z1d
         xk9w==
X-Gm-Message-State: AOAM530T6Lj7J8kEAoRQbTNZTMArwYtqtpCUeTwP0Ws6T0afcT8H+bUm
        AMjUQCj/HEc5qxae/54J73jD3jRZKNu8IJ0MKOWBbyAMMnzlc27OmWywwTA72CGVB0lTRWSbU+A
        IElM32T1hQPR2YmrkkMGSStEO
X-Received: by 2002:a17:907:1c1f:: with SMTP id nc31mr9435975ejc.210.1636637077975;
        Thu, 11 Nov 2021 05:24:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz4Rc9RSHfyPuquSvW65YFg3YPh5YwwspZVNv/qX0D7M932u2rP7K0HG2NJ0phRnS7ZSu7eHg==
X-Received: by 2002:a17:907:1c1f:: with SMTP id nc31mr9435941ejc.210.1636637077764;
        Thu, 11 Nov 2021 05:24:37 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.gmail.com with ESMTPSA id em21sm1342487ejc.103.2021.11.11.05.24.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Nov 2021 05:24:37 -0800 (PST)
Message-ID: <511ea6df-ae7e-dbbb-8b11-95d6f440ddb3@redhat.com>
Date:   Thu, 11 Nov 2021 14:24:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v4] KVM: x86: inhibit APICv when KVM_GUESTDBG_BLOCKIRQ
 active
Content-Language: en-US
To:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>
References: <20211108090245.166408-1-mlevitsk@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20211108090245.166408-1-mlevitsk@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/8/21 10:02, Maxim Levitsky wrote:
> KVM_GUESTDBG_BLOCKIRQ relies on interrupts being injected using
> standard kvm's inject_pending_event, and not via APICv/AVIC.
> 
> Since this is a debug feature, just inhibit APICv/AVIC while
> KVM_GUESTDBG_BLOCKIRQ is in use on at least one vCPU.
> 
> Fixes: 61e5f69ef0837 ("KVM: x86: implement KVM_GUESTDBG_BLOCKIRQ")
> 
> Reported-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> Reviewed-and-tested-by: Sean Christopherson <seanjc@google.com>
> ---
>   arch/x86/include/asm/kvm_host.h |  1 +
>   arch/x86/kvm/svm/avic.c         |  3 ++-
>   arch/x86/kvm/vmx/vmx.c          |  3 ++-
>   arch/x86/kvm/x86.c              | 20 ++++++++++++++++++++
>   4 files changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 88fce6ab4bbd7..8f6e15b95a4d8 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1034,6 +1034,7 @@ struct kvm_x86_msr_filter {
>   #define APICV_INHIBIT_REASON_IRQWIN     3
>   #define APICV_INHIBIT_REASON_PIT_REINJ  4
>   #define APICV_INHIBIT_REASON_X2APIC	5
> +#define APICV_INHIBIT_REASON_BLOCKIRQ	6
>   
>   struct kvm_arch {
>   	unsigned long n_used_mmu_pages;
> diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
> index 8052d92069e01..affc0ea98d302 100644
> --- a/arch/x86/kvm/svm/avic.c
> +++ b/arch/x86/kvm/svm/avic.c
> @@ -904,7 +904,8 @@ bool svm_check_apicv_inhibit_reasons(ulong bit)
>   			  BIT(APICV_INHIBIT_REASON_NESTED) |
>   			  BIT(APICV_INHIBIT_REASON_IRQWIN) |
>   			  BIT(APICV_INHIBIT_REASON_PIT_REINJ) |
> -			  BIT(APICV_INHIBIT_REASON_X2APIC);
> +			  BIT(APICV_INHIBIT_REASON_X2APIC) |
> +			  BIT(APICV_INHIBIT_REASON_BLOCKIRQ);
>   
>   	return supported & BIT(bit);
>   }
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 71f54d85f104c..e4fc9ff7cd944 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -7565,7 +7565,8 @@ static void hardware_unsetup(void)
>   static bool vmx_check_apicv_inhibit_reasons(ulong bit)
>   {
>   	ulong supported = BIT(APICV_INHIBIT_REASON_DISABLE) |
> -			  BIT(APICV_INHIBIT_REASON_HYPERV);
> +			  BIT(APICV_INHIBIT_REASON_HYPERV) |
> +			  BIT(APICV_INHIBIT_REASON_BLOCKIRQ);
>   
>   	return supported & BIT(bit);
>   }
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index ac83d873d65b0..6064ac47c8a37 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -10703,6 +10703,24 @@ int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,
>   	return ret;
>   }
>   
> +static void kvm_arch_vcpu_guestdbg_update_apicv_inhibit(struct kvm *kvm)
> +{
> +	bool inhibit = false;
> +	struct kvm_vcpu *vcpu;
> +	int i;
> +
> +	down_write(&kvm->arch.apicv_update_lock);
> +
> +	kvm_for_each_vcpu(i, vcpu, kvm) {
> +		if (vcpu->guest_debug & KVM_GUESTDBG_BLOCKIRQ) {
> +			inhibit = true;
> +			break;
> +		}
> +	}
> +	__kvm_request_apicv_update(kvm, !inhibit, APICV_INHIBIT_REASON_BLOCKIRQ);
> +	up_write(&kvm->arch.apicv_update_lock);
> +}
> +
>   int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
>   					struct kvm_guest_debug *dbg)
>   {
> @@ -10755,6 +10773,8 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
>   
>   	static_call(kvm_x86_update_exception_bitmap)(vcpu);
>   
> +	kvm_arch_vcpu_guestdbg_update_apicv_inhibit(vcpu->kvm);
> +
>   	r = 0;
>   
>   out:
> 

Queued, thanks.

Paolo

