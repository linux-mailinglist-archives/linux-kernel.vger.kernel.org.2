Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E419A364817
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 18:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237761AbhDSQTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 12:19:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57405 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233752AbhDSQTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 12:19:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618849117;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fqJmgeuiMFVLhBvmQoDThETkhKCzy/6fbNKOoBifg+Y=;
        b=NRcYV6ojY6LySCLGkZmWUkVR5bevhvhwA5qG6grUSUYZf1pmLPP3AS7e5v3pAB+zWwSxel
        5ySVZBYq0JHg8zPLqF68NL/J3IadS8a1H++6b+fiOa50VU+wcmSYHOI7+JjZw8ptsyv54c
        9lx27nln9sf6DNxxdqsr5LDLqoBCAGg=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-553-YAeJLw_sMmyzCkYxUjoAnw-1; Mon, 19 Apr 2021 12:18:35 -0400
X-MC-Unique: YAeJLw_sMmyzCkYxUjoAnw-1
Received: by mail-qk1-f199.google.com with SMTP id g184-20020a3784c10000b02902e385de9adaso4604016qkd.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 09:18:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=fqJmgeuiMFVLhBvmQoDThETkhKCzy/6fbNKOoBifg+Y=;
        b=oWnARPmZqr+yWOYCBdBChGNK2XOPhGnTVTccbbJeBuc1zfpujeAelpxAwV6bQLsvsm
         OfsG0c5aD3kM/kBEdziR7unYJDr4rdEeUgi3iEamNOKZoq/R2L9r60Hy91wJcuAeuTCr
         yq2oUsTlwE9/Gw+r47ySSbwy0Ht1YNo+ur0XhATIFXWQ1oWMOclqmuiyQXTySxTnIoKt
         l9c4d9uMNED7BKrzruV/MyfRRw5+4n6NghoV59fVMg0cbUf5L5sqFltpm/rhRsqGse3m
         rEo7eg1TFUm4yENMesiuNlsN19HT9HcpGNhrFpJAVlvWPcwMHKoOR25M9JnYZhhqduVT
         Axyw==
X-Gm-Message-State: AOAM532u0MxNRZI3Ou1O+TbI31YuwhIHb1TomDPLGtA2Ui2gaXgXhkdU
        t5aW3np1GdKlT/lkN1LAU9pr54hI/U6neboCx7vklH8idIQ9wkHFR+6DnGqkiEA9Bja9oJSZYIR
        jPfJlGM8RCINt75QHMckCR1CC
X-Received: by 2002:a37:9cb:: with SMTP id 194mr5491932qkj.4.1618849111634;
        Mon, 19 Apr 2021 09:18:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzJUxsMhOaiewnOvltNqxLcFgDmHVqmxsvQ037G7yq3H/F6qF/yWngPBHq6ZDy4Zx0BKbsUeQ==
X-Received: by 2002:a37:9cb:: with SMTP id 194mr5491908qkj.4.1618849111409;
        Mon, 19 Apr 2021 09:18:31 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id f16sm10296757qkl.25.2021.04.19.09.18.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Apr 2021 09:18:30 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v4 1/5] mm/memcg: Move mod_objcg_state() to memcontrol.c
To:     Johannes Weiner <hannes@cmpxchg.org>
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
Message-ID: <140444ea-14e7-b305-910f-f23fafe45488@redhat.com>
Date:   Mon, 19 Apr 2021 12:18:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <ffb5705e-8629-808d-9d09-0c9c7f509326@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/19/21 11:21 AM, Waiman Long wrote:
> On 4/19/21 11:14 AM, Johannes Weiner wrote:
>> On Sun, Apr 18, 2021 at 08:00:28PM -0400, Waiman Long wrote:
>>> The mod_objcg_state() function is moved from mm/slab.h to 
>>> mm/memcontrol.c
>>> so that further optimization can be done to it in later patches without
>>> exposing unnecessary details to other mm components.
>>>
>>> Signed-off-by: Waiman Long <longman@redhat.com>
>>> ---
>>>   mm/memcontrol.c | 13 +++++++++++++
>>>   mm/slab.h       | 16 ++--------------
>>>   2 files changed, 15 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>>> index e064ac0d850a..dc9032f28f2e 100644
>>> --- a/mm/memcontrol.c
>>> +++ b/mm/memcontrol.c
>>> @@ -3150,6 +3150,19 @@ void __memcg_kmem_uncharge_page(struct page 
>>> *page, int order)
>>>       css_put(&memcg->css);
>>>   }
>>>   +void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data 
>>> *pgdat,
>>> +             enum node_stat_item idx, int nr)
>>> +{
>>> +    struct mem_cgroup *memcg;
>>> +    struct lruvec *lruvec = NULL;
>>> +
>>> +    rcu_read_lock();
>>> +    memcg = obj_cgroup_memcg(objcg);
>>> +    lruvec = mem_cgroup_lruvec(memcg, pgdat);
>>> +    mod_memcg_lruvec_state(lruvec, idx, nr);
>>> +    rcu_read_unlock();
>>> +}
>> It would be more naturally placed next to the others, e.g. below
>> __mod_lruvec_kmem_state().
>>
>> But no deal breaker if there isn't another revision.
>>
>> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
>>
> Yes, there will be another revision by rebasing patch series on the 
> linux-next. I will move the function then. 

OK, it turns out that mod_objcg_state() is only defined if 
CONFIG_MEMCG_KMEM. That was why I put it in the CONFIG_MEMCG_KMEM block 
with the other obj_stock functions. I think I will keep it there.

Thanks,
Longman

