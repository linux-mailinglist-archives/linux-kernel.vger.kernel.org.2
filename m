Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC9DA3FE9B3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 09:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242608AbhIBHGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 03:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240424AbhIBHGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 03:06:01 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B56AC061757
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 00:05:03 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id z24-20020a17090acb1800b0018e87a24300so806606pjt.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 00:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=HBaL61QBYMUZzotrZtJQEFy+kr+3Pv8VSTjmOd/YXyc=;
        b=gpq0+vByj5ZSakSAjmhB412QEKXYdbHQRt6Wrovgsdv2THWPRdvv7VmHPJny18IvW+
         UL1jW2O4X/utRsV9mUkdSIDkSjQSAanBZ1D2yv9r8aWO1lk5a4v1/IUhviaTUCXodQEH
         M0VoNSQ/S9BxwE7HaYDjf/fxqmYskFlTkyRwXEaLM4hrpTgIXVpavUM7mVUEvdoFgDt9
         XN1AO6niSrcOKJo2Xcp8ituadZv38hO1gg7ZUbIMVvGQC2alXEORX5t2puTz2wmEkFIQ
         UxmW3iWRbxPxbHbSome9N7OF+K4bSIQ8zqa144SZUhifjaFwwIg8+f4GeA2BmK7clJ84
         2bDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=HBaL61QBYMUZzotrZtJQEFy+kr+3Pv8VSTjmOd/YXyc=;
        b=Mcslsl0QnJDRW17yFUESbik9k6aUcIHP+IopbRQfslyk6YYkkgICRx3rO0iltKYeuh
         LrW3844tMW60PUIlcqNgNGpSJENnUDqT3sDuqeg7mNqK9eDvSV/XYTZlteqk7Hi4Jit6
         Vyj12celhCIncEZprtzPJZ1V/bUk5IZam22AdL/5qFAtfXl/9Cwukj7AFBU7sakiOxth
         yzTCqvFY1uOeof2oSLhPG8yFmMHlsh+C7U0UaH/Gd1kgvjjLDmQ9q1Ry4JhdwEFl5xZn
         26rPtpIgOU74m74BqqrL4dwq/GkEEwni22AbiOTMEKpWjXp0j1eXWtMeefAOoCn14CIj
         PdGQ==
X-Gm-Message-State: AOAM5320KT97mkznrC88PjAj8eZWvLalm7xyPdodZSz+j7bu16ZfGkIH
        YyBUFdKjcBbkDtWexPyVohGRPg==
X-Google-Smtp-Source: ABdhPJwpJqPKt9Y7iE8kwSXxa86EER+DXHn4/hF1fRP/w8Fj/bNnbhwN4Ru5ZqkqVVCTzkNLo39/kw==
X-Received: by 2002:a17:90a:d990:: with SMTP id d16mr2305089pjv.2.1630566302822;
        Thu, 02 Sep 2021 00:05:02 -0700 (PDT)
Received: from [10.254.207.253] ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id ev12sm984854pjb.57.2021.09.02.00.04.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Sep 2021 00:05:02 -0700 (PDT)
Subject: Re: [PATCH v2 6/9] mm: free user PTE page table pages
To:     Jason Gunthorpe <jgg@nvidia.com>,
        David Hildenbrand <david@redhat.com>
Cc:     akpm@linux-foundation.org, tglx@linutronix.de, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com,
        kirill.shutemov@linux.intel.com, mika.penttila@nextfour.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, songmuchun@bytedance.com
References: <20210819031858.98043-1-zhengqi.arch@bytedance.com>
 <20210819031858.98043-7-zhengqi.arch@bytedance.com>
 <20210901135314.GA1859446@nvidia.com>
 <0c9766c9-6e8b-5445-83dc-9f2b71a76b4f@redhat.com>
 <20210901153247.GJ1721383@nvidia.com>
 <7789261d-6a64-c47b-be6c-c9be680e5d33@redhat.com>
 <20210901161613.GN1721383@nvidia.com>
 <e8ebb0bb-b268-c43b-6fc1-e5240dc085c9@redhat.com>
 <20210901171039.GO1721383@nvidia.com>
 <ef7a722d-0bc0-1c68-b11b-9ede073516e0@redhat.com>
 <20210901175547.GP1721383@nvidia.com>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
Message-ID: <b013b637-a3d6-9caf-32d4-9c04fac29c64@bytedance.com>
Date:   Thu, 2 Sep 2021 15:04:53 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210901175547.GP1721383@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/9/2 AM1:55, Jason Gunthorpe wrote:
> On Wed, Sep 01, 2021 at 07:49:23PM +0200, David Hildenbrand wrote:
>> On 01.09.21 19:10, Jason Gunthorpe wrote:
>>> On Wed, Sep 01, 2021 at 06:19:03PM +0200, David Hildenbrand wrote:
>>>
>>>>> I wouldn't think it works everywhere, bit it works in a lot of places,
>>>>> and it is a heck of a lot better than what is proposed here. I'd
>>>>> rather see the places that can use it be moved, and the few places
>>>>> that can't be opencoded.
>>>>
>>>> Well, I used ptep_get_map_lock() and friends. But hacking directly into
>>>> ptep_map_lock() and friends wasn't possible due to all the corner cases.
>>>
>>> Sure, I'm not surprised you can't get every single case, but that just
>>> suggest we need two API families, today's to support the special cases
>>> and a different one for the other regular simple cases.
>>>
>>> A new function family pte_try_map/_locked() and paired unmap that can
>>> internally do the recounting and THP trickery and convert the easy
>>> callsites.
>>>
>>> Very rough counting suggest at least half of the pte_offset_map_lock()
>>> call sites can trivially use the simpler API.
>>>
>>> The other cases can stay as is and get open coded refcounts, or maybe
>>> someone will have a better idea once they are more clearly identified.
>>>
>>> But I don't think we should take a performance hit of additional
>>> atomics in cases like GUP where this is trivially delt with by using a
>>> better API.
>>
>> Right, but as I said in the cover letter, we can happily optimize once we
>> have the basic infrastructure in place and properly reviewed. Getting rid of
>> some unnecessary atomics by introducing additional fancy helpers falls under
>> that category.
> 
> I'm not sure I agree given how big and wide this patch series is. It
> would be easier to review if it was touching less places. The helpers
> are not fancy, it is a logical re-arrangement of existing code that
> shrinks the LOC of this series and makes it more reviewable.
> 
> Or stated another way, a niche feature like this try much harder not
> to add more complexity everywhere.

Totally agree, I will rework this patch series based on you and David's
suggestions.

Thank you very much,
Qi

> 
> Jason
> 
