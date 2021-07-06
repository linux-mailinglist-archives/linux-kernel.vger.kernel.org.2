Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66DBF3BD89D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 16:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232427AbhGFOpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 10:45:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38547 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232322AbhGFOoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 10:44:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625582483;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dyv/6mgjNNKYtygPJuI6vJBV8Q4XF1LGAO51hVfQGwE=;
        b=WIl/S/4MPA1x4RXf19wN/JggQl96ulno3U/WY3UNCKOsNerL1GSmDxU9yscB3ft7zoVTJX
        RxGQwI+9BSk3iXR1DrMfyP18FGpUYBwQV7FORWUHVN9uWXsGTLQ4lXj/11en/xnROeyVa+
        F9BpiH1Vzhxu2rHB13sTaiIDDWUNAZo=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-548-UHp17WhNNey-ay5UdAGSBA-1; Tue, 06 Jul 2021 10:41:22 -0400
X-MC-Unique: UHp17WhNNey-ay5UdAGSBA-1
Received: by mail-ed1-f71.google.com with SMTP id p19-20020aa7c4d30000b0290394bdda6d9cso10859341edr.21
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jul 2021 07:41:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dyv/6mgjNNKYtygPJuI6vJBV8Q4XF1LGAO51hVfQGwE=;
        b=hUf/Yi/5/PudzEuH9O33U0qiLHhHnuO6INzDRqywxDpQNi7bFd8iWt4LWDjZ4hzA9H
         Y0ngFjyDwryYYE06k2CrJzTXVUQ+3hwoc1jqzaGJklEQBj2jLCxGZ1nzo0MMTsZyfBLC
         tz8mgJ9VF45GUqyxF9ZUnH17EPGDL9iJI5G2TtGAUoMNykIiI2dOgLJFGwP9FkdbjoIV
         ZVEm0XRkOCh+w80gMC4/kBm6o5j2kZ0KesooTCW12yGUIUePCKAJVr9lAvut7pF8bdzl
         X/6+PEttY7rCfqZ+2EMqfYf5HRHR4MU8bv6O6PXlp/6A0DqGCtoHbW1uMPk7b0vgLMWq
         gLWA==
X-Gm-Message-State: AOAM533mAL94GFMbmNPA0XETHSvenALC/gpYWsZHfK+X/k2HmDAvENEl
        v1w+veCDXJ1Un/JQEODqYfOFFDCiMzu3Dac+2h/T7HsdFwe+RHs4hYxRWkbcTcRjbzOk3CHM6hO
        Chy5Y/GNlxIgSd0xZL1erkpxK
X-Received: by 2002:a17:907:7b9b:: with SMTP id ne27mr7623802ejc.318.1625582481350;
        Tue, 06 Jul 2021 07:41:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzZjvghyeB5q5KFlIBdTd3M1i6Cs8EjflinMcoeMLrkZQJ5IYpZgPqOp0uSqXUoAAMsURWsrA==
X-Received: by 2002:a17:907:7b9b:: with SMTP id ne27mr7623773ejc.318.1625582481104;
        Tue, 06 Jul 2021 07:41:21 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id t6sm7263654edd.3.2021.07.06.07.41.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jul 2021 07:41:19 -0700 (PDT)
Subject: Re: [RFC PATCH v2 39/69] KVM: x86: Add guest_supported_xss placholder
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
 <3bcd7285a0cb15974fdb0e8f81b61143a360f4a5.1625186503.git.isaku.yamahata@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <469f9f3d-bf51-1c79-1139-c4ccad4b7b89@redhat.com>
Date:   Tue, 6 Jul 2021 16:41:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <3bcd7285a0cb15974fdb0e8f81b61143a360f4a5.1625186503.git.isaku.yamahata@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/07/21 00:04, isaku.yamahata@intel.com wrote:
> From: Sean Christopherson <sean.j.christopherson@intel.com>
> 
> Add a per-vcpu placeholder for the support XSS of the guest so that the
> TDX configuration code doesn't need to hack in manual computation of the
> supported XSS.  KVM XSS enabling is currently being upstreamed, i.e.
> guest_supported_xss will no longer be a placeholder by the time TDX is
> ready for upstreaming (hopefully).
> 
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> ---
>   arch/x86/include/asm/kvm_host.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 7822b531a5e2..c641654307c6 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -656,6 +656,7 @@ struct kvm_vcpu_arch {
>   
>   	u64 xcr0;
>   	u64 guest_supported_xcr0;
> +	u64 guest_supported_xss;
>   
>   	struct kvm_pio_request pio;
>   	void *pio_data;
> 

Please remove guest_supported_xss from patch 66 for now, instead.

Paolo

