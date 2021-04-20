Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E92DE366008
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 21:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233689AbhDTTJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 15:09:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21839 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233541AbhDTTJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 15:09:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618945752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ADqf//8Mzh80P94odXSMaff1QLcxK4pUkpeVBlMf/kw=;
        b=WysXm/9f0aeGVTfFbauL5BgspuGT3dyb44SkU/Mv1wQeJGVXCCNun1YQlJTsAtN11ZUh8I
        2vKkYGFbK/Wh1cF2h4L1HxP6+K4Hn5zn42WKmGAi7Yrw821EuEaySpCXVaLtXV2BNuUbxx
        5xN+yYAic52kMA63utfuD1n37mK64+k=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-sNBeK8BhM1eRm0hfZU7PYw-1; Tue, 20 Apr 2021 15:09:05 -0400
X-MC-Unique: sNBeK8BhM1eRm0hfZU7PYw-1
Received: by mail-qk1-f199.google.com with SMTP id e4-20020a37b5040000b02902df9a0070efso7930768qkf.18
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 12:09:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ADqf//8Mzh80P94odXSMaff1QLcxK4pUkpeVBlMf/kw=;
        b=GqlFssx+6PJBUunubxzu8jYTy0kQpdTS0BTgcanhl3aQ2uoKte2PRDK4zgQdC4XPvU
         Jyaa3Vo2haB4vNd4QvBh3biCuvJiTCXAyrUu+QAXPgDssXxEDRIRA+UI7w4Y9mt31TsL
         7MIWUgaLkngBjMGDrdAXTI05nnQISv4E2mX2blV8QRTRBnZZl/eD7q1TFigLZjltasGG
         En4O3nWJMsSwiveb0CjHfPQ3/zcmyRZqzDdJiwOPlOj0Els8vRHzdqn3VEHtEmlQ1PnE
         K2yUuvT12DPGivRI8GAgM5xz2zoqWqYdWwe5cLsTXaJs5T9Yw7pMYkalOYd7kWhQDR2y
         4xvQ==
X-Gm-Message-State: AOAM5339nKYnqw08pGAkrAfgvr4JSHxqV1IyZD0ATiFooVNTfOT0HjAD
        o4j27fSNM0OSsh4z8pqT2sqXcFmY0otkgfYhabLSSBUtn314hA3RIFT4awEqDuUzUTGP1QsNe+i
        gtFOQNL4ooYw0aFjUIJx5mkO3
X-Received: by 2002:a37:9586:: with SMTP id x128mr18596288qkd.61.1618945744530;
        Tue, 20 Apr 2021 12:09:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwCgyJTAXtU75ZtsvsaHDCgL3huwabplSfyYMhmJMHY2x0E7jTHUedXNA4KApy+WW0YuNx3xQ==
X-Received: by 2002:a37:9586:: with SMTP id x128mr18596260qkd.61.1618945744221;
        Tue, 20 Apr 2021 12:09:04 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id r5sm11751930qtp.75.2021.04.20.12.09.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Apr 2021 12:09:03 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v4 4/5] mm/memcg: Save both reclaimable & unreclaimable
 bytes in object stock
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
 <20210419000032.5432-5-longman@redhat.com> <YH216/wnyEOcxATl@cmpxchg.org>
Message-ID: <73992e36-376f-b7d3-dde5-d287c7696e72@redhat.com>
Date:   Tue, 20 Apr 2021 15:09:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <YH216/wnyEOcxATl@cmpxchg.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/19/21 12:55 PM, Johannes Weiner wrote:
> On Sun, Apr 18, 2021 at 08:00:31PM -0400, Waiman Long wrote:
>> Currently, the object stock structure caches either reclaimable vmstat
>> bytes or unreclaimable vmstat bytes in its object stock structure. The
>> hit rate can be improved if both types of vmstat data can be cached
>> especially for single-node system.
>>
>> This patch supports the cacheing of both type of vmstat data, though
>> at the expense of a slightly increased complexity in the caching code.
>> For large object (>= PAGE_SIZE), vmstat array is done directly without
>> going through the stock caching step.
>>
>> On a 2-socket Cascade Lake server with instrumentation enabled, the
>> miss rates are shown in the table below.
>>
>>    Initial bootup:
>>
>>    Kernel       __mod_objcg_state    mod_objcg_state    %age
>>    ------       -----------------    ---------------    ----
>>    Before patch      634400              3243830        19.6%
>>    After patch       419810              3182424        13.2%
>>
>>    Parallel kernel build:
>>
>>    Kernel       __mod_objcg_state    mod_objcg_state    %age
>>    ------       -----------------    ---------------    ----
>>    Before patch      24329265           142512465       17.1%
>>    After patch       24051721           142445825       16.9%
>>
>> There was a decrease of miss rate after initial system bootup. However,
>> the miss rate for parallel kernel build remained about the same probably
>> because most of the touched kmemcache objects were reclaimable inodes
>> and dentries.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   mm/memcontrol.c | 79 +++++++++++++++++++++++++++++++------------------
>>   1 file changed, 51 insertions(+), 28 deletions(-)
>>
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index c13502eab282..a6dd18f6d8a8 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -2212,8 +2212,8 @@ struct obj_stock {
>>   	struct obj_cgroup *cached_objcg;
>>   	struct pglist_data *cached_pgdat;
>>   	unsigned int nr_bytes;
>> -	int vmstat_idx;
>> -	int vmstat_bytes;
>> +	int reclaimable_bytes;		/* NR_SLAB_RECLAIMABLE_B */
>> +	int unreclaimable_bytes;	/* NR_SLAB_UNRECLAIMABLE_B */
> How about
>
> 	int nr_slab_reclaimable_b;
> 	int nr_slab_unreclaimable_b;
>
> so you don't need the comments?

Sure, will make the change.


>>   #else
>>   	int dummy[0];
>>   #endif
>> @@ -3217,40 +3217,56 @@ void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
>>   		     enum node_stat_item idx, int nr)
>>   {
>>   	unsigned long flags;
>> -	struct obj_stock *stock = get_obj_stock(&flags);
>> +	struct obj_stock *stock;
>> +	int *bytes, *alt_bytes, alt_idx;
>> +
>> +	/*
>> +	 * Directly update vmstat array for big object.
>> +	 */
>> +	if (unlikely(abs(nr) >= PAGE_SIZE))
>> +		goto update_vmstat;
> This looks like an optimization independent of the vmstat item split?
It may not be that helpful. I am going to take it out in the next version.
>
>> +	stock = get_obj_stock(&flags);
>> +	if (idx == NR_SLAB_RECLAIMABLE_B) {
>> +		bytes = &stock->reclaimable_bytes;
>> +		alt_bytes = &stock->unreclaimable_bytes;
>> +		alt_idx = NR_SLAB_UNRECLAIMABLE_B;
>> +	} else {
>> +		bytes = &stock->unreclaimable_bytes;
>> +		alt_bytes = &stock->reclaimable_bytes;
>> +		alt_idx = NR_SLAB_RECLAIMABLE_B;
>> +	}
>>   
>>   	/*
>> -	 * Save vmstat data in stock and skip vmstat array update unless
>> -	 * accumulating over a page of vmstat data or when pgdat or idx
>> +	 * Try to save vmstat data in stock and skip vmstat array update
>> +	 * unless accumulating over a page of vmstat data or when pgdat
>>   	 * changes.
>>   	 */
>>   	if (stock->cached_objcg != objcg) {
>>   		/* Output the current data as is */
>> -	} else if (!stock->vmstat_bytes) {
>> -		/* Save the current data */
>> -		stock->vmstat_bytes = nr;
>> -		stock->vmstat_idx = idx;
>> -		stock->cached_pgdat = pgdat;
>> -		nr = 0;
>> -	} else if ((stock->cached_pgdat != pgdat) ||
>> -		   (stock->vmstat_idx != idx)) {
>> -		/* Output the cached data & save the current data */
>> -		swap(nr, stock->vmstat_bytes);
>> -		swap(idx, stock->vmstat_idx);
>> +	} else if (stock->cached_pgdat != pgdat) {
>> +		/* Save the current data and output cached data, if any */
>> +		swap(nr, *bytes);
>>   		swap(pgdat, stock->cached_pgdat);
>> +		if (*alt_bytes) {
>> +			__mod_objcg_state(objcg, pgdat, alt_idx,
>> +					  *alt_bytes);
>> +			*alt_bytes = 0;
>> +		}
> As per the other email, I really don't think optimizing the pgdat
> switch (in a percpu cache) is worth this level of complexity.

I am going to simplify it in the next version.


>
>>   	} else {
>> -		stock->vmstat_bytes += nr;
>> -		if (abs(stock->vmstat_bytes) > PAGE_SIZE) {
>> -			nr = stock->vmstat_bytes;
>> -			stock->vmstat_bytes = 0;
>> +		*bytes += nr;
>> +		if (abs(*bytes) > PAGE_SIZE) {
>> +			nr = *bytes;
>> +			*bytes = 0;
>>   		} else {
>>   			nr = 0;
>>   		}
>>   	}
>> -	if (nr)
>> -		__mod_objcg_state(objcg, pgdat, idx, nr);
>> -
>>   	put_obj_stock(flags);
>> +	if (!nr)
>> +		return;
>> +update_vmstat:
>> +	__mod_objcg_state(objcg, pgdat, idx, nr);
>>   }
>>   
>>   static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
>> @@ -3303,12 +3319,19 @@ static void drain_obj_stock(struct obj_stock *stock)
>>   	/*
>>   	 * Flush the vmstat data in current stock
>>   	 */
>> -	if (stock->vmstat_bytes) {
>> -		__mod_objcg_state(old, stock->cached_pgdat, stock->vmstat_idx,
>> -				  stock->vmstat_bytes);
>> +	if (stock->reclaimable_bytes || stock->unreclaimable_bytes) {
>> +		int bytes;
>> +
>> +		if ((bytes = stock->reclaimable_bytes))
>> +			__mod_objcg_state(old, stock->cached_pgdat,
>> +					  NR_SLAB_RECLAIMABLE_B, bytes);
>> +		if ((bytes = stock->unreclaimable_bytes))
>> +			__mod_objcg_state(old, stock->cached_pgdat,
>> +					  NR_SLAB_UNRECLAIMABLE_B, bytes);
> The int bytes indirection isn't necessary. It's easier to read even
> with the extra lines required to repeat the long stock member names,
> because that is quite a common pattern (if (stuff) frob(stuff)).
OK, I will eliminate the bytes variable.
>
> __mod_objcg_state() also each time does rcu_read_lock() toggling and a
> memcg lookup that could be batched, which I think is further proof
> that it should just be inlined here.
>
I am also thinking that eliminate unnecessary 
rcu_read_lock/rcu_read_unlock may help performance a bit. However, that 
will be done in another patch after I have done more performance 
testing. I am  not going to bother with that in this series.

Cheers,
Longman


