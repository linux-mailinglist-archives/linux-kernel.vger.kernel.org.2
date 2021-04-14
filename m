Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6E535F88D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 18:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347531AbhDNP67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 11:58:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20625 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233215AbhDNP6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 11:58:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618415910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xuItTKmz5+Knqt1+vfq/OkDfdneEY+UbE9qRzfYYMnc=;
        b=gTIh5q2tAD6g1Su6ChtlHQbbygIsjHa5HRSaKxi1fKF8gXZ+RLsOlaQBQZfcrOKN5xPNry
        DWaqBqJzP7SmlpQI+pDzG+L2p+mMValf3Wozag9tdbtlbzQuv1RKIToj0Df6FPf6EwxaAM
        vKwlXhD5htSIE409GPPJbwKPz4Uccwo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-535-FmXt2jwTNT6FQHP0Q-Rr7w-1; Wed, 14 Apr 2021 11:58:28 -0400
X-MC-Unique: FmXt2jwTNT6FQHP0Q-Rr7w-1
Received: by mail-wm1-f72.google.com with SMTP id u11-20020a05600c00cbb029012a3f52677dso2201079wmm.8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 08:58:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=xuItTKmz5+Knqt1+vfq/OkDfdneEY+UbE9qRzfYYMnc=;
        b=stFYNfc/B/SHhOLbUaY/jHVNZmiUUIpVXsI539mLGna3i5flVXmdYcrstC+nihrmQ1
         XOaHxI+Yxjpp+vBJfhu+rMsl0egRxysDOYgo6O1vMjBbeq1fNzLjT/ImOYWQJ0LG4AE9
         eiwlwrPZTV61XWNDZAMdeVC3TO+t/N0eGAdTpIffvLr2tPV35C+olFXgCECXP1VbeR9j
         bNw1K1aRLkdN6c9nhHIellde6n+v7LPW/GzvTi5AiqTkvUlh5rOTBi41wI+Dqn7bPu/v
         XbA+j+I+g9igEUp6TyDDQ/Cb5IvNknJSOhn/x9DB2yb0+fDkKVn3NAULk7MV7CCV8a00
         Lbrg==
X-Gm-Message-State: AOAM532vi+RGz+IkEpKjgS5vkfYk0vCpX3CRVijEqEk4e3bAdz6PQ/uY
        bhP1Q8PvLVyj67FkZLSV1tATnKbC5ZOEPbNEwfhWPFDPHHybhAIJ25JHT+h6pMf2WnwUsv+D8Uh
        TC3C4aijkusyUSK669r53pDyf
X-Received: by 2002:a5d:4689:: with SMTP id u9mr8195034wrq.10.1618415907424;
        Wed, 14 Apr 2021 08:58:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxGqSCJM5+og5DryDMutS2KeHgtQzF2BtH5xs7DH3i6DfTgoCDlW4C+HHfPtOlPuTkx6JlsgA==
X-Received: by 2002:a5d:4689:: with SMTP id u9mr8195011wrq.10.1618415907152;
        Wed, 14 Apr 2021 08:58:27 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6470.dip0.t-ipconnect.de. [91.12.100.112])
        by smtp.gmail.com with ESMTPSA id y31sm5805675wmp.46.2021.04.14.08.58.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Apr 2021 08:58:26 -0700 (PDT)
Subject: Re: [RFC/RFT PATCH 2/3] arm64: decouple check whether pfn is normal
 memory from pfn_valid()
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20210407172607.8812-1-rppt@kernel.org>
 <20210407172607.8812-3-rppt@kernel.org>
 <4a788546-b854-fd35-644a-f1d9075a9a78@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <9c0956f0-494e-5c6b-bdc2-d4213afd5e2f@redhat.com>
Date:   Wed, 14 Apr 2021 17:58:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <4a788546-b854-fd35-644a-f1d9075a9a78@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.04.21 07:14, Anshuman Khandual wrote:
> 
> On 4/7/21 10:56 PM, Mike Rapoport wrote:
>> From: Mike Rapoport <rppt@linux.ibm.com>
>>
>> The intended semantics of pfn_valid() is to verify whether there is a
>> struct page for the pfn in question and nothing else.
> 
> Should there be a comment affirming this semantics interpretation, above the
> generic pfn_valid() in include/linux/mmzone.h ?
> 
>>
>> Yet, on arm64 it is used to distinguish memory areas that are mapped in the
>> linear map vs those that require ioremap() to access them.
>>
>> Introduce a dedicated pfn_is_memory() to perform such check and use it
>> where appropriate.
>>
>> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
>> ---
>>   arch/arm64/include/asm/memory.h | 2 +-
>>   arch/arm64/include/asm/page.h   | 1 +
>>   arch/arm64/kvm/mmu.c            | 2 +-
>>   arch/arm64/mm/init.c            | 6 ++++++
>>   arch/arm64/mm/ioremap.c         | 4 ++--
>>   arch/arm64/mm/mmu.c             | 2 +-
>>   6 files changed, 12 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
>> index 0aabc3be9a75..7e77fdf71b9d 100644
>> --- a/arch/arm64/include/asm/memory.h
>> +++ b/arch/arm64/include/asm/memory.h
>> @@ -351,7 +351,7 @@ static inline void *phys_to_virt(phys_addr_t x)
>>   
>>   #define virt_addr_valid(addr)	({					\
>>   	__typeof__(addr) __addr = __tag_reset(addr);			\
>> -	__is_lm_address(__addr) && pfn_valid(virt_to_pfn(__addr));	\
>> +	__is_lm_address(__addr) && pfn_is_memory(virt_to_pfn(__addr));	\
>>   })
>>   
>>   void dump_mem_limit(void);
>> diff --git a/arch/arm64/include/asm/page.h b/arch/arm64/include/asm/page.h
>> index 012cffc574e8..32b485bcc6ff 100644
>> --- a/arch/arm64/include/asm/page.h
>> +++ b/arch/arm64/include/asm/page.h
>> @@ -38,6 +38,7 @@ void copy_highpage(struct page *to, struct page *from);
>>   typedef struct page *pgtable_t;
>>   
>>   extern int pfn_valid(unsigned long);
>> +extern int pfn_is_memory(unsigned long);
>>   
>>   #include <asm/memory.h>
>>   
>> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
>> index 8711894db8c2..ad2ea65a3937 100644
>> --- a/arch/arm64/kvm/mmu.c
>> +++ b/arch/arm64/kvm/mmu.c
>> @@ -85,7 +85,7 @@ void kvm_flush_remote_tlbs(struct kvm *kvm)
>>   
>>   static bool kvm_is_device_pfn(unsigned long pfn)
>>   {
>> -	return !pfn_valid(pfn);
>> +	return !pfn_is_memory(pfn);
>>   }
>>   
>>   /*
>> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
>> index 3685e12aba9b..258b1905ed4a 100644
>> --- a/arch/arm64/mm/init.c
>> +++ b/arch/arm64/mm/init.c
>> @@ -258,6 +258,12 @@ int pfn_valid(unsigned long pfn)
>>   }
>>   EXPORT_SYMBOL(pfn_valid);
>>   
>> +int pfn_is_memory(unsigned long pfn)
>> +{
>> +	return memblock_is_map_memory(PFN_PHYS(pfn));
>> +}
>> +EXPORT_SYMBOL(pfn_is_memory);> +
> 
> Should not this be generic though ? There is nothing platform or arm64
> specific in here. Wondering as pfn_is_memory() just indicates that the
> pfn is linear mapped, should not it be renamed as pfn_is_linear_memory()
> instead ? Regardless, it's fine either way.

TBH, I dislike (generic) pfn_is_memory(). It feels like we're mixing 
concepts. NOMAP memory vs !NOMAP memory; even NOMAP is some kind of 
memory after all. pfn_is_map_memory() would be more expressive, although 
still sub-optimal.

We'd actually want some kind of arm64-specific pfn_is_system_memory() or 
the inverse pfn_is_device_memory() -- to be improved.

-- 
Thanks,

David / dhildenb

