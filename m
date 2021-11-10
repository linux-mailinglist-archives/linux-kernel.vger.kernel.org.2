Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 584B344BF52
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 11:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbhKJLBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 06:01:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32362 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229653AbhKJLBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 06:01:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636541905;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8fkTpO8x5KG1uxXpfme5xvq/R22WXXuhTXHbIA1ozCs=;
        b=FsZ+pyKYXIFTwhKhQrX8tWXsfCxnk9dUzlnB+Xfz5M2ZwQTGeYxwgRAgz39XNXyGcalqry
        +HNHQvNA/Y3RnexKXQ1sGif64mXlwl3R4YAQls33rix13s9EN4kr9lk/wizy9NLyo/ivlP
        +ebPMIMHHEodIbW1YSa9mSAy/zUVTM4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-463-UzeHKOE1OneyXjXIq8j7bA-1; Wed, 10 Nov 2021 05:58:24 -0500
X-MC-Unique: UzeHKOE1OneyXjXIq8j7bA-1
Received: by mail-wr1-f72.google.com with SMTP id y4-20020adfd084000000b00186b16950f3so344807wrh.14
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 02:58:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8fkTpO8x5KG1uxXpfme5xvq/R22WXXuhTXHbIA1ozCs=;
        b=1Cyf+9ZbcT4bXOltet0aMEiXcDhMN1RHvERJjsuaZ8zmQBIfPlyKY0fYV1fFi3y9EB
         6Dak9VH8BMziDZUuInEUDiEq37nu63iU1wYFEnPnA0NNdkSFVa4j2hTF/Xw9HGmp7VrX
         DXSanR6LeZ/8DDALAuHbMffrhV7DXR09rE9O5SQWYqCj6bFnZs/G3eA4bBPBxxOK5C/U
         Q0UyngTK1hHMwTjezI4RaLle589pDQqSK3YWKQUHAcWS1BlmGflp605e1HPB9pdqmdkE
         4wEWu8VYovmqkUaB5NaB55oBZV0dAKCRAkyU7ANFfuWJIXGu5DBhdNY/MCG2jFMZwlOm
         rkog==
X-Gm-Message-State: AOAM533w3lP9ksxq66kR6Ue6ELbc9GAq5moOZmMlZ5jA/2dZObnCoKEf
        fbpItcm6LZvBShkYtRW31vBDDzq5khNhkB2KioplTgBEizInln6UKHQo8Wpb4sPfuKmQELV4N2j
        XVScY+lEFHMhz0TdG0V95wmTc
X-Received: by 2002:a05:6000:144a:: with SMTP id v10mr18771461wrx.315.1636541901503;
        Wed, 10 Nov 2021 02:58:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyZiFUK0C+P7RAAilIWjg74hcMjiNVE3fYOUwlaPcAr2Zmm8n4sLXKeaXZITxXUeii59v5LyQ==
X-Received: by 2002:a05:6000:144a:: with SMTP id v10mr18771419wrx.315.1636541901270;
        Wed, 10 Nov 2021 02:58:21 -0800 (PST)
Received: from ?IPv6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id u5sm23648630wrg.57.2021.11.10.02.58.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Nov 2021 02:58:20 -0800 (PST)
Subject: Re: [PATCH v4 14/21] KVM: arm64: Support SDEI_EVENT_{COMPLETE,
 COMPLETE_AND_RESUME} hypercall
To:     Gavin Shan <gshan@redhat.com>, kvmarm@lists.cs.columbia.edu
Cc:     maz@kernel.org, linux-kernel@vger.kernel.org,
        Jonathan.Cameron@huawei.com, pbonzini@redhat.com, will@kernel.org
References: <20210815001352.81927-1-gshan@redhat.com>
 <20210815001352.81927-15-gshan@redhat.com>
From:   Eric Auger <eauger@redhat.com>
Message-ID: <62c67e31-fa33-24e9-6508-59976673c0db@redhat.com>
Date:   Wed, 10 Nov 2021 11:58:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210815001352.81927-15-gshan@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gavin,

On 8/15/21 2:13 AM, Gavin Shan wrote:
> This supports SDEI_EVENT_{COMPLETE, COMPLETE_AND_RESUME} hypercall.
> They are used by the guest to notify the completion of the SDEI
> event in the handler. The registers are changed according to the
> SDEI specification as below:
> 
>    * x0 - x17, PC and PState are restored to what values we had in
>      the interrupted context.
> 
>    * If it's SDEI_EVENT_COMPLETE_AND_RESUME hypercall, IRQ exception
>      is injected.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  arch/arm64/include/asm/kvm_emulate.h |  1 +
>  arch/arm64/include/asm/kvm_host.h    |  1 +
>  arch/arm64/kvm/hyp/exception.c       |  7 +++
>  arch/arm64/kvm/inject_fault.c        | 27 ++++++++++
>  arch/arm64/kvm/sdei.c                | 75 ++++++++++++++++++++++++++++
>  5 files changed, 111 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
> index fd418955e31e..923b4d08ea9a 100644
> --- a/arch/arm64/include/asm/kvm_emulate.h
> +++ b/arch/arm64/include/asm/kvm_emulate.h
> @@ -37,6 +37,7 @@ bool kvm_condition_valid32(const struct kvm_vcpu *vcpu);
>  void kvm_skip_instr32(struct kvm_vcpu *vcpu);
>  
>  void kvm_inject_undefined(struct kvm_vcpu *vcpu);
> +void kvm_inject_irq(struct kvm_vcpu *vcpu);
>  void kvm_inject_vabt(struct kvm_vcpu *vcpu);
>  void kvm_inject_dabt(struct kvm_vcpu *vcpu, unsigned long addr);
>  void kvm_inject_pabt(struct kvm_vcpu *vcpu, unsigned long addr);
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index 46f363aa6524..1824f7e1f9ab 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -437,6 +437,7 @@ struct kvm_vcpu_arch {
>  #define KVM_ARM64_EXCEPT_AA32_UND	(0 << 9)
>  #define KVM_ARM64_EXCEPT_AA32_IABT	(1 << 9)
>  #define KVM_ARM64_EXCEPT_AA32_DABT	(2 << 9)
> +#define KVM_ARM64_EXCEPT_AA32_IRQ	(3 << 9)
>  /* For AArch64: */
>  #define KVM_ARM64_EXCEPT_AA64_ELx_SYNC	(0 << 9)
>  #define KVM_ARM64_EXCEPT_AA64_ELx_IRQ	(1 << 9)
> diff --git a/arch/arm64/kvm/hyp/exception.c b/arch/arm64/kvm/hyp/exception.c
> index 0418399e0a20..ef458207d152 100644
> --- a/arch/arm64/kvm/hyp/exception.c
> +++ b/arch/arm64/kvm/hyp/exception.c
> @@ -310,6 +310,9 @@ static void kvm_inject_exception(struct kvm_vcpu *vcpu)
>  		case KVM_ARM64_EXCEPT_AA32_DABT:
>  			enter_exception32(vcpu, PSR_AA32_MODE_ABT, 16);
>  			break;
> +		case KVM_ARM64_EXCEPT_AA32_IRQ:
> +			enter_exception32(vcpu, PSR_AA32_MODE_IRQ, 4);
> +			break;
>  		default:
>  			/* Err... */
>  			break;
> @@ -320,6 +323,10 @@ static void kvm_inject_exception(struct kvm_vcpu *vcpu)
>  		      KVM_ARM64_EXCEPT_AA64_EL1):
>  			enter_exception64(vcpu, PSR_MODE_EL1h, except_type_sync);
>  			break;
> +		case (KVM_ARM64_EXCEPT_AA64_ELx_IRQ |
> +		      KVM_ARM64_EXCEPT_AA64_EL1):
> +			enter_exception64(vcpu, PSR_MODE_EL1h, except_type_irq);
> +			break;
>  		default:
>  			/*
>  			 * Only EL1_SYNC makes sense so far, EL2_{SYNC,IRQ}
> diff --git a/arch/arm64/kvm/inject_fault.c b/arch/arm64/kvm/inject_fault.c
> index b47df73e98d7..3a8c55867d2f 100644
> --- a/arch/arm64/kvm/inject_fault.c
> +++ b/arch/arm64/kvm/inject_fault.c
> @@ -66,6 +66,13 @@ static void inject_undef64(struct kvm_vcpu *vcpu)
>  	vcpu_write_sys_reg(vcpu, esr, ESR_EL1);
>  }
>  
> +static void inject_irq64(struct kvm_vcpu *vcpu)
> +{
> +	vcpu->arch.flags |= (KVM_ARM64_EXCEPT_AA64_EL1     |
> +			     KVM_ARM64_EXCEPT_AA64_ELx_IRQ |
> +			     KVM_ARM64_PENDING_EXCEPTION);
> +}
> +
>  #define DFSR_FSC_EXTABT_LPAE	0x10
>  #define DFSR_FSC_EXTABT_nLPAE	0x08
>  #define DFSR_LPAE		BIT(9)
> @@ -77,6 +84,12 @@ static void inject_undef32(struct kvm_vcpu *vcpu)
>  			     KVM_ARM64_PENDING_EXCEPTION);
>  }
>  
> +static void inject_irq32(struct kvm_vcpu *vcpu)
> +{
> +	vcpu->arch.flags |= (KVM_ARM64_EXCEPT_AA32_IRQ |
> +			     KVM_ARM64_PENDING_EXCEPTION);
> +}
> +
>  /*
>   * Modelled after TakeDataAbortException() and TakePrefetchAbortException
>   * pseudocode.
> @@ -160,6 +173,20 @@ void kvm_inject_undefined(struct kvm_vcpu *vcpu)
>  		inject_undef64(vcpu);
>  }
>  
> +/**
> + * kvm_inject_irq - inject an IRQ into the guest
> + *
> + * It is assumed that this code is called from the VCPU thread and that the
> + * VCPU therefore is not currently executing guest code.
> + */
> +void kvm_inject_irq(struct kvm_vcpu *vcpu)
> +{
> +	if (vcpu_el1_is_32bit(vcpu))
> +		inject_irq32(vcpu);
> +	else
> +		inject_irq64(vcpu);
> +}
> +
>  void kvm_set_sei_esr(struct kvm_vcpu *vcpu, u64 esr)
>  {
>  	vcpu_set_vsesr(vcpu, esr & ESR_ELx_ISS_MASK);
> diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
> index b5d6d1ed3858..1e8e213c9d70 100644
> --- a/arch/arm64/kvm/sdei.c
> +++ b/arch/arm64/kvm/sdei.c
> @@ -308,6 +308,75 @@ static unsigned long kvm_sdei_hypercall_context(struct kvm_vcpu *vcpu)
>  	return ret;
>  }
>  
> +static unsigned long kvm_sdei_hypercall_complete(struct kvm_vcpu *vcpu,
> +						 bool resume)
> +{
> +	struct kvm *kvm = vcpu->kvm;
> +	struct kvm_sdei_kvm *ksdei = kvm->arch.sdei;
> +	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
> +	struct kvm_sdei_kvm_event *kske = NULL;
> +	struct kvm_sdei_vcpu_event *ksve = NULL;
> +	struct kvm_sdei_vcpu_regs *regs;
> +	unsigned long ret = SDEI_SUCCESS;
for the RESUME you never seem to read resume_addr arg? How does it work?
I don't get the irq injection path. Please could you explain?
> +	int index;
> +
> +	/* Sanity check */
> +	if (!(ksdei && vsdei)) {
> +		ret = SDEI_NOT_SUPPORTED;
> +		goto out;
> +	}
> +
> +	spin_lock(&vsdei->lock);
> +	if (vsdei->critical_event) {
> +		ksve = vsdei->critical_event;
> +		regs = &vsdei->state.critical_regs;
> +		vsdei->critical_event = NULL;
> +		vsdei->state.critical_num = KVM_SDEI_INVALID_NUM;
> +	} else if (vsdei->normal_event) {
> +		ksve = vsdei->normal_event;
> +		regs = &vsdei->state.normal_regs;
> +		vsdei->normal_event = NULL;
> +		vsdei->state.normal_num = KVM_SDEI_INVALID_NUM;
> +	} else {
> +		ret = SDEI_DENIED;
> +		goto unlock;
> +	}
> +
> +	/* Restore registers: x0 -> x17, PC, PState */
> +	for (index = 0; index < ARRAY_SIZE(regs->regs); index++)
> +		vcpu_set_reg(vcpu, index, regs->regs[index]);
> +
> +	*vcpu_cpsr(vcpu) = regs->pstate;
> +	*vcpu_pc(vcpu) = regs->pc;
> +
> +	/* Inject interrupt if needed */
> +	if (resume)
> +		kvm_inject_irq(vcpu);
> +
> +	/*
> +	 * Update state. We needn't take lock in order to update the KVM
> +	 * event state as it's not destroyed because of the reference
> +	 * count.
> +	 */
> +	kske = ksve->kske;
> +	ksve->state.refcount--;
> +	kske->state.refcount--;
why double --?
> +	if (!ksve->state.refcount) {
why not using a struct kref directly?
> +		list_del(&ksve->link);
> +		kfree(ksve);
> +	}
> +
> +	/* Make another request if there is pending event */
> +	if (!(list_empty(&vsdei->critical_events) &&
> +	      list_empty(&vsdei->normal_events)))
> +		kvm_make_request(KVM_REQ_SDEI, vcpu);
> +
> +unlock:
> +	spin_unlock(&vsdei->lock);
> +out:
> +	return ret;
> +}
> +
>  static unsigned long kvm_sdei_hypercall_unregister(struct kvm_vcpu *vcpu)
>  {
>  	struct kvm *kvm = vcpu->kvm;
> @@ -628,7 +697,13 @@ int kvm_sdei_hypercall(struct kvm_vcpu *vcpu)
>  		ret = kvm_sdei_hypercall_context(vcpu);
>  		break;
>  	case SDEI_1_0_FN_SDEI_EVENT_COMPLETE:
> +		has_result = false;
> +		ret = kvm_sdei_hypercall_complete(vcpu, false);
> +		break;
>  	case SDEI_1_0_FN_SDEI_EVENT_COMPLETE_AND_RESUME:
> +		has_result = false;
> +		ret = kvm_sdei_hypercall_complete(vcpu, true);
> +		break;
>  	case SDEI_1_0_FN_SDEI_EVENT_UNREGISTER:
>  		ret = kvm_sdei_hypercall_unregister(vcpu);
>  		break;
> 
Eric

