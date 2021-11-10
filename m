Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44C1B44BF56
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 11:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbhKJLBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 06:01:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:36491 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229653AbhKJLBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 06:01:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636541942;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rud4BOhI3/FnheVPSiISCtxclKyfCyexZ+PhymJnR1M=;
        b=N0ZtTkxTrMp18MISIJPQXfjFr897VY9VXmbOtnHBIhF4Mba0BGQA9nQqOLBWuQHfL6XyzE
        1eJH51OHd8wAL3mcGH35qKWYw6JP+XQr05GpSMgkf2EGyjj2ucGzA59MsVD2lnDOoe5JGm
        qXRyxUAJ3EHIgGm+0H3pAjBdxtE9ioI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-KYyy1FjVPlWjuyiSWmQlKA-1; Wed, 10 Nov 2021 05:59:01 -0500
X-MC-Unique: KYyy1FjVPlWjuyiSWmQlKA-1
Received: by mail-wr1-f70.google.com with SMTP id p17-20020adff211000000b0017b902a7701so341930wro.19
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 02:59:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Rud4BOhI3/FnheVPSiISCtxclKyfCyexZ+PhymJnR1M=;
        b=pj1fJxXi3AzjKdK/CDo/Hoy7Dp0U7Nk40r5hQxsZdXXfxQEU83TRWpjpuokME/s526
         z2++KnnRd11bA9jPXjgZJj73ypx8A7izqzFQszMvqi9SpQO6FX2RBU4c2GcbmYQivjF5
         4Sz4rmh2CQP/DcSBqPw5sQacwUmumI6lSVPgHZUN3c3Z+XN6Db7RJS5cJk6jLKrjjHyL
         p3XEDkHIpH4mjKqCde5vDXQ5eb9Sf8XJtrNYz3I9swBBfwLFLnrNdR+RAfV17q/rxMDs
         viRXoedVOkAuXIZ5hb/0x1g0BRHE2B1bD8wFVGYdZToy663HqnfHgKXkE/vJclsU3Ufy
         xtBA==
X-Gm-Message-State: AOAM533l9idfFNL8pdZXwWeRrS72Hw5Zcf15XxmF8qTjR4BDKGJAk9G+
        GySqLVdfX9XZSaat7rnvcNd0k655LW6VFE33NWllNFtD+BzStuVo8Mo1JimwkMmMUaBUgUA2BE6
        V8Pv1oUAegn8Mb7FFzZpYT5m7
X-Received: by 2002:a5d:424c:: with SMTP id s12mr18029616wrr.370.1636541940140;
        Wed, 10 Nov 2021 02:59:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwfdYIAv7B9E9ylltgHIyhCaUoqaBWjTAG5jF5bdx5t8xS8Q1D/9qoWSPwt+wfcivG8Ym+ZfA==
X-Received: by 2002:a5d:424c:: with SMTP id s12mr18029591wrr.370.1636541939935;
        Wed, 10 Nov 2021 02:58:59 -0800 (PST)
Received: from ?IPv6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id l5sm5484924wms.16.2021.11.10.02.58.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Nov 2021 02:58:59 -0800 (PST)
From:   Eric Auger <eauger@redhat.com>
Subject: Re: [PATCH v4 13/21] KVM: arm64: Impment SDEI event delivery
To:     Gavin Shan <gshan@redhat.com>, kvmarm@lists.cs.columbia.edu
Cc:     maz@kernel.org, linux-kernel@vger.kernel.org,
        Jonathan.Cameron@huawei.com, pbonzini@redhat.com, will@kernel.org
References: <20210815001352.81927-1-gshan@redhat.com>
 <20210815001352.81927-14-gshan@redhat.com>
Message-ID: <74c5f170-fb08-56a7-ff87-9a51ecfda989@redhat.com>
Date:   Wed, 10 Nov 2021 11:58:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210815001352.81927-14-gshan@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/Impment/Implement in the commit title

On 8/15/21 2:13 AM, Gavin Shan wrote:
> This implement kvm_sdei_deliver() to support SDEI event delivery.
> The function is called when the request (KVM_REQ_SDEI) is raised.
> The following rules are taken according to the SDEI specification:
> 
>    * x0 - x17 are saved. All of them are cleared except the following
>      registered:
s/registered/registers
>      x0: number SDEI event to be delivered
s/number SDEI event/SDEI event number
>      x1: parameter associated with the SDEI event
user arg?
>      x2: PC of the interrupted context
>      x3: PState of the interrupted context
> 
>    * PC is set to the handler of the SDEI event, which was provided
>      during its registration. PState is modified accordingly.
> 
>    * SDEI event with critical priority can preempt those with normal
>      priority.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  arch/arm64/include/asm/kvm_host.h |  1 +
>  arch/arm64/include/asm/kvm_sdei.h |  1 +
>  arch/arm64/kvm/arm.c              |  3 ++
>  arch/arm64/kvm/sdei.c             | 84 +++++++++++++++++++++++++++++++
>  4 files changed, 89 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index aedf901e1ec7..46f363aa6524 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -47,6 +47,7 @@
>  #define KVM_REQ_RECORD_STEAL	KVM_ARCH_REQ(3)
>  #define KVM_REQ_RELOAD_GICv4	KVM_ARCH_REQ(4)
>  #define KVM_REQ_RELOAD_PMU	KVM_ARCH_REQ(5)
> +#define KVM_REQ_SDEI		KVM_ARCH_REQ(6)
>  
>  #define KVM_DIRTY_LOG_MANUAL_CAPS   (KVM_DIRTY_LOG_MANUAL_PROTECT_ENABLE | \
>  				     KVM_DIRTY_LOG_INITIALLY_SET)
> diff --git a/arch/arm64/include/asm/kvm_sdei.h b/arch/arm64/include/asm/kvm_sdei.h
> index b0abc13a0256..7f5f5ad689e6 100644
> --- a/arch/arm64/include/asm/kvm_sdei.h
> +++ b/arch/arm64/include/asm/kvm_sdei.h
> @@ -112,6 +112,7 @@ KVM_SDEI_FLAG_FUNC(enabled)
>  void kvm_sdei_init_vm(struct kvm *kvm);
>  void kvm_sdei_create_vcpu(struct kvm_vcpu *vcpu);
>  int kvm_sdei_hypercall(struct kvm_vcpu *vcpu);
> +void kvm_sdei_deliver(struct kvm_vcpu *vcpu);
>  void kvm_sdei_destroy_vcpu(struct kvm_vcpu *vcpu);
>  void kvm_sdei_destroy_vm(struct kvm *kvm);
>  
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index 2f021aa41632..0c3db1ef1ba9 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -689,6 +689,9 @@ static void check_vcpu_requests(struct kvm_vcpu *vcpu)
>  		if (kvm_check_request(KVM_REQ_VCPU_RESET, vcpu))
>  			kvm_reset_vcpu(vcpu);
>  
> +		if (kvm_check_request(KVM_REQ_SDEI, vcpu))
> +			kvm_sdei_deliver(vcpu);
> +
>  		/*
>  		 * Clear IRQ_PENDING requests that were made to guarantee
>  		 * that a VCPU sees new virtual interrupts.
> diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
> index 62efee2b67b8..b5d6d1ed3858 100644
> --- a/arch/arm64/kvm/sdei.c
> +++ b/arch/arm64/kvm/sdei.c
> @@ -671,6 +671,90 @@ int kvm_sdei_hypercall(struct kvm_vcpu *vcpu)
>  	return 1;
>  }
>  
> +void kvm_sdei_deliver(struct kvm_vcpu *vcpu)
> +{
> +	struct kvm *kvm = vcpu->kvm;
> +	struct kvm_sdei_kvm *ksdei = kvm->arch.sdei;
> +	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
> +	struct kvm_sdei_event *kse = NULL;
> +	struct kvm_sdei_kvm_event *kske = NULL;
> +	struct kvm_sdei_vcpu_event *ksve = NULL;
> +	struct kvm_sdei_vcpu_regs *regs = NULL;
> +	unsigned long pstate;
> +	int index = 0;
> +
> +	/* Sanity check */
> +	if (!(ksdei && vsdei))
> +		return;
> +
> +	/* The critical event can't be preempted */
move the comment after the spin_lock
> +	spin_lock(&vsdei->lock);
> +	if (vsdei->critical_event)
> +		goto unlock;
> +
> +	/*
> +	 * The normal event can be preempted by the critical event.
> +	 * However, the normal event can't be preempted by another
> +	 * normal event.
> +	 */
> +	ksve = list_first_entry_or_null(&vsdei->critical_events,
> +			struct kvm_sdei_vcpu_event, link);
> +	if (!ksve && !vsdei->normal_event) {
> +		ksve = list_first_entry_or_null(&vsdei->normal_events,
> +				struct kvm_sdei_vcpu_event, link);
> +	}
At this stage of the review the struct kvm_sdei_vcpu_event lifecycle is
not known.

From the dispatcher pseudocode I understand you check

((IsCriticalEvent(E) and !CriticalEventRunning(P, C)) ||
(!IsCriticalEvent(E) and !EventRunning(P, C)))

but I can't check you take care of
IsEnabled(E) and
IsEventTarget(E, P)
IsUnmasked(P)

Either you should shash with 18/21 or at least you should add comments.
> +
> +	if (!ksve)
> +		goto unlock;
> +
> +	kske = ksve->kske;
> +	kse = kske->kse;
> +	if (kse->state.priority == SDEI_EVENT_PRIORITY_CRITICAL) {
> +		vsdei->critical_event = ksve;
> +		vsdei->state.critical_num = ksve->state.num;
> +		regs = &vsdei->state.critical_regs;
> +	} else {
> +		vsdei->normal_event = ksve;
> +		vsdei->state.normal_num = ksve->state.num;
> +		regs = &vsdei->state.normal_regs;
> +	}
> +
> +	/* Save registers: x0 -> x17, PC, PState */
> +	for (index = 0; index < ARRAY_SIZE(regs->regs); index++)
> +		regs->regs[index] = vcpu_get_reg(vcpu, index);
> +
> +	regs->pc = *vcpu_pc(vcpu);
> +	regs->pstate = *vcpu_cpsr(vcpu);
> +
> +	/*
> +	 * Inject SDEI event: x0 -> x3, PC, PState. We needn't take lock
> +	 * for the KVM event as it can't be destroyed because of its
> +	 * reference count.
> +	 */
> +	for (index = 0; index < ARRAY_SIZE(regs->regs); index++)
> +		vcpu_set_reg(vcpu, index, 0);
> +
> +	index = (kse->state.type == SDEI_EVENT_TYPE_PRIVATE) ?
> +		vcpu->vcpu_idx : 0;
> +	vcpu_set_reg(vcpu, 0, kske->state.num);
> +	vcpu_set_reg(vcpu, 1, kske->state.params[index]);
> +	vcpu_set_reg(vcpu, 2, regs->pc);
> +	vcpu_set_reg(vcpu, 3, regs->pstate);
> +
> +	pstate = regs->pstate;
> +	pstate |= (PSR_D_BIT | PSR_A_BIT | PSR_I_BIT | PSR_F_BIT);
> +	pstate &= ~PSR_MODE_MASK;
> +	pstate |= PSR_MODE_EL1h;
> +	pstate &= ~PSR_MODE32_BIT;
> +
> +	vcpu_write_sys_reg(vcpu, regs->pstate, SPSR_EL1);
> +	*vcpu_cpsr(vcpu) = pstate;
> +	*vcpu_pc(vcpu) = kske->state.entries[index];
> +
> +unlock:
> +	spin_unlock(&vsdei->lock);
> +}
> +
>  void kvm_sdei_init_vm(struct kvm *kvm)
>  {
>  	struct kvm_sdei_kvm *ksdei;
> 
Eric

