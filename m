Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6998A373124
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 22:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232675AbhEDUDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 16:03:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50409 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232582AbhEDUDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 16:03:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620158538;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VE7sisr51bWaASPhEsNZ/WxzuZMuCTfCXf9ed9Dm2Lw=;
        b=P9bdSKVD92RGMQWbFhkGmorsbIQWIw6CXJ6oF4UirhGOry3Bhv5whxq6bTXVwesnDu9i2Z
        PACBbnB7ZW/ZdfF9Z3P3apCuhZbjZ004W6G4JUvXi9+9aVD39PiVH8Axqb1ABLXppNg9pR
        M4wXUyYZcZcVsQ3K8VvAdTjaxyuSFu4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-_kuK15OsOISvx9jGq1Cwrw-1; Tue, 04 May 2021 16:02:16 -0400
X-MC-Unique: _kuK15OsOISvx9jGq1Cwrw-1
Received: by mail-qk1-f200.google.com with SMTP id p133-20020a37428b0000b02902de31dd8da3so8365267qka.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 13:02:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=VE7sisr51bWaASPhEsNZ/WxzuZMuCTfCXf9ed9Dm2Lw=;
        b=lQl4VQURHzwrNL4h1/8OEKwIGUtn81i9V9c+kADfhXEeky/UwLRwvBBNh7sevzg6iM
         83N5JZtn2a2uW3J/p3nKI3MGdQFrCHSGrzNXwVFPyPwMH+F3IR9Veu/IFPNn1y5CQDUq
         jNhkieteEw29EFFx8TaSSSn9KQFv/3cNH+wL0QxlPVI/LNTGO3qgog25sxIm+mp+Brjn
         fgTHwsdA1iZw4KN2PAYCxz/BNiiJlXL7n1M3nGNb7UwWMin3h7YyYOBvn3haUbvEpOJC
         jmtl6SmTObvtgy6ugGqFFAPRenBjL0ESR5HGuhLgh42mVaH6kx8ZjDjT9rUcK+ZyV/LS
         B+6g==
X-Gm-Message-State: AOAM530l7eIZYiQ0wbVUnRcAHPAE+QGFgoqA6r4ayvh+On8EjoSNxk2c
        q9YsWOV83UhLEEoEfetcUfx96a56XjDh2nV+9xc3aL1KNgLtGdVFfOlTYr6SaHfPKZ1UjpQd6Z6
        yUDhjiH1+l3PjKa0HjvYewnyv
X-Received: by 2002:a37:8906:: with SMTP id l6mr27594724qkd.198.1620158536437;
        Tue, 04 May 2021 13:02:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzew9UQi58ZCeX2QWSS7d98RivIluTCwTthqw1aP/iQD40qJkD8jFbyDdr63EWdkEgiv7Xbpg==
X-Received: by 2002:a37:8906:: with SMTP id l6mr27594691qkd.198.1620158536155;
        Tue, 04 May 2021 13:02:16 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id t6sm2442450qkh.29.2021.05.04.13.02.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 May 2021 13:02:15 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v2 1/2] mm: memcg/slab: Properly set up gfp flags for
 objcg pointer array
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <guro@fb.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>
References: <20210504132350.4693-1-longman@redhat.com>
 <20210504132350.4693-2-longman@redhat.com>
 <CALvZod438=YKZtV0qckoaMkdL1seu5PiLnvPPQyRzA0S60-TpQ@mail.gmail.com>
Message-ID: <267501a0-f416-4058-70d3-e32eeec3d6da@redhat.com>
Date:   Tue, 4 May 2021 16:02:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <CALvZod438=YKZtV0qckoaMkdL1seu5PiLnvPPQyRzA0S60-TpQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/4/21 3:37 PM, Shakeel Butt wrote:
> On Tue, May 4, 2021 at 6:24 AM Waiman Long <longman@redhat.com> wrote:
>> Since the merging of the new slab memory controller in v5.9, the page
>> structure may store a pointer to obj_cgroup pointer array for slab pages.
>> Currently, only the __GFP_ACCOUNT bit is masked off. However, the array
>> is not readily reclaimable and doesn't need to come from the DMA buffer.
>> So those GFP bits should be masked off as well.
>>
>> Do the flag bit clearing at memcg_alloc_page_obj_cgroups() to make sure
>> that it is consistently applied no matter where it is called.
>>
>> Fixes: 286e04b8ed7a ("mm: memcg/slab: allocate obj_cgroups for non-root slab pages")
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   mm/memcontrol.c | 8 ++++++++
>>   mm/slab.h       | 1 -
>>   2 files changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index c100265dc393..5e3b4f23b830 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -2863,6 +2863,13 @@ static struct mem_cgroup *get_mem_cgroup_from_objcg(struct obj_cgroup *objcg)
>>   }
>>
>>   #ifdef CONFIG_MEMCG_KMEM
>> +/*
>> + * The allocated objcg pointers array is not accounted directly.
>> + * Moreover, it should not come from DMA buffer and is not readily
>> + * reclaimable. So those GFP bits should be masked off.
>> + */
>> +#define OBJCGS_CLEAR_MASK      (__GFP_DMA | __GFP_RECLAIMABLE | __GFP_ACCOUNT)
> What about __GFP_DMA32? Does it matter? It seems like DMA32 requests
> go to normal caches.

I included __GFP_DMA32 in my first draft patch. However, __GFP_DMA32 is 
not considered in determining the right kmalloc_type() (patch 2), so I 
took it out to make it consistent. I can certainly add it back.

Cheers,
Longman

