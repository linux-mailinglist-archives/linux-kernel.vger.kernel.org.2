Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC0423648F1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 19:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239748AbhDSRT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 13:19:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33026 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238710AbhDSRTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 13:19:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618852759;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x9OldeANN4a6pkdIYcVnUP/Jno87aqlwEagtGa388Cg=;
        b=IIBHvC9OwnXGApWnBtQpc9SXyHWioxO/s4GCvhRpesCcq724CyowZ3VMGKWW1UZf2AXpGm
        MQQbeQqjK8UH/peKVftkn7XdkFQ4QGR4AcYJINJOHo/DzN2zZqHh/XFi8tEmPETIhaQmF0
        DLr7e9hyOOg9RoZfjWKPkQJNRkjMFQ8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-dfN28B_8Ocq53YAbyY9s_A-1; Mon, 19 Apr 2021 13:19:16 -0400
X-MC-Unique: dfN28B_8Ocq53YAbyY9s_A-1
Received: by mail-qv1-f71.google.com with SMTP id a3-20020a0ce3830000b02901a32a1f457eso6468521qvl.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 10:19:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=x9OldeANN4a6pkdIYcVnUP/Jno87aqlwEagtGa388Cg=;
        b=aTuu2KBvfZ3Zkks+H+MUIbNkGs3M34HKwMY2E9Ovx3ERzaxXRfLCVH/feE51UlRz4o
         sTbAuIwUlHRIjXVMP8L0HhzE1kreSHQku45Llz1C3LQB2GL+L7MDH/UbLt7CcYxQqENi
         5Z0TMHKDNaFKeJCMHHPGyG6q6LLiypn26mdm31xUA4Q1Nf/j1uRgE5l+fGq8/hePQIy1
         TuU2Ts1OmgZHqjqLTHy+XAU+GxW/NzIeg0VpOmS4Fr+0lpxHlRpENMrAtl0q6rve0yQV
         9LiITnJDGII+PwyeCatjHXicUmJjwIp0YdcFmVcE3dbMlfxx2vissIXl5wXrYyKIBcAF
         lzmg==
X-Gm-Message-State: AOAM530IcIvwBsIXEfjo74KGyoXaFmUnZgOz6oCaRlQ7KERTyOkviKoU
        2Rwjmyi/uVIpQWGpBR/E1DW4c9ypA1zWGQsshFONIkFDBLXBqo5El2/lN7ARbaUJM+C76cHhIGN
        3m/N6UfTLaCro8WN8B0GHgKhW
X-Received: by 2002:a05:620a:1202:: with SMTP id u2mr11657527qkj.248.1618852755981;
        Mon, 19 Apr 2021 10:19:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz9b8EgTP3l5q4bSUy95ytyAd5w0lweu9u9pfDmphadF49T09PeZL5Kx54CzS5oQH28K2jBDw==
X-Received: by 2002:a05:620a:1202:: with SMTP id u2mr11657492qkj.248.1618852755746;
        Mon, 19 Apr 2021 10:19:15 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id q67sm10199456qkb.89.2021.04.19.10.19.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Apr 2021 10:19:15 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v4 1/5] mm/memcg: Move mod_objcg_state() to memcontrol.c
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Waiman Long <llong@redhat.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <guro@fb.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>
References: <20210419000032.5432-1-longman@redhat.com>
 <20210419000032.5432-2-longman@redhat.com> <YH2eT+JCII48hX80@cmpxchg.org>
 <ffb5705e-8629-808d-9d09-0c9c7f509326@redhat.com>
 <140444ea-14e7-b305-910f-f23fafe45488@redhat.com>
 <YH26RrMBOxLaMg4l@cmpxchg.org>
Message-ID: <b7c8e209-3311-609b-9b61-5602a89a8313@redhat.com>
Date:   Mon, 19 Apr 2021 13:19:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <YH26RrMBOxLaMg4l@cmpxchg.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/19/21 1:13 PM, Johannes Weiner wrote:
> On Mon, Apr 19, 2021 at 12:18:29PM -0400, Waiman Long wrote:
>> On 4/19/21 11:21 AM, Waiman Long wrote:
>>> On 4/19/21 11:14 AM, Johannes Weiner wrote:
>>>> On Sun, Apr 18, 2021 at 08:00:28PM -0400, Waiman Long wrote:
>>>>> The mod_objcg_state() function is moved from mm/slab.h to
>>>>> mm/memcontrol.c
>>>>> so that further optimization can be done to it in later patches without
>>>>> exposing unnecessary details to other mm components.
>>>>>
>>>>> Signed-off-by: Waiman Long <longman@redhat.com>
>>>>> ---
>>>>>    mm/memcontrol.c | 13 +++++++++++++
>>>>>    mm/slab.h       | 16 ++--------------
>>>>>    2 files changed, 15 insertions(+), 14 deletions(-)
>>>>>
>>>>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>>>>> index e064ac0d850a..dc9032f28f2e 100644
>>>>> --- a/mm/memcontrol.c
>>>>> +++ b/mm/memcontrol.c
>>>>> @@ -3150,6 +3150,19 @@ void __memcg_kmem_uncharge_page(struct
>>>>> page *page, int order)
>>>>>        css_put(&memcg->css);
>>>>>    }
>>>>>    +void mod_objcg_state(struct obj_cgroup *objcg, struct
>>>>> pglist_data *pgdat,
>>>>> +             enum node_stat_item idx, int nr)
>>>>> +{
>>>>> +    struct mem_cgroup *memcg;
>>>>> +    struct lruvec *lruvec = NULL;
>>>>> +
>>>>> +    rcu_read_lock();
>>>>> +    memcg = obj_cgroup_memcg(objcg);
>>>>> +    lruvec = mem_cgroup_lruvec(memcg, pgdat);
>>>>> +    mod_memcg_lruvec_state(lruvec, idx, nr);
>>>>> +    rcu_read_unlock();
>>>>> +}
>>>> It would be more naturally placed next to the others, e.g. below
>>>> __mod_lruvec_kmem_state().
>>>>
>>>> But no deal breaker if there isn't another revision.
>>>>
>>>> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
>>>>
>>> Yes, there will be another revision by rebasing patch series on the
>>> linux-next. I will move the function then.
>> OK, it turns out that mod_objcg_state() is only defined if
>> CONFIG_MEMCG_KMEM. That was why I put it in the CONFIG_MEMCG_KMEM block with
>> the other obj_stock functions. I think I will keep it there.
> The CONFIG_MEMCG_KMEM has become sort of useless now. It used to be
> configurable, but now it just means CONFIG_MEMCG && !CONFIG_SLOB. And
> even that doesn't make sense because while slob doesn't support slab
> object tracking, we can still do all the other stuff we do under
> KMEM. I have a patch in the works to remove the symbol and ifdefs.
>
> With that in mind, it's better to group the functions based on what
> they do rather than based on CONFIG_MEMCG_KMEM. It's easier to just
> remove another ifdef later than it is to reorder the functions.
>
OK, I will make the move then. Thanks for the explanation.

Cheers,
Longman

