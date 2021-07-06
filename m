Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE0B3BD864
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 16:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbhGFOjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 10:39:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31357 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232502AbhGFOji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 10:39:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625582219;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ViCBW+aU4HmX1q30hpE32yx0uxbzc7hky1uZJpH6cmY=;
        b=AVxUU2lv+y8FYUZ075wcmJ5BInYwPqzEqtaYJvtHVn9WHJTnhJE8OqyEGsjvhBcVb5gmIV
        pUcMygNKSlM/B8nd4ncORCce37fuiVXiHpTdAyN5NGN4Sxl7KlbFunGRSj4isjJ8kM4a2A
        PqX/CEK5UXWSdS3lXk28CjAw8Djo72g=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-Gxo1twWfPEKJiXgAt0qSMA-1; Tue, 06 Jul 2021 10:36:56 -0400
X-MC-Unique: Gxo1twWfPEKJiXgAt0qSMA-1
Received: by mail-ej1-f72.google.com with SMTP id k1-20020a17090666c1b029041c273a883dso5904795ejp.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jul 2021 07:36:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ViCBW+aU4HmX1q30hpE32yx0uxbzc7hky1uZJpH6cmY=;
        b=FxeOK6euUePEWqCpNixPsTAu/jPpBds8sTuwI54UrMA7ywBrkDpOQmLzekkakZhtXH
         Kb8cqhrr7NjjlbTRD+5+vDi3HK18QkL7VXeKuy2KwhD++vGSmfrcGGU1WdRyZwrDnb1T
         TnGvwRbVtra29pplUsgiWUz3khL0xJ7mQi7BqA/cB07Gr/A7EA1cEGPiIYuMzy003C5c
         lR9CfMx1r93Bi6bkLgdZneAAqlJtM98UJtth4e5rJBTvGOzEhChgrWd6KeFR8YEVlgC0
         5EpA5wRT/eEHjeE889kpP5dte4xso7BYdyjBGcN7AuUp44Ly5PUNGEJBIHYU2EwFWZQe
         MEdw==
X-Gm-Message-State: AOAM532dOZw1vqe36n9AbsKDFaG5hdDwOUAlDEh3SixgmgJ+GYisF5gJ
        jsCOGZk7NdTXJX5nvh7/AG8goDL5AlkGjhZoL2Aalyp8x4/l4U8PYZLte7ujzeEeS2In9kikoEO
        IxbPzqYZ0jXyUQhmlpk78A/xw
X-Received: by 2002:a17:907:72c9:: with SMTP id du9mr4054659ejc.497.1625582215085;
        Tue, 06 Jul 2021 07:36:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyzSGNDTuDB2nTgFFg1Qz93NY7KXXLlEt7e7B/RxiR9gDpBYM1jY+L1YBkDn5cKQmZvz3QLMQ==
X-Received: by 2002:a17:907:72c9:: with SMTP id du9mr4054632ejc.497.1625582214843;
        Tue, 06 Jul 2021 07:36:54 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id op26sm5117107ejb.57.2021.07.06.07.36.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jul 2021 07:36:54 -0700 (PDT)
Subject: Re: [RFC PATCH v2 36/69] KVM: x86: Add a switch_db_regs flag to
 handle TDX's auto-switched behavior
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
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Chao Gao <chao.gao@intel.com>
References: <cover.1625186503.git.isaku.yamahata@intel.com>
 <1f79ce2ad686f25767711ccd6a520324dd6e1c21.1625186503.git.isaku.yamahata@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8fd6118a-6804-4a58-138f-0c78855cc32a@redhat.com>
Date:   Tue, 6 Jul 2021 16:36:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1f79ce2ad686f25767711ccd6a520324dd6e1c21.1625186503.git.isaku.yamahata@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/07/21 00:04, isaku.yamahata@intel.com wrote:
> From: Sean Christopherson <sean.j.christopherson@intel.com>
> 
> Add a flag, KVM_DEBUGREG_AUTO_SWITCHED_GUEST, to skip saving/restoring DRs
> irrespective of any other flags.  TDX-SEAM unconditionally saves and
> restores guest DRs and reset to architectural INIT state on TD exit.
> So, KVM needs to save host DRs before TD enter without restoring guest DRs
> and restore host DRs after TD exit.
> 
> Opportunistically convert the KVM_DEBUGREG_* definitions to use BIT().
> 
> Reported-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Co-developed-by: Chao Gao <chao.gao@intel.com>
> Signed-off-by: Chao Gao <chao.gao@intel.com>
> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> ---
>   arch/x86/include/asm/kvm_host.h | 11 ++++++++---
>   arch/x86/kvm/x86.c              |  3 ++-
>   2 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 96e6cd95d884..7822b531a5e2 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -488,9 +488,14 @@ struct kvm_pmu {
>   struct kvm_pmu_ops;
>   
>   enum {
> -	KVM_DEBUGREG_BP_ENABLED = 1,
> -	KVM_DEBUGREG_WONT_EXIT = 2,
> -	KVM_DEBUGREG_RELOAD = 4,
> +	KVM_DEBUGREG_BP_ENABLED		= BIT(0),
> +	KVM_DEBUGREG_WONT_EXIT		= BIT(1),
> +	KVM_DEBUGREG_RELOAD		= BIT(2),
> +	/*
> +	 * Guest debug registers are saved/restored by hardware on exit from
> +	 * or enter guest. KVM needn't switch them.
> +	 */
> +	KVM_DEBUGREG_AUTO_SWITCH_GUEST	= BIT(3),

Maybe remove "_GUEST"?  Apart from that,

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

Paolo

>   };
>   
>   struct kvm_mtrr_range {
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 4b436cae1732..f1d5e0a53640 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -9441,7 +9441,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
>   	if (test_thread_flag(TIF_NEED_FPU_LOAD))
>   		switch_fpu_return();
>   
> -	if (unlikely(vcpu->arch.switch_db_regs)) {
> +	if (unlikely(vcpu->arch.switch_db_regs & ~KVM_DEBUGREG_AUTO_SWITCH_GUEST)) {
>   		set_debugreg(0, 7);
>   		set_debugreg(vcpu->arch.eff_db[0], 0);
>   		set_debugreg(vcpu->arch.eff_db[1], 1);
> @@ -9473,6 +9473,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
>   	 */
>   	if (unlikely(vcpu->arch.switch_db_regs & KVM_DEBUGREG_WONT_EXIT)) {
>   		WARN_ON(vcpu->guest_debug & KVM_GUESTDBG_USE_HW_BP);
> +		WARN_ON(vcpu->arch.switch_db_regs & KVM_DEBUGREG_AUTO_SWITCH_GUEST);
>   		static_call(kvm_x86_sync_dirty_debug_regs)(vcpu);
>   		kvm_update_dr0123(vcpu);
>   		kvm_update_dr7(vcpu);
> 

