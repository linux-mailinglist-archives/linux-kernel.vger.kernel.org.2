Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2EB932D01C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 10:53:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237993AbhCDJwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 04:52:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32908 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237843AbhCDJvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 04:51:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614851415;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uylkGuKA1QvnEOMM2uLHXNkUqdOnowekW+lRTSaD2mY=;
        b=absLI6bf9SfKdo3RIsZTPVQ9fZIxWhV8vN8rnC3+MmjdDO0VJqA5FV6kn2WzQN9FPE+Gb5
        6CHfqf2l+avv/dOWk+sFMjxBSysCVaR+YDTKyTONbPFiPsOn0463lzu+6rYD+UKaZ8PK/I
        m6CR0xkarUXfMF0LgHo9lwlIo0fsces=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221-zqfZQ3jXP_GE1jLOmywo4g-1; Thu, 04 Mar 2021 04:50:13 -0500
X-MC-Unique: zqfZQ3jXP_GE1jLOmywo4g-1
Received: by mail-ej1-f71.google.com with SMTP id r26so6358682eja.22
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 01:50:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=uylkGuKA1QvnEOMM2uLHXNkUqdOnowekW+lRTSaD2mY=;
        b=oDIeDh1+5g8U0mx0kCcgiA3CkQiR5ao9YeYHZ3letNePHvhuA8KiXw42MmWxA0wLZa
         ruizIiR1HN3fC/vPTIbl0chGfIDtM8b9ndrLRbJ+b78q3sVgDO2z0gpo+KdzZvIyg5x4
         sgonWRddxp4UMalVPI/WBSyLqG2xHOdefgVLdm+Z8BMXiqDgcHi8UoaKpCJhxtGJYxig
         7IPvFz0gAL8polat8Bz4kMGsm87vD0a2UW+Fibhajv6WIExjide5UVjxABUEu2ibzv4t
         pme9l9ZVShvk63QuXdKmpUjLTcXmZ6iG4b9L81zHZAlAnfsCHZwk8eGKYP6dBkqYZJrc
         s5vw==
X-Gm-Message-State: AOAM532NG5lNnR0igmx2fckjiSmVdEkl0krKVkDFY6PvIR9V9/Ya5L+y
        Z41vhoLluCpWVKv9pNBYe1CQjRStYnRClWMJPgySbMdsHj+Wl2M7Xcn4vtRvtBbydOkKCbRBTsA
        j8snzhdXNPA6S+sbAl9uUFPkAIw70MF6ZtcnVygXFAYIqj/qOtpoNRF6orAg1Txa/Z+3m1FNB8V
        94
X-Received: by 2002:a17:906:12db:: with SMTP id l27mr3221571ejb.500.1614851412324;
        Thu, 04 Mar 2021 01:50:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzujsuOWwrj8tpClxPDBcVEpxWrvBUd+CkRq1WJICydmv3lTZrtBjJJnDKrio/zc5v49Uj+8A==
X-Received: by 2002:a17:906:12db:: with SMTP id l27mr3221555ejb.500.1614851412049;
        Thu, 04 Mar 2021 01:50:12 -0800 (PST)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id pg2sm10031493ejb.49.2021.03.04.01.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 01:50:11 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Yang Weijiang <weijiang.yang@intel.com>
Cc:     pbonzini@redhat.com, seanjc@google.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] KVM: nVMX: Sync L2 guest CET states between L1/L2
In-Reply-To: <20210304060740.11339-2-weijiang.yang@intel.com>
References: <20210304060740.11339-1-weijiang.yang@intel.com>
 <20210304060740.11339-2-weijiang.yang@intel.com>
Date:   Thu, 04 Mar 2021 10:50:10 +0100
Message-ID: <87k0qnckod.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yang Weijiang <weijiang.yang@intel.com> writes:

> These fields are rarely updated by L1 QEMU/KVM, sync them when L1 is trying to
> read/write them and after they're changed. If CET guest entry-load bit is not
> set by L1 guest, migrate them to L2 manaully.
>
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> ---
>  arch/x86/kvm/cpuid.c      |  1 -
>  arch/x86/kvm/vmx/nested.c | 30 ++++++++++++++++++++++++++++++
>  arch/x86/kvm/vmx/vmx.h    |  3 +++
>  3 files changed, 33 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index d191de769093..8692f53b8cd0 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -143,7 +143,6 @@ void kvm_update_cpuid_runtime(struct kvm_vcpu *vcpu)
>  		}
>  		vcpu->arch.guest_supported_xss =
>  			(((u64)best->edx << 32) | best->ecx) & supported_xss;
> -

Nitpick: stray change?

>  	} else {
>  		vcpu->arch.guest_supported_xss = 0;
>  	}
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index 9728efd529a1..24cace55e1f9 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -2516,6 +2516,13 @@ static void prepare_vmcs02_rare(struct vcpu_vmx *vmx, struct vmcs12 *vmcs12)
>  	vmcs_write32(VM_ENTRY_MSR_LOAD_COUNT, vmx->msr_autoload.guest.nr);
>  
>  	set_cr4_guest_host_mask(vmx);
> +
> +	if (kvm_cet_supported() && vmx->nested.nested_run_pending &&
> +	    (vmcs12->vm_entry_controls & VM_ENTRY_LOAD_CET_STATE)) {
> +		vmcs_writel(GUEST_SSP, vmcs12->guest_ssp);
> +		vmcs_writel(GUEST_S_CET, vmcs12->guest_s_cet);
> +		vmcs_writel(GUEST_INTR_SSP_TABLE, vmcs12->guest_ssp_tbl);
> +	}
>  }
>  
>  /*
> @@ -2556,6 +2563,15 @@ static int prepare_vmcs02(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
>  	if (kvm_mpx_supported() && (!vmx->nested.nested_run_pending ||
>  	    !(vmcs12->vm_entry_controls & VM_ENTRY_LOAD_BNDCFGS)))
>  		vmcs_write64(GUEST_BNDCFGS, vmx->nested.vmcs01_guest_bndcfgs);
> +
> +	if (kvm_cet_supported() && (!vmx->nested.nested_run_pending ||
> +	    !(vmcs12->vm_entry_controls & VM_ENTRY_LOAD_CET_STATE))) {
> +		vmcs_writel(GUEST_SSP, vmx->nested.vmcs01_guest_ssp);
> +		vmcs_writel(GUEST_S_CET, vmx->nested.vmcs01_guest_s_cet);
> +		vmcs_writel(GUEST_INTR_SSP_TABLE,
> +			    vmx->nested.vmcs01_guest_ssp_tbl);
> +	}
> +
>  	vmx_set_rflags(vcpu, vmcs12->guest_rflags);
>  
>  	/* EXCEPTION_BITMAP and CR0_GUEST_HOST_MASK should basically be the
> @@ -3375,6 +3391,12 @@ enum nvmx_vmentry_status nested_vmx_enter_non_root_mode(struct kvm_vcpu *vcpu,
>  	if (kvm_mpx_supported() &&
>  		!(vmcs12->vm_entry_controls & VM_ENTRY_LOAD_BNDCFGS))
>  		vmx->nested.vmcs01_guest_bndcfgs = vmcs_read64(GUEST_BNDCFGS);
> +	if (kvm_cet_supported() &&
> +		!(vmcs12->vm_entry_controls & VM_ENTRY_LOAD_CET_STATE)) {
> +		vmx->nested.vmcs01_guest_ssp = vmcs_readl(GUEST_SSP);
> +		vmx->nested.vmcs01_guest_s_cet = vmcs_readl(GUEST_S_CET);
> +		vmx->nested.vmcs01_guest_ssp_tbl = vmcs_readl(GUEST_INTR_SSP_TABLE);
> +	}
>  
>  	/*
>  	 * Overwrite vmcs01.GUEST_CR3 with L1's CR3 if EPT is disabled *and*
> @@ -4001,6 +4023,9 @@ static bool is_vmcs12_ext_field(unsigned long field)
>  	case GUEST_IDTR_BASE:
>  	case GUEST_PENDING_DBG_EXCEPTIONS:
>  	case GUEST_BNDCFGS:
> +	case GUEST_SSP:
> +	case GUEST_INTR_SSP_TABLE:
> +	case GUEST_S_CET:
>  		return true;
>  	default:
>  		break;
> @@ -4052,6 +4077,11 @@ static void sync_vmcs02_to_vmcs12_rare(struct kvm_vcpu *vcpu,
>  		vmcs_readl(GUEST_PENDING_DBG_EXCEPTIONS);
>  	if (kvm_mpx_supported())
>  		vmcs12->guest_bndcfgs = vmcs_read64(GUEST_BNDCFGS);
> +	if (kvm_cet_supported()) {
> +		vmcs12->guest_ssp = vmcs_readl(GUEST_SSP);
> +		vmcs12->guest_s_cet = vmcs_readl(GUEST_S_CET);
> +		vmcs12->guest_ssp_tbl = vmcs_readl(GUEST_INTR_SSP_TABLE);
> +	}
>  
>  	vmx->nested.need_sync_vmcs02_to_vmcs12_rare = false;
>  }
> diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
> index 9d3a557949ac..36dc4fdb0909 100644
> --- a/arch/x86/kvm/vmx/vmx.h
> +++ b/arch/x86/kvm/vmx/vmx.h
> @@ -155,6 +155,9 @@ struct nested_vmx {
>  	/* to migrate it to L2 if VM_ENTRY_LOAD_DEBUG_CONTROLS is off */
>  	u64 vmcs01_debugctl;
>  	u64 vmcs01_guest_bndcfgs;
> +	u64 vmcs01_guest_ssp;
> +	u64 vmcs01_guest_s_cet;
> +	u64 vmcs01_guest_ssp_tbl;
>  
>  	/* to migrate it to L1 if L2 writes to L1's CR8 directly */
>  	int l1_tpr_threshold;

-- 
Vitaly

