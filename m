Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87E4431EA8A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 14:47:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbhBRNqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 08:46:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45093 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231285AbhBRL51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 06:57:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613649301;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xM9m3LAcIkQCLSgn4HHjJl45j/tS8G7ursOunXYklgQ=;
        b=U7tgG82ulsPAam8upwU7WVVOAKDLF6m5D8s0BeHnmAU18IthLzYJOv4sh7/cBFxQnvHTYW
        qTxFUSaWCnu3kwzGW5ncIro5gpoJIZIzS1hA+M3RP1wIFwiYSF9ADjFOJ9EvjlSUDm8rKL
        YTFcXfav4uAHP95txdYmZq2UxxwKrto=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-z-Cx62M6NTOv0OSjLCCG-A-1; Thu, 18 Feb 2021 06:54:58 -0500
X-MC-Unique: z-Cx62M6NTOv0OSjLCCG-A-1
Received: by mail-wr1-f70.google.com with SMTP id x1so849652wrg.22
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 03:54:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xM9m3LAcIkQCLSgn4HHjJl45j/tS8G7ursOunXYklgQ=;
        b=c3e/VHSvkPW+GZoTfM73otmi7GXbCUV+kLZ7gG00hOe6cq1wcmkgR87atF12VFo0KO
         wzKOftGqr1US0rMUmgyAWAiY9YE+cIl1VJZvIgYT1/vzVeuCkieqRGkIhOTqU/NcHswV
         OIIVjPIr7ReeiPDOr9ePr6oREMJ4v9ym4ggF2cxWMCaRXHr0axIBMQ3s2oj2CuDDzNgN
         ySmTnR5CqW269RXbzUW6J4C2iXaCz/H2HIBl+ZsZoSIgb+eGe4xp4zMcmi8ODNjakBVl
         vDLLav8/UU3OKSoyh86+1Gmlh/fLnb4kFfQ4ROP92QdTT7ORhoD9dMGNRnEo10VWhe1p
         LJlg==
X-Gm-Message-State: AOAM530HIp/P2AGzt6EcyJbLtq1jf+U54S7Bk7cFfqdwQIbzdF7YgE/f
        KNPuZ7oZewXCV6DbnNggoBGceQH8q88Avh8PGFWQLWYKxuzk6TuCvudiPUlAgMmHxT9VYzpkLd7
        upgRno/uLruLN1TsyuIgrhyR7
X-Received: by 2002:adf:fa91:: with SMTP id h17mr3952993wrr.257.1613649296561;
        Thu, 18 Feb 2021 03:54:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxCxFOaHyjfxAcmm2wPtgetlm8fz285CphttwWL3I/oT6ge81OjEf5rAAWEk5jk4hyQa/9f4w==
X-Received: by 2002:adf:fa91:: with SMTP id h17mr3952968wrr.257.1613649296270;
        Thu, 18 Feb 2021 03:54:56 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id r2sm8924563wrp.33.2021.02.18.03.54.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Feb 2021 03:54:55 -0800 (PST)
Subject: Re: [PATCH] KVM: x86: dump_vmcs should not assume GUEST_IA32_EFER is
 valid
To:     David Edmondson <david.edmondson@oracle.com>,
        linux-kernel@vger.kernel.org
Cc:     Borislav Petkov <bp@alien8.de>, Wanpeng Li <wanpengli@tencent.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
References: <20210218100450.2157308-1-david.edmondson@oracle.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <708f2956-fa0f-b008-d3d2-93067f95783c@redhat.com>
Date:   Thu, 18 Feb 2021 12:54:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210218100450.2157308-1-david.edmondson@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/02/21 11:04, David Edmondson wrote:
> When dumping the VMCS, retrieve the current guest value of EFER from
> the kvm_vcpu structure if neither VM_EXIT_SAVE_IA32_EFER or
> VM_ENTRY_LOAD_IA32_EFER is set, which can occur if the processor does
> not support the relevant VM-exit/entry controls.

Printing vcpu->arch.efer is not the best choice however.  Could we dump 
the whole MSR load/store area instead?

Paolo

> Fixes: 4eb64dce8d0a ("KVM: x86: dump VMCS on invalid entry")
> Signed-off-by: David Edmondson <david.edmondson@oracle.com>
> ---
>   arch/x86/kvm/vmx/vmx.c | 14 +++++++++-----
>   arch/x86/kvm/vmx/vmx.h |  2 +-
>   2 files changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index eb69fef57485..74ea4fe6f35e 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -5754,7 +5754,7 @@ static void vmx_dump_dtsel(char *name, uint32_t limit)
>   	       vmcs_readl(limit + GUEST_GDTR_BASE - GUEST_GDTR_LIMIT));
>   }
>   
> -void dump_vmcs(void)
> +void dump_vmcs(struct kvm_vcpu *vcpu)
>   {
>   	u32 vmentry_ctl, vmexit_ctl;
>   	u32 cpu_based_exec_ctrl, pin_based_exec_ctrl, secondary_exec_control;
> @@ -5771,7 +5771,11 @@ void dump_vmcs(void)
>   	cpu_based_exec_ctrl = vmcs_read32(CPU_BASED_VM_EXEC_CONTROL);
>   	pin_based_exec_ctrl = vmcs_read32(PIN_BASED_VM_EXEC_CONTROL);
>   	cr4 = vmcs_readl(GUEST_CR4);
> -	efer = vmcs_read64(GUEST_IA32_EFER);
> +	if ((vmexit_ctl & VM_EXIT_SAVE_IA32_EFER) ||
> +	    (vmentry_ctl & VM_ENTRY_LOAD_IA32_EFER))
> +		efer = vmcs_read64(GUEST_IA32_EFER);
> +	else
> +		efer = vcpu->arch.efer;
>   	secondary_exec_control = 0;
>   	if (cpu_has_secondary_exec_ctrls())
>   		secondary_exec_control = vmcs_read32(SECONDARY_VM_EXEC_CONTROL);
> @@ -5955,7 +5959,7 @@ static int vmx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
>   	}
>   
>   	if (exit_reason & VMX_EXIT_REASONS_FAILED_VMENTRY) {
> -		dump_vmcs();
> +		dump_vmcs(vcpu);
>   		vcpu->run->exit_reason = KVM_EXIT_FAIL_ENTRY;
>   		vcpu->run->fail_entry.hardware_entry_failure_reason
>   			= exit_reason;
> @@ -5964,7 +5968,7 @@ static int vmx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
>   	}
>   
>   	if (unlikely(vmx->fail)) {
> -		dump_vmcs();
> +		dump_vmcs(vcpu);
>   		vcpu->run->exit_reason = KVM_EXIT_FAIL_ENTRY;
>   		vcpu->run->fail_entry.hardware_entry_failure_reason
>   			= vmcs_read32(VM_INSTRUCTION_ERROR);
> @@ -6049,7 +6053,7 @@ static int vmx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
>   
>   unexpected_vmexit:
>   	vcpu_unimpl(vcpu, "vmx: unexpected exit reason 0x%x\n", exit_reason);
> -	dump_vmcs();
> +	dump_vmcs(vcpu);
>   	vcpu->run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
>   	vcpu->run->internal.suberror =
>   			KVM_INTERNAL_ERROR_UNEXPECTED_EXIT_REASON;
> diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
> index 9d3a557949ac..f8a0ce74798e 100644
> --- a/arch/x86/kvm/vmx/vmx.h
> +++ b/arch/x86/kvm/vmx/vmx.h
> @@ -489,6 +489,6 @@ static inline bool vmx_guest_state_valid(struct kvm_vcpu *vcpu)
>   	return is_unrestricted_guest(vcpu) || __vmx_guest_state_valid(vcpu);
>   }
>   
> -void dump_vmcs(void);
> +void dump_vmcs(struct kvm_vcpu *vcpu);
>   
>   #endif /* __KVM_X86_VMX_H */
> 

