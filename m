Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8529E36855D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 18:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238118AbhDVQ7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 12:59:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56273 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236058AbhDVQ7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 12:59:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619110747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tnsoyaxSTba4CLrYhMvvI/m5yaJbsJVCTEUHiT030yM=;
        b=HNowwqmuG0F2CNMCovieT70jDeMFIuCJNNg4FpTxXhOV+gHmAXL5pGNmywYvC+lAj1y5w6
        lmUj4bZr5jWAGyON1e73AYYNWU1nOD51SMOJuSQE/Cc7sDbI23AZUIVmldd2PYjMmqy01I
        UbdhiZbqqN6F3gKdVsluMDjn3uhJkzE=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-1L-sSsr4NKCRc2Wq_VRbOQ-1; Thu, 22 Apr 2021 12:58:55 -0400
X-MC-Unique: 1L-sSsr4NKCRc2Wq_VRbOQ-1
Received: by mail-qv1-f72.google.com with SMTP id f7-20020a0562141d27b029019a6fd0a183so16319241qvd.23
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 09:58:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=tnsoyaxSTba4CLrYhMvvI/m5yaJbsJVCTEUHiT030yM=;
        b=ocBokvm/759hD+m8Hvi77QHK26+7TEPVa79bShX7E0NF39xvf53dUmQAnlGoLN2NfO
         o3zzXlZSb0AUP0qml4vtc2fbYnZk8GqTfz5zW/CT4eDNb8hiPpDvzSm/Wl6KmouTkIdn
         bwl2iec+6PIZBJacuKSgpn3DWdMqaJnXuAHwL9XWZdUZkv1Cw4x7BaQKkrNRUh+ZhLIH
         MOl8eje9+z0deYeJ/zJLVSKhvylc3Lyb1YHVpF1DahGqifhvUTuiB+8u13T2XQOmq+eW
         ydfN10ep6eKkrln28cVWq1W/t+ibIjw1OQjB+KcoRZ57b6z2kyp5AvEuX6B3f23aYZMw
         DvvA==
X-Gm-Message-State: AOAM530q0dwBrT/KuYpVYGkxvQJkiS5v9wdaMxHkBZ9mTgGDzsS3h4zf
        L+kbUzsMVMa/CM1R65LnMqRTXCL/RpmgMKaMZq/DKlqAfBIUSd/3X4UrsEuu6CiOReau/urH4r/
        dIWgQOu1+7SsMIC+WbzvGa5KW
X-Received: by 2002:a05:622a:301:: with SMTP id q1mr4076311qtw.48.1619110735146;
        Thu, 22 Apr 2021 09:58:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyMMDzwOxnCBIZPqNlb6mS4q+6V6Etx8XVFSoCsq4jewANdy6F+FHMw0/YtsCSFKEaj7MWOhg==
X-Received: by 2002:a05:622a:301:: with SMTP id q1mr4076276qtw.48.1619110734839;
        Thu, 22 Apr 2021 09:58:54 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id d68sm2543373qkf.93.2021.04.22.09.58.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Apr 2021 09:58:54 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH-next v5 2/4] mm/memcg: Cache vmstat data in percpu
 memcg_stock_pcp
To:     Roman Gushchin <guro@fb.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>
References: <20210420192907.30880-1-longman@redhat.com>
 <20210420192907.30880-3-longman@redhat.com>
 <YIC1HEKF8SQQdnxa@carbon.dhcp.thefacebook.com>
Message-ID: <ded96eba-8c0c-1822-61b5-de0577b7ebab@redhat.com>
Date:   Thu, 22 Apr 2021 12:58:52 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <YIC1HEKF8SQQdnxa@carbon.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/21/21 7:28 PM, Roman Gushchin wrote:
> On Tue, Apr 20, 2021 at 03:29:05PM -0400, Waiman Long wrote:
>> Before the new slab memory controller with per object byte charging,
>> charging and vmstat data update happen only when new slab pages are
>> allocated or freed. Now they are done with every kmem_cache_alloc()
>> and kmem_cache_free(). This causes additional overhead for workloads
>> that generate a lot of alloc and free calls.
>>
>> The memcg_stock_pcp is used to cache byte charge for a specific
>> obj_cgroup to reduce that overhead. To further reducing it, this patch
>> makes the vmstat data cached in the memcg_stock_pcp structure as well
>> until it accumulates a page size worth of update or when other cached
>> data change. Caching the vmstat data in the per-cpu stock eliminates two
>> writes to non-hot cachelines for memcg specific as well as memcg-lruvecs
>> specific vmstat data by a write to a hot local stock cacheline.
>>
>> On a 2-socket Cascade Lake server with instrumentation enabled and this
>> patch applied, it was found that about 20% (634400 out of 3243830)
>> of the time when mod_objcg_state() is called leads to an actual call
>> to __mod_objcg_state() after initial boot. When doing parallel kernel
>> build, the figure was about 17% (24329265 out of 142512465). So caching
>> the vmstat data reduces the number of calls to __mod_objcg_state()
>> by more than 80%.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> Reviewed-by: Shakeel Butt <shakeelb@google.com>
>> ---
>>   mm/memcontrol.c | 86 +++++++++++++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 83 insertions(+), 3 deletions(-)
>>
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index 7cd7187a017c..292b4783b1a7 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -782,8 +782,9 @@ void __mod_lruvec_kmem_state(void *p, enum node_stat_item idx, int val)
>>   	rcu_read_unlock();
>>   }
>>   
>> -void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
>> -		     enum node_stat_item idx, int nr)
>> +static inline void mod_objcg_mlstate(struct obj_cgroup *objcg,
>> +				     struct pglist_data *pgdat,
>> +				     enum node_stat_item idx, int nr)
>>   {
>>   	struct mem_cgroup *memcg;
>>   	struct lruvec *lruvec;
>> @@ -791,7 +792,7 @@ void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
>>   	rcu_read_lock();
>>   	memcg = obj_cgroup_memcg(objcg);
>>   	lruvec = mem_cgroup_lruvec(memcg, pgdat);
>> -	mod_memcg_lruvec_state(lruvec, idx, nr);
>> +	__mod_memcg_lruvec_state(lruvec, idx, nr);
>>   	rcu_read_unlock();
>>   }
>>   
>> @@ -2059,7 +2060,10 @@ struct memcg_stock_pcp {
>>   
>>   #ifdef CONFIG_MEMCG_KMEM
>>   	struct obj_cgroup *cached_objcg;
>> +	struct pglist_data *cached_pgdat;
> I wonder if we want to have per-node counters instead?
> That would complicate the initialization of pcp stocks a bit,
> but might shave off some additional cpu time.
> But we can do it later too.
>
A per node counter will certainly complicate the code and reduce the 
performance benefit too. I got a pretty good hit rate of 80%+ with the 
current code on a 2-socket system. The hit rate will probably drop when 
there are more nodes. I will do some more investigation, but it will not 
be for this patchset.


>>   	unsigned int nr_bytes;
>> +	int nr_slab_reclaimable_b;
>> +	int nr_slab_unreclaimable_b;
>>   #endif
>>   
>>   	struct work_struct work;
>> @@ -3008,6 +3012,63 @@ void __memcg_kmem_uncharge_page(struct page *page, int order)
>>   	obj_cgroup_put(objcg);
>>   }
>>   
>> +void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
>> +		     enum node_stat_item idx, int nr)
>> +{
>> +	struct memcg_stock_pcp *stock;
>> +	unsigned long flags;
>> +	int *bytes;
>> +
>> +	local_irq_save(flags);
>> +	stock = this_cpu_ptr(&memcg_stock);
>> +
>> +	/*
>> +	 * Save vmstat data in stock and skip vmstat array update unless
>> +	 * accumulating over a page of vmstat data or when pgdat or idx
>> +	 * changes.
>> +	 */
>> +	if (stock->cached_objcg != objcg) {
>> +		drain_obj_stock(stock);
>> +		obj_cgroup_get(objcg);
>> +		stock->nr_bytes = atomic_read(&objcg->nr_charged_bytes)
>> +				? atomic_xchg(&objcg->nr_charged_bytes, 0) : 0;
>> +		stock->cached_objcg = objcg;
>> +		stock->cached_pgdat = pgdat;
>> +	} else if (stock->cached_pgdat != pgdat) {
>> +		/* Flush the existing cached vmstat data */
>> +		if (stock->nr_slab_reclaimable_b) {
>> +			mod_objcg_mlstate(objcg, pgdat, NR_SLAB_RECLAIMABLE_B,
>> +					  stock->nr_slab_reclaimable_b);
>> +			stock->nr_slab_reclaimable_b = 0;
>> +		}
>> +		if (stock->nr_slab_unreclaimable_b) {
>> +			mod_objcg_mlstate(objcg, pgdat, NR_SLAB_UNRECLAIMABLE_B,
>> +					  stock->nr_slab_unreclaimable_b);
>> +			stock->nr_slab_unreclaimable_b = 0;
>> +		}
>> +		stock->cached_pgdat = pgdat;
>> +	}
>> +
>> +	bytes = (idx == NR_SLAB_RECLAIMABLE_B) ? &stock->nr_slab_reclaimable_b
>> +					       : &stock->nr_slab_unreclaimable_b;
>> +	if (!*bytes) {
>> +		*bytes = nr;
>> +		nr = 0;
>> +	} else {
>> +		*bytes += nr;
>> +		if (abs(*bytes) > PAGE_SIZE) {
>> +			nr = *bytes;
>> +			*bytes = 0;
>> +		} else {
>> +			nr = 0;
>> +		}
>> +	}
> This part is a little bit hard to follow, how about something like this
> (completely untested):
>
> {
> 	stocked = (idx == NR_SLAB_RECLAIMABLE_B) ? &stock->nr_slab_reclaimable_b
> 		: &stock->nr_slab_unreclaimable_b;
> 	if (abs(*stocked + nr) > PAGE_SIZE) {
> 		nr += *stocked;
> 		*stocked = 0;
> 	} else {
> 		*stocked += nr;
> 		nr = 0;
> 	}
> }

That was done purposely to make sure that large object (>= 4k) will also 
be cached once before flushing it out. I should have been more clear 
about that by adding a comment about it. vmstat data isn't as critical 
as memory charge and so I am allowing it to cache more than 4k in this case.

Cheers,
Longman

