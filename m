Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8BA44232C0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 23:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236580AbhJEVUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 17:20:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:42756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236042AbhJEVUY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 17:20:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1116C61159;
        Tue,  5 Oct 2021 21:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1633468713;
        bh=Q6enXg4bysVMT9olwJ7KUXyPIz0nbbHdJJJglJELuyg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2G6uyDBi6sLSKrs+sYErDvwM9fF1TEpnAxLApQBBQQ+ni+IOf/pBvpefh9eBgJjtG
         xbncFN0EolZcTVSAJGSXLShpdHgEKjtCwp1hIszOByK+bVn6uFSkEKfHWtTOSxdE57
         yfYm3iG28bW99wjzCb2jAlmEaY+HXFIO7QOFkg/Q=
Date:   Tue, 5 Oct 2021 14:18:32 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH] mm: don't call should_failslab() for !CONFIG_FAILSLAB
Message-Id: <20211005141832.d6f3d4e06c4ad7a06cd554dd@linux-foundation.org>
In-Reply-To: <e01e5e40-692a-519c-4cba-e3331f173c82@kernel.dk>
References: <e01e5e40-692a-519c-4cba-e3331f173c82@kernel.dk>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Oct 2021 09:31:43 -0600 Jens Axboe <axboe@kernel.dk> wrote:

> Allocations can be a very hot path, and this out-of-line function
> call is noticeable.
> 
> --- a/include/linux/fault-inject.h
> +++ b/include/linux/fault-inject.h
> @@ -64,8 +64,8 @@ static inline struct dentry *fault_create_debugfs_attr(const char *name,
>  
>  struct kmem_cache;
>  
> -int should_failslab(struct kmem_cache *s, gfp_t gfpflags);
>  #ifdef CONFIG_FAILSLAB
> +int should_failslab(struct kmem_cache *s, gfp_t gfpflags);
>  extern bool __should_failslab(struct kmem_cache *s, gfp_t gfpflags);
>  #else
>  static inline bool __should_failslab(struct kmem_cache *s, gfp_t gfpflags)
> diff --git a/mm/slab.h b/mm/slab.h
> index 58c01a34e5b8..92fd6fe01877 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -491,8 +491,10 @@ static inline struct kmem_cache *slab_pre_alloc_hook(struct kmem_cache *s,
>  
>  	might_alloc(flags);
>  
> +#ifdef CONFIG_FAILSLAB
>  	if (should_failslab(s, flags))
>  		return NULL;
> +#endif

Can we avoid the ifdefs here?

>  
>  	if (!memcg_slab_pre_alloc_hook(s, objcgp, size, flags))
>  		return NULL;
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index ec2bb0beed75..c21bd447f237 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -1323,6 +1323,7 @@ EXPORT_TRACEPOINT_SYMBOL(kmem_cache_alloc_node);
>  EXPORT_TRACEPOINT_SYMBOL(kfree);
>  EXPORT_TRACEPOINT_SYMBOL(kmem_cache_free);
>  
> +#ifdef CONFIG_FAILSLAB
>  int should_failslab(struct kmem_cache *s, gfp_t gfpflags)
>  {
>  	if (__should_failslab(s, gfpflags))
> @@ -1330,3 +1331,4 @@ int should_failslab(struct kmem_cache *s, gfp_t gfpflags)
>  	return 0;
>  }
>  ALLOW_ERROR_INJECTION(should_failslab, ERRNO);
> +#endif

Like,

--- a/include/linux/fault-inject.h~mm-dont-call-should_failslab-for-config_failslab-fix
+++ a/include/linux/fault-inject.h
@@ -68,6 +68,10 @@ struct kmem_cache;
 int should_failslab(struct kmem_cache *s, gfp_t gfpflags);
 extern bool __should_failslab(struct kmem_cache *s, gfp_t gfpflags);
 #else
+static inline int should_failslab(struct kmem_cache *s, gfp_t gfpflags)
+{
+	return 0;
+}
 static inline bool __should_failslab(struct kmem_cache *s, gfp_t gfpflags)
 {
 	return false;
--- a/mm/slab.h~mm-dont-call-should_failslab-for-config_failslab-fix
+++ a/mm/slab.h
@@ -491,10 +491,8 @@ static inline struct kmem_cache *slab_pr
 
 	might_alloc(flags);
 
-#ifdef CONFIG_FAILSLAB
 	if (should_failslab(s, flags))
 		return NULL;
-#endif
 
 	if (!memcg_slab_pre_alloc_hook(s, objcgp, size, flags))
 		return NULL;
_

