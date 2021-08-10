Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08B173DC2B8
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 04:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236802AbhGaCaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 22:30:02 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:7769 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbhGaCaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 22:30:01 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Gc7P62Cc9zYjb7;
        Sat, 31 Jul 2021 10:23:54 +0800 (CST)
Received: from [10.174.178.209] (10.174.178.209) by
 dggeme703-chm.china.huawei.com (10.1.199.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Sat, 31 Jul 2021 10:29:53 +0800
Subject: Re: [PATCH 2/5] mm, memcg: narrow the scope of percpu_charge_mutex
To:     Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>
CC:     <hannes@cmpxchg.org>, <vdavydov.dev@gmail.com>,
        <akpm@linux-foundation.org>, <shakeelb@google.com>,
        <willy@infradead.org>, <alexs@kernel.org>,
        <richard.weiyang@gmail.com>, <songmuchun@bytedance.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <cgroups@vger.kernel.org>
References: <20210729125755.16871-1-linmiaohe@huawei.com>
 <20210729125755.16871-3-linmiaohe@huawei.com> <YQNsxVPsRSBZcfGG@carbon.lan>
 <YQOhGs3k9rHx3mmT@dhcp22.suse.cz>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <4a3c23c4-054c-2896-29c5-8cf9a4deee98@huawei.com>
Date:   Sat, 31 Jul 2021 10:29:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YQOhGs3k9rHx3mmT@dhcp22.suse.cz>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.209]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggeme703-chm.china.huawei.com (10.1.199.99)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/7/30 14:50, Michal Hocko wrote:
> On Thu 29-07-21 20:06:45, Roman Gushchin wrote:
>> On Thu, Jul 29, 2021 at 08:57:52PM +0800, Miaohe Lin wrote:
>>> Since percpu_charge_mutex is only used inside drain_all_stock(), we can
>>> narrow the scope of percpu_charge_mutex by moving it here.
>>>
>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>>> ---
>>>  mm/memcontrol.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>>> index 6580c2381a3e..a03e24e57cd9 100644
>>> --- a/mm/memcontrol.c
>>> +++ b/mm/memcontrol.c
>>> @@ -2050,7 +2050,6 @@ struct memcg_stock_pcp {
>>>  #define FLUSHING_CACHED_CHARGE	0
>>>  };
>>>  static DEFINE_PER_CPU(struct memcg_stock_pcp, memcg_stock);
>>> -static DEFINE_MUTEX(percpu_charge_mutex);
>>>  
>>>  #ifdef CONFIG_MEMCG_KMEM
>>>  static void drain_obj_stock(struct obj_stock *stock);
>>> @@ -2209,6 +2208,7 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
>>>   */
>>>  static void drain_all_stock(struct mem_cgroup *root_memcg)
>>>  {
>>> +	static DEFINE_MUTEX(percpu_charge_mutex);
>>>  	int cpu, curcpu;
>>
>> It's considered a good practice to protect data instead of code paths. After
>> the proposed change it becomes obvious that the opposite is done here: the mutex
>> is used to prevent a simultaneous execution of the code of the drain_all_stock()
>> function.
> 
> The purpose of the lock was indeed to orchestrate callers more than any
> data structure consistency.
>  
>> Actually we don't need a mutex here: nobody ever sleeps on it. So I'd replace
>> it with a simple atomic variable or even a single bitfield. Then the change will
>> be better justified, IMO.
> 
> Yes, mutex can be replaced by an atomic in a follow up patch.
> 

Thanks for both of you. It's a really good suggestion. What do you mean is something like below？

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 616d1a72ece3..508a96e80980 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2208,11 +2208,11 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
  */
 static void drain_all_stock(struct mem_cgroup *root_memcg)
 {
-       static DEFINE_MUTEX(percpu_charge_mutex);
        int cpu, curcpu;
+       static atomic_t drain_all_stocks = ATOMIC_INIT(-1);

        /* If someone's already draining, avoid adding running more workers. */
-       if (!mutex_trylock(&percpu_charge_mutex))
+       if (!atomic_inc_not_zero(&drain_all_stocks))
                return;
        /*
         * Notify other cpus that system-wide "drain" is running
@@ -2244,7 +2244,7 @@ static void drain_all_stock(struct mem_cgroup *root_memcg)
                }
        }
        put_cpu();
-       mutex_unlock(&percpu_charge_mutex);
+       atomic_dec(&drain_all_stocks);
 }

 static int memcg_hotplug_cpu_dead(unsigned int cpu)
