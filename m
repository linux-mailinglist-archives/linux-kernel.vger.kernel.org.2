Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66FFA368D9E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 09:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241012AbhDWHGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 03:06:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51552 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240920AbhDWHGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 03:06:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619161570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c0Cl5FS9BM4Q35WpIm6J5r8zv2qpk0iAb6szpk8n7ZM=;
        b=dJGZzFOBZEYmdiWWkrrImqmb1wpts+JIBwi4XMn+Exu4CgGzRXmH8+vOQN12FLUZ+Edtf7
        Z1jHNoUf7UTRYB9wPmnkzcbwgtYJTyV2ZIe+Zb7sbrq9UzZW0YayG2dVXwbc4Ot2nKq/rf
        AjUnzkzV+OpRiumkFRdC5kOrPRU2DUU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-541-p8vFkDLkMwyHFBiZYaFAnQ-1; Fri, 23 Apr 2021 03:06:08 -0400
X-MC-Unique: p8vFkDLkMwyHFBiZYaFAnQ-1
Received: by mail-ej1-f69.google.com with SMTP id n10-20020a1709061d0ab029037caa96b8c5so8098889ejh.23
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 00:06:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=c0Cl5FS9BM4Q35WpIm6J5r8zv2qpk0iAb6szpk8n7ZM=;
        b=XkIH+Ygqof6GNHlfD3jbLMHzTbc5u7G4R+EqhWrWxuPHqa/0i3tmnCJNyAqyZi254r
         x6T3M9hGmu6SYNoHasK4kPtHtHT7FFflroq8pmcS1zf/ZW4S9bWkr1VTSMCr5fWL8PR2
         ND3UEEfZYOkeFnK1SF3Q9CupfzxzJvbWlRlvvBKQX9VS+dy8J8TAyQemN18/oqzF0Zqa
         UglRTKzyv+K/+EuLUajKwgUuqMzHgHYEqDVeoouul8RsZ0w0EnRT7BryIjthEq3bQbBv
         0o+R5Luqyo8djG7QIGOG9+PNuSMQUDsRe5V0yzfB/TkJnEy2PO7GPnTXeTnpEmeq3v5p
         SVWw==
X-Gm-Message-State: AOAM532e2+3Ognbn6NUoaTug76/QSqLWxkpgh8xNL7gYyd4LRvHov5UL
        eaAbFXdWxPqevl3o/qy6/vN2GZkqXjMdcnIj1zQ6WlRsdfPtZKhfoPU15en51b5Ghw11+x7YlkZ
        CXPJD5IJz94n6gnUkMwzX4hfY
X-Received: by 2002:a50:cc4b:: with SMTP id n11mr2774602edi.186.1619161566798;
        Fri, 23 Apr 2021 00:06:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzBaNe9SswxfFTcNaWeJfRB2NuJ7rXn8/9taV7As0j13rnKsmU38i2cf1iTBfRl6CSz7Kerww==
X-Received: by 2002:a50:cc4b:: with SMTP id n11mr2774568edi.186.1619161566637;
        Fri, 23 Apr 2021 00:06:06 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id e16sm3918899edu.94.2021.04.23.00.06.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Apr 2021 00:06:06 -0700 (PDT)
Subject: Re: [PATCH] KVM: x86: Fix implicit enum conversion goof in scattered
 reverse CPUID code
To:     Sean Christopherson <seanjc@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        Kai Huang <kai.huang@intel.com>
References: <20210421010850.3009718-1-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7b1f385c-3a97-efe0-bb8d-53cdb9c19dbf@redhat.com>
Date:   Fri, 23 Apr 2021 09:06:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210421010850.3009718-1-seanjc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/04/21 03:08, Sean Christopherson wrote:
> Take "enum kvm_only_cpuid_leafs" in scattered specific CPUID helpers
> (which is obvious in hindsight), and use "unsigned int" for leafs that
> can be the kernel's standard "enum cpuid_leaf" or the aforementioned
> KVM-only variant.  Loss of the enum params is a bit disapponting, but
> gcc obviously isn't providing any extra sanity checks, and the various
> BUILD_BUG_ON() assertions ensure the input is in range.
> 
> This fixes implicit enum conversions that are detected by clang-11.
> 
> Fixes: 4e66c0cb79b7 ("KVM: x86: Add support for reverse CPUID lookup of scattered features")
> Cc: Kai Huang <kai.huang@intel.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
> 
> Hopefully it's not too late to squash this...

Too late, but I queued this anyway.

Paolo

> 
>   arch/x86/kvm/cpuid.c | 5 +++--
>   arch/x86/kvm/cpuid.h | 2 +-
>   2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 96e41e1a1bde..e9d644147bf5 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -365,7 +365,7 @@ int kvm_vcpu_ioctl_get_cpuid2(struct kvm_vcpu *vcpu,
>   }
>   
>   /* Mask kvm_cpu_caps for @leaf with the raw CPUID capabilities of this CPU. */
> -static __always_inline void __kvm_cpu_cap_mask(enum cpuid_leafs leaf)
> +static __always_inline void __kvm_cpu_cap_mask(unsigned int leaf)
>   {
>   	const struct cpuid_reg cpuid = x86_feature_cpuid(leaf * 32);
>   	struct kvm_cpuid_entry2 entry;
> @@ -378,7 +378,8 @@ static __always_inline void __kvm_cpu_cap_mask(enum cpuid_leafs leaf)
>   	kvm_cpu_caps[leaf] &= *__cpuid_entry_get_reg(&entry, cpuid.reg);
>   }
>   
> -static __always_inline void kvm_cpu_cap_init_scattered(enum cpuid_leafs leaf, u32 mask)
> +static __always_inline
> +void kvm_cpu_cap_init_scattered(enum kvm_only_cpuid_leafs leaf, u32 mask)
>   {
>   	/* Use kvm_cpu_cap_mask for non-scattered leafs. */
>   	BUILD_BUG_ON(leaf < NCAPINTS);
> diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
> index eeb4a3020e1b..7bb4504a2944 100644
> --- a/arch/x86/kvm/cpuid.h
> +++ b/arch/x86/kvm/cpuid.h
> @@ -236,7 +236,7 @@ static __always_inline void cpuid_entry_change(struct kvm_cpuid_entry2 *entry,
>   }
>   
>   static __always_inline void cpuid_entry_override(struct kvm_cpuid_entry2 *entry,
> -						 enum cpuid_leafs leaf)
> +						 unsigned int leaf)
>   {
>   	u32 *reg = cpuid_entry_get_reg(entry, leaf * 32);
>   
> 

