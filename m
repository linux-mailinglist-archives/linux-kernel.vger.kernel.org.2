Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 089483FE167
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 19:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346679AbhIARv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 13:51:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30419 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347118AbhIARuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 13:50:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630518567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wcSS0stjCZ+EufNjuLhGnQ5APuKOPn6/83B2E8zhIVk=;
        b=L35zbBWaTpQyBE30YMm/Y05kdl03eEoJSSs3Xwn3FDOHPQ+xO07zoR7xroWE32r9bEcj1k
        v00Z/1awy+E18gGkS4bI9et19S+8ZZqzwcaIgnC0mPQYcgqOTfJjwoJcx1ihNt9T/hxogl
        0X2sCsivXPSnbGk3z+ymYw6FiJlIViw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-6_99skLmOiWDyQz_0B6Yhw-1; Wed, 01 Sep 2021 13:49:26 -0400
X-MC-Unique: 6_99skLmOiWDyQz_0B6Yhw-1
Received: by mail-wm1-f69.google.com with SMTP id x125-20020a1c3183000000b002e73f079eefso155179wmx.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 10:49:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=wcSS0stjCZ+EufNjuLhGnQ5APuKOPn6/83B2E8zhIVk=;
        b=f/KgdZabdFo/ZDrQ+yL0a4Dt4ZJf32ycOWFGgm4+TuO0o2WmiCBst39RhiNtkSQwFZ
         0jxuRyW4/vKXz1SI6Rwv0nFYvVN8av5HlVczC7uu0EcNY3FzwR47Cydle01yIc6yKgfA
         SatWI2nxPIMuPOTuO1zPP/7LuMB+8BSTxRy5j+D8ftVIm0w+q9FG8yepWVGsB5nPcCbu
         6JNIdyuC2/G5KYszIrND/0zG0WYIjezgbE9h2XA4N47hEpJs/9bfBfXhnMJP5R4DxFOC
         DrirCVUdANN1z8Uipd4Ocr+dhx3GWtAXFbTPDpFXOWvXXJK3k50bYyAhN9s9hvP/Pwif
         tphg==
X-Gm-Message-State: AOAM530RIPhfZGO1NT3RFUaWcA6s7Ck2i5dMAeNTvEzEEGHjJcIIO3fw
        zNPAIFCu9U07tf97Z/wCR5oz6xORbPea5OmXkBBwmAV9NNUy2683qgYBno1Yx0XiVR9NkEXqZfs
        K59lFgDE7HzdnEsB5dASTyWom
X-Received: by 2002:a1c:19c6:: with SMTP id 189mr717979wmz.174.1630518565342;
        Wed, 01 Sep 2021 10:49:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy/NrrsbhKylVigxv7rpdncN0pJ4zbcVXVZJsfupW2ppJ5IrimVhHTvVn8Y5YEQ7YGxyE6BKQ==
X-Received: by 2002:a1c:19c6:: with SMTP id 189mr717962wmz.174.1630518565124;
        Wed, 01 Sep 2021 10:49:25 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23f71.dip0.t-ipconnect.de. [79.242.63.113])
        by smtp.gmail.com with ESMTPSA id q11sm192401wmc.41.2021.09.01.10.49.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Sep 2021 10:49:24 -0700 (PDT)
Subject: Re: [PATCH v2 6/9] mm: free user PTE page table pages
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
 <7789261d-6a64-c47b-be6c-c9be680e5d33@redhat.com>
 <20210901161613.GN1721383@nvidia.com>
 <e8ebb0bb-b268-c43b-6fc1-e5240dc085c9@redhat.com>
 <20210901171039.GO1721383@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <ef7a722d-0bc0-1c68-b11b-9ede073516e0@redhat.com>
Date:   Wed, 1 Sep 2021 19:49:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210901171039.GO1721383@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.09.21 19:10, Jason Gunthorpe wrote:
> On Wed, Sep 01, 2021 at 06:19:03PM +0200, David Hildenbrand wrote:
> 
>>> I wouldn't think it works everywhere, bit it works in a lot of places,
>>> and it is a heck of a lot better than what is proposed here. I'd
>>> rather see the places that can use it be moved, and the few places
>>> that can't be opencoded.
>>
>> Well, I used ptep_get_map_lock() and friends. But hacking directly into
>> ptep_map_lock() and friends wasn't possible due to all the corner cases.
> 
> Sure, I'm not surprised you can't get every single case, but that just
> suggest we need two API families, today's to support the special cases
> and a different one for the other regular simple cases.
> 
> A new function family pte_try_map/_locked() and paired unmap that can
> internally do the recounting and THP trickery and convert the easy
> callsites.
> 
> Very rough counting suggest at least half of the pte_offset_map_lock()
> call sites can trivially use the simpler API.
> 
> The other cases can stay as is and get open coded refcounts, or maybe
> someone will have a better idea once they are more clearly identified.
> 
> But I don't think we should take a performance hit of additional
> atomics in cases like GUP where this is trivially delt with by using a
> better API.

Right, but as I said in the cover letter, we can happily optimize once 
we have the basic infrastructure in place and properly reviewed. Getting 
rid of some unnecessary atomics by introducing additional fancy helpers 
falls under that category.

The performance hit shouldn't exist if this feature is not compiled in.

-- 
Thanks,

David / dhildenb

