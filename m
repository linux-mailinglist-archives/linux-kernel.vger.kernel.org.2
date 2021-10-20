Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57DC0434E5D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 16:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbhJTO6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 10:58:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51213 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229570AbhJTO6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 10:58:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634741760;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DvkW/BJlHhRMHO63xOlv6FjfRFrkZksB/IOG7UE4hNA=;
        b=g/ec2qizSJzT3ouRB5QJgL3vkFR94hhV1YIJfpFGl6zhMdV2wvkGxl5jmKT9hy0zR0af4B
        xZfMTU6QNRZak75Q5t+zoEpoKguFHkZ+Bv34Jbw+YxhltFhA4jXu9MlVLbSSIC/P6/d6xy
        MqfsYn1ZPDf1le1JAB+QWfzWYrhcDtQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-PKFnUm0tOgCc_uMljUpYTw-1; Wed, 20 Oct 2021 10:55:58 -0400
X-MC-Unique: PKFnUm0tOgCc_uMljUpYTw-1
Received: by mail-ed1-f70.google.com with SMTP id g28-20020a50d0dc000000b003dae69dfe3aso21242064edf.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 07:55:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DvkW/BJlHhRMHO63xOlv6FjfRFrkZksB/IOG7UE4hNA=;
        b=6O16fKYavILbyDVLS8KkR6HsWh1X/0YIqneOUuLDXwmXUwe+4qz57b9uOfY4IRUSBv
         lgPhRH5F3T5ntyIi3xKNRXfPAH1gi2Ui0zKfHuN/MPZMVRuSqKmWe7HXhhWsPBF7X+C/
         UV6XBGhZfWVWyo6wV6mN1I6VK6N30FyRfEDURLBDoOgHapmGnNmKyWjMiocwNUgbJpfU
         iOthXvdE8clkaSpzXlhpTiYhoHpDKjWj0qneWsait+5wg7p0QluvEc8Rc+nDBd9R1XMt
         CS4sjUCipmbYiu3i8M+iKlVvC6cbpk0NJyjJDPYhvVjkdidULC/Hu+xpSCOqNSLOVPdZ
         X/+w==
X-Gm-Message-State: AOAM53160gaX6WgzQyv8zN4nHx0CYtNa7LQUx34EHdAWRKHIo8duXcdZ
        5YaDNR1rQVFL8ofSoD6i0Zd+kd4jopiG9ub/xRcKOBGuhJm48qjVSs0YI5tqPhshv0p+Xt1d3uV
        7pHb/sOsJEGP9R/jPm4xYRqaz
X-Received: by 2002:a50:da42:: with SMTP id a2mr505708edk.361.1634741757716;
        Wed, 20 Oct 2021 07:55:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw1++Z3/KHUmZ2PZcZLSOgJP0sE5Y2OiRPx35Tlh7QIfp4FNxn/cbmvY7EMfczpuCXhkDrFhQ==
X-Received: by 2002:a50:da42:: with SMTP id a2mr505670edk.361.1634741757437;
        Wed, 20 Oct 2021 07:55:57 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id j3sm1152009ejy.65.2021.10.20.07.55.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Oct 2021 07:55:56 -0700 (PDT)
Message-ID: <842ca2d4-fa72-3814-6c52-e079f081ec5d@redhat.com>
Date:   Wed, 20 Oct 2021 16:55:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH 0/2] KVM: x86: Enhance vendor module error messages
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Menzel <pmenzel@molgen.mpg.de>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
References: <20211018183929.897461-1-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20211018183929.897461-1-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/10/21 20:39, Sean Christopherson wrote:
> Paul Menzel encountered the bad userspace behavior of spamming KVM module
> loading on all CPUs, which was mitigated by commit ef935c25fd64 ("kvm: x86:
> Limit the number of "kvm: disabled by bios" messages"), except this time
> userspace is extra "clever" and spams both kvm_intel and kvm_amd.  Because
> the "already loaded the other module" message isn't ratelimited, the bogus
> module load managed to spam the kernel log.
> 
> Patch 1 addresses another suggestion from Paul by incorporating the vendor
> module name into the error messages.
> 
> Patch 2 addresses the original report by prioritizing the hardware/bios
> support messages over the "already loaded" error.  In additional to
> reducing spam, doing so also ensures consistent messaging if a vendor
> module isn't supported regardless of what other modules may be loaded.
> 
> [*] https://lkml.kernel.org/r/20210818114956.7171-1-pmenzel@molgen.mpg.de
> 
> Sean Christopherson (2):
>    KVM: x86: Add vendor name to kvm_x86_ops, use it for error messages
>    KVM: x86: Defer "already loaded" check until after basic support
>      checks
> 
>   arch/x86/include/asm/kvm_host.h |  2 ++
>   arch/x86/kvm/svm/svm.c          |  2 ++
>   arch/x86/kvm/vmx/vmx.c          |  2 ++
>   arch/x86/kvm/x86.c              | 17 +++++++++--------
>   4 files changed, 15 insertions(+), 8 deletions(-)
> 

Queued, thanks.  But I kept the ratelimiting; given the recent "clashes" 
with the chief penguin, I am also ratelimiting the snark in the commit 
messages.

Paolo

