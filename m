Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF7D4359C86
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 13:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233773AbhDILAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 07:00:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:34272 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233670AbhDILAg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 07:00:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9B536B147;
        Fri,  9 Apr 2021 11:00:22 +0000 (UTC)
Subject: Re: [PATCH 1/2] mm/vmscan: add sync_shrinkers function
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     ray.huang@amd.com, daniel@ffwll.ch, akpm@linux-foundation.org
References: <20210409071725.1532-1-christian.koenig@amd.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <462c2a51-4aa8-47ba-1c67-171ca651b016@suse.cz>
Date:   Fri, 9 Apr 2021 13:00:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210409071725.1532-1-christian.koenig@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/9/21 9:17 AM, Christian König wrote:
> To be able to switch to a spinlock and reduce lock contention in the TTM
> shrinker we don't want to hold a mutex while unmapping and freeing pages
> from the pool.

Does using spinlock instead of mutex really reduce lock contention?

> But then we somehow need to prevent a race between (for example) the shrinker
> trying to free pages and hotplug trying to remove the device which those pages
> belong to.
> 
> Taking and releasing the shrinker semaphore on the write side after
> unmapping and freeing all pages should make sure that no shrinker is running in
> paralell any more.

So you explain this in this commit log for adding the function, but then the
next patch just adds a sync_shrinkers() call without any comment. I would expect
there a comment explaining why it's done there - what it protects against, as
it's not an obvious pattern IMHO.

> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>  include/linux/shrinker.h |  1 +
>  mm/vmscan.c              | 10 ++++++++++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
> index 0f80123650e2..6b75dc372fce 100644
> --- a/include/linux/shrinker.h
> +++ b/include/linux/shrinker.h
> @@ -92,4 +92,5 @@ extern void register_shrinker_prepared(struct shrinker *shrinker);
>  extern int register_shrinker(struct shrinker *shrinker);
>  extern void unregister_shrinker(struct shrinker *shrinker);
>  extern void free_prealloced_shrinker(struct shrinker *shrinker);
> +extern void sync_shrinkers(void);
>  #endif
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 562e87cbd7a1..46cd9c215d73 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -408,6 +408,16 @@ void unregister_shrinker(struct shrinker *shrinker)
>  }
>  EXPORT_SYMBOL(unregister_shrinker);
>  
> +/**
> + * sync_shrinker - Wait for all running shrinkers to complete.
> + */
> +void sync_shrinkers(void)
> +{
> +	down_write(&shrinker_rwsem);
> +	up_write(&shrinker_rwsem);
> +}
> +EXPORT_SYMBOL(sync_shrinkers);
> +
>  #define SHRINK_BATCH 128
>  
>  static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
> 

