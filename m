Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9114019AE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 12:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241882AbhIFKVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 06:21:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31776 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232032AbhIFKVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 06:21:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630923605;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kApZxRcNths8CwofL4jwNIMwgxVB9nVlu1PJuFsciKs=;
        b=bSjBrM9CplVykqZZt6L0625yX9b4zwYky2O5spF7FMzE4OVN7rfcCm21XOoSBxMIhqKROr
        ByLLU8GVCHd0xM/kVLWKrpVz8j4Flp0aTG7Jv5W3YU36AhUB8TFfha4pJi4IOW53BgtEzd
        jq/vweU/SUqdoFcu7jYU0Y7voBAFZyo=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-eJby92csORi3YZbWM_uTQw-1; Mon, 06 Sep 2021 06:20:05 -0400
X-MC-Unique: eJby92csORi3YZbWM_uTQw-1
Received: by mail-ej1-f70.google.com with SMTP id r21-20020a1709067055b02904be5f536463so2160176ejj.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 03:20:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kApZxRcNths8CwofL4jwNIMwgxVB9nVlu1PJuFsciKs=;
        b=IsZD+YlwQk+9VOf7BJPJcVIXZcafptR4XkUNhSVXfhUDo8up7UaGpb8PLgHHpSffeJ
         2CQUAJODlt0lWz4Tb/XiQEBD3F0BqL++9ukxPheh3Mh6FOvi9pGSVihiUVFOOo8zkauS
         aOuj4v0+oDKmZ1EP9vmC1hRH85O3qwYbJDgbPgMnwWfxaU5lGkPP+OX3c7UGxnq6lKa/
         /lW6WND6CS+3VuR+qSXe0vTWvepWSAiKj5eTR347Ip1F9hoPfZmOojJp62OMEEUEU2qY
         qUwcMsFK/M7pQStscCmZG1Q8vDATrZ6zjcjva1JRn4z/ap/XXdd8o/nWcL3uk7e1KzE9
         zNbQ==
X-Gm-Message-State: AOAM530BaPH+J/aNbvrihrVN+NflEZ52jEJ0J2XaxSOjton7lbw/2Maq
        6x+djMzH6gohNc78r0Oa2rb4dQZhaVKS8LWkIKJyaTYKtQLxAjka4yFQw0bMQH3ozhh4Z8Fv8x0
        /djs7+tn3DnNI+r+jZ6dyb3Od
X-Received: by 2002:a17:906:b00c:: with SMTP id v12mr12809172ejy.222.1630923603867;
        Mon, 06 Sep 2021 03:20:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyPJ+JhtNZmx05ysP93LZo4bmGfUAKojyaBYEWc3KUkgJMiIG8poRKWqRwdzqSe7p8yZW5CTg==
X-Received: by 2002:a17:906:b00c:: with SMTP id v12mr12809159ejy.222.1630923603602;
        Mon, 06 Sep 2021 03:20:03 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id p23sm4471023edw.94.2021.09.06.03.20.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Sep 2021 03:20:03 -0700 (PDT)
Subject: Re: [PATCH 0/3] KVM: x86/mmu: kvm_mmu_page cleanups
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jia He <justin.he@arm.com>
References: <20210901221023.1303578-1-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6636f9c9-96e9-40bf-e344-c0b3f6ed7bed@redhat.com>
Date:   Mon, 6 Sep 2021 12:20:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210901221023.1303578-1-seanjc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/09/21 00:10, Sean Christopherson wrote:
> Patch 1 is from Jia He to remove a defunct boolean from kvm_mmu_page
> (link[*] below if you want to take it directly).
> 
> Patch 2 builds on that patch to micro-optimize the TDP MMU flag.
> 
> Patch 3 is another micro-optimization that probably doesn't buy much
> performance (I didn't check), feel free to ignore it.
> 
> [*] https://lkml.kernel.org/r/20210830145336.27183-1-justin.he@arm.com
> 
> Jia He (1):
>    KVM: x86/mmu: Remove unused field mmio_cached in struct kvm_mmu_page
> 
> Sean Christopherson (2):
>    KVM: x86/mmu: Relocate kvm_mmu_page.tdp_mmu_page for better cache
>      locality
>    KVM: x86/mmu: Move lpage_disallowed_link further "down" in
>      kvm_mmu_page
> 
>   arch/x86/kvm/mmu/mmu_internal.h | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
> 

Queued, thanks.

Paolo

