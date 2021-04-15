Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 129093605BD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 11:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbhDOJcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 05:32:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47833 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230474AbhDOJb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 05:31:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618479091;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=phkRKYasHy2ON2Zd+AYnzw9m/3bL2pWoEajZ+S+eLjE=;
        b=UHVBgssU6AtMt7bHKsoNjGWZmLb2dNLpL302eS/pWSek+cSANzQYV+T5IF5/6J8TY3XYK9
        oGUUZTiXJVLBmXGkoT9uyfn2IYP61rhRDkv/FkfDp4d7J8WZKq9kOSpPzEBM/YRFhSEhTM
        UCRPfAOEIqko7TFJbvhXa55fXK1c8DU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-6VbZ0yRqOay4S7RceM_prw-1; Thu, 15 Apr 2021 05:31:29 -0400
X-MC-Unique: 6VbZ0yRqOay4S7RceM_prw-1
Received: by mail-wr1-f72.google.com with SMTP id t14-20020adff04e0000b0290103307c23e1so2465906wro.8
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 02:31:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=phkRKYasHy2ON2Zd+AYnzw9m/3bL2pWoEajZ+S+eLjE=;
        b=SDpTCX12bYHwLDP5RxzOR9eT9wUDnhDSFdFPZ+8jZ41M714+nltKQI/YVgftphoThd
         6xEUlbqKF9LK3GfHppxHoloxhDKecK5M9qjGOF8QMrsVUL7WmN/qef/0wM+qeKQucaoi
         2E4ivmAGUePR3GI6K7YFnPaGwqApo62Qd3h0BvGgGBUj+twPsvrdsWJM+H6UWqb9H/kW
         hdrw8AIctYk0iqvHvYMfqtiqfQV9JqCxAutHvarNyECAWTGF4qg6UI18m2M87KMfotJT
         AQ5SrySWjm51Vw6lfu4hT+4rLugPc2HoPoIbbfrhW5N6fUhhP1qDQgjvI+fNNxZaOPs+
         w4LA==
X-Gm-Message-State: AOAM533O3uIybgMWwSk5Qn97ddiCFJBzzdLDH9eXsg7laq/yN8y15P4K
        mnERsRjDhQK2j5fBkDdkicIX4YvWM0gFczWHcQ6K8yoA+h7f9q8ekPpRO6x2QYxZZ8Xy0lgD86O
        xjp+dMgDHX9okmZJEQJviMQkX
X-Received: by 2002:adf:8b45:: with SMTP id v5mr2406839wra.398.1618479088756;
        Thu, 15 Apr 2021 02:31:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxfQSnAXznxI2JGkIgFlRINBs/MudcZie1Vu3F7EQtZ3n7ewfaKl4lNqKpS1JUJMayw6nDijQ==
X-Received: by 2002:adf:8b45:: with SMTP id v5mr2406812wra.398.1618479088514;
        Thu, 15 Apr 2021 02:31:28 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6392.dip0.t-ipconnect.de. [91.12.99.146])
        by smtp.gmail.com with ESMTPSA id t19sm1746813wmq.14.2021.04.15.02.31.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Apr 2021 02:31:27 -0700 (PDT)
Subject: Re: [RFC/RFT PATCH 2/3] arm64: decouple check whether pfn is normal
 memory from pfn_valid()
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20210407172607.8812-1-rppt@kernel.org>
 <20210407172607.8812-3-rppt@kernel.org>
 <4a788546-b854-fd35-644a-f1d9075a9a78@arm.com>
 <9c0956f0-494e-5c6b-bdc2-d4213afd5e2f@redhat.com>
 <YHdQtmuxpqi4wCE/@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <62161846-4f03-e4b1-ae0b-fdf96f78d97c@redhat.com>
Date:   Thu, 15 Apr 2021 11:31:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YHdQtmuxpqi4wCE/@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.04.21 22:29, Mike Rapoport wrote:
> On Wed, Apr 14, 2021 at 05:58:26PM +0200, David Hildenbrand wrote:
>> On 08.04.21 07:14, Anshuman Khandual wrote:
>>>
>>> On 4/7/21 10:56 PM, Mike Rapoport wrote:
>>>> From: Mike Rapoport <rppt@linux.ibm.com>
>>>>
>>>> The intended semantics of pfn_valid() is to verify whether there is a
>>>> struct page for the pfn in question and nothing else.
>>>
>>> Should there be a comment affirming this semantics interpretation, above the
>>> generic pfn_valid() in include/linux/mmzone.h ?
>>>
>>>>
>>>> Yet, on arm64 it is used to distinguish memory areas that are mapped in the
>>>> linear map vs those that require ioremap() to access them.
>>>>
>>>> Introduce a dedicated pfn_is_memory() to perform such check and use it
>>>> where appropriate.
>>>>
>>>> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
>>>> ---
>>>>    arch/arm64/include/asm/memory.h | 2 +-
>>>>    arch/arm64/include/asm/page.h   | 1 +
>>>>    arch/arm64/kvm/mmu.c            | 2 +-
>>>>    arch/arm64/mm/init.c            | 6 ++++++
>>>>    arch/arm64/mm/ioremap.c         | 4 ++--
>>>>    arch/arm64/mm/mmu.c             | 2 +-
>>>>    6 files changed, 12 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
>>>> index 0aabc3be9a75..7e77fdf71b9d 100644
>>>> --- a/arch/arm64/include/asm/memory.h
>>>> +++ b/arch/arm64/include/asm/memory.h
>>>> @@ -351,7 +351,7 @@ static inline void *phys_to_virt(phys_addr_t x)
>>>>    #define virt_addr_valid(addr)	({					\
>>>>    	__typeof__(addr) __addr = __tag_reset(addr);			\
>>>> -	__is_lm_address(__addr) && pfn_valid(virt_to_pfn(__addr));	\
>>>> +	__is_lm_address(__addr) && pfn_is_memory(virt_to_pfn(__addr));	\
>>>>    })
>>>>    void dump_mem_limit(void);
>>>> diff --git a/arch/arm64/include/asm/page.h b/arch/arm64/include/asm/page.h
>>>> index 012cffc574e8..32b485bcc6ff 100644
>>>> --- a/arch/arm64/include/asm/page.h
>>>> +++ b/arch/arm64/include/asm/page.h
>>>> @@ -38,6 +38,7 @@ void copy_highpage(struct page *to, struct page *from);
>>>>    typedef struct page *pgtable_t;
>>>>    extern int pfn_valid(unsigned long);
>>>> +extern int pfn_is_memory(unsigned long);
>>>>    #include <asm/memory.h>
>>>> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
>>>> index 8711894db8c2..ad2ea65a3937 100644
>>>> --- a/arch/arm64/kvm/mmu.c
>>>> +++ b/arch/arm64/kvm/mmu.c
>>>> @@ -85,7 +85,7 @@ void kvm_flush_remote_tlbs(struct kvm *kvm)
>>>>    static bool kvm_is_device_pfn(unsigned long pfn)
>>>>    {
>>>> -	return !pfn_valid(pfn);
>>>> +	return !pfn_is_memory(pfn);
>>>>    }
>>>>    /*
>>>> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
>>>> index 3685e12aba9b..258b1905ed4a 100644
>>>> --- a/arch/arm64/mm/init.c
>>>> +++ b/arch/arm64/mm/init.c
>>>> @@ -258,6 +258,12 @@ int pfn_valid(unsigned long pfn)
>>>>    }
>>>>    EXPORT_SYMBOL(pfn_valid);
>>>> +int pfn_is_memory(unsigned long pfn)
>>>> +{
>>>> +	return memblock_is_map_memory(PFN_PHYS(pfn));
>>>> +}
>>>> +EXPORT_SYMBOL(pfn_is_memory);> +
>>>
>>> Should not this be generic though ? There is nothing platform or arm64
>>> specific in here. Wondering as pfn_is_memory() just indicates that the
>>> pfn is linear mapped, should not it be renamed as pfn_is_linear_memory()
>>> instead ? Regardless, it's fine either way.
>>
>> TBH, I dislike (generic) pfn_is_memory(). It feels like we're mixing
>> concepts.
> 
> Yeah, at the moment NOMAP is very much arm specific so I'd keep it this way
> for now.
> 
>>   NOMAP memory vs !NOMAP memory; even NOMAP is some kind of memory
>> after all. pfn_is_map_memory() would be more expressive, although still
>> sub-optimal.
>>
>> We'd actually want some kind of arm64-specific pfn_is_system_memory() or the
>> inverse pfn_is_device_memory() -- to be improved.
> 
> In my current version (to be posted soon) I've started with
> pfn_lineary_mapped() but then ended up with pfn_mapped() to make it
> "upward" compatible with architectures that use direct rather than linear
> map :)

And even that is moot. It doesn't tell you if a PFN is *actually* mapped 
(hello secretmem).

I'd suggest to just use memblock_is_map_memory() in arch specific code. 
Then it's clear what we are querying exactly and what the semantics 
might be.

-- 
Thanks,

David / dhildenb

