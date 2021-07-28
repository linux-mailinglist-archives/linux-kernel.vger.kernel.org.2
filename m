Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C19213D8EEA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 15:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235942AbhG1NXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 09:23:15 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:47410 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233315AbhG1NXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 09:23:14 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 66B701FFC7;
        Wed, 28 Jul 2021 13:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1627478592; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WJzhKiA6oIO7oLr1sdiTWSyxqi+PYk7isJPGsfi89Go=;
        b=BueN44Ims3KQNM4UoedO8pW733T5e1CfQYF/8Bkp666xKg84qoe5vF47ZyKlVW1wT49YME
        zUVwGC7MbD5tDJXwTmloiqXIdv03OakhWUw+eVjXZqX/3Lep9JeHQxKkiMqmLRjPkKSV+C
        W/OPYCWMAcpSdRJE+2+BKjOPUu69usc=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E3AF3A3B8E;
        Wed, 28 Jul 2021 13:23:11 +0000 (UTC)
Date:   Wed, 28 Jul 2021 15:23:11 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Wang Hai <wanghai38@huawei.com>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        hannes@cmpxchg.org, shakeelb@google.com, ast@kernel.org,
        wangkefeng.wang@huawei.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/memcg: fix NULL pointer dereference in
 memcg_slab_free_hook()
Message-ID: <YQFaPwYzzy0UPzNI@dhcp22.suse.cz>
References: <20210728091348.272714-1-wanghai38@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210728091348.272714-1-wanghai38@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 28-07-21 17:13:48, Wang Hai wrote:
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
>  kmem_cache_free_bulk+0x58/0x630 mm/slub.c:3293
>  kfree_bulk include/linux/slab.h:413 [inline]
>  kfree_rcu_work+0x1ab/0x200 kernel/rcu/tree.c:3300
>  process_one_work+0x207/0x530 kernel/workqueue.c:2276
>  worker_thread+0x320/0x610 kernel/workqueue.c:2422
>  kthread+0x13d/0x160 kernel/kthread.c:313
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
> 
> When kmalloc_node() a large memory, page is allocated, not slab,
> so when freeing memory via kfree_rcu(), this large memory should not
> be used by memcg_slab_free_hook(), because memcg_slab_free_hook() is
> is used for slab.
> 
> So in this case, there is no need to do anything with this large
> page in memcg_slab_free_hook(), just skip it.
> 
> Fixes: 270c6a71460e ("mm: memcontrol/slab: Use helpers to access slab page's memcg_data")

Are you sure that this commit is really breaking the code. Unless I have
missed something there shouldn't be any real change wrt. large
allocations here. page_has_obj_cgroups is just a different name for what
what page_objcgs is giving us.

I haven't studied the kfree_rcu part but isn't the problem its use of
kmem_cache_free_bulk or isn't the problem right there in the bulk free?

> Signed-off-by: Wang Hai <wanghai38@huawei.com>
> ---
>  mm/slab.h | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/slab.h b/mm/slab.h
> index 67e06637ff2e..247d3f9c21f7 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -339,15 +339,20 @@ static inline void memcg_slab_free_hook(struct kmem_cache *s_orig,
>  			continue;
>  
>  		page = virt_to_head_page(p[i]);
> +		if (!s_orig) {
> +			if (unlikely(!PageSlab(page))) {
> +				BUG_ON(!PageCompound(page));

BUG_ON is not really a good idea here. Why should we crash the kernel
just because of an unexpected page showing up. Leaking it would be more
appropriate (the same would apply to kfree btw). I would just warn
here. Also don't we need any hookd here.  Looking at kfree path it does
call kfree_hook. Why is that not needed here?

> +				continue;
> +			}
> +			s = page->slab_cache;
> +		} else {
> +			s = s_orig;
> +		}
> +
>  		objcgs = page_objcgs(page);
>  		if (!objcgs)
>  			continue;
>  
> -		if (!s_orig)
> -			s = page->slab_cache;
> -		else
> -			s = s_orig;
> -
>  		off = obj_to_index(s, page, p[i]);
>  		objcg = objcgs[off];
>  		if (!objcg)
> -- 
> 2.17.1

-- 
Michal Hocko
SUSE Labs
