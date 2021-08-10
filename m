Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6FC83DB14E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 04:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235940AbhG3Cqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 22:46:33 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:12332 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbhG3Cqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 22:46:31 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4GbWr36KL3z80M9;
        Fri, 30 Jul 2021 10:41:39 +0800 (CST)
Received: from [10.174.178.209] (10.174.178.209) by
 dggeme703-chm.china.huawei.com (10.1.199.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 30 Jul 2021 10:46:24 +0800
Subject: Re: [External] Re: [PATCH 5/5] mm, memcg: always call
 __mod_node_page_state() with preempt disabled
To:     Muchun Song <songmuchun@bytedance.com>
CC:     Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alex Shi <alexs@kernel.org>,
        Wei Yang <richard.weiyang@gmail.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>
References: <20210729125755.16871-1-linmiaohe@huawei.com>
 <20210729125755.16871-6-linmiaohe@huawei.com>
 <CALvZod6n1EwcyLTi=Eb8t=NVVPLRh9=Ng=VJ93pQyCRkOcLo9Q@mail.gmail.com>
 <29c4bb2a-ceaf-6c8b-c222-38b30460780f@huawei.com>
 <CAMZfGtUMBZeo-P48MECO=xM9-apeLMAZZGE3VNsg_u5P523BEg@mail.gmail.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <0077ebd3-abef-5763-8f50-7a937734c54b@huawei.com>
Date:   Fri, 30 Jul 2021 10:46:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAMZfGtUMBZeo-P48MECO=xM9-apeLMAZZGE3VNsg_u5P523BEg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.209]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggeme703-chm.china.huawei.com (10.1.199.99)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/7/30 10:33, Muchun Song wrote:
> On Fri, Jul 30, 2021 at 9:52 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
>>
>> On 2021/7/29 22:39, Shakeel Butt wrote:
>>> On Thu, Jul 29, 2021 at 5:58 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
>>>>
>>>> We should always ensure __mod_node_page_state() is called with preempt
>>>> disabled or percpu ops may manipulate the wrong cpu when preempt happened.
>>>>
>>>> Fixes: b4e0b68fbd9d ("mm: memcontrol: use obj_cgroup APIs to charge kmem pages")
>>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>>>> ---
>>>>  mm/memcontrol.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>>>> index 70a32174e7c4..616d1a72ece3 100644
>>>> --- a/mm/memcontrol.c
>>>> +++ b/mm/memcontrol.c
>>>> @@ -697,8 +697,8 @@ void __mod_lruvec_page_state(struct page *page, enum node_stat_item idx,
>>>>         memcg = page_memcg(head);
>>>>         /* Untracked pages have no memcg, no lruvec. Update only the node */
>>>>         if (!memcg) {
>>>> -               rcu_read_unlock();
>>>>                 __mod_node_page_state(pgdat, idx, val);
>>>> +               rcu_read_unlock();
>>>
>>> This rcu is for page_memcg. The preemption and interrupts are disabled
>>> across __mod_lruvec_page_state().
>>>
>>
>> I thought it's used to protect __mod_node_page_state(). Looks somewhat confusing for me.
>> Many thanks for pointing this out!
> 
> Hi Miaohe,
> 
> git show b4e0b68fbd9d can help you find out why we add
> the rcu read lock around it.

Thanks for your tip. That's my overlook when I checked this commit. I should have looked at this
more closely. :(

> 
> Thanks.
> 
>>
>>>>                 return;
>>>>         }
>>>>
>>>> --
>>>> 2.23.0
>>>>
>>> .
>>>
>>
> .
> 

