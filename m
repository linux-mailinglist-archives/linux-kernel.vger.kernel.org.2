Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86623364701
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 17:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240304AbhDSPWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 11:22:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39569 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233733AbhDSPWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 11:22:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618845714;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T04/99zjOhCEQHzWZ92KH2vVjDJkKk+5bJDNm7yYZ9I=;
        b=Yz8t62AEIdCodLz8yVPDhieOP+S0kLKMVRSXA1zM0d+Q3b7wGEhfyaDFEETMcQR2hTIHs6
        U/mk1F911Boygf6/3zENVKNx8K2f+pAQxraiffdnB8obp4mQRvBrU91OR9sd5UtqzifOS0
        LAJZIvSCLLogYiWGxEiOiNMoUmxGo1s=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283--WbYvcD0PZ2qE8tCcljJYA-1; Mon, 19 Apr 2021 11:21:53 -0400
X-MC-Unique: -WbYvcD0PZ2qE8tCcljJYA-1
Received: by mail-qv1-f70.google.com with SMTP id e20-20020ad442b40000b029019aa511c767so9533303qvr.18
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 08:21:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=T04/99zjOhCEQHzWZ92KH2vVjDJkKk+5bJDNm7yYZ9I=;
        b=rwD5aWcvVWcWSYakPEERIGFmYqOrWzmXSyvBUjVvcISvbB/h8xYvOmBh9/DtdguI52
         Qv0za/cb3lGR7OIX0BNprnLinS52d169uCl5l37bKQGpn1oo9Pl/+0MjQ6Fh6ZEj1Ss4
         vABZNlqkO/Vxw4fw7IzdBDqOQjSjmRym8ZBztd0Q/LXHhoaihDQ9vZTyXKDmcBsZCF3G
         ufHt7xFJ9+q8s8gNSYC06AE8TPdvZKbzzzyYMP6Gy9n/TvaHOt2k7UK+99yIkOeUgzN+
         Hi57Wn99hGuNQJvo8v9MB+xRib73BQQ72pT+PPIcqjBqusGf10oYw0aXOjawOQF/89GS
         Xd4Q==
X-Gm-Message-State: AOAM532SameKoXxR53iugmm6bvHVDW/rJP1krf1a1isiyDq5fyc+i7KW
        90p/IPwu2IdH8mEMnd1Xz6oltWIEWwUD6z3npwMZ7n1Jr5o7dqaFYUKh2f3HeWc1J4TpDggsYTk
        281i3FkGGMqDyrUsEZ3lss6VH
X-Received: by 2002:a0c:f514:: with SMTP id j20mr22772788qvm.14.1618845712867;
        Mon, 19 Apr 2021 08:21:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwfcP+m2/yYx0KigHlb0LSENNqOid6KRPq88K9IL3KERZIIwfhDU0/SUnWl4lHGZwVLDt3UYQ==
X-Received: by 2002:a0c:f514:: with SMTP id j20mr22772760qvm.14.1618845712728;
        Mon, 19 Apr 2021 08:21:52 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id n136sm9882372qka.133.2021.04.19.08.21.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Apr 2021 08:21:52 -0700 (PDT)
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
Message-ID: <ffb5705e-8629-808d-9d09-0c9c7f509326@redhat.com>
Date:   Mon, 19 Apr 2021 11:21:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <YH2eT+JCII48hX80@cmpxchg.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/19/21 11:14 AM, Johannes Weiner wrote:
> On Sun, Apr 18, 2021 at 08:00:28PM -0400, Waiman Long wrote:
>> The mod_objcg_state() function is moved from mm/slab.h to mm/memcontrol.c
>> so that further optimization can be done to it in later patches without
>> exposing unnecessary details to other mm components.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   mm/memcontrol.c | 13 +++++++++++++
>>   mm/slab.h       | 16 ++--------------
>>   2 files changed, 15 insertions(+), 14 deletions(-)
>>
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index e064ac0d850a..dc9032f28f2e 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -3150,6 +3150,19 @@ void __memcg_kmem_uncharge_page(struct page *page, int order)
>>   	css_put(&memcg->css);
>>   }
>>   
>> +void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
>> +		     enum node_stat_item idx, int nr)
>> +{
>> +	struct mem_cgroup *memcg;
>> +	struct lruvec *lruvec = NULL;
>> +
>> +	rcu_read_lock();
>> +	memcg = obj_cgroup_memcg(objcg);
>> +	lruvec = mem_cgroup_lruvec(memcg, pgdat);
>> +	mod_memcg_lruvec_state(lruvec, idx, nr);
>> +	rcu_read_unlock();
>> +}
> It would be more naturally placed next to the others, e.g. below
> __mod_lruvec_kmem_state().
>
> But no deal breaker if there isn't another revision.
>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
>
Yes, there will be another revision by rebasing patch series on the 
linux-next. I will move the function then.

Cheers,
Longman

