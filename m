Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD0C3D9D73
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 08:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234354AbhG2GEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 02:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234093AbhG2GEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 02:04:21 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB639C061757
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 23:04:18 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id q17-20020a17090a2e11b02901757deaf2c8so7846783pjd.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 23:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gqlOu5w7sIF9m7Ex8akMtGucE3AKmn8iiHCycTTM/xE=;
        b=ph5LVGOXWqyvIdu2y1OP4WXRoj1hjrxn2tMBtanm0fgVIqf/Ci5vZR+j5hFfnpT6l6
         7pXTYJQm5/AgQ7wbdxQK9FLkQKfoo5kDHqsNp8v9VYzzNUfrjgsuV3SHqMsInWz1/Ehm
         3brKiO0WsbndMAUkGXTuc3TBBBXR3zDBKfnF8qD8Pr0l/u7bKsUsUeDWNQJymO3GjFEj
         9TKvtt9JJkeLrP3dePxuRwCmQj1rN9dTo1gEMzlQZBRilTrlg9MHO4Sz+wHXIHu6+3H8
         TyKdyH7bxBfhvYUNHU9D0ZwTkBPNOUhzqqq8FDcdYdIwVXLQuIBCqNZOEH2F/8xTvfz4
         JWTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gqlOu5w7sIF9m7Ex8akMtGucE3AKmn8iiHCycTTM/xE=;
        b=nvDsirOIsMP15/pFBQRvhVG6cSPx4TFzwKn7Ek/QGyjT+U4AxtZTNaZBobJZ9YojZl
         fGuFHgLoieIZ4vshFr/0Eb909qhWZy6kob58X+7k6ZBBMTApbHtzEYiEPD1TA344Yo+X
         mFs1jgXbJbYhc56x4gHZ+zzVVF9TjHbOpu5IEZEYBGqFOkV5dEiiP0gnsmxSFFlynUu5
         1ZgIe8KXqZla4XKN9CSnwzKUKp86NTw+dYC7/XnS+a4bgcDeK2xQmqpdZfHlzORNlZci
         ub6Czl6ztvLapsVOyC4Twjn3U5qXTKHNzrh7CqamYaX31MDcdArQmpUxJRw5CmdJyZKO
         g/1Q==
X-Gm-Message-State: AOAM53023proKcYdh6NfB9Jb7gX6tH49onc0G58LUviVyIWV9FeCGOPP
        msry0g6Mh88kwokoD9xjXzw7QBmoGr18H72FKuw7Aw==
X-Google-Smtp-Source: ABdhPJzDYXlUsa81+9TOdegbgF8dMAhSsTVDVOveJdyatsUa0SeIZyLEktiOkLl3eKARlGFPUGBpGpqw1eAxyKQ27MY=
X-Received: by 2002:a17:90a:9b13:: with SMTP id f19mr3547754pjp.229.1627538658277;
 Wed, 28 Jul 2021 23:04:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210728145655.274476-1-wanghai38@huawei.com>
In-Reply-To: <20210728145655.274476-1-wanghai38@huawei.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 29 Jul 2021 14:03:39 +0800
Message-ID: <CAMZfGtUpc4LL0wajz5GDwDD70jrVPCA_p4eFbMvMaC4TuR5e6Q@mail.gmail.com>
Subject: Re: [PATCH v2] mm/memcg: fix NULL pointer dereference in memcg_slab_free_hook()
To:     Wang Hai <wanghai38@huawei.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Roman Gushchin <guro@fb.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2021 at 10:57 PM Wang Hai <wanghai38@huawei.com> wrote:
>
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

More simpler than v1. Thanks.

Reviewed-by: Muchun Song <songmuchun@bytedance.com>
