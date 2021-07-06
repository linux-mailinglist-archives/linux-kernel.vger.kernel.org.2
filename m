Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7B9A3BD859
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 16:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbhGFOh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 10:37:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27540 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232261AbhGFOhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 10:37:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625582114;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SadklWu5h42Kr+n17qV7by5TT0XeZa9ds78ScI/5JFI=;
        b=jT9eCeOi/WTmkOgz+PWPyMjhng9yuKRMmzj02wW7crx/zp9fem5DJW4CoiDbBDcpg23o68
        bE3/iNIhvppuBiTbUx0g2Lam8Rps9bJnZDZTbHbD8XK9oV4zoBDK79o2agRZgS/XvoOPdq
        FRV16H0m7ZfjktpFexIPpHrWEY6ucdw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-482-rcHx6rF0NCmZyc8pJPm5QQ-1; Tue, 06 Jul 2021 10:35:13 -0400
X-MC-Unique: rcHx6rF0NCmZyc8pJPm5QQ-1
Received: by mail-ed1-f70.google.com with SMTP id p19-20020aa7c4d30000b0290394bdda6d9cso10849092edr.21
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jul 2021 07:35:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SadklWu5h42Kr+n17qV7by5TT0XeZa9ds78ScI/5JFI=;
        b=L5hDHp7XBZ+WFbpI29ntcQOqkHY5Nx7xLJSB/4lMwuZsiDCYvD43gziucb3Stkp2jA
         QzK5YkPf9kBdtm3/0LzeMwbLnUjdIz4taQ7ZToU0DSDDpOQVvjX61/LQYkzjKlu8Pakv
         LauWuNfnTBT/n0FfDLDFy7goPA/9iYMey95DqIxpHkYuzE2z/+Z3Q/PusaZS5gWfTvZO
         qsnhsSjK1qZ6bektShbhhmmr1sK30ddh8G/KIkgU+XUksAuVGy+jm5viNZgCmXevpBqp
         9jL7A9FxTvsn1XcygQiZjThqsFQt1LwTMbW4SVysfs8Qv+r5+jqv4l6PAdJiL4YrAXx4
         f7Tg==
X-Gm-Message-State: AOAM530Jagd+4ILnWbpRgvCKYMFkyVg4mp8+Qp1pqRaVdE9+yVyZnwQ8
        Mjw0wuleZJNuZ+IH63inuhrV4JIvw5n4MwDY5Kt4zbYLlr1QFIfaHAeR20xdAX6N4nBeywgygGt
        xYt/10K1WGvcHV7nNOekIz9LS
X-Received: by 2002:a17:906:7b4f:: with SMTP id n15mr18484076ejo.42.1625582111850;
        Tue, 06 Jul 2021 07:35:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyX/hN6grD9bMUghxfplyXRvID/QOIo0cYh5JzubHTBO/PXsUDzoj4n1GCTZJLcwlRuSvxCcQ==
X-Received: by 2002:a17:906:7b4f:: with SMTP id n15mr18484049ejo.42.1625582111659;
        Tue, 06 Jul 2021 07:35:11 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id d18sm1023485ejr.50.2021.07.06.07.35.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jul 2021 07:35:11 -0700 (PDT)
Subject: Re: [RFC PATCH v2 38/69] KVM: x86: Add option to force LAPIC
 expiration wait
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
        Sean Christopherson <sean.j.christopherson@intel.com>
References: <cover.1625186503.git.isaku.yamahata@intel.com>
 <357378fcb6e3e2becb6d4f00a5c3d2b00b2c566b.1625186503.git.isaku.yamahata@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a349d5bf-b85c-34c3-bb88-523df23a2985@redhat.com>
Date:   Tue, 6 Jul 2021 16:35:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <357378fcb6e3e2becb6d4f00a5c3d2b00b2c566b.1625186503.git.isaku.yamahata@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/07/21 00:04, isaku.yamahata@intel.com wrote:
> From: Sean Christopherson <sean.j.christopherson@intel.com>
> 
> Add an option to skip the IRR check in kvm_wait_lapic_expire().  This
> will be used by TDX to wait if there is an outstanding notification for
> a TD, i.e. a virtual interrupt is being triggered via posted interrupt
> processing.  KVM TDX doesn't emulate PI processing, i.e. there will
> never be a bit set in IRR/ISR, so the default behavior for APICv of
> querying the IRR doesn't work as intended.
> 
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>

Is there a better (existing after the previous patches) flag to test, or 
possibly can it use vm_type following the suggestion I gave for patch 28?

Paolo

> ---
>   arch/x86/kvm/lapic.c   | 4 ++--
>   arch/x86/kvm/lapic.h   | 2 +-
>   arch/x86/kvm/svm/svm.c | 2 +-
>   arch/x86/kvm/vmx/vmx.c | 2 +-
>   4 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index 977a704e3ff1..3cfc0485a46e 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -1622,12 +1622,12 @@ static void __kvm_wait_lapic_expire(struct kvm_vcpu *vcpu)
>   		__wait_lapic_expire(vcpu, tsc_deadline - guest_tsc);
>   }
>   
> -void kvm_wait_lapic_expire(struct kvm_vcpu *vcpu)
> +void kvm_wait_lapic_expire(struct kvm_vcpu *vcpu, bool force_wait)
>   {
>   	if (lapic_in_kernel(vcpu) &&
>   	    vcpu->arch.apic->lapic_timer.expired_tscdeadline &&
>   	    vcpu->arch.apic->lapic_timer.timer_advance_ns &&
> -	    lapic_timer_int_injected(vcpu))
> +	    (force_wait || lapic_timer_int_injected(vcpu)))
>   		__kvm_wait_lapic_expire(vcpu);
>   }
>   EXPORT_SYMBOL_GPL(kvm_wait_lapic_expire);
> diff --git a/arch/x86/kvm/lapic.h b/arch/x86/kvm/lapic.h
> index 997c45a5963a..2bd32d86ad6f 100644
> --- a/arch/x86/kvm/lapic.h
> +++ b/arch/x86/kvm/lapic.h
> @@ -233,7 +233,7 @@ static inline int kvm_lapic_latched_init(struct kvm_vcpu *vcpu)
>   
>   bool kvm_apic_pending_eoi(struct kvm_vcpu *vcpu, int vector);
>   
> -void kvm_wait_lapic_expire(struct kvm_vcpu *vcpu);
> +void kvm_wait_lapic_expire(struct kvm_vcpu *vcpu, bool force_wait);
>   
>   void kvm_bitmap_or_dest_vcpus(struct kvm *kvm, struct kvm_lapic_irq *irq,
>   			      unsigned long *vcpu_bitmap);
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index bcc3fc4872a3..b12bfdbc394b 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -3774,7 +3774,7 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu)
>   	clgi();
>   	kvm_load_guest_xsave_state(vcpu);
>   
> -	kvm_wait_lapic_expire(vcpu);
> +	kvm_wait_lapic_expire(vcpu, false);
>   
>   	/*
>   	 * If this vCPU has touched SPEC_CTRL, restore the guest's value if
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 36756a356704..7ce15a2c3490 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -6727,7 +6727,7 @@ static fastpath_t vmx_vcpu_run(struct kvm_vcpu *vcpu)
>   	if (enable_preemption_timer)
>   		vmx_update_hv_timer(vcpu);
>   
> -	kvm_wait_lapic_expire(vcpu);
> +	kvm_wait_lapic_expire(vcpu, false);
>   
>   	/*
>   	 * If this vCPU has touched SPEC_CTRL, restore the guest's value if
> 

