Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AFCD38FC03
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 09:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbhEYHy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 03:54:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:37416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231640AbhEYHy4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 03:54:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 319E86128B;
        Tue, 25 May 2021 07:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621929205;
        bh=i3iKLnAT/uEav9AIigQ8Y+Badv6xYz6k3RQel47yBkg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l1DU/FaBhz7SMVX3dH4z+eoGUA5ci2yPfij1JkOzkuxeDQvZE6jC+zKrvCARJp2D8
         ZodDjWX/tzNFQ4vCh4BSTy/4Bc31e8pqzF6rv6PoDA8xWcc/1hq82A9qZIRO0kNrH0
         yLv4csKYEX0+Xxoewfz+o35/sTNj5+DZYizoIIZU=
Date:   Tue, 25 May 2021 09:53:23 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Faiyaz Mohammed <faiyazm@codeaurora.org>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        glittao@gmail.com, vinmenon@codeaurora.org
Subject: Re: [PATCH v7] mm: slub: move sysfs slab alloc/free interfaces to
 debugfs
Message-ID: <YKys873HUNp/ZMqV@kroah.com>
References: <1621928285-751-1-git-send-email-faiyazm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1621928285-751-1-git-send-email-faiyazm@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021 at 01:08:05PM +0530, Faiyaz Mohammed wrote:
> alloc_calls and free_calls implementation in sysfs have two issues,
> one is PAGE_SIZE limitiation of sysfs and other is it does not adhere
> to "one value per file" rule.
> 
> To overcome this issues, move the alloc_calls and free_calls implemeation
> to debugfs.
> 
> Rename the alloc_calls/free_calls to alloc_traces/free_traces,
> to be inline with what it does.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Faiyaz Mohammed <faiyazm@codeaurora.org>
> ---
> changes in V7:
>         - Drop the older alloc_calls and free_calls interface.
> changes in v6:
>         - https://lore.kernel.org/linux-mm/1621341949-26762-1-git-send-email-faiyazm@codeaurora.org/
> 
> changes in v5:
>         - https://lore.kernel.org/linux-mm/1620296523-21922-1-git-send-email-faiyazm@codeaurora.org/
> 
> changes in v4:
>         - https://lore.kernel.org/linux-mm/1618583239-18124-1-git-send-email-faiyazm@codeaurora.org/
> 
> changes in v3:
>         - https://lore.kernel.org/linux-mm/1617712064-12264-1-git-send-email-faiyazm@codeaurora.org/
> 
> changes in v2:
>         - https://lore.kernel.org/linux-mm/3ac1d3e6-6207-96ad-16a1-0f5139d8b2b5@codeaurora.org/
> 
> changes in v1:
>         - https://lore.kernel.org/linux-mm/1610443287-23933-1-git-send-email-faiyazm@codeaurora.org/
> 
>  include/linux/slub_def.h |   8 ++
>  mm/slab_common.c         |   9 ++
>  mm/slub.c                | 353 ++++++++++++++++++++++++++++++++++-------------
>  3 files changed, 276 insertions(+), 94 deletions(-)
> 
> diff --git a/include/linux/slub_def.h b/include/linux/slub_def.h
> index dcde82a..b413ebe 100644
> --- a/include/linux/slub_def.h
> +++ b/include/linux/slub_def.h
> @@ -159,6 +159,14 @@ static inline void sysfs_slab_release(struct kmem_cache *s)
>  }
>  #endif
>  
> +#if defined(CONFIG_DEBUG_FS) && defined(CONFIG_SLUB_DEBUG)
> +#define SLAB_SUPPORTS_DEBUGFS
> +void debugfs_slab_release(struct kmem_cache *);
> +#else
> +static inline void debugfs_slab_release(struct kmem_cache *s)
> +{
> +}
> +#endif
>  void object_err(struct kmem_cache *s, struct page *page,
>  		u8 *object, char *reason);
>  
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index a4a5714..873dd79 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -455,6 +455,9 @@ static void slab_caches_to_rcu_destroy_workfn(struct work_struct *work)
>  #else
>  		slab_kmem_cache_release(s);
>  #endif
> +#ifdef SLAB_SUPPORTS_DEBUGFS
> +		debugfs_slab_release(s);
> +#endif

Why do you need these #ifdef if your slub_dev.h file already provides an
"empty" function for this?

>  	}
>  }
>  
> @@ -472,6 +475,9 @@ static int shutdown_cache(struct kmem_cache *s)
>  #ifdef SLAB_SUPPORTS_SYSFS
>  		sysfs_slab_unlink(s);
>  #endif
> +#ifdef SLAB_SUPPORTS_DEBUGFS
> +		debugfs_slab_release(s);
> +#endif

Same here.

>  		list_add_tail(&s->list, &slab_caches_to_rcu_destroy);
>  		schedule_work(&slab_caches_to_rcu_destroy_work);
>  	} else {
> @@ -482,6 +488,9 @@ static int shutdown_cache(struct kmem_cache *s)
>  #else
>  		slab_kmem_cache_release(s);
>  #endif
> +#ifdef SLAB_SUPPORTS_DEBUGFS
> +		debugfs_slab_release(s);
> +#endif

And here.

What is wrong with your .h file that keeps the need for #ifdef in the .c
file?

I thought I've asked about this a number of times in the past, what am I
missing?

thanks,

greg k-h
