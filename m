Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C068358187
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 13:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbhDHLS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 07:18:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42435 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229837AbhDHLS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 07:18:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617880725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e9GB1bc5nTqQLr5FYMM0BQdP1r5V4EAQj9pCagC3gNQ=;
        b=PgjstiXZfnBbU4HfR/jE/WE9fYCGwxh/6d7akB63rVE15gL976JACGPbl4auQR1JFRHymB
        15+SOcucafYpoJ0C2fyQ+BD/1d/4miSbQByNlSxoyBjoIPmWyG9+1HgM5+GwP3VZjjEEM3
        elbz1PWwKFa5FPMr4BrzRkR9A99rDgU=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-564-uPMY_ImAOsmoWYQqHf7RpQ-1; Thu, 08 Apr 2021 07:18:44 -0400
X-MC-Unique: uPMY_ImAOsmoWYQqHf7RpQ-1
Received: by mail-ed1-f69.google.com with SMTP id o24so855444edt.15
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 04:18:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=e9GB1bc5nTqQLr5FYMM0BQdP1r5V4EAQj9pCagC3gNQ=;
        b=EXFTeVYp/Oio7EzI9ppXcHwitI0aSHaEdlCLyGn4CLveNJAgWb5e9tJEvRQ0gC6vuB
         0tfGhOR8ppbgnhZk+28Am578wz7QDRTdHTGjCu7kVGCEVR8bM0QDZnvKkHdju+h7rV6t
         nLMdLzOAueViG5mc/hjYv8xG+zR6s4ue3IFIAP5PJQBDaqA0C19auCFDNWf9MBrTcEKb
         1Shez3njmT+BwF4cXrQ+GeiQpMUYbdinkKV5HyD+PIPxgHW40FfwBZl9S83ihkbDkGCw
         HkiZC9hQtviN1czfpBWOpefUpaoHVd4G4OZ6v94oHncnwmsQD3gctNt4pft6xCPHa6UA
         23Gw==
X-Gm-Message-State: AOAM533uan/muYi1JcTSqDtfG8W5j917MrswLtFcnWQC7MKO7jRYgfDW
        GlDKG44V3t8aiu3vD4aO41DdFcF0fWtFMMVpIhLCJIsu2ad6eypohBdG/f+GWHv2Y9VO/qpZS4n
        pzeCfLVSnxGCjE8/UtA9LlU2t
X-Received: by 2002:a05:6402:150e:: with SMTP id f14mr10706639edw.63.1617880723073;
        Thu, 08 Apr 2021 04:18:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzsUUZ1nZ1Do8rFMm9JgnlTS5QEF3UTCdI4T3dCkR0kugi4Hpfj+GAHSQ4R4P4ajljpcHw15w==
X-Received: by 2002:a05:6402:150e:: with SMTP id f14mr10706621edw.63.1617880722924;
        Thu, 08 Apr 2021 04:18:42 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id x4sm16717374edd.58.2021.04.08.04.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 04:18:42 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Vineeth Pillai <viremana@linux.microsoft.com>,
        Lan Tianyu <Tianyu.Lan@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, Wei Liu <wei.liu@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>
Cc:     Vineeth Pillai <viremana@linux.microsoft.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "K. Y. Srinivasan" <kys@microsoft.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 5/7] KVM: SVM: hyper-v: Remote TLB flush for SVM
In-Reply-To: <1c754fe1ad8ae797b4045903dab51ab45dd37755.1617804573.git.viremana@linux.microsoft.com>
References: <cover.1617804573.git.viremana@linux.microsoft.com>
 <1c754fe1ad8ae797b4045903dab51ab45dd37755.1617804573.git.viremana@linux.microsoft.com>
Date:   Thu, 08 Apr 2021 13:18:41 +0200
Message-ID: <87ft01ausu.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vineeth Pillai <viremana@linux.microsoft.com> writes:

> Enable remote TLB flush for SVM.
>
> Signed-off-by: Vineeth Pillai <viremana@linux.microsoft.com>
> ---
>  arch/x86/kvm/svm/svm.c | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index baee91c1e936..6287cab61f15 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -36,6 +36,7 @@
>  #include <asm/spec-ctrl.h>
>  #include <asm/cpu_device_id.h>
>  #include <asm/traps.h>
> +#include <asm/mshyperv.h>
>  
>  #include <asm/virtext.h>
>  #include "trace.h"
> @@ -43,6 +44,8 @@
>  #include "svm.h"
>  #include "svm_ops.h"
>  
> +#include "hyperv.h"
> +
>  #define __ex(x) __kvm_handle_fault_on_reboot(x)
>  
>  MODULE_AUTHOR("Qumranet");
> @@ -928,6 +931,8 @@ static __init void svm_set_cpu_caps(void)
>  		kvm_cpu_cap_set(X86_FEATURE_VIRT_SSBD);
>  }
>  
> +static struct kvm_x86_ops svm_x86_ops;
> +
>  static __init int svm_hardware_setup(void)
>  {
>  	int cpu;
> @@ -997,6 +1002,16 @@ static __init int svm_hardware_setup(void)
>  	kvm_configure_mmu(npt_enabled, get_max_npt_level(), PG_LEVEL_1G);
>  	pr_info("kvm: Nested Paging %sabled\n", npt_enabled ? "en" : "dis");
>  
> +#if IS_ENABLED(CONFIG_HYPERV)
> +	if (ms_hyperv.nested_features & HV_X64_NESTED_ENLIGHTENED_TLB
> +	    && npt_enabled) {
> +		pr_info("kvm: Hyper-V enlightened NPT TLB flush enabled\n");
> +		svm_x86_ops.tlb_remote_flush = kvm_hv_remote_flush_tlb;
> +		svm_x86_ops.tlb_remote_flush_with_range =
> +				kvm_hv_remote_flush_tlb_with_range;
> +	}
> +#endif
> +
>  	if (nrips) {
>  		if (!boot_cpu_has(X86_FEATURE_NRIPS))
>  			nrips = false;
> @@ -1112,6 +1127,21 @@ static void svm_check_invpcid(struct vcpu_svm *svm)
>  	}
>  }
>  
> +#if IS_ENABLED(CONFIG_HYPERV)
> +static void hv_init_vmcb(struct vmcb *vmcb)
> +{
> +	struct hv_enlightenments *hve = &vmcb->hv_enlightenments;
> +
> +	if (npt_enabled &&
> +	    ms_hyperv.nested_features & HV_X64_NESTED_ENLIGHTENED_TLB)
> +		hve->hv_enlightenments_control.enlightened_npt_tlb = 1;
> +}
> +#else
> +static inline void hv_init_vmcb(struct vmcb *vmcb)
> +{
> +}
> +#endif
> +
>  static void init_vmcb(struct vcpu_svm *svm)
>  {
>  	struct vmcb_control_area *control = &svm->vmcb->control;
> @@ -1274,6 +1304,8 @@ static void init_vmcb(struct vcpu_svm *svm)
>  		}
>  	}
>  
> +	hv_init_vmcb(svm->vmcb);
> +
>  	vmcb_mark_all_dirty(svm->vmcb);
>  
>  	enable_gif(svm);
> @@ -3967,6 +3999,9 @@ static void svm_load_mmu_pgd(struct kvm_vcpu *vcpu, unsigned long root,
>  		svm->vmcb->control.nested_cr3 = cr3;
>  		vmcb_mark_dirty(svm->vmcb, VMCB_NPT);
>  
> +		if (kvm_x86_ops.tlb_remote_flush)
> +			kvm_update_arch_tdp_pointer(vcpu->kvm, vcpu, cr3);
> +

VMX has "#if IS_ENABLED(CONFIG_HYPERV)" around this, should we add it
here too?

>  		/* Loading L2's CR3 is handled by enter_svm_guest_mode.  */
>  		if (!test_bit(VCPU_EXREG_CR3, (ulong *)&vcpu->arch.regs_avail))
>  			return;

-- 
Vitaly

