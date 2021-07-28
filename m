Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5931F3D9364
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 18:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbhG1QoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 12:44:11 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:47370 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbhG1QoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 12:44:07 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 8D3B81FFD7;
        Wed, 28 Jul 2021 16:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1627490644; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v4EOY6ldmDFYdioXhdFcqgF63Zm4Uf4JO8ULF+YwZqE=;
        b=Dt1aZCMOmON0Sr2FeZq8bnbtMMIQcxP+jPEjOTZW/bt05S/l+X3o3vIVkK0yX0xB7P4tGa
        CsUzGY1Q5alN3lAc5H+N5WVu0hoVwQtHbjauWaGatStK9d1BtIiV9t4KLTYqPvfWD5sCLQ
        vMN/sqi8JsuFT7rc0yd2g+1SAu9HGME=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 567C0A3B8B;
        Wed, 28 Jul 2021 16:44:04 +0000 (UTC)
Date:   Wed, 28 Jul 2021 18:44:03 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Wang Hai <wanghai38@huawei.com>
Cc:     cl@linux.com, penberg@kernel.org, guro@fb.com, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        hannes@cmpxchg.org, shakeelb@google.com, ast@kernel.org,
        wangkefeng.wang@huawei.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/memcg: fix NULL pointer dereference in
 memcg_slab_free_hook()
Message-ID: <YQGJUz9kKfYR37ce@dhcp22.suse.cz>
References: <20210728145655.274476-1-wanghai38@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210728145655.274476-1-wanghai38@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 28-07-21 22:56:55, Wang Hai wrote:
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
> Using page_objcgs_check() instead of page_objcgs() in
> memcg_slab_free_hook() to fix this bug.
> 
> Fixes: 270c6a71460e ("mm: memcontrol/slab: Use helpers to access slab page's memcg_data")
> Signed-off-by: Wang Hai <wanghai38@huawei.com>

This looks like a much better fix. Thanks!

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
> v1->v2: Use page_objcgs_check() to fix this bug
>  mm/slab.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/slab.h b/mm/slab.h
> index 67e06637ff2e..59db4797acd4 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -339,7 +339,7 @@ static inline void memcg_slab_free_hook(struct kmem_cache *s_orig,
>  			continue;
>  
>  		page = virt_to_head_page(p[i]);
> -		objcgs = page_objcgs(page);
> +		objcgs = page_objcgs_check(page);
>  		if (!objcgs)
>  			continue;
>  
> -- 
> 2.17.1

-- 
Michal Hocko
SUSE Labs
