Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D09DD3D9DD5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 08:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234425AbhG2Gsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 02:48:51 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:12330 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234142AbhG2Gst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 02:48:49 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Gb1G84QRmz7y9n;
        Thu, 29 Jul 2021 14:44:00 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 29 Jul 2021 14:48:45 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 29 Jul 2021 14:48:44 +0800
Subject: Re: [PATCH v2] mm/memcg: fix NULL pointer dereference in
 memcg_slab_free_hook()
To:     Wang Hai <wanghai38@huawei.com>, <cl@linux.com>,
        <penberg@kernel.org>, <guro@fb.com>, <rientjes@google.com>,
        <iamjoonsoo.kim@lge.com>, <akpm@linux-foundation.org>,
        <vbabka@suse.cz>, <hannes@cmpxchg.org>, <shakeelb@google.com>,
        <ast@kernel.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20210728145655.274476-1-wanghai38@huawei.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <277efd2a-e2eb-5d45-150b-8885b571eef7@huawei.com>
Date:   Thu, 29 Jul 2021 14:48:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20210728145655.274476-1-wanghai38@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/7/28 22:56, Wang Hai wrote:
> When I use kfree_rcu() to free a large memory allocated by
> kmalloc_node(), the following dump occurs.
>
> BUG: kernel NULL pointer dereference, address: 0000000000000020
> [...]
> Oops: 0000 [#1] SMP
> [...]
> Workqueue: events kfree_rcu_work
> RIP: 0010:__obj_to_index include/linux/slub_def.h:182 [inline]
> RIP: 0010:obj_to_index include/linux/slub_def.h:191 [inline]
> RIP: 0010:memcg_slab_free_hook+0x120/0x260 mm/slab.h:363
> [...]
> Call Trace:
>   kmem_cache_free_bulk+0x58/0x630 mm/slub.c:3293
>   kfree_bulk include/linux/slab.h:413 [inline]
>   kfree_rcu_work+0x1ab/0x200 kernel/rcu/tree.c:3300
>   process_one_work+0x207/0x530 kernel/workqueue.c:2276
>   worker_thread+0x320/0x610 kernel/workqueue.c:2422
>   kthread+0x13d/0x160 kernel/kthread.c:313
>   ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
>
> When kmalloc_node() a large memory, page is allocated, not slab,
> so when freeing memory via kfree_rcu(), this large memory should not
> be used by memcg_slab_free_hook(), because memcg_slab_free_hook() is
> is used for slab.
>
> Using page_objcgs_check() instead of page_objcgs() in
> memcg_slab_free_hook() to fix this bug.
>
> Fixes: 270c6a71460e ("mm: memcontrol/slab: Use helpers to access slab page's memcg_data")
> Signed-off-by: Wang Hai <wanghai38@huawei.com>
Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
> v1->v2: Use page_objcgs_check() to fix this bug
>   mm/slab.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/slab.h b/mm/slab.h
> index 67e06637ff2e..59db4797acd4 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -339,7 +339,7 @@ static inline void memcg_slab_free_hook(struct kmem_cache *s_orig,
>   			continue;
>   
>   		page = virt_to_head_page(p[i]);
> -		objcgs = page_objcgs(page);
> +		objcgs = page_objcgs_check(page);
>   		if (!objcgs)
>   			continue;
>   
