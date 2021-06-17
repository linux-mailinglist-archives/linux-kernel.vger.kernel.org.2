Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB74C3ABBC2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 20:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232911AbhFQS24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 14:28:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37566 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231720AbhFQS22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 14:28:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623954379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XvRDiOu3L2aDPvixr4wW0PI+YISrBEUZXNM7z6Kd0Ug=;
        b=i03K+5E+3a7yAlrR8xc7sYkSTK6lPXRVS0l56Eyx+FPzJr5n1nZsDbMP4Yh9ZAb6vubO6I
        YgQmDBgeLO4Wz6U+cNavAPlhRlGe8cAs+H266J20XjUxYrvY5ENwksVaohFFUWaC3Fmg/L
        eHRKG6Ep8rKJj3+ZaBB0OLytPmKlAug=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-XsrQFFbYON2R5xXLsdEpWA-1; Thu, 17 Jun 2021 14:26:18 -0400
X-MC-Unique: XsrQFFbYON2R5xXLsdEpWA-1
Received: by mail-ej1-f71.google.com with SMTP id br12-20020a170906d14cb02904311c0f32adso2784281ejb.9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 11:26:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XvRDiOu3L2aDPvixr4wW0PI+YISrBEUZXNM7z6Kd0Ug=;
        b=mL1mfuFQo3Wlb6BcehvE8UuDcCvLp8lf4yrAwvt8v9idGTA0yQZZf4TzFsYRrxs93x
         ue9yGZbGQHxuArs6f2FN/DMzPT155Ox3P2ePEAeKJh89onlGdEQEu28k3/hC+5o1II5j
         D2yfT3WpCVLHuJfcmYiJItJzp5xhPNLCrHJ/g9MP/38MpNFcj9XU/xWlR6O5T5jo7HwP
         zEKZsKmU3X17rx0JrIry3QN1O1mpAu+ysKoPN7nIVpBEjpZ3vnVCSIxhegzpNPwTj5A5
         9lb5uwRlR7Xon+06bYIqomCP3FFKmuB3/SEL9v4jX/QZyuVEGxote8/9fpjVquaa6lJ8
         uJEQ==
X-Gm-Message-State: AOAM530ioZ7Dd1VPEueYovpgjbLNBskgKGNOOWhUYd1Njd2TWY2iwwRg
        U0R8bhQTvz6Q12zl5M0nZKqF35sdLH6yT63nd/UrbQqry7hjBpKh5LjMWCU3JRuRFcBBYpcWIHc
        ++DlQzW8PvxAOGDZ4sFWiUr1M
X-Received: by 2002:a05:6402:31f3:: with SMTP id dy19mr8407669edb.153.1623954377523;
        Thu, 17 Jun 2021 11:26:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwHC/0zrifPDrAWmAlm02JHo9HIKYIOLCBfKF2EIzEF/aYCysomV9DjE4RzUEhNqpvTWbYIiA==
X-Received: by 2002:a05:6402:31f3:: with SMTP id dy19mr8407653edb.153.1623954377328;
        Thu, 17 Jun 2021 11:26:17 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id u21sm4202016eja.59.2021.06.17.11.26.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jun 2021 11:26:16 -0700 (PDT)
Subject: Re: [PATCH v3] KVM: LAPIC: Keep stored TMCCT register value 0 after
 KVM_SET_LAPIC
To:     Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
References: <1623223000-18116-1-git-send-email-wanpengli@tencent.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <02391363-6713-1548-fa4b-70b70cc96f79@redhat.com>
Date:   Thu, 17 Jun 2021 20:26:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <1623223000-18116-1-git-send-email-wanpengli@tencent.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/06/21 09:16, Wanpeng Li wrote:
> From: Wanpeng Li <wanpengli@tencent.com>
> 
> KVM_GET_LAPIC stores the current value of TMCCT and KVM_SET_LAPIC's memcpy
> stores it in vcpu->arch.apic->regs, KVM_SET_LAPIC could store zero in
> vcpu->arch.apic->regs after it uses it, and then the stored value would
> always be zero. In addition, the TMCCT is always computed on-demand and
> never directly readable.
> 
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
>   arch/x86/kvm/lapic.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index 6d72d8f43310..9bd29b3ca790 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -2628,6 +2628,7 @@ int kvm_apic_set_state(struct kvm_vcpu *vcpu, struct kvm_lapic_state *s)
>   	apic_manage_nmi_watchdog(apic, kvm_lapic_get_reg(apic, APIC_LVT0));
>   	update_divide_count(apic);
>   	__start_apic_timer(apic, APIC_TMCCT);
> +	kvm_lapic_set_reg(apic, APIC_TMCCT, 0);
>   	kvm_apic_update_apicv(vcpu);
>   	apic->highest_isr_cache = -1;
>   	if (vcpu->arch.apicv_active) {
> 

Queued, thanks.

Paolo

