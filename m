Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0863541F658
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 22:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355355AbhJAUf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 16:35:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53387 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230032AbhJAUf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 16:35:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633120452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YyOwgV/Jf4YIPqbyFfxrS4OFgtbN1vjUsbHPDDzmHEg=;
        b=BtJTGMmKr3NI2CxhL3rDsnw4Y7qPNQOlF5OgB4qljxhh7Ice8eejflr/9ho5skMI4cAReF
        DQqzG7MObSqKLYQgZtegWm+ViIgN+NWmJHJ1pff/0Jzhx66vY31RGE1GOcUpQI6JEDoxLV
        Lp+iJhJGiGdSKCVruqLvwXBfNSm5XmI=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-jvnWAW-EO3md5kMZLLChJQ-1; Fri, 01 Oct 2021 16:34:11 -0400
X-MC-Unique: jvnWAW-EO3md5kMZLLChJQ-1
Received: by mail-qv1-f71.google.com with SMTP id ey7-20020a0562140b6700b00382cf3eb480so616715qvb.22
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 13:34:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=YyOwgV/Jf4YIPqbyFfxrS4OFgtbN1vjUsbHPDDzmHEg=;
        b=ZFpCSZqcGG+NGX26TGRZv6KgBXMXRkUCzoeU35aw608XMOFwGCfWnLMpEb+hWvjwW/
         dIv4lz6r3tiNneCC5QdFwROvm4yUtuBqPe19WVgQXvxiyZEJLJe7OApUpG4QKKN3oRbZ
         Arut4JS7GPwXG7mgmVyR5bl0dozdbzAAwlr7KhvRsERrIT5aYM3YQqtcNBR/Ux8wa0qi
         S47ivWh8UibFV/1RwDvEfFb2HSC/FDTagUf1D3KQupCYBjSWbNcrAL3sINKN1r+/U/wk
         EdnbSM0SuUQhZR3lFrnAjm5QuPC2eLwykriCUIX5TQHpXohPJDEHz8rzsyMPF8N3MHj8
         C0HA==
X-Gm-Message-State: AOAM531S+/D3MMtwaDOvXr/PajluaU3J2gHzzg8oMwRSmaYwO6bnlFln
        8A2sshmoBPcoN/n1sFaujPBCMOJvkvN8rK0gpcgvU3HMlE11GCZbohkCNh/OxbVGvzXoofECXQF
        3RGiExNg/+xdJGC6YeY89wlrr
X-Received: by 2002:ac8:5c8e:: with SMTP id r14mr15028000qta.37.1633120450918;
        Fri, 01 Oct 2021 13:34:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyDD9hNOk0rk39lRFkGCjkjL+S9d5g9nP9rQ0xw8Iw+1OZHh+vYchf+diRksLZf2c+MhpclaQ==
X-Received: by 2002:ac8:5c8e:: with SMTP id r14mr15027984qta.37.1633120450666;
        Fri, 01 Oct 2021 13:34:10 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id a22sm4469187qtx.7.2021.10.01.13.34.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Oct 2021 13:34:10 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 3/3] mm, memcg: Ensure valid memcg from objcg within a RCU
 critical section
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <guro@fb.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Muchun Song <songmuchun@bytedance.com>
References: <20211001190938.14050-1-longman@redhat.com>
 <20211001190938.14050-4-longman@redhat.com>
 <CALvZod42VDSMy4E47snF-8yToSkt7no1h=KnYmQnH2dz2CDPLQ@mail.gmail.com>
Message-ID: <1d1dd020-e86e-8478-5fea-0e4a97100667@redhat.com>
Date:   Fri, 1 Oct 2021 16:34:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CALvZod42VDSMy4E47snF-8yToSkt7no1h=KnYmQnH2dz2CDPLQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/1/21 4:24 PM, Shakeel Butt wrote:
> On Fri, Oct 1, 2021 at 12:10 PM Waiman Long <longman@redhat.com> wrote:
>> To ensure that a to-be-offlined memcg fetched from objcg remains
>> valid (has non-zero reference count) within a RCU critical section,
>> a synchronize_rcu() call is inserted at the end of memcg_offline_kmem().
>>
>> With that change, we no longer need to use css_tryget()
>> in get_mem_cgroup_from_objcg() as the final css_put() in
>> css_killed_work_fn() would not have been called yet.
>>
>> The obj_cgroup_uncharge_pages() function is simplifed to perform
>> the whole uncharge operation within a RCU critical section saving a
>> css_get()/css_put() pair.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   mm/memcontrol.c | 16 +++++++++++-----
>>   1 file changed, 11 insertions(+), 5 deletions(-)
>>
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index 8177f253a127..1dbb37d96e49 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -2769,10 +2769,8 @@ static struct mem_cgroup *get_mem_cgroup_from_objcg(struct obj_cgroup *objcg)
>>          struct mem_cgroup *memcg;
>>
>>          rcu_read_lock();
>> -retry:
>>          memcg = obj_cgroup_memcg(objcg);
>> -       if (unlikely(!css_tryget(&memcg->css)))
>> -               goto retry;
>> +       css_get(&memcg->css);
>>          rcu_read_unlock();
>>
>>          return memcg;
>> @@ -2947,13 +2945,14 @@ static void obj_cgroup_uncharge_pages(struct obj_cgroup *objcg,
>>   {
>>          struct mem_cgroup *memcg;
>>
>> -       memcg = get_mem_cgroup_from_objcg(objcg);
>> +       rcu_read_lock();
>> +       memcg = obj_cgroup_memcg(objcg);
>>
>>          if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
>>                  page_counter_uncharge(&memcg->kmem, nr_pages);
>>          refill_stock(memcg, nr_pages);
>>
>> -       css_put(&memcg->css);
>> +       rcu_read_unlock();
>>   }
>>
>>   /*
>> @@ -3672,6 +3671,13 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
>>          memcg_drain_all_list_lrus(kmemcg_id, parent);
>>
>>          memcg_free_cache_id(kmemcg_id);
>> +
>> +       /*
>> +        * To ensure that a to-be-offlined memcg fetched from objcg remains
>> +        * valid within a RCU critical section, we need to wait here until
>> +        * the a grace period has elapsed.
>> +        */
>> +       synchronize_rcu();
> This is called with cgroup_mutex held from css_offline path and
> synchronize_rcu() can be very expensive on a busy system, so, this
> will indirectly impact all the code paths which take cgroup_mutex.
>
Yes, you are right. Just don't consider this patch for the time being. I 
will need to find a way to work around that.

Thanks,
Longman

