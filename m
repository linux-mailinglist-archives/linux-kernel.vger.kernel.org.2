Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87F4244BA1C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 02:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbhKJB7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 20:59:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbhKJB7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 20:59:15 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B65C061764
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 17:56:27 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id j21so3949720edt.11
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 17:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+T9S2Ka5uunmjDVQ9GtYEQLB2RlYBS5G+VmuCSvgFlE=;
        b=GphJAXjd57tAonvFra1nrp58exzkrv+MKIoXzrEMOT8tkWV5k4HyN3KAu58jwpZGIp
         xvibb8tGY1g6GwdOJjHHEbO1v4Xi1AdRq9rJ2RzwAUfOvo7+EL7AUcH6t0tzntM/raqg
         M9ZhGSckTRpeInMvt513b8FsSdRbmAEiFQ6X8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+T9S2Ka5uunmjDVQ9GtYEQLB2RlYBS5G+VmuCSvgFlE=;
        b=tZqIafe1ITGIoR519y+e1YMfMpd367yaqLi2WY5Egu8W0hkQ5OCGKVnDvcH4CERV1T
         cwieGNVN7VF22qFtGAqkWgxY7+sNwT95TtKI7eWsWNLlFJ1zh0Vtu18CRLZtCceF29H3
         JhPUVt5Lbrp2xWlE6nLiuVETPIBAzZ0PVXLANL344aXPFT/ZNEGvOPg1KJSNnem7CVQl
         AUiXk9/lFPz6FTWaks3IIA7C8eY0YpDGJck8pTh3Fd4ZV8SvHKgOS56aF6V2z27EJneU
         G5/CkjLaP8Z60g557myB3dEeeOpKRwO0jQvRbf+Zo3fQx9jS9StdTuUXTmxJRIpxe5sR
         1uEw==
X-Gm-Message-State: AOAM530hLag/pbv7roRvh/mPLCshKtTU+MBVd1Zb8vXq1DVj0P2ApFGd
        fei7SqpYiKVs/flxyLoHqxhSMA==
X-Google-Smtp-Source: ABdhPJyOqcvtiiEELAtWZ5QMnXn7x/9DRnGtVUxml/orL/3e+WeBFj8qtDbUAgl2ny3vRnEv/6TRoA==
X-Received: by 2002:a17:907:3e8a:: with SMTP id hs10mr16025138ejc.404.1636509386503;
        Tue, 09 Nov 2021 17:56:26 -0800 (PST)
Received: from localhost ([2620:10d:c093:400::5:f94d])
        by smtp.gmail.com with ESMTPSA id gs17sm5495353ejc.28.2021.11.09.17.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 17:56:26 -0800 (PST)
Date:   Wed, 10 Nov 2021 01:56:25 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: memcontrol: make cgroup_memory_nokmem static
Message-ID: <YYsmyXtOHs33E1DV@chrisdown.name>
References: <20211109065418.21693-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20211109065418.21693-1-songmuchun@bytedance.com>
User-Agent: Mutt/2.1.3 (987dde4c) (2021-09-10)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Muchun Song writes:
>The commit 494c1dfe855e ("mm: memcg/slab: create a new set of kmalloc-cg-<n>
>caches") makes cgroup_memory_nokmem global, however, it is unnecessary
>because there is already a function mem_cgroup_kmem_disabled() which
>exports it.
>
>Just make it static and replace it with mem_cgroup_kmem_disabled()
>in mm/slab_common.c.
>
>Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Seems reasonable, thanks.

Acked-by: Chris Down <chris@chrisdown.name>

>---
> mm/internal.h    | 5 -----
> mm/memcontrol.c  | 2 +-
> mm/slab_common.c | 2 +-
> 3 files changed, 2 insertions(+), 7 deletions(-)
>
>diff --git a/mm/internal.h b/mm/internal.h
>index 18256e32a14c..ad15251d7a3c 100644
>--- a/mm/internal.h
>+++ b/mm/internal.h
>@@ -137,11 +137,6 @@ extern void putback_lru_page(struct page *page);
> extern pmd_t *mm_find_pmd(struct mm_struct *mm, unsigned long address);
>
> /*
>- * in mm/memcontrol.c:
>- */
>-extern bool cgroup_memory_nokmem;
>-
>-/*
>  * in mm/page_alloc.c
>  */
>
>diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>index 8f1d9c028897..89fc3ca65b2d 100644
>--- a/mm/memcontrol.c
>+++ b/mm/memcontrol.c
>@@ -84,7 +84,7 @@ EXPORT_PER_CPU_SYMBOL_GPL(int_active_memcg);
> static bool cgroup_memory_nosocket __ro_after_init;
>
> /* Kernel memory accounting disabled? */
>-bool cgroup_memory_nokmem __ro_after_init;
>+static bool cgroup_memory_nokmem __ro_after_init;
>
> /* Whether the swap controller is active */
> #ifdef CONFIG_MEMCG_SWAP
>diff --git a/mm/slab_common.c b/mm/slab_common.c
>index e5d080a93009..d05203a11201 100644
>--- a/mm/slab_common.c
>+++ b/mm/slab_common.c
>@@ -849,7 +849,7 @@ new_kmalloc_cache(int idx, enum kmalloc_cache_type type, slab_flags_t flags)
> 	if (type == KMALLOC_RECLAIM) {
> 		flags |= SLAB_RECLAIM_ACCOUNT;
> 	} else if (IS_ENABLED(CONFIG_MEMCG_KMEM) && (type == KMALLOC_CGROUP)) {
>-		if (cgroup_memory_nokmem) {
>+		if (mem_cgroup_kmem_disabled()) {
> 			kmalloc_caches[type][idx] = kmalloc_caches[KMALLOC_NORMAL][idx];
> 			return;
> 		}
>-- 
>2.11.0
>
>
