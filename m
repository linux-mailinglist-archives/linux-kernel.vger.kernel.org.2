Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A577A436B70
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 21:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbhJUTp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 15:45:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32343 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230272AbhJUTp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 15:45:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634845421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jA5+/YLOXXotQtGi2/7M4WZlbe47Qp+2MvjCtlJSlO4=;
        b=HUd0db9oSj/oWgVrz+Ao2NrrQyWHg+B9vzV1B+4gZiCASwBmeNxnn0AclVRZT9DgV6eTDp
        PKF+u/G19YWQ12VB/R1ffYW3eO9HWSmIxiLG14Uc449uGTU332XQn2763HC/P87lPUzPWD
        w26tduhXiNIOA07EbaMLYDktgxBvv9I=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-527-Jg_oyTNhMB6ebw8aVlQ9cg-1; Thu, 21 Oct 2021 15:43:39 -0400
X-MC-Unique: Jg_oyTNhMB6ebw8aVlQ9cg-1
Received: by mail-ed1-f71.google.com with SMTP id u10-20020a50d94a000000b003dc51565894so1398508edj.21
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 12:43:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jA5+/YLOXXotQtGi2/7M4WZlbe47Qp+2MvjCtlJSlO4=;
        b=e9OrBo6Ovo6QO2PSuQlflCoTgoyCFdwe6LPt/Mz6r8lzPfFl0/vlLjns7SvCnLZ3R6
         ZAq0wL24KSV5Z5dQ10esRJK6Lni/64OE+B1PpDJ0l8AoFDmbGg7j4NEB03dL+D0uY1SX
         JD/As4+pAVnpCmalzc7PSn4kGE/kycBKpe6C6sIgsLnicmaDNrrauym5RE7JNhxZR/PM
         R9bkBoubTQ5F+qV83Ur19GGqHsJTZXvZHhG3bSDNnkJy8S3CiTxHs/XkKO3acbMmaVFr
         y2tswN5XbSId1Lh8m2ACBJ5I1kchSth0rRb39tq4uIFNF42+viIWcBiVtDbkgnOpwe/6
         b+iw==
X-Gm-Message-State: AOAM5333xvzHfv6xxI+U4r/YnBc5mr7hhwBeFNBXGYwVuMV38hGxEPYH
        miZxaWlGp4jeCTxPeg597u7pROaBG11LZ7wluX5EpAT3yDG/wMVJXswetNdlTkIzoTtO2Y8lEx5
        Ntmc597X/hlC/5i0Wytu3hOK3
X-Received: by 2002:a17:906:3842:: with SMTP id w2mr9951017ejc.28.1634845418710;
        Thu, 21 Oct 2021 12:43:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy2Pc0sZLEakmIY7IoYcyNraQH6cmIu6PwtuSJfu97RkCshSRmWBynXFw9s+hWcrXu92f78pw==
X-Received: by 2002:a17:906:3842:: with SMTP id w2mr9950993ejc.28.1634845418483;
        Thu, 21 Oct 2021 12:43:38 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.gmail.com with ESMTPSA id j1sm3264483edk.53.2021.10.21.12.43.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Oct 2021 12:43:37 -0700 (PDT)
Message-ID: <4b81af0a-559e-b8f5-ab8a-167c88fec2d5@redhat.com>
Date:   Thu, 21 Oct 2021 21:43:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH 4/4] KVM: VMX: Register posted interrupt wakeup handler
 iff APICv is enabled
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
References: <20211009001107.3936588-1-seanjc@google.com>
 <20211009001107.3936588-5-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20211009001107.3936588-5-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/10/21 02:11, Sean Christopherson wrote:
> Don't bother registering a posted interrupt wakeup handler if APICv is
> disabled, KVM utilizes the wakeup vector if and only if APICv is enabled.
> Practically speaking, there's no meaningful functional change as KVM's
> wakeup handler is a glorified nop if there are no vCPUs using posted
> interrupts, not to mention that nothing in the system should be sending
> wakeup interrupts when APICv is disabled.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>   arch/x86/kvm/vmx/vmx.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 9164f1870d49..df9ad4675215 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -7553,7 +7553,8 @@ static void vmx_migrate_timers(struct kvm_vcpu *vcpu)
>   
>   static void hardware_unsetup(void)
>   {
> -	kvm_unregister_posted_intr_wakeup_handler(pi_wakeup_handler);
> +	if (enable_apicv)
> +		kvm_unregister_posted_intr_wakeup_handler(pi_wakeup_handler);
>   
>   	if (nested)
>   		nested_vmx_hardware_unsetup();
> @@ -7907,7 +7908,8 @@ static __init int hardware_setup(void)
>   	if (r)
>   		nested_vmx_hardware_unsetup();
>   
> -	kvm_register_posted_intr_wakeup_handler(pi_wakeup_handler);
> +	if (enable_apicv)
> +		kvm_register_posted_intr_wakeup_handler(pi_wakeup_handler);
>   
>   	return r;
>   }

Also adds unnecessary complexity (you have to ensure the condition 
cannot change from one call to the other), so I am only queuing patches 
1 and 2.

Paolo

