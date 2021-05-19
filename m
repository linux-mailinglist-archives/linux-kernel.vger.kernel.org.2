Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBED938838B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 02:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244168AbhESAJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 20:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233688AbhESAJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 20:09:20 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C792C06175F
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 17:08:01 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id gb21-20020a17090b0615b029015d1a863a91so2510990pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 17:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AvMPVw0tg5Dj6coxQ9DiblbWWNkeUP+FuTEACH0pmmE=;
        b=X6Jdzqp7soe6JpB+RYT10AVUzXA5SlKvXRdGCd9/Z1X1D5TRamVRfK1C3mBi4yVGTJ
         tyA6W9NNnzOR16JmphyK+GUYskg44Fz6qeLfS6tv3xIfWk7PLKIrknhyxIVu+sgNgz84
         GUzDjwKTNSN6vGYXClxgMaCVMFOqzH1ZfDPTJfDLUmLl/CTsZ5gVcUlX+9rRuITembQ3
         3x8VldsMd2XLXhv20MVP+gb3x365rniF7SK4YgeiCB+QSljDztRBrjAGKKoJ+9NOzY1l
         y5YuCjC85E2nMNFY5RxC34lyDvLY+m+KPJ1EU14m3f8txvr6TnVzzg7Iaetm0VEpkrB7
         tljQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AvMPVw0tg5Dj6coxQ9DiblbWWNkeUP+FuTEACH0pmmE=;
        b=n0ikDrpwDYKthHd7lRy/3t07vy8rmaj0zRH/YD+U1a8WaBb0+e1ETzIIPcEVQ/ek0z
         INQFwknkYqPcl86HS1ZdrovNlkpCJSEj5aQ8r2DCdGqxQIEmgclAaZMETinbPZ7Eo0wi
         tKqA1eGCBq9tWYZV3/Le8UsbgzypDyhLaNHwlUz4REMJuVJSdKQ5xdy2S5jqQVS4AJyR
         12HSaK9WnLnL2wTRvEGI8Z3jEmralWxDbVm/QXS75fv91aDR54XG0ov0/4QX1Gs26x0B
         WKCf2qqra86rMoe8peWYuzDwr6noFVUqfliFhcELpw2xu+vVAdeCDy15uw/1gYsoECfG
         8G0g==
X-Gm-Message-State: AOAM530ct0mjedrb3v1uXcL2HRCqySU42KsMl8Wnyiaui+ZwvvxPDM36
        PWCSSGm2pr7JFQhEEipOxgOilg==
X-Google-Smtp-Source: ABdhPJyLsR01tQg11ggiMn8P8sQKtnWQ0lI1kVVOSQW3GOWH3n0+8jbZrbcKq9iwy4KTUfJK9ymVmA==
X-Received: by 2002:a17:90b:1a92:: with SMTP id ng18mr8271086pjb.213.1621382881017;
        Tue, 18 May 2021 17:08:01 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id d7sm2547470pfa.40.2021.05.18.17.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 17:08:00 -0700 (PDT)
Date:   Wed, 19 May 2021 00:07:56 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Ilias Stamatis <ilstam@amazon.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, mlevitsk@redhat.com, vkuznets@redhat.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
        zamsden@gmail.com, mtosatti@redhat.com, dwmw@amazon.co.uk
Subject: Re: [PATCH v2 08/10] KVM: VMX: Set the TSC offset and multiplier on
 nested entry and exit
Message-ID: <YKRW3EF5NHBlJEOn@google.com>
References: <20210512150945.4591-1-ilstam@amazon.com>
 <20210512150945.4591-9-ilstam@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210512150945.4591-9-ilstam@amazon.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12, 2021, Ilias Stamatis wrote:
> Now that nested TSC scaling is supported we need to calculate the
> correct 02 values for both the offset and the multiplier using the
> corresponding functions. On L2's exit the L1 values are restored.
> 
> Signed-off-by: Ilias Stamatis <ilstam@amazon.com>
> ---
>  arch/x86/kvm/vmx/nested.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index 6058a65a6ede..f1dff1ebaccb 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -3354,8 +3354,9 @@ enum nvmx_vmentry_status nested_vmx_enter_non_root_mode(struct kvm_vcpu *vcpu,
>  	}
>  
>  	enter_guest_mode(vcpu);
> -	if (vmcs12->cpu_based_vm_exec_control & CPU_BASED_USE_TSC_OFFSETTING)
> -		vcpu->arch.tsc_offset += vmcs12->tsc_offset;
> +
> +	kvm_set_02_tsc_offset(vcpu);
> +	kvm_set_02_tsc_multiplier(vcpu);

Please move this code into prepare_vmcs02() to co-locate it with the relevant
vmcs02 logic.  If there's something in prepare_vmcs02() that consumes
vcpu->arch.tsc_offset() other than the obvious VMWRITE, I vote to move things
around to fix that rather than create this weird split.

>  	if (prepare_vmcs02(vcpu, vmcs12, &entry_failure_code)) {
>  		exit_reason.basic = EXIT_REASON_INVALID_STATE;
> @@ -4463,8 +4464,12 @@ void nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 vm_exit_reason,
>  	if (nested_cpu_has_preemption_timer(vmcs12))
>  		hrtimer_cancel(&to_vmx(vcpu)->nested.preemption_timer);
>  
> -	if (vmcs12->cpu_based_vm_exec_control & CPU_BASED_USE_TSC_OFFSETTING)
> -		vcpu->arch.tsc_offset -= vmcs12->tsc_offset;
> +	if (vmcs12->cpu_based_vm_exec_control & CPU_BASED_USE_TSC_OFFSETTING) {
> +		vcpu->arch.tsc_offset = vcpu->arch.l1_tsc_offset;
> +
> +		if (vmcs12->secondary_vm_exec_control & SECONDARY_EXEC_TSC_SCALING)
> +			vcpu->arch.tsc_scaling_ratio = vcpu->arch.l1_tsc_scaling_ratio;
> +	}
>  
>  	if (likely(!vmx->fail)) {
>  		sync_vmcs02_to_vmcs12(vcpu, vmcs12);
> -- 
> 2.17.1
> 
