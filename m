Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC0E5361C9C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 11:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240718AbhDPI67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 04:58:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51025 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240606AbhDPI66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 04:58:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618563514;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VGbphinr7QGpBlr6jS+8V/guPiVoCFlwGjQeMKWxcak=;
        b=Sl7J01a0VkDBn+pS06DfuPksyh7O30RbFZiQ5gCXsahalKvNUSWqACT4nNXYDm01Y2Bm1L
        rLWGqiJxOOPuGfuepK35pdw/o8hEJhCG+/ktA5rQFtzGNnWt1edFBmLnuTvavLdD+cCD54
        jFtPXwHmlmO2JzX9lyKOKJDItLpgw0U=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-535-LNzMUJmoNPSPF_NckgPm-A-1; Fri, 16 Apr 2021 04:58:30 -0400
X-MC-Unique: LNzMUJmoNPSPF_NckgPm-A-1
Received: by mail-ed1-f71.google.com with SMTP id bm19-20020a0564020b13b02903789d6e74b5so6598784edb.21
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 01:58:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=VGbphinr7QGpBlr6jS+8V/guPiVoCFlwGjQeMKWxcak=;
        b=lBBFtYCcJ9nbiP5V5xAy8leUJt7H9qkd8goBiw7fgRLwzuT1Oha0g0x4rifuz/prgd
         dFNQvCUlHcIdk5zZl3uWq7b5JJL6NGIQzmYfXIBS+Dv5VlqWUE4L2SW0fw+gwMN4Hg4N
         upZj3i5F9aKJzsy1XLN5oPp8PO+F++W5Z6ghllGyfdwXEr6P+eSwivI7txSN2fwEpkBo
         wNtq8ubhdfOkpMGCJBbYZ+8Jwne6rz7JNQAsq8MBBDrRJ6mPNwymQ7REJYJgoORP5gqV
         OKPeZs4OUWQRoiXoWJ53LGhgGLAhLeG8SGS7xcXKKOKdAqT5QhPnlQYo8J96+unkOL+Y
         0mQg==
X-Gm-Message-State: AOAM530DCRuoYnBaBHJYcdLfasbpvKhuym8+G3H/2yN5PdSgEU9rGyp4
        HEymJMrLLp+rKixIGQhnqmcWqlIEqGMTNluvlfpUP5uvRW16Jz3HEyw3BSkLzIG/85yRTQPNc2T
        SAfduYmUT3Vb5N8aQ55N3mPxz
X-Received: by 2002:aa7:d5c2:: with SMTP id d2mr273456eds.86.1618563508953;
        Fri, 16 Apr 2021 01:58:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzjiqn9I5OvZMPc5KW8faZAfQMovxLeR9R57FItNkdjYqynJ0C6SgYtrEX1nPDYBiqHYP3BAw==
X-Received: by 2002:aa7:d5c2:: with SMTP id d2mr273435eds.86.1618563508795;
        Fri, 16 Apr 2021 01:58:28 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id gt26sm3849163ejb.31.2021.04.16.01.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 01:58:28 -0700 (PDT)
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
Subject: Re: [PATCH v2 4/7] KVM: SVM: hyper-v: Nested enlightenments in VMCB
In-Reply-To: <ffe0e81164e5577a43f7499e40922b6abb663430.1618492553.git.viremana@linux.microsoft.com>
References: <cover.1618492553.git.viremana@linux.microsoft.com>
 <ffe0e81164e5577a43f7499e40922b6abb663430.1618492553.git.viremana@linux.microsoft.com>
Date:   Fri, 16 Apr 2021 10:58:27 +0200
Message-ID: <87v98m7gi4.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vineeth Pillai <viremana@linux.microsoft.com> writes:

> Add Hyper-V specific fields in VMCB to support SVM enlightenments.
> Also a small refactoring of VMCB clean bits handling.
>
> Signed-off-by: Vineeth Pillai <viremana@linux.microsoft.com>
> ---
>  arch/x86/include/asm/svm.h | 24 +++++++++++++++++++++++-
>  arch/x86/kvm/svm/svm.c     |  8 ++++++++
>  arch/x86/kvm/svm/svm.h     | 30 ++++++++++++++++++++++++++++--
>  3 files changed, 59 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
> index 1c561945b426..3586d7523ce8 100644
> --- a/arch/x86/include/asm/svm.h
> +++ b/arch/x86/include/asm/svm.h
> @@ -322,9 +322,31 @@ static inline void __unused_size_checks(void)
>  	BUILD_BUG_ON(sizeof(struct ghcb)		!= EXPECTED_GHCB_SIZE);
>  }
>  
> +
> +#if IS_ENABLED(CONFIG_HYPERV)
> +struct __packed hv_enlightenments {
> +	struct __packed hv_enlightenments_control {
> +		u32 nested_flush_hypercall:1;
> +		u32 msr_bitmap:1;
> +		u32 enlightened_npt_tlb: 1;
> +		u32 reserved:29;
> +	} hv_enlightenments_control;
> +	u32 hv_vp_id;
> +	u64 hv_vm_id;
> +	u64 partition_assist_page;
> +	u64 reserved;
> +};

Enlightened VMCS seems to have the same part:

        struct {
                u32 nested_flush_hypercall:1;
                u32 msr_bitmap:1;
                u32 reserved:30;
        }  __packed hv_enlightenments_control;
        u32 hv_vp_id;
        u64 hv_vm_id;
        u64 partition_assist_page;

Would it maybe make sense to unify these two (in case they are the same
thing in Hyper-V, of course)?


> +#define VMCB_CONTROL_END	992	// 32 bytes for Hyper-V
> +#else
> +#define VMCB_CONTROL_END	1024
> +#endif
> +
>  struct vmcb {
>  	struct vmcb_control_area control;
> -	u8 reserved_control[1024 - sizeof(struct vmcb_control_area)];
> +	u8 reserved_control[VMCB_CONTROL_END - sizeof(struct vmcb_control_area)];
> +#if IS_ENABLED(CONFIG_HYPERV)
> +	struct hv_enlightenments hv_enlightenments;
> +#endif
>  	struct vmcb_save_area save;
>  } __packed;
>  
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index baee91c1e936..2ad1f55c88d0 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -31,6 +31,7 @@
>  #include <asm/tlbflush.h>
>  #include <asm/desc.h>
>  #include <asm/debugreg.h>
> +#include <asm/hypervisor.h>
>  #include <asm/kvm_para.h>
>  #include <asm/irq_remapping.h>
>  #include <asm/spec-ctrl.h>
> @@ -122,6 +123,8 @@ bool npt_enabled = true;
>  bool npt_enabled;
>  #endif
>  
> +u32 __read_mostly vmcb_all_clean_mask = VMCB_ALL_CLEAN_MASK;
> +
>  /*
>   * These 2 parameters are used to config the controls for Pause-Loop Exiting:
>   * pause_filter_count: On processors that support Pause filtering(indicated
> @@ -1051,6 +1054,11 @@ static __init int svm_hardware_setup(void)
>  	 */
>  	allow_smaller_maxphyaddr = !npt_enabled;
>  
> +#if IS_ENABLED(CONFIG_HYPERV)
> +	if (hypervisor_is_type(X86_HYPER_MS_HYPERV))
> +		vmcb_all_clean_mask |= VMCB_HYPERV_CLEAN_MASK;
> +#endif
> +
>  	return 0;
>  
>  err:
> diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
> index 39e071fdab0c..63ed05c8027b 100644
> --- a/arch/x86/kvm/svm/svm.h
> +++ b/arch/x86/kvm/svm/svm.h
> @@ -33,6 +33,11 @@ static const u32 host_save_user_msrs[] = {
>  extern u32 msrpm_offsets[MSRPM_OFFSETS] __read_mostly;
>  extern bool npt_enabled;
>  
> +/*
> + * Clean bits in VMCB.
> + * VMCB_ALL_CLEAN_MASK and VMCB_HYPERV_CLEAN_MASK might
> + * also need to be updated if this enum is modified.
> + */
>  enum {
>  	VMCB_INTERCEPTS, /* Intercept vectors, TSC offset,
>  			    pause filter count */
> @@ -50,12 +55,28 @@ enum {
>  			  * AVIC PHYSICAL_TABLE pointer,
>  			  * AVIC LOGICAL_TABLE pointer
>  			  */
> -	VMCB_DIRTY_MAX,
> +#if IS_ENABLED(CONFIG_HYPERV)
> +	VMCB_HV_NESTED_ENLIGHTENMENTS = 31,
> +#endif
>  };
>  
> +#define VMCB_ALL_CLEAN_MASK (					\
> +	(1U << VMCB_INTERCEPTS) | (1U << VMCB_PERM_MAP) |	\
> +	(1U << VMCB_ASID) | (1U << VMCB_INTR) |			\
> +	(1U << VMCB_NPT) | (1U << VMCB_CR) | (1U << VMCB_DR) |	\
> +	(1U << VMCB_DT) | (1U << VMCB_SEG) | (1U << VMCB_CR2) |	\
> +	(1U << VMCB_LBR) | (1U << VMCB_AVIC)			\
> +	)

What if we preserve VMCB_DIRTY_MAX and drop this newly introduced
VMCB_ALL_CLEAN_MASK (which basically lists all the members of the enum
above)? '1 << VMCB_DIRTY_MAX' can still work. (If the 'VMCB_DIRTY_MAX'
name becomes misleading we can e.g. rename it to VMCB_NATIVE_DIRTY_MAX
or something but I'm not sure it's worth it)

> +
> +#if IS_ENABLED(CONFIG_HYPERV)
> +#define VMCB_HYPERV_CLEAN_MASK (1U << VMCB_HV_NESTED_ENLIGHTENMENTS)
> +#endif

VMCB_HYPERV_CLEAN_MASK is a single bit, why do we need it at all
(BIT(VMCB_HV_NESTED_ENLIGHTENMENTS) is not super long)

> +
>  /* TPR and CR2 are always written before VMRUN */
>  #define VMCB_ALWAYS_DIRTY_MASK	((1U << VMCB_INTR) | (1U << VMCB_CR2))
>  
> +extern u32 vmcb_all_clean_mask __read_mostly;
> +
>  struct kvm_sev_info {
>  	bool active;		/* SEV enabled guest */
>  	bool es_active;		/* SEV-ES enabled guest */
> @@ -230,7 +251,7 @@ static inline void vmcb_mark_all_dirty(struct vmcb *vmcb)
>  
>  static inline void vmcb_mark_all_clean(struct vmcb *vmcb)
>  {
> -	vmcb->control.clean = ((1 << VMCB_DIRTY_MAX) - 1)
> +	vmcb->control.clean = vmcb_all_clean_mask
>  			       & ~VMCB_ALWAYS_DIRTY_MASK;
>  }
>  
> @@ -239,6 +260,11 @@ static inline void vmcb_mark_dirty(struct vmcb *vmcb, int bit)
>  	vmcb->control.clean &= ~(1 << bit);
>  }
>  
> +static inline bool vmcb_is_clean(struct vmcb *vmcb, int bit)
> +{
> +	return (vmcb->control.clean & (1 << bit));
> +}
> +
>  static inline struct vcpu_svm *to_svm(struct kvm_vcpu *vcpu)
>  {
>  	return container_of(vcpu, struct vcpu_svm, vcpu);

-- 
Vitaly

