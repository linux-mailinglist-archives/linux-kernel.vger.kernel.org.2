Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB3245387C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 18:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238764AbhKPRaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 12:30:20 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:54574 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238746AbhKPRaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 12:30:20 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2F67C1FD33;
        Tue, 16 Nov 2021 17:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637083642; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GVNWcGse0qDkmGgCird4qZLuxFgYfISBGCUtscZ9EN8=;
        b=bIhgJ5MONGk6Agtl/SZ/UgCZ0bBcAYpq5d5lbzFCIVZgVVNdA9D7zfczAMWeWktd3OMhc4
        pl6XcQzsFYMLeeO9OtUuFHRR1H3Lx7w0bVSF/Ta5yHOUT7Zs4BpClChhyrb4b21cSrqb3E
        HfEuU0Xn92GjRNan9VDn7BQNoxLiRJM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637083642;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GVNWcGse0qDkmGgCird4qZLuxFgYfISBGCUtscZ9EN8=;
        b=Hu8VOyAh+Wn6Ej05XTdbP8sjQ6UguJ00bb766o6agFlS8Tz0jezrTzjGY5oFCYAXf2bArv
        86VrmE0wOjsYmXAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1359013C3C;
        Tue, 16 Nov 2021 17:27:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RJLiA/rpk2GbZwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 16 Nov 2021 17:27:22 +0000
Message-ID: <206e47d2-64da-babe-17d1-da846fbba959@suse.cz>
Date:   Tue, 16 Nov 2021 18:27:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH] mm: memcontrol: make cgroup_memory_nokmem static
Content-Language: en-US
To:     Muchun Song <songmuchun@bytedance.com>, akpm@linux-foundation.org,
        hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20211109065418.21693-1-songmuchun@bytedance.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20211109065418.21693-1-songmuchun@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/9/21 07:54, Muchun Song wrote:
> The commit 494c1dfe855e ("mm: memcg/slab: create a new set of kmalloc-cg-<n>
> caches") makes cgroup_memory_nokmem global, however, it is unnecessary
> because there is already a function mem_cgroup_kmem_disabled() which
> exports it.
> 
> Just make it static and replace it with mem_cgroup_kmem_disabled()
> in mm/slab_common.c.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/internal.h    | 5 -----
>  mm/memcontrol.c  | 2 +-
>  mm/slab_common.c | 2 +-
>  3 files changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/internal.h b/mm/internal.h
> index 18256e32a14c..ad15251d7a3c 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -137,11 +137,6 @@ extern void putback_lru_page(struct page *page);
>  extern pmd_t *mm_find_pmd(struct mm_struct *mm, unsigned long address);
>  
>  /*
> - * in mm/memcontrol.c:
> - */
> -extern bool cgroup_memory_nokmem;
> -
> -/*
>   * in mm/page_alloc.c
>   */
>  
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 8f1d9c028897..89fc3ca65b2d 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -84,7 +84,7 @@ EXPORT_PER_CPU_SYMBOL_GPL(int_active_memcg);
>  static bool cgroup_memory_nosocket __ro_after_init;
>  
>  /* Kernel memory accounting disabled? */
> -bool cgroup_memory_nokmem __ro_after_init;
> +static bool cgroup_memory_nokmem __ro_after_init;
>  
>  /* Whether the swap controller is active */
>  #ifdef CONFIG_MEMCG_SWAP
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index e5d080a93009..d05203a11201 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -849,7 +849,7 @@ new_kmalloc_cache(int idx, enum kmalloc_cache_type type, slab_flags_t flags)
>  	if (type == KMALLOC_RECLAIM) {
>  		flags |= SLAB_RECLAIM_ACCOUNT;
>  	} else if (IS_ENABLED(CONFIG_MEMCG_KMEM) && (type == KMALLOC_CGROUP)) {
> -		if (cgroup_memory_nokmem) {
> +		if (mem_cgroup_kmem_disabled()) {
>  			kmalloc_caches[type][idx] = kmalloc_caches[KMALLOC_NORMAL][idx];
>  			return;
>  		}
> 

