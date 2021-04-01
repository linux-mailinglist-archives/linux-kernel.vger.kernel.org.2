Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BDB3350D34
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 05:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbhDADif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 23:38:35 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:15424 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbhDADid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 23:38:33 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4F9pl36G4XzjXXJ;
        Thu,  1 Apr 2021 11:36:47 +0800 (CST)
Received: from [10.174.179.86] (10.174.179.86) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Thu, 1 Apr 2021 11:38:26 +0800
Subject: Re: [PATCH] mm: memcontrol: fix forget to obtain the ref to objcg in
 split_page_memcg
To:     Roman Gushchin <guro@fb.com>,
        Muchun Song <songmuchun@bytedance.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <duanxiongchun@bytedance.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <akpm@linux-foundation.org>, <shakeelb@google.com>,
        <vdavydov.dev@gmail.com>
References: <20210401030141.37061-1-songmuchun@bytedance.com>
 <5c183fe6-637f-151c-67f0-fe19a0ce3356@huawei.com>
 <YGU/ZojpKXXK9AnU@carbon.DHCP.thefacebook.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <38903032-6075-954a-31e2-7ab609b4bb2e@huawei.com>
Date:   Thu, 1 Apr 2021 11:38:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YGU/ZojpKXXK9AnU@carbon.DHCP.thefacebook.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.86]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/4/1 11:35, Roman Gushchin wrote:
> On Thu, Apr 01, 2021 at 11:31:16AM +0800, Miaohe Lin wrote:
>> On 2021/4/1 11:01, Muchun Song wrote:
>>> Christian Borntraeger reported a warning about "percpu ref
>>> (obj_cgroup_release) <= 0 (-1) after switching to atomic".
>>> Because we forgot to obtain the reference to the objcg and
>>> wrongly obtain the reference of memcg.
>>>
>>> Reported-by: Christian Borntraeger <borntraeger@de.ibm.com>
>>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>>
>> Thanks for the patch.
>> Is a Fixes tag needed?
> 
> No, as the original patch hasn't been merged into the Linus's tree yet.
> So the fix can be simply squashed.
> 
> Btw, the fix looks good to me.
> 
> Acked-by: Roman Gushchin <guro@fb.com>
> 

I see. Many thanks for explanation!

The code looks good to me.
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

>>
>>> ---
>>>  include/linux/memcontrol.h | 6 ++++++
>>>  mm/memcontrol.c            | 6 +++++-
>>>  2 files changed, 11 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
>>> index 0e8907957227..c960fd49c3e8 100644
>>> --- a/include/linux/memcontrol.h
>>> +++ b/include/linux/memcontrol.h
>>> @@ -804,6 +804,12 @@ static inline void obj_cgroup_get(struct obj_cgroup *objcg)
>>>  	percpu_ref_get(&objcg->refcnt);
>>>  }
>>>  
>>> +static inline void obj_cgroup_get_many(struct obj_cgroup *objcg,
>>> +				       unsigned long nr)
>>> +{
>>> +	percpu_ref_get_many(&objcg->refcnt, nr);
>>> +}
>>> +
>>>  static inline void obj_cgroup_put(struct obj_cgroup *objcg)
>>>  {
>>>  	percpu_ref_put(&objcg->refcnt);
>>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>>> index c0b83a396299..64ada9e650a5 100644
>>> --- a/mm/memcontrol.c
>>> +++ b/mm/memcontrol.c
>>> @@ -3133,7 +3133,11 @@ void split_page_memcg(struct page *head, unsigned int nr)
>>>  
>>>  	for (i = 1; i < nr; i++)
>>>  		head[i].memcg_data = head->memcg_data;
>>> -	css_get_many(&memcg->css, nr - 1);
>>> +
>>> +	if (PageMemcgKmem(head))
>>> +		obj_cgroup_get_many(__page_objcg(head), nr - 1);
>>> +	else
>>> +		css_get_many(&memcg->css, nr - 1);
>>>  }
>>>  
>>>  #ifdef CONFIG_MEMCG_SWAP
>>>
>>
> .
> 

