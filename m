Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44DA93D90BD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 16:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236821AbhG1OeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 10:34:03 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:7884 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236686AbhG1OeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 10:34:03 -0400
Received: from dggeme766-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GZbfW1sgTz813j;
        Wed, 28 Jul 2021 22:30:11 +0800 (CST)
Received: from [10.174.176.245] (10.174.176.245) by
 dggeme766-chm.china.huawei.com (10.3.19.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Wed, 28 Jul 2021 22:33:56 +0800
Subject: Re: [PATCH] mm/memcg: fix NULL pointer dereference in
 memcg_slab_free_hook()
To:     Shakeel Butt <shakeelb@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
CC:     Michal Hocko <mhocko@suse.com>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20210728091348.272714-1-wanghai38@huawei.com>
 <YQFaPwYzzy0UPzNI@dhcp22.suse.cz>
 <e9ad7775-2df2-fdb3-cfa9-6c1c265142f5@huawei.com>
 <CALvZod7a36w7Hht4yrozTMx4gdNxZ7mzi+MeaD-yuv69rxYY7Q@mail.gmail.com>
From:   "wanghai (M)" <wanghai38@huawei.com>
Message-ID: <aced9cfe-2ae4-b717-62f5-e495ca4934c2@huawei.com>
Date:   Wed, 28 Jul 2021 22:33:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CALvZod7a36w7Hht4yrozTMx4gdNxZ7mzi+MeaD-yuv69rxYY7Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.245]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggeme766-chm.china.huawei.com (10.3.19.112)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/7/28 22:26, Shakeel Butt 写道:
> On Wed, Jul 28, 2021 at 7:21 AM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>>
>> On 2021/7/28 21:23, Michal Hocko wrote:
>>> On Wed 28-07-21 17:13:48, Wang Hai wrote:
>>>> When I use kfree_rcu() to free a large memory allocated by
>>>> kmalloc_node(), the following dump occurs.
>>>>
>>>> BUG: kernel NULL pointer dereference, address: 0000000000000020
>>>> [...]
>>>> Oops: 0000 [#1] SMP
>>>> [...]
>>>> Workqueue: events kfree_rcu_work
>>>> RIP: 0010:__obj_to_index include/linux/slub_def.h:182 [inline]
>>>> RIP: 0010:obj_to_index include/linux/slub_def.h:191 [inline]
>>>> RIP: 0010:memcg_slab_free_hook+0x120/0x260 mm/slab.h:363
>>>> [...]
>>>> Call Trace:
>>>>    kmem_cache_free_bulk+0x58/0x630 mm/slub.c:3293
>>>>    kfree_bulk include/linux/slab.h:413 [inline]
>>>>    kfree_rcu_work+0x1ab/0x200 kernel/rcu/tree.c:3300
>>>>    process_one_work+0x207/0x530 kernel/workqueue.c:2276
>>>>    worker_thread+0x320/0x610 kernel/workqueue.c:2422
>>>>    kthread+0x13d/0x160 kernel/kthread.c:313
>>>>    ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
>>>>
>>>> When kmalloc_node() a large memory, page is allocated, not slab,
>>>> so when freeing memory via kfree_rcu(), this large memory should not
>>>> be used by memcg_slab_free_hook(), because memcg_slab_free_hook() is
>>>> is used for slab.
>>>>
>>>> So in this case, there is no need to do anything with this large
>>>> page in memcg_slab_free_hook(), just skip it.
>>>>
>>>> Fixes: 270c6a71460e ("mm: memcontrol/slab: Use helpers to access slab page's memcg_data")
>>> Are you sure that this commit is really breaking the code. Unless I have
>> Yes, we confirmed that this commit introduces the bug.
>>> missed something there shouldn't be any real change wrt. large
>>> allocations here. page_has_obj_cgroups is just a different name for what
>>> what page_objcgs is giving us.
>> maybe we could simply use page_objcgs_check to fix the issue ? we will
>> check it again.
> You will see the same crash with page_objcgs_check as well.
> .

I just test it. It won't crash.

This is the test case:

node = kmalloc_node(299999, GFP_ATOMIC | __GFP_NOWARN | __GFP_ACCOUNT, -1);
kfree_rcu(node, rcu);

