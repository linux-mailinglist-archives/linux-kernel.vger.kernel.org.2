Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7943DE986
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 11:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234760AbhHCJLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 05:11:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22889 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234953AbhHCJLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 05:11:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627981889;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ww50rpTfPMrsM3ZfYnQ4Y42+A1dc/QCaNs+ZKmOYvIA=;
        b=ORJEnGNIBddzTO6jkKyIqmHQxr5VvS1qbMSMemi5RgYEhPVQDnz5mvRU4KWZ7mH9mRF8a/
        rPCFiqFhflgTF32wcHIQ2wMhVq/dvJKnom6DnSWXdPdhi2GktlPgMDLM8q//tqcrntrIXc
        vK9Chau3KiGyLU8KlhdZvg3V27DEmAY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-zNdrefB6NXiDMJxFJYGySw-1; Tue, 03 Aug 2021 05:11:27 -0400
X-MC-Unique: zNdrefB6NXiDMJxFJYGySw-1
Received: by mail-wm1-f72.google.com with SMTP id o67-20020a1ca5460000b0290223be6fd23dso3707565wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 02:11:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ww50rpTfPMrsM3ZfYnQ4Y42+A1dc/QCaNs+ZKmOYvIA=;
        b=qev5vhjxqZSPSR/01gtLjJ72QyGLa8k8MUvJ4yAkJ6bq9syt3VX56VTJhoKRhschyN
         iCQmOh4rmBSYWuOyQimnM0P3EcGwJuu7kZAnAF7XJWCtcN0apZgsZ9mC6vdSIUu2VlGI
         ICCBhqXkoUs3QiYFs8z9gMc271CNFvNzUYrpvJQpLKmijXExuQMy+LT08clDwHGZsgu6
         sg2E3ArucPGRxYiJA5I9SRXYN3+/zzTHKerWQw50UzYrhVILWFXIZ+UWPGdu3orojJLg
         fZbFY9S8HPfBQXDabwmHHn903vdITydaP9cyKq1jw5iYeBfQNJ8tH/U4jx2Gk9/KndIK
         p5Ow==
X-Gm-Message-State: AOAM531Pyo0Rx/5ywCO/1mjRfoxvtNcNGlNWRmFH67TDabTfKdpwh3N0
        RN1sh/SJ2nUn9+62k1Ft0rCA9JEkwyZlULWI7rywuiUmSPj7OX4bZUOi30w0g9LfguRI8zDH+dt
        T13FiRgeal8QuM5PfFLlDjiqi
X-Received: by 2002:a05:600c:2197:: with SMTP id e23mr10912995wme.22.1627981886075;
        Tue, 03 Aug 2021 02:11:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJztPFH5Lkm0hhgNrUOpi1iGz0Drv3yTGk+xokv0DuvP1XpPvbr8Tj1zpQt/S0dBsjL31q24MA==
X-Received: by 2002:a05:600c:2197:: with SMTP id e23mr10912977wme.22.1627981885891;
        Tue, 03 Aug 2021 02:11:25 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id t16sm4409501wmi.13.2021.08.03.02.11.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Aug 2021 02:11:25 -0700 (PDT)
Subject: Re: [PATCH v3 10/12] KVM: SVM: remove svm_toggle_avic_for_irq_window
To:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@alien8.de>,
        Sean Christopherson <seanjc@google.com>,
        Jim Mattson <jmattson@google.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20210802183329.2309921-1-mlevitsk@redhat.com>
 <20210802183329.2309921-11-mlevitsk@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7b4442b6-644d-6fcb-1147-2aa220b2c8c8@redhat.com>
Date:   Tue, 3 Aug 2021 11:11:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210802183329.2309921-11-mlevitsk@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/08/21 20:33, Maxim Levitsky wrote:
> Now that kvm_request_apicv_update doesn't need to drop the kvm->srcu lock,
> we can call kvm_request_apicv_update directly.
> 
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>   arch/x86/kvm/svm/avic.c | 11 -----------
>   arch/x86/kvm/svm/svm.c  |  4 ++--
>   arch/x86/kvm/svm/svm.h  |  1 -
>   3 files changed, 2 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
> index d0acbeeab3d6..1def54c26259 100644
> --- a/arch/x86/kvm/svm/avic.c
> +++ b/arch/x86/kvm/svm/avic.c
> @@ -582,17 +582,6 @@ void avic_post_state_restore(struct kvm_vcpu *vcpu)
>   	avic_handle_ldr_update(vcpu);
>   }
>   
> -void svm_toggle_avic_for_irq_window(struct kvm_vcpu *vcpu, bool activate)
> -{
> -	if (!enable_apicv || !lapic_in_kernel(vcpu))
> -		return;
> -
> -	srcu_read_unlock(&vcpu->kvm->srcu, vcpu->srcu_idx);
> -	kvm_request_apicv_update(vcpu->kvm, activate,
> -				 APICV_INHIBIT_REASON_IRQWIN);
> -	vcpu->srcu_idx = srcu_read_lock(&vcpu->kvm->srcu);
> -}
> -
>   void svm_set_virtual_apic_mode(struct kvm_vcpu *vcpu)
>   {
>   	return;
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 3923d383face..c8827de49c75 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -2994,7 +2994,7 @@ static int interrupt_window_interception(struct kvm_vcpu *vcpu)
>   	 * In this case AVIC was temporarily disabled for
>   	 * requesting the IRQ window and we have to re-enable it.
>   	 */
> -	svm_toggle_avic_for_irq_window(vcpu, true);
> +	kvm_request_apicv_update(vcpu->kvm, true, APICV_INHIBIT_REASON_IRQWIN);
>   
>   	++vcpu->stat.irq_window_exits;
>   	return 1;
> @@ -3546,7 +3546,7 @@ static void svm_enable_irq_window(struct kvm_vcpu *vcpu)
>   		 * via AVIC. In such case, we need to temporarily disable AVIC,
>   		 * and fallback to injecting IRQ via V_IRQ.
>   		 */
> -		svm_toggle_avic_for_irq_window(vcpu, false);
> +		kvm_request_apicv_update(vcpu->kvm, false, APICV_INHIBIT_REASON_IRQWIN);
>   		svm_set_vintr(svm);
>   	}
>   }
> diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
> index bd41f2a32838..aae851762b59 100644
> --- a/arch/x86/kvm/svm/svm.h
> +++ b/arch/x86/kvm/svm/svm.h
> @@ -524,7 +524,6 @@ int avic_ga_log_notifier(u32 ga_tag);
>   void avic_vm_destroy(struct kvm *kvm);
>   int avic_vm_init(struct kvm *kvm);
>   void avic_init_vmcb(struct vcpu_svm *svm);
> -void svm_toggle_avic_for_irq_window(struct kvm_vcpu *vcpu, bool activate);
>   int avic_incomplete_ipi_interception(struct kvm_vcpu *vcpu);
>   int avic_unaccelerated_access_interception(struct kvm_vcpu *vcpu);
>   int avic_init_vcpu(struct vcpu_svm *svm);
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

