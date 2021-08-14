Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51F503EC125
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 09:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237345AbhHNHW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 03:22:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29931 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237275AbhHNHWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 03:22:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628925745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1TtSUDMLTyWrnaOTR2UJPOGTDs88Lu3pvS9ZFwMmYSo=;
        b=JELr58FcRMuQeDYfk+6ORCWiJhK53Ug73j3OvpxiAmK/WV6jerbDxq9ov0n3ymC+jCUniJ
        oyObYGWp+umchUEU2PIB85hMxLkBjX1zfxPTBHLfPbAuPubi7Ck9aFcTQPBzWTIH6t++A/
        XiW+4/EHCC92HPbCwz3OhcNREFfN6v0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-TM9ftO-XPUOiuzObTWLX2w-1; Sat, 14 Aug 2021 03:22:21 -0400
X-MC-Unique: TM9ftO-XPUOiuzObTWLX2w-1
Received: by mail-ed1-f69.google.com with SMTP id eg56-20020a05640228b8b02903be79801f9aso5940937edb.21
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 00:22:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1TtSUDMLTyWrnaOTR2UJPOGTDs88Lu3pvS9ZFwMmYSo=;
        b=JfgsAf3nl0MlanQS7Ng090Oias0DKtnkuptkEvuhtzhExQrPxJ9lJgV6ep23NdPnjR
         bXT4lOC3qlI5SlQVi0pLDggauJvdQoospU7pjM70pmo9T65sMHaYvkokOslKuolGxu3Z
         +VrXOQzblwDOYF5Y93jH8lOPKIIw2ThskIkXPZWa04rCCyFFOZVKPsUdeOCkx/Ph+qqo
         qXTr/bcz0ezlkXx5jx+uQ1uiE7khuVhDhesUYsOCKpHNXxd7yd1fDL7XLqd+XSS/AFup
         CttzjxVdt63XKlY32Av+zO4Lw4y/16uQJd2uIp062L20IWDS7f80+CX/mDVhUK1g9d4x
         vZOg==
X-Gm-Message-State: AOAM532mKi6YK7xXLqkrJB1HyFe4EiMzDSKBFoE18nE0QOTXgd8jY0XM
        PyzVGcpM9wbmS19rrhAUJoYf8j5ZtUy+OhMZ9QhrbsIES50O7gY/g9JWQgC7QRwwQSUSdGLMgT6
        4pcjQOsuJ99chE5+g9iZ6Sw+h
X-Received: by 2002:a05:6402:1d33:: with SMTP id dh19mr7880369edb.10.1628925740649;
        Sat, 14 Aug 2021 00:22:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzlMdYxdPuv4hxHiu5mdrKEcsJmNgUQPIOBIw33CfjXaNdkfdzNZcQUx/8sGWC1f+auRLo1Gw==
X-Received: by 2002:a05:6402:1d33:: with SMTP id dh19mr7880346edb.10.1628925740441;
        Sat, 14 Aug 2021 00:22:20 -0700 (PDT)
Received: from [192.168.10.118] ([93.56.169.140])
        by smtp.gmail.com with ESMTPSA id z4sm1412515edc.33.2021.08.14.00.22.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Aug 2021 00:22:19 -0700 (PDT)
To:     Hikaru Nishida <hikalium@chromium.org>,
        linux-kernel@vger.kernel.org, dme@dme.org, tglx@linutronix.de,
        mlevitsk@redhat.com
Cc:     suleiman@google.com, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        John Stultz <john.stultz@linaro.org>,
        Sean Christopherson <seanjc@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>, kvm@vger.kernel.org,
        x86@kernel.org
References: <20210806100710.2425336-1-hikalium@chromium.org>
 <20210806190607.v2.3.Ib0cb8ecae99f0ccd0e2814b310adba00b9e81d94@changeid>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [v2 PATCH 3/4] x86/kvm: Add host side support for virtual suspend
 time injection
Message-ID: <2ec642dd-dde6-bee6-3de3-0fa78d288995@redhat.com>
Date:   Sat, 14 Aug 2021 09:22:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210806190607.v2.3.Ib0cb8ecae99f0ccd0e2814b310adba00b9e81d94@changeid>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/08/21 12:07, Hikaru Nishida wrote:
> +#if defined(CONFIG_KVM_VIRT_SUSPEND_TIMING) || \
> +	defined(CONFIG_KVM_VIRT_SUSPEND_TIMING_GUEST)
> +#define VIRT_SUSPEND_TIMING_VECTOR	0xec
> +#endif

No need to use a new vector.  You can rename the existing 
MSR_KVM_ASYNC_PF_INT to MSR_KVM_HYPERVISOR_CALLBACK_INT or something 
like that, and add the code to sysvec_kvm_asyncpf_interrupt.

> +static void kvm_make_suspend_time_interrupt(struct kvm_vcpu *vcpu)
> +{
> +	kvm_queue_interrupt(vcpu, VIRT_SUSPEND_TIMING_VECTOR, false);
> +	kvm_make_request(KVM_REQ_EVENT, vcpu);
> +}

Use kvm_apic_set_irq which will inject the interrupt as soon as 
possible, so you do not even need to check 
kvm_vcpu_ready_for_interrupt_injection.

> +#ifdef CONFIG_KVM_VIRT_SUSPEND_TIMING
> +		if (kvm->suspend_injection_requested &&
> +			kvm_vcpu_ready_for_interrupt_injection(vcpu)) {
> +			kvm_write_suspend_time(kvm);
> +			kvm_make_suspend_time_interrupt(vcpu);
> +			kvm->suspend_injection_requested = false;
> +		}
> +#endif

Do not read variables in vcpu_run; There is KVM_REQ_* if you need to do 
work in the vCPU run loop.

> +	mutex_lock(&kvm_lock);
> +	list_for_each_entry(kvm, &vm_list, vm_list) {
> +		if (!(kvm->arch.msr_suspend_time & KVM_MSR_ENABLED))
> +			continue;
> +
> +		kvm_for_each_vcpu(i, vcpu, kvm)
> +			vcpu->arch.tsc_offset_adjustment -= adj;
> +
> +		/*
> +		 * Move the offset of kvm_clock here as if it is stopped
> +		 * during the suspension.
> +		 */
> +		kvm->arch.kvmclock_offset -= suspend_time_ns;
> +
> +		/* suspend_time is accumulated per VM. */
> +		kvm->suspend_time_ns += suspend_time_ns;
> +		kvm->suspend_injection_requested = true;
> +		/*
> +		 * This adjustment will be reflected to the struct provided
> +		 * from the guest via MSR_KVM_HOST_SUSPEND_TIME before
> +		 * the notification interrupt is injected.
> +		 */
> +	}
> +	mutex_unlock(&kvm_lock);
> +}

As pointed out by Thomas, this should be a work item.

Paolo

