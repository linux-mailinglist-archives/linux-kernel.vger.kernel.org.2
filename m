Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7C123D901F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 16:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236657AbhG1OKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 10:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235411AbhG1OKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 10:10:42 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1E5C061757
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 07:10:40 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id r17so4256552lfe.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 07:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tzqXN6ljVfKCtav6KN2V4ySvtOzmVHwY4YSZdyei1YM=;
        b=Oo1K10dAv82MrkV06wPn/Fowbs0gd5e4MK+SCHnF6WBc2tJT776SsOjQ9oa51NSN9I
         2HdSBKBQxbU1dQzGLVdk35huure6rKro16w/NbfDjq/X25fl3MbORFd6jxeUcv9OL2v1
         lXRxkNhF8X39IZbcWr+ZHYlJQoLYNWyyNe27ZcIt1+NcuNv853sDZQotIK7VfXVRz4FH
         fMqTm8yb6XFPe5oV9qx0zaxwt/xXCrMWtQcxKr3Eq50UZ+KboD8QgOPUdSaNCK6tbGY9
         7okaH0hHvWs2Ri0r2VhWTlicxpfY2Dl8Cz8umzSmfn4T2jDAs5L0Mcr8wYfozs/qdCFn
         L1YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tzqXN6ljVfKCtav6KN2V4ySvtOzmVHwY4YSZdyei1YM=;
        b=pXM0p3dkHs//y3XN+F3NwlJkeBIX0LFOb/dzm+6l5fo+pwCNkZEP+AEV+iYKVznGYQ
         3PVTdw70O9DT7X+oQ+M2+wSM83T/1c3oSgp60hDeGN6cVg/u37oItfn3nRABpdtgjqLU
         PEhY6m/SSAzeWAiolWovI+955QoHKBJq8s0dXuC6QtJP8RKQPApLVOUyc7OW4+RbF2+j
         E890lFLbS2kBujBotKu7ZS2WBr+n85qGpQCQ5Y6SIOxAY0KXoGYZWCFavhAbJ5JXWV7q
         bYcQLqFPVV7Y5pEPLuzWZVjcOMgJ52KqkVfJKqux3ZXtYlsxKH2tNznnRxVENHNfXG06
         6Hnw==
X-Gm-Message-State: AOAM5338l9Eczg+bHgnIDODUUqrsAMjugX8qtOiXlWNSXf/F1k9sjGgO
        4Up1viohoRL/kFUMq6iZ/uJGyGBDghaa+rBWtQ1Oww==
X-Google-Smtp-Source: ABdhPJzTI7d889Y4BXdkFlMPZMemCacSNNOf3Te13xQ2wTaAeBbx2u61OgGcXH/twHLkbeRYLs0ieAdyK/ZpYgWxumc=
X-Received: by 2002:a19:ae0f:: with SMTP id f15mr20952757lfc.117.1627481438086;
 Wed, 28 Jul 2021 07:10:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210728091348.272714-1-wanghai38@huawei.com> <YQFaPwYzzy0UPzNI@dhcp22.suse.cz>
In-Reply-To: <YQFaPwYzzy0UPzNI@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 28 Jul 2021 07:10:26 -0700
Message-ID: <CALvZod7PzQ8dCpcBr7F1eKCDWCZ+RhHCzHj3pC3QS_CJAYSfDw@mail.gmail.com>
Subject: Re: [PATCH] mm/memcg: fix NULL pointer dereference in memcg_slab_free_hook()
To:     Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>
Cc:     Wang Hai <wanghai38@huawei.com>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Alexei Starovoitov <ast@kernel.org>,
        wangkefeng.wang@huawei.com, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Roman

On Wed, Jul 28, 2021 at 6:23 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Wed 28-07-21 17:13:48, Wang Hai wrote:
> > When I use kfree_rcu() to free a large memory allocated by
> > kmalloc_node(), the following dump occurs.
> >
> > BUG: kernel NULL pointer dereference, address: 0000000000000020
> > [...]
> > Oops: 0000 [#1] SMP
> > [...]
> > Workqueue: events kfree_rcu_work
> > RIP: 0010:__obj_to_index include/linux/slub_def.h:182 [inline]
> > RIP: 0010:obj_to_index include/linux/slub_def.h:191 [inline]
> > RIP: 0010:memcg_slab_free_hook+0x120/0x260 mm/slab.h:363
> > [...]
> > Call Trace:
> >  kmem_cache_free_bulk+0x58/0x630 mm/slub.c:3293
> >  kfree_bulk include/linux/slab.h:413 [inline]
> >  kfree_rcu_work+0x1ab/0x200 kernel/rcu/tree.c:3300
> >  process_one_work+0x207/0x530 kernel/workqueue.c:2276
> >  worker_thread+0x320/0x610 kernel/workqueue.c:2422
> >  kthread+0x13d/0x160 kernel/kthread.c:313
> >  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
> >
> > When kmalloc_node() a large memory, page is allocated, not slab,
> > so when freeing memory via kfree_rcu(), this large memory should not
> > be used by memcg_slab_free_hook(), because memcg_slab_free_hook() is
> > is used for slab.
> >
> > So in this case, there is no need to do anything with this large
> > page in memcg_slab_free_hook(), just skip it.
> >
> > Fixes: 270c6a71460e ("mm: memcontrol/slab: Use helpers to access slab page's memcg_data")
>
> Are you sure that this commit is really breaking the code. Unless I have
> missed something there shouldn't be any real change wrt. large
> allocations here. page_has_obj_cgroups is just a different name for what
> what page_objcgs is giving us.

Actually they are different. For MEMCG_DATA_KMEM page,
page_has_obj_cgroups() will return false while page_objcgs() on
non-VM_DEBUG kernels will return "struct obj_cgroup *" instead of
"struct obj_cgroup **".

>
> I haven't studied the kfree_rcu part but isn't the problem its use of
> kmem_cache_free_bulk or isn't the problem right there in the bulk free?
>

SLUB's kmem_cache_free_bulk() is doing two passes. In first pass
uncharges all the objects and in the second pass frees them to the
slub infra. There is nothing wrong with that. It is just that SLUB
mixes page (for higher order) and slab allocations and requires
special handling.

> > Signed-off-by: Wang Hai <wanghai38@huawei.com>
> > ---
> >  mm/slab.h | 15 ++++++++++-----
> >  1 file changed, 10 insertions(+), 5 deletions(-)
> >
> > diff --git a/mm/slab.h b/mm/slab.h
> > index 67e06637ff2e..247d3f9c21f7 100644
> > --- a/mm/slab.h
> > +++ b/mm/slab.h
> > @@ -339,15 +339,20 @@ static inline void memcg_slab_free_hook(struct kmem_cache *s_orig,
> >                       continue;
> >
> >               page = virt_to_head_page(p[i]);
> > +             if (!s_orig) {
> > +                     if (unlikely(!PageSlab(page))) {
> > +                             BUG_ON(!PageCompound(page));
>
> BUG_ON is not really a good idea here. Why should we crash the kernel
> just because of an unexpected page showing up. Leaking it would be more
> appropriate (the same would apply to kfree btw). I would just warn
> here.

The simplest fix would be to not call memcg_slab_free_hook() in
kmem_cache_free_bulk() because slab_free() will call
memcg_slab_free_hook() for individual objects. Not sure if there will
be any performance impact.

>  Also don't we need any hookd here.  Looking at kfree path it does
> call kfree_hook. Why is that not needed here?

These are called later in build_detached_freelist().
