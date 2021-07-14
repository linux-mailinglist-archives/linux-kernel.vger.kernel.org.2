Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55BFB3C8891
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 18:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbhGNQ1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 12:27:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54202 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229554AbhGNQ07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 12:26:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626279847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XOSyZTmUOUHddn1EWyHVvuoKVwDzElqd4nGHPGr4I4I=;
        b=gywPPW+PtpsfMthBoiUoMRpUPhtO2Tmdv+umPyW5oq6KN9bIO+Ko/yzuVx4kfizTCl+DOa
        bmiC3GEvt6UlOI8X6WsbGh/IfNIdqRyuK5E2H4ogWkSCkZMORlCctCAgCTh1N897tmGHEX
        8syJbrHxWOSSQ+vB6rPBIzRHZqsWnY4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-7dStoeyiNKqoQUfgZv6vHw-1; Wed, 14 Jul 2021 12:24:06 -0400
X-MC-Unique: 7dStoeyiNKqoQUfgZv6vHw-1
Received: by mail-wm1-f70.google.com with SMTP id l33-20020a05600c1d21b029021c6168367bso614812wms.9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 09:24:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=XOSyZTmUOUHddn1EWyHVvuoKVwDzElqd4nGHPGr4I4I=;
        b=Ju6/UMEbEldONdDtxBAE0Qo3VdqvjNhIIatCThIuwZHPUbG9LZVl0vn2aGxyUxLOLw
         lYA2IJhQZ6kgT4LvFhtKAkjJflI1OHYkyv2WTfXq7TIL91/M1jYBUvnSdoK1z2uomvSM
         Es4o0VbGT3SduXlaSWpnK5erz4BWP5sjspzYNEnTNlniAW8FSkjPPzcOA2HXgfsvE9Ec
         FaNHDa0gkcj/ZCw5bvlugUnmjmqrsz6kNKOkFBWaRpk1UuDNT9aHHtjixOFwCD1ZaWb3
         Ead6FQl7F8fAVXEFMEExF56BFl88UlMwQEXB+jQngPqZXkrZBeRLNd5M2yDhz/EcHVsg
         B5eQ==
X-Gm-Message-State: AOAM533LjOIMNnwiWCoenk8FlvzkbUvilZRcLpKoHx0S3EZEDUXRPr1i
        SpGpzfOuCZhyIYrLxdehq27raqADP0vNIN7GvcBJhDc9eqj/qB6rCaqdtYdYaOalolUbEg/qvZE
        jD6x3VrQEPSchVMD1/9rwhIOo
X-Received: by 2002:a05:6000:18ae:: with SMTP id b14mr11053661wri.427.1626279844896;
        Wed, 14 Jul 2021 09:24:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwOUHqgSVMSt4kT31DzF0TTbh3RCm3TqeS6VrhoFbzDF67zPoEwHcFxfwhmql5gyhE25Od6Ww==
X-Received: by 2002:a05:6000:18ae:: with SMTP id b14mr11053627wri.427.1626279844617;
        Wed, 14 Jul 2021 09:24:04 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c60d5.dip0.t-ipconnect.de. [91.12.96.213])
        by smtp.gmail.com with ESMTPSA id w3sm3143291wrt.55.2021.07.14.09.24.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jul 2021 09:24:04 -0700 (PDT)
To:     Peter Xu <peterx@redhat.com>,
        Tiberiu Georgescu <tiberiu.georgescu@nutanix.com>
Cc:     akpm@linux-foundation.org, catalin.marinas@arm.com,
        peterz@infradead.org, chinwen.chang@mediatek.com,
        linmiaohe@huawei.com, jannh@google.com, apopple@nvidia.com,
        christian.brauner@ubuntu.com, ebiederm@xmission.com,
        adobriyan@gmail.com, songmuchun@bytedance.com, axboe@kernel.dk,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, ivan.teterevkov@nutanix.com,
        florian.schmidt@nutanix.com, carl.waldspurger@nutanix.com,
        Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>
References: <20210714152426.216217-1-tiberiu.georgescu@nutanix.com>
 <20210714152426.216217-2-tiberiu.georgescu@nutanix.com>
 <YO8L5PTdAs+vPeIx@t490s>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC PATCH 1/1] pagemap: report swap location for shared pages
Message-ID: <0e38ef52-0ac7-c15b-114b-3316973fc7dc@redhat.com>
Date:   Wed, 14 Jul 2021 18:24:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YO8L5PTdAs+vPeIx@t490s>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.07.21 18:08, Peter Xu wrote:
> On Wed, Jul 14, 2021 at 03:24:26PM +0000, Tiberiu Georgescu wrote:
>> When a page allocated using the MAP_SHARED flag is swapped out, its pagemap
>> entry is cleared. In many cases, there is no difference between swapped-out
>> shared pages and newly allocated, non-dirty pages in the pagemap interface.
>>
>> This patch addresses the behaviour and modifies pte_to_pagemap_entry() to
>> make use of the XArray associated with the virtual memory area struct
>> passed as an argument. The XArray contains the location of virtual pages
>> in the page cache, swap cache or on disk. If they are on either of the
>> caches, then the original implementation still works. If not, then the
>> missing information will be retrieved from the XArray.
>>
>> Co-developed-by: Florian Schmidt <florian.schmidt@nutanix.com>
>> Signed-off-by: Florian Schmidt <florian.schmidt@nutanix.com>
>> Co-developed-by: Carl Waldspurger <carl.waldspurger@nutanix.com>
>> Signed-off-by: Carl Waldspurger <carl.waldspurger@nutanix.com>
>> Co-developed-by: Ivan Teterevkov <ivan.teterevkov@nutanix.com>
>> Signed-off-by: Ivan Teterevkov <ivan.teterevkov@nutanix.com>
>> Signed-off-by: Tiberiu Georgescu <tiberiu.georgescu@nutanix.com>
>> ---
>>   fs/proc/task_mmu.c | 37 +++++++++++++++++++++++++++++--------
>>   1 file changed, 29 insertions(+), 8 deletions(-)
>>
>> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
>> index eb97468dfe4c..b17c8aedd32e 100644
>> --- a/fs/proc/task_mmu.c
>> +++ b/fs/proc/task_mmu.c
>> @@ -1359,12 +1359,25 @@ static int pagemap_pte_hole(unsigned long start, unsigned long end,
>>   	return err;
>>   }
>>   
>> +static void *get_xa_entry_at_vma_addr(struct vm_area_struct *vma,
>> +		unsigned long addr)
>> +{
>> +	struct inode *inode = file_inode(vma->vm_file);
>> +	struct address_space *mapping = inode->i_mapping;
>> +	pgoff_t offset = linear_page_index(vma, addr);
>> +
>> +	return xa_load(&mapping->i_pages, offset);
>> +}
>> +
>>   static pagemap_entry_t pte_to_pagemap_entry(struct pagemapread *pm,
>>   		struct vm_area_struct *vma, unsigned long addr, pte_t pte)
>>   {
>>   	u64 frame = 0, flags = 0;
>>   	struct page *page = NULL;
>>   
>> +	if (vma->vm_flags & VM_SOFTDIRTY)
>> +		flags |= PM_SOFT_DIRTY;
>> +
>>   	if (pte_present(pte)) {
>>   		if (pm->show_pfn)
>>   			frame = pte_pfn(pte);
>> @@ -1374,13 +1387,22 @@ static pagemap_entry_t pte_to_pagemap_entry(struct pagemapread *pm,
>>   			flags |= PM_SOFT_DIRTY;
>>   		if (pte_uffd_wp(pte))
>>   			flags |= PM_UFFD_WP;
>> -	} else if (is_swap_pte(pte)) {
>> +	} else if (is_swap_pte(pte) || shmem_file(vma->vm_file)) {
>>   		swp_entry_t entry;
>> -		if (pte_swp_soft_dirty(pte))
>> -			flags |= PM_SOFT_DIRTY;
>> -		if (pte_swp_uffd_wp(pte))
>> -			flags |= PM_UFFD_WP;
>> -		entry = pte_to_swp_entry(pte);
>> +		if (is_swap_pte(pte)) {
>> +			entry = pte_to_swp_entry(pte);
>> +			if (pte_swp_soft_dirty(pte))
>> +				flags |= PM_SOFT_DIRTY;
>> +			if (pte_swp_uffd_wp(pte))
>> +				flags |= PM_UFFD_WP;
>> +		} else {
>> +			void *xa_entry = get_xa_entry_at_vma_addr(vma, addr);
>> +
>> +			if (xa_is_value(xa_entry))
>> +				entry = radix_to_swp_entry(xa_entry);
>> +			else
>> +				goto out;
>> +		}
>>   		if (pm->show_pfn)
>>   			frame = swp_type(entry) |
>>   				(swp_offset(entry) << MAX_SWAPFILES_SHIFT);
>> @@ -1393,9 +1415,8 @@ static pagemap_entry_t pte_to_pagemap_entry(struct pagemapread *pm,
>>   		flags |= PM_FILE;
>>   	if (page && page_mapcount(page) == 1)
>>   		flags |= PM_MMAP_EXCLUSIVE;
>> -	if (vma->vm_flags & VM_SOFTDIRTY)
>> -		flags |= PM_SOFT_DIRTY;
> 
> IMHO moving this to the entry will only work for the initial iteration, however
> it won't really help anything, as soft-dirty should always be used in pair with
> clear_refs written with value "4" first otherwise all pages will be marked
> soft-dirty then the pagemap data is meaningless.
> 
> After the "write 4" op VM_SOFTDIRTY will be cleared and I expect the test case
> to see all zeros again even with the patch.
> 
> I think one way to fix this is to do something similar to uffd-wp: we leave a
> marker in pte showing that this is soft-dirtied pte even if swapped out.

How exactly does such a pte look like? Simply pte_none() with another 
bit set?

> However we don't have a mechanism for that yet in current linux, and the
> uffd-wp series is the first one trying to introduce something like that.

Can you give me a pointer? I'm very interested in learning how to 
identify this case.

-- 
Thanks,

David / dhildenb

