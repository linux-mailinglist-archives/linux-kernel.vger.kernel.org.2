Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 900893FDF81
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 18:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244229AbhIAQO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 12:14:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40599 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231468AbhIAQOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 12:14:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630512807;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jNQNf94w2B/KUb1e/ecylvdoWjqK4Psx9JHN1btjTDc=;
        b=IzULm2yzpWu+1tvv1Ii05zTIgLkShu32qrDJGMI6pNWobAQue4bF0qZ6UGyIuXYPgltUIz
        TnmobW8hYdJ5/lhhKcgjysOUjZr2C/f+jD7sou/bmWck1V1bRszixbJP3fAITbUWZoCfc+
        V/2v4rMTp7DqERKNJvMcnF63g+ARAEI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-yEbB50KQMJGIxNFf7ZanTQ-1; Wed, 01 Sep 2021 12:13:24 -0400
X-MC-Unique: yEbB50KQMJGIxNFf7ZanTQ-1
Received: by mail-wm1-f71.google.com with SMTP id r125-20020a1c2b830000b0290197a4be97b7so11513wmr.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 09:13:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=jNQNf94w2B/KUb1e/ecylvdoWjqK4Psx9JHN1btjTDc=;
        b=nopel/JuZpJ5VQQkI5Isz382hnJa86vPI3XI0u1ahHHeuyFvGgZwOafRms0h4/10xw
         9DHPa/APhaTiWLRZtHeP+K0OYZmRo2Y3CeEmonXq2poDYJ5VoLzPME9C7K2QktuZe8GC
         TT6Cn00dq7wLh00Kp3yQW+v3okFWmd1MiLAcTqof10a1RRSOqWaUazOx7q+q5dlwohKa
         wnh8PvCsxus5kcEfW1JkFSeLEHtNl+4BD3lWYbTHiC3EM51VEfUfKUBCEB5BGt+JaZYG
         usqnXWKDxy8ahWPR30TU5xkwoHBnwgfSz5mVuJHK/rnmCQqjBuwCct9Vn2GPn60wO+Nt
         s84Q==
X-Gm-Message-State: AOAM530Ndgx0D2RSwYwHsXh9HL1DrC8tOjYPnckLGmeP3a3fBRjPgkqC
        QlTP0ooiZ6eYK7fO0QVAxJQcnklpmr5gyfmOdwYfHIn+oPymUSGBlxMAEmDtq5dtTULZH3UvsYN
        YjvWH2BQdSKg/y3Uuy6ljivrS
X-Received: by 2002:a05:600c:b4e:: with SMTP id k14mr251919wmr.139.1630512803550;
        Wed, 01 Sep 2021 09:13:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyO4LkyCGLZr018Y/LoACRfCBfu0mckb3LIj0CvAOTwgWxvrwipGnQx7hqOjzn46NjmwWENpw==
X-Received: by 2002:a05:600c:b4e:: with SMTP id k14mr251893wmr.139.1630512803372;
        Wed, 01 Sep 2021 09:13:23 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23f71.dip0.t-ipconnect.de. [79.242.63.113])
        by smtp.gmail.com with ESMTPSA id s205sm21756wme.4.2021.09.01.09.13.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Sep 2021 09:13:22 -0700 (PDT)
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Qi Zheng <zhengqi.arch@bytedance.com>, akpm@linux-foundation.org,
        tglx@linutronix.de, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, kirill.shutemov@linux.intel.com,
        mika.penttila@nextfour.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        songmuchun@bytedance.com
References: <20210819031858.98043-1-zhengqi.arch@bytedance.com>
 <20210819031858.98043-7-zhengqi.arch@bytedance.com>
 <20210901135314.GA1859446@nvidia.com>
 <0c9766c9-6e8b-5445-83dc-9f2b71a76b4f@redhat.com>
 <20210901153247.GJ1721383@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2 6/9] mm: free user PTE page table pages
Message-ID: <7789261d-6a64-c47b-be6c-c9be680e5d33@redhat.com>
Date:   Wed, 1 Sep 2021 18:13:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210901153247.GJ1721383@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.09.21 17:32, Jason Gunthorpe wrote:
> On Wed, Sep 01, 2021 at 03:57:09PM +0200, David Hildenbrand wrote:
>> On 01.09.21 15:53, Jason Gunthorpe wrote:
>>> On Thu, Aug 19, 2021 at 11:18:55AM +0800, Qi Zheng wrote:
>>>
>>>> diff --git a/mm/gup.c b/mm/gup.c
>>>> index 2630ed1bb4f4..30757f3b176c 100644
>>>> +++ b/mm/gup.c
>>>> @@ -500,6 +500,9 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
>>>>    	if (unlikely(pmd_bad(*pmd)))
>>>>    		return no_page_table(vma, flags);
>>>> +	if (!pte_try_get(mm, pmd))
>>>> +		return no_page_table(vma, flags);
>>>> +
>>>>    	ptep = pte_offset_map_lock(mm, pmd, address, &ptl);
>>>
>>> This is not good on a performance path, the pte_try_get() is
>>> locking/locking the same lock that pte_offset_map_lock() is getting.
>>
>> Yes, and we really need patch #8, anything else is just confusing reviewers.
> 
> It is a bit better with patch 8, but it is still not optimal, we don't
> need to do the atomic work at all if the entire ptep is accessed while
> locked. So the above is stil not what I would expect here, even with
> RCU.
> 
> eg I would expect that this kind of change would work first with the
> existing paired acessors, ie
> 
> 	pte = pte_offset_map(pmd, address);
> 	pte_unmap(pte);
> 
> Should handle the refcount under the covers, and same kind of idea for
> the _locked/_unlocked varient.

See my other mail.

> 
> Only places that don't already use that pairing should get modified.
> 
> To do this we have to extend the API so that pte_offset_map() can
> fail, or very cleverly return some kind of global non-present pte page
> (I wonder if the zero page would work?)

I explored both ideas (returning NULL, return a specially prepared page) 
and it didn't work in some cases where we unmap+remap etc.

> 
>>> Also, I don't really understand how this scheme works with
>>> get_user_pages_fast.
>>
>> With the RCU change it in #8 it should work just fine, because RCU
>> synchronize has to wait either until all other CPUs have left the RCU read
>> section, or re-enabled interrupts.
> 
> So at this point in the series fast gup is broken, that does mean the
> series presentation really needs to be reworked. The better
> presentation is to add the API changes, with a
> no-functional-difference implementation, push the new API in well
> split patches to all the consumption sites, then change the API to
> have the new semantics.

Exactly my thoughts.

> 
> RCU and refcount to free the page levels seems like a reasonable
> approach, but I have to say I haven't thought it through fully - are
> all the contexts that have the pte deref safe to do call_rcu?


Very good question. I'd assume so.


-- 
Thanks,

David / dhildenb

