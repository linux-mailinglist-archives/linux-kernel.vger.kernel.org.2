Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81B28367EAF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 12:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235755AbhDVKfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 06:35:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48393 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230270AbhDVKfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 06:35:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619087681;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pHa3hGYdY/NebgmfQ2FScrNOSdDh9EEW0ZZOOGb69Po=;
        b=cKvfvtvq8/TdwYV3dXTrhxVER3t/kXMDJmC8n0yqtnY2Z/fs9xc8KNdJgfO9Z/I1EDmPGk
        rm/SLu3/OaCkjc8yIUxVBG3gtTdnuMK+FiZp3jz0kgPidxHtsIhbdsBEM+mVAtF8Jw2DYn
        oLb6ZmIxjW0/F0qOk/vRwJ8IAFLBukc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-590-OrIFWAa9NtW01yhnXDmygQ-1; Thu, 22 Apr 2021 06:34:38 -0400
X-MC-Unique: OrIFWAa9NtW01yhnXDmygQ-1
Received: by mail-ej1-f72.google.com with SMTP id o25-20020a1709061d59b029037c94676df5so7049554ejh.7
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 03:34:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pHa3hGYdY/NebgmfQ2FScrNOSdDh9EEW0ZZOOGb69Po=;
        b=uLHkpyeACf4gDrG7hyM3zTuV8wEiX14ccV8OXFvgxZ1WGg0mzoej6CAeuZLpU16t5M
         o/+fmCfopCKgN7+6yF6JVBV2I78DVz60/dtXywPrk1fSvCU1XxyKZgAXXEQrDcel20ZW
         LMJ79mDHnyt8KhL4w4gSFpCjmD/3DFL4gDPqVcI0JVsEUWf5eTj3JqaH8es5dem5OoKP
         tsKwUQ6oOYdOo42AgkF2H4abUQyW74p0g6MIRogQR2C1koXZJO8bAGSHLwo3EqdZU6qi
         LbahK7+xLWoQyVy6Vo23I1Hy1wOri3i0SCY9LmAEoBaZsSeeQYC8RMEHpQUig9L/1U1n
         PVOA==
X-Gm-Message-State: AOAM533uHhtZ+yuUjsSJfgXl7w6SOm7OVkwtNuWDpuocouGyZVWopWnp
        72GLuFF9n9t6Ow/viYMFc83deGki+kL/eDq6WhIeoobb9cnRdp5p0N64k/gt8PPBfZVcVf2+Ruu
        C0bvCZLluy6Az3hIj0l93hzzj
X-Received: by 2002:a17:906:f8cd:: with SMTP id lh13mr2651226ejb.387.1619087676853;
        Thu, 22 Apr 2021 03:34:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzkWR85Sr2lbGoFYqFOR9uUIDIZO4dTU54VFc2EDX4XSQdcooksddMIxISQPqCXuy4N/bhivg==
X-Received: by 2002:a17:906:f8cd:: with SMTP id lh13mr2651207ejb.387.1619087676646;
        Thu, 22 Apr 2021 03:34:36 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id 16sm1642520ejw.0.2021.04.22.03.34.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Apr 2021 03:34:36 -0700 (PDT)
Subject: Re: [PATCH] KVM: X86: Fix always skip to boost kernel lock holder
 candidate for SEV-ES guests
To:     Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
References: <1619080459-30032-1-git-send-email-wanpengli@tencent.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a5dc4068-050e-b651-2e8a-8e90164694a6@redhat.com>
Date:   Thu, 22 Apr 2021 12:34:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <1619080459-30032-1-git-send-email-wanpengli@tencent.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/04/21 10:34, Wanpeng Li wrote:
> From: Wanpeng Li <wanpengli@tencent.com>
> 
> Commit f1c6366e3043 ("KVM: SVM: Add required changes to support intercepts under
> SEV-ES") prevents hypervisor accesses guest register state when the guest is
> running under SEV-ES. The initial value of vcpu->arch.guest_state_protected
> is false, it will not be updated in preemption notifiers after this commit which
> means that the kernel spinlock lock holder will always be skipped to boost. Let's
> fix it by always treating preempted is in the guest kernel mode, false positive
> is better than skip completely.
> 
> Fixes: f1c6366e3043 (KVM: SVM: Add required changes to support intercepts under SEV-ES)
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
>   arch/x86/kvm/x86.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index d696a9f..e52ca09 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -11151,6 +11151,9 @@ bool kvm_arch_dy_has_pending_interrupt(struct kvm_vcpu *vcpu)
>   
>   bool kvm_arch_vcpu_in_kernel(struct kvm_vcpu *vcpu)
>   {
> +	if (vcpu->arch.guest_state_protected)
> +		return true;
> +
>   	return vcpu->arch.preempted_in_kernel;
>   }
>   
> 

Queued, thanks.

Paolo

