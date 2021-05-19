Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D351C388D6F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 14:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353231AbhESME5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 08:04:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54948 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230226AbhESMEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 08:04:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621425807;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C2tITqJSuYbvq+jsZJ9sBCe2doWKAdm3TnmWMpGg4/0=;
        b=X4b+gY5c0RjprC3urjmnxWlhElpP3X2SXanYqYKFW/c/zod/1HWrh4K92tXnOgm75QN94p
        5AsvlZgKmOlpi372sh4MdCGFd0nyaX/j7pe5f1rtPb71IEKgzyebj9SDV8W2G3ynBNd276
        L0PyYrR+7NwH675X/Az+w+gLV9OGmY0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-553-Xr5dsVxRO-i-jBNO_fYMDA-1; Wed, 19 May 2021 08:03:26 -0400
X-MC-Unique: Xr5dsVxRO-i-jBNO_fYMDA-1
Received: by mail-wm1-f71.google.com with SMTP id n127-20020a1c27850000b02901717a27c785so1448105wmn.9
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 05:03:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=C2tITqJSuYbvq+jsZJ9sBCe2doWKAdm3TnmWMpGg4/0=;
        b=W0E+kLMhEv4w1H2vxpQOexJPYDBONaCEyJiylA0SBws1p+6HrpfCeiJQoaQVHQrRJq
         bcZ1IpquNh0D6LaR2S4llAr3wIIgAkFYfK7xmbzWJAvmI2RXTFZTPliu+ofisZ8QiolX
         urrsbJ+dnBIK5fOHf2s702Bd1s8jF/vW1yI3La35/j76pY6w4YS/1GnfZj4xu4yKZnt4
         IxP9R8tF8JL+6113WpyRCI/Zuqj2+eog9UtQWffRL1wmY/nzEvFRz4XhNdkasqpcV9N5
         IrRmFfICD19T8WJwvWAEr0RVVtsiO+p4jiUlwOTLqde3AP8vPYGcV9wFChTWgHoRImp4
         Jk+Q==
X-Gm-Message-State: AOAM531PiNxGrdpyh2gRXGWn4ylTypz3LxfoQ7OqSvskYlCATmY1XWFF
        XKvbzL71elesrcdcH/7VgNGDVpiB6wMI/y+duyjkcD6m9JFZTApna11O6pXzuwgyiixd+rCkssT
        yagFfgDk9CudW3dMRnNGuotIs
X-Received: by 2002:a05:600c:218c:: with SMTP id e12mr10837515wme.16.1621425805113;
        Wed, 19 May 2021 05:03:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzUbn7Icj3cLTs0K75jizldDb0dn/E0PcCqSEvXVbxyqNjMn+DSAD0c6hFvb3EV1mBLD2Bw+g==
X-Received: by 2002:a05:600c:218c:: with SMTP id e12mr10837476wme.16.1621425804863;
        Wed, 19 May 2021 05:03:24 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6694.dip0.t-ipconnect.de. [91.12.102.148])
        by smtp.gmail.com with ESMTPSA id w25sm20593966wmk.25.2021.05.19.05.03.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 May 2021 05:03:24 -0700 (PDT)
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Muchun Song <songmuchun@bytedance.com>, will@kernel.org,
        akpm@linux-foundation.org, bodeddub@amazon.com, osalvador@suse.de,
        mike.kravetz@oracle.com, rientjes@google.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com,
        fam.zheng@bytedance.com, zhengqi.arch@bytedance.com
References: <20210518091826.36937-1-songmuchun@bytedance.com>
 <1b9d008a-7544-cc85-5c2f-532b984eb5b5@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] arm64: mm: hugetlb: add support for free vmemmap pages of
 HugeTLB
Message-ID: <88114091-fbb2-340d-b69b-a572fa340265@redhat.com>
Date:   Wed, 19 May 2021 14:03:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <1b9d008a-7544-cc85-5c2f-532b984eb5b5@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.05.21 13:45, Anshuman Khandual wrote:
> 
> 
> On 5/18/21 2:48 PM, Muchun Song wrote:
>> The preparation of supporting freeing vmemmap associated with each
>> HugeTLB page is ready, so we can support this feature for arm64.
>>
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>> ---
>>   arch/arm64/mm/mmu.c | 5 +++++
>>   fs/Kconfig          | 2 +-
>>   2 files changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index 5d37e461c41f..967b01ce468d 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -23,6 +23,7 @@
>>   #include <linux/mm.h>
>>   #include <linux/vmalloc.h>
>>   #include <linux/set_memory.h>
>> +#include <linux/hugetlb.h>
>>   
>>   #include <asm/barrier.h>
>>   #include <asm/cputype.h>
>> @@ -1134,6 +1135,10 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
>>   	pmd_t *pmdp;
>>   
>>   	WARN_ON((start < VMEMMAP_START) || (end > VMEMMAP_END));
>> +
>> +	if (is_hugetlb_free_vmemmap_enabled() && !altmap)
>> +		return vmemmap_populate_basepages(start, end, node, altmap);
> 
> Not considering the fact that this will force the kernel to have only
> base page size mapping for vmemmap (unless altmap is also requested)
> which might reduce the performance, it also enables vmemmap mapping to
> be teared down or build up at runtime which could potentially collide
> with other kernel page table walkers like ptdump or memory hotremove
> operation ! How those possible collisions are protected right now ?

Hi Anshuman,

Memory hotremove is not an issue IIRC. At the time memory is removed, 
all huge pages either have been migrated away or dissolved; the vmemmap 
is stable.

vmemmap access (accessing the memmap via a virtual address) itself is 
not an issue. Manually walking (vmemmap) page tables might behave 
differently, not sure if ptdump would require any synchronization.

> 
> Does not this vmemmap operation increase latency for HugeTLB usage ?
> Should not this runtime enablement also take into account some other
> qualifying information apart from potential memory save from struct
> page areas. Just wondering.

That's one of the reasons why it explicitly has to be enabled by an admin.

-- 
Thanks,

David / dhildenb

