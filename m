Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 664A13D9092
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 16:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237192AbhG1O1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 10:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236837AbhG1O0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 10:26:55 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9FBEC0617A2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 07:26:32 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id a7so3278078ljq.11
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 07:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5wW7GGfnHW+FbXjPW0YXEzsBymKiCMQ5XbTjvh/KboQ=;
        b=lauEEuiRYW1T8KlRcC7+C3wNCVNPsohJ7h2lpG0RrO/VvQ9Z1WVCAu777ngIlXaqsl
         Yh7tG9FxqeSO7oXmknKzZNOZD7eXVmt6nhKs/+vzagJhZPoe9STykeXLRj9yY5JXM4CO
         +Hd78QFe1WvCxy8vxXdrz8XOOtKmdZYinT4/RuGtDMSYORrhhEgi0ex85rtQ9BBEdkDK
         sXJNyV9g+f86FYTZaT7aQanIsIDpcV7AA6ara+QbpgkDKfCV39N6bnquJzUtgnqZ6XKO
         HMKzbHyGoVNIzYkQfE4hJS/ZSwhIwGkqqWILdxIGo4ByD1LF40gUZ4qiZ2Uoq+eJ1xdb
         VxnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5wW7GGfnHW+FbXjPW0YXEzsBymKiCMQ5XbTjvh/KboQ=;
        b=qgVYlpDfXDfBN4pHfbdrlQ1jGH80FkjqRd1V9h6MHmRw4fdUgisU49xDRD27wGjPdi
         i6CnYlmMwgys7VpKcbP+B2SIv0DqO28Y1D70cSUKzwXkpNomgfP/ctj0mgO7k/hTo1Ib
         JrXa0WsYKMxoiA6UNcVQbV9QJ6Wkcsm2l5BnIbDanRFBQwu5+V2XBhrS2j5aL49YCFT0
         kplQNVu1Dh3kQIOsO/5bAcwfxl+CTZSlz9iANwsYGd5WhkS1MAyhuNEDnHAwh47yhFB9
         8GRl1i9TJtn9oQicid9/T0M12CN5O+FQR6o3POqMM/gfB353Ek8Hr0XSOySc8dAiVF4+
         hG1g==
X-Gm-Message-State: AOAM532QbUuwj2DcBezwypTqD6HLSuXFWPFkWhVfoSiBxcwJVNUGBBUW
        o2G7jVitymGl8HqFa29pmwK6AWYR0R7ZgSdi6+KwNQ==
X-Google-Smtp-Source: ABdhPJzOM17jqW7FCFdGqhUip/b+GcfgAIxToJpxbmMfaRL0XlMbu+nlvXxP3Dtu8D+2E+e3tW8wWZDZLJY4GiAk8n0=
X-Received: by 2002:a05:651c:1213:: with SMTP id i19mr85583lja.81.1627482390698;
 Wed, 28 Jul 2021 07:26:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210728091348.272714-1-wanghai38@huawei.com> <YQFaPwYzzy0UPzNI@dhcp22.suse.cz>
 <e9ad7775-2df2-fdb3-cfa9-6c1c265142f5@huawei.com>
In-Reply-To: <e9ad7775-2df2-fdb3-cfa9-6c1c265142f5@huawei.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 28 Jul 2021 07:26:19 -0700
Message-ID: <CALvZod7a36w7Hht4yrozTMx4gdNxZ7mzi+MeaD-yuv69rxYY7Q@mail.gmail.com>
Subject: Re: [PATCH] mm/memcg: fix NULL pointer dereference in memcg_slab_free_hook()
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Michal Hocko <mhocko@suse.com>, Wang Hai <wanghai38@huawei.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2021 at 7:21 AM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>
>
> On 2021/7/28 21:23, Michal Hocko wrote:
> > On Wed 28-07-21 17:13:48, Wang Hai wrote:
> >> When I use kfree_rcu() to free a large memory allocated by
> >> kmalloc_node(), the following dump occurs.
> >>
> >> BUG: kernel NULL pointer dereference, address: 0000000000000020
> >> [...]
> >> Oops: 0000 [#1] SMP
> >> [...]
> >> Workqueue: events kfree_rcu_work
> >> RIP: 0010:__obj_to_index include/linux/slub_def.h:182 [inline]
> >> RIP: 0010:obj_to_index include/linux/slub_def.h:191 [inline]
> >> RIP: 0010:memcg_slab_free_hook+0x120/0x260 mm/slab.h:363
> >> [...]
> >> Call Trace:
> >>   kmem_cache_free_bulk+0x58/0x630 mm/slub.c:3293
> >>   kfree_bulk include/linux/slab.h:413 [inline]
> >>   kfree_rcu_work+0x1ab/0x200 kernel/rcu/tree.c:3300
> >>   process_one_work+0x207/0x530 kernel/workqueue.c:2276
> >>   worker_thread+0x320/0x610 kernel/workqueue.c:2422
> >>   kthread+0x13d/0x160 kernel/kthread.c:313
> >>   ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
> >>
> >> When kmalloc_node() a large memory, page is allocated, not slab,
> >> so when freeing memory via kfree_rcu(), this large memory should not
> >> be used by memcg_slab_free_hook(), because memcg_slab_free_hook() is
> >> is used for slab.
> >>
> >> So in this case, there is no need to do anything with this large
> >> page in memcg_slab_free_hook(), just skip it.
> >>
> >> Fixes: 270c6a71460e ("mm: memcontrol/slab: Use helpers to access slab page's memcg_data")
> > Are you sure that this commit is really breaking the code. Unless I have
> Yes, we confirmed that this commit introduces the bug.
> > missed something there shouldn't be any real change wrt. large
> > allocations here. page_has_obj_cgroups is just a different name for what
> > what page_objcgs is giving us.
>
> maybe we could simply use page_objcgs_check to fix the issue ? we will
> check it again.

You will see the same crash with page_objcgs_check as well.
